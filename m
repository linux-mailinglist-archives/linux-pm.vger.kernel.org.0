Return-Path: <linux-pm+bounces-4807-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3083877145
	for <lists+linux-pm@lfdr.de>; Sat,  9 Mar 2024 14:15:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFC791C2092E
	for <lists+linux-pm@lfdr.de>; Sat,  9 Mar 2024 13:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B61F3BBEA;
	Sat,  9 Mar 2024 13:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gl5a69X9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B67436AF9
	for <linux-pm@vger.kernel.org>; Sat,  9 Mar 2024 13:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709990112; cv=none; b=QA3L9It9bVoBbH5Jn6GcVeKWwIW6z+h3dS1i7v7g4/VkPAsGyTTYe4whCt6TRdv5/p/2rFqUJwKzXytWL+8djSgYZ4nb81+6pg8db55filOLctr7Qz2UeoBz8OsOT4hqM/VpSz4slneHd6CpMzZ598Fu+9FmvfAjH9DhGUA9ir8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709990112; c=relaxed/simple;
	bh=/rLOqxDCtOy3ZBTqzS2uqhC7GkbdJSaFH0Cz3NiHJsg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=HNaO/TLhZ8l35u6zJrNZqmfH56kXjlna7bh9pb8XU7yuaM/9gM03G1SQ/2uOEVLdyOsrnBXoFwxKwCbipcE9d+kx+PKF2BDAa5MRsujEtthFyVIFc4U7HzNnB9/U6wbPOBq7UjIWcNXzttFp/eTiYSUngQWrnkmdDs/ikhQPXs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Gl5a69X9; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d4141c4438so37130051fa.3
        for <linux-pm@vger.kernel.org>; Sat, 09 Mar 2024 05:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709990108; x=1710594908; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/8UXQrDYYySZ4GwBvs13x7kXsVlrNox4c3TscAN1nzQ=;
        b=Gl5a69X95JNBrPn6aU9qjECmzg99NIN+cuoG0lXE16NVxEPBEtZI/8d9YuH07GDiEm
         RUwMcLfh4Z3Fal91vXJT+o/sMN5MOrT334HkpSre7YuhqeGRX+scK8qQkda+mYYItHO0
         sF9T/qh/nCLhHqncbe7mLCZBsp/CUS/AGcTHsS/nF64H3/CoFOpdsEvsG/RtOjYc/Zor
         LOAGESZdxXszhW91TxZGOKl2sTPfDHxACYpypoo0mldaB95JwyzlcRlGvyOfzivo5TGI
         vqHw8BsmLdNo+DdY1y3GZcz8bGnpLG0/hbJf5Sh8ACDKZsenVTUDcSrRAqjH2nUdZQQt
         P9QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709990108; x=1710594908;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/8UXQrDYYySZ4GwBvs13x7kXsVlrNox4c3TscAN1nzQ=;
        b=vbkwQynHUngUxAz0VG0XI3KN9/n9DUlUcHvEYZIyFqbjGrN5/ReBGKvYOypXHz8oy/
         fy9jJeX1O57TwLl2jydgPk7fuiFIgJEu5k11K9w/Z/giBeUp1OLxVR1vsesY8LngkW+I
         WrcdiB6fYD7PKLWPxKXCY9MsWth80ucWETV0tuRNIpviSFrWoVAb4oS7EUpZDgW6B3hk
         xXc8uR6pQm0An8EC5P9SHbsEtcjCvq5CqKNn3jCn1rMr1Ol13naTfHbE6L9DsXQchP6v
         y7frRW1VkElVf4lKg7sH6x1PwDZPxlj3Ab9GuzzCm2jg/xR/EHSAHUyugBBBKbI57tng
         HdCw==
X-Forwarded-Encrypted: i=1; AJvYcCUZ9eaaxvVV+EFRdybrf2uLj5nu98AAVG126ZVE9uzUSKYwXFDPfAPT+Q2iME4E8sYPHO2eAPpMiozNeZp11qFZ99UDOl1Fe7A=
X-Gm-Message-State: AOJu0YxLPAyTQnYjFZfYMNdUw2HF5489Y/dq5axbVIsUIp4xXGmL0Iwy
	3peo2FmHxpmgU2gbplPFaapNCKuxr6JTZAS2tXiPp+6nuwXAYl3xqTrXFEQT92E=
X-Google-Smtp-Source: AGHT+IEWGXl1OqAaIsm68n2Tg6uRWCj1l0pMavIibu7vuSi5KJe98gVk3MLtxz1Wy6w+1UxI7F+lVQ==
X-Received: by 2002:a2e:8810:0:b0:2d2:a2bf:4ae6 with SMTP id x16-20020a2e8810000000b002d2a2bf4ae6mr1185972ljh.31.1709990108433;
        Sat, 09 Mar 2024 05:15:08 -0800 (PST)
Received: from [10.167.154.1] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id i26-20020a2ea37a000000b002d3e6ce75cesm297596ljn.70.2024.03.09.05.15.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Mar 2024 05:15:08 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH v2 0/3] QCM2290 LMH
Date: Sat, 09 Mar 2024 14:15:01 +0100
Message-Id: <20240308-topic-rb1_lmh-v2-0-bac3914b0fe3@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANVg7GUC/3WNQQrCMBBFr1KyNjJJq6gr7yFFkjhpBmJSJrUop
 Xc3du/yPfj/LaIgExZxaRbBOFOhnCroXSNcMGlASY/KQoPuoIWTnPJITrJV9/gMUiH4rgPXnrU
 RdWNNQWnZJBfqKr1irHJk9PTeIre+cqAyZf5szVn97L/7WUmQB3BH8B6VauEaKRnO+8yD6Nd1/
 QIjnrNnwAAAAA==
To: Bjorn Andersson <andersson@kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thara Gopinath <thara.gopinath@gmail.com>, Amit Kucheria <amitk@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, stable@vger.kernel.org, 
 Loic Poulain <loic.poulain@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709990106; l=1019;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=/rLOqxDCtOy3ZBTqzS2uqhC7GkbdJSaFH0Cz3NiHJsg=;
 b=BOLrerRTfO9qD2pMYZTSyidUuVlxPx1s/nqhfu0hHL9K1CWlmrREgogxESYonIzQ4bAtmcPVg
 lOFss0UIA3HBoU4bSm51iObSzjUIYSSt5wspLgsCMW4c69kv8eXhEn/
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Wire up LMH on QCM2290 and fix a bad bug while at it.

P1-2 for thermal, P3 for qcom

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Changes in v2:
- Pick up tags
- Fix a couple typos in commit messages
- Drop stray msm8998 binding addition
- Link to v1: https://lore.kernel.org/r/20240308-topic-rb1_lmh-v1-0-50c60ffe1130@linaro.org

---
Konrad Dybcio (2):
      dt-bindings: thermal: lmh: Add QCM2290 compatible
      thermal: qcom: lmh: Check for SCM availability at probe

Loic Poulain (1):
      arm64: dts: qcom: qcm2290: Add LMH node

 Documentation/devicetree/bindings/thermal/qcom-lmh.yaml | 12 ++++++++----
 arch/arm64/boot/dts/qcom/qcm2290.dtsi                   | 14 +++++++++++++-
 drivers/thermal/qcom/lmh.c                              |  3 +++
 3 files changed, 24 insertions(+), 5 deletions(-)
---
base-commit: 8ffc8b1bbd505e27e2c8439d326b6059c906c9dd
change-id: 20240308-topic-rb1_lmh-1e0f440c392a

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>


