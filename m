Return-Path: <linux-pm+bounces-43835-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MCRRFGvnqmkTYAEAu9opvQ
	(envelope-from <linux-pm+bounces-43835-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 15:40:43 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A3214222E2A
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 15:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C6DC83183FF6
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2026 14:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F6F3ACF1F;
	Fri,  6 Mar 2026 14:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="EweMiyHU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BCE3A9D8B
	for <linux-pm@vger.kernel.org>; Fri,  6 Mar 2026 14:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772807612; cv=none; b=GxtAHEHOO+wRyeJAHQOPyX7hILVHM6zKq+9ceLqEqaK8nfFLNPclqcgO7Td85AJHseV9n/fWOWoYCXMaS2+wUzvO5DDiJAXgLQkYUxXc+YGMt+lm3QBawAVMH5wOe1IZ4LgTwMDOWcAWi0lJ3LOihyI4dJkxIKM8vjj3qu45fq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772807612; c=relaxed/simple;
	bh=rZeSH+p/sWb94+YtWuBoX7zwjk1MlkPbjBLWjAkhzPY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mcn+e/B8chpdDrDwnxYUDVm3JKrBgclbM9Wi/4xUHCn+eQ2ZcAcxVmyVRpfHf16dmkRRQ14G9i8F+DVbmtbukR1drzjDY7kKo7QsVGKzIHRbvp//I5CmkhDjjfUbGGuaZdUihVySGNFqyTIDfV6zhE8+QFCudBvkGFlXglOr+eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=EweMiyHU; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-48375f10628so61742385e9.1
        for <linux-pm@vger.kernel.org>; Fri, 06 Mar 2026 06:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1772807609; x=1773412409; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I8FV20nY94XdgsSpk3nNKgaUktiutL3Fj9XNodWc9Os=;
        b=EweMiyHUqlgtoxy20WJ+dlyC8cMiOwddivymdEGCf6tD/xxzAgRM06PnJCTRGti1L0
         DvW4y3ocSuI9+d/9RRr2IZds+u7CCR++RvvhggHJoRruYqVESDJt5WMmJcUlvPmZpdt9
         XSEie3HniWPZ/yFd0ZoTjyJX/jx5yZkoK95PGzcLTo9jjn3wpwRM1aRq3adFhK+bCIpM
         fvrxAbG/ETbBIqUWrOPb/YKmyx0yh3kBd3rRysF9VmCij0bcIKmd4lxAD69fgZT8P2Z9
         aHYjcf9N8c4EnubEysahCpi3WXPMia1qtXI5faXI+uSgc8+gnH08L+9JGhlZKPMaxgBD
         Ry4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772807609; x=1773412409;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=I8FV20nY94XdgsSpk3nNKgaUktiutL3Fj9XNodWc9Os=;
        b=fffk+tH33anuqmIi83dDpaFsujeru5MQ143loWDRcm3K9iRPArkEmzh1NMM6YeJTz2
         afzWFPdR4luxiiDD60TJgDROBPdwmXBzy6RzQZ4jS2OJjZpZnSayx4nIPbPHe941owCA
         p+0W2NFjCHCnzCc7roQDiFe/cizXFL9oCjuMhsfcDXBKIVJaOxtGKZ8HgLmfQ1pYjKRH
         yj6ruTNVTZJfx3Jjjh3cZZ6dOs10k0ARXDlLybROQOZ1lqfIUzC+7kdzESZhdcDCfcG4
         Vp5Bqg7kcGpRYQ2KrV7tBVMJgu7TNztopvxp3R4FBsrDFZBzmd8N/5XlSanssy0ZHMwn
         DWAw==
X-Forwarded-Encrypted: i=1; AJvYcCWpAkyfh/AcjxMpg66VSVRRoMLIv7zGYDgjLQi4WPvUn6fN+hYmb53yMhDVN1znchs0LA7K06UeBw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzbmMouvqYCPnGeyRBvyyXIEVFhUlRPdykNqKFKf+leKuZgUwFP
	MMiw7uRlRzbKg/286sfN0INstuP5gkPzM3v59L73h55gTI7iYtN9qUZLNWrvMWfAYCc=
X-Gm-Gg: ATEYQzxgFbfUx/cAbEJ0hzZDnwnx0oT8A1k58+XHxDWDhB93LQueHWsMBYvS/GaVwyO
	ffTAuHLf0LbZyhXJygqi2c1sY53I0SWXSaNc2DgZeZkqvsG9C/OA7DQ5BgIpbKBwI6kyB74snxM
	c5SqpxhrjoFjTpldDRaLyE+qHdb5s+mF+HiXBm4OpgpAM8y8Y6ASFCHUp3AAvFxU+H9qE1N/P2F
	s3OJt1XP8+sVnyC5ySx9S+4/QtzZcxKAS67hoosjwKy9bUV05BkoEKPHO84LeTwye1aKxibPQMb
	LWOPNodBhaGazVvKVNUKJrqZgaWYUHY4cEdwGpl3Pd8ZFuLB98jjGRn4hJZ9jOb/G+RsS6uxgJe
	iMMPbt/dvqIOasFtpEi9UIEm3YkVqCwIZKC5gMKPHR0dwgDglKQCNdj4na0gnVWG74p6xzsesHm
	TyifcVMzRP8/nPaoR02gPntLWvRuMElSzmgSBeCCTl4Cs2pdfYLdnx+vgKKHLHOF3cjDTrYa1fj
	t6R5aDaHlYVz/C7
X-Received: by 2002:a05:600c:3596:b0:483:6f37:1b51 with SMTP id 5b1f17b1804b1-4852697955fmr34852995e9.23.1772807608970;
        Fri, 06 Mar 2026 06:33:28 -0800 (PST)
Received: from alchark-surface.localdomain (bba-86-98-192-109.alshamil.net.ae. [86.98.192.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dad8daf2sm4635281f8f.2.2026.03.06.06.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 06:33:28 -0800 (PST)
From: Alexey Charkov <alchark@flipper.net>
Date: Fri, 06 Mar 2026 18:33:07 +0400
Subject: [PATCH v2 07/11] power: supply: bq257xx: Consistently use indirect
 get/set helpers
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260306-bq25792-v2-7-6595249d6e6f@flipper.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3364; i=alchark@flipper.net;
 h=from:subject:message-id; bh=rZeSH+p/sWb94+YtWuBoX7zwjk1MlkPbjBLWjAkhzPY=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWSuerqkvnqiT8+3o1lGnJ6+pseXrQtbEfuxb0n2fe6/l
 S8sK9O3dExkYRDjYrAUU2SZ+22J7VQjvlm7PDy+wsxhZQIZIi3SwAAELAx8uYl5pUY6Rnqm2oZ6
 hoY6xjpGDFycAjDVKZ8ZGWbal1zZket5rlD8nmCb+NMpAdHSdU9eCk+YHR+g8jKtiI3hf/7UMw0
 PA/9WlbM6JSx4vmg7b9/mhi+rZa+uy3oV/ebHHy4A
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
X-Rspamd-Queue-Id: A3214222E2A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[flipper.net,quarantine];
	R_DKIM_ALLOW(-0.20)[flipper.net:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43835-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,hotmail.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[flipper.net:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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

Move the remaining get/set helper functions to indirect calls via the
per-chip bq257xx_chip_info struct.

This improves the consistency of the code and prepares the driver to
support multiple chip variants with different register layouts and bit
definitions.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 drivers/power/supply/bq257xx_charger.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/power/supply/bq257xx_charger.c b/drivers/power/supply/bq257xx_charger.c
index e14dd16f9d08..deb60a9bd222 100644
--- a/drivers/power/supply/bq257xx_charger.c
+++ b/drivers/power/supply/bq257xx_charger.c
@@ -30,9 +30,15 @@ struct bq257xx_chip_info {
 	int (*bq257xx_hw_init)(struct bq257xx_chg *pdata);
 	void (*bq257xx_hw_shutdown)(struct bq257xx_chg *pdata);
 	int (*bq257xx_get_state)(struct bq257xx_chg *pdata);
+	int (*bq257xx_get_ichg)(struct bq257xx_chg *pdata, int *intval);
 	int (*bq257xx_set_ichg)(struct bq257xx_chg *pdata, int ichg);
+	int (*bq257xx_get_vbatreg)(struct bq257xx_chg *pdata, int *intval);
 	int (*bq257xx_set_vbatreg)(struct bq257xx_chg *pdata, int vbatreg);
+	int (*bq257xx_get_iindpm)(struct bq257xx_chg *pdata, int *intval);
 	int (*bq257xx_set_iindpm)(struct bq257xx_chg *pdata, int iindpm);
+	int (*bq257xx_get_cur)(struct bq257xx_chg *pdata, int *intval);
+	int (*bq257xx_get_vbat)(struct bq257xx_chg *pdata, int *intval);
+	int (*bq257xx_get_min_vsys)(struct bq257xx_chg *pdata, int *intval);
 };
 
 /**
@@ -489,22 +495,22 @@ static int bq257xx_get_charger_property(struct power_supply *psy,
 		break;
 
 	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
-		return bq25703_get_iindpm(pdata, &val->intval);
+		return pdata->chip->bq257xx_get_iindpm(pdata, &val->intval);
 
 	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX:
-		return bq25703_get_chrg_volt(pdata, &val->intval);
+		return pdata->chip->bq257xx_get_vbatreg(pdata, &val->intval);
 
 	case POWER_SUPPLY_PROP_CURRENT_NOW:
-		return bq25703_get_cur(pdata, &val->intval);
+		return pdata->chip->bq257xx_get_cur(pdata, &val->intval);
 
 	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
-		return bq25703_get_vbat(pdata, &val->intval);
+		return pdata->chip->bq257xx_get_vbat(pdata, &val->intval);
 
 	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX:
-		return bq25703_get_ichg_cur(pdata, &val->intval);
+		return pdata->chip->bq257xx_get_ichg(pdata, &val->intval);
 
 	case POWER_SUPPLY_PROP_VOLTAGE_MIN:
-		return bq25703_get_min_vsys(pdata, &val->intval);
+		return pdata->chip->bq257xx_get_min_vsys(pdata, &val->intval);
 
 	case POWER_SUPPLY_PROP_USB_TYPE:
 		val->intval = pdata->usb_type;
@@ -632,9 +638,15 @@ static const struct bq257xx_chip_info bq25703_chip_info = {
 		.bq257xx_hw_init = &bq25703_hw_init,
 		.bq257xx_hw_shutdown = &bq25703_hw_shutdown,
 		.bq257xx_get_state = &bq25703_get_state,
+		.bq257xx_get_ichg = &bq25703_get_ichg_cur,
 		.bq257xx_set_ichg = &bq25703_set_ichg_cur,
+		.bq257xx_get_vbatreg = &bq25703_get_chrg_volt,
 		.bq257xx_set_vbatreg = &bq25703_set_chrg_volt,
+		.bq257xx_get_iindpm = &bq25703_get_iindpm,
 		.bq257xx_set_iindpm = &bq25703_set_iindpm,
+		.bq257xx_get_cur = &bq25703_get_cur,
+		.bq257xx_get_vbat = &bq25703_get_vbat,
+		.bq257xx_get_min_vsys = &bq25703_get_min_vsys,
 };
 
 /**

-- 
2.52.0


