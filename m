Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D644024D6CD
	for <lists+linux-pm@lfdr.de>; Fri, 21 Aug 2020 16:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728633AbgHUOAm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 21 Aug 2020 10:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728236AbgHUOAk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Aug 2020 10:00:40 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C72E7C061573;
        Fri, 21 Aug 2020 07:00:39 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id b2so1506400edw.5;
        Fri, 21 Aug 2020 07:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nt1Kd98grCASJIUWWiWXpg+ScuiPaXDgXJdNYD47wWE=;
        b=tp9Nu4RNWrkklFOwMk18vBYIyTEHFyTZEyVFlr8zKr/VPtCIVHGqOIxlE7hs9ei1Js
         buboWgyI8TVqd5OrwLyLlaPmkqgnpDIfI/yG2QQ/LpA+0jA2CYES4U31Ly1VQiKNQVkS
         73vgs8cM2w46WdvrfuzVk4HRakgQaVYoTj5uXeLTP04r8663O/Am5OD5f75kgd8jM/pe
         ImUwNdA9mRH8HjrXydueV9ox3/bSgyTLnY7VjYLxAFiTdN6R4GxV1HQBP8HHO1/mr2Eg
         2EGhDDNldjLY+l1nG+3NLRnnKhcXYn8A1ABZA0WchTRe0nXn0wCFYndqX+rOSop/ke7T
         D3+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nt1Kd98grCASJIUWWiWXpg+ScuiPaXDgXJdNYD47wWE=;
        b=YxcyjeWOwU2iROiTZ+z5yhfZme6/kOrdBho4lFeD13dWg3g+Y8I3RHu3eux0AuzZEW
         G5mvyAUTV+1wqRlgAjikwsjXE4sUKNFWStO1iburg7LPFaux6UUfn49ASCsWI0Ni6TmK
         ZMYZZpokkIO325uBYfEUTCZN73DG6+1tJMKpn/yjijwBibj3s3B0J7Aeue8CAa2aKsqg
         smLoXgEZdNLivian6qZushqNyviaHeILAC1x8O5rInNVaIGXJ/6Gc/Zf+hc+GO9Bzmf4
         tc33su452GrV+0z0osuKZpnZxs/z23VO5anXb/GP8YB/TVL9y2l7lZlrBSCmsMlgtgv0
         748A==
X-Gm-Message-State: AOAM531m3Rsif6XRwcKULt/bsU/AlG7wKN2pjkBIZPmmhcApogAgATEu
        kTxxjFntjMWgwVcgWLLt3F0=
X-Google-Smtp-Source: ABdhPJwXWlhQMaNkBZ5lWOMS4F3g51moSS6ZPdFXV4Y2pPsLgA6kKM9kus4ugPjIzamA0wGCA/1Dzg==
X-Received: by 2002:a05:6402:17cc:: with SMTP id s12mr1005802edy.293.1598018437105;
        Fri, 21 Aug 2020 07:00:37 -0700 (PDT)
Received: from Ansuel-XPS.localdomain (host-87-10-16-66.retail.telecomitalia.it. [87.10.16.66])
        by smtp.googlemail.com with ESMTPSA id c7sm1152969edf.1.2020.08.21.07.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 07:00:36 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v3 0/2] Add Krait Cache Scaling support
Date:   Fri, 21 Aug 2020 16:00:19 +0200
Message-Id: <20200821140026.19643-1-ansuelsmth@gmail.com>
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

v3:
* Use opp infrastructure
* Update documentation

v2:
* Fix Documentation error reported by bot
* Rework code to fail probe on missing required params
* Optimize notifier callback to reduce CPU cycle

Ansuel Smith (2):
  cpufreq: qcom: Add Krait Cache Scaling support
  dt-bindings: cpufreq: Document Krait CPU Cache scaling

 .../bindings/cpufreq/krait-cache-scale.yaml   |  79 ++++++
 drivers/cpufreq/Kconfig.arm                   |   9 +
 drivers/cpufreq/Makefile                      |   1 +
 drivers/cpufreq/krait-cache.c                 | 232 ++++++++++++++++++
 4 files changed, 321 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/cpufreq/krait-cache-scale.yaml
 create mode 100644 drivers/cpufreq/krait-cache.c

-- 
2.27.0

