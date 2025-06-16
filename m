Return-Path: <linux-pm+bounces-28774-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 078DDADA73C
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 06:44:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9054188EDBF
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 04:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C2A1A5B8C;
	Mon, 16 Jun 2025 04:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="PX43daP8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DDAD7262B
	for <linux-pm@vger.kernel.org>; Mon, 16 Jun 2025 04:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750049083; cv=none; b=c19osX/s2Kyclrxk7oFD0JsyVbp2iIHq2bjX3W0xUgSmU+xPrxiad7Q0/PmbUAixY5zN9e3rP5wZgasrPA8QGnOCKfWbNFTxhnOE5WV/xOnX+wdbM5NJ4xLg+1dEGp2re1mwr2+KnzkwkdP9Qzxz8K4XDJdYMSO9KqZ9PTzWaKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750049083; c=relaxed/simple;
	bh=Ql1n+4jUxnOtoX7FKD8Mc3RaJicHFobkF1KXH7F9hn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GZQ/U/9athzmUvWryDD+jWaik2g4Tlloa5uvciZH2xYAIEcyI1iOpuZx7isGOOmO8rKXW5boc/kuODf2eG6QL8JeXctlPEFWUPVgLwgFhNUIbMtubWaiONHCyUX9bIH08Of2gKORGX4l8BbWZda7LSculKwo7YYH7614WkHIZYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=PX43daP8; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7425bd5a83aso3442376b3a.0
        for <linux-pm@vger.kernel.org>; Sun, 15 Jun 2025 21:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1750049081; x=1750653881; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gx/8eoHL8Kyw56Icq4f/cXQzirpUgPz3h2cjfH8G+5s=;
        b=PX43daP8SWtEVJJGIC3RkLS/wlhX98x6hr+Ub7PG53G8YOrqk6/Be5pOzpxDxU8jSJ
         YrpDhUpPBqxUbCUBaqw6B/le86vUxEBRHIC4a15XqrV+L/TGtVUQQof+AKQgpw55ait+
         91NI495+dzS9+M/e7TRMY+YSb8UZJUEFKWbbqMBNHSvJbvA63xeHZkxiEm3KgkzLGqF/
         RZmkrnyhmXO469dBHgQoxvkacSfcSc664WH5x0VkZzyGiD2kzdwzxYF5xkeKckcH2wVL
         PBcUfZ1DpCr5laNy1cSfwDGBh8to0ZmAitpPIwnst7EVNuvJS7OM/69mUlxuJYnK+yT/
         fE2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750049081; x=1750653881;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gx/8eoHL8Kyw56Icq4f/cXQzirpUgPz3h2cjfH8G+5s=;
        b=BdOQVpnyyZ6aA+9UZmBgcz/ji+cshRZIKfUF7rIfxcOz75jZNcUA9L6OMh9cG8WDba
         ANwC5mEH8CB0RGkyvJMGmQDqD3lGl6w/CiIqJWuM95amrf6Dw0rSlcfPabJ2xqDcit24
         rkcf8len7xlVpoEOrO60FdysE8QXezKvcR6vnjEOt5mIowvbXwI4ZBVyz4eXAIoeFfun
         QoZMRv6T3OV4qC9bd7HauJoOR6Tpjblt/cH91rcc4akl4NbVLxlpvYxfFPmpEdD7Gcyw
         w17Vo5yuTpHzQ2/9oON+KCWtWyu5+iGB/VfE0gRrrzwDoMrOsl/03uurWugcSM9OLG/k
         uNgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVyeWFQNX4FwEeN9uUJZwPMlun1/ItPdrH6FT+xdvE42+wcSntvU1baHjWHLVPZGyrjuzTu6/M5qw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxFtjDn9PBb7syAQ2h/3fVT7UBRSfu10PeRTMOxYH8iUut0dSu0
	FmnTMmyNTl9pvBOaNp4M47vpHDaoCHb9ykIR2ufbjieWhEr5Yy/j3hNnTsOnyAJN9YQ=
X-Gm-Gg: ASbGncsmS6oZ6E5AHbY6jcTZtLZFMYQVi0cQewkbDZnEUzNKxSfNqwKapdbfcEXikC/
	vBgb8VE+vp29/9ZDCtvUNbYF0g48P049hHEFnnTi0hNqkmYvSW8cxO8KcFaSaBPN0L/aV4IMeQr
	VqVY+CkA7YCksV0D6nxmyrBSxIelibIXx9m/GbraYGYnea+7SeS2xGOj2p5Y6f1SLKlHV24d+nQ
	189+Kc+CqI25bx/uftTzQRYIdMDi1KU5bNkCl4sQhTOs5JNWtzUwftJz1jX10hk+5SBSefZpqRe
	/KR2U3cSrwnLRbSd9VpCF4EnMeGmuvZwn9odKSFFQg+vfpFoG+tNY89Hi0M0cZuCisTRChrByLH
	dIHykOLwQQQYe8kf0YA07YSDG2PnKljs=
