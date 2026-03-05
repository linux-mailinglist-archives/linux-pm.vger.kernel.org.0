Return-Path: <linux-pm+bounces-43639-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ADTfCrX6qGnVzwAAu9opvQ
	(envelope-from <linux-pm+bounces-43639-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 05 Mar 2026 04:38:29 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 891BB20A9A8
	for <lists+linux-pm@lfdr.de>; Thu, 05 Mar 2026 04:38:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9AF2C308DBA2
	for <lists+linux-pm@lfdr.de>; Thu,  5 Mar 2026 03:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CEE827C84B;
	Thu,  5 Mar 2026 03:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SidjP6Bj"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66256264619
	for <linux-pm@vger.kernel.org>; Thu,  5 Mar 2026 03:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772681656; cv=none; b=DwPwq/mf/p3iMgqzszfCXY2b2bts3xiuFVMTC/Yc9gHXJnGuNWMV7WAw2dCEgyXMWsQSeNm8M4Ah2doklLZnr4BE4iDsoZcO0Lg/7I1RyHN/5tigR1AuQ18aWoFjegud6KrMq9rF5836J43/Nea5byDs6AYh3aOhjmSUgAFOrGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772681656; c=relaxed/simple;
	bh=3cQd24z258zjc20dy6ohb0HVeZL+LfFrMaR3/kR1p5Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Asf1C/ZX8A005nREAW6Bspq8L4qjNS4GV2OEpeTq1UFk+Xh0H/lhGY30NQEj4JGOZyN2gkH/BI3iWkN2y5ON7Qj44feXB5UxBqMBofLy0tpIxYtyeamgbOvwVxrmem8SKmUWzTHdANEmYsGwO6pNMBYDc7rCchz8U/dDPSHZzO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SidjP6Bj; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-506989e8516so65352861cf.0
        for <linux-pm@vger.kernel.org>; Wed, 04 Mar 2026 19:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772681653; x=1773286453; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2d5yl02iJv/wkdm4hWnCdO+qs5aDrcJeSjvUW0fTJuE=;
        b=SidjP6Bj1PVb3X7Yjw+MI6l8teBl3jhBlDLyZuGxFtfUg7WFxijpnenVz19Qu1nQLX
         eBrVlTNn4oEpkPnaMyt5Lv8xmcZ3xmjgqNOiyyJovd/YcxxJZv3iNZnqKTi0+UJSXjzy
         ATKUsOyfK02qOUX7ZrBT3GsjrBVJ3wcy7JvZNGrCc6A/xIrmYdUA6ml/8eTKBRSGMfJ3
         onkEWzLMUAxnH8mll9PP69MFHxsQFfVbXgDfGpqWjG1RTqHaxy7OhqTEjLNSHcMashaf
         NkbQClKluWQ3zMw3+J2V1lA+57uk46CyZD/ZyORfWr6d/C3VyoC2lCBlyNRlqyh74lHC
         9rTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772681653; x=1773286453;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2d5yl02iJv/wkdm4hWnCdO+qs5aDrcJeSjvUW0fTJuE=;
        b=Jkbex1qiF/VSvjpRoyLBxaSszxNqalie1Nfht87ycIg5jBLeRDxZr/BCC/rYU5qdzW
         eCjRrSQMmmXtOnmUeyJ2tQwBrqh9qTlc4h9lMuXfYuOfg0uDy/L0WDSowlC2RnqSHsBW
         +SHmT7LU6Slut6nmXOrH2iBAC6byj5uZlLe/VcQmKV4JqUoUJFg0l/dqOxT9WyOmskjj
         1oIUzUxs1EvUQ8kIgNyW0ndKVj9QG7jNaLxkOB0T+ld4A5NzR+1+QFotS7zpsIEyZyXv
         A7gW7ueWYrFL5Oox5w+MPIRrj8wQDB9AcZEGSUihnlrX1MvB7khbjr90chFDLyOX+7yB
         L+jg==
X-Forwarded-Encrypted: i=1; AJvYcCUoIqsFv664CZXd4Xvf0tjNsKG8MeAWpqGTs142JqdyCyfEK3uj901QoJm9BOxDqfpv/WuDr5UGew==@vger.kernel.org
X-Gm-Message-State: AOJu0YwLaGIkpb2X2ll8xRHhm6yqkuJeH7fyATiZxIIaD+wejdncIGhf
	8GNU/jPd5e5ovZOXGaXU72MoJGul5BH3QrxNmyFKBPBVcWjMBHx21pD6
X-Gm-Gg: ATEYQzwHplXjUT1pEnW87LZGPICeZifIipIq7KNXl21Jw6tNpuNcFTngm6QN/seTDUi
	BzoP/k0G00egXn3urwbWdNKxLqCxpdwzFoXDkCt0XLkou7qm14nwobbMTvA8L7bKkXvuE44lt1Q
	U8L994HEsP2mY/BQp+aU9wpX7HArs7SXSYFLDC/P3GoXx08tnaLAmKLGNiWWYfGrrcmTcisq+PU
	8PtDiByqA+KEJji5EEJd78kce0MJ08Xzk+KInPUmQcZ9hnr6gaeyHWgmayt1FGub7LtFKXcOAWX
	8JJ1CLeAxHmLLuI1fqEO82bJSyIWlm7kGZ8tzad+sy+FwL8rfeuoGmfXhGO6uQo6aBby+X9HvE8
	rEOpFqCJpNZ16Noxzk73dv1G7/T0/LFifpZ8w0VIUHTnbEz6mvY/4yWIJWGnTeQ7eYZXj0wUrhA
	LPW/4oiMixNkuZvEV3keZmpqNyFj8=
X-Received: by 2002:ac8:5a0c:0:b0:501:4b10:aa9e with SMTP id d75a77b69052e-508db2a632bmr59254511cf.13.1772681653433;
        Wed, 04 Mar 2026 19:34:13 -0800 (PST)
Received: from [172.17.0.2] ([134.128.219.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-507449630b6sm190667601cf.7.2026.03.04.19.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 19:34:13 -0800 (PST)
From: Yuanshen Cao <alex.caoys@gmail.com>
Date: Thu, 05 Mar 2026 03:34:08 +0000
Subject: [PATCH v2 2/2] pmdomain: sunxi: Add support for A733 to Allwinner
 PCK600 driver
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260305-b4-pck600-a733-v2-2-ba6bbed7d253@gmail.com>
References: <20260305-b4-pck600-a733-v2-0-ba6bbed7d253@gmail.com>
In-Reply-To: <20260305-b4-pck600-a733-v2-0-ba6bbed7d253@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, Yuanshen Cao <alex.caoys@gmail.com>
X-Mailer: b4 0.14.3
X-Rspamd-Queue-Id: 891BB20A9A8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43639-lists,linux-pm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

The Allwinner A733 PCK600, similar to A523 PCK600, is likely a
customized version of ARM PCK-600 power controller. It shares the same
BSP driver with A523. According to the BSP provided by Radxa, unlike
A523, it doesn't require reset, as well as a different pair of delay
values.

Make reset optional in the sunxi pck600 driver and add support
for A733.

Signed-off-by: Yuanshen Cao <alex.caoys@gmail.com>
---
 drivers/pmdomain/sunxi/sun55i-pck600.c | 35 ++++++++++++++++++++++++++++++----
 1 file changed, 31 insertions(+), 4 deletions(-)

diff --git a/drivers/pmdomain/sunxi/sun55i-pck600.c b/drivers/pmdomain/sunxi/sun55i-pck600.c
index c7ab51514531..1d47bbd35ced 100644
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
@@ -206,7 +209,27 @@ static const struct sunxi_pck600_desc sun55i_a523_pck600_desc = {
 	.device_ctrl1_delay = 0xffff,
 	.logic_power_switch0_delay = 0x8080808,
 	.logic_power_switch1_delay = 0x808,
-	.off2on_delay = 0x8
+	.off2on_delay = 0x8,
+	.has_rst_clk = true,
+};
+
+static const char * const sun60i_a733_pck600_pd_names[] = {
+	"VI", "DE_SYS", "VE_DEC", "VE_ENC", "NPU",
+	"GPU_TOP", "GPU_CORE", "PCIE", "USB2", "VO", "VO1"
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
@@ -214,6 +237,10 @@ static const struct of_device_id sunxi_pck600_of_match[] = {
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


