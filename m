Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4DDF2D8617
	for <lists+linux-pm@lfdr.de>; Sat, 12 Dec 2020 11:58:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438847AbgLLK6A (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 12 Dec 2020 05:58:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726374AbgLLK6A (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 12 Dec 2020 05:58:00 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AFCAC0613CF
        for <linux-pm@vger.kernel.org>; Sat, 12 Dec 2020 02:57:20 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id 23so17962330lfg.10
        for <linux-pm@vger.kernel.org>; Sat, 12 Dec 2020 02:57:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+xA7rCVNS/7h2O4jFsTgoSyQIUMJYQQ5V/vkRCnYTJ8=;
        b=IukAXvv4NySSWMScSQideCmcmL5QbtTFqxpPQ4sHw7FBXn24FwjsZn3ooOpzliF5JU
         McKVR3mGVLCoCMKjg7LMEjyyl7Hjoi1j9tMaktQMPedXewC9xUsFS9SbZDwnglDAlzv+
         wUcZD9KkRa9F6bflVDGVPpud5ovseejM/5v/tyMNMWnKTuPBz/06LKQtBOFuI57cssJb
         ICO2dmDEOGgpyDjJiUxacQ+ySIVtj+eVkXstkjIoq5j/CBTo7+bpbp7op35lLqVB9TYT
         Y6LoDWbpPaKIExLaQNuSdkLVc7fFGFhVfJdPpSoqCq81xxcLwOxMJEZAqzzYWoiBo/A6
         ZUaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+xA7rCVNS/7h2O4jFsTgoSyQIUMJYQQ5V/vkRCnYTJ8=;
        b=gSKm4MJZ50spHJL+DzNTM5rk0BKagnhHQTw7Gi/VG9+TYxZJuP79PRVJ2EmmyM0yY6
         ajlvSRqJ5HbpcYLRti4xWbaDNR4XzRbNRdWqj8WbIJCdYpWp/coaJeDOVYIrrqpOQW6Y
         pPg1m5coeRkEikSRPnOy3WpcixGEEgWxtjEOkhg561+Kc4mNEFc4aklQTPN/n24w0gNf
         TweXBRCmINS0S96bEgvpb1elMHfMvVIJUoIWrkHw5ZGRf8vxRQ+Pe7PWm2FpZUoF+Nmj
         nQrKLMgwZUA1JIJ5AgWQ4Z5liS8NR8Snv213/toWoINjG1avBoNUhIwc3FOe5mbfApdS
         uTpw==
X-Gm-Message-State: AOAM532fRJHhq0FfZIU4ul5VIQL2AKKfYglS63ytRij1JhIJSI+Etqt+
        zswLOAS2bMAmMkjVsskBcFcWZ9lYqofouFvh
X-Google-Smtp-Source: ABdhPJwjv9KpxJGdbenzf5xsInjKegEtyiP6zonW6WTPv/Z+Qr9JoS4nKvF/I+3ehxXkiQdhw4gTKQ==
X-Received: by 2002:a2e:bc26:: with SMTP id b38mr7264352ljf.161.1607770638531;
        Sat, 12 Dec 2020 02:57:18 -0800 (PST)
Received: from localhost.bredbandsbolaget (c-92d7225c.014-348-6c756e10.bbcust.telenor.se. [92.34.215.146])
        by smtp.gmail.com with ESMTPSA id j2sm490674lfe.213.2020.12.12.02.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Dec 2020 02:57:17 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Marcus Cooper <codekipper@gmail.com>
Cc:     linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 0/5] power: supply: ab8500 charger cleanup
Date:   Sat, 12 Dec 2020 11:57:07 +0100
Message-Id: <20201212105712.2727842-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch set is a first set of cleanups for the AB8500
charging code, I'm trying to bring this to a working
state. The code has seen some bitrot since it was merged
a few years back.

Notably it makes the code probe properly when enabled.

Linus Walleij (5):
  power: supply: ab8500: Use local helper
  power: supply: ab8500: Convert to dev_pm_ops
  power: supply: ab8500_charger: Oneshot threaded IRQs
  power: supply: ab8500_fg: Request all IRQs as threaded
  power: supply: ab8500: Use dev_err_probe() for IIO channels

 drivers/power/supply/ab8500_btemp.c    |  66 +++++++--------
 drivers/power/supply/ab8500_charger.c  |  99 ++++++++++-------------
 drivers/power/supply/ab8500_fg.c       | 106 +++++++++----------------
 drivers/power/supply/abx500_chargalg.c |  19 ++---
 4 files changed, 116 insertions(+), 174 deletions(-)

-- 
2.26.2

