Return-Path: <linux-pm+bounces-39374-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C20BFCB19D4
	for <lists+linux-pm@lfdr.de>; Wed, 10 Dec 2025 02:43:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7842730CFAA2
	for <lists+linux-pm@lfdr.de>; Wed, 10 Dec 2025 01:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7796227BB5;
	Wed, 10 Dec 2025 01:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="IJwLtN6E"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCEB226165
	for <linux-pm@vger.kernel.org>; Wed, 10 Dec 2025 01:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765331019; cv=none; b=o9Q+DgLNVZll83YXCrFFmzENf5cWRu9yVxfY90c5d9w2wuMI8kOHePo/4U9Mmdp1LW5k63Kje7VrH2gKyPlB+6G71V35iC1/UtQ6Ic0B+m9iCJMAh5IC5ea+vlmkFyEweIiNWwh/j53e+iC7Lb5PmybeJLox/oc0ri7F+yDbzyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765331019; c=relaxed/simple;
	bh=W8/D6Zte+WLuzj1BAkQdHKSbz78N81zx1LJo/v0yIRU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=nnsM0MhZiL3AZIZEWCWL69wkhJhOig9oxO+FvUWpbI2Xw71mKtBbi+l4s4Z1fE6WIdHoXvrDDh3znVD/klDBoM2ezdnmuswdClgZrC3Q+eQ1Qcz2E8sfp/eyNeOL4pnpRdHSs4Ib7C3sPTJPj89YPN5pVZwROiYJjFR1WzcAvr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=IJwLtN6E; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-477b198f4bcso54227395e9.3
        for <linux-pm@vger.kernel.org>; Tue, 09 Dec 2025 17:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1765331016; x=1765935816; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=urnGBbYBlge0MPMnEMgs9eDhJcIT7BulOmvs3UtoNbk=;
        b=IJwLtN6EdeV9vU5oSoi58gNLustcSwmWA1Thi8i5/TGrsjiJbizz4ZMmFBZUrZdeTF
         znT/+KyTeIvIjyDyat1rs4FKnZu1IqOO9igv0tppQm+V2OrnsTKZeAYTRb2Y+b26kecI
         LX96d6dSTj8JerlESD5Me44d/XA3XsQ7wNG2gAf5qW1IG7IaN8MMTa2JLJbtw6bQUQ6E
         etlS8FqVzHZ3IokR1OWAcTlMoM/w4MgR1Uun5gFr5QRDh6oQCwRcgLzlZiJm3MXxTecr
         1oSltMo7YyabTtpt0CyYP/Zg+kbiUx+/kO0BWGT3FRdW2tc2zU32SFNtIWlgvbzfdlbE
         5mZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765331016; x=1765935816;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=urnGBbYBlge0MPMnEMgs9eDhJcIT7BulOmvs3UtoNbk=;
        b=wriBk6123HIrEt0WkMQh/DALfBdKKDn02VAF036NlPxn5Uun0wm5pz+KWneOC1yiTq
         a8dewb1JOaB6F/bU3mf47WJsLwTfiXrnST3zRENSPMrXk7dhiR7DXxnFa+XvOFXrMHzJ
         QmCAKTBXUKUaDW9UybztxeiS17NhwyTycr5rAPtbrqW9khJl+TWpc6b35G3HCL8yC+RM
         2EDFKbY0S6vsf97BTXqrjizhfQvEClQJa/HLD88/f1WBy2/nDb5NiBNwjF7y2wMiwc4E
         3vKmOTI28pljEFNVeJQiDZGJ6xR0w1M5gzVZTEgJPt4GcykuHzQZJCOI0mtvugHlu32S
         bmIg==
X-Forwarded-Encrypted: i=1; AJvYcCUtxfPpgXKZnkTMm/3Na3ULnzGxBGs60LuYAy9183g+ISru3gO0YJxSaWvO8iaBlp9ACeVUtWM0wg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzLw4Dla2xJ23WK8S0oNiswo0Ah+1TGGPP6fsUcGWuXp0HxOL9c
	wpamL5yDJ5DEG6RGl0uJCXeqd9+hrZIgxlvPMBwdIYZB4kJFMi282bhkJFyPrKWV6/o=
