Return-Path: <linux-pm+bounces-10629-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC7E927C72
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jul 2024 19:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B1821F218E9
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jul 2024 17:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B262F4085D;
	Thu,  4 Jul 2024 17:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fp04a8kh"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7974B3D3AC;
	Thu,  4 Jul 2024 17:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720115063; cv=none; b=aRHDFzh1P/2KX+bIg23wD6BIXIBbkDew1sPwfut7sE1OxmzwSj/sUjrQSwqI+xqwi8++FGKyXuzPSYij0hcoor0C+AXSYqQW5VU/Hg8ZnNB4CLhNFgtvXky6nNbpwOoL/rDOCESt645bqt/cufwHje404QsWhN8+bsmvmQ6Ma4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720115063; c=relaxed/simple;
	bh=AzVLN5s8m2pR07hkp4MUmLEh08g3IkzD0iu13g2nOIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PSNiSSX6ElzmmmbEtuEh2A2SvsAZpl5FPRsOEa3HmFF2Jygl0j8lDEMRGD0kDsOl5yOw1mKjsRJQWpnDiuTm7HYE/Q7/Pz3IrCPg8hdVPxZ4C7/DNtnNHHKWOheLT8pNGn70F8zGIhhBc/08mvNMO7Yuyh8/VKmna+ZEnSTrV4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fp04a8kh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBF0BC3277B;
	Thu,  4 Jul 2024 17:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720115063;
	bh=AzVLN5s8m2pR07hkp4MUmLEh08g3IkzD0iu13g2nOIo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fp04a8khZ0ndBddqA0DLvSs631FmVud72skRkUs8zP/6w+757aMn5psgiVA14HIre
	 fchF+ee7Y9F5LJSElxVE7mlRVdCTCYIglkzqTD4N2oZUGbOlsbPxsY77cnZcyXKZNA
	 3MDlgXwMHkX9637NcxJVWNnRNIdqkPabyo27JHud/gNUYn3GfNqZk0GvP8JkKlMOhX
	 nK2tm6xpN73P9O+DbdyV+7PQGJ9IDkaMNFCHqeMDGkiUqqNZAP05AI2roPkHBUjWUE
	 sY69eyvc9+Yret1FjSWXFO/O6vMG0Xz2ofudBVZowajTVWwtXMQ7jEcJnrNe9n74hN
	 osSCiwLuT6bVQ==
Date: Thu, 4 Jul 2024 12:44:19 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Odelu Kukatla <quic_okukatla@quicinc.com>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Kees Cook <keescook@chromium.org>, cros-qcom-dts-watchers@chromium.org, 
	"Gustavo A . R . Silva" <gustavoars@kernel.org>, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	quic_rlaggysh@quicinc.com, quic_mdtipton@quicinc.com
Subject: Re: [PATCH] interconnect: qcom: Fix DT backwards compatibility for
 QoS
Message-ID: <jhfya4mjnckrmogtmusyvwjv4mlyycgqj3apt2kaj5umxprhtv@rfew7c5w3zf5>
References: <20240704125515.22194-1-quic_okukatla@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240704125515.22194-1-quic_okukatla@quicinc.com>

On Thu, Jul 04, 2024 at 06:25:15PM GMT, Odelu Kukatla wrote:
> Add qos_clks_required flag to skip QoS configuration if clocks property
> is not populated in devicetree for providers which require clocks to be
> enabled for accessing registers. This is to keep the QoS configuration
> backwards compatible with devices that have older DTB.
> 

Please read "Describe your changes" [1], and make your commit message
start with the problem description - establish to the reader why this
change is needed, then follow that with a technical description of the
solution (likely in a separate paragraph).

[1] https://docs.kernel.org/process/submitting-patches.html#describe-your-changes

