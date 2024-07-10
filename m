Return-Path: <linux-pm+bounces-10941-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDD0E92D5F7
	for <lists+linux-pm@lfdr.de>; Wed, 10 Jul 2024 18:14:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 871F22832B1
	for <lists+linux-pm@lfdr.de>; Wed, 10 Jul 2024 16:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B824E198E9B;
	Wed, 10 Jul 2024 16:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BdwAh+dN"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8042E197A65;
	Wed, 10 Jul 2024 16:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720627893; cv=none; b=A8197uxwiwZNou8WLfShfiLw1k+qmPu0UJ4i3Qwemx15RIOw+wLaCW5K7C7d+zSYK8soJMkRdKNZS96ttzDjSQOkpZV9xas1z15PJTTl3vfkSjnhd6QP1SVRTb2fw331qG6tq6ebgFgqj0boRqLq/8CVG4Cziy+2EMB/2c+LmQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720627893; c=relaxed/simple;
	bh=a+7WKy915cYtcjH7UwZEbtB/L6kz1ndbvjx3AaxaK30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ViAxef5uePHabAmmPyA/TP8/NFKGR3+Dg0KSClOn5ak+23lV3PYYWrBc+OddYaGwIbwFekhHiVp9lnIGpzjnvH+ySshznyPDxRHqXw3Qu4a2fEdCWmNNW+aWlmQmbJdjdW9ifdcW050FNSBO4CDmer9CE/beJDMKHqjvwi7x3Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BdwAh+dN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A62B2C4AF0A;
	Wed, 10 Jul 2024 16:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720627892;
	bh=a+7WKy915cYtcjH7UwZEbtB/L6kz1ndbvjx3AaxaK30=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BdwAh+dNSn6JErm1pydRtzjQ4/A74kobkcw3ruKNPrJTfnzZ7LFJgu25e8HIraQPv
	 uvlS/RLvof+nQdHtMbpUAPrZ+xFLffJ39TwJNTWSk6ObSRxPu4da+/vMhWPdC2wo6w
	 fmf2prSUTwNnWuWzsuJBTvE8LZOiFc1o0gY6gTzgy0VpVvlnawGfDHQG1TPnDqLH1c
	 5WSy0EF8jjMEj0xL/4ltPqKOSytJF1E91s1muNNUWUBteUJTNua0+rpluB6PS5d0Gl
	 ilK1vuPd+xx1nsKC83ptMtaKnn4kE4RQ40uxiHIDdOIW95o6jML386eya5qXMFoXKv
	 MjPh0lw5Xsp7Q==
Date: Wed, 10 Jul 2024 10:11:31 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Adam Skladowski <a39.skl@gmail.com>
Cc: Sibi Sankar <quic_sibis@quicinc.com>, Georgi Djakov <djakov@kernel.org>,
	Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
	devicetree@vger.kernel.org, phone-devel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Vladimir Lypak <vladimir.lypak@gmail.com>,
	Abel Vesa <abel.vesa@linaro.org>, linux-arm-msm@vger.kernel.org,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Rohit Agarwal <quic_rohiagar@quicinc.com>,
	Rajendra Nayak <quic_rjendra@quicinc.com>,
	~postmarketos/upstreaming@lists.sr.ht,
	Conor Dooley <conor+dt@kernel.org>,
	Barnabas Czeman <barnabas.czeman@mainlining.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	linux-kernel@vger.kernel.org, Danila Tikhonov <danila@jiaxyga.com>,
	linux-pm@vger.kernel.org, Andrew Halaney <ahalaney@redhat.com>
Subject: Re: [PATCH v3 9/9] dt-bindings: interconnect: qcom: msm8953: Fix
 'See also' in description
Message-ID: <172062789070.3205605.3268441513464795042.robh@kernel.org>
References: <20240709102728.15349-1-a39.skl@gmail.com>
 <20240709102728.15349-10-a39.skl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240709102728.15349-10-a39.skl@gmail.com>


On Tue, 09 Jul 2024 12:22:54 +0200, Adam Skladowski wrote:
> "See also" in description seems to be wrongly defined,
> make it inline with other yamls.
> 
> Fixes: 791ed23f735b ("dt-bindings: interconnect: qcom: Add Qualcomm MSM8953 NoC")
> Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
> ---
>  .../devicetree/bindings/interconnect/qcom,msm8953.yaml         | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


