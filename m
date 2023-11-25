Return-Path: <linux-pm+bounces-229-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 540977F8C35
	for <lists+linux-pm@lfdr.de>; Sat, 25 Nov 2023 16:59:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76CC71C20B21
	for <lists+linux-pm@lfdr.de>; Sat, 25 Nov 2023 15:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D753F2941C;
	Sat, 25 Nov 2023 15:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YQyt0Zsn"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BDDFB3
	for <linux-pm@vger.kernel.org>; Sat, 25 Nov 2023 07:59:34 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-50aab0ca90aso4060153e87.0
        for <linux-pm@vger.kernel.org>; Sat, 25 Nov 2023 07:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700927972; x=1701532772; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2iB89YTPF/qEg+1UoN4/CBmby4obiZNm4Lhj2XaG9FI=;
        b=YQyt0ZsnIpmBSr8NA/PJVmk/ejiRK7Lkjs5/PuXlRBqxQfRHjEZBNmJQqxTLadfWit
         N7zF2jzoOSs966KMXEGFIF9LELpd2L2D5vc1mMwRJgxlFrpGcHfr5iqHX+FddCbzo/vB
         MLzvi7pgXsm3i6B9AMdCK6+qb9Z7iEulGPBtPfY4TLcmTmvGLlJacYZsMUIjkyJ5F33G
         xxOuyTlVuD/ZksuaSfOCmZ/1lNdib4txjjjS0u6rTZ1Uu6AnaP+X0OlvCxkmK92PP+m0
         z14AgGr7shfTWLudfl4xNl9uLDfB/yGawbfuJYpyIf0VPHUDCFCkFT+X+N0b1UMuWyGq
         0Nyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700927972; x=1701532772;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2iB89YTPF/qEg+1UoN4/CBmby4obiZNm4Lhj2XaG9FI=;
        b=ElLsYCXZ+ECdzp6k6hpBRV/OrSCm5JUVtMZKPjjOtdzSHk6BwVM68QWPfOcfhN9yGt
         qdrC0buUKewJo17IlKLA2RgEwLQtqQfZSnrWUiZEksbiCjY4brfmxzHBml1z38d/zU+A
         kx8CS22cbB8Zk4c7AHfS806TMZGqxwuoYtYTycyyQJR4Ths47mKrmo/geG0Y+e+5Nko+
         S7Poc3ZP9ybb+bVWNCxcpxD/nTB7ac6HKjMZ1GrrrMbf50E7xIxeXfJFFl54P0+CQpgC
         nI4Bnye+yfypH+xrX6vn1w6no4KQh4w+lZKc8FoWqAkN76CJn1v82J41u6rfauiwbXsN
         Z84A==
X-Gm-Message-State: AOJu0YyYKQoLCFOdpgGR4gh02i4XkAump2hEzfs0ar/aZh34aUIVxsDM
	8a3eiwqn/IDhtG0iZ9Ig7rCWfA==
X-Google-Smtp-Source: AGHT+IG3jaaZVBgM3Hqa4iYcCnw5wxK7UKFeh9UCBZXihUA7e6fKCddpCaWXrBVJHuoQd1FRwWKfEQ==
X-Received: by 2002:a05:6512:3e0b:b0:500:b5db:990b with SMTP id i11-20020a0565123e0b00b00500b5db990bmr5367910lfv.47.1700927972557;
        Sat, 25 Nov 2023 07:59:32 -0800 (PST)
Received: from [10.167.154.1] (178235187180.dynamic-4-waw-k-2-3-0.vectranet.pl. [178.235.187.180])
        by smtp.gmail.com with ESMTPSA id g22-20020aa7c856000000b005489e55d95esm3185813edt.22.2023.11.25.07.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Nov 2023 07:59:32 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH 0/2] SM6115 interconnect
Date: Sat, 25 Nov 2023 16:59:25 +0100
Message-Id: <20231125-topic-6115icc-v1-0-fa51c0b556c9@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN0ZYmUC/x2NQQqDQAwAvyI5N9Bs2ar9SukhptkakFV2rQji3
 xt6nIFhDqhaTCs8mgOKblZtzg50aUBGzh9FeztDuIYbUYi4zosJ3omiiSBT16bYdz2nFrwZuCo
 OhbOMXuXvNLlciibb/5Pn6zx/P55W+nQAAAA=
To: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Georgi Djakov <djakov@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1700927971; l=854;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=Nl3DWqDUUcrIjWHIlwNbTG+HmHnE55GLQ2aePjPqqWg=;
 b=rUtgk8krejWo39AXRWB3ZMxuG+T+FjvIv8+dm3dozPkQFFFim2GkXZg3/yGO6AJKuPkVz8nyD
 V84Ql7kxKcJB+OeiOld/D9MxNQNiuuh8x82xfWhbpLaF3PbSJ8WoJjU
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

As it says on the can.

Georgi, Bjorn, can we please set up an immutable branch with the bindings?

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Konrad Dybcio (2):
      dt-bindings: interconnect: Add Qualcomm SM6115 NoC
      interconnect: qcom: Add SM6115 interconnect provider driver

 .../bindings/interconnect/qcom,sm6115.yaml         |  128 ++
 drivers/interconnect/qcom/Kconfig                  |    9 +
 drivers/interconnect/qcom/Makefile                 |    2 +
 drivers/interconnect/qcom/sm6115.c                 | 1427 ++++++++++++++++++++
 include/dt-bindings/interconnect/qcom,sm6115.h     |  111 ++
 5 files changed, 1677 insertions(+)
---
base-commit: 8c9660f6515396aba78d1168d2e17951d653ebf2
change-id: 20231125-topic-6115icc-a187f5989af7

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>


