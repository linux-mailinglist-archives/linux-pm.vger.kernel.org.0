Return-Path: <linux-pm+bounces-18241-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 298079DE85D
	for <lists+linux-pm@lfdr.de>; Fri, 29 Nov 2024 15:25:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C661028277A
	for <lists+linux-pm@lfdr.de>; Fri, 29 Nov 2024 14:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6DED224D4;
	Fri, 29 Nov 2024 14:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dda0CXCj"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A59D208CA
	for <linux-pm@vger.kernel.org>; Fri, 29 Nov 2024 14:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732890297; cv=none; b=lKKAJY7cjwsqp2UMZQm84+4a1c0l4tFOHPLSQJRZ14X5l+iyAVZ3bYcZzPe/NCFxTuCYbTi+ZfPDF4/uDf1zmKmlGjY+mJJB9sNZo+a0h91pI1Nf40sgbNJzR9y/dxjxyExypLD/3wD0NHrp79432guh11oqPLqR4ngcIT/vemU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732890297; c=relaxed/simple;
	bh=bSfl7Dve9i5C1znJ/YQ1xVmQ29PlBYONWFiyrKw6DiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KpBhopmK4UVLEA7nqQS5bRKpm4WiAw0rTYwta9eRmv/cbEn51g0I3/UN6Aq39M6O3Fy2+U5TlhbXUyKYTfN6rWrqYOX6+gaaz+wYbfR9MTnZI2ycBuJKWe4Wf6BeeumACDityjBcEqupD5pogbROKi64DxzQw6T4DkxyqM85U8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dda0CXCj; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-53de7321675so2054992e87.2
        for <linux-pm@vger.kernel.org>; Fri, 29 Nov 2024 06:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732890294; x=1733495094; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rCZSOSvoZDja8J6h/7BpGF/AK434TPL5kxxQSlBImvw=;
        b=dda0CXCjdVZzoPXPK2yfi8OtWeFj4XS+Az7Xq3dhJwk398+UOFT3mDQTXg3wJfTS+J
         TiE+CcFgF6eLhJpeSlvPCR5NfZ5hnbtYn56AFGxzSR6Irf4X1J535AxhUpNKRsVYyEOO
         XxPsk7CV6qJjx/49eexI9cZDMpHNBBR5ZPMun4IwJcxoGU8hrHTlizRt6PuxGcFGmvaR
         GtcHjcq/9oQF/SfLtuMCaeZ0oIWNoWMEoNdBLTadF9xy2aWSV7GIDHAPcjh58M+W7x0U
         UPyvhv9wn72HrnuhaHBq1NlqlXjza/Rn+vDgeCPhTStqVWXZYjhqmAV+dgbta1HuLSfT
         yakA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732890294; x=1733495094;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rCZSOSvoZDja8J6h/7BpGF/AK434TPL5kxxQSlBImvw=;
        b=CFKcKaHyfphqnFlWaKetclVx8GVZ8qkcg1dx1PcSRV72LKWoUn0tDX9RCiBc5YHYVB
         paRNfi8Ub2SZ4SS6os95h+n7adgWWkmu3htmWtrUwH1k+6E1hUOCH8nHpGftQIMIGkSF
         OmGyg32Fu88f5JiaVXzf4qyc73+tVykQEu7/dOjfUBSV9LYigUTRqhbmKanNfrHQwNeA
         QmCH6DNGaqQll9xk88CcwC8/S2kCkTf8KTMVg6DE8AQQsIttWhcqZgGbfu8Z/QUXEo79
         7xKAg05GNU9+1n7EUDQZzy+CRvIsPlM2H4hyClotQ6L5ijzeAyl1LJpuP/EmH4qkfR2s
         lFyA==
X-Forwarded-Encrypted: i=1; AJvYcCWVJQQ2ekDniaLp+AISK7RaAoRw1KYl+/pcSJ5FZIiD+2jD/GPS+nm2K7X/qa+hiypoG4RIOCKc6A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxPEFqyizQommfAPvc80+8xlvWYs3KoYz/WAkxaanqbcbglHzUe
	M1sCv/QB9Eft5Le6i0SiUWzimwWg3W0GbDMtyw6TYFZhxA4EkBKviIOUJjd9Oek=
X-Gm-Gg: ASbGncvZoLS+s8LmAbRsxhDHiPLisEIc15IZZAgR0BOYDq51a5QjzKlMw4O3srMs92E
	rjPAwYYeyRgxookejkGT3mJo0YBujRU5/8LPJZ+PEDY30JqFxhOIQ4ElzqvleqHWcc+RJB1Hwvb
	Kg1eXUzLwpaW7XoCDnkUEZEU3xEox9nf7ImAS5KRxS2chNbuCeMtmCBWv+sG1a70PUCBR1LMsPk
	NOtk6MMYXCJT9EfOXlCAiHyhxmXDugMGSXnjotZLzONd7k0rodcg/qUdBk=
