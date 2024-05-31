Return-Path: <linux-pm+bounces-8492-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D738D6C9E
	for <lists+linux-pm@lfdr.de>; Sat,  1 Jun 2024 00:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23FF3288B0A
	for <lists+linux-pm@lfdr.de>; Fri, 31 May 2024 22:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F36382490;
	Fri, 31 May 2024 22:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W2J+cUbZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64193207;
	Fri, 31 May 2024 22:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717195928; cv=none; b=Lf52oMzNvTqAdx2hqCBiwLrB8Led9kghcA2RATQop2iaLiCWKWoJOIbu0tuerPLIVcmoZ08VdSXK82ssuR5u83d1qhekSHCHmd0+pZsE34uirFma80mZUTAAeM8uOgBFcYKEoKFKBF9CiIALNF4sLAYDmAr8ykyN3vu61F1Ov2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717195928; c=relaxed/simple;
	bh=GBPyE45nrogn+zGrWB4VZvx6JNf2uRpYn1HKgzi4c/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=scHmt9brjuADklW1Seh9YzqaRJzxi6zekfZTCVNXdkIWjVF6e2FG9tWcn5FAH53r2zeIHmh8RwJdZKj3o29WpR1dD0pHm31etsccRva1t/zO4mIgc2WmIxQ2HnWScsdsOKgX5YXw3wvzodvxDZ5Tj1fbAt+wpW8mjXFiGgFRCUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W2J+cUbZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5112C116B1;
	Fri, 31 May 2024 22:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717195927;
	bh=GBPyE45nrogn+zGrWB4VZvx6JNf2uRpYn1HKgzi4c/g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W2J+cUbZIsYSalGWrDl6d2BjMNMrhWmwUj+BGYt8Hd5IxN0AKx8/aZYCMzBQC3AdW
	 o2bw656fonhCXD5IGM3M8SEtkhTJ2iEBf06wVVIhiXsSgXe1x/xjoPTbF3L4zjhxDk
	 XFkZYWfdi5eW3l93r9vFq9DvrWtWlBTBoZg1Iz/3HAMrfCxk3tll5YENIe7GutmbOp
	 y/KtkNO2PdRq3px3sbgf8kL9wNanCYR5JgG1D0O5xwTJsMBB2z4cbvVoGiElE+mJTN
	 H4YJP7NtUxKNacrHNX6aII4WVRjrkp34yyJCS4w6gjP/lRWejyV1QhY0xyDHPHFAqJ
	 MY+bM7iYu1s6Q==
Date: Fri, 31 May 2024 17:52:04 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Taniya Das <quic_tdas@quicinc.com>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Andy Gross <agross@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, quic_jkona@quicinc.com, 
	quic_imrashai@quicinc.com
Subject: Re: [PATCH] pmdomain: qcom: rpmhpd: Skip retention level for Power
 Domains
Message-ID: <4dap2yus4dvn6u25foq4dc3bpejxpgxqlhqqgxd3jpkcpewo6z@t3mt72ggwieu>
References: <20240531114148.8550-1-quic_tdas@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240531114148.8550-1-quic_tdas@quicinc.com>

On Fri, May 31, 2024 at 05:11:48PM GMT, Taniya Das wrote:
> In the cases where the power domain connected to logics is allowed to
> transition from a level(L)-->power collapse(0)-->retention(1) or
> vice versa retention(1)-->power collapse(0)-->level(L)  will cause the
> logic to lose the configurations. The ARC does not support retention
> to collapse transition on MxC rails.
> 
> The targets from SM8450 onwards the PLL logics of clock controllers are
> connected to MxC rails and the recommended configurations are carried
> out during the clock controller probes. The MxC transition as mentioned
> above should be skipped to ensure the PLL settings are intact across
> clock controller power on & off.
> 
> On older generation of targets which supports only Mx the logic is never
> collapsed and it is parked always at RETENTION, thus this issue is never
> observed on those targets.
> 

Cc: stable@vger.kernel.org # v5.17
Reviewed-by: Bjorn Andersson <andersson@kernel.org>

Regards,
Bjorn

> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
> ---
>  drivers/pmdomain/qcom/rpmhpd.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> ---
>  drivers/pmdomain/qcom/rpmhpd.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/pmdomain/qcom/rpmhpd.c b/drivers/pmdomain/qcom/rpmhpd.c
> index de9121ef4216..d2cb4271a1ca 100644
> --- a/drivers/pmdomain/qcom/rpmhpd.c
> +++ b/drivers/pmdomain/qcom/rpmhpd.c
> @@ -40,6 +40,7 @@
>   * @addr:		Resource address as looped up using resource name from
>   *			cmd-db
>   * @state_synced:	Indicator that sync_state has been invoked for the rpmhpd resource
> + * @skip_retention_level: Indicate that retention level should not be used for the power domain
>   */
>  struct rpmhpd {
>  	struct device	*dev;
> @@ -56,6 +57,7 @@ struct rpmhpd {
>  	const char	*res_name;
>  	u32		addr;
>  	bool		state_synced;
> +	bool            skip_retention_level;
>  };
>  
>  struct rpmhpd_desc {
> @@ -173,6 +175,7 @@ static struct rpmhpd mxc = {
>  	.pd = { .name = "mxc", },
>  	.peer = &mxc_ao,
>  	.res_name = "mxc.lvl",
> +	.skip_retention_level = true,
>  };
>  
>  static struct rpmhpd mxc_ao = {
> @@ -180,6 +183,7 @@ static struct rpmhpd mxc_ao = {
>  	.active_only = true,
>  	.peer = &mxc,
>  	.res_name = "mxc.lvl",
> +	.skip_retention_level = true,
>  };
>  
>  static struct rpmhpd nsp = {
> @@ -819,6 +823,9 @@ static int rpmhpd_update_level_mapping(struct rpmhpd *rpmhpd)
>  		return -EINVAL;
>  
>  	for (i = 0; i < rpmhpd->level_count; i++) {
> +		if (rpmhpd->skip_retention_level && buf[i] == RPMH_REGULATOR_LEVEL_RETENTION)
> +			continue;
> +
>  		rpmhpd->level[i] = buf[i];
>  
>  		/* Remember the first corner with non-zero level */
> -- 
> 2.17.1
> 

