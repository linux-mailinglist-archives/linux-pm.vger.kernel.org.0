Return-Path: <linux-pm+bounces-43508-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QLQAKa7/pmk7bgAAu9opvQ
	(envelope-from <linux-pm+bounces-43508-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 03 Mar 2026 16:35:10 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D5481F2BB2
	for <lists+linux-pm@lfdr.de>; Tue, 03 Mar 2026 16:35:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D4F62305A870
	for <lists+linux-pm@lfdr.de>; Tue,  3 Mar 2026 15:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF114492532;
	Tue,  3 Mar 2026 15:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="ZqqXRqwC"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42068492185
	for <linux-pm@vger.kernel.org>; Tue,  3 Mar 2026 15:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772551990; cv=none; b=iI4eqmaI2xENzzfL5dR27aPxSOyaW58XQJddL1gh1D4AbTiAYP7odnnAU1VJ0PmD/J8YfF5gcNTVhk0vfK4IQg8gg2gLwA2VX0e2claWvXj3zfzWxCfVWkJPfa7YnlXbqM98Vtr5BaeeTDt7rnJJhOy2I3S1XZyQhnG8yo0JSYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772551990; c=relaxed/simple;
	bh=boG9G+5QbeBW6aT+kko42e7K1ue9tm4B0o/XFrV9C0g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rfnA7J8cixFnL0HwlZW/CgS+QQRQHz17IDpQONpq26pXCYqn1wiIzdZunzMqrWLy/X0EYRkQPavWT5fMtcq4GjKg1a9nt+e8dCRPLmEEiqjajLwLY7PG058LrwYjZgt+LRD+0KkXnLSj/h5RhDsbuEvCIme7HBcfCA6oW8B147c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=ZqqXRqwC; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-439b8a3f2bcso1787467f8f.3
        for <linux-pm@vger.kernel.org>; Tue, 03 Mar 2026 07:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1772551988; x=1773156788; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ewnwkW8aeBnRH/Jc82nMn2tCnapdMhZRN1gE49Tbo+w=;
        b=ZqqXRqwChZtIdiLdJyzuFGh5FQpomexaL/qVXH2p5pJqAfWAhR5qXouJtpFb67XMEq
         7k7U96tpXAiYNIskJEG3c24fOBok8srlEbwuAhOpxlFDVYurtjGTpRTxwADV0iobUX4B
         S4TPmA40IwWMqEWMjRpGZx2bdAgyF9gBv4Y18rMExgRO3LKGnoBc5xMJxpfm3aYQnOF6
         zs4UEhG5cHkmVbsyEbdxdPcSFBRZFQC1nMGv9VRABlitxvvGBQ7hiSe10FKK5HEvmjUN
         KtIzMftfq/S/JiXCVI4UyLSgoNKo9xfNAu5XS9KYOr+iCHeC+TNK8X/SEQv5ZTtjwLAm
         gpsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772551988; x=1773156788;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ewnwkW8aeBnRH/Jc82nMn2tCnapdMhZRN1gE49Tbo+w=;
        b=Lcd0U9gVZvgQ/pD5S+o64DUmSmXFEoEBQ+sQqAn8JF1Ci31jh2SoxLiTiEMuZVih60
         8gtMCWwjDd8LtDpq2O+KjGlX3BdA9LRThKn6GLpH+nyuc0HTKxMVlzReLN5qO5OzRmUn
         Knl2dEK7d+ZqavBqnzD3ABxp/OfiKZ+EOMV0oZVvPTqaN2MULj6NL0hvDU0iguqWQKEG
         4nL//ZlTQvrhhpPfP9baGT2RsjH+PnVBZ3ey7mQ7PiNFWspKFJ3ZSWwzh+pL9R7PJtDH
         h2mLEATsz4DMT8rymXIve7yFDLX6nMQY+5ZuU1SoINnu7pyMuxhOOXI2djNgCqJGPtyO
         1ROg==
X-Forwarded-Encrypted: i=1; AJvYcCW2rjDRs2U13R0Ua579MDrPKDRsqnY/v9SPLlkB4jza8uwqyyxzmj5sQDiLVFi03BfVjYJaIrdNIA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwOVO5svSFt3AwLL7s5ULxHubA7WilOwJv6c5lsZvbSIVxzrAXo
	WiHqvGZO/3C/wrn4jQS7GE3d06RlnbijE3nOXoTdmLlJ1vVtWyGwQwpQCl3Q30hwmB0=
X-Gm-Gg: ATEYQzxdH6XTMRPyA9Il4PIdp2bIJmYSkDl1rh5MspdOUxcHi3xHoKEugQTlBUJEDhq
	HaI1vduACre7Jy+ZvWgI27P+a4zRRhWirsQE7+bw3Zu+AHH2M+E3rcLwyOwSdO7Ez/oAb/P2Hmy
	MExxozAdCHJ/BSGJmO+15Sns/s38Vj+zmeD/mBJEp35LuoQFLhdj+tIHNlueS/dT2hc4i9xh/dL
	SrR77uGHGlJYHdSVqpCKHXmX5XDmx1bkduOXENP1Xr4Y7dhCV+D1v0kIezPRSkeXx0DLz67eH7a
	W3Nq/2pvRLX6ERJWY8/VBy1c/Bbl+telN3JwU3y1q9FVmGlGEsQMvtZKIbryPzOEvnahTNgGYRh
	d9m1W5uZ9J/9vvbOvsarzP9u7iLOZEUTuqrCDZ2blb3tCSNsQxZy6NIQiCuz+YCqLx50d9wsCpY
	k6SdturSToBqNUF2V3pfpIRAI4KfcFwuMj6WioiDjwd+13BqRvUuu5yX97DcwmDDX7//KAU3kji
	V8=
X-Received: by 2002:a05:6000:26cb:b0:439:b3d2:376c with SMTP id ffacd0b85a97d-439b3d243f3mr15987799f8f.12.1772551987668;
        Tue, 03 Mar 2026 07:33:07 -0800 (PST)
Received: from alchark-surface.localdomain (bba-94-59-44-101.alshamil.net.ae. [94.59.44.101])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439b55d15besm19799447f8f.30.2026.03.03.07.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 07:33:07 -0800 (PST)
From: Alexey Charkov <alchark@flipper.net>
Date: Tue, 03 Mar 2026 19:32:49 +0400
Subject: [PATCH 04/11] regulator: bq257xx: Make OTG enable GPIO really
 optional
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260303-bq25792-v1-4-e6e5e0033458@flipper.net>
References: <20260303-bq25792-v1-0-e6e5e0033458@flipper.net>
In-Reply-To: <20260303-bq25792-v1-0-e6e5e0033458@flipper.net>
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
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWQu+68WURDMHNEhvUVgxyKjhqM/b4oJrBCz5J+xo/7KW
 ilWBxnbjoksDGJcDJZiiixzvy2xnWrEN2uXh8dXmDmsTCBDpEUaGICAhYEvNzGv1EjHSM9U21DP
 0FDHWMeIgYtTAKbadz3D/wCzdraafc/1beefL2ze8fVk9SHz3do/1u2askHu3Y8Xhi6MDLvKZ0+
 2Wrq4UtDP/lCJg1Je6F0xN7cu40W1RksM3398zg4A
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
X-Rspamd-Queue-Id: 4D5481F2BB2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[flipper.net,quarantine];
	R_DKIM_ALLOW(-0.20)[flipper.net:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43508-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,hotmail.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[flipper.net:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alchark@flipper.net,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[flipper.net:dkim,flipper.net:email,flipper.net:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
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


