Return-Path: <linux-pm+bounces-4495-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C12C86A8B1
	for <lists+linux-pm@lfdr.de>; Wed, 28 Feb 2024 08:07:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4EA9B24B13
	for <lists+linux-pm@lfdr.de>; Wed, 28 Feb 2024 07:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2503822F1D;
	Wed, 28 Feb 2024 07:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="flqfirZ5"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC2122F1E;
	Wed, 28 Feb 2024 07:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709104058; cv=none; b=Ld222y3oc/4vkdpQF+JdkcQFPLCyP3zLaV07ohc7JRi27szpoVr/22t74XiyEa9E7Rl4BhhIVX8hViEWygDRbczja57v6E0zmckjfw8ZbygRutLY2e7mcIhnnHMsedYqntGdf7LZLeVjyhWoUdlQ5nh+E5NPov/0HOVFETJO+Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709104058; c=relaxed/simple;
	bh=crVUTJppSiBoHshvxxfL9ijmddEMhjmw34CMlqepejg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=odVSsBGh4mDfdLXJNGSDb75HH+ehsyE/Bb59H4kLnFaIK3rLPVwLlKfg70nqG4m9LPSTTJJ6+RxyAMBA03rzaV5AsZJupStXlWuAU9oRi8F3RuS2SxJ1XoEBC+sHl8NnQcOFoMm/nbgcJf5gZVpl5Gbaf/diSq41feMGSzCLTa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=flqfirZ5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3719C433C7;
	Wed, 28 Feb 2024 07:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709104057;
	bh=crVUTJppSiBoHshvxxfL9ijmddEMhjmw34CMlqepejg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=flqfirZ5dmPwtrZAYOyoc64thr+j+rfbqCHhiz13hSYVleFtFoaG57j3vAPc37OQp
	 LR/wKGjPDbXSjBKUiq2M0hNu50foGafScud5d5xKomEgzbMV5z0gs2q238KYG2jkdM
	 hPw06k+Je3XRQPE/TmAT2zQt2rDhf7NBuzlPb3ak=
Date: Wed, 28 Feb 2024 08:07:34 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: John Stultz <jstultz@google.com>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
	Thierry Reding <treding@nvidia.com>,
	Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Bjorn Andersson <bjorn.andersson@linaro.org>,
	Saravana Kannan <saravanak@google.com>,
	Todd Kjos <tkjos@google.com>, Len Brown <len.brown@intel.com>,
	Pavel Machek <pavel@ucw.cz>, Ulf Hansson <ulf.hansson@linaro.org>,
	Kevin Hilman <khilman@kernel.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Rob Herring <robh@kernel.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	John Stultz <john.stultz@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.4 39/84] driver core: Set deferred_probe_timeout to a
 longer default if CONFIG_MODULES is set
Message-ID: <2024022838-enrage-upheld-1529@gregkh>
References: <20240227131552.864701583@linuxfoundation.org>
 <20240227131554.144760148@linuxfoundation.org>
 <CANDhNCoGL7voc11QFt5rBXXibMSvDM2YxZ8ocV1fkGYh=Mm0nA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANDhNCoGL7voc11QFt5rBXXibMSvDM2YxZ8ocV1fkGYh=Mm0nA@mail.gmail.com>

On Tue, Feb 27, 2024 at 11:38:01AM -0800, John Stultz wrote:
> On Tue, Feb 27, 2024 at 5:27 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > 5.4-stable review patch.  If anyone has any objections, please let me know.
> >
> > ------------------
> >
> > From: John Stultz <john.stultz@linaro.org>
> >
> > [ Upstream commit e2cec7d6853712295cef5377762165a489b2957f ]
> >
> > When using modules, its common for the modules not to be loaded
> > until quite late by userland. With the current code,
> > driver_deferred_probe_check_state() will stop returning
> > EPROBE_DEFER after late_initcall, which can cause module
> > dependency resolution to fail after that.
> >
> > So allow a longer window of 30 seconds (picked somewhat
> > arbitrarily, but influenced by the similar regulator core
> > timeout value) in the case where modules are enabled.
> >
> > Cc: linux-pm@vger.kernel.org
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Linus Walleij <linus.walleij@linaro.org>
> > Cc: Thierry Reding <treding@nvidia.com>
> > Cc: Mark Brown <broonie@kernel.org>
> > Cc: Liam Girdwood <lgirdwood@gmail.com>
> > Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> > Cc: Saravana Kannan <saravanak@google.com>
> > Cc: Todd Kjos <tkjos@google.com>
> > Cc: Len Brown <len.brown@intel.com>
> > Cc: Pavel Machek <pavel@ucw.cz>
> > Cc: Ulf Hansson <ulf.hansson@linaro.org>
> > Cc: Kevin Hilman <khilman@kernel.org>
> > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > Cc: Rob Herring <robh@kernel.org>
> > Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Signed-off-by: John Stultz <john.stultz@linaro.org>
> > Link: https://lore.kernel.org/r/20200225050828.56458-3-john.stultz@linaro.org
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Sasha Levin <sashal@kernel.org>
> > ---
> >  drivers/base/dd.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> 
> This change ended up being reverted upstream in ce68929f07de
> 
> Is there some specific reason it got selected to be pulled into -stable?

It was an attempt to sync up with what had been added to the 4.19.y tree
but not newer kernels.  I'll go drop this from 5.4.y now, thanks for
noticing the revert, my scripts did not pick that up :(

Also, this is in the 4.19.y tree, but in a different form, and one that
no one seemed to have problems with, so I'll leave it alone there for
now.

thanks,

greg k-h

