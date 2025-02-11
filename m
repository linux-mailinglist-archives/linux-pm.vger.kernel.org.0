Return-Path: <linux-pm+bounces-21825-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD11BA30C1E
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 13:56:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6050716596C
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 12:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB3A215046;
	Tue, 11 Feb 2025 12:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wdkwSYSg"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AEC6213E61
	for <linux-pm@vger.kernel.org>; Tue, 11 Feb 2025 12:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739278605; cv=none; b=bHxKMPeSQjCegb5oiaCuOuIC8I2BRy7MUftA3W1Y2Q2DXbkvkAoIQp+CG8lj91109HrN6ZI4lcPYUhF/yUb717Dqn1e1Gt2euehu/9CQslO6LYef7yyfjy7uVplMmOS0QJQ0rlaf+uod90IlX4vVBC27rx0CUMmMa6KIZpexK80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739278605; c=relaxed/simple;
	bh=w4m+sspvQMnK1s4SMX9UzeZ5mQsYG19kF8famTA53As=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=kVOlMzkxnL93jT0pS1e+xqzSTL9RH9a0HFieohGGM+2BtT0Noode6MBL/YFqXst5YgGzEJVeRCvrGfclmQGOjYL1OP+zc3PN38NipejrNaqFfRlhMhxq+cm7DuigjJHtllkOFHPV5gNmIafOI8/e9EvAT3H6azNrrettFyMrtR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wdkwSYSg; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-38dd0dc21b2so2127920f8f.2
        for <linux-pm@vger.kernel.org>; Tue, 11 Feb 2025 04:56:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739278602; x=1739883402; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yrpH7jKG5dNn7UfZK23E+5eCOO6ZpGDKZ1LcXH2HpqM=;
        b=wdkwSYSg8tNv2WL8F5UFh6OujUdoUzk8vZcZnRgXKfCubFCLILrUNN5oZw2rN95i0u
         yku2hZFeMstcsa1ZVWXtAYZJhB+eDsAktJHPKRUCbKNQeOo2XFTlgVBysvVuqoogOsr0
         LXJpqsC+mFRdg11mklIwNGKe8VozvvsjzJrRxCkcO4b1S13Y7yR06y+gWBjtc36aLtFQ
         p+9yXmOEBa8aRFsu0dmH5Z/5JBqEEMU6u7y2HGkRigsZMZCj3Ekg2WFIxF/Trb54NmXK
         6AoXaqLz0ff0pjA/4YyFXRCozhaAuLfqlavruqu2h2aSuibDuZADbQumMufHEwRHfqzl
         LNJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739278602; x=1739883402;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yrpH7jKG5dNn7UfZK23E+5eCOO6ZpGDKZ1LcXH2HpqM=;
        b=cm/ZFl40ELRsCvbE+kR56Ddb2vAC55y8tYMURfdQiTUrXpK/f/MbE0kG837k23EJvn
         Wb+q5J4U37rAQvBzKdAo87Bwpj8HE4LBave4gdLTuWeySwflC9qBC2N9HImqDKJCJKyG
         URil7iv6jj54p0NKQapL+eDp3zPnhJPOXvfR6OSwVmPv/BZu3K1gPEd5drcju+8ZjFnY
         +Yl6DQSumoTbIZHnh35zmxXXzlVotZlJjFW3NTi6EySvKLkKxzGkQr1QO97JTejxIN6n
         H5Uhq5J2XeCXuoq6EX1o1OelJkuMis5tiFnukGDydXHfdPJv5YQAfk1kpV+5Yz45D5ck
         jgIw==
X-Forwarded-Encrypted: i=1; AJvYcCWfBFP5KcF31mynYzzZG7Ak8zZIUvzi+SwNBZ0Lu/SFYhu+a2BnS837oFxPkHhVrWSmK51dlhUwkw==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywih4MRnux1l6oBRZgIQXdS/Sp7LnEhBAQWhGMyg9LM2SI9L1Tl
	ogub7yQjkcna/Q5KLI7E6AxZ9gzXHFMnfPryKjIlQJ9eJ1+LbFvW6G7SLwB0KgY=
X-Gm-Gg: ASbGncvu+yyM2lfw3CxR9vwDm7NZlpfhApoa0D6+byoqMX2FKECeNN/yC/7IPfGIah/
	TcxdGT7C8ImovuZ2/GvizdLBQjMKLk9eNxC/G+sdx50YGNc/gonQs+3VcAyAVz/CZ8Fgi/jbkt/
	OcHvf85JNVNhK2kP+EO33HBGC3l+yqr0xWpZiDgwwtCr2imiVEEJaJNfEj7IKbC+iinLTOgbhRA
	xeAiI5PEnWRPnHWSqfrueumQZSZAKWjQcBT47sqXAKi9RIwcwCCLGYK+PGgoVaK4uBDpPf8Dfu8
	wCWR4PLiNfYoBTCRhM9TilKM4XpqEUUS0hvz
