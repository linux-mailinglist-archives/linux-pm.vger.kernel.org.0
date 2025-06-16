Return-Path: <linux-pm+bounces-28773-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCCE9ADA737
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 06:39:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 551D016CB60
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 04:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9701B1A23A9;
	Mon, 16 Jun 2025 04:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="Gj8Zd8UD"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B583D193077
	for <linux-pm@vger.kernel.org>; Mon, 16 Jun 2025 04:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750048740; cv=none; b=Xpg2YT6lh8TQQxXBeIhcJszTWc0Sb0L42SfuCvbdrAgd3TN3v+aI8XEGcZov236Rm+q/EZIX8j0tdgZUTZsiLt5Fv5Aff8RJ63QhWF0XthFA30u8ozJClcOX+NzC3ABLk99CdNBKatz3kqbttK10i2vOb8i864Lxn5A1uXaR3W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750048740; c=relaxed/simple;
	bh=ukMrFs54obPST5gEbpIZADkYDnuDNh1MUH1aN8jHv6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ADpxPF7jFzNvRSWs5PzoNGYk5oEHGIr1RDgNgP/bNMb62ZUxP8ByIULG45K+1vgxQ/W1NmfB/2QYlkJS8rnZBH9frJ74wlpGclcsLfRjYZj4sfDkebTM8hco/ENxiRBlBPZbwUVGPAzfDIoyLYGqApETRWA/nGTW5lTs/AqC7Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=Gj8Zd8UD; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-31223a4cddeso2915681a91.1
        for <linux-pm@vger.kernel.org>; Sun, 15 Jun 2025 21:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1750048738; x=1750653538; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QeDMCjmT243+ImCsN5aSe2LSuaW52Izp8hB4w8uj3WA=;
        b=Gj8Zd8UDNWy+ayVNGHdEHfFsIh1c/Cr+fB4YW8wgkS3VcX79JAc1wDCdXZjZRB5KBr
         Rld+oetOU4EV6HdJBvRbG9DKny19jXe9MoLqW87CfOxmXDMps589vq6U2CDYKCGY0W1a
         lJooWQRvr1nvKcozznuMhXeMxDHJFAmiu6S98IMpzpJDn+uZs5FH+Ml78DDDi4uTh2LC
         4vcrF/nJULyKIzEEDzWRTQP/FyzXlCmE0MWe/Oh2uIXFIwccldxWB1g4dbEnmVwc8zAT
         icvnkHQM68ZmHdZhEDCAnnPLXrQGDbdW+sTvnVRviw84DKH1q6eI6vQaelbrdEjjG+Bo
         lDyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750048738; x=1750653538;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QeDMCjmT243+ImCsN5aSe2LSuaW52Izp8hB4w8uj3WA=;
        b=WP6aWHvOGCOLDRHjIPrgmwEK9B6D/+IQd/kRWq19jz/5kqYM7sFwa6P5+g4lGaJBuw
         gWDYvfgkkX4tr//sudOF6J4BRgmz4NDyb26TMZ9tleaULVcoPpERmNR+8rIn1h4GpKXt
         zGrxBceEaSi/5v28N71bYpD2yN7Jh4DAaMs3c5IevA6FzxUWhApNZrx10aIrNopZsjFI
         o5n803qL2F2J8iq+u28uhYb9veSxxjwObRlBqT8bmJghB0vi1hVOfe1uXCTrPD2VtV69
         tjBnQukNjzi230BgCXU7jdLFni510XEl4iChYsyqS+O/MEUAI2FbegIq67dNFcXrVHTg
         st4A==
X-Forwarded-Encrypted: i=1; AJvYcCWYaWiC2fD9ECvbk3Xy4m7oMdxFBynsI7CiEe12ncKTP/lKLWoDfap4b46i7gBbCFn2HqDqJXFO1A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwOL5RB6EoJm4EfEXs4zbHYMV/hFWXJNcwnQ98hDvfjT43kWchl
	zDVEZWqsRAX6taV6Y9Iq0wMHkx24QskyIo/o0omgOR79j3waBr6qPT2AuCcOBQElLmQ=
