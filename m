Return-Path: <linux-pm+bounces-16600-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B5D69B3693
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 17:34:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC288285136
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 16:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36D1B1DED77;
	Mon, 28 Oct 2024 16:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ELaI4UXe"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19F81DE3B4
	for <linux-pm@vger.kernel.org>; Mon, 28 Oct 2024 16:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730133270; cv=none; b=A+1Oxz1g8I8v1HYYvckMvklWmC12eEz2OhwmFrdVGQ9eWl8wmAz0JF+7++MOqG+RqVjo2buCtGj9vgWLDme4SsdLsOAbTeD1GNVwk5rrIe20CZkP+RVsg349XyXnulIdPDZFqo2hoCk2jxiUD1dY4B5E0CpokRBSdowXQwSoIbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730133270; c=relaxed/simple;
	bh=RoDbH8hhDR7FVvuNh9vHX1jh1XZGfsb2QPHmuvLlXZU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZgMvwwkiRB3lTszuggLKFNIMvGX21GX/7RR6cPX3CD3pZvB2zyE2JA24CeZfw+Y8dR7n9SKpDgB/x6jEeT4IaBPH3HcVu3lSmVlsqGzxcZ6NXn3qHqByxL0mprs1vvSTHp/A5ESwBuJeYBcg4or0OK/bHJp06PebMKNYBxPncEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ELaI4UXe; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-37d4fd00574so2864458f8f.0
        for <linux-pm@vger.kernel.org>; Mon, 28 Oct 2024 09:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730133264; x=1730738064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=js81SeQpn9xUgzINLi31wUaurNTSsIvVF8Ge8x3mQNo=;
        b=ELaI4UXePNplr+7iBtL4zncHmuhkzIPn3/BFkOSdrc5fgTYIdCPveBgDA3zEjzKC23
         6qZzeIDXOio68pfFE2ixhsHl2IPmtnmlvVIaSn2fTANkUFO9d1MReBIgdznuEDrLs6Hm
         fvkIuV/h+jNMwqTQ0yvZXjtUEYkL8W1NslsXIR2oKkCmW71bp0aPDlsO0gHQFemiHPua
         yhNY/N2MevmEikY9rfZgEtYbjG4+QOYwQZiPf4JIh6DzAX6stz+Vl0huL2SZE9diYlZ5
         HjW3Sq3AMtF7LXAFOv8CWLfCTSXTrqStYrf3j1oTI1VJNRbOPz6ZqSnHvCYfWftprXv3
         5CSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730133264; x=1730738064;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=js81SeQpn9xUgzINLi31wUaurNTSsIvVF8Ge8x3mQNo=;
        b=CULNNvIjog8R8jMohhl8Gh+ROHX4TK7lEhi6hjDqlnwp8UB/jUfurEbpEbDZUJjBBS
         A3b1R8NOkGG5Mq2HrsdB0d/lJF53kcbepxJh6npOQldvK3d7w31l3tThwhidUwNoG7xG
         Ad/llGaLEq+kbCBnTocNh+oyug9tw4Ib9HKfY94nfjVela0R9/paDaFlAPJIag94QOmU
         uuP2PbVN+Df2mvxS70jnRQnBeyRAuHzdDNk80gG+GuZq4w7DAVHoLxRkHrUoOYHZ+Ipv
         eUUABAilsAZ6h6eaH8vJk72j4Ew13W20eY3rBwlZo+DyAoUVasOtatVHkVywcCb1jE5N
         Q3BQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxIfYrNnY6h42lVQUKX/a3AN5COsr+R3Zomj6JtSVC+ujjGX/eZ+ztfOW5ZxBBD5RFuhkUMg6FFw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxH8DSx0tKEaDkM7quQ5KBaESMq5wVuM5rrRSlFJJw2KFUY1XKm
	YFe0/0+TmPaL4E5NGOaZh8qZh4h34B80HNvA1oSJPNwv3j32XMwtsbyUMpkr9A8=
