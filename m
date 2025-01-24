Return-Path: <linux-pm+bounces-20938-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B5AA1B3EE
	for <lists+linux-pm@lfdr.de>; Fri, 24 Jan 2025 11:51:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DEA73A6CE9
	for <lists+linux-pm@lfdr.de>; Fri, 24 Jan 2025 10:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 958F71D14EC;
	Fri, 24 Jan 2025 10:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DAm09OYU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA281CDFC1
	for <linux-pm@vger.kernel.org>; Fri, 24 Jan 2025 10:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737715914; cv=none; b=UgwDJsq5YY9Q7gXvMSHfJ11AVnMG2EkoWftrUqIIPk2uUTo2KilQOeLQmeZZF/wdXEbS8cNuBoClpwIUkf8AtzOKiiJV+e/RFciRcpqX4J5D0tLFLb5FFP9zNCQvZAHg3KMSa923eak6NcuowZGhTj2fPmC1dyKrCNR25sJPZUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737715914; c=relaxed/simple;
	bh=B/1l3tdtCZ9PRYzReDHc6UkLBAY6SnrhKfJIycn3/Gk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aYGMz/NR/DI0ZUIoshxydLMHUr0daS+xUM0aXB8BD+DQNULv/5nkAo4poqN33I7x+X+VPpLYacvOD2n5zrR++Pi7/pSagOAFIcaxDw3VVZyQQkorK7I+7tiwB+9UbnxgEnMhUbL01lHTUbDK+YsoRhaNU760AWMpn1me3EKnkKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DAm09OYU; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-385d7b4da2bso1798845f8f.1
        for <linux-pm@vger.kernel.org>; Fri, 24 Jan 2025 02:51:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737715911; x=1738320711; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tGTlLozxCo1nf43/X/aagzssis+Atz8YpkZYRRrzAY0=;
        b=DAm09OYUCJHkxonVXjZalcz4Xfmevxg5Zqdd/kDgJiSewZk0pNGS1IbP8eJB6eJ4Ma
         O1hHqlFwuq2Qvix0WsrUozye7A66428W2sKreu9KbB1FlRbwI+2zT+vauhd/V+nzT9Un
         nEY+rQkcxiNL4J179N7U1U48CuPqTsQ6mAAbzNIwzldnar0zWrWt3q7wMP/AFwGERHcl
         p8Q3f7NjNLpwVg/ca08EAEXt98gXXWTdYssTNeP5rItQzWOtk3mC/IzO3lzhl4zGVqNg
         R9/S2ylg3PtjeoFNGMW929K10yFPuS7/nliMPEvQrnxyDU/7ZuhYt2Q0rF7itsMv0HiR
         5LKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737715911; x=1738320711;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tGTlLozxCo1nf43/X/aagzssis+Atz8YpkZYRRrzAY0=;
        b=ABncTgTVVA3jRIhcoMEndrfZvFnmCoIhspQaWB6Trdnbh/t3y8x2QLRbGv9LP3Fcfp
         uWS0K2RxqCBjDwffjkU37IRLvkaQ2gXJ5ngQTLYnJk8FD+LyCuf73axNMSaWY6eyZbw+
         Ch9CE9vog/7HEjjliOaEwsvrRbniJOwv1UoBLL5lmrrkCGoQmr3iznBkFTCaNtMFYZyi
         qqASK0s0Aj/W1OaNka7gs9v3VNUv51FzxXLF2t9rOz4qD7g+L+WHfJYa3x4LFkVB1lpE
         LX0OCTxtmtSBO7Vde0oRQOP/3fUCHghWXTiaG6ahN15DFCTXUPvHWjm3GLAQgno/U4dz
         VwNw==
X-Forwarded-Encrypted: i=1; AJvYcCXs+xtpFpGJYM5T7hiTjzcdNOfG16GIYvGAXnfPMPJkpcfFNUZWcpI8p+N8FxlTjFjuDZIUB+x1HA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyLb0dHsJF2vSjMbkX6AZZM8XtlB4hgX6cvfKkdTD1QKpfo8jUW
	ZcMJeIRWZ2hpa10jMMmFrsbE8Lwma9RSmohmLVLyj/ozuwv/pbF8Q8+46udBHzs=
X-Gm-Gg: ASbGncux+jC29ClIKRo2X4piUs4mMrmHPHQl0l/ya1WfioNfccRvrWLok8bOA9emnNE
	aeiLQLQkOMVaHTFazi38jwNTVFHntU/YlRKBX7LkUTATRc2cCDb+kau6ds2PhqSveumhbWD6gC9
	vRTAi58Prjwz/PYaccJ5uhU0OIeJsOQM081bLOo5LfxiexUZ23FzhWG9zS8H/OjMRdaEj1qSBS0
	yitX/blgfS4q8k5MadLWaVP8/goXFaALGrXzV8CXKmIcJAUw1t7nkyeJv6F4VnqK8vI+pHeNWLk
	X4y/etagOw==
X-Google-Smtp-Source: AGHT+IFYQo9jNiHBgOR8bRaxcWjkfxh6Y7QIEImm5C6fb5pC+YqVIPsrpJEhp0PabuCFZK+cqqd41g==
X-Received: by 2002:a05:6000:2a6:b0:385:eb7c:5d0f with SMTP id ffacd0b85a97d-38bf566a239mr28879962f8f.26.1737715909296;
        Fri, 24 Jan 2025 02:51:49 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c2a1c418esm2332243f8f.95.2025.01.24.02.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 02:51:48 -0800 (PST)
