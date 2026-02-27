Return-Path: <linux-pm+bounces-43291-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YA9WFz5FoWkirwQAu9opvQ
	(envelope-from <linux-pm+bounces-43291-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 27 Feb 2026 08:18:22 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 061941B3BFB
	for <lists+linux-pm@lfdr.de>; Fri, 27 Feb 2026 08:18:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B3D93317DDF0
	for <lists+linux-pm@lfdr.de>; Fri, 27 Feb 2026 07:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD3D3AEF5E;
	Fri, 27 Feb 2026 07:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qJwObES6"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F352C389E18
	for <linux-pm@vger.kernel.org>; Fri, 27 Feb 2026 07:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772176518; cv=none; b=ixGoDzBPrOhYxZqXfcDL4rQ4ShZus+ONF75KTXHUnSCK3k3CznJ2eszQ+O38ELZm3iZHOo49bgLq/PiVNNz5sNB3yY6/QjyxrSh4vbFhgtgF90fLnlyNrZuZbLFrWbFrHeoT2/j25Wf0RvIajxmU7zuJ8na4LRePOaT6aqfJU0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772176518; c=relaxed/simple;
	bh=mdMwa+4vXJFSq1mBJLsIE/rDEGn2SDuqUw2L2ipYiws=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LtgVEhbszrHSmlfnWI1CxoalULOhjTZT3/jzdk4L9dXVm3g06GN3wlFTK1il5PnTDVUuNEzhHkYVXRJC5LDyXE4PJKwguhQF+fhZUTSaoa8jCYEZ0rCq+AUPz59LPERHSwrOOGVePClrEhNRlIxEtaUzq5sdevYTrIIkQd7JoXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qJwObES6; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-65faaa8b807so3259520a12.3
        for <linux-pm@vger.kernel.org>; Thu, 26 Feb 2026 23:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772176515; x=1772781315; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pb9+a6UQI9eJoPAfaI075Xgk+AX6ysZxadZXLoPE5ik=;
        b=qJwObES6t1BuEALPr1QuOyfP1m6V6NmCubcWrKqzWkVr5xZfl4fks2KyN0PGsVGy4B
         0/oUld4DixrrLsk6cQXeV23WDGZDmzOCPdrcWK76peUvh4qJw6Mdt656C9n/EARFMwNW
         KD5T0XaAAGoLKWeUe5ui7mgwcze4KS/IEwYZ1yHfMoYRU2G5e9IfE2jUMOEoTLglCgOo
         Vl6dC7FMUx9Xo+lyl3YKBhM808DBg2wVctAq1UjlIzdhLgMpvr8krZ/L8VFNshTrzItz
         D0Qi2dRNrfiDPAFfoW5bEsWnpohwKbQ0t+aZuYYepds6rrwmUA5kPUxc2HN6hNLHv6Uw
         dLGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772176515; x=1772781315;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Pb9+a6UQI9eJoPAfaI075Xgk+AX6ysZxadZXLoPE5ik=;
        b=CRxbPV5WCNPHLVVMIN4zOqwu5tn2Qt3+D3BrR78OHtRgJXouhYOnzb7ipOfFT6Gwis
         1z+Foo8SAloERw4BQhjN+S1c6I3xBUIb4Beg+iKT+9A0k/VmcEv2rm2WOfnz1tvxuwTy
         2HzdqSsx7Unx4N6ditBU0FJNsKNHUtqJy8JD3c824slE1qF3BllfJcQxlpznsrpsMaP5
         ZKpaNwzYtU5mRcmWTQNpkBc8CYV02aHopp08Ih92qPjK3fUuNmN9kq2uysdp25w9QcL9
         pycLbylcts+KwcUW3wHMLslZJTWg+RbAOKUbeAoR0Pg5OAR3CsQX1znbe9iOaXDstQhY
         7RWw==
X-Forwarded-Encrypted: i=1; AJvYcCUa0thB7U6yaiCptPGiSjzHrrNFarqGcf0WodiVLpLy0dKjjy6brwdkAw2T1tXF6asFlt3s7LRAmw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxPPV8ZC6KcIv7WgmJihpYTyk1R//yk+9quiFqw2AFvyz3OnXD3
	QHub5ElbcO1zJr8Fu6dhN+zv65hwGbDLNUNekMM6xfgvaGEnwFXZpleXaeEAQqaEXlQ=
X-Gm-Gg: ATEYQzwz6XpHnxk4VwwPVJkV4PLjt6nA7dx2xoRlhwpt6vc/SSyg8ChX2BwundbO/Zj
	bHzKcotPnCboLeyXS9dePd3uO+IO304JXH7NAcBywxgMTbtjq7TJI4voqLmvc4Gnfb1kmIrXexA
	IHThE9GyDGdAWBg4jZbaSAKq1uMOjqTxPdBwOiN+91t5j42Gp2TGeemQp12Hwi3mDmpWo/FjeZV
	xr1sCUGSRreJbdtmBf+GqTx+iakXgd0XDAK2V+zJiAIJN5tVlTeDwRBekTuYC5ew0mNZi2Lxolu
	CbdYqf+LZOZujJzDZAqjZFdbC5MTCgGzu3YdXQLzON6WDQozwAuSJxqa6jnfpvtaJOtsZtPJMkG
	2FFKTNGjMayw9sb8a+M7bFd9VjVHrFOEBRfcqt0y9LShEvy1PnaJdXhYsJSaCHY0MvUELTRB+f5
	4YfH2jDKXfmPiKyd3Mo9J8HAoX+dm+yvfUDZamjTBpbmV2s3u/nWgfru0pUmkxijBrXG2ZW7mXt
	jA0TZSO7AcvprNViQ==
X-Received: by 2002:a17:907:d05:b0:b87:965:907a with SMTP id a640c23a62f3a-b93765210c0mr101186166b.32.1772176515213;
        Thu, 26 Feb 2026 23:15:15 -0800 (PST)
Received: from puffmais2.c.googlers.com (244.175.141.34.bc.googleusercontent.com. [34.141.175.244])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b935aeee867sm124205066b.66.2026.02.26.23.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 23:15:14 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Fri, 27 Feb 2026 07:15:16 +0000
Subject: [PATCH v2 11/11] power: supply: max17042: report time to full
 (max17055 & max77759)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260227-max77759-fg-v2-11-e50be5f191f0@linaro.org>
References: <20260227-max77759-fg-v2-0-e50be5f191f0@linaro.org>
In-Reply-To: <20260227-max77759-fg-v2-0-e50be5f191f0@linaro.org>
To: Hans de Goede <hansg@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>, 
 Purism Kernel Team <kernel@puri.sm>, Sebastian Reichel <sre@kernel.org>, 
 Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, Juan Yescas <jyescas@google.com>, 
 Amit Sunil Dhamne <amitsd@google.com>, kernel-team@android.com, 
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.14.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43291-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[linaro.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andre.draszik@linaro.org,linux-pm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:mid,linaro.org:dkim,linaro.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 061941B3BFB
X-Rspamd-Action: no action

Report the remaining time to full as calculated by the firmware for
devices that implement this.
Similar to time to empty, the reported value is only meaningful when
charging, i.e. if it is != U16_MAX.

Signed-off-by: André Draszik <andre.draszik@linaro.org>

---
v2:
- limit to max17055 & max77759, the datasheet for max17047 and max17050
  describes the register as 'reserved'. I was mislead by the comment
  and enum ordering in max17042_battery.h
- report as POWER_SUPPLY_PROP_TIME_TO_FULL_NOW (not _AVG). The max17050
  datasheet is a bit clearer than the max77759 one on that.
---
 drivers/power/supply/max17042_battery.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
index 89909b140cf9..770d806033b9 100644
--- a/drivers/power/supply/max17042_battery.c
+++ b/drivers/power/supply/max17042_battery.c
@@ -89,6 +89,7 @@ static enum power_supply_property max17042_battery_props[] = {
 	POWER_SUPPLY_PROP_HEALTH,
 	POWER_SUPPLY_PROP_SCOPE,
 	POWER_SUPPLY_PROP_TIME_TO_EMPTY_NOW,
+	POWER_SUPPLY_PROP_TIME_TO_FULL_NOW,
 	// these two have to be at the end on the list
 	POWER_SUPPLY_PROP_CURRENT_NOW,
 	POWER_SUPPLY_PROP_CURRENT_AVG,
@@ -447,6 +448,21 @@ static int max17042_get_property(struct power_supply *psy,
 		if (data == U16_MAX)
 			return -ENODATA;
 
+		val->intval = data * 5625 / 1000;
+		break;
+	case POWER_SUPPLY_PROP_TIME_TO_FULL_NOW:
+		if (chip->chip_type != MAXIM_DEVICE_TYPE_MAX17055 &&
+		    chip->chip_type != MAXIM_DEVICE_TYPE_MAX77759)
+			return -EINVAL;
+
+		ret = regmap_read(map, MAX17055_TTF, &data);
+		if (ret < 0)
+			return ret;
+
+		/* when discharging, the value is not meaningful */
+		if (data == U16_MAX)
+			return -ENODATA;
+
 		val->intval = data * 5625 / 1000;
 		break;
 	default:

-- 
2.53.0.473.g4a7958ca14-goog