X-Google-Smtp-Source: AGHT+IHGS7TezSWXTQnx/EjfY1u1lEUaZd6nAutN8M7vFaejhP8Nake+9DeRhSOrd8BaunXKDH5yrw==
X-Received: by 2002:adf:ec8a:0:b0:37d:3baa:9f34 with SMTP id ffacd0b85a97d-380813bc996mr199477f8f.1.1730133264161;
        Mon, 28 Oct 2024 09:34:24 -0700 (PDT)
Received: from eugen-station.. ([82.76.24.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b47f6fsm9944608f8f.50.2024.10.28.09.34.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 09:34:23 -0700 (PDT)
From: Eugen Hristev <eugen.hristev@linaro.org>
To: linux-arm-msm@vger.kernel.org
Cc: andersson@kernel.org,
	konradybcio@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org,
	djakov@kernel.org,
	sboyd@kernel.org,
	mturquette@baylibre.com,
	Eugen Hristev <eugen.hristev@linaro.org>
Subject: [PATCH v2] soc: qcom: Rework BCM_TCS_CMD macro
Date: Mon, 28 Oct 2024 18:34:03 +0200
Message-ID: <20241028163403.522001-1-eugen.hristev@linaro.org>
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

While at it, used le32_encode_bits which made the code easier to
follow and removed unnecessary shift definitions.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 drivers/clk/qcom/clk-rpmh.c           |  2 +-
 drivers/interconnect/qcom/bcm-voter.c |  2 +-
 include/soc/qcom/tcs.h                | 28 +++++++++++++--------------
 3 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/clk/qcom/clk-rpmh.c b/drivers/clk/qcom/clk-rpmh.c
index 4acde937114a..4929893b09c2 100644
--- a/drivers/clk/qcom/clk-rpmh.c
+++ b/drivers/clk/qcom/clk-rpmh.c
@@ -267,7 +267,7 @@ static int clk_rpmh_bcm_send_cmd(struct clk_rpmh *c, bool enable)
 
 	if (c->last_sent_aggr_state != cmd_state) {
 		cmd.addr = c->res_addr;
-		cmd.data = BCM_TCS_CMD(1, enable, 0, cmd_state);
+		cmd.data = (__force u32)BCM_TCS_CMD(1, enable, 0, cmd_state);
 
 		/*
 		 * Send only an active only state request. RPMh continues to
diff --git a/drivers/interconnect/qcom/bcm-voter.c b/drivers/interconnect/qcom/bcm-voter.c
index a2d437a05a11..ce9091cf122b 100644
--- a/drivers/interconnect/qcom/bcm-voter.c
+++ b/drivers/interconnect/qcom/bcm-voter.c
@@ -144,7 +144,7 @@ static inline void tcs_cmd_gen(struct tcs_cmd *cmd, u64 vote_x, u64 vote_y,
 		vote_y = BCM_TCS_CMD_VOTE_MASK;
 
 	cmd->addr = addr;
-	cmd->data = BCM_TCS_CMD(commit, valid, vote_x, vote_y);
+	cmd->data = (__force u32)BCM_TCS_CMD(commit, valid, vote_x, vote_y);
 
 	/*
 	 * Set the wait for completion flag on command that need to be completed
diff --git a/include/soc/qcom/tcs.h b/include/soc/qcom/tcs.h
index 3acca067c72b..152947a922c0 100644
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
@@ -60,22 +63,19 @@ struct tcs_request {
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
+	(le32_encode_bits(commit, BCM_TCS_CMD_COMMIT_MASK) |	\
+	le32_encode_bits(valid, BCM_TCS_CMD_VALID_MASK) |	\
+	le32_encode_bits(vote_x,	\
+			BCM_TCS_CMD_VOTE_X_MASK) |		\
+	le32_encode_bits(vote_y,	\
+			BCM_TCS_CMD_VOTE_Y_MASK))
 
 #endif /* __SOC_QCOM_TCS_H__ */
-- 
2.43.0