Date: Fri, 24 Jan 2025 13:51:44 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: zuoqian <zuoqian113@gmail.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	Ionela Voinescu <ionela.voinescu@arm.com>,
	"rafael@kernel.org" <rafael@kernel.org>,
	"viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
	"cristian.marussi@arm.com" <cristian.marussi@arm.com>,
	"arm-scmi@vger.kernel.org" <arm-scmi@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cpufreq: scpi: compare against frequency instead of rate
Message-ID: <d7e5ba38-046f-49ff-8201-409756218e75@stanley.mountain>
References: <20250123075321.4442-1-zuoqian113@gmail.com>
 <ad11dfc1-5e88-4421-b427-3955d4220133@stanley.mountain>
 <Z5IzMhTOhtujyH0n@bogus>
 <8ebf8f26-c3d9-43c0-b417-ce3131a84eb4@stanley.mountain>
 <6793606d.050a0220.a73fe.0803@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6793606d.050a0220.a73fe.0803@mx.google.com>

On Fri, Jan 24, 2025 at 09:42:01AM +0000, zuoqian wrote:
> On Thu, Jan 23, 2025 at 04:04:13PM +0300, Dan Carpenter wrote:
> > On Thu, Jan 23, 2025 at 12:16:50PM +0000, Sudeep Holla wrote:
> > > (for some reason I don't have the original email)
> > > 
> > > On Thu, Jan 23, 2025 at 02:12:14PM +0300, Dan Carpenter wrote:
> > > > On Thu, Jan 23, 2025 at 07:53:20AM +0000, zuoqian wrote:
> > > > > The CPU rate from clk_get_rate() may not be divisible by 1000
> > > > > (e.g., 133333333). But the rate calculated from frequency is always
> > > > > divisible by 1000 (e.g., 133333000).
> > > > > Comparing the rate causes a warning during CPU scaling:
> > > > > "cpufreq: __target_index: Failed to change cpu frequency: -5".
> > > > > When we choose to compare frequency here, the issue does not occur.
> > > > > 
> > > > > Signed-off-by: zuoqian <zuoqian113@gmail.com>
> > > > > ---
> > > > >  drivers/cpufreq/scpi-cpufreq.c | 5 +++--
> > > > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/cpufreq/scpi-cpufreq.c b/drivers/cpufreq/scpi-cpufreq.c
> > > > > index cd89c1b9832c..3bff4bb5ab4a 100644
> > > > > --- a/drivers/cpufreq/scpi-cpufreq.c
> > > > > +++ b/drivers/cpufreq/scpi-cpufreq.c
> > > > > @@ -39,8 +39,9 @@ static unsigned int scpi_cpufreq_get_rate(unsigned int cpu)
> > > > >  static int
> > > > >  scpi_cpufreq_set_target(struct cpufreq_policy *policy, unsigned int index)
> > > > >  {
> > > > > -	u64 rate = policy->freq_table[index].frequency * 1000;
> > > > 
> > > > policy->freq_table[index].frequency is a u32 so in this original
> > > > calculation, even though "rate" is declared as a u64, it can't actually
> > > > be more than UINT_MAX.
> > > >
> > > 
> > > Agreed and understood.
> > > 
> > > > > +	unsigned long freq = policy->freq_table[index].frequency;
> > > > >  	struct scpi_data *priv = policy->driver_data;
> > > > > +	u64 rate = freq * 1000;
> > > >
> > > > So you've fixed this by casting policy->freq_table[index].frequency
> > > > to unsigned long, which fixes the problem on 64bit systems but it still
> > > > remains on 32bit systems.  It would be better to declare freq as a u64.
> > > >
> > > 
> > > Just trying to understand if that matters. freq is in kHz as copied
> > > from policy->freq_table[index].frequency and we compare it with
> > > kHZ below as the obtained clock rate is divided by 1000. What am I
> > > missing ? If it helps, it can be renamed as freq_in_khz and even keep
> > > it as "unsigned int" as in struct cpufreq_frequency_table.
> > > 
> > 
> > 
> > I misunderstood the integer overflow bug because I read too much into the
> > fact that "rate" was declared as a u64.  It would have been fine to
> > declare it as a unsigned long.  The cpufreq internals don't support
> > anything more than ULONG_MAX.  I have heard someone say that new systems
> > are bumping up against the 4GHz limit but presumably that would only be
> > high end 64bit systems, not old 32bit system.
> > 
> > The ->freq_table[] frequency is in kHz so a u32 is fine.  I guess if we
> > get frequencies of a THz then we'll have to update that.  But when we
> > convert to Hz then we need a cast to avoid an integer overflow for systems
> > which are over the 4GHz boundary.
> > 
> > 	unsigned long rate = (unsigned long)khz * 1000;
> > 
> > The second bug is that we need to compare kHz instead of Hz and that's
> > straight forward.
> > 
> > regards,
> > dan carpenter
> >
> 
> Thank you for your valuable feedback.I will make the changes to the patch and 
> resubmit it, including renaming freq and keeping it as an "unsigned int".

If you keep it as unsigned int then you will need to add a cast when you
do the "* 1000" multiplication.  Please make freq and rate both unsigned
longs.

regards,
dan carpenter


