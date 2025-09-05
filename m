Return-Path: <linux-pm+bounces-33966-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CCF0B454EC
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 12:42:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF15E189C03A
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 10:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7372D5C6C;
	Fri,  5 Sep 2025 10:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="nErYQFrP"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991862FE05D
	for <linux-pm@vger.kernel.org>; Fri,  5 Sep 2025 10:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757068863; cv=none; b=OmH56SOzqPuvxxuI/c5PbFt82fQuT97of1Zqp/OBqwehr09rMdr9e+q1wnxlRbUFGaV4BkWhBrYplysTvsv0NqZWibhaBzhIxqzj3PEkwSJgjU1S3SyPpg1hoTj3oDOvt54qwY7Dy1Xlcu+6r0y9kuXQVQQaGXQfKBhiO4l6LwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757068863; c=relaxed/simple;
	bh=t5R4UW31UoUE7aHekeSNbKI9qdNJcDF4TdGs9lVlvwU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=UQGq9Ta/cN0I9eKvvDpKVMlUHXT02RrVZu5BF0nUEWlImPIYZ4sP2iVlEd1XWu2mkMWE8aB6gOefF5x2MkIIqutxGYGAcSo5qd1lWL3HD92/Fwh9woGs9l3AdMoNnVDJ5hHG3YEYwxNs5jSFWnHK1AKHeJHiIexHgCt4lGqk774=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=nErYQFrP; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-3cf991e8c82so1841665f8f.3
        for <linux-pm@vger.kernel.org>; Fri, 05 Sep 2025 03:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1757068860; x=1757673660; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GqjeSvXCrahhKJFKiSx2ZS2MamV+BQDmtkvvhQaFj0M=;
        b=nErYQFrPLnzJ0M837wBnQPML0jsbi5TPv3oemfRLLWRNEqxOfLUPLoJHLz2m1Z5I8f
         D3XlQpk17/+ID2Sov2g1VyhbtqAG8LrMuuSgY9ef7SopGhX3r0NukZadHnCDXDblPkaD
         wT+uIKVHupThisXo5aSbma/O74JK/worJFX+t5pO1bF5F+iGQ/WV4OfK8OcrDf0wxubR
         Rawf8VLL4YpN7XIpf0bGEtAUvxCaZlrF7/KedGzawNWM8TF1wlTm+Ark0aNhnfEd+ucu
         2PUZPLnLgDtcGr5O2n/8mneAcimvVAGAYjd1v2NLuJ9eiM4XRdVPBUk+nig2t9z0og8c
         ue2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757068860; x=1757673660;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GqjeSvXCrahhKJFKiSx2ZS2MamV+BQDmtkvvhQaFj0M=;
        b=DIx39oixx4RE06mCWMRGyncJgCPQ5WdE6yG8qUpkNzPek0Dmo+Otau/ivirwp3L404
         6EaQN/+t9A9/ShBFm2zFnWEtqZ0FNNVLiMHf+sxxE6LaQ9x4+enUGYmrzMa4AldPFcuj
         warGgYPBV1YJixSMh7jAqF7904CQe0H3HuHbbqk7lB04Ou4QPepZvxw2gdt7IMU5aWuX
         gY3TyQWKq+RljiPBNW6sf+2TWDCA4Q2YjLMwWXt3Z717c/ek7ipsGpLMT4qOLja9wP+H
         LSmwu7dXNk00zSXOq+xIqX+918UMoC/PLenRiSzh5wmK34LSIu4/od2RBPqM/GoVW19m
         TX2w==
X-Forwarded-Encrypted: i=1; AJvYcCXO+XGvGosHzJYR6U0pLTe3zObDuyDfy6i43Y7llGOa/mnSfUivd8Ptst6ZGDOVl27LCt0ixo6R9A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzTnFnArRhHp1N6ziKyGof4LW37FTIypKMugscYS/YxGnCz1uXq
	cuUa2LPWrzkNTtiC4IwOijkQABWq2CSwDsSp3DGD+gvUQcXH0YulBIHaS65O5C6eJCY=
X-Gm-Gg: ASbGnctDeO53XU8+N58GFPZl0LEfIiE4gEkyfr4VF01TUEgV9Q8Od0SMyCHYB3Dt241
	NEd5ZcdazzQKzyNBQ5TbwxPzdnYXT9i/T2xWCWyJVX++rpKGEqnb4m1Df/1jZoBNBzX1OIIx3iC
	9XCW7+y0ydL34N1ZQF/JqVyLCEb1hSad8IdsgXdK1lGel/mNtmNl+JB0vX6dgr0F9jPqEJ1wqvk
	S9gGvx8mHKSpMe9eQZB+ty6YXU13rs7zJ+Hy6WWUr13ic+2+22T79HIAhWXj6XI/ns/os2dNVnn
	btCWjgLjfE4ZWqHD0HZiTQ1OFoTmjUOefB7wW10Ro/ruS+04/pipsaD3j4mWT9p0v/WHAI63jy6
	TpFnk+U2sBuuUnL7kWrKsYzXnnd+7VoGY+KGs5BQiFjwQJS2G04bukJIdMkpLzZ2pm2i1uY/4TA
	U0PdVvp50i9KuhR7NxOfRWgRQVVEdOww==
X-Google-Smtp-Source: AGHT+IGACoEn/nbo6e2DyckGACB/CNW4OVzXkDG8m1N/cYcO1zHIfjpCrYFjRtT8AHuW/9OW2nHiOg==
X-Received: by 2002:a05:6000:2185:b0:3d1:e1b1:9640 with SMTP id ffacd0b85a97d-3d1e1b19c98mr12582044f8f.30.1757068859889;
        Fri, 05 Sep 2025 03:40:59 -0700 (PDT)
