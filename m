Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A302610F6F8
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2019 06:23:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725907AbfLCFXh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Dec 2019 00:23:37 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38697 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbfLCFXh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Dec 2019 00:23:37 -0500
Received: by mail-pg1-f193.google.com with SMTP id t3so1120433pgl.5
        for <linux-pm@vger.kernel.org>; Mon, 02 Dec 2019 21:23:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=N6/Vfj+VnloKWDrO0keM08fpBsJsdBma6GiUwIrec4g=;
        b=IaOrcClVOiytYPvZ/GyCl7kuuxS2MieZf3/zjMPjFrj1hz4nMh0GOUF3ReKo5ZnWXf
         sPqyz5YDiyjHrw3XjxPMjk/o/XFjBsvHNSB/+lzcKq3tm8wl6TA/lG0zXQkUgQ0xYrla
         ZdBYtFqJNDJYrLis5h4xdxE1egpYECrCh139U07hObomwBHkq0DSETdfgomv90oUAE5A
         mSXh7q0x568TE1zri8FftVKmhxCnyoHwGFI+K6+WR0fmhxvjEOSdUiPm3U4KGcNPuk4J
         /M+2yK+X1ATkKfbLKQsnmnWS5zuAmak7jSoX/81fPeooerKiexIomdAsxJG3OSY4J3tR
         t+AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=N6/Vfj+VnloKWDrO0keM08fpBsJsdBma6GiUwIrec4g=;
        b=CVEqCKTIi9hP3of/LJPRjwf05mocVjZThmQ9yq1GD551JgNdYHOXicPOB++ws1kOiG
         wydFrIQzUNXN31q7rSNmPtCD+qpF8U44+ERgAVKYeVTIgn2Lq6kE5NDnZJJbywsk8Ysu
         swvLiTZ5XBkqNdvGbuqDjYcERSYtSBWNITUDzRuF5dqT8Jb4YMySAwv5ExwPx93MB0JU
         O57RPlmKbdv+QlBo/tsXMLSzU9nsJOrn6C7xy9L9/f54pP055wqKE3W5ZnfeE07ez9h9
         uDAdCMQ1/3kIanW1EgxSjlTXWOgegQacgtdYf/Li5pMAdrV3goip2K1pXmpqZx65t04/
         6e5A==
X-Gm-Message-State: APjAAAVsz6izCLYoouRCS9/FjjffHG2NE+wk1zr1W/h0pajtm1hg+8Cv
        zIGu/W81AHLR7gRlVGYM10YHFw==
X-Google-Smtp-Source: APXvYqzBmqmcs7hfpJvWbz3BETEGz2dOxflDfBhKP1dipSrFLRru5zt4EJ3eXlRAVFM7scft8Nk94A==
X-Received: by 2002:a63:1a22:: with SMTP id a34mr3250138pga.403.1575350616626;
        Mon, 02 Dec 2019 21:23:36 -0800 (PST)
Received: from localhost ([14.96.109.134])
        by smtp.gmail.com with ESMTPSA id d23sm1379850pfo.176.2019.12.02.21.23.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Dec 2019 21:23:35 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, swboyd@chromium.org,
        sivaa@codeaurora.org, Andy Gross <agross@kernel.org>
Cc:     Amit Kucheria <amit.kucheria@verdurent.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH v2 0/9] thermal: tsens: Handle critical interrupts
Date:   Tue,  3 Dec 2019 10:53:21 +0530
Message-Id: <cover.1575349416.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

TSENS IP v2.x supports critical interrupts and v2.3+ adds watchdog support
in case the FSM is stuck. Enable support in the driver.

This series was generated on top of linux-next from 20191202 to capture
const changes for msm8976 that is queued currently.

Changes from v1:
- Make tsens_features non-const to allow run time detection of features
- Pass tsens_sensor around as a const
- Fix a bug to release dev pointer in success path
- Address review comments from Bjorn and Stephen (thanks for the review)
- Add msm8998 and msm8996 DTSI changes for critical interrupts

Amit Kucheria (9):
  drivers: thermal: tsens: De-constify struct tsens_features
  drivers: thermal: tsens: Pass around struct tsens_sensor as a constant
  drivers: thermal: tsens: use simpler variables
  drivers: thermal: tsens: Release device in success path
  drivers: thermal: tsens: Add critical interrupt support
  drivers: thermal: tsens: Add watchdog support
  arm64: dts: sdm845: thermal: Add critical interrupt support
  arm64: dts: msm8996: thermal: Add critical interrupt support
  arm64: dts: msm8998: thermal: Add critical interrupt support

 arch/arm64/boot/dts/qcom/msm8996.dtsi |  10 +-
 arch/arm64/boot/dts/qcom/msm8998.dtsi |  10 +-
 arch/arm64/boot/dts/qcom/sdm845.dtsi  |  10 +-
 drivers/thermal/qcom/tsens-8960.c     |   4 +-
 drivers/thermal/qcom/tsens-common.c   | 188 +++++++++++++++++++++++---
 drivers/thermal/qcom/tsens-v0_1.c     |   6 +-
 drivers/thermal/qcom/tsens-v1.c       |   6 +-
 drivers/thermal/qcom/tsens-v2.c       |  24 +++-
 drivers/thermal/qcom/tsens.c          |  26 +++-
 drivers/thermal/qcom/tsens.h          | 104 ++++++++++++--
 10 files changed, 332 insertions(+), 56 deletions(-)

-- 
2.17.1

