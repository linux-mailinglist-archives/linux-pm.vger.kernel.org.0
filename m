Return-Path: <linux-pm+bounces-43834-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gIjbETvnqmkTYAEAu9opvQ
	(envelope-from <linux-pm+bounces-43834-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 15:39:55 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD96222DE5
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 15:39:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6742F317BD53
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2026 14:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B0823A9603;
	Fri,  6 Mar 2026 14:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="07HutCqE"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D09C392C32
	for <linux-pm@vger.kernel.org>; Fri,  6 Mar 2026 14:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772807609; cv=none; b=AgAa5vk4peax0VAHXemnMeuf5WqzvpnxR2JDVBg8zl2/dfjO/rQW4cmqZV5YlCywgpszA13Mq7+qUoqYH/h9n4GjVyzBBiDcrgSPhMqEal0AS+wjYyrkkrGUXITuVttqnolFVXmVkocOV/pGrJ8TB5Dwgus6o5D4IZ2PHW3Qo48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772807609; c=relaxed/simple;
	bh=rI3qlTJ6sVlqcAKmwgpX1F1kJ2fiqBBvb2/yVu30Rak=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OdtlTIWkryyPe1n/ds5gsaPY9XdIk0FPeL7C4iTBN9OTmaEaQUQ7gmxXi4vff9eDtv7aGJPGZ8aQ1k9ZnnmRk6QhnwYVQGWKV5xJu7mYTTU/Sokg0tirOJHww/rCuK347eOe0xfI6SvLKKtMBH2cYNzRzXCHXJZ5obd35Qs5dyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=07HutCqE; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-439b78b638eso6118734f8f.2
        for <linux-pm@vger.kernel.org>; Fri, 06 Mar 2026 06:33:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1772807606; x=1773412406; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UNXZcw1aJqSKR83mcQk2RSs9v+AW3Tva6N8ZbjfBrlI=;
        b=07HutCqEanVTkgsAQZ1eu/ajYE+l43WRqlTAg8j85xD+h5tREo0XGU49ybKAf3z/8/
         HUW0QZqpJBRJHXzR3Y9b31s2ytQK2GRHTe3FNJAAZFr58lDf3qxOKML+CVvaJ2K/q/8u
         onAwz3Lt0ErgZRtesf1qQLb+xSv+yxsJ4Jek7kSgHdlOE85A0QdWg10+68wUQUYoKOcW
         /GvV9UId9NFdhVKT36ByxqfPhPJtEc/Z2PpPxMxFCWx+CYmydqFh3XawUh1qFsGeYZUy
         Kt1jvXSy1nVX6yfJAJ3TSG92fvlOJ/FIxjQw6/gmbhTuRy0otcaCF00G08wfr5kINRXi
         aDrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772807606; x=1773412406;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UNXZcw1aJqSKR83mcQk2RSs9v+AW3Tva6N8ZbjfBrlI=;
        b=bVdt3DlQDyQ8ih+MfCeiTbO+X+QRXtxdGv3XGRZ6l7c8tkj8RTlE0mVxpdpX6wL45h
         8J3ZWLEpCMpWqTPdMfbD/yVQKu75zgkBd327gXu9Ga/W+j/wLC5OrdbEt1QI27VCA1wH
         58bUuH3I2BGMwOrRE8JTiR/owYKH+BdKKzYqZa2ABe4i4jUONJNIZkroW8Eh+gV3SS4Q
         W3oSCEqtuU+UkAB2Z3P57a9F1MgNzuIh3G1aFkdiWom8mX6ELg6Uncfi8czNeR3SEXxw
         HC/pnQ2bqbzdMQ5vbDVchtrKO+Zs4c/v9iIKmpg5dpEvM9jWbISRhkvfy6jaiIXnwyZu
         GZaw==
X-Forwarded-Encrypted: i=1; AJvYcCVUsnvn7lx18LJwSZctebKFMvv5XaH7oiPcop5QL7+vKtkXclQk+dbuYqF5IiuWmYZFPyOSoNV7Zg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzY/QLx6Y4K9FAQ+1UNJBpeSFOz6rDKnqEQgySHJXBDgbMRuweb
	3z7RfSXU4dmER7N4BlknHZP1ovuyPBPK+dWFp0uJWtgeODx+9C4Wf0uol6qNE/8kRL4=
X-Gm-Gg: ATEYQzzMD+KkEbUpIsmzkRhmW5kYMluj5lj261swoBGXjBrEy5dbTD5ZI4+FmKVa4KX
	hRlcXO6uMpXSV6HzBKg1wvI9IIo7KMQOTkgNIUny396kpbpOPxNXiQ8Yz+g6VRBcUxqAYY1AvEs
	LvQLnnZhyFWX7pXTg1xlFXaM2xwSVI0Bix3vS1eS5i8jP9VnLhziwjt1PRo5oKTbXQMM0zmmvhB
	XqpAWMC+KHKQW7Hf3+zx/0GgJoS3lWAdlw1ZPC014YunpQZapHB6s5Q5Hd0U6f4KSv3Ulj5pyvz
	hYNscI2gLYLVgUaUYgYxGttk3cCswfeAB2P5mRhpdx2IyyevtOAsc/kbjRmtSJKF9EeCMHqLpNG
	eLbfjkMQ793IOrsen0En9KSuLmSE6ccjqANYVKtf0W0pYreB4ZeEJod1JwhsBi12g6+iLzzd4yJ
	3uBG9krQs32DFnAcn6RH1L1YulDw46OLxgUG6P1lqlNHoV00HYX1wrQe3jOzHHqHUx1MoEmsnFb
	vnKow==
X-Received: by 2002:a05:6000:186b:b0:439:9282:e728 with SMTP id ffacd0b85a97d-439da654ce4mr4361366f8f.2.1772807606440;
        Fri, 06 Mar 2026 06:33:26 -0800 (PST)
Received: from alchark-surface.localdomain (bba-86-98-192-109.alshamil.net.ae. [86.98.192.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dad8daf2sm4635281f8f.2.2026.03.06.06.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 06:33:26 -0800 (PST)
From: Alexey Charkov <alchark@flipper.net>
Date: Fri, 06 Mar 2026 18:33:06 +0400
Subject: [PATCH v2 06/11] power: supply: bq257xx: Make the default current
 limit a per-chip attribute
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260306-bq25792-v2-6-6595249d6e6f@flipper.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1615; i=alchark@flipper.net;
 h=from:subject:message-id; bh=rI3qlTJ6sVlqcAKmwgpX1F1kJ2fiqBBvb2/yVu30Rak=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWSuerpEulGU2U+WZdGfB9M2vhS2frju+WXT2bVh327xH
 X2YsXv1qY6JLAxiXAyWYoosc78tsZ1qxDdrl4fHV5g5rExgQ0QaGICAhYEvNzGv1EjHSM9U21DP
 0FDHWMeIgYtTAKb6LxMjwzNX+19bA3ff0FntdihP+tNDa9MFP7cUlH9i/Cj4S+RtYRPDP5v/zTP
 fTeKuOLJYdXqDmdZFTzf/Sz+vT/UMnCIlIxeazw0A
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
X-Rspamd-Queue-Id: DCD96222DE5
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
	TAGGED_FROM(0.00)[bounces-43834-lists,linux-pm=lfdr.de];
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

Add a field for the default current limit to the bq257xx_info structure and
use it instead of the hardcoded value in the probe function.

This prepares the driver for allowing different electrical constraints for
different chip variants.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 drivers/power/supply/bq257xx_charger.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/bq257xx_charger.c b/drivers/power/supply/bq257xx_charger.c
index 7ca4ae610902..e14dd16f9d08 100644
--- a/drivers/power/supply/bq257xx_charger.c
+++ b/drivers/power/supply/bq257xx_charger.c
@@ -26,6 +26,7 @@ struct bq257xx_chg;
  * @bq257xx_set_iindpm: set maximum input current (in uA)
  */
 struct bq257xx_chip_info {
+	int default_iindpm_uA;
 	int (*bq257xx_hw_init)(struct bq257xx_chg *pdata);
 	void (*bq257xx_hw_shutdown)(struct bq257xx_chg *pdata);
 	int (*bq257xx_get_state)(struct bq257xx_chg *pdata);
@@ -627,6 +628,7 @@ static const struct power_supply_desc bq257xx_power_supply_desc = {
 };
 
 static const struct bq257xx_chip_info bq25703_chip_info = {
+		.default_iindpm_uA = BQ25703_IINDPM_DEFAULT_UA,
 		.bq257xx_hw_init = &bq25703_hw_init,
 		.bq257xx_hw_shutdown = &bq25703_hw_shutdown,
 		.bq257xx_get_state = &bq25703_get_state,
@@ -675,7 +677,7 @@ static int bq257xx_parse_dt(struct bq257xx_chg *pdata,
 				       "input-current-limit-microamp",
 				       &pdata->iindpm_max);
 	if (ret)
-		pdata->iindpm_max = BQ25703_IINDPM_DEFAULT_UA;
+		pdata->iindpm_max = pdata->chip->default_iindpm_uA;
 
 	return 0;
 }

-- 
2.52.0


