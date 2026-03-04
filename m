Return-Path: <linux-pm+bounces-43541-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sAWGLbuqp2lejAAAu9opvQ
	(envelope-from <linux-pm+bounces-43541-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 04 Mar 2026 04:44:59 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 19FAD1FA7E2
	for <lists+linux-pm@lfdr.de>; Wed, 04 Mar 2026 04:44:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AE02E311D21E
	for <lists+linux-pm@lfdr.de>; Wed,  4 Mar 2026 03:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD696377005;
	Wed,  4 Mar 2026 03:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UbmR68Fk"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284DD346E57
	for <linux-pm@vger.kernel.org>; Wed,  4 Mar 2026 03:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772595854; cv=none; b=WDVAlL2Zd+nPhbOF+tZ79+buoAPEzw31jG+Oy9hKPAOeO7fv2JP8GdoT+Q8IXvESGXn5euA/8phviBAzrZoEMG6c+kEpUxtgmtTXDkNjPPdr6MATmPO6gsmMgDrDtZ7oYbLABsevUwGn7qZXM2+cTOYorR4zxkaFOVPdYSJxf1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772595854; c=relaxed/simple;
	bh=V3nE+XT6gJM1djPOVmmoXLkSIGNlRHxcehnXAsYeJSw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZYk4SJvgdPwODB4M0xf0hCsyTWsX+eB7GhKJBe3FTNr/8G1eEMP8YP3ovq7VvtA6e/e+/EpoaoSmAt7pMzWdvZqueB5tmv6PYhJymk1Qive2ksg9mRoENK04cdZ8XnnAKwGo2p7FJlrqrkQ4yZkxO9PZNVr+jd4weg8XDbLU5nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UbmR68Fk; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-506c02ec1b3so73532991cf.0
        for <linux-pm@vger.kernel.org>; Tue, 03 Mar 2026 19:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772595851; x=1773200651; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZmZUdiZZg0fCj/2i+g2j9xmvk9n9CjWeVFiVPCHQNYY=;
        b=UbmR68FkK7IIj+x9hLIlgrrZ26cZFQyULJysCgnfFl7nzbmOrpNa7nEAiH4y+lmQwa
         Cs1TKw5xXy/xEoSVWt83LWndJBOZoK1FVw2i8AXWRh8h6jxtGKBl5U2ieSgqyvPjUsmS
         tGKtGzN/TGhCXLfuvV9kX9a0j25u7HSCnMiwavyHG1Vy/6TkETTrrNq5vSc7kB2cYm2q
         gtR6c2vbgM+KxK1KNfR/sI2emqIl4v6i+RvLeZwEwFBv6TTQPuY198t2bgV3QDnXPevK
         gCe67X4z1OAIy+jWyPCqaemd6ZmEWXHgEicSU6RHLKRPmvGPsLi/HauC2oVe6yzqwCKn
         rM7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772595851; x=1773200651;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZmZUdiZZg0fCj/2i+g2j9xmvk9n9CjWeVFiVPCHQNYY=;
        b=q4Ksuf5QHW9u5O2gio7PnZD//M/LdMlhH0lq/Gco7QdsNH9WektpIy86+YSPM5Wag0
         aqrU3vY7lIAntf8RZHLjm9H+i4VSUFOaCtbphTRQa0VmGPsnZe8w+Vqnapfee1GixuGU
         cbkqdfmudpWDK1eNt4YzVharePkImZgUXt3w3I7dyO75T/HOlYBrbMjiR6srTinfABfD
         nifRqDlGNC0gXVMpywxPMGK0cw37qLdHI3cjBlTUCU/Mf/D6m/iSz1+DUZZYOpjn7dS3
         JOCRbEJz18yszhlYBTSYzMgfA34V0A2Bpv4/fGEhQJh7jZAH85X8cj2NfcuDVCnX1sBH
         tcoA==
X-Forwarded-Encrypted: i=1; AJvYcCWruJo/R+CNUgRGpYisz7ruig2ueR+k6ngII6oOGgKn0CTs0gfx50es8cenJrsodOQeWId2+CKSnA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1Gq7nF2EyoZNDMqNCEfl55RXCTNng2fthZmT8bGk9f3xGSjSn
	bfsleY9wYq5zWMX6vXI6nFPaP2LSR57gahALWGgNsyLfVKMgcU6VAmye
X-Gm-Gg: ATEYQzxXQa8XF0cO01/Hm6xFS8ZoTaqYvm80oMiGYNv1oIntnXnv9haaYNdzm7HORPX
	LBOqF/gFu49d/uDoOb8LbNJxpeSirUJFA7iAr+pN20Ufyy1RYwB6UivvUhE5FQIJ0b3ovW3JRTy
	Cz8bkVEqqK3wCZEUXnwqpt4FjjwUaaD41fbz72ZFK4LlGR8M7B5tENcXNkCFymQljLtDP342V3V
	xpLvlEtKJB4yfOHg6mL6OOqZgkkVnKHbZc/7E9gA0JBN/Q5J6VvbzrUrzrZYoVLvIP8Yi+fRW2e
	AOe+xE0NLpb7FLRaPY9Y5AQ5bK6iE7IrR1+a278uVPkl+dG8LG0t70i9ccmS7T6JB3CXIZne8Yy
	YnsTxsQUWDmcvyjEfd42r06UxZrMN6cLf0Rbd6Ud+birmbB6dodeU2W51DjwcVtXxYllESRcJ0Y
	A+H1pbm7OU/CxZPksY4TDEvzxtWIQ=
X-Received: by 2002:a05:622a:1490:b0:501:4b9d:ad19 with SMTP id d75a77b69052e-508cea9b44fmr52007601cf.22.1772595851140;
        Tue, 03 Mar 2026 19:44:11 -0800 (PST)
Received: from [172.17.0.2] ([134.128.219.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899e608cfc6sm88603286d6.14.2026.03.03.19.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 19:44:10 -0800 (PST)
From: Yuanshen Cao <alex.caoys@gmail.com>
Date: Wed, 04 Mar 2026 03:43:45 +0000
Subject: [PATCH 2/2] pmdomain: sunxi: Add support for A733 to Allwinner
 PCK600 driver
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260304-b4-pck600-a733-v1-2-2f54efdb8cc2@gmail.com>
References: <20260304-b4-pck600-a733-v1-0-2f54efdb8cc2@gmail.com>
In-Reply-To: <20260304-b4-pck600-a733-v1-0-2f54efdb8cc2@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, Yuanshen Cao <alex.caoys@gmail.com>
X-Mailer: b4 0.14.3
X-Rspamd-Queue-Id: 19FAD1FA7E2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43541-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,sholland.org,linaro.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,lists.linux.dev,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexcaoys@gmail.com,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

The Allwinner A733 PCK600, similar to A523 PCK600, is likely a
customized version of ARM PCK-600 power controller. It shares
the same BSP driver with A523. According to the BSP provided
by Radxa, unlike A523, it doesn't require reset.

Make reset optional in the sunxi pck600 driver and add support
for A733.

Signed-off-by: Yuanshen Cao <alex.caoys@gmail.com>
---
 drivers/pmdomain/sunxi/sun55i-pck600.c | 53 ++++++++++++++++++++++++++++++----
 1 file changed, 48 insertions(+), 5 deletions(-)

diff --git a/drivers/pmdomain/sunxi/sun55i-pck600.c b/drivers/pmdomain/sunxi/sun55i-pck600.c
index c7ab51514531..8f9fdc3915bd 100644
--- a/drivers/pmdomain/sunxi/sun55i-pck600.c
+++ b/drivers/pmdomain/sunxi/sun55i-pck600.c
@@ -52,6 +52,7 @@ struct sunxi_pck600_desc {
 	u32 logic_power_switch0_delay;
 	u32 logic_power_switch1_delay;
 	u32 off2on_delay;
+	bool has_rst_clk;
 };
 
 struct sunxi_pck600_pd {
@@ -151,9 +152,11 @@ static int sunxi_pck600_probe(struct platform_device *pdev)
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
-	rst = devm_reset_control_get_exclusive_released(dev, NULL);
-	if (IS_ERR(rst))
-		return dev_err_probe(dev, PTR_ERR(rst), "failed to get reset control\n");
+	if (desc->has_rst_clk) {
+		rst = devm_reset_control_get_exclusive_released(dev, NULL);
+		if (IS_ERR(rst))
+			return dev_err_probe(dev, PTR_ERR(rst), "failed to get reset control\n");
+	}
 
 	clk = devm_clk_get_enabled(dev, NULL);
 	if (IS_ERR(clk))
@@ -193,7 +196,14 @@ static int sunxi_pck600_probe(struct platform_device *pdev)
 }
 
 static const char * const sun55i_a523_pck600_pd_names[] = {
-	"VE", "GPU", "VI", "VO0", "VO1", "DE", "NAND", "PCIE"
+	"VE",
+	"GPU",
+	"VI",
+	"VO0",
+	"VO1",
+	"DE",
+	"NAND",
+	"PCIE",
 };
 
 static const struct sunxi_pck600_desc sun55i_a523_pck600_desc = {
@@ -206,7 +216,36 @@ static const struct sunxi_pck600_desc sun55i_a523_pck600_desc = {
 	.device_ctrl1_delay = 0xffff,
 	.logic_power_switch0_delay = 0x8080808,
 	.logic_power_switch1_delay = 0x808,
-	.off2on_delay = 0x8
+	.off2on_delay = 0x8,
+	.has_rst_clk = true,
+};
+
+static const char * const sun60i_a733_pck600_pd_names[] = {
+	"VI",
+	"DE_SYS",
+	"VE_DEC",
+	"VE_ENC",
+	"NPU",
+	"GPU_TOP",
+	"GPU_CORE",
+	"PCIE",
+	"USB2",
+	"VO",
+	"VO1",
+};
+
+static const struct sunxi_pck600_desc sun60i_a733_pck600_desc = {
+	.pd_names = sun60i_a733_pck600_pd_names,
+	.num_domains = ARRAY_SIZE(sun60i_a733_pck600_pd_names),
+	.logic_power_switch0_delay_offset = 0xc00,
+	.logic_power_switch1_delay_offset = 0xc04,
+	.off2on_delay_offset = 0xc10,
+	.device_ctrl0_delay = 0x1f1f1f,
+	.device_ctrl1_delay = 0x1f1f,
+	.logic_power_switch0_delay = 0x8080808,
+	.logic_power_switch1_delay = 0x808,
+	.off2on_delay = 0x8,
+	.has_rst_clk = false,
 };
 
 static const struct of_device_id sunxi_pck600_of_match[] = {
@@ -214,6 +253,10 @@ static const struct of_device_id sunxi_pck600_of_match[] = {
 		.compatible	= "allwinner,sun55i-a523-pck-600",
 		.data		= &sun55i_a523_pck600_desc,
 	},
+	{
+		.compatible	= "allwinner,sun60i-a733-pck-600",
+		.data		= &sun60i_a733_pck600_desc,
+	},
 	{}
 };
 MODULE_DEVICE_TABLE(of, sunxi_pck600_of_match);

-- 
2.53.0


