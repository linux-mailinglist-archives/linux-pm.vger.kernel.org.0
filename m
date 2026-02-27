Return-Path: <linux-pm+bounces-43286-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IHwsKJFEoWkirwQAu9opvQ
	(envelope-from <linux-pm+bounces-43286-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 27 Feb 2026 08:15:29 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 73BCB1B3B20
	for <lists+linux-pm@lfdr.de>; Fri, 27 Feb 2026 08:15:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6D6693040FF5
	for <lists+linux-pm@lfdr.de>; Fri, 27 Feb 2026 07:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BF623290C0;
	Fri, 27 Feb 2026 07:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F7emd6YT"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4150F35A387
	for <linux-pm@vger.kernel.org>; Fri, 27 Feb 2026 07:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772176516; cv=none; b=W4yRzXeK6j9itZqUnlAbTkPscS3h5DtkNVyPqLWqLV8ucqf6q7L+eMFaVZ9dGgWentGqeslcilAce1RHjpo9JuvzCovPAwaUQpRBEdLzouU43JoyorQn70yb8lS88HleJ4vSy5cnObuZ0GSR4ucg7mKfHUhm5l/dtDF61OVQF34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772176516; c=relaxed/simple;
	bh=Yt0sNw9b+pj9fmaA7tM3vgRmJfOjPqWF3O7G+LpIrnI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NSiIFoudW+8KQt9kNZtFRcRMfY4ki1SoPsl/JukgaHjYEUKGYuHCbgDhOQp0INvhlOMx6BafqzoUuWBFZVReZM7Vwte6fF/sSyJo11q7RGr8RgH92H0lel01TW/DnsNLhv32h7qSfMq/x6jHBLigWr6c6p/UoQrHolbzajFazXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=F7emd6YT; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-65c01595082so2850610a12.3
        for <linux-pm@vger.kernel.org>; Thu, 26 Feb 2026 23:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772176512; x=1772781312; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WClHPYuZJqN8n1xZlLHGmGajkWi1sdB8zHmMALTl0VI=;
        b=F7emd6YTNBdSollPGgpVYasDjaN53eX0ZmmTptU73hIfQBa/OAKY2uWc/0+CMkfvll
         LH3A1grt6Uod99fIiJA8VJ8ARR8ONCLhgQKt7rKkICGyrJ6qAQSx9jQ/6pMN+SuQkbDq
         yC3axNC9QIsUDvFzc6hqNPHxWJJh8ib1s4ADZ4Jod+bBmEX1nGUjd3YblRKsp2ms7aXr
         6lOo55oCPHPKzSyT0ThMMfmBPsXCDtpHkTn/Gu1sMxaEqggJulP53qEVW4sLEcQHnPX8
         6s/sWG3xJIuXjC4hLpYRpYMZ3HSuIYFLw8SRW+3ygM4po146jmXiBbDn1ZR73aQ44ylJ
         AIbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772176512; x=1772781312;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WClHPYuZJqN8n1xZlLHGmGajkWi1sdB8zHmMALTl0VI=;
        b=jU+/ZVkKhW+HUs2MPs2Yas3zeC3fzryLTe6PSVq0z447SGs0H/y3oihKkjm0bXtT1b
         RdiETWkuFe0mfHNlgTnDsWdSwLNZbBjgxaSY6fdHXzH8u5lfNvhal7O+Z+I0H2aRXkPa
         LZWArPLy9Oi1cqOV/VT3bdWok/we+yMD3QE3e7EDmZZFICoYBRCNK3OjiXC6CewdQi0N
         zeDIyK6G8ketg6KU0I+2IaRlB3mjh8CY1m8795PWstD+uYFrlSNhELvw7Fexr667Zz64
         UujY5ehEm4ml0rLgR31IRkUwDYyk8Sg5vjcEqvHGoiHjPWxMiJ85g6Ix/7MKPX4DOgvM
         Dk/A==
X-Forwarded-Encrypted: i=1; AJvYcCVmb5s8qjOtAANEHzpx7LgaepNGvFNbZN6lxGsXY8M41QTsX1tSCN6/GL3SHsCnNNOv/bBM6P3K+g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyblW66xV6Dm9fKzvhfXrnZlwjdQ4dxEc5M3wBShkeU/PxCnngt
	fN9lkKsyAim6ckKJXNRtFvO11k8/zh0oj62wcuBFEyoLKfg/w2RTIT5daj6ODLFATIo=
X-Gm-Gg: ATEYQzzqC2rkRxGOh9nexaS3Kq2GAt+JjIIasdUip+x+0hvQlwqmN1etlHmnMIM/1CO
	Cx7mHMqDACBzePMewktlPY0uHcpib5xuJJd7wt1PIje256PT4efdAf2b3dJXHWEZRedj1+riFX3
	XPor/cP9x9ozjhi1+u586q0QJWPs2CQqLkIPQr6Rd9yGM7UTj+J1KTlFVaZYqVei2tekb1603TT
	mlgF2WaqpsN9o6CJGOEkyq8h9hoVDepzvhQHhxVQg8SDXhKkW3tyRPX4C+4bEjSQ1heQJp8OT6O
	7ZzdANna1WWlfqqBpzswUprKgT0ngYwbBdNVk4JH660y1n/PKg70grkyxi3jo855Tq4pnaquims
	x+QyFbnOqE82inpiXy/XXZZRs3rhH1rDnDWB8XVnHGu2TeARIKX1bTi7oScwCCf0psjHlARcrVc
	P0fQmNB5pnNJcqw1nblOq1UDbGVsH9zCUZKsGZzD5zgxrKUpx1GYUYpKWfMvsVhmr1FI9JzERPh
	MJPgTSWN9r0vKhEJQ==
X-Received: by 2002:a17:907:3e91:b0:b93:5521:b57a with SMTP id a640c23a62f3a-b93764b5f90mr102410666b.31.1772176512558;
        Thu, 26 Feb 2026 23:15:12 -0800 (PST)
Received: from puffmais2.c.googlers.com (244.175.141.34.bc.googleusercontent.com. [34.141.175.244])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b935aeee867sm124205066b.66.2026.02.26.23.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 23:15:12 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Fri, 27 Feb 2026 07:15:11 +0000
Subject: [PATCH v2 06/11] power: supply: max17042: avoid overflow when
 determining health
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260227-max77759-fg-v2-6-e50be5f191f0@linaro.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43286-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[linaro.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andre.draszik@linaro.org,linux-pm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:mid,linaro.org:dkim,linaro.org:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 73BCB1B3B20
X-Rspamd-Action: no action

If vmax has the default value of INT_MAX (e.g. because not specified in
DT), battery health is reported as over-voltage. This is because adding
any value to vmax (the vmax tolerance in this case) causes it to wrap
around, making it negative and smaller than the measured battery
voltage.

Avoid that by using size_add().

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/power/supply/max17042_battery.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
index b9277f81a25d..8808c0d2ad10 100644
--- a/drivers/power/supply/max17042_battery.c
+++ b/drivers/power/supply/max17042_battery.c
@@ -201,7 +201,11 @@ static int max17042_get_battery_health(struct max17042_chip *chip, int *health)
 		goto out;
 	}
 
-	if (vbatt > chip->pdata->vmax + MAX17042_VMAX_TOLERANCE) {
+	/* avoid
+	 * /sys/class/power_supply/max170xx_battery/health:Over voltage
+	 * due to overflow
+	 */
+	if (vbatt > size_add(chip->pdata->vmax, MAX17042_VMAX_TOLERANCE)) {
 		*health = POWER_SUPPLY_HEALTH_OVERVOLTAGE;
 		goto out;
 	}

-- 
2.53.0.473.g4a7958ca14-goog