X-Gm-Gg: ASbGncuPvp8dXdaUFZZQ1Cy1wIEeEvWD8zIg1+I4W8tYLQkfQZYfB5dPvFKZIrNsOVl
	PtXa2gFVeCFQBF9Se6A5l8nJ50FwIeE/1VHVnj2T0Yn/rYxL/G2SjL8PYjoRCsnY+1mMR4mTMzQ
	9r6qehcogI2BAoYdgPtiXsVbkk786I0WdFO3wPymUWMJtRNZL2g7qQZIa2qzn66Q3YpJplZAViA
	IwojwhUuI50Ke9NjzWhvhNVhe0hyLOfbW3a5aZCit31zOEnM84D0YwTynA06uQzJcOm24vgwSYr
	uB41KjJML7oIYwoQqmOfdGpT5QGLSVXqLEhytu5VzFgSEOJdozXjJD70/9oSioMcDwdFCkccNsI
	JfXQtMNNKhKdJlaPBUVWpZWH1/D4JI29j31FIMllCrppWs44NyQAd+yXWBSogaQo18CfdmQh8P7
	i6jCAVtzS8TEVWLF9PkLfL38vNcoge4NnfRahV9kbjPcwRyycyiiTBrcZIaT00
X-Google-Smtp-Source: AGHT+IHVpoG1RYPG0Fo88j3DEV1z2Ax9xc3BWFe84CbZR5zOE94zc2qjuEfQYpMaSAgy5ZkutBnSVA==
X-Received: by 2002:a05:600c:444f:b0:477:7a78:3016 with SMTP id 5b1f17b1804b1-47a8374ce6bmr7128495e9.8.1765331016267;
        Tue, 09 Dec 2025 17:43:36 -0800 (PST)
Received: from [10.200.8.8] (p99249-ipoefx.ipoe.ocn.ne.jp. [153.246.134.248])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34a7000c984sm705234a91.6.2025.12.09.17.43.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Dec 2025 17:43:35 -0800 (PST)
From: Luca Weiss <luca.weiss@fairphone.com>
Subject: [PATCH v4 0/9] Various dt-bindings for Milos and The Fairphone
 (Gen. 6) addition
Date: Wed, 10 Dec 2025 10:43:24 +0900
Message-Id: <20251210-sm7635-fp6-initial-v4-0-b05fddd8b45c@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAD3QOGkC/23PzY7CIBQF4FdpWIvhR4q4mveYuKD0Mr2JpRWQO
 DF998FqYjLp8pCc71weJEFESOTUPEiEggmnUMNh1xA32PADFPuaiWBCsVZImkbdSkX93FIMmNF
 eKFdwYB68kq4ntThH8Hhf0e/zK0e43qqdX4+kswmom8YR86kJcM/06XPBDHkWBkx5ir/rUYWvj
 fe+2tovnDLaG9dLIcA63n15i3EepgD7OrKSRXwYzTe/UURl4OiN1UejmNpk5IcxbPsaWRnGuXY
 CvOed/s8sy/IHAZUpu3cBAAA=
X-Change-ID: 20250623-sm7635-fp6-initial-15e40fef53cd
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, 
 Herbert Xu <herbert@gondor.apana.org.au>, 
 "David S. Miller" <davem@davemloft.net>, Vinod Koul <vkoul@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-crypto@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1765331010; l=3801;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=W8/D6Zte+WLuzj1BAkQdHKSbz78N81zx1LJo/v0yIRU=;
 b=iidJCYi5UY3L2gSm3zjrS8o9I3QIjjHa+ajT0HkiP1WdsM3r384T3hm3AJhYRmiDnw4wKu6cH
 yxNWjdO9eZ5Ab46KfOFpWdoij5U2fQS5w4/32PzBKqpbp5SpBTf2udJ
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Document various bits of the Milos SoC in the dt-bindings, which don't
really need any other changes.

@Rob: Please pick up the cpufreq, crypto, and pdc dt-bindings, they've
been on the list since many months and weren't picked up by any
maintainers, so it would be nice if you could take them through your
tree. The patch for arm/qcom.yaml will be handled by Bjorn I think.

Then we can add the dtsi for the Milos SoC and finally add a dts for the
The Fairphone (Gen. 6) smartphone.

