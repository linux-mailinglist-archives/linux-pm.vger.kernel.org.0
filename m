Return-Path: <linux-pm+bounces-17629-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5FA09CE163
	for <lists+linux-pm@lfdr.de>; Fri, 15 Nov 2024 15:36:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A702E280D42
	for <lists+linux-pm@lfdr.de>; Fri, 15 Nov 2024 14:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E82721CEEBA;
	Fri, 15 Nov 2024 14:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GaKHY/z2"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60241CDA3F
	for <linux-pm@vger.kernel.org>; Fri, 15 Nov 2024 14:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731681359; cv=none; b=W6ieXUeYfGwjzPzUo73JIQHBuBLqRV7uJ+unxuUJ4NxiWFAWL6eODoaGjWBHudVf/uYrPkLDmTLeAH51UlmZsFahK97eUxijYnnbwIxPGenwIVzLN9uJYMW8amfmvdQz5Flyfj4X6FidM4hO84/SQmvF3gsVT3QdtkzPxYc0+dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731681359; c=relaxed/simple;
	bh=aKFssPoMCbEZPG5Jve3taMTZ0CaJrhtVp1laAqMUheA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t0FxQG6/v9VF/69PJ87A1PYYEys56hemkwskKBnoAflVVkBSyV6fxRkxg7EPH7eI7pqWMFKLa7OtQYNKBMJanla+86ZZX8UQPnil38XFf9KkkdimfPo9aHeKKFYY7pYwS0IJ44oS+x/2RcPYJ7X/alpmjQeB145T97Gk+4tQVlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GaKHY/z2; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-539fb49c64aso3100872e87.0
        for <linux-pm@vger.kernel.org>; Fri, 15 Nov 2024 06:35:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731681356; x=1732286156; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d43CGOrYwQTMl3TbKozwdFlBmEWO7EVgTabyaP0raws=;
        b=GaKHY/z2CEG8C5V+QDB4jq4+emRuSbks9O7z3BjQzaQJ3IXsNgWDdhFrXSHLL7LZ1z
         GpR75hDP3FACr6xsDBqk+X9Ph2odVxbcq4Ubl2+p6/Vl7EAYIT65FD8WffU/XpOiwieF
         OfGSplVrZdTsCvtJ29M0XP9b6g7D4dTC4ZtqU+YPl3hxy0Tk2bmNpzQlgyGYlVzY0DAa
         xPa5+5rHzqDg5qRSgixpVIFxQb3jOMFQDodSoHNqKqFFmXPGH9WUwlInuRjNrgw9j2Ml
         9vU40ujmc32qBvslnvFt+ltaLvZGP+zWTNOEyww7iMAy6+cINyX5DmjlmImwoJbQTsSi
         7B8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731681356; x=1732286156;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d43CGOrYwQTMl3TbKozwdFlBmEWO7EVgTabyaP0raws=;
        b=QcFUcl6bwv6UE9Ek1WzVJogTZueLTZ59MzBu5zNtVMKuMc6bxWmyuXkl6giYz2t+FC
         sTrFkx8wbI6D4Y7LSaFIaS41Eu7Zwv5+9XqdbE7GO3u9vVNIhHnbtFwyZX4HKO5KeZuq
         X8IF69K/veFOfUeriaYw7XLBG/UqoysnGhD92o6yMruq4ZYapIZz6KfB8RwE5nXShGFA
         5+lmu0odgRfEUAWhienzsX67mzIfxzsmhWToDwvrhk2e4HAVGcxQOSS3r4YhP6EVJKjM
         MLMH1SqWXE8/iELMU5RFp7lO7+XXg4fJYQRcz0/gkpTuXNe4Ia3lkG1o/Lwa0bh/5sTn
         OO+g==
