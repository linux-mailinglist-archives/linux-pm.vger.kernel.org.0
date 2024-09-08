Return-Path: <linux-pm+bounces-13856-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED6E597082B
	for <lists+linux-pm@lfdr.de>; Sun,  8 Sep 2024 16:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEEBB1C215D7
	for <lists+linux-pm@lfdr.de>; Sun,  8 Sep 2024 14:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C589170A3A;
	Sun,  8 Sep 2024 14:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="joTKNOvL"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E944515C127;
	Sun,  8 Sep 2024 14:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725805778; cv=none; b=Y5IEmsJFezKwbL1VdH8oqw9ydiGZU8JVlm4lmCEF8Opb1Aqm6pDqTyZUyljQxjk1sa2gOhke+iGkqtlb+PKh6Y8PzCC4bqmve9zhrbpiDPze+uLvwQkvOWuPevf9qx6GFTss++4Du7nci3+N2sSGsFG6EY2aQ5oi+tZO6LO81Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725805778; c=relaxed/simple;
	bh=bZDaIE9L2S3stuNCEgJbTCe8JAXpaV/Ati1K509j9cI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ix/VzQm+nbwoh1dnHkb61hh80+Df2StvH7Rhk4ZLjXdhYAKPv7ykCpakdmsyS7OBAH+n+X0AW29eODdxJMdZkIsHLb9n3IVV44GTe8QjB+wUYWETSO+STZJu5WOfIssstJxNSyPPljxcFG9i11lEeWwTiuLYkPt1tekBWZFML9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=joTKNOvL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6027C4CEC3;
	Sun,  8 Sep 2024 14:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725805777;
	bh=bZDaIE9L2S3stuNCEgJbTCe8JAXpaV/Ati1K509j9cI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=joTKNOvL39WgbE9UNBcEcEibBRmVGU8krgg2XbjXhLXtHAGfchLFkH7CdLVIK44H7
	 rHOH5MpcfjGnzz0aa6/X+/jkHrkMT9i5DgevA+eoLPSA6RVzMjPulrqconueMXk89S
	 1mGYFMSCj5JHqXzZorbeQFOeR+ue1MGeKhBANmb0=
Date: Sun, 8 Sep 2024 16:29:34 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Christian Heusel <christian@heusel.eu>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	"Jones, Morgan" <Morgan.Jones@viasat.com>,
	Sasha Levin <sashal@kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	David Arcari <darcari@redhat.com>,
	Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	"rafael@kernel.org" <rafael@kernel.org>,
	"viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
	"gautham.shenoy@amd.com" <gautham.shenoy@amd.com>,
	"perry.yuan@amd.com" <perry.yuan@amd.com>,
	"skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
	"li.meng@amd.com" <li.meng@amd.com>,
	"ray.huang@amd.com" <ray.huang@amd.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	Linux kernel regressions list <regressions@lists.linux.dev>
Subject: Re: linux-6.6.y regression on amd-pstate
Message-ID: <2024090825-clarity-cofounder-5c79@gregkh>
References: <66f08ce529d246bd8315c87fe0f880e6@viasat.com>
 <645f2e77-336b-4a9c-b33e-06043010028b@amd.com>
 <2e36ee28-d3b8-4cdb-9d64-3d26ef0a9180@amd.com>
 <d6477bd059df414d85cd825ac8a5350d@viasat.com>
 <d6808d8e-acaf-46ac-812a-0a3e1df75b09@amd.com>
 <7f50abf9-e11a-4630-9970-f894c9caee52@amd.com>
 <f9085ef60f4b42c89b72c650a14db29c@viasat.com>
 <be2d96b0-63a6-42ea-a13b-1b9cf7f04694@amd.com>
 <2024090834-hull-unbalance-ca6b@gregkh>
 <2ffb55e3-6752-466a-b06b-98c324a8d3cc@heusel.eu>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ffb55e3-6752-466a-b06b-98c324a8d3cc@heusel.eu>

On Sun, Sep 08, 2024 at 04:12:28PM +0200, Christian Heusel wrote:
> Hey Greg,
> 
> On 24/09/08 04:05PM, Greg Kroah-Hartman wrote:
> > On Thu, Sep 05, 2024 at 04:14:26PM -0500, Mario Limonciello wrote:
> > > + stable
> > > + regressions
> > > New subject
> > > 
> > > Great news.
> > > 
> > > Greg, Sasha,
> > > 
> > > Can you please pull in these 3 commits specifically to 6.6.y to fix a
> > > regression that was reported by Morgan in 6.6.y:
> > > 
> > > commit 12753d71e8c5 ("ACPI: CPPC: Add helper to get the highest performance
> > > value")
> > 
> > This is fine, but:
> > 
> > > commit ed429c686b79 ("cpufreq: amd-pstate: Enable amd-pstate preferred core
> > > support")
> > 
> > This is not a valid git id in Linus's tree :(
> 
> f3a052391822 ("cpufreq: amd-pstate: Enable amd-pstate preferred core support")
> 
> > 
> > > commit 3d291fe47fe1 ("cpufreq: amd-pstate: fix the highest frequency issue
> > > which limits performance")
> > 
> > And neither is this :(
> 
> bf202e654bfa ("cpufreq: amd-pstate: fix the highest frequency issue which limits performance")
> 
> > So perhaps you got them wrong?
> 
> I have added the ID's of the matching commits from Linus' tree above! :)
> 

Thanks, that works, all now queued up.

greg k-h

