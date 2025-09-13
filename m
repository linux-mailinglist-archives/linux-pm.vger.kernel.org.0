Return-Path: <linux-pm+bounces-34589-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69806B55FCC
	for <lists+linux-pm@lfdr.de>; Sat, 13 Sep 2025 11:16:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4BF61B27DCF
	for <lists+linux-pm@lfdr.de>; Sat, 13 Sep 2025 09:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD86270545;
	Sat, 13 Sep 2025 09:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ApP3lpej"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628B5747F;
	Sat, 13 Sep 2025 09:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757754971; cv=none; b=rXbhedHIxTjtg1jRiMC0ldW/p19UuDjr/cVAL0XXPAF1QqiaDe1CyWthkOAP4WO7g4P+upFWsTPVTVjHQvwY6umAN6YiOfGPSt5baBXzl0JTnNThCD2glBOEoQg8JlBEEVqKzBqXihza1I+EKQQppJwsss2+C25/m4wnz8EggGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757754971; c=relaxed/simple;
	bh=tIdpl+E9qiPpRky8s9y/LrALOp3p9zK9giky241MagU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HLepzB+zrlImdVou/gL9wGc8gW/3vntDu0qUL6be0IaxOlzoX86YfJHiAzIUCG5HKJGbR09A9ScwfzGah3E22HB3xjw3hgiCVt1ly1e9kwTvbF3YrQGVr+rqXQdVhNz6W/cqrOqa2aK5XEbhy4PAxpou8EHNlf3+rkckPnFqlJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ApP3lpej; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF665C4CEEB;
	Sat, 13 Sep 2025 09:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757754971;
	bh=tIdpl+E9qiPpRky8s9y/LrALOp3p9zK9giky241MagU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ApP3lpejWn30G2bgA2ehbS3Ka26Z+JAlbpL80GW1VdmC2SuBpe5XIFWE5tUIpa8cX
	 gRiD3eRMAft2Sq7jzXSv4PkzkeiR86yhl5bdPiyfMgr1Ae4bwZT09VTSKACagMfQe7
	 6J4NIRmMVmzy321QEzvJL5fDRu0hT32gg/b8UzhQsdd9Nl8mz8XOkEVM2jsJGMMMXR
	 om24bPxkm8kyhvA0xOVZKVXWt9cAjdLG1MuCQzuS+e6liSRuDfY47w9+TH2x4WC1f6
	 KTkHCbGGsUVodAb4BM9hmGSX2osedxVL9d/CQksXy0aRBsP114fd7B1mDU7ALv8JDY
	 fjolwuRHLU8cw==
Date: Sat, 13 Sep 2025 10:16:04 +0100
From: Simon Horman <horms@kernel.org>
To: "irving.ch.lin" <irving-ch.lin@mediatek.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Qiqi Wang <qiqi.wang@mediatek.com>, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org,
	netdev@vger.kernel.org,
	Project_Global_Chrome_Upstream_Group@mediatek.com,
	sirius.wang@mediatek.com, vince-wl.liu@mediatek.com,
	jh.hsu@mediatek.com
Subject: Re: [PATCH v2 4/4] pmdomain: mediatek: Add power domain driver for
 MT8189 SoC
Message-ID: <20250913091604.GK224143@horms.kernel.org>
References: <20250912120508.3180067-1-irving-ch.lin@mediatek.com>
 <20250912120508.3180067-5-irving-ch.lin@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912120508.3180067-5-irving-ch.lin@mediatek.com>

On Fri, Sep 12, 2025 at 08:04:53PM +0800, irving.ch.lin wrote:
> From: Irving-ch Lin <irving-ch.lin@mediatek.com>
> 
> Introduce a new power domain (pmd) driver for the MediaTek mt8189 SoC.
> This driver ports and refines the power domain framework, dividing
> hardware blocks (CPU, GPU, peripherals, etc.) into independent power
> domains for precise and energy-efficient power management.
> 
> Signed-off-by: Irving-ch Lin <irving-ch.lin@mediatek.com>

...

> diff --git a/drivers/pmdomain/mediatek/mtk-scpsys.c b/drivers/pmdomain/mediatek/mtk-scpsys.c

...

> @@ -419,54 +848,145 @@ static void init_clks(struct platform_device *pdev, struct clk **clk)
>  		clk[i] = devm_clk_get(&pdev->dev, clk_names[i]);
>  }
>  
> +static int init_subsys_clks(struct platform_device *pdev,
> +			    const char *prefix, struct clk **clk)
> +{
> +	struct device_node *node = pdev->dev.of_node;
> +	u32 prefix_len, sub_clk_cnt = 0;
> +	struct property *prop;
> +	const char *clk_name;
> +
> +	if (!node) {
> +		dev_err(&pdev->dev, "Cannot find scpsys node: %ld\n",
> +			PTR_ERR(node));
> +		return PTR_ERR(node);

Hi Irving-ch,

Here node is NULL. So PTR_ERR(node) will be zero.
This is probably not what you are after here.

Flagged by Smatch

> +	}
> +
> +	prefix_len = strlen(prefix);
> +
> +	of_property_for_each_string(node, "clock-names", prop, clk_name) {
> +		if (!strncmp(clk_name, prefix, prefix_len) &&
> +		    (strlen(clk_name) > prefix_len + 1) &&
> +		    (clk_name[prefix_len] == '-')) {
> +			if (sub_clk_cnt >= MAX_SUBSYS_CLKS) {
> +				dev_err(&pdev->dev,
> +					"subsys clk out of range %d\n",
> +					sub_clk_cnt);
> +				return -EINVAL;
> +			}
> +
> +			clk[sub_clk_cnt] = devm_clk_get(&pdev->dev, clk_name);
> +
> +			if (IS_ERR(clk[sub_clk_cnt])) {
> +				dev_err(&pdev->dev,
> +					"Subsys clk get fail %ld\n",
> +					PTR_ERR(clk[sub_clk_cnt]));
> +				return PTR_ERR(clk[sub_clk_cnt]);
> +			}
> +			sub_clk_cnt++;
> +		}
> +	}
> +
> +	return sub_clk_cnt;
> +}

...

