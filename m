Return-Path: <linux-pm+bounces-25901-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88913A96CD0
	for <lists+linux-pm@lfdr.de>; Tue, 22 Apr 2025 15:32:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D337E17DC07
	for <lists+linux-pm@lfdr.de>; Tue, 22 Apr 2025 13:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3960D28C5A4;
	Tue, 22 Apr 2025 13:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cEygV0Vh"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A4C28B517
	for <linux-pm@vger.kernel.org>; Tue, 22 Apr 2025 13:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745328528; cv=none; b=bnRNxRK1cO9y6lruw76lspYKbD+xnvt1h54hwdqhsnXEO1/XxBmd5Yz7oJ5d7wAoK1d6uif+65cXLPCv2wLyaafgx//yfkrYRm3EgjVg1kk8rrB/y3eIwWKBg7bI6UaLMzVz/9hwnb0Hcmx4K0MFpxBiHXd3tpujjweShmSYyKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745328528; c=relaxed/simple;
	bh=ViyHovAi2SEzHa4yd1kygd9djfXSry24UVYbk29LzYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wyah4cOZKwsJp2jrN7AenUwsrdjvXYKdzSeC9uisJA+eEbBLwKi3/JrCAqFUPgmQWf1XxWzOAvf9ylUFI1CfBZtARQ6dYXlg4r0DhB1bJEtvgU0jp1kOINfdqRn1i1m5o5z3+1gbHeK+2zgA/x42wGF726wVmvJJnmR6sAf9+p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cEygV0Vh; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5e6f4b3ebe5so9404530a12.0
        for <linux-pm@vger.kernel.org>; Tue, 22 Apr 2025 06:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745328523; x=1745933323; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zJrR2JxkMMZwCpTNb/tpAEcXKA5Fk1cxT8LzYQjHkvI=;
        b=cEygV0VhiRrFgEb55teIQdho0agfPekqntBYy/gt2d1h/cMYxBXTZcyHgqGsIerG9O
         X/BWFWvFBY3chXiX57JdzRkpKE4jPV2ZN1owIWaVMMX7mc0YcQz5dRkPyyAD2NFq3EnZ
         MihYXJZVR4G47EH1KkzxLVRl2la/OaRs/Hu6uKrerxX9jMn0RqSTcdKMapFyyKcx4781
         Re2pUuF+x0pgiUGKFIzMLqmLfQxcPmLbvAF1AYqp61YP/TaMglPiSDeB162/3N/k1JWL
         IZElrEdBADoSa+ufmV7gsaK7eVtxj+LKkEDVeYS3Cj0e9WwizZxE8gRrevAQGBoxc11y
         d3ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745328523; x=1745933323;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zJrR2JxkMMZwCpTNb/tpAEcXKA5Fk1cxT8LzYQjHkvI=;
        b=gzf8IcWQE7cReZJ2rOrcBF201ZJG/0CMsfMY+hTjTmVVU/ZUgbcJ1ZyetnDUsfXLSu
         0vkGVy8rlLmwb1qRLFh2GxWFGietijkCxunRiQ3YfqvbovJHAQtTeNCL8o3nxmxumpHo
         9DIFWXxGQFshjkiJ1oaLTvskvHeSmu4WW8zsuXOO/Fx0tcKEmolPyByyIoXbv3gVutOE
         mKhp2LY9uaG0rL7vpoXRZvAVFRMm3O7Obzvmms6H5UlfArlT57GzQQuoQcPML2CWkhZk
         khIxcCBfZSHgeSZ2nO58X2dfwtAI/t5eNx1Q6CYd+UjVwwDkH9WRn5EyqYsXLZ4OWZvE
         ke+A==
X-Forwarded-Encrypted: i=1; AJvYcCVTHI2L+0maH2kQYO9fq5GAFaOt2v704CTRWNCxbB16RdriWTrOyKgSBAyCCveSPRUMbAci2OVmIg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwePaqzyLEyXOoTPqkl6snMDLGL03Ntx6Yd2X0FgUv/AfGYrBf1
	JL/u22Sjt53qT4jMKffXnoVgd7CvWUHoGfhXMgWnjQPcCxBaEbBjvh1vtxoVRa8=
