Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4BAE162DD8
	for <lists+linux-pm@lfdr.de>; Tue, 18 Feb 2020 19:12:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbgBRSMU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 18 Feb 2020 13:12:20 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37225 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbgBRSMT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 Feb 2020 13:12:19 -0500
Received: by mail-pg1-f195.google.com with SMTP id z12so11350690pgl.4
        for <linux-pm@vger.kernel.org>; Tue, 18 Feb 2020 10:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aEx06awt80jAiN38AZX49qL25dVM9rqZAP00JoKZ/1Y=;
        b=iFWBs0FkEI2gFTZEtmapEPIfUk/1BHgR6/8C7cy9tCyQgZnwEidoCOaGe2BbCywP7Y
         dCSNeFzuHQdAG0Ypm7IeiqPu3kdhsHEtatvB/GX3yZcG5Ij7r1lUNhBN8eFDdl+LY2ul
         7y5gFsa7IhVoIuMKWESajf4rAv8FQv1zmkt4Vv/GI6QEVenkNfcYTrV3th7ZWENgUaQM
         iwFH35NRw+tPRKU1FdZxaLQmzL+nyYUVLYutUHuwmzbxC0bH2jh8Yt/RMisg9OzE3+Jq
         qrRH5M+/6tUcmxeEA/M++hK75kN5uvuHJL0eDwfpqIBbcrv/+ugDjZAI1mQKZnvwzcok
         EPJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aEx06awt80jAiN38AZX49qL25dVM9rqZAP00JoKZ/1Y=;
        b=qXUJk/GjL1qyERcJXmdyuyoxfzWfk0A/xxFAxMXNSXKeo7wi7w1KhVpzZGJWcQjwbG
         i0W8shwpg8jU4yIcQ/ZmBNtwfJxmup2fObhad5XkJcgReNSpUf6/7ANygYuD49Cor6GG
         rBn/FyCivOlER+wiOLcCVxxoLM9I6+NhA5nDhcnN6xURSf+Rae6zeurIvBCdQt32AQzw
         MXN7iv8Pb622syzD413GjB6+n40Ekfuqr7xTjoc3S8XROTSh35ld+Nk3fKgv/2rhew1v
         L1bN4z/0BTpB80xQcBDN4wdyDzTGabvp2IPzi4XQ/bpzqLsu8F8yt5uLk73j+E2iarm2
         ysnQ==
X-Gm-Message-State: APjAAAWs29rotPBUYEzeEO+oDpwlcCkcOYMkkJaSCfdq8ymy8sKihUjG
        Lt3WamOgFOU1yDENj7aVcKqbJw==
X-Google-Smtp-Source: APXvYqzRi7O6oL6zesAkbVlSiq+VLIsiK6/GEYjK1IYW1nzcmRnPUB0H7UmdmroY+zhRwI0RtOQx7w==
X-Received: by 2002:a63:5345:: with SMTP id t5mr23708373pgl.254.1582049538893;
        Tue, 18 Feb 2020 10:12:18 -0800 (PST)
Received: from localhost ([103.195.202.120])
        by smtp.gmail.com with ESMTPSA id d14sm5071557pfq.117.2020.02.18.10.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 10:12:17 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        daniel.lezcano@linaro.org, bjorn.andersson@linaro.org,
        swboyd@chromium.org, sivaa@codeaurora.org,
        Andy Gross <agross@kernel.org>
Cc:     Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-pm@vger.kernel.org
Subject: [PATCH v5 0/8] thermal: tsens: Handle critical interrupts
Date:   Tue, 18 Feb 2020 23:42:04 +0530
Message-Id: <cover.1582048155.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

TSENS IP v2.x supports critical interrupts and v2.3+ adds watchdog support
in case the FSM is stuck. Enable support in the driver.

This series was generated on top of v5.6-rc2.

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
 drivers/thermal/qcom/tsens.c        |  26 +++-
 drivers/thermal/qcom/tsens.h        | 103 ++++++++++++++--
 7 files changed, 307 insertions(+), 47 deletions(-)

-- 
2.20.1

