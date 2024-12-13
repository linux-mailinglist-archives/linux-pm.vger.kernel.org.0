Return-Path: <linux-pm+bounces-19180-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C3829F07B6
	for <lists+linux-pm@lfdr.de>; Fri, 13 Dec 2024 10:22:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CC06284B80
	for <lists+linux-pm@lfdr.de>; Fri, 13 Dec 2024 09:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E0771B0F00;
	Fri, 13 Dec 2024 09:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E7L2e/2m"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB531AB6DD;
	Fri, 13 Dec 2024 09:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734081741; cv=none; b=dgiM0HAdSiV/+lhieHq1CrccG3HbD1Y6e7DQ14oOJGPOGClJSOLXJKAkzpzIzA0vebH2AcyIqFWSz8cl78WseZ+KRlIhZqAYLmtScZcH18q9YZKoUkmMj4tQCNuVUqPcKmYIXfEPCYy8PM4tVHkp9Cs9cFkF+FUpsBcOSnpRmB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734081741; c=relaxed/simple;
	bh=b52vfwJl4uqGickd+6KGXREsb2dmjrVhmMOCLp8FrCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=llCEnkQH61PcHS7o02bVVY+gT7t22KMZlbTWOnmBR7kGF8RwigFnQo5tiNoPGtJnFDpMPIVEggmcsKGYNBpSDJWwEH3nB/tsRJJCDAKzqxGEnwD1RQ2VqYUcfiK2GI11RiF7ijGKzPH6w2T4EwLx4wuMWh+85Fm/c4u1pjvgE8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E7L2e/2m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C933BC4CED0;
	Fri, 13 Dec 2024 09:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734081738;
	bh=b52vfwJl4uqGickd+6KGXREsb2dmjrVhmMOCLp8FrCU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E7L2e/2mavqt654a1ofIbOwMfZcqfVlNka9m4KCBbzEZmt4MS2+HikUz5jnpv+n86
	 j6kkmMv9ACjoLdiwezM5VqwhizhGptVmsEV7bTJuxczO/I1xqSi210FkfYxQnmQrCF
	 +YDqbnwOQjExnC5wSDvIO3zc/5xOjpj/RyngbiLjB68zKIE4sUZ78aH4DpG9vavkAm
	 ritUX5VulVKYIUeBsWUCG+9zA+Vsdu/+M3+RvSS+HWoV6X4tlxqjT6SzbRKqmNangi
	 V2+j7oQ5YP/BpdwWh4HmFU0f4qSxnlyZt+aaRW7Zrg1lBFRTclSuH8Y7ERXBmlfFCF
	 BaeZ9JcpYdL6w==
Date: Fri, 13 Dec 2024 10:22:15 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Pengfei Li <pengfei.li_1@nxp.com>, Marco Felsch <m.felsch@pengutronix.de>, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: thermal: fsl,imx91-tmu: add bindings
 for NXP i.MX91 thermal module
Message-ID: <kb2mekvslpkj23a3ymdfwcpugvlscn736kjfwst24xqdgyqrfn@jozxo7o7enbi>
References: <20241212-imx91tmu-v3-0-85e756b29437@nxp.com>
 <20241212-imx91tmu-v3-1-85e756b29437@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241212-imx91tmu-v3-1-85e756b29437@nxp.com>

On Thu, Dec 12, 2024 at 03:59:59PM -0500, Frank Li wrote:
> From: Pengfei Li <pengfei.li_1@nxp.com>
> 
> Add bindings documentation for i.MX91 thermal modules.
> 
> Signed-off-by: Pengfei Li <pengfei.li_1@nxp.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


