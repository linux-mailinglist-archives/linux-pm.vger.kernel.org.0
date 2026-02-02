Return-Path: <linux-pm+bounces-41912-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iNEIKrK6gGl3AgMAu9opvQ
	(envelope-from <linux-pm+bounces-41912-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 02 Feb 2026 15:54:42 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AAF5CDACB
	for <lists+linux-pm@lfdr.de>; Mon, 02 Feb 2026 15:54:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 85EFC306249B
	for <lists+linux-pm@lfdr.de>; Mon,  2 Feb 2026 14:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD6637107F;
	Mon,  2 Feb 2026 14:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fVOzYKe2"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365BC37106D
	for <linux-pm@vger.kernel.org>; Mon,  2 Feb 2026 14:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770043596; cv=pass; b=PH8RYPgFD+v9eSHGFea7mRFv2d2BUIdwe4V76tr1Q926uWQAzsqkkpaXxMPJ+ygEmAn6BH1xA9ya7yxCLH397p1p+2Pf0YGPLQo4VCfj+x7C4hOyUStQkfB5j0plsA5D030NVywKnahild4lgmm8fDksLcBqgUX45m54pTQhjBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770043596; c=relaxed/simple;
	bh=6wKlGaF+HJlYg3oYlybm2siLLYbtx8o9sW8eaq0Ny5A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OwrEAG1HZFHm3EdCY3dO7F52JmIEUQR7Ug0rlfH8RVTP6vqFrxLkKYLeZ9mTepPbV328zc9WQEYIuv5mcn1fxUyvJ4NJJzHecw9V/1o5gu8CLped9TCddWfVkDLgV8KYS2PhEUeICrxDYCp+MSYGRFlSI8II2xsBL5+Lyt99xLg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fVOzYKe2; arc=pass smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-59dcd9b89ecso5211729e87.1
        for <linux-pm@vger.kernel.org>; Mon, 02 Feb 2026 06:46:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770043593; cv=none;
        d=google.com; s=arc-20240605;
        b=WHZcUo0BfdCTK6kxIpvYkMNS1dRKzzSvXnL59jgBXPUQftgzacma0DtcJr3FUT+QKP
         L12ryjK972/Uiw8cjSe+qOc6qMWBw867o1x3y9iD29PS34d7N92YETscLGglpKqGwXKy
         zuXCHh8DGvPSqd5RgMEOnlvWrVCKN8feooFF5fAZvr8NBsYHT7MRIoW7+0/ZK6PuRzKb
         HABB8BG8DJadlV39HMPZ7quSEfQjgpJdjhL2ggYKJFg4CSSj2OBi1uZ1xofLe2UfASYO
         PQ383Yx3045w4QC57R+q5dy0o7P0c6CL7f3+kh4IslrhvT9VWq1RIoMM7j8SEgyYbR98
         HWmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=CCxcsWChfDF2Gh4ycD+vyncq/ofeycyF+64lSijnMn0=;
        fh=O2Pg9gapfj5qIW0WauN+0kGyFzveXP929x3vHfJK4LQ=;
        b=iQmnJOS6NbuD4sZNDtGf+LRtFqF5GZPudS7qViul1pUzxmuSvcDDdjQkI5GQMIEwHD
         hA3b0A++0ks+I6YtZgZZQl57FePFOpRuN1XSZ0ES7pOYLPM0L6JhLHB9VmM9XumsOl27
         v/1X5QfjGrKAZ7C/SkR8uamShsOHpnNqdjMWuk4wN5SoDImZd01dREDCNVeuHtyLChhC
         LvKLPMf+Bzs+S8+Qkag5vufLlWeYFFXVUIYZcfVeaCJCO5+kJhEcuxOU4O8UYLmIn7O9
         01yq7E1MG9gqcUs9AbQpJZUItcDnSVV+ypLQbktgK4J+769C2l63xKLPPOkOkji+CdtB
         cCNA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770043593; x=1770648393; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CCxcsWChfDF2Gh4ycD+vyncq/ofeycyF+64lSijnMn0=;
        b=fVOzYKe2l2RRcFW+Sf7fGimY+tIcvF5zBMwbbs7M+DLbk0mH85UpGR3Jws6hsrL7ZQ
         gjeXyI2CZajzK2NznroXwsu7OdOwiwaT56j3YR/rIVcCra3Zep39byQ7bXnbiJgnA80w
         c03KOxxv6aHSdSZufwhXe7xg6221bjbExrwu/ii68LoBcV1FpXGkalsGpn7Vyti7RrQ9
         OeJpYNhAXBcR7UouNnwElYV5VJVwN3HcRVcsVQnJUiGTcY1afNNjV+z4S0KaVdj4poUJ
         bUMqzXekNZP8KrUlx8w0xMn8F404sCfaITXKzIbS5WU/GF0hxeR3//Epw7itz8PFJ5RU
         0g6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770043593; x=1770648393;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CCxcsWChfDF2Gh4ycD+vyncq/ofeycyF+64lSijnMn0=;
        b=Unbx0Y0yKgBO6J1f/E4oYim52cLrwO9s8iyzolnupnycrMncVGDCld2EdnDiyw7bW1
         uN2cPXDfJWuetOHdj6X1DSwU2RI0pXJrbxwwX2LuhEzIYH2fq6X8QCWBCrMklAWEK+H6
         hjSavw9ogSQn/Al/Z1z+nBiy0nKIvMP5aYJo4SKGVLDaKYkTmkNZomR0l0AFhtA42ynK
         jgy4ypIFtJALAkkIa/4WmyFXuA6AFcMm0+IaAiwcTk7Q1zWKB2l4bycpUuj5cukCyhnB
         yGmhQLqvHCp4UDXygj3CacQII+iD6ycO9QqERf78JUu+vQyfIcyuZmjIwxgnSsK8iPud
         ic7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUyMmtBM+PDykuys+zhxXKC82aMREd8ZY8VxCFOtCtr68AqxSSqFQ1ADjllLv4iZqprgc3uOlozqg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxNP2KeRMmTIijbKmvufFqa3cq0scD72Em3QNej9vIY9WM6drhk
	vid+Ne1/QN5iChSwgKuUnMmRX1io8jVR6tWJBuUhs/sZuisDzlak/xvHNimuv+QuNXW9ESLw6Hf
	Pg2MaiJs9naAmksIhdj1QR8vmym75tOLF/2GZmCu6XQ==
X-Gm-Gg: AZuq6aJY+D/irsDOtY+/iGC3plruDZ4f3n7OQxZY7pFARS/QW2H0m3zWMk/ir2VA2MM
	OtZZKpF6pet9TixIRgBLio3nw1JYQrYn7j8Imf1sUusJD18o+f1aFZCKqHyb+aOp3fhxKNePmw1
	4YKyOzr2UkxDQc5iwx5isiJF3E+PeboVXsnvKTKGp2T3eY+Kr60TajugpSWOoon2hvoCfyRkZOb
	Y/ydeboUxWJcgsmqwFtFAyybnYjPSVllwgTF1EK6JnB12dt3aMR7/aIHQfUZvMHt8SlBAfz
X-Received: by 2002:a05:6512:3d07:b0:59d:f1c7:3e02 with SMTP id
 2adb3069b0e04-59e0d88d299mr7865289e87.1.1770043593213; Mon, 02 Feb 2026
 06:46:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260201-iris-venus-fix-sm8250-v2-0-6f40d2605c89@oss.qualcomm.com>
In-Reply-To: <20260201-iris-venus-fix-sm8250-v2-0-6f40d2605c89@oss.qualcomm.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 2 Feb 2026 15:45:56 +0100
X-Gm-Features: AZwV_QhOzR0E6k1IfUGRMUbn9MQFxH_pvh_89KhmlNk_aUHzuxVlk0zPxkYMZY8
Message-ID: <CAPDyKFoNX087ZhLkQ_n8-42WNQcL06noSuPJPDG87y0andVdNg@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] media: qcom: iris/venus: fix power domain handling
 on SM8250
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Taniya Das <quic_tdas@quicinc.com>, Jonathan Marek <jonathan@marek.ca>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, "Bryan O'Donoghue" <bod@kernel.org>, 
	Vikash Garodia <vikash.garodia@oss.qualcomm.com>, 
	Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Stanimir Varbanov <stanimir.varbanov@linaro.org>, 
	Abhinav Kumar <abhinav.kumar@linux.dev>, Hans Verkuil <hverkuil@kernel.org>, 
	Stefan Schmidt <stefan.schmidt@linaro.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	"Bryan O'Donoghue" <bryan.odonoghue@linaro.org>, Dikshita Agarwal <dikshita@qti.qualcomm.com>, 
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-media@vger.kernel.org, 
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41912-lists,linux-pm=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ulf.hansson@linaro.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[linaro.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pm,dt,huawei];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,linaro.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 0AAF5CDACB
X-Rspamd-Action: no action