Dependencies:
* No dependencies on other series anymore

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
Changes in v4:
- Fold in PM7550 & PMIV0104 dts additions from their series, since they
  were the last patches of those series (Konrad)
- Rebase on next-20251209
- Pick up tags
- Link to v3: https://lore.kernel.org/r/20250905-sm7635-fp6-initial-v3-0-0117c2eff1b7@fairphone.com

Changes in v3:
- Rebase on linux-next, drop patches already applied
- Pick up tags
- Drop simple-framebuffer to drop dependency on interconnect patchset,
  will add back later
- #interrupt-cells = <4> for intc
- Move protected-clocks to dts
- usb_1: reg size and assigned-clock-rates update
- tsens: reg size & interrupt fixes
- thermal trips cleanup based on review comments
- Link to v2: https://lore.kernel.org/r/20250713-sm7635-fp6-initial-v2-0-e8f9a789505b@fairphone.com

Changes in v2:
- Rebrand SM7635 to Milos as requested: https://lore.kernel.org/linux-arm-msm/aGMI1Zv6D+K+vWZL@hu-bjorande-lv.qualcomm.com/
- Disable pm8550vs instances by default
- Enable gpi_dma by default, sort pinctrl, update gpio-reserved-ranges
  style, update USB2.0 comment, newlines before status, remove dummy
  panel for simpledrm
- Link to v1: https://lore.kernel.org/r/20250625-sm7635-fp6-initial-v1-0-d9cd322eac1b@fairphone.com

---
Luca Weiss (9):
      dt-bindings: cpufreq: qcom-hw: document Milos CPUFREQ Hardware
      dt-bindings: crypto: qcom,prng: document Milos
      dt-bindings: qcom,pdc: document the Milos Power Domain Controller
      dt-bindings: arm: qcom: Add Milos and The Fairphone (Gen. 6)
      arm64: dts: qcom: pm8550vs: Disable different PMIC SIDs by default
      arm64: dts: qcom: Add PM7550 PMIC
      arm64: dts: qcom: Add PMIV0104 PMIC
      arm64: dts: qcom: Add initial Milos dtsi
      arm64: dts: qcom: Add The Fairphone (Gen. 6)

 Documentation/devicetree/bindings/arm/qcom.yaml    |    5 +
 .../bindings/cpufreq/cpufreq-qcom-hw.yaml          |    2 +
 .../devicetree/bindings/crypto/qcom,prng.yaml      |    1 +
 .../bindings/interrupt-controller/qcom,pdc.yaml    |    1 +
 arch/arm64/boot/dts/qcom/Makefile                  |    1 +
 arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts   |  790 ++++++
 arch/arm64/boot/dts/qcom/milos.dtsi                | 2633 ++++++++++++++++++++
 arch/arm64/boot/dts/qcom/pm7550.dtsi               |   67 +
 arch/arm64/boot/dts/qcom/pm8550vs.dtsi             |    8 +
 arch/arm64/boot/dts/qcom/pmiv0104.dtsi             |   73 +
 arch/arm64/boot/dts/qcom/qcs8550-aim300.dtsi       |   16 +
 arch/arm64/boot/dts/qcom/sm8550-hdk.dts            |   16 +
 arch/arm64/boot/dts/qcom/sm8550-mtp.dts            |   16 +
 arch/arm64/boot/dts/qcom/sm8550-qrd.dts            |   16 +
 arch/arm64/boot/dts/qcom/sm8550-samsung-q5q.dts    |   16 +
 .../dts/qcom/sm8550-sony-xperia-yodo-pdx234.dts    |   16 +
 arch/arm64/boot/dts/qcom/sm8650-hdk.dts            |   16 +
 arch/arm64/boot/dts/qcom/sm8650-mtp.dts            |   16 +
 arch/arm64/boot/dts/qcom/sm8650-qrd.dts            |   16 +
 19 files changed, 3725 insertions(+)
---
base-commit: 8ebfd5290c6162d65f83f9a8acdbbf243b49a586
change-id: 20250623-sm7635-fp6-initial-15e40fef53cd

Best regards,
-- 
Luca Weiss <luca.weiss@fairphone.com>


