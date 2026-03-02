Return-Path: <linux-pm+bounces-43409-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6DpRLMyRpWmoDgYAu9opvQ
	(envelope-from <linux-pm+bounces-43409-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 02 Mar 2026 14:34:04 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 176A21D9D80
	for <lists+linux-pm@lfdr.de>; Mon, 02 Mar 2026 14:34:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC397306B2DC
	for <lists+linux-pm@lfdr.de>; Mon,  2 Mar 2026 13:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA603FB06C;
	Mon,  2 Mar 2026 13:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f1jVMBhX"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05473603D4
	for <linux-pm@vger.kernel.org>; Mon,  2 Mar 2026 13:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772458340; cv=none; b=YErb8hvoVxpvIEWAho+HEYUxs2cnJ46SPHNpiLRF2qS3QpWWpOFdLc4OXazsJLtqpvh/bnEx5F1A6LhB7pM2WLS+BZEZckP7AkmLwQ/y0iU4gWJ3Cj9xfxrz+2mss56JNHttkEh6PfF8izQfmzT6Tm7t1X2eqQn8cAsYqi8ypPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772458340; c=relaxed/simple;
	bh=sxd7YorxQK3s3bX7aC7ot31fSiw0w3sFEnl0PhhhGbI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GFbz7BzyS3xfjqQe/iOiSqX7Tmq5AM33yRQuE9uPL1y064k7C4xxS2URrnYC6CDZZalcd0mupA29Nz5FIV8nhghZI0NQwhFmx/4eoLYX39kdEKD0pKqFJUMj+ZNuPAlf/ok4X+ZBlmggExF/scyLAXcxHtdzMZjiFVK/f4Ce7nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=f1jVMBhX; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-65c0d2f5fe1so8894630a12.3
        for <linux-pm@vger.kernel.org>; Mon, 02 Mar 2026 05:32:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772458336; x=1773063136; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5UKScLMgRHs8hJKSYmXUtDVc/88opLYmEdJPHO4tTBY=;
        b=f1jVMBhXJ43Mhg/e7xo2IqsbukocgmHmNsNuQ07fa7KerCx8DzPypbaZl4chIR75nT
         eNdgePHfGVqAa+2uodWexE2LNEB/nuFgwx+NCRs4vUu5960bZqdiNXLe7iDo0A8tZvHx
         vM5I0r50K1bdw0zsM+t+dPws/HjoQIZkf2cm3m+HyJji/Z77y65OutaVnMrq9SgfA2HG
         8l+yJWsIw2ow9T+urs86CXw2/hzY8tkLRAWNXowzvvCj3IVLjm9kCWQ0hSp4C4qIrqX6
         sO9RA86LiVVm6amjHvJpQquO9/3dtZ8NPn/B5USn7h1gHQ0Mb3Ip6aT1q7rrnCg+gN98
         /N+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772458336; x=1773063136;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5UKScLMgRHs8hJKSYmXUtDVc/88opLYmEdJPHO4tTBY=;
        b=anOVa1aMtiGvAWhyn+WzhbFxr2Dpa9H/3/AjLuEwT65EzYeI0qOQctyJtRvOZaNdb4
         eLq3c9VfwnBspCoqf8gDEPGMZrjSyzFtU3tZm8O+olqiFkzrffAGV/x31Glh55j1Hpwk
         w1ZxMenxD5h2zI0GGZGKfaGi9qsGAe7PswB/CIWbvTyI47u/9a4d+GFD1E6WYpOCH1gs
         kjpZMGWarQrDTNVDtIn7CI/gM1I9E3B5l+VlP3mMv5Df17bMs0By5CXLZzCsF6ZtjPtH
         C6jDh0LgVtAXE/8aKwXSn34wTibUAVHQbLHZDfLtNRDPXgY9HyGc0CKq5Ro6cAORHpIM
         o16w==
X-Forwarded-Encrypted: i=1; AJvYcCXljKHHW62LkuKcERmOHtjw6I/3A1OAxJvv6mkVsSeUbxtPo0ZOEalLPH5Dgh/vdfDZ4zcZygpp4Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzSB/QbgO+cz3fvsjS9/q31D2hv3DV+TgFBk1DEpsDfa+VPZrul
	vbFrD9sECP61C2A16gL0FYgNCCV0nb2Ur0CZQ+TZEHTwVnsV0koM768SfQ1frLM4Gvk=
X-Gm-Gg: ATEYQzzPisRwcOuhSdV8jri9ahLhjnha/9OACRwsvp5KeUTqfv6ciD51xG5jBzf9vzF
	9NTCn7JCXIS1Cqut4wf6FnUIIWqgYHcwhPiartucTUd5TjGCvpZH8sv0jH7uvBWVgRczZycUTG+
	OMtSvD9lMcqKI8avA4ExSbp8Ncvi7BTg3J31Nq5xermNvM+UfhDGUmGFRix2PzOtFhVHrDnAR4/
	AVp9RNgVZXqiwrBbbJ6DycL6goIn4K+wLeIrelPviHnTuBjn9sLFwZaqNy2gp+FkK3zmgADmfeX
	l5KdIdWW/eCEb2vF0J4kqg4vOf/St/doBoUlnFvAbpJL8igSyFlYtcwUlhHQrTuU0gSctmzqWYJ
	xQ8BhpxqbZMs6S6hWcyAF53IzHTM5l+tRGf30tP4ZFmp454zLXY/SXy6DBY4megr3gPOd1kF1yH
	v34keoXSQCyDlVadXdphipovOZdyth4Pv9q2cRQRNJLEpLHOoRINyDYyr4v44fAaBOX81a1lY/z
	DifAdLPRIxgQrI=
X-Received: by 2002:a05:6402:2706:b0:65f:a619:22f4 with SMTP id 4fb4d7f45d1cf-65fddef77dfmr6964317a12.27.1772458336267;
        Mon, 02 Mar 2026 05:32:16 -0800 (PST)
Received: from puffmais2.c.googlers.com (221.210.91.34.bc.googleusercontent.com. [34.91.210.221])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65fabf6d1c6sm3282988a12.17.2026.03.02.05.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 05:32:15 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Mon, 02 Mar 2026 13:32:00 +0000
Subject: [PATCH v3 01/11] dt-bindings: power: supply: max17042: add support
 for max77759
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260302-max77759-fg-v3-1-3c5f01dbda23@linaro.org>
References: <20260302-max77759-fg-v3-0-3c5f01dbda23@linaro.org>
In-Reply-To: <20260302-max77759-fg-v3-0-3c5f01dbda23@linaro.org>
To: Hans de Goede <hansg@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>, 
 Purism Kernel Team <kernel@puri.sm>, Sebastian Reichel <sre@kernel.org>, 
 Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Ramakrishna Pallala <ramakrishna.pallala@intel.com>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, Juan Yescas <jyescas@google.com>, 
 Amit Sunil Dhamne <amitsd@google.com>, kernel-team@android.com, 
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Conor Dooley <conor.dooley@microchip.com>
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
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43409-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[linaro.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andre.draszik@linaro.org,linux-pm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,microchip.com:email,linaro.org:mid,linaro.org:dkim,linaro.org:email]
X-Rspamd-Queue-Id: 176A21D9D80
X-Rspamd-Action: no action

The Maxim MAX77759 is a companion PMIC intended for use in mobile
phones and tablets. It is used on Google Pixel 6 and 6 Pro (oriole and
raven). Amongst others, it contains a fuel gauge that is similar to the
ones supported by this binding.

The fuel gauge can measure battery charge and discharge current,
battery voltage, battery temperature, and the Type C connector's
temperature.

Reviewed-by: Peter Griffin <peter.griffin@linaro.org>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
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
2.53.0.473.g4a7958ca14-goog


