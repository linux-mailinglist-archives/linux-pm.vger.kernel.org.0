Return-Path: <linux-pm+bounces-32920-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FAC2B322F2
	for <lists+linux-pm@lfdr.de>; Fri, 22 Aug 2025 21:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1A2424E185C
	for <lists+linux-pm@lfdr.de>; Fri, 22 Aug 2025 19:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54F2F2D3236;
	Fri, 22 Aug 2025 19:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QCsrNgGl"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2199A4A1A;
	Fri, 22 Aug 2025 19:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755891386; cv=none; b=FTo5wdgeCOesqq7wjwGUTcV33npscbwybHcUaguAbDc/+p/ToAWNbIG8h4Gw0MQenC8+HEZyZXGvsiNQHJD49TiCiVXpIRNofRxS1FHFDhmUzZTSvJ4ulYFHQE0k0pANuK9cYav72UGUrWab/fI5tvzmvoNi8tEdkUJ3OpuhG/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755891386; c=relaxed/simple;
	bh=zUCHNRR29X2q9YcEgJs3tXfAiU46otyD1jNMg85M99Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tl3yw0SXSfxTv9yTnS21AB4cc+fDaAziu50FGZNzA7lksJ/FgFVuKjQtV55dmM2sAHgWYyvgLPbv8HhvSvR2wQGNNybfp0G0hNeOB9GNlZFyvKVfAaG4GkcjLsedUXr56gyYeBnRglND6zDanIZHpU6tOx2nYbSeFvoENGE1j8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QCsrNgGl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C97EC4CEED;
	Fri, 22 Aug 2025 19:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755891385;
	bh=zUCHNRR29X2q9YcEgJs3tXfAiU46otyD1jNMg85M99Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QCsrNgGlw9/U8/bb96FmiCm0e7GCnSOxo2e73LWwl7l4/OVe3lBJSmgheBA3wLb4p
	 ztRSODRu6eLqie2tbnSD/eKWGhnDOzOJkb7VrjYLSDJkZQGl+AZGOfsJYtmu7zKqq0
	 25ykW8pS5oX4v1Lmh4YFYI4qONxivNNHghtLus1xvDWSJOY0AlylaAWJenmU8XDzbK
	 /YLxDPEm05uZqeftxy14lqO6DZC0FglHvw9JCscmhCLlRKfESVh4Dbk40NfaYIrMPV
	 JDzKMK3jbHP8NVAPQaSrpAkLf57lNF5AVfB2/gWXFJb0T1jTn+3GuM8k0H7J+WTJOu
	 BdTgWPpypKi0Q==
Date: Fri, 22 Aug 2025 14:36:24 -0500
From: Rob Herring <robh@kernel.org>
To: Duje =?utf-8?Q?Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	David Wronek <david@mainlining.org>, Karel Balej <balejk@matfyz.cz>,
	phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 2/4] dt-bindings: power: Add Marvell PXA1908 domains
Message-ID: <20250822193624.GA187008-robh@kernel.org>
References: <20250821-pxa1908-genpd-v2-0-eba413edd526@dujemihanovic.xyz>
 <20250821-pxa1908-genpd-v2-2-eba413edd526@dujemihanovic.xyz>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250821-pxa1908-genpd-v2-2-eba413edd526@dujemihanovic.xyz>

On Thu, Aug 21, 2025 at 01:17:44PM +0200, Duje Mihanović wrote:
> Add device tree bindings for Marvell PXA1908's power domains.
> 
> Signed-off-by: Duje Mihanović <duje@dujemihanovic.xyz>
> ---
> v2:
> - Drop schema
> ---
>  include/dt-bindings/power/marvell,pxa1908-power.h | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)

This should be squashed into the previous patch. The Reviewed-by stands 
with that.

> 
> diff --git a/include/dt-bindings/power/marvell,pxa1908-power.h b/include/dt-bindings/power/marvell,pxa1908-power.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..19b088351af138823505a774ff27203429fe2d97
> --- /dev/null
> +++ b/include/dt-bindings/power/marvell,pxa1908-power.h
> @@ -0,0 +1,17 @@
> +/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
> +/*
> + * Marvell PXA1908 power domains
> + *
> + * Copyright 2025, Duje Mihanović <duje@dujemihanovic.xyz>
> + */
> +
> +#ifndef __DTS_MARVELL_PXA1908_POWER_H
> +#define __DTS_MARVELL_PXA1908_POWER_H
> +
> +#define PXA1908_POWER_DOMAIN_VPU	0
> +#define PXA1908_POWER_DOMAIN_GPU	1
> +#define PXA1908_POWER_DOMAIN_GPU2D	2
> +#define PXA1908_POWER_DOMAIN_DSI	3
> +#define PXA1908_POWER_DOMAIN_ISP	4
> +
> +#endif
> 
> -- 
> 2.50.1
> 

