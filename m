Return-Path: <linux-pm+bounces-21444-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C1DEA2A025
	for <lists+linux-pm@lfdr.de>; Thu,  6 Feb 2025 06:28:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC028163BB9
	for <lists+linux-pm@lfdr.de>; Thu,  6 Feb 2025 05:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60611223324;
	Thu,  6 Feb 2025 05:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z218f1wG"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5EA022331F
	for <linux-pm@vger.kernel.org>; Thu,  6 Feb 2025 05:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738819679; cv=none; b=YT9SHW1w590kvcgdv6Jt1vCjsgY7D8p31UPXQvD9e8i+MyZww9+FaR5kYb7592+vjSCL9ujuGdR3QY2gxrnhga24myJY5exMTgf4VMIKJJxh89oW1/JzJX6o6f9GHRdIV7EHb06CsP59vO/JzSPn0bgFCw43oZGpw/9h4d77aJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738819679; c=relaxed/simple;
	bh=UjMdMXdzfY8FA3OIjvPbpQ2pM3XdG3LmxQG3cALELwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H3Ws7f2HMOECH0u/hQaDFz+TSqQlPBGBOVhb8U6240QHDLPGrdtWFk8XemULLtpiE/ayEgEVqozU5hAmvN+IbeAdK5GdXb3hvP/yGWfiibwSJZILbWvpw+S+6KT5Fqk9PnjHdQ9HkeMJlEOI9n68puXSoE1vlAmtIhFmqZ9843I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=z218f1wG; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-21661be2c2dso10246895ad.1
        for <linux-pm@vger.kernel.org>; Wed, 05 Feb 2025 21:27:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738819677; x=1739424477; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N5TuaKcHCHKRHmy6UIoV5V210kvNYMZbMQRWf3DAlzE=;
        b=z218f1wG/yYIELH4Evon3ardntw/HbbfDmkBaHBNfH78gchqYsDZu4vCA5vqJ5vUQU
         KDGGPJn/L+31A67q2Dk2vHk/RRu9SoPfvokHLXWjclj+wv7EC0AZrrawXR/1VOuS9RT8
         TwS2QrI/n2ISsnknDGvoordQbVVOCO6Y/WQic8oUzGe3TBbV6atrXRJQmGY8ALOC3aLQ
         wAJElvpZLmmoX3WdmBX/qzj3C3Jm1u2yaYZxbEJdDC+nxsfc7XWpW/pHbRQCA5yEbGLk
         MZVbigje0PDD3D9Z/p7ZCTDCO8L+yMMujgoM7lH1s3hp29DMWgQBJrgAULD94ewi48jQ
         mprA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738819677; x=1739424477;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N5TuaKcHCHKRHmy6UIoV5V210kvNYMZbMQRWf3DAlzE=;
        b=dBecQcIuugPnUHRXaPHW8E8FEwgReo7sOFNaOm/gQPL0tryZ1mOHxS22Z6cuOKNseX
         bZdPvgpSiWaFoqKnxXJETeoQj6A/+JXOcVjGOskrQIkwqKCJtdIMZlGSgHrzZMLb8kfF
         +9dybpDfIgSVX2q7ldUzxEf0CHz2WA4IGvv3LibuHhCILqr+hei0MJMMMTkujQRxhBek
         BXA/d+e39mxacqpjSMUzfLI/X2w23MT9F5j8/ddTPtvigcjoaP2HL0ShIBsJmYB69eBj
         /Wqzj5btDbNt2qgDng/jTNzp/h2htqvJazxKGHvVD1YRhfKODCPo+OEhhR8bBYXacePk
         vdNg==
X-Forwarded-Encrypted: i=1; AJvYcCVMfv9D4FmMgR1v7NeY4PfHb42eapuw0if0bCSEshSdBJb2alaU3EGNsl87JYcYLJVs3IunQzYVbw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxW+FQy9xVvpj2jLe+fI7ijLtY4LsaHxH2VIVM0ostiAMb6LUut
	HVTLCLuuQj4kW5pVNVetvg4E7pbXFjDbNTpWLNibYO5sz08bSr+FJX+Ru7/+xN8=
