Return-Path: <linux-pm+bounces-43245-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uAo+DtNGoGkuhwQAu9opvQ
	(envelope-from <linux-pm+bounces-43245-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 26 Feb 2026 14:12:51 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D28EA1A6292
	for <lists+linux-pm@lfdr.de>; Thu, 26 Feb 2026 14:12:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 982DD305DDD6
	for <lists+linux-pm@lfdr.de>; Thu, 26 Feb 2026 13:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C08E5314A64;
	Thu, 26 Feb 2026 13:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z0Q6RFkn"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51CA3161A2
	for <linux-pm@vger.kernel.org>; Thu, 26 Feb 2026 13:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772111502; cv=none; b=SS0b/5FEKvcHRn4wSyMQu7f/o506Yf9cPk3fKOzotQw/7FNjl3y+YumSdFmnszZwFr2yZQISlgklflkcTU4ARaWgzZ8V6EsgRCHTVl1O2EqZ+WAqmZodBYUM8PjK3EimlyofYpGREgH3laZ/1125AVgp+5/um7Civb602NEe98E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772111502; c=relaxed/simple;
	bh=CV8yI1R1vxaepaMKQg2pU15I1IQGq4B2d1c5Q8TyfT8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YYFRhYrWy69XQku0WFtDsd12822Uz4WUdyCbQ/T3Y9L+0jzgfLTV6vDAbBHGRTV5+Cml+6dVYVmfe2SYUcROYLQnnLnPuMU8yqikUTJz8MVaxLE091HBx2IEij/nSdcg+xC2BS66LotUKNq1e3mafjO7T7vEfJs8h+aNduHc2vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=z0Q6RFkn; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b884d5c787bso120964366b.0
        for <linux-pm@vger.kernel.org>; Thu, 26 Feb 2026 05:11:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772111498; x=1772716298; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7dxIGuour1z+2vBwoz711z9H7XQ3u+zJtn7J7jgmZus=;
        b=z0Q6RFknwVQTzky8yekM0kmYficmX6Okzh06jDL6iPQOCqbaDqitDg6B8wR6qp49xU
         +Cx0zYwcTHowe4Qi3tjldRqsJ5msDpSMQlYjyf/v/LQB9RtqHdpnHMbidYi8HYYxgTC4
         +sNc0fZyGDCs8A1mpPUWAN6+V/TyjkTxfUQlZUYBMvf/r6bbuY04laHVuu+U3jnJ6TGR
         MJf0en4q1kEw+hLC/fZvOFfuLVVynyyW6CeG9nqJs8agotBqgl8SC20o/LBW/Z1b2IoQ
         NNVp9i8K5heFGYsL8M/vcKZD5MimBf/DWfZgUtrMmJkjo8sirQ/JDhfDio1UfVZu7DAn
         rjRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772111498; x=1772716298;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7dxIGuour1z+2vBwoz711z9H7XQ3u+zJtn7J7jgmZus=;
        b=cvn3vNlY7xgtqb++Wx5qQ7Mc0GYZGf2vWVuu7bN3GILT3eetrRjH8vNjiZOnSQVnro
         HhzAsN4ULxWykv2pjH6QcefZfVARtcGGv48x1Kj2+3/Bg+AQbkG3kVfGjv4ZwQl3kvCZ
         AM2IDY+mEcbWdQJR834MJB2Rir++dLQORo6B3onaLdNv3L0k+xgbvPzHUq5Dj9GCg76y
         J9L4ukopYqRNJCU1Gvr61NuZbshwgXtD8lUfEp4TTzyMfi1stkycNkAh2CyUD/fCMNR7
         npjsZmBBhB/FN6LBmyiqVtLBkq3x6vdVd5ks03bbr8+evs+HLt0B4SXI1raJ1Wz236JH
         vDyA==
X-Forwarded-Encrypted: i=1; AJvYcCVn3sqUPg1NduGxGdzUJqa0ffG3Z998wATCeVgTmDqoW27Iyg5vp3r6eTPipA5jXEl63+9/TyyBFQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyQUN8uQfX5nLdu9EqjzL+kKCX37zfJByrTsfYy50FINMOjfAQL
	NXzxecBI+h9/AwvKGM4+vClyOyYk0wSJUL8GzhzgaQRpEIsfE3cdY+DqoiJHhbbnOaE=
X-Gm-Gg: ATEYQzxObkm6RcPNGYgPDQ+PRApLNWcBzs8O//HY0IyllulNT5UOtumWlBLqrUX29JD
	fgz9UKvJ83vhU7FDrRqNYztW2xeC/odcON8ggfnVFQVXd5LVzEt8nK3xPOg4EOoKmoTSGeSyFSf
	IBobIh37yAxnHOGA1Ri4alBlREsQq0+knEt3PtWpTvVRf7vqHI999QA9hD6VVInNcjBNu1G7JFb
	T22Dqh0e1qhYYuanTqLKUb3zx7/ZFtakEoMJGnCdIekz1y4SN9084p51k0z4pw78Oy+ubIS74tg
	xWM+4HIMkNog5kndjBTdhKLFx5n1xxmi2mmK5t3yqZdxNBnQRiyM3KKmrju3bj2e0QU5wHVoRjA
	9GwgaeZ5QlXYQmLvxFxw7arQV8f+S0rZFXXpnpXuCOXgH8YZttoSspiUu2XxlkFhD/eNOE1CKiC
	hNzgP8BzGdTmVwp5Fp5TQ+Ic5yBxlfkcpHs97OLDSOCoglWhYW5aZtKJxLWWbWRAixOPaHqjM+p
	oghyIk32D48grg2fA==
X-Received: by 2002:a17:907:a09:b0:b87:117f:b6f9 with SMTP id a640c23a62f3a-b9351466c1cmr242535766b.8.1772111497969;
        Thu, 26 Feb 2026 05:11:37 -0800 (PST)
Received: from puffmais2.c.googlers.com (244.175.141.34.bc.googleusercontent.com. [34.141.175.244])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b935ac73d2asm55125866b.26.2026.02.26.05.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 05:11:37 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Thu, 26 Feb 2026 13:11:35 +0000
Subject: [PATCH 01/11] dt-bindings: power: supply: max17042: add support
 for max77759
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260226-max77759-fg-v1-1-ff0a08a70a9f@linaro.org>
References: <20260226-max77759-fg-v1-0-ff0a08a70a9f@linaro.org>
In-Reply-To: <20260226-max77759-fg-v1-0-ff0a08a70a9f@linaro.org>
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
	TAGGED_FROM(0.00)[bounces-43245-lists,linux-pm=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D28EA1A6292
X-Rspamd-Action: no action

The Maxim MAX77759 is a companion PMIC intended for use in mobile
phones and tablets. It is used on Google Pixel 6 and 6 Pro (oriole and
raven). Amongst others, it contains a fuel gauge that is similar to the
ones supported by this binding.

The fuel gauge can measure battery charge and discharge current,
battery voltage, battery temperature, and the Type C connector's
temperature.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 Documentation/devicetree/bindings/power/supply/maxim,max17042.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/power/supply/maxim,max17042.yaml b/Documentation/devicetree/bindings/power/supply/maxim,max17042.yaml
index 14242de7fc08..055d1f2ee0ba 100644
--- a/Documentation/devicetree/bindings/power/supply/maxim,max17042.yaml
+++ b/Documentation/devicetree/bindings/power/supply/maxim,max17042.yaml
@@ -20,6 +20,7 @@ properties:
       - maxim,max17050
       - maxim,max17055
       - maxim,max77705-battery
+      - maxim,max77759-fg
       - maxim,max77849-battery
 
   reg:
@@ -28,7 +29,7 @@ properties:
   interrupts:
     maxItems: 1
     description: |
-      The ALRT pin, an open-drain interrupt.
+      The ALRT pin (or FG_INTB pin on MAX77759), an open-drain interrupt.
 
   maxim,rsns-microohm:
     $ref: /schemas/types.yaml#/definitions/uint32

-- 
2.53.0.414.gf7e9f6c205-goog


