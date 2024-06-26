Return-Path: <linux-pm+bounces-10018-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 232D8917908
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 08:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98F2A1F21E6F
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 06:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F717153803;
	Wed, 26 Jun 2024 06:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GsXVUD4W"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763B414F125
	for <linux-pm@vger.kernel.org>; Wed, 26 Jun 2024 06:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719383606; cv=none; b=ISIpxmASjSBBZRxbHagTEHL46c5LpgKOYDUQJEihTIMp2TZiMY1Xdom9NY16b/FpwoNZMQYxxCDZjaWUiBVoOIXPlxzgsKl0+UsZ6hP96PYvgqc49G6DKrofyoBHXoCfVnVkYBBwcoDYbjvuAQyYQcGFL22FfSpsXD5Sy9EG+b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719383606; c=relaxed/simple;
	bh=Shi12dlPxlBZPg66WRXw4zfsLLkZ8IHxFQjsPCKC7/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=crojb4cfgArBm5GR/lI3SkGkLU0BxXeeO52ip9t+f/4OrXcBZo4RQFn8OZ/Vmhenho43RCI4R91SE9tyhbu6l5Gn6mOnUpNeGnMExg2S9UcVeXYWMWP/SZUIUGZ62kBOFjTCBI8uLNVfoeoEd0RZyHGb+POQh/jNuFnQVfrMNoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GsXVUD4W; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2c1a4192d55so4830102a91.2
        for <linux-pm@vger.kernel.org>; Tue, 25 Jun 2024 23:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719383605; x=1719988405; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xIe54blZeFv2wCBTIbQ224KWLDIpEaIZB95qu35e1SY=;
        b=GsXVUD4WXvA+uTVFUxOmJGyR70I/7numLflir729+raNSUi4YcMIrY4O9k8XSgWrDk
         ktNUMD6ubW/+4zUgQR5DwxbDo+nzrfqEFBxL6Srf78/bK9Kpf9UpddwAJEbcQ1W+tUic
         8r/11Z6ljpMMHGLL5jQPOVz++S07dC4tGhlBa6ge4Gfa25M22DqSliVTtyeLXRvnuXWi
         spLnW9N8A8bUvawEegUSHazkVSE/YwCNh7LMrNYJm0KM24zNKuDgORVEkb10EqIL7M8w
         yrspx3QW4STE+g2X3Ku4C/yvqx076Q6U7gXjXqBN6lw/LMUmRvbjXj2/L5MSC+lgc25G
         WBkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719383605; x=1719988405;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xIe54blZeFv2wCBTIbQ224KWLDIpEaIZB95qu35e1SY=;
        b=EGemnWJRZNbXUqNNSzRGCwj3EFl5GZTgsF0QdXY1efB+J//bp+QqTLuL7EU/ecnTDV
         trPaLZWXGOZU317B1tEJEKekjpX3BD809cpDrOWOXzC01o+l6dxXyTl7bh8xMtbKB7s9
         NUrr5tSoFWLJlXCp3wlLyisUU27EPi1R3UnqwJ1WRNNt1rwjONt/T82tlOBvY7RjainS
         UbpSuk12CCjyBen2XKUwFA4cTs+J3SS6CyjXOLIo16cFKEpLeu90t1WzB+YI+q/dxOD1
         yL103qSO+KjEJOWyMe8gCNl9zVNR+o2XDhEEg755gsz0HSNOQFErMya2Vo9bD4CBFTAt
         dLdg==
X-Forwarded-Encrypted: i=1; AJvYcCXuq1NiS73QmBjbhf1uF5ga9lOLNdXW7ttXvSZYDuNi5qMKVlYcfnLiip0tcvJEq708bzVLyULy07ysv9X+obFa0/HivBsJBiE=
X-Gm-Message-State: AOJu0Yxfr1/2k5Dc8fukXWnz0sbd4sFLLftH9i2sXZfPoJUxXBMSdR5G
	7WqtjmgU7IQZUiG5TeTaS+6LVXKR+WoFF0Imat4wcPBKO2lnqIqIuEQZT1oghfc=
