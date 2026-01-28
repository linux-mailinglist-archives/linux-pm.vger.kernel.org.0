Return-Path: <linux-pm+bounces-41622-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2NXwGus1eml+4gEAu9opvQ
	(envelope-from <linux-pm+bounces-41622-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jan 2026 17:14:35 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EF333A54CF
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jan 2026 17:14:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 68881300A514
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jan 2026 16:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A787330DD03;
	Wed, 28 Jan 2026 16:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kUmtfpGk"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3EE23090C2
	for <linux-pm@vger.kernel.org>; Wed, 28 Jan 2026 16:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769616656; cv=none; b=MJY8Wxhy+u+kyt6ITFW9C2HbFj1r6lAj5dbEY3F2wWWd4STA7lGLt1BTuCiTdtGOxcPFJKGWsh78g/M4mFbQqlNGA8yU0cSILQBG9iha7nck0pNHBh4RTM0E57qBs1tn/7BxGmix3Ulnxb3y+jur/HMOYWTgFumYkW+EfyG3DtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769616656; c=relaxed/simple;
	bh=N4JpNWAJ8z+Zh2xDD+z/ESazuy8Zh1rNG2zbFITp4kY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=D7hbXFas2yth/V1dMnPQKVvBra7iMnKRTLjTTDNM/ID/tc+BTUs02LsDz/sBxhi+tCS1yej5r421jHYpL7B2eruUVm2q2n7p9c/xEHNuoYv8xAqiPyBJqwVOMl+pbXiqiHao45II6o6PxCTSmqqJDwgBH1a6s3/mdOP2r57UFdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kUmtfpGk; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6505d3adc3aso56464a12.1
        for <linux-pm@vger.kernel.org>; Wed, 28 Jan 2026 08:10:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769616653; x=1770221453; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZNtEsD/7Ir/dUUyhxp9vhIGp+bMH6wePQ4vuvyFT4dU=;
        b=kUmtfpGk+y1Po5L9WbRjGjjeOS3zyaluAuOecDHbQL39C/3NQ90m10XsHMeJWgMtic
         WXjXVMbyMmzYXzv6wlCiDIjbxGFC5BtFthpf/fw9Nqv0i+em9/PGKAq1M9kXCWEw2aQ4
         RW/PtGBL5NweHquSZcl+5N8hWTKlBtclwkuH7NyDAOpNASYqpE1dcRCZmZ6BmlRoMcNK
         KAu/GhbUd4pJx43Qu2w6ggvqZHdGMMH7FfeoTxKWBZp9UJX3PtcFBxuOdL/VjgHPQeGX
         /XM7N2fzXkVv1FYXbiQVij51fsBRSc8zrXwBYBcfvdsdWguY+5leziE4CDiB6YM5KCUK
         Opsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769616653; x=1770221453;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZNtEsD/7Ir/dUUyhxp9vhIGp+bMH6wePQ4vuvyFT4dU=;
        b=VbKzKnu1wRfpRirA4fHz1l79tB/IarZdTMeE3eKvydZKTruSpIEyAvG/lms2njtBNe
         jy33QObz3+KeF0S1yE9khqVJJE7prT54ZfmsMZvFyVGIOtX3Bj5F0tcDxB/m10MBcu0O
         5y5Hqssj9d/KVpqmTiPlwbESZj1y9BBzgPT+V+PNuERsNBaZyLnGtgXKY+4A1yO7RvHC
         EWPKW/2zZmAOg1LYffzjbsfiHfPFmCU+i7jTNzMiflmKcU20ac6uW3g6kmjNB5gLns6C
         cWrs0oUssqSHZqrzYKPZM6aoK6/c2yf/BXpeF5Q5RoFwixrNjL55T3lMtOiQZufXfDhg
         8zlw==
X-Forwarded-Encrypted: i=1; AJvYcCVIfUHaDn+pqS4kEhD9jA+05cLex7FQyJxRTynoVy0oBBmaRXPLZu7vF72v3UjljLyOBufqj6Umhw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwtKnKJfUnKcJZuGc5cr2VtPvkpUxkiIfSIN+hdekw4EDfz0xcz
	LhqC9FrvBPjGCxgE87juUpvQkiSDW80KO6yRA+zMjGU9TAuph6WchfBQmrB3woW375w=
X-Gm-Gg: AZuq6aJUa/AQ4kEHBwJ/BexDQsY/QuvIpGX554xL9eI7QNrY54z0wN/4C2GI/3od4jI
	SrTHa3/1ZFuC5BZLnTItKSa3lRz7FfoJ2mREQUB7NBcekSI0qNpVptIsXa6z2gX/aJ7Aiozpwji
	IF68dE3htt3kH0G7NhbU5yEP6sF3rmAgsPecfqPqX0q3+njXEPrEWUVzT6A9BxFG8Eqb/KdoTnC
	nc+zRT6HsXSqiMRVBnre0Pxgziiyzt7lv1DolmZtjiluQ3IDQBOJeik4d4WgipVVqVrTlR1et5H
	Mx5s6nZ5kJBBLBcrG3qIqndPrAhGAoJlv0i28U25UqmKyEIpPXcfNatmgvz1+2NhWP5nXUne3TJ
	wLm41+FnKNk9FTFJr9kKV5dhiBivmn4UGGQ0k/aIXBccbHM9z7phLEVlyO2md66NWtdDFgZMUgm
	FNBHBG86paamxgHDk7Z3CwmMV9GfEBlrU8HJ3ZwXex50wCCVmrTonCJ+H86C9Nefwtf+iCyAQsM
	ZigAA==
X-Received: by 2002:a17:907:da6:b0:b76:b632:1123 with SMTP id a640c23a62f3a-b8dab33b16dmr439788766b.42.1769616652975;
        Wed, 28 Jan 2026 08:10:52 -0800 (PST)
Received: from puffmais2.c.googlers.com (244.175.141.34.bc.googleusercontent.com. [34.141.175.244])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8dbf1c021fsm148553366b.49.2026.01.28.08.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 08:10:52 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Subject: [PATCH v4 00/10] pmdomain: samsung: add support for Google GS101
Date: Wed, 28 Jan 2026 16:10:49 +0000
Message-Id: <20260128-gs101-pd-v4-0-cbe7bd5a4060@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAo1emkC/2WNSwrCMBBAryJZG5l8bIwr7yEu8m0D0pREglJ6d
 9OCGHEz8IZ5b2aUXQouo/NuRsmVkEMcK/D9DplBjb3DwVZGFOiRABDcZ1LnZLHl1khhBagTR/V
 8Ss6H55a63ioPIT9iem3lQtbtJ9J9I4VgwB6MBgPEKaEv9zCqFA8x9WitFNqasjFpNZnnqrOaK
 s/kn8kak7Q/WTWFZiCkYLJz4sdcluUNl9IgBxUBAAA=
X-Change-ID: 20251001-gs101-pd-d4dc97d70a84
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Ulf Hansson <ulf.hansson@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, Juan Yescas <jyescas@google.com>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: b4 0.14.2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-41622-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,samsung.com,linaro.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linaro.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andre.draszik@linaro.org,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,linaro.org:dkim,linaro.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EF333A54CF
X-Rspamd-Action: no action

Hi,

This series adds support for the power domains on Google GS101.

There are a few differences compared to SoCs already supported by this
driver:
* register access does not work via plain ioremap() / readl() /
  writel().
  Instead, the regmap created by the PMU driver must be used (which
  uses Arm SMCC calls under the hood).
* DTZPC: a call needs to be made before and after power domain off/on,
  to inform the EL3 firmware of the request.
* power domains can and are fed by a regulator rail and therefore
  regulator control needed be implemented.

Bullet points 2 and 3 are new compared to previous versions of this
series, and related changes are in patches 1, 2, 9, and 10. I can merge
patch 9 (SMC call) into the gs101 patch (patch 7) if preferred, but for
now I kept them independent to make it easier to see changes compared
to previous versions of this series, and because patch 8 actually
applies to not only gs101, but to many newer Exynos SoCs, and to make
the two patches themselves easier to review and reason about.

The DT update to add the new required properties on gs101 will be
posted separately.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
Changes in v4:
- drop unneeded or already merged patches
- drop patch "pmdomain: samsung: convert to regmap_read_poll_timeout()"
  as Marek reported issues on some platforms
- rebase
- DTZPC related changes
- Link to v3: https://lore.kernel.org/r/20251016-gs101-pd-v3-0-7b30797396e7@linaro.org

Changes in v3:
- use additionalProperties, not unevaluatedProperties in patch 2
- fix path in $id in patch 2 (Rob)
- drop comment around 'select' in patch 2 (Rob)
- collect tags
- Link to v2: https://lore.kernel.org/r/20251009-gs101-pd-v2-0-3f4a6db2af39@linaro.org

Changes in v2:
- Krzysztof:
  - move google,gs101-pmu binding into separate file
  - mark devm_kstrdup_const() patch as fix
  - use bool for need_early_sync_state
  - merge patches 8 and 10 from v1 series into one patch
- collect tags
- Link to v1: https://lore.kernel.org/r/20251006-gs101-pd-v1-0-f0cb0c01ea7b@linaro.org

---
André Draszik (10):
      dt-bindings: soc: google: add google,gs101-dtzpc
      dt-bindings: power: samsung: add google,gs101-pd
      dt-bindings: soc: samsung: exynos-pmu: move gs101-pmu into separate binding
      dt-bindings: soc: google: gs101-pmu: allow power domains as children
      pmdomain: samsung: convert to using regmap
      pmdomain: samsung: don't hard-code offset for registers to 0 and 4
      pmdomain: samsung: add support for google,gs101-pd
      pmdomain: samsung: use dev_err() instead of pr_err()
      pmdomain: samsung: implement SMC to save / restore TZ config
      pmdomain: samsung: implement domain-supply regulator

 .../devicetree/bindings/power/pd-samsung.yaml      |  29 ++-
 .../bindings/soc/google/google,gs101-dtzpc.yaml    |  42 ++++
 .../bindings/soc/google/google,gs101-pmu.yaml      |  97 ++++++++
 .../bindings/soc/samsung/exynos-pmu.yaml           |  20 --
 MAINTAINERS                                        |   2 +
 drivers/pmdomain/samsung/exynos-pm-domains.c       | 254 ++++++++++++++++++---
 6 files changed, 395 insertions(+), 49 deletions(-)
---
base-commit: e3b32dcb9f23e3c3927ef3eec6a5842a988fb574
change-id: 20251001-gs101-pd-d4dc97d70a84

Best regards,
-- 
André Draszik <andre.draszik@linaro.org>


