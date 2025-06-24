Return-Path: <linux-pm+bounces-29417-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DF069AE5954
	for <lists+linux-pm@lfdr.de>; Tue, 24 Jun 2025 03:42:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 765117A9A09
	for <lists+linux-pm@lfdr.de>; Tue, 24 Jun 2025 01:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC6461A7045;
	Tue, 24 Jun 2025 01:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="ki72FuPL"
X-Original-To: linux-pm@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91C01946DF;
	Tue, 24 Jun 2025 01:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750729342; cv=none; b=XH5x6Ne54l4TzK3bqWH7gBcf4hcX4UJfSvHdiAWcnNtUZSjpfV2QkX20N1l6cUS8jz4rIRgVIl3GfmSR+Ms5dGdpU7R21KmCavZnoFOfjzvd0/7GQsPGaOVsubpitoGXGEyGyooG83a55PuPY14lQ4ciEHn8kVReiIUk647X51Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750729342; c=relaxed/simple;
	bh=VvHo+YvNoQIsmPh60/IV+ZW7D+ewbHAD+Igs22VFyiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mIJIQzpDbCtqUqMxpkgseFLwlCx/YG4oQY/kKWwoucN///F9+zqNV5Me1TaAgOmkM268XRhdQ5FZ9hcikmf0APUBvKufGgYB5YotPWf5Dj4UAf60oyS1APhCOVXyJn0ea8CFTzjqycu7x+qq4gRSumlJ30gKzo8zx9awzRr5HG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=ki72FuPL; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id E3AB325C6F;
	Tue, 24 Jun 2025 03:42:17 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id utfTtbN02bci; Tue, 24 Jun 2025 03:42:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1750729337; bh=VvHo+YvNoQIsmPh60/IV+ZW7D+ewbHAD+Igs22VFyiU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ki72FuPLBOfAtePC6++zcN8NdKRRgiTwtJhpgk0ZmmIMFXCAQ5qWdUQctsFEkdb7p
	 5c1CIOqYjUzJ41YBo+E8h2HfHZIvcuSgtu/pgFhoJXssT9eJpETXyj1sgALC+EhUZR
	 mFz40Ai23IH4QhCfJdRMhrqv10FbbKXXQu9PUIcPMkXNRl0+OS5CRJw9eICyHVJFMw
	 m8AcyoeoNercj02VbGoAYgedYPvoh/86KF/v3m3sb+GmYoOKOBQ7tUv19h5sV0UBCT
	 g2vPCMegKTNnOsJ9F7m9f/xY8Jp3l6x3nJx3+NgjTWWb/e8wgVkDaT6t1ttrd8TIZZ
	 25mbcJD6YG03Q==
Date: Tue, 24 Jun 2025 01:42:00 +0000
From: Yao Zi <ziyao@disroot.org>
To: Xi Ruoyao <xry111@xry111.site>, Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar	 <viresh.kumar@linaro.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, Mingcong Bai <jeffbai@aosc.io>,
	Kexy Biscuit <kexybiscuit@aosc.io>, loongarch@lists.linux.dev,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: loongson3: Support older SMC firmware
Message-ID: <aFoCaKrOcf-yIard@pie.lan>
References: <20250623123321.5622-1-ziyao@disroot.org>
 <9246b226e356ea0db044a592fed8853dd593f7f7.camel@xry111.site>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9246b226e356ea0db044a592fed8853dd593f7f7.camel@xry111.site>

On Mon, Jun 23, 2025 at 10:59:50PM +0800, Xi Ruoyao wrote:
> On Mon, 2025-06-23 at 12:33 +0000, Yao Zi wrote:
> 
> /* snip */
> 
> > -static struct cpufreq_driver loongson3_cpufreq_driver = {
> > +static struct cpufreq_driver loongson3_cpufreq_smc0_driver = {
> >  	.name = "loongson3",
> 
> How about using different names for the drivers?

I don't have a strong opinion on the name since it could be considered
in both ways,

- SMCv0 and SMCv1 provide similar functions and are implemented in the
  same driver. The firmware version is already printed in the probe
  callback, which should be enough for debugging purpose.
- Meanwhile, loongson3_cpufreq_smc0_driver and
  loongson3_cpufreq_smc1_driver ARE different sets of callbacks,
  different names may avoid future confusion.

I'm willing to provide different names in v2 unless you change your mind
or there're further objections, thanks.

> >  	.flags = CPUFREQ_CONST_LOOPS,
> > -	.init = loongson3_cpufreq_cpu_init,
> > +	.init = loongson3_cpufreq_cpu_smc0_init,
> >  	.exit = loongson3_cpufreq_cpu_exit,
> >  	.online = loongson3_cpufreq_cpu_online,
> >  	.offline = loongson3_cpufreq_cpu_offline,
> > -	.get = loongson3_cpufreq_get,
> > -	.target_index = loongson3_cpufreq_target,
> > +	.target_index = loongson3_cpufreq_smc0_target,
> > +	.verify = cpufreq_generic_frequency_table_verify,
> > +	.suspend = cpufreq_generic_suspend,
> > +};
> > +
> > +static struct cpufreq_driver loongson3_cpufreq_smc1_driver = {
> > +	.name = "loongson3",
> 
> Tested on a 3A6000 laptop with the schedutil policy.  On idle one core
> is at 2000MHz and other cores are at 250MHz, when building the kernel
> all cores are at 2000MHz.
> 
> Tested-by: Xi Ruoyao <xry111@xry111.site>
> 
> -- 
> Xi Ruoyao <xry111@xry111.site>
> 

Regards,
Yao Zi