X-Gm-Gg: ASbGncumnYu+TOZSpfJZEERura3JmWe7afMytp80+mLGnP3+EB9hd+Upl51NCtHD9jn
	9PkePP1DnGRTkXz65xdxiMFq39+RCEJt9ZjAwfm08NB+SrAP5veAEDPkmcnCv0q9+nN7Fjx1ER3
	AubfI50bSoGOEJaAaJTJPzI4I3ErVE8CoAxzSImF4OQH1jnai2oTwEukxguROGm8DEO3rjTbYS/
	AKIdRKW3nsU5bE+J+fi8eEFK00M+EdDelkjv9PdHmUQtWfgjpFy+BIUN4RPPOI8siqZAos5SEFE
	6Dvz03Ke2ZmhPuLffg==
X-Google-Smtp-Source: AGHT+IHOn7iWRBNscDl6r4DQ+HQlP4sycPSn7NOLs7VrTo4POwB3zeP6AMKOQs+Jwf8U4Z2smBr7vQ==
X-Received: by 2002:a17:902:da85:b0:216:1543:195d with SMTP id d9443c01a7336-21f17e46190mr100438965ad.25.1738819676962;
        Wed, 05 Feb 2025 21:27:56 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3689e280sm3312565ad.219.2025.02.05.21.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 21:27:56 -0800 (PST)
Date: Thu, 6 Feb 2025 10:57:54 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/15] cpufreq: cppc: Set policy->boost_supported
Message-ID: <20250206052754.3p5axkd4tsz5knhe@vireshk-i7>
References: <cover.1737707712.git.viresh.kumar@linaro.org>
 <c744751c8f61cae509959270176ebdef77326ba2.1737707712.git.viresh.kumar@linaro.org>
 <d7acce9e-fafc-4b1d-80f9-2ddc46b5a28d@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7acce9e-fafc-4b1d-80f9-2ddc46b5a28d@huawei.com>

On 06-02-25, 11:58, zhenglifeng (A) wrote:
> On 2025/1/24 16:58, Viresh Kumar wrote:
> > diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> > index 7fa89b601d2a..08117fb9c1eb 100644
> > --- a/drivers/cpufreq/cppc_cpufreq.c
> > +++ b/drivers/cpufreq/cppc_cpufreq.c
> > @@ -34,8 +34,6 @@
> >   */
> >  static LIST_HEAD(cpu_data_list);
> >  
> > -static bool boost_supported;
> > -
> >  static struct cpufreq_driver cppc_cpufreq_driver;
> >  
> >  #ifdef CONFIG_ACPI_CPPC_CPUFREQ_FIE
> > @@ -653,7 +651,7 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
> >  	 * is supported.
> >  	 */
> >  	if (caps->highest_perf > caps->nominal_perf)
> > -		boost_supported = true;
> > +		policy->boost_supported = true;
> >  
> >  	/* Set policy->cur to max now. The governors will adjust later. */
> >  	policy->cur = cppc_perf_to_khz(caps, caps->highest_perf);
> > @@ -791,11 +789,6 @@ static int cppc_cpufreq_set_boost(struct cpufreq_policy *policy, int state)
> >  	struct cppc_perf_caps *caps = &cpu_data->perf_caps;
> >  	int ret;
> >  
> > -	if (!boost_supported) {
> > -		pr_err("BOOST not supported by CPU or firmware\n");
> > -		return -EINVAL;
> > -	}
> > -
> >  	if (state)
> >  		policy->max = cppc_perf_to_khz(caps, caps->highest_perf);
> >  	else
> 
> I have a little question. With the old boost_supported flag as false, it
> will fail when you operate the global boost flag. But if you replace it
> with the per-policy boost_supported flag, the global boost_enabled flag can
> be set to true without any error, even no policy's boost_enabled flag
> changed. Is this interface behavior change OK?

Right, so earlier even if a single policy didn't support boost, the code disabled
boost for all of them. Or it was rather racy, as the last policy to be
initialized will decide if boost will be supported or not. This is surely
incorrect.

The global boost flag can be enabled disabled without worrying about any
individual policy. If the policy supports boost, it will follow the global boost
here, else it shouldn't take part in the change.

So yes, the new interface does the right thing here.

-- 
viresh

