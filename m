Return-Path: <linux-pm+bounces-43641-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eA4WLLMeqWmL2QAAu9opvQ
	(envelope-from <linux-pm+bounces-43641-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 05 Mar 2026 07:12:03 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B8E20B2DB
	for <lists+linux-pm@lfdr.de>; Thu, 05 Mar 2026 07:12:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D4827301221F
	for <lists+linux-pm@lfdr.de>; Thu,  5 Mar 2026 06:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A74328CF5F;
	Thu,  5 Mar 2026 06:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C9yxUMxi"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DF2288AD
	for <linux-pm@vger.kernel.org>; Thu,  5 Mar 2026 06:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772691116; cv=none; b=cmX/fM2Dlc3oWOkFBD+sPBF7FoFDrQE36rHQ/QVmv0nlLBuQo8e79O1VJ6Jh7a3AEf1HykyzkeqRwa8Rc+T0M4zcQESuVcsqz7nriuMF+gkeZWx91DbNNl6GMDRrTlzvI5fOuw12+D+DirdyrFQrK5hDoa0vBn6on5xdB5hMwX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772691116; c=relaxed/simple;
	bh=tUpTwQUR5c6k32kkb5RaDrfApr1ZlqcpB5g7VG2FaiM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=PBSuUODd6/cUpzHeP5lmuTc3m/ueJjPi/1cXzSp5dPek6tydNZKj7H0d1z3W7U0RkG6ZulDJfyD+DQ8IkxOlehyvwk47iAPwXJMlSDg5gRzsUtAxNhS384Y3rT4nUKu0Uz0nwvHuumNodskbvtxekV2SGDCVVQnPvNxjsHHwCyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=C9yxUMxi; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b8fb6ad3243so1127970866b.1
        for <linux-pm@vger.kernel.org>; Wed, 04 Mar 2026 22:11:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772691113; x=1773295913; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WfslmvgIdI2+lkhe/ajja/biDUUS7aCfKq3X/UX+k4o=;
        b=C9yxUMxiFAw+tRi5NJ9G7C/gASKUcgrcSD7B9n25O4bBGOTnl2w+kNpqYW66Us5UJ1
         gnCffiJ9FUvePgoHpEiWzPojvjnl537q3cUrwfEtbr8Xv4bVpI/TkSUwZtpIX5UqYnOr
         +X0PjXmM8STaRFh5wYK8Ev8S6BsIh3AzAGoD/qHaUU7A2uku31C0F0By5Y32E+iWeY5v
         ABFwn9ovJYI+zd8OkOxTXUte0JJ9GAPYO1k+o9L/VmSQJuCu2lTSBcZrfSPYmJbtvSeN
         gOZmDhyeDJkWxId3KCIjeFclvHn725CiqLX54xeaZgawQbLXaX4bSvBrEwlTTZGW/N6U
         ByIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772691113; x=1773295913;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WfslmvgIdI2+lkhe/ajja/biDUUS7aCfKq3X/UX+k4o=;
        b=ZYB97bVd1IKtQwf/csoWYVrpJaJN5O91P9Irad3O8QYoHaBzeuUJ4/gp29uUWdgUaF
         /+2fH+aT0CLd6SxLXT9hhkToNItVbHSAkG5QzYofz40AFV9j6dUNxczcOhMVSceKlNaG
         asz4FsarRGTnM7R56PuGzbrnBBuBxQETBMPDjRBd8j4+4zeNRfoCZuPuruWTPf3E3vtS
         cE4F4qM+P42TP9HAYUQR3k5Ele2KKc2ZCgwvsEg0wGoGbDGUPAXGBSutsE/C72wzWzeA
         aX7p8EBuyazhqfPRRtp28YaA88tbUAGpIfsOZqfVPDyq3NQYEpDufv/1sNO4Z3/Ta74B
         kAFw==
X-Forwarded-Encrypted: i=1; AJvYcCWK0Okia9s4fQILqsSbBoN1Eg8GsQlvbLKqwly9N9JYbcNg5ELs2K146Bjh0jBOAW95mphC/79hFw==@vger.kernel.org
X-Gm-Message-State: AOJu0YySpeRP7fXkh99qCHBu6mCoZRSnrNg8QAXmzvZwpGXQA78DQJlg
	vCSB5vyeV5mqVvcJfnnp3Jn+Xf1m5h4pen5T9tTIgIUCXRQlvydNs4xADTYY478ORpo=
X-Gm-Gg: ATEYQzx1XexZUblg+iVCH8700p3Egxf571GANJMfdVeYibgIMtXxB/YtsUZUK0CkpUL
	CQLd+1lN4W4UAwMxir8rO+WiXczOf6mY7mXV4LtyjVy3vmHKaMZNuq0lr+O7Dcmyblq1fCST4k5
	DLsN81FcxWakjeKCUETMTb6xYFUC6pAyv2e/3/itEvIhAXDn/lS0fTB2c4TItZQbFoyJPpHI9r+
	ZjxtWattmrqLZinECmWm7dLNGXhg3D9YAP6iCMrc7l09B9ldfsB7rRwQmWYHM93eOnm2vn03twu
	heKg7Wk/zsibCKWljOZx0DIxefFx4FKOIoMvH34y8IGujkYI1HNA45BG58MczeevxBeQ5sgH7LD
	OukSN/5KE4NJ7lGCqyh+bP4Vd2c1e+mcMsV8XjoUkQyEBZnWqzjzx842lY0inViBwHStmYU/7sz
	zYuu2eaSrFkMBPjR6I0h61H27CyBDdS6AnuuTcL0gnXQZbPuIstIGfWGrnyjbEOQG2qV9RBinfE
	MdLF4SrkBp82+w=
X-Received: by 2002:a17:906:794f:b0:b88:5a74:4cd6 with SMTP id a640c23a62f3a-b93f145f23bmr296129266b.43.1772691112851;
        Wed, 04 Mar 2026 22:11:52 -0800 (PST)
Received: from puffmais2.c.googlers.com (221.210.91.34.bc.googleusercontent.com. [34.91.210.221])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b935aec3243sm849355966b.53.2026.03.04.22.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 22:11:52 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Subject: [PATCH v6 00/10] pmdomain: samsung: add support for Google GS101
Date: Thu, 05 Mar 2026 06:11:49 +0000
Message-Id: <20260305-gs101-pd-v6-0-8cb953c1a723@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAKYeqWkC/2XNzYrDIBSG4Vsprutw/K+z6n2UWajnJBVKUnQIL
 SX3PrZQ6pCN8InP64NVKpkq+949WKEl1zxPbdj9jqVzmEbiGdtmEqQRAIKPVbTzihw1Ju/QQTh
 o1p5fCw359kqdfto+5/o7l/urvIjn7TtiP5FFcOADpAgJBAUXj5c8hTJ/zWVkz8oie+k7KZtUg
 w4WowyD8hupOin6P1WTLipw3ilvyW2kfksLQh46qZtMkVxEEzRY2EjzkRJMJ02ThKR9wmhcsP/
 kuq5/H2ldR4kBAAA=
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
X-Mailer: b4 0.14.3
X-Rspamd-Queue-Id: B8B8E20B2DB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43641-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,samsung.com,linaro.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linaro.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andre.draszik@linaro.org,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:dkim,linaro.org:email,linaro.org:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
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

Bullet points 2 and 3 are new since version 4 of this series, and
related changes are in patches 1, 2, 9, and 10. I can merge patch 9
(SMC call) into the gs101 patch (patch 7) if preferred, but for now I
kept them independent to make it easier to see changes compared to
previous versions of this series, and because patch 9 actually applies
to not only gs101, but to many newer Exynos SoCs, and to make patches 9
and 10 themselves easier to review and reason about.

The DT update to add the new required properties on gs101 will be
posted separately.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
Changes in v6:
- collect tags
- patch 4: update commit message footer to clarify that while
  old/existing DT are now incomplete, they'll be updated once binding
  is accepted.
- Link to v5: https://lore.kernel.org/r/20260205-gs101-pd-v5-0-ede49cdb57a6@linaro.org

Changes in v5:
- add domain-supply to binding (patch 2)
- Link to v4: https://lore.kernel.org/r/20260128-gs101-pd-v4-0-cbe7bd5a4060@linaro.org

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

 .../devicetree/bindings/power/pd-samsung.yaml      |  33 ++-
 .../bindings/soc/google/google,gs101-dtzpc.yaml    |  42 ++++
 .../bindings/soc/google/google,gs101-pmu.yaml      |  97 ++++++++
 .../bindings/soc/samsung/exynos-pmu.yaml           |  20 --
 MAINTAINERS                                        |   2 +
 drivers/pmdomain/samsung/exynos-pm-domains.c       | 254 ++++++++++++++++++---
 6 files changed, 399 insertions(+), 49 deletions(-)
---
base-commit: fc7b1a72c6cd5cbbd989c6c32a6486e3e4e3594d
change-id: 20251001-gs101-pd-d4dc97d70a84

Best regards,
-- 
André Draszik <andre.draszik@linaro.org>