X-Gm-Gg: ASbGnctApapw3T454fLekn9rjHRj6L8tE4G/9h+ehIwa0tAxnA0q5PxhqGvPEbYk4uW
	28LWDUfVWN+8BHtFhsc4aN7UBOB7c3dGkxCJvQM1swdKRhFVRghcU0nf/8LbJ/060o5FVg6M7sw
	VMh4Zu9rtGEC55vWUFjY2jDoMpLbYZUIXBlGH0RmRWCzQK9qzf7XJroZm1pXP92ZkVvISnTVTpH
	gdNx3qKb5kAhf1ZkzbCa4MYW46GtJtMBRK10pYr6zryC1yugNxLChXUFWoFrWNrK79cnVU6eFQX
	h1LtKlurODpyAAnPeq4O/yvxy2uXaVskBnf9eQ==
X-Google-Smtp-Source: AGHT+IGBZS9qAdq9W3YkRDXdH/Hs9bjK7HcuVeE81Ft+GPykI97oKk1Nc4VkNoyA40tEDn0sMITw8A==
X-Received: by 2002:a17:907:da3:b0:ac4:76d:6d2c with SMTP id a640c23a62f3a-acb74dba1e2mr1407490766b.40.1745328523115;
        Tue, 22 Apr 2025 06:28:43 -0700 (PDT)
Received: from linaro.org ([62.231.96.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace3175d95esm78875166b.173.2025.04.22.06.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 06:28:42 -0700 (PDT)
Date: Tue, 22 Apr 2025 16:28:40 +0300
From: Abel Vesa <abel.vesa@linaro.org>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Saravana Kannan <saravanak@google.com>, Stephen Boyd <sboyd@kernel.org>,
	linux-pm@vger.kernel.org, "Rafael J . Wysocki" <rafael@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Michael Grzeschik <m.grzeschik@pengutronix.de>,
	Bjorn Andersson <andersson@kernel.org>,
	Devarsh Thakkar <devarsht@lewv0571a.ent.ti.com>,
	Peng Fan <peng.fan@oss.nxp.com>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Johan Hovold <johan@kernel.org>,
	Maulik Shah <maulik.shah@oss.qualcomm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/11] pmdomain: core: Simplify return statement in
 genpd_power_off()
Message-ID: <aAeZiIE9URMmf3JE@linaro.org>
References: <20250417142513.312939-1-ulf.hansson@linaro.org>
 <20250417142513.312939-3-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250417142513.312939-3-ulf.hansson@linaro.org>

On 25-04-17 16:25:00, Ulf Hansson wrote:
> Rather than using two if-clauses immediately after each to check for
> similar reasons to prevent the power-off, let's combine them into one
> if-clause to simplify the code.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Reviewed-by: Abel Vesa <abel.vesa@linaro.org>

> ---
>  drivers/pmdomain/core.c | 20 +++++++-------------
>  1 file changed, 7 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
> index 574a0de1696a..34a85bf347ad 100644
> --- a/drivers/pmdomain/core.c
> +++ b/drivers/pmdomain/core.c
> @@ -917,20 +917,14 @@ static void genpd_power_off(struct generic_pm_domain *genpd, bool one_dev_on,
>  
>  	/*
>  	 * Do not try to power off the domain in the following situations:
> -	 * (1) The domain is already in the "power off" state.
> -	 * (2) System suspend is in progress.
> +	 * The domain is already in the "power off" state.
> +	 * System suspend is in progress.
> +	 * The domain is configured as always on.
> +	 * The domain has a subdomain being powered on.
>  	 */
> -	if (!genpd_status_on(genpd) || genpd->prepared_count > 0)
> -		return;
> -
> -	/*
> -	 * Abort power off for the PM domain in the following situations:
> -	 * (1) The domain is configured as always on.
> -	 * (2) When the domain has a subdomain being powered on.
> -	 */
> -	if (genpd_is_always_on(genpd) ||
> -			genpd_is_rpm_always_on(genpd) ||
> -			atomic_read(&genpd->sd_count) > 0)
> +	if (!genpd_status_on(genpd) || genpd->prepared_count > 0 ||
> +	    genpd_is_always_on(genpd) || genpd_is_rpm_always_on(genpd) ||
> +	    atomic_read(&genpd->sd_count) > 0)
>  		return;
>  
>  	/*
> -- 
> 2.43.0
> 