X-Google-Smtp-Source: AGHT+IEvJ56j6yvQEX4nDHubHwfsFnfDLbBvWF1DIzuJCWlkxtNCeWyF2FWFrmDRy/GwFtNFQfBrvw==
X-Received: by 2002:a17:90a:887:b0:2c8:5f01:affd with SMTP id 98e67ed59e1d1-2c85f01b7f7mr9036616a91.36.1719383604658;
        Tue, 25 Jun 2024 23:33:24 -0700 (PDT)
Received: from localhost ([122.172.82.13])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c8d7e55c14sm804529a91.2.2024.06.25.23.33.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 23:33:24 -0700 (PDT)
Date: Wed, 26 Jun 2024 12:03:21 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Nikunj Kela <nkela@quicinc.com>,
	Prasad Sodagudi <psodagud@quicinc.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>, linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] OPP: Rework _set_required_devs() to manage a single
 device per call
Message-ID: <20240626063321.3x4cvyj7yiks5f3p@vireshk-i7>
References: <20240619140849.368580-1-ulf.hansson@linaro.org>
 <20240619140849.368580-4-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240619140849.368580-4-ulf.hansson@linaro.org>

On 19-06-24, 16:08, Ulf Hansson wrote:
> @@ -2494,36 +2495,68 @@ static int _opp_set_required_devs(struct opp_table *opp_table,
>  		return -EINVAL;
>  	}
>  
> -	/* Another device that shares the OPP table has set the required devs ? */
> -	if (opp_table->required_devs[0])
> -		return 0;
> +	/* Genpd core takes care of propagation to parent genpd */
> +	if (opp_table->is_genpd) {

A genpd can have non-genpd devices in the required OPPs and so this
isn't sufficient. What we were ignoring earlier was genpd having
another genpd as required opp.

> +		dev_err(dev, "%s: Operation not supported for genpds\n", __func__);
> +		return -EOPNOTSUPP;
> +	}
>  
>  	for (i = 0; i < opp_table->required_opp_count; i++) {
> -		/* Genpd core takes care of propagation to parent genpd */
> -		if (required_devs[i] && opp_table->is_genpd &&
> -		    opp_table->required_opp_tables[i]->is_genpd) {
> -			dev_err(dev, "%s: Operation not supported for genpds\n", __func__);
> -			return -EOPNOTSUPP;
> -		}
> +		struct opp_table *table = opp_table->required_opp_tables[i];
> +
> +		/*
> +		 * The OPP table should be available at this point. If not, it's
> +		 * not the one we are looking for.
> +		 */
> +		if (IS_ERR(table))
> +			continue;
> +
> +		/* Move to the next available index. */
> +		if (opp_table->required_devs[i])
> +			continue;
>  
> -		opp_table->required_devs[i] = required_devs[i];
> +		/*
> +		 * We need to compare the nodes for the OPP tables, rather than
> +		 * the OPP tables themselves, as we may have separate instances.
> +		 */
> +		if (required_opp_table->np == table->np) {
> +

We don't keep such empty lines in OPP core generally at this place.

> +			/* Cross check the OPP tables and fix it if needed. */

Copy the bigger comment from_opp_attach_genpd() here too. It helps
understanding why required_opp_tables entry is getting replaced.

> +			if (required_opp_table != table) {
> +				dev_pm_opp_put_opp_table(table);
> +				_get_opp_table_kref(required_opp_table);
> +				opp_table->required_opp_tables[i] = required_opp_table;
> +			}
> +
> +			opp_table->required_devs[i] = required_dev;
> +
> +			/*
> +			 * Add the required_dev as a user of the OPP table, so
> +			 * we can call dev_pm_opp_set_opp() on it directly.
> +			 */
> +			if (!_add_opp_dev(required_dev, required_opp_table)) {
> +				dev_err(dev, "Failed to add the device to the required OPP table\n");
> +				return -ENOMEM;
> +			}
> +
> +			return i;
> +		}
>  	}

-- 
viresh

