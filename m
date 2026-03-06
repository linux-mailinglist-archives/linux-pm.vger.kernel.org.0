Return-Path: <linux-pm+bounces-43836-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sGHdFWjnqmkTYAEAu9opvQ
	(envelope-from <linux-pm+bounces-43836-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 15:40:40 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C5EEA222E23
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 15:40:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F18A73190CE9
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2026 14:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 099213AEF2E;
	Fri,  6 Mar 2026 14:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="M3VWppeu"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559773AE1B7
	for <linux-pm@vger.kernel.org>; Fri,  6 Mar 2026 14:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772807614; cv=none; b=kjP+M13i2nrugPtqMxUSTB8Nn4WqnZtJKsZg8EBqH3NM1yM5lABZt5FePrsE5+0siP8dTk0bVTLhgZxmBeJzTRgUVmLz/sJn29rjYn93o/TiO/cxNe9uZUXYZ3Cfp4om+FC9lra54Oauue9VZhsY7brIF+IFitqxgocR5VTT+gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772807614; c=relaxed/simple;
	bh=fqgV7d8c4BXshhw1gqL0HWfj9aw9iK9J0f1QWTNLAG8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WuZQaCTVb59e+1I5iW6LAiwv1+YyRAyPlbyA2yhQ0ETGtCQwUW83VsNWS4WXPul9hDCQ6xii+PpuKXaqSa9y+cO6nwerhUiammyDkj3kV76T5bczSOrAXrVJuLT4wjEG75nY/0PfNICgmanyaMWtexRsUEt2ClLcv1QduFWs5II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=M3VWppeu; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-439b9b1900bso4196776f8f.1
        for <linux-pm@vger.kernel.org>; Fri, 06 Mar 2026 06:33:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1772807612; x=1773412412; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G3vNgmqYmO5UknTO3x1kCPV7VqUspCxEKfK8SFuWCw4=;
        b=M3VWppeu2iu1VSrF81rV3Vur5kqBEC77COlnXSODDnsf2ebWoAMF7KheRGvLgMgJJ0
         1LVQ/QCdoehA79qTU1NtHrkkPijnIy9BcWUrGG3PuFYwqe9zgE2uC2XuGABjorgrfknG
         jDHg3LWfLyujGtdjuRnvSaiKvdC5T45xt4QmgWCgxj+usQX0Q9JPv/bT/RQz2U9kdVnV
         GKyofWuiqDALh6xiPIGtODsgITsRTf1RyA+VbGu4+hiBxntcMXO2g+aRdj9JoV9EdagD
         z3THwDKkgK75UKVgCNQb4xqjzFa3ZtIVg7yZbTjhyj3dHMKznFN3rtQ8n0xAwaQEWFiS
         RMwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772807612; x=1773412412;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=G3vNgmqYmO5UknTO3x1kCPV7VqUspCxEKfK8SFuWCw4=;
        b=w3fdUSfJMlDT2RxJUvjadVaeHgjjroYTLrQkSYmNcU2bz5Do1o3bImYvqzeLoYLPQo
         rEvA8o3ay3Bu5QkrXo8quXgCEcr8d2fgSysmUEALC0Kk8hO6j6g5jKCSDfPlMLG6UOIx
         QZIalY6QIWB9UJiXHNXeTcslDA1nWpsDBqTKmaK/npfQRPJxK8KfE8vYzk5nHS/bZZi4
         ZrBiT1goqi+N7Q3HKenz6IyB2XtHK/K3Dy9DGzApOBXUiX5jYOdRwxZrEOgKoOCdBcf/
         LC1AbuzHIjpO18RAtKREo6ICCN4MMy+Rud5XC1ZkL7mHRUf0l+qZaxtSpnWzHZ+v/uHP
         5w2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWBxJqjjq6UIVehITB47vLGBpjjJiH/ZE79FntzkNsdA2HarB7zaYFAm+f7EzB+b+vi+IXXlgPzFA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwsgcsxLM0ECAkUP7P8V5xifUx3v3TBu0vPZCBvg9rax7SMfLye
	K8PsSHYzwhRI8HmBFS6QMJJhRTaEXmFLLQQFAmIGyw/1w6hllzV4T+2XVuMOPMUX+3A=
X-Gm-Gg: ATEYQzyS8SOVIkykaiePCrcjZ6igV2K/gfiPZG6L29wcJN+NEmk3B7BTL4dE9g+JN2x
	Uzj0QI4EzbaXPAUaYhN4byA04AZ2tdwD+9HtzoCNCHp9Xgd6I/4oyxTN1M1TN8deu2+Q42k8VOH
	aCoEszEvMh4TY6By1n5mCsBMyDnC4GNYIk+eF4mkDoThmDpiqWdGB5iGZiPIfnWPs8lHPLHXBHX
	bUrmwKRFqyeVAI/QQEYSi74A7ttKMeb4wOb6f3BTxl1UbMkhEeb+IIsAtQ7D5keac9vWDSx3mAz
	a5UNPlNW1bJY4KgDHWd2XBMNx4Hg7JvLS1f8eSrkJ+wtKhLIHJKOluD3Rbkr5wXObqNqAAQEQwd
	rfJPt1ms23ZB7mBrSzhQRN3JGcspEwuLcN6rg2YGFxWS9T2mdFnQU9n1kiYK3kxJ2dKgy8B1VlK
	8+m64pS6QlMb0Zmpo4RXviZNMikh6jAKWJOZx5NSxqAPHxiCZETU+RaJxBs4xM6QQl74Jp7CZkR
	jFUog==
X-Received: by 2002:a05:6000:1785:b0:439:af25:e4ea with SMTP id ffacd0b85a97d-439da66c26fmr4336958f8f.25.1772807611534;
        Fri, 06 Mar 2026 06:33:31 -0800 (PST)
Received: from alchark-surface.localdomain (bba-86-98-192-109.alshamil.net.ae. [86.98.192.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dad8daf2sm4635281f8f.2.2026.03.06.06.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 06:33:31 -0800 (PST)
From: Alexey Charkov <alchark@flipper.net>
Date: Fri, 06 Mar 2026 18:33:08 +0400
Subject: [PATCH v2 08/11] power: supply: bq257xx: Add fields for 'charging'
 and 'overvoltage' states
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260306-bq25792-v2-8-6595249d6e6f@flipper.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2470; i=alchark@flipper.net;
 h=from:subject:message-id; bh=fqgV7d8c4BXshhw1gqL0HWfj9aw9iK9J0f1QWTNLAG8=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWSuerrE+sdFtp9H3jRtXiPzfcbnQ3pfbz9Qqv8kdjLSo
 iY+8eYU5Y6JLAxiXAyWYoosc78tsZ1qxDdrl4fHV5g5rEwgQ6RFGhiAgIWBLzcxr9RIx0jPVNtQ
 z9BQx1jHiIGLUwCm+hI7w//4xZlTLh4QOrJsF2vvTL2z3oti+w48/Ps03T/lQMxGnR2qjAwH/y8
 X0zBNN3I747Xmq8qfHQXq0bvKmxcfKNubLP7pRBITAA==
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
X-Rspamd-Queue-Id: C5EEA222E23
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
	TAGGED_FROM(0.00)[bounces-43836-lists,linux-pm=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[flipper.net:dkim,flipper.net:email,flipper.net:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
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


