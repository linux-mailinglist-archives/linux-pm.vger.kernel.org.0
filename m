Return-Path: <linux-pm+bounces-43509-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oAT3J8D/pmk7bgAAu9opvQ
	(envelope-from <linux-pm+bounces-43509-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 03 Mar 2026 16:35:28 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 648051F2BC8
	for <lists+linux-pm@lfdr.de>; Tue, 03 Mar 2026 16:35:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 05938306145C
	for <lists+linux-pm@lfdr.de>; Tue,  3 Mar 2026 15:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7424A4949FD;
	Tue,  3 Mar 2026 15:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="R+wGD6+j"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191CF49251C
	for <linux-pm@vger.kernel.org>; Tue,  3 Mar 2026 15:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772551993; cv=none; b=ckXdhCodLSsSAwUjX/6AfVUO3eJg37FfPwgzRBAub2JrBNhSc8/q9b0JBy2m/kAQwU00yKOEmY5FkGqbHY6JpkyfBEnNL6R8AQkvtrKbUgxB8AtuMB+Us6quQF/0sa7EXbh/TD8/7KoxEyOZpWIKkYWlMjqzfI84+bMvvhKn9O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772551993; c=relaxed/simple;
	bh=Q9D7eBKxq86MNvlgm1qDMnqHysA/422W4yV9eBroyC4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QomuSXJcB+ldG8EOja3psSIMZvyGHqBFvXhP/CCrSppavO6IZPrHjtCYMEeNKupfjmFpCaoCqIC+vUiq7dmTpPiK+wuqssxRv9aS7mGBRR4FhC+bDUfcXsIumyjaa3q9o0Igp0cJu42eSGltNCFdTeSPezH4yGTcEqbhIqWk3hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=R+wGD6+j; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-439aeed8a5bso2899391f8f.3
        for <linux-pm@vger.kernel.org>; Tue, 03 Mar 2026 07:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1772551990; x=1773156790; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sz4biLahYPKsT9J1ufLdEia90vJM1vdO3bq5iy8XGEM=;
        b=R+wGD6+jlr/0q2tFQ1AgxZsPUTeQvTgKbmBzi2ZlxBvZKtl6RziVZVBinpcyNPxb2V
         7LLIImtxaMXHIL5CbfLu2i7SFvq4PCusmafP05rIBvZ3rRnC6Fdtf01NPdEkshYNL/fm
         FR19vuzD0sDzgRPl3COcFf2P1MiiNl4fYAGn1weLMNpmj/ceF3bRewLUqZ2DvbZmbJlz
         4ANhAnOQ+KZNLvQhCCsow7xoEKUWHx+vRVIhxQb1+T6gSqaCOikHSqQmiqRcuI2grg8G
         QISALlVUH1NNtZIpltdlgfbmnLaENKDYwQ5KueBW0mrFFz/J3uHAli3rEIW0bES7Se7n
         fJdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772551990; x=1773156790;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Sz4biLahYPKsT9J1ufLdEia90vJM1vdO3bq5iy8XGEM=;
        b=e5LmMXcJHJa2AdXtbenHT/eM4LC6KkZknuPP519Hf7Y+W0qDo6U4C9nYUy3FxpKCCM
         ggdr4BmtJ4yB6Ls7V43hPx4F4L2se9neJtZOIlQD/lpjfh995s9g5LMbxY9XdKtjxGmU
         bSNWM0YYzIUJFiEABHxDebLraIAZKuenSfsdjamByE5EabnUeR6MotIgmoqO0ZBQfOso
         aG4n5kaBhEC43IIsRdjKIax3LP6jAOdxEcQlAFcle4kEUCT3ACO2eVDUUi+StbFtjniI
         RiwKi16DfzBtW1KzOTLmjPJpjySqpwh++Ep5LqIN9F29z8Mid36qa7jV2kkxHakE2tbQ
         dA/g==
X-Forwarded-Encrypted: i=1; AJvYcCWNJIXK0J0u14Gi9PutDcRx9sXfCcdNvp79jtlGLDM6fgU3xcZcYp5c4Vrn4pEnd8eUimt3UI5Cnw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzZfG5aQPFacbEEP1tC8DAzOlV0/CvGY0mfmPRC2OZVSmhdIMq3
	nZQrRjFIrbpFU89vilbHGVqy6aI8KsyDjKusRqPiGIcTscMOxwjxPvg7i57UqTp0r8I=
X-Gm-Gg: ATEYQzwOWLcQRuxfktrghuliIQvagQZeQwOL6TYKbPYA29rV3Iq3EU33sK/I9PWxdt1
	rr0vbaCeyuEMXs2K182Ndi9fUGokDcZ0ccsWUIVjRBh4IJTZZHYvdpaj3//U06pHDvhNQYUqKYd
	g/cCWs+1YXDeNMWw90uaL4CnvDFmkC2/8BCMD8MUi/L8yEEODZI9mmWl2XKMXls9fIAwyL/IZBb
	pinJOcgeWfigIClyKJNrNHU/oZRDPiPLUZaPKrwOm7b86rJ+cEdTSMoQ49S/6l3XdzENRCDypLC
	i2VRMFNqvMLK9FkFpSaVb+hiUvf2IRHuKJM25T+aZ5RRLgjDF05j2efyNEpnnm19mmTwFB/d+sI
	+lLIRXGBcKho728sy9TidriQ+QJz3MNUoieNyVP9PoUg0LsxMZqZqjUTsP2ttWGmCC2kjsJzaMj
	PqbsVZGV9AhccH94mbwkyFA6dSQYK04FrCg3yCcahJ+vpNSffTu5yXJkidEigtZZ0L5Ajg5TdCQ
	GQ=
X-Received: by 2002:a05:6000:1847:b0:439:b6d6:728 with SMTP id ffacd0b85a97d-439b6d60a8bmr14024221f8f.58.1772551990320;
        Tue, 03 Mar 2026 07:33:10 -0800 (PST)
Received: from alchark-surface.localdomain (bba-94-59-44-101.alshamil.net.ae. [94.59.44.101])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439b55d15besm19799447f8f.30.2026.03.03.07.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 07:33:10 -0800 (PST)
From: Alexey Charkov <alchark@flipper.net>
Date: Tue, 03 Mar 2026 19:32:50 +0400
Subject: [PATCH 05/11] power: supply: bq257xx: Fix VSYSMIN clamping logic
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260303-bq25792-v1-5-e6e5e0033458@flipper.net>
References: <20260303-bq25792-v1-0-e6e5e0033458@flipper.net>
In-Reply-To: <20260303-bq25792-v1-0-e6e5e0033458@flipper.net>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chris Morgan <macromorgan@hotmail.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 linux-pm@vger.kernel.org, Alexey Charkov <alchark@flipper.net>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1911; i=alchark@flipper.net;
 h=from:subject:message-id; bh=Q9D7eBKxq86MNvlgm1qDMnqHysA/422W4yV9eBroyC4=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWQu+6927vSyU6pnYy6ZvRLuM2vfKCc+Y4+B7pY9/Zvv+
 CcrxL3Q7ZjIwiDGxWAppsgy99sS26lGfLN2eXh8hZnDygQyRFqkgQEIWBj4chPzSo10jPRMtQ31
 DA11jHWMGLg4BWCqeV0ZGXbrrJ3AIPAw0E9vWZjBDK/ck/c53F9M/6i3n7+xh4fT6BzDX2GdwCs
 9D+T35Xgd+rR3z/RTC2Ywun848zzsjb/brNlTGrkB
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
X-Rspamd-Queue-Id: 648051F2BC8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[flipper.net,quarantine];
	R_DKIM_ALLOW(-0.20)[flipper.net:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43509-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,hotmail.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[flipper.net:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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

The minimal system voltage (VSYSMIN) is meant to protect the battery from
dangerous over-discharge. When the device tree provides a value for the
minimum design voltage of the battery, the user should not be allowed to
set a lower VSYSMIN, as that would defeat the purpose of this protection.

Flip the clamping logic when setting VSYSMIN to ensure that battery design
voltage is respected.

Cc: stable@vger.kernel.org
Fixes: 1cc017b7f9c7 ("power: supply: bq257xx: Add support for BQ257XX charger")
Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 drivers/power/supply/bq257xx_charger.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/power/supply/bq257xx_charger.c b/drivers/power/supply/bq257xx_charger.c
index 02c7d8b61e82..7ca4ae610902 100644
--- a/drivers/power/supply/bq257xx_charger.c
+++ b/drivers/power/supply/bq257xx_charger.c
@@ -128,9 +128,8 @@ static int bq25703_get_min_vsys(struct bq257xx_chg *pdata, int *intval)
  * @vsys: voltage value to set in uV.
  *
  * This function takes a requested minimum system voltage value, clamps
- * it between the minimum supported value by the charger and a user
- * defined minimum system value, and then writes the value to the
- * appropriate register.
+ * it between the user defined minimum system value and the maximum supported
+ * value by the charger, and then writes the value to the appropriate register.
  *
  * Return: Returns 0 on success or error if an error occurs.
  */
@@ -139,7 +138,7 @@ static int bq25703_set_min_vsys(struct bq257xx_chg *pdata, int vsys)
 	unsigned int reg;
 	int vsys_min = pdata->vsys_min;
 
-	vsys = clamp(vsys, BQ25703_MINVSYS_MIN_UV, vsys_min);
+	vsys = clamp(vsys, vsys_min, BQ25703_MINVSYS_MAX_UV);
 	reg = ((vsys - BQ25703_MINVSYS_MIN_UV) / BQ25703_MINVSYS_STEP_UV);
 	reg = FIELD_PREP(BQ25703_MINVSYS_MASK, reg);
 

-- 
2.52.0


