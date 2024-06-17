Return-Path: <linux-pm+bounces-9325-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D388790AC89
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 13:01:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 056361C21559
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 11:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12AEC1946DB;
	Mon, 17 Jun 2024 11:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o+1WFjLe"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202E5381A1
	for <linux-pm@vger.kernel.org>; Mon, 17 Jun 2024 11:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718622066; cv=none; b=PDsrPFw3TZvzjGFDxEMD10U1kKgk8f/g2O7wqozbtGsaLjgytaXJ8KnHosBMbgUe7xJCwRisEYVgZ/qoR+8Y4Kklax5OF7TTxUOuohM/W42NXhdxYd9PTWQ1yr9CJMvp2yWQXgi5zqR1iy4pUx/BHvaeBUKu8VkPZ+gfimkd+nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718622066; c=relaxed/simple;
	bh=cKofoxhoSF5ZQPhIVi4G0l+IsmRHCdzIQcUF+FD2XyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kylpSx1EOqHde2IIZsp9FGLCXDFDXfA4fYtq6fmysJ1PtWTJmYyEESiEeUuml+ZhAv3KXW+QK5Vd3/vjtOmDP2cVYC/0Iz6NDu4cAZmryfy92SWCur8H+Jas7mWx/MAi24YNsW1FSbHrcbzZZpnTRiCrfXEH01wpPER3bg7+ypc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=o+1WFjLe; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2ebeefb9a7fso57785301fa.0
        for <linux-pm@vger.kernel.org>; Mon, 17 Jun 2024 04:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718622061; x=1719226861; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/SjNe9vmU5byAvsAKJbghGk4V4PXep6SvlVxJjNPLCM=;
        b=o+1WFjLe5iHMnIJFK6/5EHggVUxNKTkLC5bRpkyDnPnH4mFa9+xozoX8waK8199/JW
         wJGUHx6s3Kih4j3glwb8ZjxrwL04nPOLGbObdjoUlunI8gdKtckGmgHxBkS5mygTnlIM
         Ivi49dwortHOAfnXqMSMN0iWi/6qzz7viR0tnXgIKNvTcyOjrmCTESjzYPd8UGbOg6wB
         VsHriqkSsoOPbLysJopShTYMlBt6lxsc8eUdUXvExM8bgMAfXDFTBVLWr6mGoSDisjL8
         GfsvUrLQWVPc7SEhSy3KNGMmuEeXl9VNFPs5/JqOeDznd7jyAlGwfjkBMLbKv6NMtFaS
         X8Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718622061; x=1719226861;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/SjNe9vmU5byAvsAKJbghGk4V4PXep6SvlVxJjNPLCM=;
        b=pG2+ACAzFx4vRrR37tRxgNDfc/6Zm80h5yzLGCD9SsAyDv0bacQtc/Y9LVg9Y3CrcC
         MW8QRWCwyUQQwBbLgcogXJpaluIb4l5duPSRcfzEtDC+My6YsCl7QTe89U+FHp7LftJ2
         jafj12GQHbx9NPApD1IVPhKxiqrEPBO+y4WjLZHKXKCeNQHui9IPvdzlUF95jEyDcPj5
         bBkZ65vTGkSEDnovOZyAccuxWpzkjnMjviMLskq8RXoa0LDjgQamiSDIX1owR/Zp6ocu
         OXoybmNqI3gA9w/0LeNd6NWw0PxQiHK8apuTjdYFBT2og2eNjPPwDAh33O3I6VJmEei+
         ub/A==
X-Forwarded-Encrypted: i=1; AJvYcCWaX89ZeRN2YLL7FEFrvAKQ6IbkOS6k396sknhPWzEHizfPtgDQGD3+CbmF/ThxHhBYzKX39B/YN3dVfsNqIS8sqrFoq8vJ6W0=
X-Gm-Message-State: AOJu0Yx52sIdcq7Wn3OJSxqI/EEl3KDFmdKr8howyOF2bfBUq6yGs0Iu
	m+vps73IXvD3qzne3kUaREiIAowy+2r8i7ThwUKnKhcG/vKbxPhkyXtKIiBmlfE=
