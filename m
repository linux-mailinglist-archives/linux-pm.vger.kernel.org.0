Return-Path: <linux-pm+bounces-12451-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C2D6957003
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2024 18:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF3F4B29C71
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2024 16:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18843173347;
	Mon, 19 Aug 2024 16:11:12 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A4316C874;
	Mon, 19 Aug 2024 16:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724083872; cv=none; b=OW2HggFd56decl0Y8iMoSDRrd05nWJi7uapvCWG5ygUHiAHl2tsR5N/Y3u9wph1K3DTiqFr06aNC5Eivx0zttxSklaG/EnlN7WChdy5oGu1j1Z0IcWYd8+37cJ8wuOCfNwsFmGJ/l1kqeWZ9ESjBenvrH063mNsL/20nu2D/xWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724083872; c=relaxed/simple;
	bh=lsD3l0zy9n7q31pbaGfU5guogshI72B6C37og0kv7yY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=th30HNB3KB6fPOfOyfCsLnGvoeBSDsWMOddpPciHSLXEMzghSN/rf46P5lg6w0Wl0GgnX1t5oLJWT/qP5UNmyhH5gRsRlmo0xF13iM3uqq6aMrUmpsJ3xuJL9h9SKR4Es3fy3qaptVAirMa9q5bAXjMvRLOFPR36pvclt6mKIVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WncvR3GBnz67MmR;
	Tue, 20 Aug 2024 00:08:03 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 9E4F51400DB;
	Tue, 20 Aug 2024 00:11:06 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 19 Aug
 2024 17:11:06 +0100
Date: Mon, 19 Aug 2024 17:11:04 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC: Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Anup Patel
	<anup@brainfault.org>, Paul Walmsley <paul.walmsley@sifive.com>, "Palmer
 Dabbelt" <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
	<linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH 1/4] cpuidle: psci: Simplify with scoped for each OF
 child loop
Message-ID: <20240819171104.0000625c@Huawei.com>
In-Reply-To: <20240816150931.142208-1-krzysztof.kozlowski@linaro.org>
References: <20240816150931.142208-1-krzysztof.kozlowski@linaro.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 16 Aug 2024 17:09:28 +0200
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> Use scoped for_each_child_of_node_scoped() when iterating over device
> nodes to make code a bit simpler.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Looks fine,
FWIW
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

If you are bored, the pr_err() at end of here seems like it should be

return dev_err_probe(pdev->dev, ret, "failed to create CPU PM domains\n");

But that's obviously completely unrelated!


> ---
>  drivers/cpuidle/cpuidle-psci-domain.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/cpuidle/cpuidle-psci-domain.c b/drivers/cpuidle/cpuidle-psci-domain.c
> index ea28b73ef3fb..146f97068022 100644
> --- a/drivers/cpuidle/cpuidle-psci-domain.c
> +++ b/drivers/cpuidle/cpuidle-psci-domain.c
> @@ -142,7 +142,6 @@ static const struct of_device_id psci_of_match[] = {
>  static int psci_cpuidle_domain_probe(struct platform_device *pdev)
>  {
>  	struct device_node *np = pdev->dev.of_node;
> -	struct device_node *node;
>  	bool use_osi = psci_has_osi_support();
>  	int ret = 0, pd_count = 0;
>  
> @@ -153,15 +152,13 @@ static int psci_cpuidle_domain_probe(struct platform_device *pdev)
>  	 * Parse child nodes for the "#power-domain-cells" property and
>  	 * initialize a genpd/genpd-of-provider pair when it's found.
>  	 */
> -	for_each_child_of_node(np, node) {
> +	for_each_child_of_node_scoped(np, node) {
>  		if (!of_property_present(node, "#power-domain-cells"))
>  			continue;
>  
>  		ret = psci_pd_init(node, use_osi);
> -		if (ret) {
> -			of_node_put(node);
> +		if (ret)
>  			goto exit;
> -		}
>  
>  		pd_count++;
>  	}


