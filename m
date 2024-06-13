Return-Path: <linux-pm+bounces-9091-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9840907847
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 18:28:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5ADA4283C8D
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 16:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F41201474B5;
	Thu, 13 Jun 2024 16:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H4joEmRu"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE9C12D757;
	Thu, 13 Jun 2024 16:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718296131; cv=none; b=r99auG/MEILIqt7yvdeV+RHxIAVJZ5lUr2wXueLKRrdxzllgdb/Hfxe3eKcG92XFctMEAzleCaEqDI18TGabFa0y/cLHwnnNJph8byU0feFcvo5ZN8Xb8oW971XvoaS0vzBIhyNfrAcFWNNH/fXwRInZlDuvXvbORE0GIjXUj7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718296131; c=relaxed/simple;
	bh=KYCv3hQWoN1j7XUdm21Zt9d+voXjs1ywP3w3OudzhlI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FKc6LZ2OvP5E/rfwPaEhaAPTpDpnh0w+ybFPvK1qXYNYdNzYLWcdtxaEw6SZczggdalOTSnYYGZuHFpDJbJVjZ/o4r8XpDy9u/jH5RgDw0Bu3sIjKYyhrnGJJyvzW/xi+O2Q8jC8lty1vlyEZNyD92okbLFiaC3CaV6lRdJB0ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H4joEmRu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 042F3C2BBFC;
	Thu, 13 Jun 2024 16:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718296131;
	bh=KYCv3hQWoN1j7XUdm21Zt9d+voXjs1ywP3w3OudzhlI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H4joEmRucqYlJcLIeksv8iywzdSmaJd9cqa6dJAixBXwVFSpFyzU8YJKhU7pJ+gvG
	 vLpL8FKNw8KThaS4h2m2IK1K7FlmlKTJvFmstu1DTz23syMuoDKTf6QUkXpAkgLcJc
	 Jn8jWbVFNAkx7Oj4RdzOfyy5pioXEmc1GkDKRGR+Y85im0LON069CBynHJZofgUHFx
	 tZEc/Es98a5g1yIRiSZHRPs2Kid8Plcpl08FKCEEsix46V962zyXwnrs6bPZxUWp32
	 BC+DtiOl/bHQE4ObYTqhqNpnz89c/qkJfiuYyLFZYG8+NqXDjhYP3N1U9eldc1E0dp
	 /jTk35oN/xJ4g==
Date: Thu, 13 Jun 2024 10:28:48 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Odelu Kukatla <quic_okukatla@quicinc.com>
Cc: quic_mdtipton@quicinc.com, linux-arm-msm@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	cros-qcom-dts-watchers@chromium.org,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	linux-pm@vger.kernel.org, Kees Cook <keescook@chromium.org>,
	quic_rlaggysh@quicinc.com, Konrad Dybcio <konrad.dybcio@linaro.org>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	Georgi Djakov <djakov@kernel.org>
Subject: Re: [PATCH v5 3/4] dt-bindings: interconnect: add clock property to
 enable QOS on SC7280
Message-ID: <171829612654.1988993.3785634347630091942.robh@kernel.org>
References: <20240607173927.26321-1-quic_okukatla@quicinc.com>
 <20240607173927.26321-4-quic_okukatla@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607173927.26321-4-quic_okukatla@quicinc.com>


On Fri, 07 Jun 2024 23:09:26 +0530, Odelu Kukatla wrote:
> Add clock property to enable the clocks required for accessing
> QoS configuration registers.
> 
> Signed-off-by: Odelu Kukatla <quic_okukatla@quicinc.com>
> ---
>  .../interconnect/qcom,sc7280-rpmh.yaml        | 53 +++++++++++++++++++
>  1 file changed, 53 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


