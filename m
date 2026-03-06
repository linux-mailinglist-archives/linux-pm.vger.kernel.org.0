Return-Path: <linux-pm+bounces-43782-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GGlrO3StqmnjVAEAu9opvQ
	(envelope-from <linux-pm+bounces-43782-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 11:33:24 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A9D321ECC8
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 11:33:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB24B30626D6
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2026 10:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4638937CD38;
	Fri,  6 Mar 2026 10:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Kak40Ar1"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397D037BE69
	for <linux-pm@vger.kernel.org>; Fri,  6 Mar 2026 10:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772792997; cv=none; b=laBFjaQimw6gGBL2Qhu112vXb2j1MuIY4sQeF+HHEhXuDsxc3D7PGMyYSawzL1L0O6j2C3unJLTOo5GsT9AEs385+65/QXFNW2xtkgfsWKoPWemraNMg0YZwJYdOhlm85Ycd6J+vPUBRFVoLijYPyEmNzDNobTe96afmMyciN1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772792997; c=relaxed/simple;
	bh=R6jX4fq4k8WouHrMjpV3xcNoRh3zGZocqcq1Z9Kg55w=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=EsCs3wgtyxBnEig65U6XAo//9tPeRcuZytJmArbODoR1vQMwOcZ/Ar3nfYGLfAhrwC9IzRhfXRSl1AQtHRHDbQKRNyavhysUzoexBYs8R+5XBa+4LkeO63IE3+AvJ0DcyVe3npMMWKMjYGgAN8/GtvUObWmXbR0+R1jU58a/FXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Kak40Ar1; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b935cd1c6f3so1397117866b.3
        for <linux-pm@vger.kernel.org>; Fri, 06 Mar 2026 02:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772792995; x=1773397795; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5PvtQLAwyimVW6/tRnss8RiKpGBnGc7biXK7tOFe0QM=;
        b=Kak40Ar1HBc2J68SbPWxBcIzeEJyfsra+7GuAwpDbOtD0qvmPNr+oTdib2K9C05wCJ
         rCrqGE8sdNxkzhJ87Pr8mqmvHiDXBdOr/7PJAtb2Xvo37DsvqD0KWB8dTM7O44vRCXlE
         w4Emuu3JCNzDb8EevhxUCWD+FoKKoWhnmtC7BJlga8YU0/e0GLvAk7cHoHz7LaGdn7CT
         zZ7w2dVJCj8AU38gSi/+qKr2BePbHbiRxMoacKNGNEdi/EE3OBbTGJS6CJQxeZKULeOB
         z1gXb+TfLm967VhXFDQYsjq9pbWTIiEx3WLdqHb9VbBYHXp2hWQ2qjQuT8h2i5tRoU16
         9W9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772792995; x=1773397795;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5PvtQLAwyimVW6/tRnss8RiKpGBnGc7biXK7tOFe0QM=;
        b=ECGe9lsA01Kgmpf9N5IooxdwwHdIe/Vq11i+zHXB3QnAT5YLPvPmvuwi16QECOAt6O
         gYXoDpU7yiuf+ZiNn96oCsHK5wsNOi7/jgiaXCjIzUjkRkwAPkTXcA5B2cQcucD0AdWP
         qzZg9ynATUeEU0iY9KIr7D1JHU8QqRpRXD+M9alfdwABB1GIvxdHQ9LWIGql+MzJ4ydF
         hWetNOVJYEFR7ZDz9D6MQO5XgcSSTvTT7/yuxtllxbix4RU+2AX87Qcgh5jbUuIF+xgZ
         PtzKfez62NrAZOgVzT7SwBO50Tq6EhvTdoWrkeuTl2dmYn1IlqR9IHFpASacOtbCRli9
         Xtyw==
X-Forwarded-Encrypted: i=1; AJvYcCWR+UpD9hjEllpEnBtlbGgdDBoiy4Avnb4MKAKl0TlfBKuGvkT8IcYSYHS745jfAIfkiCxHZFannA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxoj52AlCnZg9P01pjLHmA+mqfUaT9rXoHJ8wOvz8P1MlMf+Sem
	JtyDWkQ1AeWpyFWM/auAsF/RE4FRobGACoDMEtyuD4iMnq1SHKXkiSu1aP+7JcalEpU=
X-Gm-Gg: ATEYQzy6f+NJICri97MiaFHEvdPjzFuxto4/q+39gEuDs1fBnoqcFt2i1eRopbN7d4+
	ePGmGS7btaN0uWY0c1KBgA6Ki9GGsEKJpuQgDDZBqQOloa3oobp24wBiww2Ho9bjhNTCr34GX1i
	yztbuBIOmWy0vtvCH9chFeOaSjRMW3U0Youf6P1M+FLZW0bfM+OudXy3N0zdmODZSumGqUofLal
	csFnXLPswn2XzFixrrE3UoX2kmdYdW19melEm3rO2Y+VgJ0RVYuHdc0ciy3YJ6Mu/d2JJSJK/V2
	osyIpNd8bxRlGCUHKbvlCd8UxV1dx5aW/4DVG8dL/tLjIoYWZMZdOG1a8YODBLyuFSGhLPLIhA5
	t2GMa82wOSFLqEGReXsj2pbtD3gY0O0+RvZ8Ysrxwcx3l11ODkcrjD5lCx8t942hhP97CX5jNm/
	u+3txk5FpumL+hmln7iw4yyNepPULOSGqGaVBVLoLbqmuzf5Q9Vkc7hPp3i1QMpqHtMo94PInfO
	9d3C19Kb6lrZ3U=
X-Received: by 2002:a17:906:7307:b0:b8f:6696:f81d with SMTP id a640c23a62f3a-b942da7798cmr93636766b.11.1772792994492;
        Fri, 06 Mar 2026 02:29:54 -0800 (PST)
Received: from puffmais2.c.googlers.com (221.210.91.34.bc.googleusercontent.com. [34.91.210.221])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b942ef8c95csm42907266b.21.2026.03.06.02.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 02:29:54 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Subject: [PATCH v7 00/10] pmdomain: samsung: add support for Google GS101
Date: Fri, 06 Mar 2026 10:29:51 +0000
Message-Id: <20260306-gs101-pd-v7-0-03f7c7965ba5@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAJ+sqmkC/2XNy2rDMBCF4VcJWldldB0rq75H6UI3O4JiB6mYl
 uB37yQQrOCN4Ah9v26s5VpyY+fTjdW8llaWmQa+nVi8+HnKvCTaTII0AkDwqQk6r4knnaLDhOA
 Hzej5teax/D5Sn1+0L6X9LPXvUV7F/fYZsXtkFRz4CDFABJE9ho/vMvu6vC91YvfKKnvpOilJq
 lF7m4L0o3IHqTop+j8VSQwK0KFyNuNB6qe0IOTQSU0yhowhGa/BwkGaXUownTQkc8raxRQMenu
 QdpfqRVqSQwzOqCg8SvUit237B1h9hPfDAQAA
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
X-Rspamd-Queue-Id: 9A9D321ECC8
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
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[kernel.org,samsung.com,linaro.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-43782-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[linaro.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andre.draszik@linaro.org,linux-pm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
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
Changes in v7:
- really be consistent with quoting (Krzysztof, patch 4)
- drop invalid tested-by tag (Krzysztof, patch 3 & 4)
- Link to v6: https://lore.kernel.org/r/20260305-gs101-pd-v6-0-8cb953c1a723@linaro.org

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