X-Google-Smtp-Source: AGHT+IH/gEyxEGAkwMq76NQgb08E1phOa65IpCDKYvd1xADq8bu4IAVMjy4IbH6o6Y5621O+PeSi0A==
X-Received: by 2002:a05:6512:3b90:b0:53d:e077:ded9 with SMTP id 2adb3069b0e04-53df010eaabmr6981535e87.48.1732890294314;
        Fri, 29 Nov 2024 06:24:54 -0800 (PST)
Received: from eugen-station.. ([82.76.24.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385ccd7fb40sm4671540f8f.89.2024.11.29.06.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 06:24:53 -0800 (PST)
From: Eugen Hristev <eugen.hristev@linaro.org>
To: linux-arm-msm@vger.kernel.org,
	sboyd@kernel.org
Cc: linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	konradybcio@kernel.org,
	andersson@kernel.org,
	evgreen@chromium.org,
	Eugen Hristev <eugen.hristev@linaro.org>
Subject: [PATCH v4] soc: qcom: Rework BCM_TCS_CMD macro
Date: Fri, 29 Nov 2024 16:24:46 +0200
Message-ID: <20241129142446.407443-1-eugen.hristev@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reworked BCM_TCS_CMD macro in order to fix warnings from sparse:

drivers/clk/qcom/clk-rpmh.c:270:28: warning: restricted __le32 degrades to integer
drivers/clk/qcom/clk-rpmh.c:270:28: warning: restricted __le32 degrades to integer

While at it, used u32_encode_bits which made the code easier to
follow and removed unnecessary shift definitions.

The use of cpu_to_le32 was wrong and thus removed.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
Changes in v4:
- as per Stephen Boyd, removed cpu_to_le32 being wrong.

Changes in v3:
- align the macro lines better

Changes in v2:
- use le32_encode_bits instead of u32_encode_bits with a cpu_to_le32 on
the fields; this however ment we need to force cast the le32 to the
u32 container.

 include/soc/qcom/tcs.h | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/include/soc/qcom/tcs.h b/include/soc/qcom/tcs.h
index 3acca067c72b..cff67ce25488 100644
--- a/include/soc/qcom/tcs.h
+++ b/include/soc/qcom/tcs.h
@@ -6,6 +6,9 @@
 #ifndef __SOC_QCOM_TCS_H__
 #define __SOC_QCOM_TCS_H__
 
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+
 #define MAX_RPMH_PAYLOAD	16
 
 /**
@@ -60,22 +63,17 @@ struct tcs_request {
 	struct tcs_cmd *cmds;
 };
 
-#define BCM_TCS_CMD_COMMIT_SHFT		30
-#define BCM_TCS_CMD_COMMIT_MASK		0x40000000
-#define BCM_TCS_CMD_VALID_SHFT		29
-#define BCM_TCS_CMD_VALID_MASK		0x20000000
-#define BCM_TCS_CMD_VOTE_X_SHFT		14
-#define BCM_TCS_CMD_VOTE_MASK		0x3fff
-#define BCM_TCS_CMD_VOTE_Y_SHFT		0
-#define BCM_TCS_CMD_VOTE_Y_MASK		0xfffc000
+#define BCM_TCS_CMD_COMMIT_MASK		BIT(30)
+#define BCM_TCS_CMD_VALID_MASK		BIT(29)
+#define BCM_TCS_CMD_VOTE_MASK		GENMASK(13, 0)
+#define BCM_TCS_CMD_VOTE_Y_MASK		GENMASK(13, 0)
+#define BCM_TCS_CMD_VOTE_X_MASK		GENMASK(27, 14)
 
 /* Construct a Bus Clock Manager (BCM) specific TCS command */
 #define BCM_TCS_CMD(commit, valid, vote_x, vote_y)		\
-	(((commit) << BCM_TCS_CMD_COMMIT_SHFT) |		\
-	((valid) << BCM_TCS_CMD_VALID_SHFT) |			\
-	((cpu_to_le32(vote_x) &					\
-	BCM_TCS_CMD_VOTE_MASK) << BCM_TCS_CMD_VOTE_X_SHFT) |	\
-	((cpu_to_le32(vote_y) &					\
-	BCM_TCS_CMD_VOTE_MASK) << BCM_TCS_CMD_VOTE_Y_SHFT))
+	(u32_encode_bits(commit, BCM_TCS_CMD_COMMIT_MASK) |	\
+	u32_encode_bits(valid, BCM_TCS_CMD_VALID_MASK) |	\
+	u32_encode_bits(vote_x, BCM_TCS_CMD_VOTE_X_MASK) |	\
+	u32_encode_bits(vote_y, BCM_TCS_CMD_VOTE_Y_MASK))
 
 #endif /* __SOC_QCOM_TCS_H__ */
-- 
2.43.0


