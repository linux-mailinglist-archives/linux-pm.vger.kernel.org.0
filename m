Return-Path: <linux-pm+bounces-18561-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B67FC9E42AF
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2024 18:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91388169ED9
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2024 17:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E39321772E;
	Wed,  4 Dec 2024 17:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SDmOYKHF"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D5D2144D4;
	Wed,  4 Dec 2024 17:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733333609; cv=none; b=bBdlM0XST1mi6raEvqOjIPzBIBUcBBd/F75rQCaLRrx8SCeP/uZTb4nRjSf0r2dygCSSUlT3svI0ZYJpmAMEwHobMH8eJIsZICIgXs7DbJH/rk6kO9CpITKuX9aKr794HtPkd1J4jsFnBvVhG61GE+xe1C7pszGoinpUPWWCe7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733333609; c=relaxed/simple;
	bh=NeyHoaU/Rj3PCru8adh/ZU0wsQKT1PHDSO0yhR+AOWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ML2dt78119RlIkleb2/eNAztr+7KP9f6sfY2mk7pxyoB3RDfhyvrCHRgk5nqd1QPHNkNFu3Vzg5bmD381yza8v1ZZVQznxI/Pg38S1Lo+k1WxqtwBx0RIF5WcuV7K3kTdSocZPo8Owxckm/l+PMLz7EXedc6L59oANWKOwb6qK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SDmOYKHF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD369C4CECD;
	Wed,  4 Dec 2024 17:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733333606;
	bh=NeyHoaU/Rj3PCru8adh/ZU0wsQKT1PHDSO0yhR+AOWU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SDmOYKHFX9hocNkWlSnZ4KKL+Cue7FN24N6jiC66l5t8HF4kIWAqSPQAK+PLXfUy0
	 SGL3BRJvbqgkZXwHW/rrnL6cE35SMfwPQmJ6cwto4MQWjTJrtECWsoBoZ5h5meYODZ
	 bIaE6ABwWTff05wqpsT4FJafuLoYNhJaCuNrtQg/XdPdGiw6Ciie4JvCJF3Ngw/9dg
	 fAGZLGDbb+neR2VMqAotEWQNBsiAEBRXT2AtpTDNYsE8yKiWphiM9Pn+6JuJBw8mcj
	 Ngm1OBXvkJIfwpCFWBCDVfH/K02KsFvNWrhBPzkENp3gZaH0R0PA+CXWORUbnu9LTE
	 xVrxIoIOKOZGA==
Date: Wed, 4 Dec 2024 10:33:24 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: djakov@kernel.org
Cc: naresh.kamboju@linaro.org, lkft@linaro.org, kees@kernel.org,
	konradybcio@kernel.org, quic_okukatla@quicinc.com,
	quic_rlaggysh@quicinc.com, linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] interconnect: qcom: icc-rpm: Set the count member before
 accessing the flex array
Message-ID: <20241204173324.GA915644@thelio-3990X>
References: <20241203223334.233404-1-djakov@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203223334.233404-1-djakov@kernel.org>

On Wed, Dec 04, 2024 at 12:33:34AM +0200, djakov@kernel.org wrote:
> From: Georgi Djakov <djakov@kernel.org>
> 
> The following UBSAN error is reported during boot on the db410c board on
> a clang-19 build:
> 
> Internal error: UBSAN: array index out of bounds: 00000000f2005512 [#1] PREEMPT SMP
> ...
> pc : qnoc_probe+0x5f8/0x5fc
> ...

Really happy to see more coverage of real hardware with compilers that
support __counted_by() so that we can start getting these addressed,
thanks for this!

> The cause of the error is that the counter member was not set before
> accessing the annotated flexible array member, but after that. Fix this
> by initializing it earlier.
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Closes: https://lore.kernel.org/r/CA+G9fYs+2mBz1y2dAzxkj9-oiBJ2Acm1Sf1h2YQ3VmBqj_VX2g@mail.gmail.com
> Fixes: dd4904f3b924 ("interconnect: qcom: Annotate struct icc_onecell_data with __counted_by")

Guess Kees missed one :)

> Signed-off-by: Georgi Djakov <djakov@kernel.org>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

This is exactly the thing that __builtin_counted_by_ref() is trying to
address, as these assignments happen right after the allocation:

https://gcc.gnu.org/onlinedocs/gcc/Other-Builtins.html#index-_005f_005fbuiltin_005fcounted_005fby_005fref

> ---
>  drivers/interconnect/qcom/icc-rpm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
> index a8ed435f696c..ea1042d38128 100644
> --- a/drivers/interconnect/qcom/icc-rpm.c
> +++ b/drivers/interconnect/qcom/icc-rpm.c
> @@ -503,6 +503,7 @@ int qnoc_probe(struct platform_device *pdev)
>  			    GFP_KERNEL);
>  	if (!data)
>  		return -ENOMEM;
> +	data->num_nodes = num_nodes;
>  
>  	qp->num_intf_clks = cd_num;
>  	for (i = 0; i < cd_num; i++)
> @@ -597,7 +598,6 @@ int qnoc_probe(struct platform_device *pdev)
>  
>  		data->nodes[i] = node;
>  	}
> -	data->num_nodes = num_nodes;
>  
>  	clk_bulk_disable_unprepare(qp->num_intf_clks, qp->intf_clks);
>  

