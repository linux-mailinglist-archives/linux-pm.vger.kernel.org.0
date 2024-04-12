Return-Path: <linux-pm+bounces-6314-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A60928A2C54
	for <lists+linux-pm@lfdr.de>; Fri, 12 Apr 2024 12:29:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62D5A2820AA
	for <lists+linux-pm@lfdr.de>; Fri, 12 Apr 2024 10:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AA4653384;
	Fri, 12 Apr 2024 10:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zIqo32Hl"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37FF953E0C
	for <linux-pm@vger.kernel.org>; Fri, 12 Apr 2024 10:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712917740; cv=none; b=jdqBJGnuzPF/sTteZih8NUC0j7ODG81BXSkSUBhOZTMZ2jQVMEuTHBHNmS7VsdvEV1CHuy+ujrtkqj55BGOl6gUWYBlP7UKJFJ9fAN0KQdTcsuykFnY4ELWkm5Lpc+1jhk1HHHlE8hVx+JCvOJzL/B7YptHahjw9pEScrEJMPH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712917740; c=relaxed/simple;
	bh=07V4dIIYHErzrufrKisSjuWCUcxaXJQk98wQ+x0QmRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P033CLChe9V8xphtc2f6I0IV7E2p5zvpjLjgcWT+F5aRtUK4XGh9mt9Q6omCSb1lR3FAUM+U7ZdTWjzD/+kL9AElRAVdNg0NqA52lqCXu8CHO3voK3mejdBXloe0OIdk5LT8twXrE5kgiSQ+3k10WOEDbMQoUuIGCY9+spHvrac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zIqo32Hl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20801C113CC;
	Fri, 12 Apr 2024 10:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712917739;
	bh=07V4dIIYHErzrufrKisSjuWCUcxaXJQk98wQ+x0QmRE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=zIqo32HltE8+nc5pXVbPZ5L2maTu2wY8O3De029Cp4dOmqdj7NpHNtdhT/QWVNwSY
	 rCi5JauYFXkbn4+pVRaivDwsJDRlrloDdBz5uZAWN5ml+97Zblo2weCbxJdHOkE6Cr
	 LqyqToMnwf/bkZow0QyqUjaxPnR4Lfu7UkNmHIxk=
Date: Fri, 12 Apr 2024 12:28:56 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: lizhe <sensor1010@163.com>,
	"grygorii.strashko" <grygorii.strashko@ti.com>,
	"gregory.clement" <gregory.clement@bootlin.com>,
	"grant.likely" <grant.likely@secretlab.ca>,
	bsegall <bsegall@google.com>, broonie <broonie@kernel.org>,
	bristot <bristot@redhat.com>, brgl <brgl@bgdev.pl>,
	"f.fainelli" <f.fainelli@gmail.com>,
	"fancer.lancer" <fancer.lancer@gmail.com>,
	festevam <festevam@gmail.com>, Finn Thain <fthain@linux-m68k.org>,
	rafael <rafael@kernel.org>, linux-pm <linux-pm@vger.kernel.org>
Subject: Re: [PATCH] cpufreq: exit() callback is optional
Message-ID: <2024041259-ranking-aeration-29f8@gregkh>
References: <b97964653d02225f061e0c2a650b365c354b98c8.1712900945.git.viresh.kumar@linaro.org>
 <5759bc29.32d04.18ed0ef5037.Coremail.sensor1010@163.com>
 <20240412062407.ntahibzv6xsbrnxs@vireshk-i7>
 <1b53a162.32e95.18ed0fdb13e.Coremail.sensor1010@163.com>
 <20240412063246.tk5z245miakbxws4@vireshk-i7>
 <2117690204.533771.1712904398042.JavaMail.root@mail-tracker-145-3ep34-c9h23-5f64cf7787-82gdh>
 <2024041212-bony-emphasize-75dd@gregkh>
 <663acff5.349d4.18ed18da6ff.Coremail.sensor1010@163.com>
 <20240412092108.xuvrfd6ioszltonf@vireshk-i7>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240412092108.xuvrfd6ioszltonf@vireshk-i7>

On Fri, Apr 12, 2024 at 02:51:08PM +0530, Viresh Kumar wrote:
> On 12-04-24, 17:05, lizhe wrote:
> > I found it first and submitted it to the main line first. Please be fair and just. Let him withdraw his patch.
> 
> Well, I decided not to reply to your emails anymore but this needs to
> be clarified a bit now.
> 
> You sent a lot of patches, over and over again and it was a mess. I
> saw the this [1] series first and went over to read the code and fixed
> an issue which I found (by the $subject patch).
> 
> Later I read your other patch [2], which I Acked roughly two hours
> back and yes you did send a patch that fixed the problem partially. I
> never saw it earlier, which is okay and it happens. Despite me giving
> an Ack to your patch, you have sent half-a-dozen more emails..
> 
> Then I posted a newer version of my patch some time back, removing the
> bits you already fixed [3].
> 
> That is all one side of the story. But all the noise you have created
> here has really demotivated people to review your stuff now.
> 
> --
> Viresh
> 
> [1] https://lore.kernel.org/all/20240410132132.3526-1-sensor1010@163.com/
> [2] https://lore.kernel.org/all/20240411231818.2471-1-sensor1010@163.com/
> [3] https://lore.kernel.org/all/68294ce534668c6ab3b71a1b3e6650227c6e1f20.1712911186.git.viresh.kumar@linaro.org/

Thanks for the links, I don't see that you did anything wrong here at
all.

Lizhe, you seem to be confused as to how kernel development works.  I
suggest you take some time off and read up on how this all is supposed
to happen and then work with some local people, in person, to get this
figured out first, before submitting changes again.

thanks,

greg k-h