On Sun, 1 Feb 2026 at 11:49, Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> wrote:
>
> As pointed out by Konrad during the review of SM8350 / SC8280XP
> patchset, Iris aka Venus description has several flows. It doesn't scale
> MMCX, the frequencies in the OPP table are wrong, etc.
>
> Let's correct the Iris/Venus enablement for SM8250 (unfortunately also
> stopping it from being overclocked).
>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

Do you want me to pick up patch2 for v7.0 - or what do you suggest at
this point?

Kind regards
Uffe


> ---
> Changes in v2:
> - Fixed example in the new sm8250-videocc schema
> - Link to v1: https://lore.kernel.org/r/20260131-iris-venus-fix-sm8250-v1-0-b635ee66284c@oss.qualcomm.com
>
> ---
> Dmitry Baryshkov (8):
>       dt-bindings: clock: qcom,sm8250-videocc: account for the MX domain
>       pmdomain: de-constify fields struct dev_pm_domain_attach_data
>       media: dt-bindings: qcom,sm8250-venus: sort out power domains
>       media: iris: scale MMCX power domain on SM8250
>       media: venus: scale MMCX power domain on SM8250
>       arm64: dts: qcom: sm8250: add MX power domain to the video CC
>       arm64: dts: qcom: sort out Iris power domains
>       arm64: dts: qcom: sm8250: correct frequencies in the Iris OPP table
>
>  .../bindings/clock/qcom,sm8250-videocc.yaml        | 85 ++++++++++++++++++++++
>  .../devicetree/bindings/clock/qcom,videocc.yaml    | 20 -----
>  .../bindings/media/qcom,sm8250-venus.yaml          | 10 +--
>  arch/arm64/boot/dts/qcom/sm8250.dtsi               | 42 +++++++----
>  .../media/platform/qcom/iris/iris_platform_gen1.c  |  2 +-
>  drivers/media/platform/qcom/iris/iris_probe.c      |  7 ++
>  drivers/media/platform/qcom/venus/core.c           |  7 +-
>  drivers/media/platform/qcom/venus/core.h           |  1 +
>  drivers/media/platform/qcom/venus/pm_helpers.c     |  8 +-
>  include/linux/pm_domain.h                          |  4 +-
>  10 files changed, 140 insertions(+), 46 deletions(-)
> ---
> base-commit: 44ef70faf71468e0ae4bdb782a6d43f0614b8ffa
> change-id: 20260131-iris-venus-fix-sm8250-f938e29e7497
>
> Best regards,
> --
> With best wishes
> Dmitry
>

