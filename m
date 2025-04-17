Return-Path: <linux-pm+bounces-25608-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 127F1A91592
	for <lists+linux-pm@lfdr.de>; Thu, 17 Apr 2025 09:46:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CEE13BFF80
	for <lists+linux-pm@lfdr.de>; Thu, 17 Apr 2025 07:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C951DB37B;
	Thu, 17 Apr 2025 07:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EGN6brhj"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC88A937;
	Thu, 17 Apr 2025 07:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744875983; cv=none; b=oq7lMUh8sBeMDOeBG98HCC3pFruYKq30GkfhmrnCUBRrpjvtA4PF0I5bAVsI1TlhukU6Ikwug4oHQ3KM4KvKPzcKGnHJ8ycZXvqOvryOkjLBGmJ47NkgjxSTzTd4BUPoS4xJ7SgeDmkVQ5aByxJUsQrqcO0gB9kGlYCHlYTNqNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744875983; c=relaxed/simple;
	bh=aVH9/RoovkU8v4WklJXZULaKkSsySrY6Xc4+YksCzr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d0//buBXPxAFKkRvRc3Y227tH0/qYghsK5weaVquSghdeAlNH5xuUnkPat/Pp86Rv9RgEE/v1FupWYhUd2J27clyHJ/3e9nSATFTcG9eMY/tcvYv4dLXVU5UIVX87t20EY3x/gfDiv3gcxZcCNpqJNF2KQXJyi156yA3/JRLvQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EGN6brhj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48E33C4CEE7;
	Thu, 17 Apr 2025 07:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744875982;
	bh=aVH9/RoovkU8v4WklJXZULaKkSsySrY6Xc4+YksCzr0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EGN6brhjfp3LgOEiWPYOOUaubua4z6Rr87Qix91C4cn0+ZeKhbehrA36p2YRJOMcU
	 nPw9J2JjVyFswd5XI1lOe10RAV9sXj1r2E5s82GgPmLUSUxo5qqtk+cYpCuR6oPZyU
	 ERyQzBpZrZOBNs5P4QpMvCQgRoyfN/yjYPdCDu3lmq7BlGmoBitobBGZfnawRDUWp8
	 HiPejRvX8Lc4pyRNl4pPFQTRF64LPkG1U9h0+Vk77gSBCKgB5U6DI15LHeqx3hpCxE
	 0lHBv9uFdbDAoEVdY/Y/d26kDe6GXPcx0YneInAzT739pyHKhyv5SLkm5/zhsnZlu4
	 dC8rraFQpi++Q==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1u5Jwz-000000000Z9-2KLU;
	Thu, 17 Apr 2025 09:46:22 +0200
Date: Thu, 17 Apr 2025 09:46:21 +0200
From: Johan Hovold <johan@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Johan Hovold <johan+linaro@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	"Rob Herring (Arm)" <robh@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] cpufreq: fix compile-test defaults
Message-ID: <aACxzWi4KqDdylfj@hovoldconsulting.com>
References: <20250417065535.21358-1-johan+linaro@kernel.org>
 <a0739b6b-b043-47f1-8044-f6ed68d39f2c@linaro.org>
 <aACsQUADxYHTQDi1@hovoldconsulting.com>
 <f957e366-51e1-4447-982c-93374d0fde2e@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f957e366-51e1-4447-982c-93374d0fde2e@linaro.org>

On Thu, Apr 17, 2025 at 09:28:43AM +0200, Krzysztof Kozlowski wrote:
> On 17/04/2025 09:22, Johan Hovold wrote:

> >>> Fix the default values for drivers that can be compile tested and that
> >>> should be enabled by default when not compile testing.
> >>>
> >>> Fixes: 3f66425a4fc8 ("cpufreq: Enable COMPILE_TEST on Arm drivers")
> >>
> >>
> >>> Fixes: d4f610a9bafd ("cpufreq: Do not enable by default during compile testing")
> >>
> >> That's not correct tag - it introduced no new issues, did not make
> >> things worse, so nothing to fix there, if I understand correctly.
> > 
> > Fair enough, I could have used dependency notation for this one.
> > 
> > Let me do that in v3.
> 
> OK. I have doubts that this should be marked as a fix in the first place
> - even skipping my commit. Some (several?) people were always
> considering COMPILE_TEST as enable everything, thus for them this was
> the intention, even if it causes such S3C64xx cpufreq warnings:
> 
> https://lore.kernel.org/all/8b6ede05-281a-4fb1-bcdc-457e6f2610ff@roeck-us.net/

Sounds like you, me and Arnd and least have the same understanding of
how COMPILE_TEST should work.

I use it all the time when fixing issues that have been reproduced in
several drivers which I then enable manually. And I usually keep them
enabled in my development kernels for a while after in case something
needs to be reworked.

If you want to compile everything as well you should do an allmodconfig
build.

> I had also talks about this in the past that one should never boot
> compile test kernel.

I have never noticed any issues with that until the other day with the
cpufreq driver, but yeah, I can imagine that other "default y" entries
could potentially cause issues.

Johan