X-Forwarded-Encrypted: i=1; AJvYcCU3mxcNhbtZvFXM8MPDIMKDTRDg8Dk9CTYJnnhq21Ql94Cw5SxVNolkEfLaaIljO5FHnfk6uosREg==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd+4KCD3gp6gDpEgrMLJMoPaviqutluKNxeKA3Nfzp//xfJ+R6
	19BRuvPV5DI5nL2RO1RFqlEp3Z2eWDkGYhSSTuHw8aU0Uzk98rxnuIAP5g2tKew=
X-Google-Smtp-Source: AGHT+IGLd55wpxXxX1fO2aUjNA5hPIFqY7ITl3o7gnKYbcvdkrET0x7ZnGF298YRTzlshfucVbwYBQ==
X-Received: by 2002:a05:6512:b1e:b0:53d:a504:9334 with SMTP id 2adb3069b0e04-53dab3b1718mr2002254e87.44.1731681355937;
        Fri, 15 Nov 2024 06:35:55 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53da6500cbcsm586808e87.88.2024.11.15.06.35.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 06:35:54 -0800 (PST)
Date: Fri, 15 Nov 2024 16:35:52 +0200
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
Subject: Re: [PATCH RFC 4/8] drm/msm: adreno: dynamically generate GMU bw
 table
Message-ID: <6bcdwzmm267x3657iydnoxdnxacexitzwjkvihzn3y57vxq3n6@vuhgq2x3iy5g>
References: <20241113-topic-sm8x50-gpu-bw-vote-v1-0-3b8d39737a9b@linaro.org>
 <20241113-topic-sm8x50-gpu-bw-vote-v1-4-3b8d39737a9b@linaro.org>
 <rvfrkb4v7cilzu3prv5dr2dni7m3jv3crhmto3uume5v5wxr5m@apvyb4lc2rre>
 <17243670-7e91-46f8-812d-3f21cee5cd2c@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17243670-7e91-46f8-812d-3f21cee5cd2c@linaro.org>

On Fri, Nov 15, 2024 at 10:11:09AM +0100, Neil Armstrong wrote:
> On 15/11/2024 08:24, Dmitry Baryshkov wrote:
> > On Wed, Nov 13, 2024 at 04:48:30PM +0100, Neil Armstrong wrote:
> > > The Adreno GPU Management Unit (GMU) can also scale the ddr
> > > bandwidth along the frequency and power domain level, but for
> > > now we statically fill the bw_table with values from the
> > > downstream driver.
> > > 
> > > Only the first entry is used, which is a disable vote, so we
> > > currently rely on scaling via the linux interconnect paths.
> > > 
> > > Let's dynamically generate the bw_table with the vote values
> > > previously calculated from the OPPs.
> > 
> > Nice to see this being worked upon. I hope the code can is generic
> > enough so that we can use it from other adreno_foo_build_bw_table()
> > functions.
> 
> I would hope so, but I don't have the HW to properly test it on those
> platforms.

Welcome to the club^W Lab.

