Return-Path: <linux-pm+bounces-17628-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B969CE5FE
	for <lists+linux-pm@lfdr.de>; Fri, 15 Nov 2024 15:58:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65A93B285F3
	for <lists+linux-pm@lfdr.de>; Fri, 15 Nov 2024 14:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B6BE1D416B;
	Fri, 15 Nov 2024 14:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TugT5qs/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20BB1CFEDB
	for <linux-pm@vger.kernel.org>; Fri, 15 Nov 2024 14:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731681262; cv=none; b=EDA52l0bDbYRxqjelKYhnR6NHiCX1tMmf28VJNlZ1IRpDfCzcqURafSlIRj4IoUlw/5y5PsgRt8N/HEMuMhoANUNUpXX0XgAPGbGLVK/qfDed5fjjMDlRp7yfQhWSVWkhCZNWJ9m5rTAks0yj1e1paXzWrX2Eng9Wi5yVWCmRbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731681262; c=relaxed/simple;
	bh=prAZ9gsnRM0zsVQaQrXujtr2yhmvOZm3gPPJ44CMzk0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m5VKRI75N5/yN1HMtIQ8zkkCv6st5g4RyTjJEALxanAJs4GUtf3Sbf4rldjaBYUuf1LSty3MAWmpP3cUGgDxI73jDhgx5MrJaATwLU/D51laEDLZvdytsPdnn3TjdCc9nLEv+0Kt7a+KLG7stmYdXi9zTaFCuLD9OUG68/i3cYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TugT5qs/; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-539f6e1f756so1883229e87.0
        for <linux-pm@vger.kernel.org>; Fri, 15 Nov 2024 06:34:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731681257; x=1732286057; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W4RZ74q0neI7Vkz4Jr5WGrbm+vl0Y0XUqqa25XmXEiU=;
        b=TugT5qs/RfzQD0quLcT8IzvV4N585D/QLZsvWKyrCXQtUZMgFcaOGgzudCQ5vcDXUl
         bW+NM8GUuQSG++GYLRE32ytJIoJTymfEvTbZc6pq09ClqJqXv0sySCF8p1WVoYWzjH0i
         ILHSEAKMvawVLLuCECfJ2TYjhT6a/8eVnUrcGc3LZXVHujKxiNm5CjY+Oi9n5uVCLlyh
         TDSO1sC2OVe2zq1EZN1Ajqrz3DP8OcDB1klg7a0glJbr5brOiZtx3WWEvS+86FBh0bhG
         5zWPpALgKd8WFz/qR4M5sVM7wARpNOe9qR8aml2YKpszvU28CToCB+D0p6osHEx6QVZk
         fT9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731681257; x=1732286057;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W4RZ74q0neI7Vkz4Jr5WGrbm+vl0Y0XUqqa25XmXEiU=;
        b=opK99wNZMmCVFwn/5ptsLfKFsKXyq0T8EPsVuEb08H0BZCXtLNalmNoVJI6xI4H0mE
         y7c6PtFEqw0dlKK+gT9TGPxK9zJ/kE32mfkvxF/llyfuNm2jiw2wOVMYZzJ87F0n9QsG
         YgOmRtCclZxGSQ7Gyr5k0iC6+66G3GYFaIr4nWYHyYiwveSuRhRG5Z7PvoQoVkqJq3gz
         qYHuuSIspWo7mXjoSP+n7BagXYFWK6Qs5retuFVX3BPWXm0KcUVGWqS0jJl5DdAII4v+
         Qp11DqV66aZ9juGNOcBbHbeo1jdMy+o+9t4ZsSje7RmSrIVi7ToVy1Wc/klV2pmiooSj
         u19Q==
X-Forwarded-Encrypted: i=1; AJvYcCWQZYH9TUGF+FeWh6Y4/QyJNVWdHMDNjxVxEIpR0vXeXTwgz4l8NzorTol6Wx4cQZX107ztT42AFw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyUtOxUHGezBsZ36L7vSdoX2FWestTBGicindlVt0lZ4rgkKLYb
	ZewHgD3J0JAjrYmb6KJrCRkgYtZXgnc5LM0xGVM5a1Nz5afnN+uogYV021eG9q8=