> Reported-by: Bjorn Andersson <andersson@kernel.org>
> Closes: https://lore.kernel.org/all/ciji6nlxn752ina4tmh6kwvek52nxpnguomqek6plwvwgvoqef@yrtexkpmn5br/
> Signed-off-by: Odelu Kukatla <quic_okukatla@quicinc.com>
> ---
>  drivers/interconnect/qcom/icc-rpmh.c | 2 +-
>  drivers/interconnect/qcom/icc-rpmh.h | 1 +
>  drivers/interconnect/qcom/sc7280.c   | 2 ++
>  3 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/interconnect/qcom/icc-rpmh.c b/drivers/interconnect/qcom/icc-rpmh.c
> index 93047defd5e2..f49a8e0cb03c 100644
> --- a/drivers/interconnect/qcom/icc-rpmh.c
> +++ b/drivers/interconnect/qcom/icc-rpmh.c
> @@ -311,7 +311,7 @@ int qcom_icc_rpmh_probe(struct platform_device *pdev)
>  		}
>  
>  		qp->num_clks = devm_clk_bulk_get_all(qp->dev, &qp->clks);
> -		if (qp->num_clks < 0) {
> +		if (qp->num_clks < 0 || (!qp->num_clks && desc->qos_clks_required)) {

For this new case, I think the dev_info() below makes total sense. I.e.
this looks good to me.


However, the num_clks < 0 case would represent finding a devicetree node
with clocks specified, but failing to get these clocks. I believe that
this would include EPROBE_DEFER.

I don't think it's correct to print a informational message and continue
without QoS. I think we should fail here.

Also, in this case devm_clk_bulk_get_all() would have pr_err() a message
about which clock it failed to acquire and why, so printing again here
doesn't seem useful.

But I think that is a separate follow up patch.

>  			dev_info(dev, "Skipping QoS, failed to get clk: %d\n", qp->num_clks);
>  			goto skip_qos_config;
>  		}
> diff --git a/drivers/interconnect/qcom/icc-rpmh.h b/drivers/interconnect/qcom/icc-rpmh.h
> index 9a5142c70486..14db89850fb3 100644
> --- a/drivers/interconnect/qcom/icc-rpmh.h
> +++ b/drivers/interconnect/qcom/icc-rpmh.h
> @@ -153,6 +153,7 @@ struct qcom_icc_desc {
>  	size_t num_nodes;
>  	struct qcom_icc_bcm * const *bcms;
>  	size_t num_bcms;
> +	bool qos_clks_required;
>  };
>  
>  int qcom_icc_aggregate(struct icc_node *node, u32 tag, u32 avg_bw,
> diff --git a/drivers/interconnect/qcom/sc7280.c b/drivers/interconnect/qcom/sc7280.c
> index 759c609a20bf..167971f8e8be 100644
> --- a/drivers/interconnect/qcom/sc7280.c
> +++ b/drivers/interconnect/qcom/sc7280.c
> @@ -1691,6 +1691,7 @@ static const struct qcom_icc_desc sc7280_aggre1_noc = {
>  	.num_nodes = ARRAY_SIZE(aggre1_noc_nodes),
>  	.bcms = aggre1_noc_bcms,
>  	.num_bcms = ARRAY_SIZE(aggre1_noc_bcms),
> +	.qos_clks_required = true,
>  };
>  
>  static struct qcom_icc_bcm * const aggre2_noc_bcms[] = {
> @@ -1722,6 +1723,7 @@ static const struct qcom_icc_desc sc7280_aggre2_noc = {
>  	.num_nodes = ARRAY_SIZE(aggre2_noc_nodes),
>  	.bcms = aggre2_noc_bcms,
>  	.num_bcms = ARRAY_SIZE(aggre2_noc_bcms),
> +	.qos_clks_required = true,

When reading the commit message and the name of this property, my first
reaction was "aggre2_noc requires qos clocks".

As such, I'd prefer if this was renamed "qos_requires_clocks" to more
clearly document what the requirement entails and hint the future reader
that the interconnect might still be operational.


With that said, thanks for your quick reply to my regression report!

Tested-by: Bjorn Andersson <andersson@kernel.org>

Regards,
Bjorn

>  };
>  
>  static struct qcom_icc_bcm * const clk_virt_bcms[] = {
> -- 
> 2.17.1
> 

