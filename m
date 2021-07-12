Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C70AD3C4055
	for <lists+linux-pm@lfdr.de>; Mon, 12 Jul 2021 02:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbhGLA1F (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 11 Jul 2021 20:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbhGLA1F (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 11 Jul 2021 20:27:05 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF5AC0613DD;
        Sun, 11 Jul 2021 17:24:16 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id e14so16279162qkl.9;
        Sun, 11 Jul 2021 17:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H7a9eq7wZxPQFQwI3zuFeYX1K7ObSWQ2BOFHF5Y37r4=;
        b=LrTG6jSuNYP2KLXY3Sg1oI8YVomTr6ejvQpaWvQBc/kSNm7yLGlYehHIe6msSHNAeD
         Y9j90nnpSRE1qYAWUf9M8rodWVyAk9mCOSXlZu+FH39kFB+2SYATPIkquqzzvFdpdW7N
         mQlNtGGUhLlnfbfgpBgRnTuVtczUW8QYPiYftvzu+kfLf6pM1VR1wPZNW+b5XZFFYRdw
         IDpYRXReYfHhDuMU4IRAkwSqKahppPt1i8b4zEHqWPN69XvvDRAdy0HyI8kJuSanSn1c
         G27qTmyQRZ67kNtpi0dBgI+sgtivJn8b6uQGl6bQI/kQgtyzNLmCGUfdBICtEZOuXqcm
         dPYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H7a9eq7wZxPQFQwI3zuFeYX1K7ObSWQ2BOFHF5Y37r4=;
        b=E1iyPFR3SBM7eQwYROMHwisBke6N+oNKkrwRc+AAobjdG/C7DE1/xwKOKiUecCSpq0
         pX530jFd9WCau67pWtYIQBYK5nE/wvSXB5KVPRIvry2eXTC/2gptydUAP39q3qFulTsB
         81gTaZodtA4BRwFLeiOGaAYCPFZ8hWQRmjkUTEUMggsj4xTrSJmsoBnzDxpe4rKVnMYI
         vxDWvy2snWmNDZV1uHmvO2NG7fcZ5qfbW21qjgG2+0+liMI5sSLfelv22m7m0+XmlAqO
         fAJKZfIcBK5rYjB3TA5kNBP6P+kdUoNPFI8VFpnJo6CpgLrYQFoxMi5FKEhxkEManiXo
         F7EA==
X-Gm-Message-State: AOAM532zaYrQVUgtPtDQP9FBrXyqFbr+1Cq0DuV+0H2ADf7/oWVyazTB
        3GLPZ3fVsjJVBX2dskcOPxw=
X-Google-Smtp-Source: ABdhPJxfBTp4T49Mv2FPNU/JPT/VkuLWO727r+QA6VRfGDv/OKPt8IM/+h/Z1eG9QNGD5tIm8wajDA==
X-Received: by 2002:a37:2d04:: with SMTP id t4mr6426682qkh.160.1626049455843;
        Sun, 11 Jul 2021 17:24:15 -0700 (PDT)
Received: from localhost.localdomain (94-29-37-113.dynamic.spd-mgts.ru. [94.29.37.113])
        by smtp.gmail.com with ESMTPSA id h13sm5860762qkg.13.2021.07.11.17.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jul 2021 17:24:15 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH v1] thermal/drivers/tegra-soctherm: Silence message about clamped temperature
Date:   Mon, 12 Jul 2021 03:23:53 +0300
Message-Id: <20210712002353.17276-1-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The Tegra soctherm driver prints message about the clamped temperature
trip each time when thermal core disables the low/high trip. The message
is confusing and creates illusion that driver is malfunctioning. Turn that
noisy info message into a debug message.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/thermal/tegra/soctherm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
index 8e303e9d1dc0..210325f92559 100644
--- a/drivers/thermal/tegra/soctherm.c
+++ b/drivers/thermal/tegra/soctherm.c
@@ -450,8 +450,8 @@ static int enforce_temp_range(struct device *dev, int trip_temp)
 
 	temp = clamp_val(trip_temp, min_low_temp, max_high_temp);
 	if (temp != trip_temp)
-		dev_info(dev, "soctherm: trip temperature %d forced to %d\n",
-			 trip_temp, temp);
+		dev_dbg(dev, "soctherm: trip temperature %d forced to %d\n",
+			trip_temp, temp);
 	return temp;
 }
 
-- 
2.32.0

