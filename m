Return-Path: <linux-pm+bounces-880-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B1480C46B
	for <lists+linux-pm@lfdr.de>; Mon, 11 Dec 2023 10:24:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 856AD1F210A2
	for <lists+linux-pm@lfdr.de>; Mon, 11 Dec 2023 09:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A2221112;
	Mon, 11 Dec 2023 09:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S3P3i2nW"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D320EB
	for <linux-pm@vger.kernel.org>; Mon, 11 Dec 2023 01:24:05 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-a1db6816177so524328766b.0
        for <linux-pm@vger.kernel.org>; Mon, 11 Dec 2023 01:24:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702286644; x=1702891444; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n6oPnCa6DBd3f+98xEuauxtAQ1S8sjdrlrHr9RLCgoc=;
        b=S3P3i2nW/PzkYyUhyscxVrRRRNPniGFuPVnWaRkF+99ZXAeVo8U6uZGflK/hSxP2xv
         zhK1Oz5NSZgaWhqGmMrXwyTtDkTeTNPBSr2ZWRHWvenSadTvVQuGj9eiwyI9AQUqbZRV
         UZ3bJJb2/FjbN+EZDB8Qcex6y47Vt3pMKylrzGGpRrGTU5ADBT983h4t2v8qSlJfILDg
         pd5UGKXTvpVzQ72sQkHzct8SxVbD/6Mm446tzPbZzbu1rBcpDV2FrN2/1nz+n6CjPrZa
         8apumfPRpUIvJCazJvaxCi4OagqexcMZwufhm6aUjiyPWbQtTd4RtrG6nbcplG70OPGf
         D3aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702286644; x=1702891444;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n6oPnCa6DBd3f+98xEuauxtAQ1S8sjdrlrHr9RLCgoc=;
        b=lilB4O0KGWwRWahlLR2K8gCOiCXgL08oN17JJUjWnNCGRygsC75ab8yo31SIo6A2Y2
         36ci69hL5lL3j99njoQFiHN7Drm9uXPi7ZtwQdRbX32H8JHvOIEMjjjLWakB5gy2z91n
         0S8i+/GjwFFMq2xrCv0CCEqw0qFBdIpUF9NHqxeXofdiF02pUTn2TNwTbihdzDLnvP37
         AM+PAIgwDUQypE7q1W6gCd4vwFg074OgCr8ZF0NLAtPVD78Nr1fFkO9SUh+28KD/IfJ8
         8zq0cjSinckvUHAi+J2YaKCvMHnrEvFK1KE1b1szrpQh8V9id7V/oHY0Gmf8hJShmhgM
         5OgA==
X-Gm-Message-State: AOJu0YzXdEcJbRpLvYrzQC00/TftdHm+KqYxRQyl4732nvxCDLI6JqXR
	pY502/NAZyhmH+BQutAZVsrfNQ==
X-Google-Smtp-Source: AGHT+IGgfdy95mNKY3dcynCeXmQN85L2HtJqH+pLYpK7S/8dLAYGnPh0D4hxqe5RKWN0arN/imiGYA==
X-Received: by 2002:a17:906:7f90:b0:a19:a19b:422d with SMTP id f16-20020a1709067f9000b00a19a19b422dmr1161332ejr.152.1702286643623;
        Mon, 11 Dec 2023 01:24:03 -0800 (PST)
Received: from [10.167.154.1] (178235179179.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.179])
        by smtp.gmail.com with ESMTPSA id tb21-20020a1709078b9500b009ad89697c86sm4570248ejc.144.2023.12.11.01.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 01:24:03 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH 0/2] Enable interconnect on SM6115
Date: Mon, 11 Dec 2023 10:23:57 +0100
Message-Id: <20231209-topic-6115iccdt-v1-0-f62da62b7276@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAC3VdmUC/x2NQQqEMAwAvyI5G0grW9j9inioMV0DUqXVZUH8u
 8HjDAxzQpWiUuHTnFDkp1XXbODaBniO+SuokzF48p3z9MZ93ZQxOPdS5mlHCpRIfEjEHVg1xio
 4lph5ti4fy2JyK5L0/2z64bpuLEHcs3YAAAA=
To: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Georgi Djakov <djakov@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702286641; l=973;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=tmsSXzF1KmW91De4zWGI6eXCqf+wYJAGd6SC/NqLLho=;
 b=eFsjoUSM1mxD8XDpzXhccY/co+PmWuuma5IMOq5vVzDBMlkYUsSrVMAZwcrqtqbhojfrgbRW+
 NIQBQwnkEG5Cps5M01s17AGP2BNwcjzuWtTErvTi3NbqEFQPIKLafRm
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

The SM6115 interconnect driver has been merged now. Add nodes required
to make use of it.

Patch 1 for icc, patch 2 for qcom.

Likely depends on patch 3/ (qcm2290 BWMON compatible) from [1].

The required bindings changes are available over at an immutable k.org/
djakov/icc.git/icc-sm6115.

[1] https://lore.kernel.org/linux-arm-msm/20231125-topic-rb1_feat-v3-3-4cbb567743bb@linaro.org/

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Konrad Dybcio (2):
      dt-bindings: interconnect: qcom,msm8998-bwmon: Add SM6115 bwmon instance
      arm64: dts: qcom: sm6115: Hook up interconnects

 .../bindings/interconnect/qcom,msm8998-bwmon.yaml  |   1 +
 arch/arm64/boot/dts/qcom/sm6115.dtsi               | 277 +++++++++++++++++++++
 2 files changed, 278 insertions(+)
---
base-commit: 206dd8f44be8930e25cd6c82873f21ae659abec9
change-id: 20231209-topic-6115iccdt-060f0e26f0c3

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>


