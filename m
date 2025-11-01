Return-Path: <linux-pm+bounces-37243-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 619FBC283EC
	for <lists+linux-pm@lfdr.de>; Sat, 01 Nov 2025 18:39:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0BCC24E05A7
	for <lists+linux-pm@lfdr.de>; Sat,  1 Nov 2025 17:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06F7E2F9DBD;
	Sat,  1 Nov 2025 17:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qv8XHu5u"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5D2287518;
	Sat,  1 Nov 2025 17:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762018777; cv=none; b=H443N+mjADb65CiVoz90aNTgPHBngOqIaC5akQHUEFwksrvhrzz5xP3SY+qkK5pdZw6RZLhSygsNhud+qfiYjXWFACNX5/WSofk8c9w2tcgghOMK+5aRbnZKfwzp123dz9Cu8RD2HwNGqzlMqsjFmAXJ/BtbFEoAlFMyXhrgZzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762018777; c=relaxed/simple;
	bh=jaSI9PNTjac7hlUazQQKeti2y4UuuMm8Ia+3VWtswo0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=biLCm815CGDFjY4pLlCOSd4uSfd/c2IOwRISYByrvMn40EhkaJMmSMvQ9f/QckYPIOePyY47qgRtrNv+gUPOdouNFQ2ZY9PlPu4C8ALni+XtFO8X9amooS1U9WsfmQ4J+gR+o1PvBLyJ4weG9dmuWoH/Ssy8SIsUXPfo/IlDNFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qv8XHu5u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3A47C4CEF1;
	Sat,  1 Nov 2025 17:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762018777;
	bh=jaSI9PNTjac7hlUazQQKeti2y4UuuMm8Ia+3VWtswo0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qv8XHu5uIpfwy46IgaXSKzFT1mtky30cDG1MtBpOcXdvGpJqmXf1iWAlPWUwep1yq
	 /g8W52E7CKC4M91nNDXNN4VxbNwlJwLPiozuRDqHUBXxapzzTvqWJZABdkg1+629Fl
	 Gdal3ohlx15frNALNhqNm2G47zjIqjX/sr1pH+B1AgRpytSt3aZYWlwY6AIWT5kQR2
	 fFyWivhik+oti8F8QiUpqe2ucAs4L/UOpF7MXAEfqG6PjJACDJUz/t9V9R/hGyTuVB
	 a9hH9dT4ZHQ2WyQKOlbnH+4jPLOIlzLqJdCWKUa+DvbTplBDkrsfOcTlHxJSyP6zSn
	 uNCLgVNmWxaiQ==
Date: Sat, 1 Nov 2025 12:42:55 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Ilia Lin <ilia.lin@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Raag Jadav <raag.jadav@intel.com>, linux-arm-msm@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] cpufreq: qcom-nvmem: add compatible fallback for
 ipq806x for no SMEM
Message-ID: <qael7opoqary2n5iqefxxp42v3qoudfhfvcgjyxfe3t7353zge@ahgvniscxl7v>
References: <20251031130835.7953-1-ansuelsmth@gmail.com>
 <20251031130835.7953-4-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251031130835.7953-4-ansuelsmth@gmail.com>

On Fri, Oct 31, 2025 at 02:08:34PM +0100, Christian Marangi wrote:
> On some IPQ806x SoC SMEM might be not initialized by SBL. This is the
> case for some Google devices (the OnHub family) that can't make use of
> SMEM to detect the SoC ID.
> 
> To handle these specific case, check if the SMEM is not initialized (by
> checking if the qcom_smem_get_soc_id returns -ENODEV) and fallback to
> OF machine compatible checking to identify the SoC variant.
> 
> Notice that the checking order is important as the machine compatible
> are normally defined with the specific one following the generic SoC
> (for example compatible = "qcom,ipq8065", "qcom,ipq8064").
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Reviewed-by: Bjorn Andersson <andersson@kernel.org>

And as mentioned in v1, this (cpufreq) patch can be merged independently
of the first two patches. So please merge it through the cpufreq tree.

Regards,
Bjorn

> ---
>  drivers/cpufreq/qcom-cpufreq-nvmem.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> index 3a8ed723a23e..5a9bd780a4f3 100644
> --- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
> +++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> @@ -257,8 +257,8 @@ static int qcom_cpufreq_ipq8064_name_version(struct device *cpu_dev,
>  					     char **pvs_name,
>  					     struct qcom_cpufreq_drv *drv)
>  {
> +	int msm_id = -1, ret = 0;
>  	int speed = 0, pvs = 0;
> -	int msm_id, ret = 0;
>  	u8 *speedbin;
>  	size_t len;
>  
> @@ -275,8 +275,21 @@ static int qcom_cpufreq_ipq8064_name_version(struct device *cpu_dev,
>  	get_krait_bin_format_a(cpu_dev, &speed, &pvs, speedbin);
>  
>  	ret = qcom_smem_get_soc_id(&msm_id);
> -	if (ret)
> +	if (ret == -ENODEV) {
> +		/* Fallback to compatible match with no SMEM initialized */
> +		ret = 0;
> +		if (of_machine_is_compatible("qcom,ipq8062"))
> +			msm_id = QCOM_ID_IPQ8062;
> +		else if (of_machine_is_compatible("qcom,ipq8065") ||
> +			 of_machine_is_compatible("qcom,ipq8069"))
> +			msm_id = QCOM_ID_IPQ8065;
> +		else if (of_machine_is_compatible("qcom,ipq8064") ||
> +			 of_machine_is_compatible("qcom,ipq8066") ||
> +			 of_machine_is_compatible("qcom,ipq8068"))
> +			msm_id = QCOM_ID_IPQ8064;
> +	} else if (ret) {
>  		goto exit;
> +	}
>  
>  	switch (msm_id) {
>  	case QCOM_ID_IPQ8062:
> -- 
> 2.51.0
> 