X-Gm-Gg: ASbGncs2mPmDw9LDiVKb/fCwuQ8spfQeQSPXxlxO0QbumsG10kPD0jl6dgJUHIMM7gu
	5zLzG3hBzOsD/hYfjgZigydQ4DX3piNMunVPd5/wFwRDzuSm5WNlpxUw8y1kviaG+dbevMqQp8R
	HrOky6bVVdr/Ch3SihHA5NvcaYkZpUEl1Y16RioeiUrNOx3g30qzhswEDgqssxyTYXxgfioV3L4
	w+IqRefl+uASksLBihGVhhKFSDUKT4kE4VpFfD2W0bwXecaQeDawALLC9W/l9eD/ibXYvnLuLGd
	EygjUjzM5NN3JfLes/apgivWhfeU5C0tfjlLa/4r0HBxtd/ZPzVQ80TcN54Aeq02uZ7/b4YOlxN
	EAFpBCyvVo5HIlp8AP1WTqwn4ObudeVo=
X-Google-Smtp-Source: AGHT+IFoxN4G3980gIVK0np5tw1fQkp1JKCmZrSoIiC5wwrCJivYrHj/DKmD4vFX3iCyAyCKzILJmA==
X-Received: by 2002:a17:90b:2dd0:b0:313:287c:74bd with SMTP id 98e67ed59e1d1-313f1d10aaamr15121787a91.33.1750048737766;
        Sun, 15 Jun 2025 21:38:57 -0700 (PDT)
Received: from mozart.vkv.me (192-184-162-253.fiber.dynamic.sonic.net. [192.184.162.253])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-313c1bd9ae1sm8569187a91.18.2025.06.15.21.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Jun 2025 21:38:57 -0700 (PDT)
Date: Sun, 15 Jun 2025 21:38:55 -0700
From: Calvin Owens <calvin@wbinvd.org>
To: "Zhang, Rui" <rui.zhang@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"lenb@kernel.org" <lenb@kernel.org>
Subject: Re: [PATCH] tools/power turbostat: Fix MSRs with CONFIG_MULTIUSER=n
Message-ID: <aE-f35kOO0TywX5K@mozart.vkv.me>
References: <81f4c402d1fda7c2419aac1148061a0789112e76.1749849645.git.calvin@wbinvd.org>
 <99f09d35e30fa335508823e9848a3365936ac9b3.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <99f09d35e30fa335508823e9848a3365936ac9b3.camel@intel.com>

On Monday 06/16 at 01:30 +0000, Zhang, Rui wrote:
> On Fri, 2025-06-13 at 19:20 -0700, Calvin Owens wrote:
> > Handle ENOSYS from cap_get_proc() in check_for_cap_sys_rawio(), so
> > turbostat can display temperatures when running on kernels compiled
> > without multiuser support.
> > 
> > Signed-off-by: Calvin Owens <calvin@wbinvd.org>
> > ---
> >  tools/power/x86/turbostat/turbostat.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/power/x86/turbostat/turbostat.c
> > b/tools/power/x86/turbostat/turbostat.c
> > index 925556b90770..f7d665913a52 100644
> > --- a/tools/power/x86/turbostat/turbostat.c
> > +++ b/tools/power/x86/turbostat/turbostat.c
> > @@ -6496,8 +6496,13 @@ int check_for_cap_sys_rawio(void)
> >  	int ret = 0;
> >  
> >  	caps = cap_get_proc();
> > -	if (caps == NULL)
> > +	if (caps == NULL) {
> > +		/* Support CONFIG_MULTIUSER=n */
> > +		if (errno == ENOSYS)
> 
> Can you point me where this knowledge comes from?
> 
> I downloaded the libcap source and didn't see how ENOSYS is set.

Hi Rui,

When the kernel is built without multiuser support, the capget() et al.
syscalls are #ifdef'd out:

    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/capability.c#n32

...so userspace will get -ENOSYS when it tries to call them, and that
ends up being propagated to errno in userspace.

Admittedly it is sort of implicit. Maybe a better way to "fix" this
would be to warn the user if the capability check fails, but still
attempt to access the MSR devices? I can do that if you prefer.

That is my only problem here: when check_for_cap_sys_rawio() fails, the
current code doesn't attempt to access the MSR devices at all, even
though in my case it would actually work.

I realize this is very weird: it came up when I was recently including
turbostat as part of an extremely tiny bootable utility image.

Thanks,
Calvin

> thanks,
> rui
> > +			return 0;
> > +
> >  		return 1;
> > +	}
> >  
> >  	if (cap_get_flag(caps, CAP_SYS_RAWIO, CAP_EFFECTIVE,
> > &cap_flag_value)) {
> >  		ret = 1;
> 

