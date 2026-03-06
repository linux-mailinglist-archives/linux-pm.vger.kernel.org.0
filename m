Return-Path: <linux-pm+bounces-43833-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CDyENzPnqmkTYAEAu9opvQ
	(envelope-from <linux-pm+bounces-43833-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 15:39:47 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 49976222DDE
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 15:39:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 27102317A95F
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2026 14:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6473D3A6EEA;
	Fri,  6 Mar 2026 14:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="tP7DBUGj"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1753932CE
	for <linux-pm@vger.kernel.org>; Fri,  6 Mar 2026 14:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772807609; cv=none; b=JF2lTDD5WzpFLHqxeZkATsWMPZDsJQhWV0XSlkGGRHzmhk/xlP34rx6XEZ7Ex3KC/vOzkXlnpNIF1BdXWSo9IFPaHA/1xOg+LvxF0PjKCjG+ayaoySM02g68NGvclcNc/Q/FP6e7vulb0GWzlr19ykG2o14RdSDOsC04CAq7RkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772807609; c=relaxed/simple;
	bh=boG9G+5QbeBW6aT+kko42e7K1ue9tm4B0o/XFrV9C0g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UNK9q2hK4HFCn+LL9MHyT0uPO2h2s+sYyIdY9vxC+KFN2KAeLbBmOLCZh4pN4ZKAAyzQ/5cKEk4SRj/hSWX331heOgTlDuLf20aFOLhfBtyV1CDG2bD2aQyzRyQgUAjzPT9x8cQa5BpYqmPIBa9xQ6Nkf9x30CVzBDVWZ1Jipps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=tP7DBUGj; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-439cd6b0aedso1774423f8f.1
        for <linux-pm@vger.kernel.org>; Fri, 06 Mar 2026 06:33:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1772807606; x=1773412406; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ewnwkW8aeBnRH/Jc82nMn2tCnapdMhZRN1gE49Tbo+w=;
        b=tP7DBUGjUjSLZtlWgSnezs2sHSRbOnDBVNo8Kf4jM+JP2EkAXOKzNLCkiDy8kfpCoC
         uDaUGp/qaoIv44oKs+GhvORYaxwxAF9mSDVwkpxPR+TRVcSyvlzHkMWulkJfz8BJc5Q7
         QLwboHpwujLNaoJYpCZrnE/higmCfbIBc2wULUnJ9h4ZfRgqLrCcvHC1pBTq8e5KP3Ed
         SKPMzzusuCWiKDOOv4kypbfDp1ux0aqw22jxGC7L6LqeAPz9TdkZi1U+9pDfcTkS7mab
         Zimqr1MaFxPW06vLQ7gd//OxsLcfxwWyhSrTWUTbpAj97G9OjtBaICalGtTXi1w5P19G
         VwsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772807606; x=1773412406;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ewnwkW8aeBnRH/Jc82nMn2tCnapdMhZRN1gE49Tbo+w=;
        b=Mej2k0MuY6XRpBbCqrLPUR5ge8gbzK/4kRXQZpZrMKWkGwj5QaAd4yq3cvLM1A2ahn
         qPifhtHeM8F+BKHKk32nwAwgHgbQUOaFWHofaVkacAyU6pI0QDrTHsIkbmQmIWKaVeZB
         yW6hsJ0yJHDU+9kOOw/oGIZ//c8uxJSfPXHMT0PAgc+ChjmoNdfYLIRmu5Wh99zHHNUE
         lIWxd8SPCxyL1Q5WBRzwxzaYP8UiCxbWq42Mlg/KH0mSqyVTVVrtXa/LPdW09exRv7MU
         HVwbeD8KlFK+oFiD6988fjaVfmtsbp8PAqUiGY3XVkLwZBEzAPMLFmXZtmcZ8E+Omzjl
         Yjcg==
X-Forwarded-Encrypted: i=1; AJvYcCWCihMbr7yRZklsg1Dx9YZDb9sYuaJnsctxADYuQZW5bRmB5AXUWu9AthLZUznzofi4D7IaxInx8g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6gxDdP+ARPizaq48eKIna7ExTPszvhgQVPpLitSR9BwHAOD5C
	Y3G4ixY9hupptAMVhw9QUeKl4lX3DIQ9zDTww7cTTB8AvnnC2og5I0w2uKUj2ffY6Oo=
X-Gm-Gg: ATEYQzzPZSUszOavf6cDmBfA6nA8ijiojfEibsqudbr0VGD9yk9NNf7dd0Nb32xehaa
	CdpxBLsYjo6KRXvi9CF3zmovG0SOXMzVCb+7nUb6aFPuj/oIVqqnL6pUnjaz54FZEKPuzmnqK3J
	+al4a2J73G73K+OaiUuH8yvcbEgHNsaUVU07lXb2AYjkfyGXsyzI68Hd0XFf/lmGx5K4ct7zX1G
	1RKu5mqaE4/kEn8ACJnt1ePh/hdUi/ewwTFz5ft99EXQsl3uGrncBc/Ou4bAg4uEEsBfhJr4EI+
	G23fD3W599GSFz6/mNSGrasTzCS+us3kXSN23cYY0feK5HEkzr1rtU9TZeyPF+uEj61wlqYYrOh
	0BxbHeYfmoyIP6nCJZzwUxJ9W9c+YBfHuR9gKYHTfxO0yTmFuuRrdObR5lYFSfALeZtDZw0ko3h
	JIs5ZRQBzXiqc8nScpyE1FFJ32zAxrN9mcjS1GDf82G5tWTusmIbwqp6SLHRJ88Z9Vj47DSgP2C
	nl1YA==
X-Received: by 2002:a05:6000:250e:b0:439:bcc2:bf0a with SMTP id ffacd0b85a97d-439da65d52dmr4139837f8f.23.1772807601226;
        Fri, 06 Mar 2026 06:33:21 -0800 (PST)
Received: from alchark-surface.localdomain (bba-86-98-192-109.alshamil.net.ae. [86.98.192.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dad8daf2sm4635281f8f.2.2026.03.06.06.33.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 06:33:21 -0800 (PST)
From: Alexey Charkov <alchark@flipper.net>
Date: Fri, 06 Mar 2026 18:33:04 +0400
Subject: [PATCH v2 04/11] regulator: bq257xx: Make OTG enable GPIO really
 optional
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260306-bq25792-v2-4-6595249d6e6f@flipper.net>
References: <20260306-bq25792-v2-0-6595249d6e6f@flipper.net>
In-Reply-To: <20260306-bq25792-v2-0-6595249d6e6f@flipper.net>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chris Morgan <macromorgan@hotmail.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 linux-pm@vger.kernel.org, Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1089; i=alchark@flipper.net;
 h=from:subject:message-id; bh=boG9G+5QbeBW6aT+kko42e7K1ue9tm4B0o/XFrV9C0g=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWSuerqk/mJMZptu1TL5jRs3fw/c58CRevt1WfZn6+7bM
 jwMy2xfdExkYRDjYrAUU2SZ+22J7VQjvlm7PDy+wsxhZQIZIi3SwAAELAx8uYl5pUY6Rnqm2oZ6
 hoY6xjpGDFycAjDV72Yy/C+NNJ6xk/93f+QD99C2sOJFtxI7tV29/FuWS1odXLn5RybDP73JDGW
 BO23s9R5Fmb3dezk74ouARcYqC9UIC/PLqdlNDAA=
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
X-Rspamd-Queue-Id: 49976222DDE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[flipper.net,quarantine];
	R_DKIM_ALLOW(-0.20)[flipper.net:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43833-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,hotmail.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[flipper.net:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alchark@flipper.net,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,flipper.net:dkim,flipper.net:email,flipper.net:mid]
X-Rspamd-Action: no action

The bindings describe the OTG enable GPIO as optional, but the driver
gets upset if it's not provided in the device tree.

Make the driver accept the absence of the GPIO, and just use register
writes to handle OTG mode in that case, skipping the error message for
-ENOENT.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 drivers/regulator/bq257xx-regulator.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/regulator/bq257xx-regulator.c b/drivers/regulator/bq257xx-regulator.c
index 674dae6109e9..0bb58ab4b8d4 100644
--- a/drivers/regulator/bq257xx-regulator.c
+++ b/drivers/regulator/bq257xx-regulator.c
@@ -126,6 +126,12 @@ static void bq257xx_reg_dt_parse_gpio(struct platform_device *pdev)
 	of_node_put(subchild);
 
 	if (IS_ERR(pdata->otg_en_gpio)) {
+		if (PTR_ERR(pdata->otg_en_gpio) == -ENOENT) {
+			/* No GPIO, will only use register writes for OTG */
+			pdata->otg_en_gpio = NULL;
+			return;
+		}
+
 		dev_err(&pdev->dev, "Error getting enable gpio: %ld\n",
 			PTR_ERR(pdata->otg_en_gpio));
 		return;

-- 
2.52.0