X-Google-Smtp-Source: AGHT+IEXhLINf4w3Jt6vhMBeIEaqYtSUuf/UGyq0ougmpEhxyfRWYmFs/qW8gnDYQ7pYqWK6RaW5Ug==
X-Received: by 2002:a05:6512:10ce:b0:52c:bd0a:dd32 with SMTP id 2adb3069b0e04-52cbd0add64mr1873804e87.46.1718622061319;
        Mon, 17 Jun 2024 04:01:01 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ca282de47sm1203069e87.66.2024.06.17.04.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 04:01:00 -0700 (PDT)
Date: Mon, 17 Jun 2024 14:00:59 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Tengfei Fan <quic_tengfan@quicinc.com>
Cc: krzysztof.kozlowski@linaro.org, djakov@kernel.org, robh@kernel.org, 
	conor+dt@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org, 
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel@quicinc.com
Subject: Re: [RFC PATCH 0/2] arm64: qcom: Add BWMON support for SA8775p
Message-ID: <3yrji5rrzrfj3j4bekvhos36mgafbdcufsslk5daqfn7y5k2qz@k3nrrlbnlsmb>
References: <20240617092940.1724962-1-quic_tengfan@quicinc.com>
 <yb3ni6o22zdm2lqodj7utdb2dlg3jkbwzutxhmljxle3syoe5y@op2prslmri4y>
 <d997f42d-0616-4180-ae36-9d2ebd60d15f@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d997f42d-0616-4180-ae36-9d2ebd60d15f@quicinc.com>

On Mon, Jun 17, 2024 at 06:42:42PM GMT, Tengfei Fan wrote:
> 
> 
> On 6/17/2024 5:43 PM, Dmitry Baryshkov wrote:
> > On Mon, Jun 17, 2024 at 05:29:38PM GMT, Tengfei Fan wrote:
> > > Add CPU and LLCC BWMON nodes and their corresponding OPP tables for
> > > SA8775p SoC.
> > 
> > This series is marked as RFC, Request For Comments. What kind of
> > comments are expected for the series?
> > 
> 
> I found that the BWMON patch for x1e80100[1] is currently under review.
> There are upstream comments suggesting that we reference the same shared OPP
> table from all the BWMONs that share the same OPP table. However, there will
> be some DTBS CHECK warnings[2] if we do reference the same shared OPP table.
> 
> Therefore, I pushed this patch series to collect some comments on whether we
> can have separate OPP tables for each BWMON, as the OPP table of
> "pmu@90b5400" and "pmu@90b6400" in this patch series.

Thank you for the explanation. Now why wasn't this a part of the cover
letter?

> 
> [1]
> https://lore.kernel.org/lkml/4ef1d9a9-6a0e-4324-b6d5-2ae225855b03@linaro.org/
> 
> [2]
> arch/arm64/boot/dts/qcom/sa8775p-ride.dtb: pmu@90b5400: 'opp-table' is a
> required property from schema $id:
> http://devicetree.org/schemas/interconnect/qcom,msm8998-bwmon.yaml#
> 
> > > 
> > > Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
> > > ---
> > > 
> > > This patch series depends on patch series:
> > > "[PATCH 2/4] soc: qcom: icc-bwmon: Allow for interrupts to be shared across instances"
> > > https://lore.kernel.org/lkml/20240604011157.2358019-3-quic_sibis@quicinc.com/
> > > 
> > > Tengfei Fan (2):
> > >    dt-bindings: interconnect: qcom-bwmon: Document SA8775p bwmon
> > >      compatibles
> > >    arm64: dts: qcom: sa8775p: Add CPU and LLCC BWMON
> > > 
> > >   .../interconnect/qcom,msm8998-bwmon.yaml      |   2 +
> > >   arch/arm64/boot/dts/qcom/sa8775p.dtsi         | 115 ++++++++++++++++++
> > >   2 files changed, 117 insertions(+)
> > > 
> > > 
> > > base-commit: 6906a84c482f098d31486df8dc98cead21cce2d0
> > > -- 
> > > 2.25.1
> > > 
> > 
> 
> -- 
> Thx and BRs,
> Tengfei Fan

-- 
With best wishes
Dmitry