Received: from [172.18.170.139] (ip-185-104-138-158.ptr.icomera.net. [185.104.138.158])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d6cf485eb7sm20990738f8f.3.2025.09.05.03.40.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 03:40:59 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Subject: [PATCH v3 0/7] Various dt-bindings for Milos and The Fairphone
 (Gen. 6) addition
Date: Fri, 05 Sep 2025 12:40:31 +0200
Message-Id: <20250905-sm7635-fp6-initial-v3-0-0117c2eff1b7@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAB++umgC/22STW7cMAyFrzLwui4oidTPrHqPoguKojoCOvbEd
 o0Uwdy9ipMiSBptpEfwfQQe9TSsujRdh/PpaVh0b2ubpy7cl9MgF55+6thK14MFS+CtG9dr8I7
 GevNjm9rW+NdoSBGqVnJShm68LVrb4wH9/uNFL/rwu7O3l+Ib+nx6BcM/8KLXedPbMss6GkyFP
 ULEHM87Hmze5HIYS2DwKpoMaIiI4iH3d9WoWhxwsUixug+u3kG+dxqWxFEKRYci0SraIo4Z1SO
 DTe9dmIwjcsgupJyzBJ8pSyo5FbXFcr9dDELvXSpBDBSxhJlspX5CdQCg5J0EMpZ9KBg/zBKjv
 s9KFJNiTcCQQlAjJZFFG6jWjFn42ZV51VHm67Vt59Okj9t4xJmAhufgL23d5uXPsdzdHMm/xk2
 f7XE3I4wlSXHWKovJ3yq35XaZJ/3ahxzI3b5hgvn0O+y2YzTWxCEmAvoPc7/f/wKRA4eteAIAA
 A==
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
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757068857; l=3748;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=t5R4UW31UoUE7aHekeSNbKI9qdNJcDF4TdGs9lVlvwU=;
 b=mjMaowhNsly/zEKdyzh/hul06MF3DpyjaK7gVEMVYiaf6Ivc6lj6N3MeRPBWNYHmfJrRKlB8f
 v04JNynDydODI94kqZ4CMNQym0Bs1p31FHxAA6xv4IM8oxlUahGV10C
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Document various bits of the Milos SoC in the dt-bindings, which don't
really need any other changes.

Then we can add the dtsi for the Milos SoC and finally add a dts for
the newly announced The Fairphone (Gen. 6) smartphone.

Dependencies:
* The dt-bindings should not have any dependencies on any other patches.
* The qcom dts bits depend on most other Milos patchsets I have sent in
  conjuction with this one. The exact ones are specified in the b4 deps.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
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
Luca Weiss (7):
      dt-bindings: cpufreq: qcom-hw: document Milos CPUFREQ Hardware
      dt-bindings: crypto: qcom,prng: document Milos
      dt-bindings: qcom,pdc: document the Milos Power Domain Controller
      dt-bindings: arm: qcom: Add Milos and The Fairphone (Gen. 6)
      arm64: dts: qcom: pm8550vs: Disable different PMIC SIDs by default
      arm64: dts: qcom: Add initial Milos dtsi
      arm64: dts: qcom: Add The Fairphone (Gen. 6)

 Documentation/devicetree/bindings/arm/qcom.yaml    |    5 +
 .../bindings/cpufreq/cpufreq-qcom-hw.yaml          |    2 +
 .../devicetree/bindings/crypto/qcom,prng.yaml      |    1 +
 .../bindings/interrupt-controller/qcom,pdc.yaml    |    1 +
 arch/arm64/boot/dts/qcom/Makefile                  |    1 +
 arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts   |  790 ++++++
 arch/arm64/boot/dts/qcom/milos.dtsi                | 2633 ++++++++++++++++++++
 arch/arm64/boot/dts/qcom/pm8550vs.dtsi             |    8 +
 arch/arm64/boot/dts/qcom/qcs8550-aim300.dtsi       |   16 +
 arch/arm64/boot/dts/qcom/sm8550-hdk.dts            |   16 +
 arch/arm64/boot/dts/qcom/sm8550-mtp.dts            |   16 +
 arch/arm64/boot/dts/qcom/sm8550-qrd.dts            |   16 +
 arch/arm64/boot/dts/qcom/sm8550-samsung-q5q.dts    |   16 +
 .../dts/qcom/sm8550-sony-xperia-yodo-pdx234.dts    |   16 +
 arch/arm64/boot/dts/qcom/sm8650-hdk.dts            |   16 +
 arch/arm64/boot/dts/qcom/sm8650-mtp.dts            |   16 +
 arch/arm64/boot/dts/qcom/sm8650-qrd.dts            |   16 +
 17 files changed, 3585 insertions(+)
---
base-commit: 87a9e300217e33b2388b9c1ffe99ec454eb6e983
change-id: 20250623-sm7635-fp6-initial-15e40fef53cd
prerequisite-change-id: 20250620-sm7635-remoteprocs-149da64084b8:v4
prerequisite-patch-id: 33c2e4cd2d8e7b9c253b86f6f3c42e4602d16b7d
prerequisite-patch-id: 0688b95e4ac7b2f042023a7cb09e0d8cb7929bb6
prerequisite-patch-id: d7a06ece910e7844c60b910fe8eed30ad2458f34
prerequisite-patch-id: 9105660b1ac9a8cd5834cc82e42dc3aa4e64a029
prerequisite-patch-id: 49135534a379bbbc76b5bc9db9de2d2ab9d387c5
prerequisite-patch-id: ec7c10dc254b52f55557f3000e563c7512a67d48
prerequisite-patch-id: 4c1e65349589e4f90a0977e1cd9524275ffb4bca

Best regards,
-- 
Luca Weiss <luca.weiss@fairphone.com>


