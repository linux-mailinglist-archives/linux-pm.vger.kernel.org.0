Return-Path: <linux-pm+bounces-42174-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MKEbHdYOhWms7wMAu9opvQ
	(envelope-from <linux-pm+bounces-42174-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 05 Feb 2026 22:42:46 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF50F7BEE
	for <lists+linux-pm@lfdr.de>; Thu, 05 Feb 2026 22:42:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 445393012E90
	for <lists+linux-pm@lfdr.de>; Thu,  5 Feb 2026 21:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81D0633291C;
	Thu,  5 Feb 2026 21:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QQQjYSYJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com [209.85.218.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C0A3328E3
	for <linux-pm@vger.kernel.org>; Thu,  5 Feb 2026 21:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770327754; cv=none; b=GCetaUHbIE3zF0M/FaKkU0JvVkAYPURSjZUOjbkE0624750m/kuDiqjrE8bjnp+xQ6W0PsOYbCAOb5Heoa/j1YZK5Wtup158bxNHk+mssqXPVQzcMpUcn+t76Xdu3n0bAjzgCdEatPYeqgfaodgeELkILoeot78S3W1SrARCoUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770327754; c=relaxed/simple;
	bh=RG/479Qxl4EQWx4UO+uB67bqkziiDabgau+g461xf5w=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Caza/2vcSBdcuKl4vFacIHbLB2Jen+VSiQ84v7aJcJD3pCfwzc0066z5qn9AIOsr/UMyG/cZCZZuBYfq+D0KV5COB7AZao7CRqxe6BpwY63H/mL69ZJaClQ3GDQr8dPFav3ucRM6W3uRCtYYN++I1DvA7MPko6U2FEjZB6+hhg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QQQjYSYJ; arc=none smtp.client-ip=209.85.218.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f66.google.com with SMTP id a640c23a62f3a-b8845cb5862so204171266b.3
        for <linux-pm@vger.kernel.org>; Thu, 05 Feb 2026 13:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770327752; x=1770932552; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qXPRumbBfZZxqaCk0CZTR3vdblmJxj3Gzg1b+SHujwo=;
        b=QQQjYSYJHAYWVPWUfdKdJtdBS5H1BcSqGuNOzOLSC0q1ycUHmpxNtMLHnnhRbDWBSY
         FqrBbRyj15sEx4fFtejjfZgWm1Y/CC5VO1XyU0PXBDn4UMqo+s3RyppE/jil4JULQf4R
         IIZEHvLBFaDm5uKjfZlKdJ3I9YJY9n74+ZmwCC0MFdAoBoed2lkhowxg3jjFtA3RAkSo
         gvH/xk/lbfR0bubyqGPES0qvY8t/vh3YzRFyGJKmS2MwKOJVPptR6MO4nqoGqhry3yfN
         O2bWBdqnob6z4VQ/x9ul1jRBNB/pDi8+dTOlRXs55kW3eD5zlIQftPSaG1bNffDEDxCk
         7f5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770327752; x=1770932552;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qXPRumbBfZZxqaCk0CZTR3vdblmJxj3Gzg1b+SHujwo=;
        b=gwRWg9b20uZ8O0QpMFph22Uq9AxgYROTXZmxfvVUmu3FPyFr1EvA49W1AKNDU2v73d
         Sb7Fj8fTPfYfQgjiXx93jF1GRjLsjk/G1RBDRG5qYMeZpS+7Id5YdnUSBycWu9JhuPYz
         0Vz+sICKNbqWw3I/awFKhHAHrswP+eYkNHxXE/0CB9JryR5tapkoho58Kp3MJFc2yPpH
         DIpA9L78DlSHmlYYwuEiBAAiM3NZHpmdQmiBvsoyPl3oXvl9SkIwu6uFgElqui1u50Vd
         gyOBK8m58x7jlOdO2o5kt1ZG3tqE5bGCTyfLVVYJ3WOXseT51YSvcPhRaMWIS+joKv0O
         9bng==
X-Forwarded-Encrypted: i=1; AJvYcCUxYFPjwaNzncKxe1/H06btrgemVeo3QdAOApOp2eaRrUVIo1GxwdU/JcE49K6ofsDdgnXslc/z9g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/mSAQYm3ts3zJebVYvyCm35U1g+DQxJZEq/1elJJY1aPYblW+
	1L70dlWV5sdWZLWOeXj6K0kw4WknzBgKZU3qY/GwOYSi/Mo8VdWGCqKQyzC/vv/qsLU=
X-Gm-Gg: AZuq6aIgTyQbRhAI+RCB2YqYxUQjugE4D8MTIV+iMeiZpaIaEzDDZtZx6rlCQHwvCAG
	5S8187ZYo2et/wjcXds1IqeL+pExjDwwfnX8U0m7Nyrms6++MQcMxcdE3tDW2MIigBxY/MDD5lP
	zC4E7xl1QjENL3Ou1sZmIf4DT5EQGD3oFVGd3iU9SspC1gw/VFV0tcphwM6RknH+n8TFoRsqrRL
	WuHvxgCTlpkOfoj7BKPQGbxC8aaLNVctqqfv4+GpB5kW4+MJQEUDtdY4GfFWTrUjwVj5U6teg8E
	SfiHXkPl4ngQ9zHMbk2fNyjISoVO0aIC4lvOjd/bG/lgohAW9/dnK8HJ8zDbsJf2kT3MiWkvoJx
	SSLV1uL52cqF+ARFfzzvNv2cc2VsJ57m7N0t545JOPgtNrTxDdv+ixRZmY2yVHcvuPcqBAMs5qw
	+PNA8fVxMgmhitgLzWRm1eMQcFN7R29MUg4+FKNlnOF/lKotO1Nvcg39rVuA99r6I3Kyyo5HYh6
	PDGPQ==
X-Received: by 2002:a17:907:a4c:b0:b88:637d:aa75 with SMTP id a640c23a62f3a-b8edf378326mr26959066b.30.1770327752121;
        Thu, 05 Feb 2026 13:42:32 -0800 (PST)
Received: from puffmais2.c.googlers.com (244.175.141.34.bc.googleusercontent.com. [34.141.175.244])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8eda7a0074sm21859966b.18.2026.02.05.13.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 13:42:31 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Subject: [PATCH v5 00/10] pmdomain: samsung: add support for Google GS101
Date: Thu, 05 Feb 2026 21:42:28 +0000
Message-Id: <20260205-gs101-pd-v5-0-ede49cdb57a6@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAMUOhWkC/2XN3QqDIByH4VsZHs/x9yPNHe0+xg78qoRRoSM2o
 nufBTFHJ8JPfF5nlHwMPqHraUbRTyGFoc+jOp+Q7XTfehxc3ogCrQgAwW0i+RwddtxZJZ0EXXO
 Un4/RN+G9pe6PvLuQXkP8bOWJrLd7RPwiE8GAG7AGLBCvpbk9Q6/jcBlii9bKREupCkmzZA3Xw
 hmqG6YOkhWSlH+yLKVhIJVkSnh5kHyXAgitC8mztMZL4yrNQcCfXJblCyIOtptPAQAA
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42174-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,samsung.com,linaro.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linaro.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andre.draszik@linaro.org,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,linaro.org:dkim,linaro.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EBF50F7BEE
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
base-commit: 9845cf73f7db6094c0d8419d6adb848028f4a921
change-id: 20251001-gs101-pd-d4dc97d70a84

Best regards,
-- 
André Draszik <andre.draszik@linaro.org>


