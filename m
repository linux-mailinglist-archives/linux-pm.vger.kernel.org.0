Return-Path: <linux-pm+bounces-1474-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB8781AF2D
	for <lists+linux-pm@lfdr.de>; Thu, 21 Dec 2023 08:10:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 334EC285869
	for <lists+linux-pm@lfdr.de>; Thu, 21 Dec 2023 07:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE9C11719;
	Thu, 21 Dec 2023 07:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tO0NeL63"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69F9DDC9
	for <linux-pm@vger.kernel.org>; Thu, 21 Dec 2023 07:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-5e76948cda7so4873887b3.3
        for <linux-pm@vger.kernel.org>; Wed, 20 Dec 2023 23:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703142640; x=1703747440; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WHrUuj/exnxtqW6ATNiyZLpsPQWVa7uaSIxTrPoZquM=;
        b=tO0NeL63IdYPXPxX0pV68W+rwjfNWyVIWgBqth4Y9W2+KjFZIVmO0PyEkQKiI8rDrM
         UsXRnTwZ0HvtPz5RhE8hgIGZ3REE8YKZnU1UXJF3+oZhkHr0P/hBZMXsH3Wa2mRnlURO
         0EmKLXiccwiS+XC8Ji8smAgL0k+fK6pSGbski5OyAqf/on4jyGdGStXE2p1v7i8wSMYU
         +w/e6PVV6yevFjJbbyu8fwbmnvGaoKttDTXF1Q+ye5KYGEN8RfeaQNLGYgsa4258Ip6T
         9Od9bmV/gPKJRQm9tW+PGfdaZccg5RHeiYh1cmDgmVnuLz7HbvU8uKOmSLWCOeR21wSw
         HO6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703142640; x=1703747440;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WHrUuj/exnxtqW6ATNiyZLpsPQWVa7uaSIxTrPoZquM=;
        b=XFVMhGwg1Yutr0R2bbmwQ8ZAPbT5t5+1SO+1RXQgEaOcfmkJCT3mv5CZJABkLnhnL5
         K5UJKI2znHefYMWVhtXErl4umEZkuhtlBmCIGgUtbo0cMo9Nr34HfLyPLm7MNyHo7lr/
         FOrWnetIatzIqysKt+JMPVOAwqkEoZBLRAgrywBS96zyfr8f4PjO3PjbL71cWYgv1Z3h
         l0tlGR2w2I7AgfN8tLWhRd32Dn4XdCQCjHKggspHb8TfKmAWmkhLXEXHc601+Be+YvYP
         eCQejO7cT3Zp6QfSxu5H7ZmP1rbCPxNGcz0/j5GmxS9I5IM5SIGegbFJKtry46jMqVhw
         t4ug==
X-Gm-Message-State: AOJu0Yzcn99Tsi6JBP3dyCyrL7we16f9I1zIsvvdtqixobLsKXcxexja
	G9oPatiVo1CVzbJsFKB4SKeXDfrrQsW8dOe+raiHTw==
X-Google-Smtp-Source: AGHT+IGRR27RkAophues2zxqhga4xK/qpUWevFXi9jLY9oKVDFwq/l8z/fjbSH4UxmtcklXyorPamjQRQZdQ3pww8kM=
X-Received: by 2002:a81:bb46:0:b0:5e7:83a7:4e4 with SMTP id
 a6-20020a81bb46000000b005e783a704e4mr848083ywl.74.1703142639759; Wed, 20 Dec
 2023 23:10:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220-sa8295p-gpu-v1-0-d8cdf2257f97@quicinc.com>
 <20231220-sa8295p-gpu-v1-1-d8cdf2257f97@quicinc.com> <CAA8EJprRjRJsV5hPR6mzjgucKa8UEthJd-y573aYJH0P8QRWqw@mail.gmail.com>
In-Reply-To: <CAA8EJprRjRJsV5hPR6mzjgucKa8UEthJd-y573aYJH0P8QRWqw@mail.gmail.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 21 Dec 2023 09:10:28 +0200
Message-ID: <CAA8EJpqgcOJHUFHtrTEE0T+jtQqdv3RGm-eTuVVa0ama_eFssQ@mail.gmail.com>
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

On Thu, 21 Dec 2023 at 09:03, Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Thu, 21 Dec 2023 at 05:51, Bjorn Andersson <quic_bjorande@quicinc.com> wrote:
> >
> > In some designs the SoC's VDD_GFX pads are supplied by an external
> > regulator, rather than a power-domain. Allow this to be described in the
> > GPU clock controller binding.
> >
> > Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> > ---
> >  Documentation/devicetree/bindings/clock/qcom,gpucc.yaml | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml b/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml
> > index f369fa34e00c..013ef78d2b31 100644
> > --- a/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml
> > +++ b/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml
> > @@ -53,6 +53,9 @@ properties:
> >    power-domains:
> >      maxItems: 1
> >
> > +  vdd-gfx-supply:
> > +    description: Regulator supply for the VDD_GFX pads
> > +
> >    '#clock-cells':
> >      const: 1
>
> I think it might be good to restrict this property to a particular
> platform (via if:not:properties:compatible:contains
> then:properties:vdd-gfx-supply:false).

After reading the last patches in the series, there is another
suggestion. Maybe we should explicitly say that there should be either
power-domains or vdd-gfx-supply, but not both.


-- 
With best wishes
Dmitry