X-Google-Smtp-Source: AGHT+IFvtQW7v73wdUZ4gpcrGgNHxAGBbARqJ5zOyoFkp3ahW2ie5O+dTE3TMMDx8WYL3KAaRGW8bg==
X-Received: by 2002:adf:e849:0:b0:38d:afc8:9535 with SMTP id ffacd0b85a97d-38dc90eeb80mr9598664f8f.30.1739278602334;
        Tue, 11 Feb 2025 04:56:42 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dc73c2e00sm12863078f8f.57.2025.02.11.04.56.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 04:56:41 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v2 0/3] arm64: qcom: sm8650: add DDR, LLCC & L3 CPU
 bandwidth scaling
Date: Tue, 11 Feb 2025 13:56:36 +0100
Message-Id: <20250211-topic-sm8650-ddr-bw-scaling-v2-0-a0c950540e68@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAARJq2cC/42NQQ6CMBAAv0L27JptgaZ68h+GA7QFNlFKtgQ1h
 L9beYHHmcPMBikIhwTXYgMJKyeOUwZ9KsCN7TQEZJ8ZNOmalCJc4swO09OamtB7we6FybUPngb
 slTVl312Urgzkwiyh5/dRvzeZR05LlM8xW9XP/tddFRJSpbwtTUe2cresW4nnKAM0+75/AShl4
 AbHAAAA
X-Change-ID: 20250110-topic-sm8650-ddr-bw-scaling-f1863fb91246
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sibi Sankar <quic_sibis@quicinc.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=978;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=w4m+sspvQMnK1s4SMX9UzeZ5mQsYG19kF8famTA53As=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnq0kHlvh5KlEfORO+AZjaIdSQC0RUM0C0ngK/iDF9
 88BX/dGJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZ6tJBwAKCRB33NvayMhJ0SofD/
 9ZURBwwRN9lvE7Nvl1yNdumDTcW2kS6cyA+BRuGz7ztjEnagdZrvkXI0krqmJOSXY/cUdIPv0euw0G
 w8kia0CogRLv/oNfhI44pJ5GoEpqwjNPxTSbJ17D0zzIiGYcz0ZRRtAcukDk0rY5qw+EhqpU7Ow7tV
 H4DUb0JXaarqBqJuyF5drHeA1KImgVX8eedY4kP9sfvxfCOzFzv7gLYwkPXwY1qgmsCoK8izf2+/SB
 intSPq+ASWQQkhLPfUgmgqj1T3MYPW4U2cxN/I2Xas2AiwpQe4OTTM6mHNmdGZR9kg9dvaBK3QXEhI
 /CbNdfyrZzXLr4kNnIBP3c+RJMCGAmffVE20mxh9f0c8VQ5Egoyjl9Cuwty8LUP+n1tAyAjuejR6xF
 6z5TnhqtoJaZSdWFbXDBpIUCZ7dS/z5sQ2g6xDoYDh7oWlmgQMo4EDcN0VgAkAqx5edGJOqN/8NPM9
 AF63ic7rhZxGn3n/uvPwQXZ/Qktyor5ldaJIHrTz+NLIl4Ocqj6TzPLOTNuIJ5A104GX4bV9AvAWh5
 Nuz+/v+HnqNeJi4b1o7/GGp7Pn/DQdntW18vS3nGf3Ax2JqpqlkbzYBXGrG2ULxcY6xifiFRYAZbJz
 uLkj5/EGmv3vfDvF6K5npXMydDp+yAZ1n49dO5BLHzuwQEgcg4KrOXtJfQ+g==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Add the OSM L3 controller node then add the necessary interconnect
properties with the appropriate OPP table for each CPU cluster to
allow the DDR, LLCC & L3 CPU bandwidth to scale along the CPU
cluster operating point.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v2:
- Drop already applied bindings patch
- Link to v1: https://lore.kernel.org/r/20250110-topic-sm8650-ddr-bw-scaling-v1-0-041d836b084c@linaro.org

---
Neil Armstrong (3):
      arm64: dts: qcom: sm8650: add OSM L3 node
      arm64: dts: qcom: sm8650: add cpu interconnect nodes
      arm64: dts: qcom: sm8650: add cpu OPP table with DDR, LLCC & L3 bandwidths

 arch/arm64/boot/dts/qcom/sm8650.dtsi | 943 +++++++++++++++++++++++++++++++++++
 1 file changed, 943 insertions(+)
---
base-commit: 808eb958781e4ebb6e9c0962af2e856767e20f45
change-id: 20250110-topic-sm8650-ddr-bw-scaling-f1863fb91246

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>


