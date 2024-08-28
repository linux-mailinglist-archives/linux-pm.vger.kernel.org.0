Return-Path: <linux-pm+bounces-13048-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E6F09631BD
	for <lists+linux-pm@lfdr.de>; Wed, 28 Aug 2024 22:26:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21DC92846B6
	for <lists+linux-pm@lfdr.de>; Wed, 28 Aug 2024 20:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 119E81AC897;
	Wed, 28 Aug 2024 20:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XsHode9S"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81DA1AAE3F;
	Wed, 28 Aug 2024 20:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724876803; cv=none; b=WlI+ruk9I0+nJMDHOTnpUGUGeLEvZQhT9eEJKbwoEFNs6Y5hQd26Y9DyyIyvt8m8XkhPXvjuesNcRB1OMqvLRmwQt7P/q9Z6/IIcbmcaCM6j/j9ebBLeY959FpfMV9SUtuhMUjX9SAX70EZDqKGCe3X+Yg2de9KiEzdevhB9HNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724876803; c=relaxed/simple;
	bh=Q43f6wvdjESKwx8IvcasE2ZU9/ZVOWLiHoqUlY336h8=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=tR8avp1LE9Vds5VfPsZjeJuSKO/rmkogQtPiLLXKF3ocWGrAtPbWOIidCCSUvhLRL7BBGdjdgk3GUqrDrTlxfr72/MkwgOrvdm1dJNdx0jDvgg/hk1zSyakpUOp4rkx4WMjGdbWeAy1a4+1KTNAFOtbbuqQ6EMdGokdvMABeisQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XsHode9S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F305C4CEC0;
	Wed, 28 Aug 2024 20:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724876803;
	bh=Q43f6wvdjESKwx8IvcasE2ZU9/ZVOWLiHoqUlY336h8=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=XsHode9StjzQOqIks0AuhzaX0uRGdwiGE+bqxZ/ubG8x2cBleYghV/87EdMDRNI1b
	 V9NC1lfNQH1Oxya7CkcpIt+/G3JXCX3fS5EeDMiQE9coiexyC3l2eO/FHZAKen01fM
	 7P/GgewSAX8A0bfUk1V1YNy9JcZCl/Z549nTtz7P6Di715gTDmE/WNwUcBXh5bWJ/n
	 uLp+EE/BCEEFhgk6zF96/N7udHnv1Xq8RkIk2KvZ38asBceg3/5Iy0+c6WAZw86X5V
	 5JhZjzasOS3YawvLzXfS+luT8YBRi7EQ5X8l+Ns6gh0KCgxY6HOFOHOjZ5Ue5iPUXQ
	 QtJeSdK1ItETA==
Message-ID: <3ea62df4ff2d6615d0033322426f5f67.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240820055705.3922754-6-quic_varada@quicinc.com>
References: <20240820055705.3922754-1-quic_varada@quicinc.com> <20240820055705.3922754-6-quic_varada@quicinc.com>
Subject: Re: [PATCH v7 5/7] clk: qcom: gcc-ipq9574: Add CPR clock definition
From: Stephen Boyd <sboyd@kernel.org>
Cc: Varadarajan Narayanan <quic_varada@quicinc.com>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Varadarajan Narayanan <quic_varada@quicinc.com>, andersson@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, ilia.lin@kernel.org, konradybcio@kernel.org, krzk+dt@kernel.org, linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, mturquette@baylibre.com, rafael@kernel.org, robh@kernel.org, ulf.hansson@linaro.org, viresh.kumar@linaro.org
Date: Wed, 28 Aug 2024 13:26:41 -0700
User-Agent: alot/0.10

Quoting Varadarajan Narayanan (2024-08-19 22:57:03)
> diff --git a/drivers/clk/qcom/gcc-ipq9574.c b/drivers/clk/qcom/gcc-ipq957=
4.c
> index 80fc94d705a0..058cde71b202 100644
> --- a/drivers/clk/qcom/gcc-ipq9574.c
> +++ b/drivers/clk/qcom/gcc-ipq9574.c
> @@ -3997,6 +3997,43 @@ static struct clk_branch gcc_xo_div4_clk =3D {
>         },
>  };
> =20
> +static const struct freq_tbl ftbl_hmss_rbcpr_clk_src[] =3D {
> +       F(24000000, P_XO, 1, 0, 0),
> +       { }
> +};
> +
> +static struct clk_rcg2 rbcpr_clk_src =3D {
> +       .cmd_rcgr =3D 0x48044,
> +       .mnd_width =3D 0,
> +       .hid_width =3D 5,
> +       .parent_map =3D gcc_xo_map,
> +       .freq_tbl =3D ftbl_gp1_clk_src,
> +       .clkr.hw.init =3D &(struct clk_init_data){

Please mark these clk_init_data structures as const.=20

> +               .name =3D "rbcpr_clk_src",
> +               .parent_data =3D gcc_xo_gpll0_gpll4,

