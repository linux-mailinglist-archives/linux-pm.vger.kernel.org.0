Return-Path: <linux-pm+bounces-20875-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F7EA1A4A0
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2025 14:04:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06367188BB73
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2025 13:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AFB520F081;
	Thu, 23 Jan 2025 13:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HLCvtPzR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6483A1C3C01
	for <linux-pm@vger.kernel.org>; Thu, 23 Jan 2025 13:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737637461; cv=none; b=GXehWv6kNbtcjqtNB0AkhF+r/TWLwD4oscZB+nP2xKF+TT07xAmga7mCzwjn6RLiqdNgS1NhyHoDR0/os+rzjh8tLmwMilCaYfvtuONKydZBRKZ191NLfCwFPrRkgbMvHn7sKs/g8O8aWwKqs62loOjegm66EgygbZmlnY23bSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737637461; c=relaxed/simple;
	bh=Vdzu+Fwt06yiMZfjE+22PPXLLqoNKYmCMWOlFKYGS6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eLB8hXMCS7ALb5forutDTzH6akJuoPCHEJ00W+6x04kx3MblnQ7N8QYRVUzJ5qF53IREAjMmvSze4uM990NMyF6xuSHrbfOtydJVI4zcJlaW3ufhQ/IscoQ6Ab846lXhSZvjV/78UuR1dgpGodl1QN6GkEqGGw8L/sPNxVdZbU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HLCvtPzR; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43690d4605dso5927845e9.0
        for <linux-pm@vger.kernel.org>; Thu, 23 Jan 2025 05:04:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737637458; x=1738242258; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cl9194DFZdwJ8whugEX9MZlsEcPw/nky6ZU9/dikYFM=;
        b=HLCvtPzR90s05j+V8GWMTSEEbCOvC6iZdTVLkhBuL61VE8hfLLVr5altYV2MtIRdwK
         KOgtrXK7SCtDCKQwARJiEuYX6cVwTOhtIc/dzi6iU7T2JTj75Zc4VOxf0rcSo8FV1iXA
         PgEUde/SrBn2Bh0CTOUAwUXPUVK/fB1+FWAAKO2MvHd22hcDL41awmb6gXgrMd8h2Zwe
         FnKLFZhUaJBMjjunV2mPYNF2T/Hf/CcE7L6LCF30qngFRKQvfOmBmmq7lWQcT3SgYOql
         5k6dcVPITs2gGXpjRp0ld8daQeh8lPjcL2+PXuBPSb+DDaycOg6bL/h294Ry3ohoJ6rB
         4tLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737637458; x=1738242258;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cl9194DFZdwJ8whugEX9MZlsEcPw/nky6ZU9/dikYFM=;
        b=CQV3ufk+av3F3N1smDxVK0Bt3C54grhQrGEm5nA7aQy/reJySNP/15weUdt60tVBY9
         +0OlDu7XDrE41ZT/e+JFjck50O+W7mziSsTLT1uRP00a9YpIsnpgf2oaR2lcTMLuD8nh
         ESCE3ixzUhtz0qAxz6lV+VD1S+lmZmXCK1GJNeDxYH+KUpWamngxMG4Di7Ou6NfnyDoy
         +280gCLWGCgw9qgXYRcyWXUVgIUvyiSirXDk8ZzkgmcvTHjTlb83DtmSIbkCiHX+19tC
         v1piZH3Ix7ORBnJZDDQfXnZ6imAYQkQ3Iy/njNtHuYmrWKQi2dBVxfDWpIFY0kPQ2YAK
         XjlQ==
X-Forwarded-Encrypted: i=1; AJvYcCVh+RAXhYySqGwdIDqrTRDEKmexGJj8tdtegIokHzK01aDwytlOzAqxbA/1978Zi3U8hRqKbTxd0Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0MDc3vkCYmR3fPLu7Vn9CvNvYms90sD2E/upvkykKNl3V15Lx
	e//kO0AfoUa3TdTFi/yzkeKQe/XJ5DYUVeNEe4aqGEO6oQ0OWPAOu8O2pGa2MAo=
X-Gm-Gg: ASbGncu+xfOoO8mfppHr8tOmwXS2XQv3kqb6HJwyJrCU9SZF5THAPBNlDeWgImjWhf7
	ME6+hlWhz1XGqBquKLwbQTAefIl0RWbcu9cccsAjjakuc0Vv6hap+lTDott3T5XjrtY8Qe3EYa5
	YeuzmRuK8xuVE91pyeeZL3EJAUwSjHgRV6nCowSApUiPSdVpXGfjSkVtss5UfvNQh3LthFCIpa3
	RRB/Uvro2ehOOTFFoFfA6niHXvfrPp8d5WaUtbr3eo/EcpecKA25G9X7eRiXejYVXEq+xfjT9uz
	vaTiaBfsoP+FuEjX586G