X-Google-Smtp-Source: AGHT+IEPckFcFtldN4ccAXqEziO/DNLijHVnM7HrhF08iZR3CHfDjHXQRjSASarfx6qpCIhG77IwIQ==
X-Received: by 2002:a05:6a00:3d10:b0:740:aa31:fe66 with SMTP id d2e1a72fcca58-7489ce0d39fmr10409001b3a.4.1750049081300;
        Sun, 15 Jun 2025 21:44:41 -0700 (PDT)
Received: from mozart.vkv.me (192-184-162-253.fiber.dynamic.sonic.net. [192.184.162.253])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-748900d24c6sm5758990b3a.168.2025.06.15.21.44.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Jun 2025 21:44:40 -0700 (PDT)
Date: Sun, 15 Jun 2025 21:44:38 -0700
From: Calvin Owens <calvin@wbinvd.org>
To: "Zhang, Rui" <rui.zhang@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"lenb@kernel.org" <lenb@kernel.org>
Subject: Re: [PATCH] tools/power turbostat: Fix MSRs with CONFIG_MULTIUSER=n
Message-ID: <aE-hNs1bWTbqE6ih@mozart.vkv.me>
References: <81f4c402d1fda7c2419aac1148061a0789112e76.1749849645.git.calvin@wbinvd.org>
 <99f09d35e30fa335508823e9848a3365936ac9b3.camel@intel.com>
 <aE-f35kOO0TywX5K@mozart.vkv.me>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aE-f35kOO0TywX5K@mozart.vkv.me>

On Sunday 06/15 at 21:38 -0700, Calvin Owens wrote:
> On Monday 06/16 at 01:30 +0000, Zhang, Rui wrote:
> > On Fri, 2025-06-13 at 19:20 -0700, Calvin Owens wrote:
> > > Handle ENOSYS from cap_get_proc() in check_for_cap_sys_rawio(), so
> > > turbostat can display temperatures when running on kernels compiled
> > > without multiuser support.
> > > 
> > > Signed-off-by: Calvin Owens <calvin@wbinvd.org>
> > > ---
> > >  tools/power/x86/turbostat/turbostat.c | 7 ++++++-
> > >  1 file changed, 6 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/tools/power/x86/turbostat/turbostat.c
> > > b/tools/power/x86/turbostat/turbostat.c
> > > index 925556b90770..f7d665913a52 100644
> > > --- a/tools/power/x86/turbostat/turbostat.c
> > > +++ b/tools/power/x86/turbostat/turbostat.c
> > > @@ -6496,8 +6496,13 @@ int check_for_cap_sys_rawio(void)
> > >  	int ret = 0;
> > >  
> > >  	caps = cap_get_proc();
> > > -	if (caps == NULL)
> > > +	if (caps == NULL) {
> > > +		/* Support CONFIG_MULTIUSER=n */
> > > +		if (errno == ENOSYS)
> > 
> > Can you point me where this knowledge comes from?
> > 
> > I downloaded the libcap source and didn't see how ENOSYS is set.
> 
> Hi Rui,
> 
> When the kernel is built without multiuser support, the capget() et al.
> syscalls are #ifdef'd out:
> 
>     https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/capability.c#n32
> 
> ...so userspace will get -ENOSYS when it tries to call them, and that
> ends up being propagated to errno in userspace.

Sorry, what I meant was: the kernel syscall returns -ENOSYS to
userspace, and the syscall() wrapper (in userspace) assigns the positive
error value to errno, where it remains after cap_get_proc() returns.

> Admittedly it is sort of implicit. Maybe a better way to "fix" this
> would be to warn the user if the capability check fails, but still
> attempt to access the MSR devices? I can do that if you prefer.
> 
> That is my only problem here: when check_for_cap_sys_rawio() fails, the
> current code doesn't attempt to access the MSR devices at all, even
> though in my case it would actually work.
> 
> I realize this is very weird: it came up when I was recently including
> turbostat as part of an extremely tiny bootable utility image.
> 
> Thanks,
> Calvin
> 
> > thanks,
> > rui
> > > +			return 0;
> > > +
> > >  		return 1;
> > > +	}
> > >  
> > >  	if (cap_get_flag(caps, CAP_SYS_RAWIO, CAP_EFFECTIVE,
> > > &cap_flag_value)) {
> > >  		ret = 1;
> > 

