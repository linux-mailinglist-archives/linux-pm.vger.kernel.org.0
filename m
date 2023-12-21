Return-Path: <linux-pm+bounces-1468-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C7AE81AF08
	for <lists+linux-pm@lfdr.de>; Thu, 21 Dec 2023 08:03:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 086FF285033
	for <lists+linux-pm@lfdr.de>; Thu, 21 Dec 2023 07:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A159D29F;
	Thu, 21 Dec 2023 07:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p7iXb+7g"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308DDBE4B
	for <linux-pm@vger.kernel.org>; Thu, 21 Dec 2023 07:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dbd4608121fso496492276.0
        for <linux-pm@vger.kernel.org>; Wed, 20 Dec 2023 23:03:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703142196; x=1703746996; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lPoWLPGRoJ8TAvIq3rSYSVRoLky2Dc/xP/dnXpyq+Us=;
        b=p7iXb+7gJpq7FyH+kVjU13oWnAQG8uvCwO7I2BJAmdEwKu9RBX00URJPtYOwWnNGLE
         YgaWTYBlZpk5Dq+GVISIdNPvQK3wSuiy1ot0Lv/7LuhUlPdYtNn3qF8GpRStxwBbxXXY
         3StcrA55Z2VVrIWeocN9pbWEQ720WddLBV3iSu2x/PGo1Zc9kQ25wHkd+oI7xZZ0WKBa
         P8MwxTurJBWDDFPIEHKkn47tx9b5hmu19rh7aKNxb3E7cqgaajpP1ogJgqB08IZtMcwg
         B0AeMXPueKbSUZHJ8CLI/dFtaOl4hUDuHIneBxldnlT8LvY+CPU/gk4tRIdXPW4T18JU
         7kHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703142196; x=1703746996;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lPoWLPGRoJ8TAvIq3rSYSVRoLky2Dc/xP/dnXpyq+Us=;
        b=YD2A4c7F/XZh4Bb90D9gpNT7SD77WQ8yqJ4d+ZwwFjX/p8F0ojXSKHQj9d/v9lv/s1
         dwaYPFP9G3Nc4PaSvnngzbDFwN+rllzpiIx6tTYomBQdNdcU2PuIfh/krG5B19KR2Qcg
         cWvcw4NzCCP52lxo1DTi5Mgr+6YnCI23RNuKqbOJ2mMoA33vVrihQdbA6PjAIomtgfS2
         Ujr1Bw1S3rNiiLOmg/sCD6Ek4pNn+u/0uNUDroJfav1opDnFohOJHoWfYf2y6fOp2hHg
         ypjFBmW02JTw9SeAgivBI6ORyix9na7l7k4yoskdnksiqEWcLSjNvyuP5eQejf04yBDZ
         0MLw==
X-Gm-Message-State: AOJu0YxN0WVwcexLkIck4TgVmMPfVj+QimPReiq6vWpkAfQI6VgI5L0T
	Z63zMgv0DmR1NnqZrlSShxrRL0e0s7C8q9gt4ylosA==
X-Google-Smtp-Source: AGHT+IE47ttPlc1KbdGexvuAvgW1TXDOsv8bQFFLJoQS4RKAcV1L1htOBKX1GvBebXBNn/zwxaqzOiFyJMcGHWWhFQQ=
X-Received: by 2002:a25:c510:0:b0:dbd:5bfa:9681 with SMTP id
 v16-20020a25c510000000b00dbd5bfa9681mr713526ybe.37.1703142196127; Wed, 20 Dec
 2023 23:03:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220-sa8295p-gpu-v1-0-d8cdf2257f97@quicinc.com> <20231220-sa8295p-gpu-v1-1-d8cdf2257f97@quicinc.com>
In-Reply-To: <20231220-sa8295p-gpu-v1-1-d8cdf2257f97@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 21 Dec 2023 09:03:04 +0200
Message-ID: <CAA8EJprRjRJsV5hPR6mzjgucKa8UEthJd-y573aYJH0P8QRWqw@mail.gmail.com>
Subject: Re: [PATCH 1/8] dt-bindings: clock: qcom: Allow VDD_GFX supply to GX
To: Bjorn Andersson <quic_bjorande@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Taniya Das <quic_tdas@quicinc.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Johan Hovold <johan+linaro@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 21 Dec 2023 at 05:51, Bjorn Andersson <quic_bjorande@quicinc.com> wrote:
>
> In some designs the SoC's VDD_GFX pads are supplied by an external
> regulator, rather than a power-domain. Allow this to be described in the
> GPU clock controller binding.
>
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
>  Documentation/devicetree/bindings/clock/qcom,gpucc.yaml | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml b/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml
> index f369fa34e00c..013ef78d2b31 100644
> --- a/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml
> +++ b/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml
> @@ -53,6 +53,9 @@ properties:
>    power-domains:
>      maxItems: 1
>
> +  vdd-gfx-supply:
> +    description: Regulator supply for the VDD_GFX pads
> +
>    '#clock-cells':
>      const: 1

I think it might be good to restrict this property to a particular
platform (via if:not:properties:compatible:contains
then:properties:vdd-gfx-supply:false).


-- 
With best wishes
Dmitry