X-Google-Smtp-Source: AGHT+IFfMaV0Ij3T3tldLauIZsdbGiEdyirSW5JG2BohSSJNY2hQK3fqNX1SRxOVtDQ4hJ9zH+XqLQ==
X-Received: by 2002:a05:600c:3d06:b0:434:eb73:b0c0 with SMTP id 5b1f17b1804b1-438913c7e31mr266934345e9.5.1737637457469;
        Thu, 23 Jan 2025 05:04:17 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438b31afa30sm64090025e9.20.2025.01.23.05.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 05:04:16 -0800 (PST)
Date: Thu, 23 Jan 2025 16:04:13 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: zuoqian <zuoqian113@gmail.com>,
	Ionela Voinescu <ionela.voinescu@arm.com>, rafael@kernel.org,
	viresh.kumar@linaro.org, cristian.marussi@arm.com,
	arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: scpi: compare against frequency instead of rate
Message-ID: <8ebf8f26-c3d9-43c0-b417-ce3131a84eb4@stanley.mountain>
References: <20250123075321.4442-1-zuoqian113@gmail.com>
 <ad11dfc1-5e88-4421-b427-3955d4220133@stanley.mountain>
 <Z5IzMhTOhtujyH0n@bogus>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z5IzMhTOhtujyH0n@bogus>

On Thu, Jan 23, 2025 at 12:16:50PM +0000, Sudeep Holla wrote:
> (for some reason I don't have the original email)
> 
> On Thu, Jan 23, 2025 at 02:12:14PM +0300, Dan Carpenter wrote:
> > On Thu, Jan 23, 2025 at 07:53:20AM +0000, zuoqian wrote:
> > > The CPU rate from clk_get_rate() may not be divisible by 1000
> > > (e.g., 133333333). But the rate calculated from frequency is always
> > > divisible by 1000 (e.g., 133333000).
> > > Comparing the rate causes a warning during CPU scaling:
> > > "cpufreq: __target_index: Failed to change cpu frequency: -5".
> > > When we choose to compare frequency here, the issue does not occur.
> > > 
> > > Signed-off-by: zuoqian <zuoqian113@gmail.com>
> > > ---
> > >  drivers/cpufreq/scpi-cpufreq.c | 5 +++--
> > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/cpufreq/scpi-cpufreq.c b/drivers/cpufreq/scpi-cpufreq.c
> > > index cd89c1b9832c..3bff4bb5ab4a 100644
> > > --- a/drivers/cpufreq/scpi-cpufreq.c
> > > +++ b/drivers/cpufreq/scpi-cpufreq.c
> > > @@ -39,8 +39,9 @@ static unsigned int scpi_cpufreq_get_rate(unsigned int cpu)
> > >  static int
> > >  scpi_cpufreq_set_target(struct cpufreq_policy *policy, unsigned int index)
> > >  {
> > > -	u64 rate = policy->freq_table[index].frequency * 1000;
> > 
> > policy->freq_table[index].frequency is a u32 so in this original
> > calculation, even though "rate" is declared as a u64, it can't actually
> > be more than UINT_MAX.
> >
> 
> Agreed and understood.
> 
> > > +	unsigned long freq = policy->freq_table[index].frequency;
> > >  	struct scpi_data *priv = policy->driver_data;
> > > +	u64 rate = freq * 1000;
> >
> > So you've fixed this by casting policy->freq_table[index].frequency
> > to unsigned long, which fixes the problem on 64bit systems but it still
> > remains on 32bit systems.  It would be better to declare freq as a u64.
> >
> 
> Just trying to understand if that matters. freq is in kHz as copied
> from policy->freq_table[index].frequency and we compare it with
> kHZ below as the obtained clock rate is divided by 1000. What am I
> missing ? If it helps, it can be renamed as freq_in_khz and even keep
> it as "unsigned int" as in struct cpufreq_frequency_table.
> 


I misunderstood the integer overflow bug because I read too much into the
fact that "rate" was declared as a u64.  It would have been fine to
declare it as a unsigned long.  The cpufreq internals don't support
anything more than ULONG_MAX.  I have heard someone say that new systems
are bumping up against the 4GHz limit but presumably that would only be
high end 64bit systems, not old 32bit system.

The ->freq_table[] frequency is in kHz so a u32 is fine.  I guess if we
get frequencies of a THz then we'll have to update that.  But when we
convert to Hz then we need a cast to avoid an integer overflow for systems
which are over the 4GHz boundary.

	unsigned long rate = (unsigned long)khz * 1000;

The second bug is that we need to compare kHz instead of Hz and that's
straight forward.

regards,
dan carpenter