> > > Those entried will then be used by the GMU when passing the
> > > appropriate bandwidth level when voting for a gpu frequency.
> > > 
> > > Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> > > ---
> > >   drivers/gpu/drm/msm/adreno/a6xx_hfi.c | 48 +++++++++++++++++++++++++++--------
> > >   1 file changed, 37 insertions(+), 11 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/msm/adreno/a6xx_hfi.c b/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
> > > index cb8844ed46b29c4569d05eb7a24f7b27e173190f..9a89ba95843e7805d78f0e5ddbe328677b6431dd 100644
> > > --- a/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
> > > +++ b/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
> > > @@ -596,22 +596,48 @@ static void a730_build_bw_table(struct a6xx_hfi_msg_bw_table *msg)
> > >   	msg->cnoc_cmds_data[1][0] = 0x60000001;
> > >   }
> > > -static void a740_build_bw_table(struct a6xx_hfi_msg_bw_table *msg)
> > > +static void a740_generate_bw_table(struct adreno_gpu *adreno_gpu, struct a6xx_gmu *gmu,
> > > +				   struct a6xx_hfi_msg_bw_table *msg)
> > >   {
> > > -	msg->bw_level_num = 1;
> > > +	const struct a6xx_info *info = adreno_gpu->info->a6xx;
> > > +	unsigned int i, j;
> > > -	msg->ddr_cmds_num = 3;
> > >   	msg->ddr_wait_bitmask = 0x7;
> > > -	msg->ddr_cmds_addrs[0] = cmd_db_read_addr("SH0");
> > > -	msg->ddr_cmds_addrs[1] = cmd_db_read_addr("MC0");
> > > -	msg->ddr_cmds_addrs[2] = cmd_db_read_addr("ACV");
> > > +	for (i = 0; i < 3; i++) {
> > > +		if (!info->bcm[i].name)
> > > +			break;
> > > +		msg->ddr_cmds_addrs[i] = cmd_db_read_addr(info->bcm[i].name);
> > > +	}
> > > +	msg->ddr_cmds_num = i;
> > > -	msg->ddr_cmds_data[0][0] = 0x40000000;
> > > -	msg->ddr_cmds_data[0][1] = 0x40000000;
> > > -	msg->ddr_cmds_data[0][2] = 0x40000000;
> > > +	for (i = 0; i < gmu->nr_gpu_bws; ++i)
> > > +		for (j = 0; j < msg->ddr_cmds_num; j++)
> > > +			msg->ddr_cmds_data[i][j] = gmu->gpu_bw_votes[i][j];
> > > +	msg->bw_level_num = gmu->nr_gpu_bws;
> > > +}
> > > +
> > > +static void a740_build_bw_table(struct adreno_gpu *adreno_gpu, struct a6xx_gmu *gmu,
> > > +				struct a6xx_hfi_msg_bw_table *msg)
> > > +{
> > > +	if ((adreno_gpu->info->quirks & ADRENO_QUIRK_GMU_BW_VOTE) && gmu->nr_gpu_bws) {
> > > +		a740_generate_bw_table(adreno_gpu, gmu, msg);
> > > +	} else {
> > 
> > Why do we need a fallback code here?
> 
> Because at this particular commit, it would generate an invalid table, I should probably remove the fallback at the end

Or move this to a generic code that generates a table if there is no bw
data (like there is none for older platforms with the current DTs).

> 
> > 
> > > +		msg->bw_level_num = 1;
> > > -	/* TODO: add a proper dvfs table */
> > > +		msg->ddr_cmds_num = 3;
> > > +		msg->ddr_wait_bitmask = 0x7;
> > > +
> > > +		msg->ddr_cmds_addrs[0] = cmd_db_read_addr("SH0");
> > > +		msg->ddr_cmds_addrs[1] = cmd_db_read_addr("MC0");
> > > +		msg->ddr_cmds_addrs[2] = cmd_db_read_addr("ACV");
> > > +
> > > +		msg->ddr_cmds_data[0][0] = 0x40000000;
> > > +		msg->ddr_cmds_data[0][1] = 0x40000000;
> > > +		msg->ddr_cmds_data[0][2] = 0x40000000;
> > > +
> > > +		/* TODO: add a proper dvfs table */
> > 
> > I think TODO is unapplicable anymore.
> > 
> > > +	}
> > >   	msg->cnoc_cmds_num = 1;
> > >   	msg->cnoc_wait_bitmask = 0x1;
> > > @@ -691,7 +717,7 @@ static int a6xx_hfi_send_bw_table(struct a6xx_gmu *gmu)
> > >   	else if (adreno_is_a730(adreno_gpu))
> > >   		a730_build_bw_table(msg);
> > >   	else if (adreno_is_a740_family(adreno_gpu))
> > > -		a740_build_bw_table(msg);
> > > +		a740_build_bw_table(adreno_gpu, gmu, msg);
> > >   	else
> > >   		a6xx_build_bw_table(msg);
> > > 
> > > -- 
> > > 2.34.1
> > > 
> > 
> 

-- 
With best wishes
Dmitry