X-Google-Smtp-Source: AGHT+IEbVST8IM23PNJS7uUCJYisSMIz1nwNUdSbgRhx3Ri6cOC5P3WcVxp2LruftCueQAiIwrth7A==
X-Received: by 2002:a05:6512:2823:b0:539:fb49:c47a with SMTP id 2adb3069b0e04-53dab290683mr1441951e87.4.1731681256980;
        Fri, 15 Nov 2024 06:34:16 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53da6548ae5sm581242e87.265.2024.11.15.06.34.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 06:34:15 -0800 (PST)
Date: Fri, 15 Nov 2024 16:34:13 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Akhil P Oommen <quic_akhilpo@quicinc.com>, 
	Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
	Konrad Dybcio <konradybcio@kernel.org>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Bjorn Andersson <andersson@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Connor Abbott <cwabbott0@gmail.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
Subject: Re: [PATCH RFC 3/8] drm/msm: adreno: add plumbing to generate
 bandwidth vote table for GMU
Message-ID: <mfft7llbxbmm73hmkamsjhj4eymmr6wx2diigzjh7cyuvt4bor@yh5smvxwt73x>
References: <20241113-topic-sm8x50-gpu-bw-vote-v1-0-3b8d39737a9b@linaro.org>
 <20241113-topic-sm8x50-gpu-bw-vote-v1-3-3b8d39737a9b@linaro.org>
 <p4x7rodp2qpwfb3hljtbi36mxjdrt5jr3xhad4rebsldlfxart@cz23of57gvrd>
 <dffb787f-7167-4027-a58d-34bba5f838ab@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dffb787f-7167-4027-a58d-34bba5f838ab@linaro.org>

On Fri, Nov 15, 2024 at 10:09:44AM +0100, Neil Armstrong wrote:
> On 15/11/2024 08:20, Dmitry Baryshkov wrote:
> > On Wed, Nov 13, 2024 at 04:48:29PM +0100, Neil Armstrong wrote:
> > > The Adreno GMU Management Unit (GMU) can also scale DDR Bandwidth along
> > > the Frequency and Power Domain level, but by default we leave the
> > > OPP core scale the interconnect ddr path.
> > > 
> > > In order to get the vote values to be used by the GPU Management
> > > Unit (GMU), we need to parse all the possible OPP Bandwidths and
> > > create a vote value to be send to the appropriate Bus Control
> > > Modules (BCMs) declared in the GPU info struct.
> > > 
> > > The vote array will be used to dynamically generate the GMU bw_table
> > > sent during the GMU power-up.
> > > 
> > > Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> > > ---
> > >   drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 163 ++++++++++++++++++++++++++++++++++
> > >   drivers/gpu/drm/msm/adreno/a6xx_gmu.h |  12 +++
> > >   drivers/gpu/drm/msm/adreno/a6xx_gpu.h |   1 +
> > >   3 files changed, 176 insertions(+)
> > > 
> > > diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> > > index 14db7376c712d19446b38152e480bd5a1e0a5198..504a7c5d5a9df4c787951f2ae3a69d566d205ad5 100644
> > > --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> > > +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> > > @@ -9,6 +9,7 @@
> > >   #include <linux/pm_domain.h>
> > >   #include <linux/pm_opp.h>
> > >   #include <soc/qcom/cmd-db.h>
> > > +#include <soc/qcom/tcs.h>
> > >   #include <drm/drm_gem.h>
> > >   #include "a6xx_gpu.h"
> > > @@ -1287,6 +1288,119 @@ static int a6xx_gmu_memory_probe(struct a6xx_gmu *gmu)
> > >   	return 0;
> > >   }
> > > +struct a6xx_bcm_data {
> > > +	u32 buswidth;
> > > +	unsigned int unit;
> > > +	unsigned int width;
> > 
> > In bits?
> > 
> > > +	unsigned int vcd;
> > 
> > What is this?
> 
> I'll also copy the icc-rpmh.h doc associated with those fields

Yes, please please provide some kerneldoc for the srtuct.

> 
> > 
> > > +	bool fixed;
> > 
> > What does it mean?
> 
> I took it from downstream, but it's the same as qcom_icc_bcm enable_mask instead here the mask depends on the platform and OPP, this is why I specified it in perfmode.
> 
> > 
> > > +	unsigned int perfmode;
> > > +	unsigned int perfmode_bw;
> > > +};
> > > +
> > > +struct bcm_db {
> > > +	__le32 unit;
> > > +	__le16 width;
> > > +	u8 vcd;
> > > +	u8 reserved;
> > > +};
> > > +
> > > +static int a6xx_gmu_rpmh_get_bcm_data(const struct a6xx_bcm *bcm,
> > > +				      struct a6xx_bcm_data *bcm_data)
> > 
> > Is there a reason to copy CMD DB and BCM data to the interim
> > representation instead of using those directly?
> 
> I guess I can keep bcm_db & a6xx_bcm as-is and do the _to_cpu() in-place.

