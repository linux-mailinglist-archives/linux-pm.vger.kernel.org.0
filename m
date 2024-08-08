Return-Path: <linux-pm+bounces-12017-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B5B294C65D
	for <lists+linux-pm@lfdr.de>; Thu,  8 Aug 2024 23:38:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E793A1F267C4
	for <lists+linux-pm@lfdr.de>; Thu,  8 Aug 2024 21:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A432A156238;
	Thu,  8 Aug 2024 21:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XNzZOTNc"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641302F23;
	Thu,  8 Aug 2024 21:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723153122; cv=none; b=qPxR59M5Lz2Sk+dZqsPg7PAO8PQHDK/Js96kdsSqIHesFdryd92801In3duB3ZTc1Kt1sEh0U2KmYXjPSeIXewd8D5KBf9pW38gxRG1mdabE4t+9srvOQfDzlAtpaC7tgqx0vLrgPYNmAtVM5zmH/EA7XpTb4SHYB44yPsplfBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723153122; c=relaxed/simple;
	bh=kOoVeCQRzz5AEUzNBWPxw4tJpCN8l/YGJXAKuoLdmy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MkuPssMTel0jrNepwOkBnYMP97RJpnnerkqK3nQDA2aKKVvK5zybkkUfehdgIQs/Jc/zmagX2bWTC8fDajYxsGwS0WV23GwVLD6HGV8eAYww9XZQlu6Gjc8SkqoWJzeyiZ3x0YV7e4PLMgqXsBE+hsKJ9T4jsHD6Vfq//a17BOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XNzZOTNc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B38F0C32782;
	Thu,  8 Aug 2024 21:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723153122;
	bh=kOoVeCQRzz5AEUzNBWPxw4tJpCN8l/YGJXAKuoLdmy8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XNzZOTNca4FvaUnhia8RoUWo4GJJZV+LBzM3V6NhHnmk5Od6CQg4Nmfnpwo0dlsdj
	 A2meofjwULYCPbuKaQlUjb6LKZbZCkE+9mJ9MIN7hGbzPsY4Cku03pCIcH8ShHS+3b
	 39X4E51AKXEwldgRpeljVYgDTBbsPGTkKCHH4ieMYUnymQbU6y+Pa6v1bfusqv6wa7
	 zDJHgVEx7JUOO7eMAgNJcCFNdDcBOkbmPvo2C57rPPxmVQobPCoWebcB6bzUaV4Qap
	 vnj/aGHgnglb3g5I67NmtpF4aV0FSmcsvRZ6eEbSfqB1YZALowMnIvAWYcskiGN6jC
	 6UnXuOlOQAVRg==
Date: Thu, 8 Aug 2024 15:38:40 -0600
From: Rob Herring <robh@kernel.org>
To: Danila Tikhonov <danila@jiaxyga.com>
Cc: krzk+dt@kernel.org, conor+dt@kernel.org, andersson@kernel.org,
	konradybcio@kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, rafael@kernel.org,
	viresh.kumar@linaro.org, kees@kernel.org, tony.luck@intel.com,
	gpiccoli@igalia.com, ulf.hansson@linaro.org, andre.przywara@arm.com,
	quic_rjendra@quicinc.com, davidwronek@gmail.com,
	neil.armstrong@linaro.org, heiko.stuebner@cherry.de,
	rafal@milecki.pl, macromorgan@hotmail.com, linus.walleij@linaro.org,
	lpieralisi@kernel.org, dmitry.baryshkov@linaro.org,
	fekz115@gmail.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	netdev@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 08/11] arm64: dts: qcom: Add SM7325 device tree
Message-ID: <20240808213840.GA2186890-robh@kernel.org>
References: <20240808184048.63030-1-danila@jiaxyga.com>
 <20240808184048.63030-9-danila@jiaxyga.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240808184048.63030-9-danila@jiaxyga.com>

On Thu, Aug 08, 2024 at 09:40:22PM +0300, Danila Tikhonov wrote:
> From: Eugene Lepshy <fekz115@gmail.com>
> 
> The Snapdragon 778G (SM7325) / 778G+ (SM7325-AE) / 782G (SM7325-AF)
> is software-wise very similar to the Snapdragon 7c+ Gen 3 (SC7280).
> 
> It uses the Kryo670.
> 
> Signed-off-by: Eugene Lepshy <fekz115@gmail.com>
> Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sm7325.dtsi | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/sm7325.dtsi
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm7325.dtsi b/arch/arm64/boot/dts/qcom/sm7325.dtsi
> new file mode 100644
> index 000000000000..5b4574484412
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sm7325.dtsi
> @@ -0,0 +1,17 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2024, Eugene Lepshy <fekz115@gmail.com>
> + * Copyright (c) 2024, Danila Tikhonov <danila@jiaxyga.com>
> + */
> +
> +#include "sc7280.dtsi"
> +
> +/* SM7325 uses Kryo 670 */
> +&CPU0 { compatible = "qcom,kryo670"; };
> +&CPU1 { compatible = "qcom,kryo670"; };
> +&CPU2 { compatible = "qcom,kryo670"; };
> +&CPU3 { compatible = "qcom,kryo670"; };
> +&CPU4 { compatible = "qcom,kryo670"; };
> +&CPU5 { compatible = "qcom,kryo670"; };
> +&CPU6 { compatible = "qcom,kryo670"; };
> +&CPU7 { compatible = "qcom,kryo670"; };

No PMU? Because PMUs are also a per CPU model compatible string.

I fixed most QCom platforms recently.

Rob

