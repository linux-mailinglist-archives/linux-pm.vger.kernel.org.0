Return-Path: <linux-pm+bounces-43512-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SDnjNhoCp2k7bgAAu9opvQ
	(envelope-from <linux-pm+bounces-43512-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 03 Mar 2026 16:45:30 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D462F1F2E15
	for <lists+linux-pm@lfdr.de>; Tue, 03 Mar 2026 16:45:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 82855308D595
	for <lists+linux-pm@lfdr.de>; Tue,  3 Mar 2026 15:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3915A4963AE;
	Tue,  3 Mar 2026 15:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="6v6wjDFM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E905349218D
	for <linux-pm@vger.kernel.org>; Tue,  3 Mar 2026 15:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772552002; cv=none; b=M+V+OiewJiCvt+IuYFtSaTx5YyaUibqpoMlneFx82TJ3CESnllXaQvjSjbhFrnMbFSMNDNvtFOYUzbuXRyZfbI2J7dXNOMMuMJUFoJZW+n3mqvATusfFA9IhiPzOfDdqj/oy/OWFnCxNtfEUc+3M1lqUZw/4oivkV6mLud2oKpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772552002; c=relaxed/simple;
	bh=fqgV7d8c4BXshhw1gqL0HWfj9aw9iK9J0f1QWTNLAG8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bqWr0L05Xir2gChbHsl1doJzUHW5XGkhqls2lY+/TX6oM1vHjZg9OZtXRY79vczEcHjKAXFXo0O8Cy7ZoVrvc2y6tAUvomNOoEMmRybx5l3P83r4utQM3JvV+bR8/NhbyROsj868Wckab9Nd9IJ3hHifmAnXKOlHab1f2EZ/wLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=6v6wjDFM; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-439a90f194bso2407227f8f.0
        for <linux-pm@vger.kernel.org>; Tue, 03 Mar 2026 07:33:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1772551998; x=1773156798; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G3vNgmqYmO5UknTO3x1kCPV7VqUspCxEKfK8SFuWCw4=;
        b=6v6wjDFML2kSoar097A1ilQQaeZWCO1xsLsZCZo4rp0U7Pi3tz0RjNeoMIabJKMp9W
         +2hH1wZkn3nPzu4TqrcXDCXhay91goZks6+yfoHD4yRv6o2QnPB48vdCkL8at/triQlr
         /36QobsF8AABOKZj2qH6Ucv4rEqNbU8ArdTA0J759qzcgmUGCEP4riho8grtmB0h9vwL
         egIIYOWXFjf/6GFWBy8ODksnRJOwyyQg23q6Vi49o0GiKdc2BfumHNswFSnLwbCZv4e8
         FRp5ukQ9EEqIYp37YIHO/34YBjy5l7GRAjBF+OGAxru5HQnrSNJdkx6anNiwYvlRA2BN
         Eh5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772551998; x=1773156798;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=G3vNgmqYmO5UknTO3x1kCPV7VqUspCxEKfK8SFuWCw4=;
        b=iytVZsFxb2rXr2lwP2oCkvp3yDgwhjMLB2PGM8AUipEfdj523lh+KnLOUVYS2PV916
         xow0lPUm9fUe4j3R+JUqjL2TrLn3bM7hmEADEsqAA+1r0TutwEUnhJU4z9LXIR6ieOQL
         IOj/9rdgnQUXQgojIrllO/xOO0Z0e3M9r7rNCCVu6YoY1bnUF2z3zC3hE9CCCsXVlMOc
         RlIcVddYxtfeievFKYN2AQyAL+iYMlNRxS+heepYFvc3rrRZyGw++SYc9L5QdiWqfn9N
         Fch5BcVFXREibRQOtTG34B46wlIgy/HsG0nc4E/RigFg8v5ARnOi9QGXQeQDulO3IU/I
         OXdA==
X-Forwarded-Encrypted: i=1; AJvYcCUAgnuqPe1kzKbVhami5Jff09quNaqkPriUtW1R1TKtX03N35CaGXCJjxBWfrBslllFU18ikQbbrA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8OeoCHs8pP0b9lWXIYNgIrLdg2Hd8biz9iKT6VaEZsjTbzreZ
	Vm/etmhKBOadGwaJyyuinR9LcK0A0w6siyHzgvpu0uP0sBLgQIIFRPHcfElO6NBKSbM=
X-Gm-Gg: ATEYQzzm2a97/tvXpFBWocgtjCtz4gopsh1j3JoqQA5+nMw8sz/1hNah5C/Kpd8eWKL
	eIOBRT4C8Xr7fHGEpG5Wd7QO71w4IRKO8UBUiUd34XK78rtX8u/7vnEZR+/ce6uI+dfNSVXHiyK
	+5Dn+YkoZ+D6XI7zrng5isFm7HMPe63HFs9UHn8+Od4XA0+JpxaEMLRuJ0RcCpY6CsDdEHtDOC7
	SremEaLrTgOlPEfHnJHeW2HzKY0iMKdOeAHo0m9x+xbwkYTctwSv8pqpaCRmtywGH6q/nexrX1W
	K/U61csODHipn+iz65AF01xRXSs9XvcK0wlJy8OMYKgnpGXfNIbkdVEqjhgv5Qii0ToLRZYeb3P
	SNJazHv2hLfpAlCRdTEVpq+Tx5hK9yYuzY8AloJHrtY9BdY+C7gLzy0B31pKwYcoFIagT4Gn83Z
	GkQizODcWXefjwyhof6A5Ht0OtEPOQ90oUmo8CQ+5gYha4xAJd4os4gZLkg4Rs2FhDx7U17TL3j
	xg=
X-Received: by 2002:a05:6000:2c0b:b0:439:ae3f:9405 with SMTP id ffacd0b85a97d-439ae3f976dmr19319559f8f.59.1772551997972;
        Tue, 03 Mar 2026 07:33:17 -0800 (PST)
Received: from alchark-surface.localdomain (bba-94-59-44-101.alshamil.net.ae. [94.59.44.101])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439b55d15besm19799447f8f.30.2026.03.03.07.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 07:33:17 -0800 (PST)
From: Alexey Charkov <alchark@flipper.net>
Date: Tue, 03 Mar 2026 19:32:53 +0400
Subject: [PATCH 08/11] power: supply: bq257xx: Add fields for 'charging'
 and 'overvoltage' states
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260303-bq25792-v1-8-e6e5e0033458@flipper.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2470; i=alchark@flipper.net;
 h=from:subject:message-id; bh=fqgV7d8c4BXshhw1gqL0HWfj9aw9iK9J0f1QWTNLAG8=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWQu+68m4TXJxnziurrwTi+7asHlm2ZcfFB01O3RxuQ/U
 xOi7d/P65jIwiDGxWAppsgy99sS26lGfLN2eXh8hZnDygQyRFqkgQEIWBj4chPzSo10jPRMtQ31
 DA11jHWMGLg4BWCqiywZGc42fXUpn3t4t+XRdMY5jwIkTYVeHbZr/PHQScq9s6VcP4LhfynngW/
 TJh58teSL2moHd6Gr69+az1f6euXuiaBesxT79fwA
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
X-Rspamd-Queue-Id: D462F1F2E15
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[flipper.net,quarantine];
	R_DKIM_ALLOW(-0.20)[flipper.net:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43512-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,hotmail.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[flipper.net:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alchark@flipper.net,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[flipper.net:dkim,flipper.net:email,flipper.net:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

The driver currently reports the 'charging' and 'overvoltage' states based
on a logical expression in the get_charger_property() wrapper function.
This doesn't scale well to other chip variants, which may have a different
number and type of hardware reported conditions which fall into these
broad power supply states.

Move the logic for determining 'charging' and 'overvoltage' states into
chip-specific accessors, which can be overridden by each variant as
needed.

This helps keep the get_charger_property() wrapper function chip-agnostic
while allowing for new chip variants to be added bringing their own logic.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 drivers/power/supply/bq257xx_charger.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/bq257xx_charger.c b/drivers/power/supply/bq257xx_charger.c
index deb60a9bd222..951abd035fc5 100644
--- a/drivers/power/supply/bq257xx_charger.c
+++ b/drivers/power/supply/bq257xx_charger.c
@@ -64,8 +64,10 @@ struct bq257xx_chg {
 	struct bq257xx_device *bq;
 	struct power_supply *charger;
 	bool online;
+	bool charging;
 	bool fast_charge;
 	bool pre_charge;
+	bool overvoltage;
 	bool ov_fault;
 	bool batoc_fault;
 	bool oc_fault;
@@ -99,8 +101,10 @@ static int bq25703_get_state(struct bq257xx_chg *pdata)
 	pdata->online = reg & BQ25703_STS_AC_STAT;
 	pdata->fast_charge = reg & BQ25703_STS_IN_FCHRG;
 	pdata->pre_charge = reg & BQ25703_STS_IN_PCHRG;
+	pdata->charging = pdata->fast_charge || pdata->pre_charge;
 	pdata->ov_fault = reg & BQ25703_STS_FAULT_ACOV;
 	pdata->batoc_fault = reg & BQ25703_STS_FAULT_BATOC;
+	pdata->overvoltage = pdata->ov_fault || pdata->batoc_fault;
 	pdata->oc_fault = reg & BQ25703_STS_FAULT_ACOC;
 
 	return 0;
@@ -471,14 +475,14 @@ static int bq257xx_get_charger_property(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_STATUS:
 		if (!pdata->online)
 			val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
-		else if (pdata->fast_charge || pdata->pre_charge)
+		else if (pdata->charging)
 			val->intval = POWER_SUPPLY_STATUS_CHARGING;
 		else
 			val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
 		break;
 
 	case POWER_SUPPLY_PROP_HEALTH:
-		if (pdata->ov_fault || pdata->batoc_fault)
+		if (pdata->overvoltage)
 			val->intval = POWER_SUPPLY_HEALTH_OVERVOLTAGE;
 		else if (pdata->oc_fault)
 			val->intval = POWER_SUPPLY_HEALTH_OVERCURRENT;

-- 
2.52.0


