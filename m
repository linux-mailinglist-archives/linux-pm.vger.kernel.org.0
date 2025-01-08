Return-Path: <linux-pm+bounces-20127-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F28A0699C
	for <lists+linux-pm@lfdr.de>; Thu,  9 Jan 2025 00:43:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C9C51886571
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jan 2025 23:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5894C204C36;
	Wed,  8 Jan 2025 23:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EYbEEhm1"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0E71F4E50;
	Wed,  8 Jan 2025 23:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736379783; cv=none; b=NDp0oc+YELf6SXwe9wH8gcthKaW1h1vVNAFnX5jL7bSoZJvH6tBzObWNKnv6d21Uiva7KiD6FOY3Ip6YaMOR8ax6T9VF7LBI1jwB4BjPRfbpp/UO9iY6E66Dc9X2y62A0d1AyXhO0zjK3Abis9GWW6AbCHjsQP22eAiPwOvZD5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736379783; c=relaxed/simple;
	bh=s4LvSNjHxIP96RzfdWGBTy4l/TRP9WawToXBJ3jEbDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qzKRtupX1rrbJQKf+2pVKDg87CTwvoV28ZUr/digt9UJcYYAtWNTIB/OxNj8cR27vTyhmc++wH+vX+1mk0pJYdzPIZ8dnizpySMnDP8MXy5FWHRJ/O95VBgMGZih4aOuCxxay4RfzgNwUVQUeM4zhfpwuki4kcYl2ln0DYMPasM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EYbEEhm1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63875C4CED3;
	Wed,  8 Jan 2025 23:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736379782;
	bh=s4LvSNjHxIP96RzfdWGBTy4l/TRP9WawToXBJ3jEbDQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EYbEEhm1CFBpKOF7XnweDcLAexyqeuTzkSHkQExDipKQUUT8VqGRxtVRR4dh0wNzJ
	 +sdP3Kpo/GvGYKkMtl4NPRFmhDVaRlLh8KOW1lQaM5fyt3gOqXEalHIYuhCUQ9FBoY
	 WrIHnWX9FMf4cpRnH55Lwo8akkfr+n7jiarjTG4viRX93g9VY4Fl2kv/hstGRv9dY5
	 SBogs/jPPHr6sfa4Ibq0awgNNOEyTxvj7xqN1FReEhTBKgomCG+sk/ojFLE+U+YSX8
	 qM17op01B0H02HLbCp/zw7IteLZmUV9FmdzVNM/o1Qgjt/x1/sJr22ceBIahG4BaiF
	 Hy9aEoCXOGQLg==
Date: Wed, 8 Jan 2025 17:43:01 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: linux-pm@vger.kernel.org, magnus.damm@gmail.com,
	linux-renesas-soc@vger.kernel.org, lukasz.luba@arm.com,
	mturquette@baylibre.com, ulf.hansson@linaro.org,
	linux-clk@vger.kernel.org, geert+renesas@glider.be,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	rui.zhang@intel.com, p.zabel@pengutronix.de,
	linux-arm-kernel@lists.infradead.org, rafael@kernel.org,
	conor+dt@kernel.org, krzk+dt@kernel.org, daniel.lezcano@linaro.org,
	sboyd@kernel.org
Subject: Re: [PATCH 3/6] dt-bindings: thermal: r9a08g045-tsu: Document the
 TSU unit
Message-ID: <173637978084.1245245.17902878993210680410.robh@kernel.org>
References: <20250103163805.1775705-1-claudiu.beznea.uj@bp.renesas.com>
 <20250103163805.1775705-4-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250103163805.1775705-4-claudiu.beznea.uj@bp.renesas.com>


On Fri, 03 Jan 2025 18:38:02 +0200, Claudiu wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> The Renesas RZ/G3S SoC includes a Thermal Sensor Unit (TSU) block designed
> to measure the junction temperature. The temperature is measured using
> the RZ/G3S ADC, with a dedicated ADC channel directly connected to the TSU.
> Add documentation for it.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>  .../thermal/renesas,r9a08g045-tsu.yaml        | 93 +++++++++++++++++++
>  1 file changed, 93 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/renesas,r9a08g045-tsu.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


