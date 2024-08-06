Return-Path: <linux-pm+bounces-11948-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AEB5949370
	for <lists+linux-pm@lfdr.de>; Tue,  6 Aug 2024 16:43:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D14C1F252A5
	for <lists+linux-pm@lfdr.de>; Tue,  6 Aug 2024 14:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E0CE1C3F0B;
	Tue,  6 Aug 2024 14:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t5QlAkhZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2BF1C37AA;
	Tue,  6 Aug 2024 14:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722955331; cv=none; b=E07vccdV5QrPpz+OGxpK0ou1qX9srqbNLh9cZuVayucEL39WQB2SVqy2dAvfPHYc1TjzFMQOPW/RbDiI2Jp2cTqyFaPQcVSDyCWuYFcJvf6o3BWYHT/0qEu4CY4XgIKJJd+YDas+80iPFIm/6Xsmx6jJxiKU9ZTU0ahvFXVNFxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722955331; c=relaxed/simple;
	bh=HjNMR+ty9GrU7p91fTdn6RMgP4z5+pj5CYoj3Tjy3wg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bg+7GJqocOtsOOCVIuKLsR/Qv60rQGBqV96TZAzDH2RG/pw2I8sIRwFMCzENaCZs0bBkxAMDjFJ1psbPMyFipcuHgxJ0CegvHUv6aqwsRljuaXXOuSrNDQntCA2nz0jF4WO7G/9Mh9jrcsnvOIutJerFzYOfHxP40ZZ3Mxit9LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t5QlAkhZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09FA0C32786;
	Tue,  6 Aug 2024 14:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722955330;
	bh=HjNMR+ty9GrU7p91fTdn6RMgP4z5+pj5CYoj3Tjy3wg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t5QlAkhZN/pFf1OS2fZT/gSbT5rVivKV5wJtyry/nI/WY26l1sfg/XmFMS4vdqWx6
	 ptzucE4dHpvJPvE7F+/GLdKcNhMMezQoSMV51h7QmbghNSK5worifm/AB2joFM2fKS
	 HIvR/x++dJ5Bbq+kJYBGupDrhKo8zynq8TR17f/jI8I1SwxZ48Rev9D7O0IqAK3K+g
	 wrQve/W2KMWETkhylrH4HshfPYn6RWlsASbNwdE4M+qXGTBOauGvUmcD0fwOHTDaqY
	 +IAiESng8KuP8C25ZY835oit827T6fdVH+YSFcFlwY/ZmKq05WHzUD8IwGB5/F3NDq
	 BCtpHH/WA3kLQ==
Date: Tue, 6 Aug 2024 08:42:08 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Danila Tikhonov <danila@jiaxyga.com>
Cc: krzk+dt@kernel.org, quic_rjendra@quicinc.com, viresh.kumar@linaro.org,
	quic_kriskura@quicinc.com, devicetree@vger.kernel.org,
	heiko.stuebner@cherry.de, linux@mainlining.org,
	linux-usb@vger.kernel.org, ulf.hansson@linaro.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	macromorgan@hotmail.com, davidwronek@gmail.com,
	johan+linaro@kernel.org, javier.carrasco.cruz@gmail.com,
	linux-hardening@vger.kernel.org, fekz115@gmail.com,
	tony.luck@intel.com, andre.przywara@arm.com, kees@kernel.org,
	andersson@kernel.org, lpieralisi@kernel.org,
	dmitry.baryshkov@linaro.org, linus.walleij@linaro.org,
	conor+dt@kernel.org, rafal@milecki.pl,
	heikki.krogerus@linux.intel.com, gpiccoli@igalia.com,
	neil.armstrong@linaro.org, sudeep.holla@arm.com, rafael@kernel.org,
	gregkh@linuxfoundation.org, linux-arm-msm@vger.kernel.org,
	konrad.dybcio@linaro.org
Subject: Re: [PATCH 05/11] dt-bindings: soc: qcom: qcom,pmic-glink: Document
 SM7325 compatible
Message-ID: <172295532809.1490946.6805112460436096246.robh@kernel.org>
References: <20240729201843.142918-1-danila@jiaxyga.com>
 <20240729201843.142918-6-danila@jiaxyga.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729201843.142918-6-danila@jiaxyga.com>


On Mon, 29 Jul 2024 23:18:12 +0300, Danila Tikhonov wrote:
> Document the SM7325 compatible used to describe the pmic glink on this
> platform.
> 
> Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
> ---
>  Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


