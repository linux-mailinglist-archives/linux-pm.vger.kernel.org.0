Return-Path: <linux-pm+bounces-37055-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D55C7C1BF48
	for <lists+linux-pm@lfdr.de>; Wed, 29 Oct 2025 17:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AC7DD34BB71
	for <lists+linux-pm@lfdr.de>; Wed, 29 Oct 2025 16:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D501A34B434;
	Wed, 29 Oct 2025 16:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T0Prl2kN"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A855E34B41E;
	Wed, 29 Oct 2025 16:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761754107; cv=none; b=KrNK09Srfu8EwWlj59xjLIzXjvSz5SkeXy2hmOtzICjRr35b0PnRfJki6N7Q6LjaTxfCaZ2m6r5SSRLNa5+xRxH1jSUSyx2kEbFxMG4eXXj9EZOnWnF33293feRhQt42x2Kz4DZXvXr+NQbfk5H4wkC9y1JeLYGN00pSVwKKFIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761754107; c=relaxed/simple;
	bh=M9VUXQ0sGm4MCTwj4cZe2NEqjEY3c4DzycPRMT5gMPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=auL2zX6Nc7eeZriWqWCW09BsgZ6Pfp+ryrqOqAnBQwQfrISZyymFggJVzSnEp/GjQMVNlWUCb9f19cUECTNQCoIKUPXlloLQq+JZjHa8BUbvjDvyyz8K1eL38SYND6pOOg8tH8N+jIge1iYQJMZChXXTsgjSd7oku9/xyCU4PRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T0Prl2kN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 517DDC4CEF7;
	Wed, 29 Oct 2025 16:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761754107;
	bh=M9VUXQ0sGm4MCTwj4cZe2NEqjEY3c4DzycPRMT5gMPQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T0Prl2kN0ilDjqzLDqH9l8QDBctE4hNV7ar7kS5HzEOGYHeGU2+O45IJHnDaUtmtY
	 AqQqebI1WpSj4wOqSrSawSR9osPq3eXWa/ducp9RppYpS0UFr/WuyM9/znrxwqWa4/
	 sA0DowkBFR/+U4KhGGu6urT5Zd8aHVNCHtDipzUMzIE9gtaaD4E+lkAFkoM+ecv7e4
	 F4vylNdD4NzYHD3+yaTO8bq4LXDLzgcXyeiWBBp4O9OXh1ZPapjLw3WC1uD+hgmH1m
	 ggj20qtOmE9eYC1ePD7w63cp6HN0bcKCfdpM9bvrSFBfz+0jvq9Pv684GPpILPQim7
	 1qGrvRiG/vZrA==
Date: Wed, 29 Oct 2025 11:11:30 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Ilia Lin <ilia.lin@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Raag Jadav <raag.jadav@intel.com>, Arnd Bergmann <arnd@arndb.de>, linux-arm-msm@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] soc: qcom: smem: better track SMEM uninitialized
 state
Message-ID: <qy3d2wqqi7y2l6lyjrlsjf4dlzoigvawwze7ulapjujozi7lhq@7tluyf4j6nbu>
References: <20251029133323.24565-1-ansuelsmth@gmail.com>
 <20251029133323.24565-2-ansuelsmth@gmail.com>
 <aQIyZfQ-Tvxmh6vL@smile.fi.intel.com>
 <69023398.df0a0220.25fede.8d9c@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69023398.df0a0220.25fede.8d9c@mx.google.com>

On Wed, Oct 29, 2025 at 04:32:35PM +0100, Christian Marangi wrote:
> On Wed, Oct 29, 2025 at 05:27:33PM +0200, Andy Shevchenko wrote:
> > On Wed, Oct 29, 2025 at 02:33:20PM +0100, Christian Marangi wrote:
> > > There is currently a problem where, in the specific case of SMEM not
> > > initialized by SBL, any SMEM API wrongly returns PROBE_DEFER
> > > communicating wrong info to any user of this API.
> > > 
> > > A better way to handle this would be to track the SMEM state and return
> > > a different kind of error than PROBE_DEFER.
> > > 
> > > Rework the __smem handle to always init it to the error pointer
> > > -EPROBE_DEFER following what is already done by the SMEM API.
> > > If we detect that the SBL didn't initialized SMEM, set the __smem handle
> > > to the error pointer -ENODEV.
> > > Also rework the SMEM API to handle the __smem handle to be an error
> > > pointer and return it appropriately.
> > 
> > ...
> > 
> > >  	if (le32_to_cpu(header->initialized) != 1 ||
> > >  	    le32_to_cpu(header->reserved)) {
> > >  		dev_err(&pdev->dev, "SMEM is not initialized by SBL\n");
> > > +		__smem = ERR_PTR(-ENODEV);
> > >  		return -EINVAL;
> > >  	}
> > 
> > I find this a bit confusing. Why the error code returned to the upper layer is
> > different to the stored one?
> >
> 
> It's INVAL for probe. But for any user of SMEM it's NODEV as there isn't
> an actual SMEM usable.
> 
> Totally ok to change the error condition in probe if maybe NODEV is
> better suited. I assume there isn't a specific pattern of the correct
> error condition in probe.
> 

I'd say ENODEV represents the error better than EINVAL, so I don't have
any concerns with you changing the return value.

> > ...
> > 
> > Also, the series of patches should include the cover letter to explain not only
> > series background but additionally
> > - how it should be applied
> > - if it has dependencies
> > - etc
> > 
> 
> Didn't add one they are trivial patch but I can add it if needed... it's
> pretty stable code so no dependency or branch target
> 

Specifically, I should merge patch 1 and 2 through the qcom/soc tree,
and patch 3 can be merged completely independently through the cpufreq
tree.

Regards,
Bjorn

> > 
> > 
> 
> -- 
> 	Ansuel

