Return-Path: <linux-pm+bounces-43290-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SCx5DcxEoWkirwQAu9opvQ
	(envelope-from <linux-pm+bounces-43290-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 27 Feb 2026 08:16:28 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D901B3BA1
	for <lists+linux-pm@lfdr.de>; Fri, 27 Feb 2026 08:16:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2DA14309951E
	for <lists+linux-pm@lfdr.de>; Fri, 27 Feb 2026 07:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1AF3A9D9F;
	Fri, 27 Feb 2026 07:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uSqFNPfp"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8313290C7
	for <linux-pm@vger.kernel.org>; Fri, 27 Feb 2026 07:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772176518; cv=none; b=pISPfuCoXBUty4JjXmvoCxYDNMfXmlJ30Qee+xNcpOwrbbyJgo4lk2OAEULj0LnTIvZvA10x1BSRmSq5khr8R1g8FAuMZIY1tVoKP80Q6UaTiuLpUYLjuqF2eRroR7cEdPKsWKaO1J7t/BKAtCzBJOp29Y+ZO9hjDCKwylNL/CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772176518; c=relaxed/simple;
	bh=aSX81ZyZDrEK62Qx+282skeF6cwlfyKFGDM/zj98kpI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LqGfxg6lL1zteUGBpemJSecC8DPEZZyKXmfL26t1braEKdRbWr2gQ2S4sWTJhRtbX5B2r7dyxBIGn6Qm+xR8nP4hWndhJ0gfSToDv2DgSn2Ao0kybP74YJkvPFWkg2bmK44nnvsABUwwBkylB0aMt00BXoDqrqm71dur2nnC7tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uSqFNPfp; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b8f97c626aaso293170466b.2
        for <linux-pm@vger.kernel.org>; Thu, 26 Feb 2026 23:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772176515; x=1772781315; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6JgNbWns3UwEKgdueIS9H9aOU4yehTOts0vV7aSX/bI=;
        b=uSqFNPfplF/QefouVlA5AM+Q639C6kVQ81yCLxbS9NctbH/RH4juFR/8nogik3PdOV
         iQbVAGotM6U252OdMzyZeKrk8gAUkkRQUyBhRkPAhJ1P2whLslb1ueHKNLSu2OyyhKeU
         RbaO6HU/bIUqkRHJiX1h6KlfIlOouoYamKcU0DTD27aY2HIfFowwHHaoQImMX1Qt6+/Z
         APHO4bsajkxY0YNeuTuFb1UlcKk/AnDrnGnyNMDzwMfqO3idx6iLqxIwhwNjwWPI/Ckm
         63QmPpZtX+3kZR5sUxp+cIBSFlkLtza0WXsBKCUMqlBio+8O/fMI9M4j2CazUgz28SG7
         NvdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772176515; x=1772781315;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6JgNbWns3UwEKgdueIS9H9aOU4yehTOts0vV7aSX/bI=;
        b=VIg3pJQiHLwe1glQh2JEBV3hkhWJ09Ku2Po12rJVRlyBfNBVHbfy+UjhuVFeJ3Giz7
         1AxVFGd4gQ4P+xlfXl6bq4YGEW7io8C9o21T/FnH9f7Od7j5MiJwlUKiPgeXiAjJgto5
         AOmLkegjPJpqbV4V7qc3W0LH5ptzaMgu2fgBqjJfa/81x6wn8rrSTCzsyMJwUzAJ40/t
         YldSqtDBLP6W+wYFgpzc7+V55QJD9h7DmPO8nkK1BIjOkp0i/M2Ia3hW2v16oXW/8c8g
         njee67w/S1ZC3wwo5YH4LXDbXnRF+0yjSnYU15irnNns+Mw4agkES+1+zmQSw5UCCCuA
         f1NA==
X-Forwarded-Encrypted: i=1; AJvYcCWtk6NpppY2kGvbyxRsv6sfsiJSg07HU7JpX5YCDGDrZMYwe9FNWbU/3n2XaZwLpRKGXJlbYphKsw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6W0KEQ6hMg+jS5YfI8poV9ejnCklRVdeFIQMRTV5dJkfH/qYv
	h/g3mluloWiMKGWlFaXXR+DJOwKpEhWOHABVNqwCVpnE87wxl1aN0RwXyUb8RPatEHI=
X-Gm-Gg: ATEYQzy08wWnB3yZ7ncQjc+G0mdq1aWkAbdeXIWKue4VFfkMghIKzJJWry0ZtoWyZHm
	mlL3Yc5KRb2KxTqJEkbyuCFXRJ9elyNH0ujqGfWb9F3Ncbf9fom48y4eMkKKrzezJJHu/ji53H4
	Wh/s/hsYyJBHUYAyjiN42e1iJn22KZybQxbjzizXwLNYk2nbuHkSvgo47cLnpTHzYTDBAyTJG3V
	+C+Jn/sGd/P3h6nC0YZlbRJZrHQmXHxPYGiwYWiwMmQp35LTER1II2gAHt4nMFIptKLhrEj/OAz
	lBqknLefJdbJ09x2Ctsl2jDwXKQKHCYDtH/4KYiOEmg2vMeemZ4QJ0nyEgYY4FFKXn2gaya2bmJ
	YUlTSYLa4XS1TJidsXSXMcNkk2x4K3EVyrojxQBfY7+CHXntQy5DGiPnvGormfTj//xLzhg3dzL
	yUmXsWwm0ruCz/DL8gjrfCfNXdfxed+Yg/9KgYc1McHc9XVBVd1OZisSj585nGpaGdcg2tIX1RF
	ES5JTiIgmHvjPoGkQ==
X-Received: by 2002:a17:907:1c93:b0:b88:64e9:899d with SMTP id a640c23a62f3a-b93764f4458mr110537166b.34.1772176514701;
        Thu, 26 Feb 2026 23:15:14 -0800 (PST)
Received: from puffmais2.c.googlers.com (244.175.141.34.bc.googleusercontent.com. [34.141.175.244])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b935aeee867sm124205066b.66.2026.02.26.23.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 23:15:14 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Fri, 27 Feb 2026 07:15:15 +0000
Subject: [PATCH v2 10/11] power: supply: max17042: consider task period
 (max77759)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260227-max77759-fg-v2-10-e50be5f191f0@linaro.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43290-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[linaro.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andre.draszik@linaro.org,linux-pm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linaro.org:mid,linaro.org:dkim,linaro.org:email]
X-Rspamd-Queue-Id: C1D901B3BA1
X-Rspamd-Action: no action

Several (register) values reported by the fuel gauge depend on its
internal task period and it needs to be taken into account when
calculating results. All relevant example formulas in the data sheet
assume the default task period (of 5760) and final results need to be
adjusted based on the task period in effect.

Update the code as and where necessary.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
While I do believe this should apply to all devices supported by this
driver, given the register description in max17042_battery.h, I've made
this change specific to max77759, as I have no way to confirm this
works as expected on those. I've found a data sheet for
max17047/max17050 online, which does describe the relevant register
0x3c as 'reserved', hence I'm a bit hesitant to enable this for all.

v2:
* update commit message subject prefix
---
 drivers/power/supply/max17042_battery.c | 20 ++++++++++++++++++++
 include/linux/power/max17042_battery.h  |  1 +
 2 files changed, 21 insertions(+)

diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
index 44626abdab34..89909b140cf9 100644
--- a/drivers/power/supply/max17042_battery.c
+++ b/drivers/power/supply/max17042_battery.c
@@ -61,6 +61,7 @@ struct max17042_chip {
 	struct work_struct work;
 	int    init_complete;
 	int    irq;
+	int    task_period;
 };
 
 static enum power_supply_property max17042_battery_props[] = {
@@ -335,6 +336,8 @@ static int max17042_get_property(struct power_supply *psy,
 			return ret;
 
 		data64 = data * 5000000ll;
+		data64 *= chip->task_period;
+		do_div(data64, MAX17042_DEFAULT_TASK_PERIOD);
 		do_div(data64, chip->pdata->r_sns);
 		val->intval = data64;
 		break;
@@ -344,6 +347,8 @@ static int max17042_get_property(struct power_supply *psy,
 			return ret;
 
 		data64 = data * 5000000ll;
+		data64 *= chip->task_period;
+		do_div(data64, MAX17042_DEFAULT_TASK_PERIOD);
 		do_div(data64, chip->pdata->r_sns);
 		val->intval = data64;
 		break;
@@ -353,6 +358,8 @@ static int max17042_get_property(struct power_supply *psy,
 			return ret;
 
 		data64 = data * 5000000ll;
+		data64 *= chip->task_period;
+		do_div(data64, MAX17042_DEFAULT_TASK_PERIOD);
 		do_div(data64, chip->pdata->r_sns);
 		val->intval = data64;
 		break;
@@ -362,6 +369,8 @@ static int max17042_get_property(struct power_supply *psy,
 			return ret;
 
 		data64 = sign_extend64(data, 15) * 5000000ll;
+		data64 *= chip->task_period;
+		data64 = div_s64(data64, MAX17042_DEFAULT_TASK_PERIOD);
 		val->intval = div_s64(data64, chip->pdata->r_sns);
 		break;
 	case POWER_SUPPLY_PROP_TEMP:
@@ -1146,6 +1155,17 @@ static int max17042_probe(struct i2c_client *client, struct device *dev, int irq
 		regmap_write(chip->regmap, MAX17042_LearnCFG, 0x0007);
 	}
 
+	chip->task_period = MAX17042_DEFAULT_TASK_PERIOD;
+	if (chip->chip_type == MAXIM_DEVICE_TYPE_MAX77759) {
+		ret = regmap_read(chip->regmap, MAX17042_TaskPeriod, &val);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "failed to read task period\n");
+		chip->task_period = val;
+	}
+	dev_dbg(dev, "task period: %#.4x (%d)\n", chip->task_period,
+		chip->task_period);
+
 	chip->battery = devm_power_supply_register(dev, max17042_desc,
 						   &psy_cfg);
 	if (IS_ERR(chip->battery))
diff --git a/include/linux/power/max17042_battery.h b/include/linux/power/max17042_battery.h
index 05097f08ea36..d5b08313cf11 100644
--- a/include/linux/power/max17042_battery.h
+++ b/include/linux/power/max17042_battery.h
@@ -17,6 +17,7 @@
 #define MAX17042_DEFAULT_VMAX		(4500) /* LiHV cell max */
 #define MAX17042_DEFAULT_TEMP_MIN	(0)    /* For sys without temp sensor */
 #define MAX17042_DEFAULT_TEMP_MAX	(700)  /* 70 degrees Celcius */
+#define MAX17042_DEFAULT_TASK_PERIOD	(5760)
 
 /* Consider RepCap which is less then 10 units below FullCAP full */
 #define MAX17042_FULL_THRESHOLD		10

-- 
2.53.0.473.g4a7958ca14-goog