I think that makes sense.

> 
> > 
> > > +{
> > > +	const struct bcm_db *data;
> > > +	size_t count;
> > > +
> > > +	data = cmd_db_read_aux_data(bcm->name, &count);
> > > +	if (IS_ERR(data))
> > > +		return PTR_ERR(data);
> > > +
> > > +	if (!count)
> > > +		return -EINVAL;
> > > +
> > > +	bcm_data->unit = le32_to_cpu(data->unit);
> > > +	bcm_data->width = le16_to_cpu(data->width);
> > > +	bcm_data->vcd = data->vcd;
> > > +	bcm_data->fixed = bcm->fixed;
> > > +	bcm_data->perfmode = bcm->perfmode;
> > > +	bcm_data->perfmode_bw = bcm->perfmode_bw;
> > > +	bcm_data->buswidth = bcm->buswidth;
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static void a6xx_gmu_rpmh_calc_bw_vote(struct a6xx_bcm_data *bcms,
> > > +				       int count, u32 bw, u32 *data)
> > > +{
> > > +	int i;
> > > +
> > > +	for (i = 0; i < count; i++) {
> > > +		bool valid = true;
> > > +		bool commit = false;
> > > +		u64 peak, y;
> > > +
> > > +		if (i == count - 1 || bcms[i].vcd != bcms[i + 1].vcd)
> > > +			commit = true;
> > > +
> > > +		if (bcms[i].fixed) {
> > > +			if (!bw)
> > > +				data[i] = BCM_TCS_CMD(commit, false, 0x0, 0x0);
> > > +			else
> > > +				data[i] = BCM_TCS_CMD(commit, true, 0x0,
> > > +					bw >= bcms[i].perfmode_bw ?
> > > +						bcms[i].perfmode : 0x0);
> > > +			continue;
> > > +		}
> > > +
> > > +		/* Multiple the bandwidth by the width of the connection */
> > 
> > ... and divide by the bus width. However it's not clear why you are
> > multiplying bandwidth (bits or bytes per second) with the width
> > (probably also bits?). Or is it not a width but the number of paths
> > between units?
> 
> So this is basically the same as in bcm_agregate:
> https://elixir.bootlin.com/linux/v6.12-rc6/source/drivers/interconnect/qcom/bcm-voter.c#L91
> 
> Just done slightly differently since we don't aggregate stuff but we want
> to set the bandwidth directly here from the GMU.

I see. And width comes from the CMD DB too.

> 
> > 
> > > +		peak = (u64)bw * bcms[i].width;
> > > +		do_div(peak, bcms[i].buswidth);
> > > +
> > > +		/* Input bandwidth value is in KBps */
> > 
> > Input or OPP / Interconnect?
> 
> I don't see the point, it's the input of the function which directly comes from OPP which is in KBps

I meant is it about the calculated 'peak' value? Also it might be worth
adding something mult_frac_ull, using do_div() instead of usual
division.


> > > +		y = peak * 1000ULL;
> > > +		do_div(y, bcms[i].unit);
> > > +
> > > +		/*
> > > +		 * If a bandwidth value was specified but the calculation ends
> > > +		 * rounding down to zero, set a minimum level
> > > +		 */
> > > +		if (bw && y == 0)
> > > +			y = 1;
> > 
> > Is it a real usecase or just a safety net? If the bandwidth ends up
> > being very low, maybe we should warn the users about it?
> 
> Probably a safety net, perhaps we could warn instead
> 
> > 
> > > +
> > > +		y = min_t(u64, y, BCM_TCS_CMD_VOTE_MASK);
> > > +		if (!y)
> > > +			valid = false;
> > 
> > This can probably be coupled with the previous condition.
> 
> Yeah I should probably refactor it and just avoid doing the
> calculation if bw == 0.
> 
> > 
> > > +
> > > +		data[i] = BCM_TCS_CMD(commit, valid, y, y);
> > > +	}
> > > +}
> > > +
> > > +static int a6xx_gmu_rpmh_bw_votes_init(const struct a6xx_info *info, struct a6xx_gmu *gmu)
> > > +{
> > > +	struct a6xx_bcm_data bcms[3];
> > > +	unsigned int bcm_count = 0;
> > > +	int ret, index;
> > > +
> > > +	/* Retrieve BCM data from cmd-db and merge with a6xx_info bcm table */
> > > +	for (index = 0; index < 3; index++) {
> > 
> > Magic number 3.
> > 
> > > +		if (!info->bcm[index].name)
> > > +			continue;
> > > +
> > > +		ret = a6xx_gmu_rpmh_get_bcm_data(&info->bcm[index], &bcms[index]);
> > > +		if (ret)
> > > +			return ret;
> > > +
> > > +		++bcm_count;
> > > +	}
> > > +
> > > +	/* Generate BCM votes values for each bandwidth & bcm */
> > > +	for (index = 0; index < gmu->nr_gpu_bws; index++)
> > > +		a6xx_gmu_rpmh_calc_bw_vote(bcms, bcm_count, gmu->gpu_bw_table[index],
> > > +					   gmu->gpu_bw_votes[index]);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > >   /* Return the 'arc-level' for the given frequency */
> > >   static unsigned int a6xx_gmu_get_arc_level(struct device *dev,
> > >   					   unsigned long freq)
> > > @@ -1390,12 +1504,15 @@ static int a6xx_gmu_rpmh_arc_votes_init(struct device *dev, u32 *votes,
> > >    * The GMU votes with the RPMh for itself and on behalf of the GPU but we need
> > >    * to construct the list of votes on the CPU and send it over. Query the RPMh
> > >    * voltage levels and build the votes
> > > + * The GMU can also vote for DDR interconnects, use the OPP bandwidth entries
> > > + * and BCM parameters to build the votes.
> > >    */
> > >   static int a6xx_gmu_rpmh_votes_init(struct a6xx_gmu *gmu)
> > >   {
> > >   	struct a6xx_gpu *a6xx_gpu = container_of(gmu, struct a6xx_gpu, gmu);
> > >   	struct adreno_gpu *adreno_gpu = &a6xx_gpu->base;
> > > +	const struct a6xx_info *info = adreno_gpu->info->a6xx;
> > >   	struct msm_gpu *gpu = &adreno_gpu->base;
> > >   	int ret;
> > > @@ -1407,6 +1524,10 @@ static int a6xx_gmu_rpmh_votes_init(struct a6xx_gmu *gmu)
> > >   	ret |= a6xx_gmu_rpmh_arc_votes_init(gmu->dev, gmu->cx_arc_votes,
> > >   		gmu->gmu_freqs, gmu->nr_gmu_freqs, "cx.lvl");
> > > +	/* Build the interconnect votes */
> > > +	if (adreno_gpu->info->quirks & ADRENO_QUIRK_GMU_BW_VOTE)
> > > +		ret |= a6xx_gmu_rpmh_bw_votes_init(info, gmu);
> > > +
> > >   	return ret;
> > >   }
> > > @@ -1442,6 +1563,38 @@ static int a6xx_gmu_build_freq_table(struct device *dev, unsigned long *freqs,
> > >   	return index;
> > >   }
> > > +static int a6xx_gmu_build_bw_table(struct device *dev, unsigned long *bandwidths,
> > > +		u32 size)
> > > +{
> > > +	int count = dev_pm_opp_get_opp_count(dev);
> > > +	struct dev_pm_opp *opp;
> > > +	int i, index = 0;
> > > +	unsigned int bandwidth = 1;
> > > +
> > > +	/*
> > > +	 * The OPP table doesn't contain the "off" bandwidth level so we need to
> > > +	 * add 1 to the table size to account for it
> > > +	 */
> > > +
> > > +	if (WARN(count + 1 > size,
> > > +		"The GMU bandwidth table is being truncated\n"))
> > > +		count = size - 1;
> > > +
> > > +	/* Set the "off" bandwidth */
> > > +	bandwidths[index++] = 0;
> > > +
> > > +	for (i = 0; i < count; i++) {
> > > +		opp = dev_pm_opp_find_bw_ceil(dev, &bandwidth, 0);
> > > +		if (IS_ERR(opp))
> > > +			break;
> > > +
> > > +		dev_pm_opp_put(opp);
> > > +		bandwidths[index++] = bandwidth++;
> > > +	}
> > > +
> > > +	return index;
> > > +}
> > > +
> > >   static int a6xx_gmu_pwrlevels_probe(struct a6xx_gmu *gmu)
> > >   {
> > >   	struct a6xx_gpu *a6xx_gpu = container_of(gmu, struct a6xx_gpu, gmu);
> > > @@ -1472,6 +1625,16 @@ static int a6xx_gmu_pwrlevels_probe(struct a6xx_gmu *gmu)
> > >   	gmu->current_perf_index = gmu->nr_gpu_freqs - 1;
> > > +	/*
> > > +	 * The GMU also handles GPU Interconnect Votes so build a list
> > > +	 * of DDR bandwidths from the GPU OPP table
> > > +	 */
> > > +	if (adreno_gpu->info->quirks & ADRENO_QUIRK_GMU_BW_VOTE)
> > > +		gmu->nr_gpu_bws = a6xx_gmu_build_bw_table(&gpu->pdev->dev,
> > > +			gmu->gpu_bw_table, ARRAY_SIZE(gmu->gpu_bw_table));
> > > +
> > > +	gmu->current_perf_index = gmu->nr_gpu_freqs - 1;
> > > +
> > >   	/* Build the list of RPMh votes that we'll send to the GMU */
> > >   	return a6xx_gmu_rpmh_votes_init(gmu);
> > >   }
> > > diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.h b/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
> > > index b4a79f88ccf45cfe651c86d2a9da39541c5772b3..95c632d8987a517f067c48c61c6c06b9a4f61fc0 100644
> > > --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
> > > +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
> > > @@ -19,6 +19,14 @@ struct a6xx_gmu_bo {
> > >   	u64 iova;
> > >   };
> > > +struct a6xx_bcm {
> > > +	char *name;
> > > +	unsigned int buswidth;
> > > +	bool fixed;
> > > +	unsigned int perfmode;
> > > +	unsigned int perfmode_bw;
> > > +};
> > > +
> > >   /*
> > >    * These define the different GMU wake up options - these define how both the
> > >    * CPU and the GMU bring up the hardware
> > > @@ -82,6 +90,10 @@ struct a6xx_gmu {
> > >   	unsigned long gpu_freqs[16];
> > >   	u32 gx_arc_votes[16];
> > > +	int nr_gpu_bws;
> > > +	unsigned long gpu_bw_table[16];
> > > +	u32 gpu_bw_votes[16][3];
> > 
> > Is it is the same magic 16 as we have few lines above or is this 16 a
> > different magic 16? And also 3 is a pure dark secret.
> 
> It's the same magic 16, since we use the same OPPs, the 3 is the actual number of BCMs we currently use, I wonder sure define should go, including the magic 16.

I think those defines can go to a6xx_gmu.h.
Also if the 16 is the same, should we define something like

  struct a6xx_gmu_freq_something {
  };

...

   struct a6xx_gmu {
       struct a6xx_gmu_freq_something bw_data[16];
   };

Seeing repetitive field size always makes me think about such a change.

> 
> > 
> > > +
> > >   	int nr_gmu_freqs;
> > >   	unsigned long gmu_freqs[4];
> > >   	u32 cx_arc_votes[4];
> > > diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
> > > index 4aceffb6aae89c781facc2a6e4a82b20b341b6cb..d779d700120cbd974ee87a67214739b1d85156e2 100644
> > > --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
> > > +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
> > > @@ -44,6 +44,7 @@ struct a6xx_info {
> > >   	u32 gmu_chipid;
> > >   	u32 gmu_cgc_mode;
> > >   	u32 prim_fifo_threshold;
> > > +	const struct a6xx_bcm bcm[3];
> > >   };
> > >   struct a6xx_gpu {
> > > 
> > > -- 
> > > 2.34.1
> > > 
> > 
> 

-- 
With best wishes
Dmitry

