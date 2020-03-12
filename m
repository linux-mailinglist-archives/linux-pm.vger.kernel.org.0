Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03B5D183055
	for <lists+linux-pm@lfdr.de>; Thu, 12 Mar 2020 13:37:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbgCLMhN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Mar 2020 08:37:13 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43641 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbgCLMhN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Mar 2020 08:37:13 -0400
Received: by mail-pf1-f194.google.com with SMTP id c144so3205360pfb.10
        for <linux-pm@vger.kernel.org>; Thu, 12 Mar 2020 05:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uZ0iOz8ncqvFjrnK1A4ouijdtb45+U/Wi2K2oQYzs7I=;
        b=q/77FA6Rns8gSsVDrJvnl8koR+lFLGllUQ+FWcEQxyVYjNQKrxI/H6Zi3JxwuWtQWg
         GTP1/3p8VO3/tJlsZr9dF5erZxP8CI07wRGWFQnuliwMY1wHuK0S6dvF8/6Uzy+wq1CI
         4rfwKB43cRoXb+/ItmVqr4OnDIpySUdL8tHm+2ADZYGCHP/CWV71F1x+WY8ccecchsqb
         G4cXO36UxcsNxa618pkf6spHe8uatumWPml7lvCMTxRRpEDY18PNK0YKe6poPB5Vcqcc
         elhxOMZAKIJH9YtvnnWndZ8QY3siuMUntwFTJr79gUbEU3SUcOJf5jbnyaqi6IOesv+5
         kD8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uZ0iOz8ncqvFjrnK1A4ouijdtb45+U/Wi2K2oQYzs7I=;
        b=Q86WRDr+OGjfmyslwiiUq9OeW95bWDQJFoeLUvNfdDzXZXmfvRvjh0a45h3PuAMgMB
         x21stoKWqf9eQ7zUvsmq0v24pdmXa4kkv5gj9xVvn/V4b3cGzwCsfBS3tBHoR8ZTuCuq
         X2+Fszotui4M5tGvJCuqB4bfW/UvO/xn0fet5f7bJTOAq3LrpjGG1KMBvckDCd8areZg
         ocGDjT/jSblCBrTK72Iti5N+f+WfOfvmg71pm0Gy96Lsa+GcJiiUt2xeBweU62D1/+xE
         nUazg3BUmUr2FnARCH18x/eZ0d3pzCkyZ4eGVT9TQ5Ne1sFHwuAgDR6NhoYEaEF1KLDS
         N+dg==
X-Gm-Message-State: ANhLgQ18czDBpaoF3Fl0RLXKxSbsDDcCa+FmsYgxXP7d+byd4xCk/Z30
        gskS7To8y1/BSQM0sktfDRCGbQ==
X-Google-Smtp-Source: ADFU+vu50rvvzGK/AUCH7CKVQ/ZiGwl6wc9WCYo8S5E6zPrpCjXozqsVbTlarBnqpdBeLmc7ZyCzNw==
X-Received: by 2002:a62:a116:: with SMTP id b22mr8164871pff.122.1584016632026;
        Thu, 12 Mar 2020 05:37:12 -0700 (PDT)
Received: from localhost ([45.127.45.7])
        by smtp.gmail.com with ESMTPSA id n5sm2677802pfq.35.2020.03.12.05.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 05:37:10 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        daniel.lezcano@linaro.org, bjorn.andersson@linaro.org,
        swboyd@chromium.org, sivaa@codeaurora.org,
        Andy Gross <agross@kernel.org>
Cc:     Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-pm@vger.kernel.org
Subject: [PATCH v7 0/8] thermal: tsens: Handle critical interrupts
Date:   Thu, 12 Mar 2020 18:06:57 +0530
Message-Id: <cover.1584015867.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

TSENS IP v2.x supports critical interrupts and v2.3+ adds watchdog support
in case the FSM is stuck. Enable support in the driver.

This series was generated on top of v5.6-rc2.

Changes since v6:
 - Fix up some lines over 80 characters
 - Remove Link tags

Changes since v5:¬
 - Introduce a function tsens_register_irq to handle uplow and critical
   interrupt registration and reduce code duplication
 - Clarify reason for patch 04

Changes from v4:
- Add back patch 1 from v3[*], I mistakenly didn't post it for v4.
- Remove spinlock from critical interrupt handling
- Change critical interrupt handler to fall thru watchdog bark handling to
  handle critical interrupts too

[*] https://lore.kernel.org/linux-arm-msm/77dd80eb58f0db29a03097cb442d606f810a849a.1577976221.git.amit.kucheria@linaro.org/

Changes from v3:
- Remove the DTS changes that are already queued
- Fix review comments by Bjorn
- Fixup patch description to clarify that we don't use TSENS critical
  interrupts in Linux, but need it for the watchdog support that uses the
  same HW irq line.
- Separate kernel-doc fixes into a separate patch.

Changes from v2:
- Handle old DTBs w/o critical irq in the same way as fix sent for 5.5

Changes from v1:
- Make tsens_features non-const to allow run time detection of features
- Pass tsens_sensor around as a const
- Fix a bug to release dev pointer in success path
- Address review comments from Bjorn and Stephen (thanks for the review)
- Add msm8998 and msm8996 DTSI changes for critical interrupts


Amit Kucheria (8):
  drivers: thermal: tsens: De-constify struct tsens_features
  drivers: thermal: tsens: Pass around struct tsens_sensor as a constant
  drivers: thermal: tsens: use simpler variables
  drivers: thermal: tsens: Release device in success path
  drivers: thermal: tsens: Add critical interrupt support
  drivers: thermal: tsens: Add watchdog support
  drivers: thermal: tsens: kernel-doc fixup
  drivers: thermal: tsens: Remove unnecessary irq flag

 drivers/thermal/qcom/tsens-8960.c   |   4 +-
 drivers/thermal/qcom/tsens-common.c | 194 ++++++++++++++++++++++++----
 drivers/thermal/qcom/tsens-v0_1.c   |   6 +-
 drivers/thermal/qcom/tsens-v1.c     |   6 +-
 drivers/thermal/qcom/tsens-v2.c     |  24 +++-
 drivers/thermal/qcom/tsens.c        |  65 ++++++----
 drivers/thermal/qcom/tsens.h        | 103 +++++++++++++--
 7 files changed, 331 insertions(+), 71 deletions(-)

-- 
2.20.1

