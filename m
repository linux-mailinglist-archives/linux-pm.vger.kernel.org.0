Return-Path: <linux-pm+bounces-38190-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B1E2C6B653
	for <lists+linux-pm@lfdr.de>; Tue, 18 Nov 2025 20:20:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 2ACC72BBF1
	for <lists+linux-pm@lfdr.de>; Tue, 18 Nov 2025 19:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB71E3730CE;
	Tue, 18 Nov 2025 19:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HQWGqloG"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E34336CE07;
	Tue, 18 Nov 2025 19:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763493021; cv=none; b=osF4+UvCRKtQt+arv2UrzvkfJMLwYmItmTL1/emcNeWoC4KITJxm1zosp8ljv7UKbL1p1khq9o6YBq/bFFJAijwXaUGNkMyMKEjXkBg6Gf58+fzfp1V4sK++v2lVMMP0WtcF+5SzHkQKUjhRCbAsK26/7hm8XOfhq5xim1PC208=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763493021; c=relaxed/simple;
	bh=iZNCfF3x67tayJ0Bqd19QsHC0wYasNnJz55BLRMRinM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IBTV5BiSlUsFPmwHUhcF+7k+7Vi+klP8o0G/U+qR2GPNTjsUirPYpajPl1sDpM+Jf9uOWQYBMOhXAaqIgY3bOYxvi6HcfZ9Ye1Bdmkye399hmYJg6rwBNphlWDw57PwSSw/jrv6a3xrBDb3qc02jiZNt2rzWH7TPr1XXHjYcXNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HQWGqloG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E2A4C19421;
	Tue, 18 Nov 2025 19:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763493020;
	bh=iZNCfF3x67tayJ0Bqd19QsHC0wYasNnJz55BLRMRinM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HQWGqloGD8o84B6FFrIKYg91b9WlfSDFgYRmLzlUi1dOdg1VqE6w0j0POAYGN0NCe
	 XXBoBezv9Z1YqYa5IWXyzOpZI6rXJ+GARxSmMlYI93qd02GygEht+UrjdxDdlSB19y
	 A6LaDKYNtuBi9fzvFxuN/M9+kof4zZCbTk7YB1eJKr50s7JFx9F6AxSsksMNFbNjio
	 IVeLFMppBkr07aqud8EgoHrQM2F/v21zComu3gUmm1qhAdImjKGnbSIQbVEMBC7VaB
	 J0Rh2ycmlYe8vQLLA1Whb55d/FtUVU40VWiiKnympshV8lofKQqVyXKY6lgrRoqDRE
	 NqRFZdcbyLlYw==
Date: Tue, 18 Nov 2025 13:10:18 -0600
From: Rob Herring <robh@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Ilia Lin <ilia.lin@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v4 1/1] cpufreq: qcom-nvmem: add compatible fallback for
 ipq806x for no SMEM
Message-ID: <20251118191018.GA3997357-robh@kernel.org>
References: <20251105112136.371376-1-ansuelsmth@gmail.com>
 <20251105112136.371376-2-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105112136.371376-2-ansuelsmth@gmail.com>

On Wed, Nov 05, 2025 at 12:21:34PM +0100, Christian Marangi wrote:
> On some IPQ806x SoC SMEM might be not initialized by SBL. This is the
> case for some Google devices (the OnHub family) that can't make use of
> SMEM to detect the SoC ID (and socinfo can't be used either as it does
> depends on SMEM presence).
> 
> To handle these specific case, check if the SMEM is not initialized (by
> checking if the qcom_smem_get_soc_id returns -ENODEV) and fallback to
> OF machine compatible checking to identify the SoC variant.
> 
> Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  drivers/cpufreq/qcom-cpufreq-nvmem.c | 35 ++++++++++++++++++++++++++--
>  1 file changed, 33 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> index 3a8ed723a23e..be44a8965e3a 100644
> --- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
> +++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> @@ -252,13 +252,22 @@ static int qcom_cpufreq_krait_name_version(struct device *cpu_dev,
>  	return ret;
>  }
>  
> +static const struct of_device_id qcom_cpufreq_ipq806x_match_list[] = {
> +	{ .compatible = "qcom,ipq8062", .data = (const void *)QCOM_ID_IPQ8062 },
> +	{ .compatible = "qcom,ipq8064", .data = (const void *)QCOM_ID_IPQ8064 },
> +	{ .compatible = "qcom,ipq8065", .data = (const void *)QCOM_ID_IPQ8065 },
> +	{ .compatible = "qcom,ipq8066", .data = (const void *)QCOM_ID_IPQ8066 },
> +	{ .compatible = "qcom,ipq8068", .data = (const void *)QCOM_ID_IPQ8068 },
> +	{ .compatible = "qcom,ipq8069", .data = (const void *)QCOM_ID_IPQ8069 },

These are all undocumented:

qcom,ipq8062
qcom,ipq8066
qcom,ipq8068
qcom,ipq8069

Rob

