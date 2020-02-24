Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3EAA816A694
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2020 13:59:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbgBXM7H (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Feb 2020 07:59:07 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:51412 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbgBXM7G (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Feb 2020 07:59:06 -0500
Received: by mail-pj1-f66.google.com with SMTP id fa20so4179258pjb.1
        for <linux-pm@vger.kernel.org>; Mon, 24 Feb 2020 04:59:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ryxn5b4EDbiCAyyRC3XMyBM6fCDfyjHdPnAp7mp/HOM=;
        b=UBicdBzxAmDEmFFrgqESYIuGQnP15PLI4MqcJmVARO0UC1pUw+8P4S1LUhNcxbQmRh
         E1gSvIb9pF4L+dSNR++nsk4rEhxEYhb/j9Zk1y5qRFFSLAqOzhFWKBkx/04/fJdtrh0Z
         xDXsrFYvKuh5R2RgyCx/fNCWZ+ijKPH+j0wn3zzOjjXOK4b4azSwQ5H91yR/wiPcvjz2
         QL3/h7h388biKYkSf28DIcmCCDTPrQy+8Fr8gEBM8+rg17UZZkQO3065xprKRbQ61c+9
         3ebxdqJ5CR9q0o6TfIQoEzEesAxjUc5rvjfNzZwwCsmB9BlOvZ19UwfOsj/FTs+4eOuH
         sopA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ryxn5b4EDbiCAyyRC3XMyBM6fCDfyjHdPnAp7mp/HOM=;
        b=b4XPr46mfTCKZ7UQQUoNzGmQRRn37ykIiCaCSk1SzmRU5hlUGzJQfyxLOFPUG03UhC
         dY+MtUtRkyfEVVK/jUELJ8CnLxJyEjKHQDWQEWoZGnFPeOySfSkBLQ1EJ3j8uRGY4cfZ
         1xvm3/5tBEtgCCgLY9SRI6oQvEN0QjzdpxvAyv6W4tR5pjyMOGbDCCaWU2Z5BK3HviX3
         ySRWlWunJn7+EtFD4dnPpq+IWZCDkqav/cs45ypGLDyY9WeaD3R07r02JKsao+wVop1D
         s6M7x8Jqx1cgRS0KuqDRDbsnSaC2lKDbMRMq9iNvuGUwI6PKlO4EAVgPbjiV78s9I+D5
         j9Yg==
X-Gm-Message-State: APjAAAXeIHrNxD+a+y/jHF8PevecBcCFHlwUX/7Po075tFdNX3rZ0vyq
        jPjAheJSLzWHBtN6iWLa20YJkA==
X-Google-Smtp-Source: APXvYqwg5tufZIaT33jpb7I1MkLg/A4X9TBK59G5zjTgr8suH6/5MbxjyJgtJJRVveHb3SFHmMTm5g==
X-Received: by 2002:a17:902:724a:: with SMTP id c10mr49301343pll.307.1582549141768;
        Mon, 24 Feb 2020 04:59:01 -0800 (PST)
Received: from localhost ([103.195.202.114])
        by smtp.gmail.com with ESMTPSA id ep2sm12609179pjb.31.2020.02.24.04.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 04:59:00 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        daniel.lezcano@linaro.org, bjorn.andersson@linaro.org,
        swboyd@chromium.org, sivaa@codeaurora.org,
        Andy Gross <agross@kernel.org>
Cc:     Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-pm@vger.kernel.org
Subject: [PATCH v6 0/8] thermal: tsens: Handle critical interrupts
Date:   Mon, 24 Feb 2020 18:28:47 +0530
Message-Id: <cover.1582548319.git.amit.kucheria@linaro.org>
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
 drivers/thermal/qcom/tsens-common.c | 185 ++++++++++++++++++++++++----
 drivers/thermal/qcom/tsens-v0_1.c   |   6 +-
 drivers/thermal/qcom/tsens-v1.c     |   6 +-
 drivers/thermal/qcom/tsens-v2.c     |  24 +++-
 drivers/thermal/qcom/tsens.c        |  63 ++++++----
 drivers/thermal/qcom/tsens.h        | 103 ++++++++++++++--
 7 files changed, 320 insertions(+), 71 deletions(-)

-- 
2.20.1

