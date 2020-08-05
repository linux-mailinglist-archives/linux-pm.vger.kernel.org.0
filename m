Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3FC523D0DB
	for <lists+linux-pm@lfdr.de>; Wed,  5 Aug 2020 21:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbgHETxv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 5 Aug 2020 15:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728126AbgHEQti (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 5 Aug 2020 12:49:38 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 761C3C034627;
        Wed,  5 Aug 2020 06:12:12 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id t14so6292490wmi.3;
        Wed, 05 Aug 2020 06:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1LBSH0Qp7OdqOykHihp8McEns6emellCq7Qms+IaztA=;
        b=T+1BrMXuyg94RoIGuTGarf+yeGBv1EEbuVYYOXq5Mv5xiv8lNgKjH0YkXF2MVsJWKq
         /z+6lT2zNMYutZsClUGKF6h9hXBq/uP61glPXt37g73wh+PawQ1lBVVK375d0gKYLElz
         SD2+3Jm4c77MZSykEicXEHLBwROqVvOVFjISBgxIlSbKLH3EhKUHBqVWnYpccq0EO0QP
         /LBrWg1YaCUZDOk8zYb8LpuFvJPWygplc92qK6z+8vWEgHXCRLdcPx6ue7LDGR2FORRI
         8JNHoUSrG5CNvlnejOvRn09G5LhAA1Z+9ACyxsPwzlTSBx07A9RMtecUCSUhk6eguKYJ
         JN5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1LBSH0Qp7OdqOykHihp8McEns6emellCq7Qms+IaztA=;
        b=SBoUy+8gLy8BhNvJ9jlMEMTUp5Ig/X9WsMs/id1LjZiRYDMSwApIs43187m1Q0sBB/
         NNcWAqzM6bK4l2bimM1o247+7yWGqylKO8Fc+KYcN7oj2rDpNoKngBFlcLgX6Q95m6sq
         aLERDU52tTF753fWKeIbPerxyl4b6qT3BiwkUjgRy5PZri64Va7WSeh/KW1FyX/ybhpf
         D4vrKT/8Z1tkHe+4gV5DdPG+VAhQVyyZKi2aZUfK5fNoiab14k0WDBEf76zjU6B1h1Yf
         65VV3ilZB3eeefBd7awehdJoubkjjDD33mM8g11eImQhb5MbXKM4NHq/Mbhr1Kqewzni
         nhkg==
X-Gm-Message-State: AOAM532vnA6vCb0KVBuSb5chC+tQOOffsPQmqfryx7zKzJC/arun3nhN
        JBumP3oTgXOboqmRnysYhpE=
X-Google-Smtp-Source: ABdhPJykBR7uzZb3Dej6c6Z34uL1k7WalWdY5gPMklhDiyAvSujz7vZKbll8sGfEVkzVUC3OZgedzA==
X-Received: by 2002:a1c:2702:: with SMTP id n2mr3189391wmn.123.1596633130994;
        Wed, 05 Aug 2020 06:12:10 -0700 (PDT)
Received: from Ansuel-XPS.localdomain (host-95-251-1-48.retail.telecomitalia.it. [95.251.1.48])
        by smtp.googlemail.com with ESMTPSA id j11sm2669756wrq.69.2020.08.05.06.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 06:12:10 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/2] Add Krait Cache Scaling support
Date:   Wed,  5 Aug 2020 15:11:57 +0200
Message-Id: <20200805131200.3234-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This adds Krait Cache scaling support using the cpufreq notifier.
I have some doubt about where this should be actually placed (clk or cpufreq)?
Also the original idea was to create a dedicated cpufreq driver (like it's done in
the codeaurora qcom repo) by copying the cpufreq-dt driver and adding the cache
scaling logic but i still don't know what is better. Have a very similar driver or
add a dedicated driver only for the cache using the cpufreq notifier and do the
scale on every freq transition.
Thanks to everyone who will review or answer these questions.

Ansuel Smith (2):
  cpufreq: qcom: Add Krait Cache Scaling support
  dt-bindings: cpufreq: Document Krait CPU Cache scaling

 .../bindings/cpufreq/krait-cache-scale.yaml   |  89 ++++++++
 drivers/cpufreq/Kconfig.arm                   |   9 +
 drivers/cpufreq/Makefile                      |   1 +
 drivers/cpufreq/krait-cache.c                 | 216 ++++++++++++++++++
 4 files changed, 315 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/cpufreq/krait-cache-scale.yaml
 create mode 100644 drivers/cpufreq/krait-cache.c

-- 
2.27.0

