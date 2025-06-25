Return-Path: <linux-pm+bounces-29502-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 162E4AE82BA
	for <lists+linux-pm@lfdr.de>; Wed, 25 Jun 2025 14:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FDA81BC6BC8
	for <lists+linux-pm@lfdr.de>; Wed, 25 Jun 2025 12:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6AF125E453;
	Wed, 25 Jun 2025 12:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UQZLSs3Y"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A28025EF81;
	Wed, 25 Jun 2025 12:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750854617; cv=none; b=ggAQLcaTsXx7t1/91j9KEu5s9muJZGvb2cxxmQYeOTJQ3BWFDVM0HyUugYQLGsbC5/+aKPB4q38QvKE3y+3n7ZPdFjaCAnn+xfVmtdRVj/6mGuHvErS/AtuIaDTe6I3pZT+vS6zAulbztNBapkVnWgDN5w75FZSZKNO6zzyolGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750854617; c=relaxed/simple;
	bh=G+Qw3FSXBEqksBqrMWJSFOY+9AOJVtOJjW9/c+GWxFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tTVB2ogBDzmybeiL27P+t4c4FjOVMR8Zmz0tpuPfNrQ1NCY5lTlwjtx7QnHlmsor6YqA9+VxthFjHLAEBv/8XYmqF5srXDOQ5Z29wkFy5HdFcTQwXOv9X7IvCXaL0FpDL523rtTy/TPcXINA9UEQddeyFpP2xiZ2iWFa/mMTRnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UQZLSs3Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24056C4CEEA;
	Wed, 25 Jun 2025 12:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750854616;
	bh=G+Qw3FSXBEqksBqrMWJSFOY+9AOJVtOJjW9/c+GWxFY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UQZLSs3YKqsnXNkFEFUuqpwGbuv8vBaldqxqP+gcEGawZGVZamOfZi4xl9DirMxgv
	 /0ErvRqZ7uqDISqCFlPpBUoj99YnOp32G/DDfX0RUu1e/eRCu/YDit5EWBYXHrju/g
	 ITp5YOwmyYDwiaVA8hIGoLUiQZetIOl4rzO1F+E7A3DFg1hH15G6xAPDQIN8c/dqsw
	 rDj9yEWUKtRFq8RH9Bg+NcF5tVl0V3CyEYADpsfdFVy0x4QgpUe2otRfzRW49RRI1G
	 oSG7BmLFf4LEKJOvlwrlrQ8tbdFTvFL18psHhG55+vyUqGah1O/Fbb6RxKae6jxW1P
	 oXftg9IhBWi9w==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1uUPGZ-000000006ON-0a7i;
	Wed, 25 Jun 2025 14:30:15 +0200
Date: Wed, 25 Jun 2025 14:30:15 +0200
From: Johan Hovold <johan@kernel.org>
To: Gabor Juhos <j4g8y7@gmail.com>
Cc: Georgi Djakov <djakov@kernel.org>,
	Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>,
	Johan Hovold <johan+linaro@kernel.org>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] interconnect: avoid memory allocation when
 'icc_bw_lock' is held
Message-ID: <aFvr1zSkf4KmIcMT@hovoldconsulting.com>
References: <20250625-icc-bw-lockdep-v3-1-2b8f8b8987c4@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625-icc-bw-lockdep-v3-1-2b8f8b8987c4@gmail.com>

On Wed, Jun 25, 2025 at 01:25:04PM +0200, Gabor Juhos wrote:
> The 'icc_bw_lock' mutex is introduced in commit af42269c3523
> ("interconnect: Fix locking for runpm vs reclaim") in order
> to decouple serialization of bw aggregation from codepaths
> that require memory allocation.
> 
> However commit d30f83d278a9 ("interconnect: core: Add dynamic
> id allocation support") added a devm_kasprintf() call into a
> path protected by the 'icc_bw_lock' which causes this lockdep
> warning (at least on the IPQ9574 platform):

> The icc_node_add() functions is not designed to fail, and as such it
> should not do any memory allocation. In order to avoid this, move the
> name generation directly into the functions which are using the dynamic
> id feature.
> 
> The change in the icc core has been tested on the IPQ9574 platform,
> where it eliminates the lockdep splat indicated above. The changes in
> the 'icc-rpmh' and 'osm-l3' drivers are compile tested only due to lack
> of suitable hardware.
> 
> Fixes: d30f83d278a9 ("interconnect: core: Add dynamic id allocation support")
> Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
> ---
> Changes in v3:
>   - move memory allocation out from the icc_node_add() function directly into
>     the users of the dynamic id feature
>   - adjust commit description according to the changes
>   - Link to v2: https://lore.kernel.org/r/20250618-icc-bw-lockdep-v2-1-3223da346765@gmail.com

Thanks for the update. This looks correct to me, except possibly for an
existing issue in the rpmh driver (see below).

I've tested it on the sc8280xp-crd with the osm-l3 driver so with the
rpmh issue resolved, feel free to add:

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
Tested-by: Johan Hovold <johan+linaro@kernel.org>

> diff --git a/drivers/interconnect/qcom/icc-rpmh.c b/drivers/interconnect/qcom/icc-rpmh.c
> index 41bfc6e7ee1d53d34b919dd8afa97698bc69d79c..fa4ef78678eff10e83557035ba572010b51ff50c 100644
> --- a/drivers/interconnect/qcom/icc-rpmh.c
> +++ b/drivers/interconnect/qcom/icc-rpmh.c
> @@ -276,13 +276,17 @@ int qcom_icc_rpmh_probe(struct platform_device *pdev)
>  		qcom_icc_bcm_init(qp->bcms[i], dev);
>  
>  	for (i = 0; i < num_nodes; i++) {
> +		bool is_dyn_node = false;
> +
>  		qn = qnodes[i];
>  		if (!qn)
>  			continue;
>  
>  		if (desc->alloc_dyn_id) {
> -			if (!qn->node)
> +			if (!qn->node) {

AFAICS, qn->node will currently never be set here and I'm not sure why
commit 7f9560a3bebe ("interconnect: qcom: icc-rpmh: Add dynamic icc node
id support") added this check, or even the node field to struct
qcom_icc_desc for that matter.

But if there's some future use case for this, then you may or may not
need to make sure that a name is allocated also in that case.

And that could be done by simply checking if node->id >=
ICC_DYN_ID_START instead of using a boolean flag below. That may be
preferred either way.

What do you think?

>  				qn->node = icc_node_create_dyn();
> +				is_dyn_node = true;
> +			}
>  			node = qn->node;
>  		} else {
>  			node = icc_node_create(qn->id);
> @@ -293,7 +297,19 @@ int qcom_icc_rpmh_probe(struct platform_device *pdev)
>  			goto err_remove_nodes;
>  		}
>  
> -		node->name = qn->name;
> +		if (is_dyn_node) {
> +			node->name = devm_kasprintf(provider->dev, GFP_KERNEL,
> +						    "%s@%s", qn->name,
> +						    dev_name(provider->dev));
> +			if (!node->name) {
> +				icc_node_destroy(node->id);
> +				ret = -ENOMEM;
> +				goto err_remove_nodes;
> +			}
> +		} else {
> +			node->name = qn->name;
> +		}
> +
>  		node->data = qn;
>  		icc_node_add(node, provider);

Johan

