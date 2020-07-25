Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE3ED22D92D
	for <lists+linux-pm@lfdr.de>; Sat, 25 Jul 2020 20:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727933AbgGYSO0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 25 Jul 2020 14:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbgGYSOZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 25 Jul 2020 14:14:25 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B3BC08C5C0;
        Sat, 25 Jul 2020 11:14:24 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id gg18so9732029ejb.6;
        Sat, 25 Jul 2020 11:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WiwnYihBtixDJzDpzWlD4k6I3xmTQHOsKsy9q7yUDY4=;
        b=gOXyDauPjCBBEN92duKWIXnR1RNC3Ip8+jtR47XfISeB26t1GWY0X6lg5SHy8TPEjW
         Xl8GpmHilFoA7woS6N5TDdNSYO2ANDRX0vJDugf8NujUr933hJ0d/UaYy4nlZnA6D80L
         ej2tacQOtXCdp01xUG8waVAdmiGmwEVYKdNLz2TP/5jLMoOjtvVsVaEjeOURfKDFD6J/
         ZsxAlKgb1X+9dbKDD9qaBBJnbiFdahMmQTsmpF3LpPGvxWcSmaTCcUc+SIkn1xy9vvvF
         d2EwkybxeoZYtYCMK5yHrSxNyXw54WxdbiU+Gdo0N4z3GAoigmTGklWoo2uGs7fqC2ui
         g+tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WiwnYihBtixDJzDpzWlD4k6I3xmTQHOsKsy9q7yUDY4=;
        b=TjQSstOIbEAMvvnL1bUr/PAZnqU5l8AYh9RO+O4cxtCb47FfNsXmBxkMmLpLjpbphN
         e+tPvS+r2kadmcjzOilZI/fFWhHwPzDmz3DKRGR+AwUnPJOQ/8jD8WEizShy9mwDlTyo
         LjNldnwLbLv93ITZCwH2VQ7O5pPW3WHs1qHdC5uLF7cf+G+nL6anOUcFqgUb+c6cLzos
         CJpqw/Zv7MkJYySkv1KsvnD1SFTp0ULlvQ78wKKldqKsQrCX2K4xL/Ig2fYOaTbyijWd
         DgoFwrH5TRrc+JaeYFLpRFFarI1N7NAQOq4jJ6PQpdqNq6bWCy0S/1S9RL/NCM6VSxVy
         sgOg==
X-Gm-Message-State: AOAM533rkZLJoDAedSzqAeILPcrykwPaQsgajdvm6raup62ADUdfZK5P
        XOnY0yAOdT9cEaTyIsSVSQQPoGA6334=
X-Google-Smtp-Source: ABdhPJypVwaMtyAB2CYK/4ceL7rXI6q8zQ7u3cYnaITT90LoOeNxa0zgLHOowZ0j8RNSjSmKJ7f6Gw==
X-Received: by 2002:a17:906:2b54:: with SMTP id b20mr14291952ejg.366.1595700862147;
        Sat, 25 Jul 2020 11:14:22 -0700 (PDT)
Received: from Ansuel-XPS.localdomain (host-79-22-5-125.retail.telecomitalia.it. [79.22.5.125])
        by smtp.googlemail.com with ESMTPSA id qn10sm220922ejb.39.2020.07.25.11.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2020 11:14:21 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v5 0/7] Add support for ipq8064 tsens
Date:   Sat, 25 Jul 2020 20:13:56 +0200
Message-Id: <20200725181404.18951-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patchset convert msm8960 to reg_filed, use int_common instead 
of a custom function and fix wrong tsens get_temp function for msm8960.
Ipq8064 SoCs tsens driver is based on 8960 tsens driver. Ipq8064 needs
to be registered as a gcc child as the tsens regs on this platform are
shared with the controller.
This is based on work and code here
https://git.linaro.org/people/amit.kucheria/kernel.git/log/?h=wrk3/tsens-8960-breakage

v5:
* Conver driver to use reg_fiedl
* Use init_common 
* Drop custom set_trip and set_interrupt
* Use common set_trip and set_interrupt
* Fix bad get_temp function
* Add missing hardcoded slope
v4:
* Fix compilation error and warning reported by the bot
v3:
* Change driver to register as child instead of use phandle
v2:
* Fix dt-bindings problems

Ansuel Smith (7):
  drivers: thermal: tsens: Add VER_0 tsens version
  drivers: thermal: tsens: Convert msm8960 to reg_field
  drivers: thermal: tsens: Use init_common for msm8960
  drivers: thermal: tsens: Fix wrong get_temp for msm8960
  drivers: thermal: tsens: Change calib_backup name for msm8960
  drivers: thermal: tsens: Add support for ipq8064-tsens
  dt-bindings: thermal: tsens: Document ipq8064 bindings

 .../bindings/thermal/qcom-tsens.yaml          |  50 ++++-
 drivers/thermal/qcom/tsens-8960.c             | 172 +++++++++++-------
 drivers/thermal/qcom/tsens.c                  | 156 +++++++++++++---
 drivers/thermal/qcom/tsens.h                  |   7 +-
 4 files changed, 284 insertions(+), 101 deletions(-)

-- 
2.27.0

