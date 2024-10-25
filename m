Return-Path: <linux-pm+bounces-16456-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB9E9B047B
	for <lists+linux-pm@lfdr.de>; Fri, 25 Oct 2024 15:48:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49F761F24092
	for <lists+linux-pm@lfdr.de>; Fri, 25 Oct 2024 13:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A4470804;
	Fri, 25 Oct 2024 13:48:42 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA02612B64;
	Fri, 25 Oct 2024 13:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729864122; cv=none; b=CfV9cM2DSwPE5qsDwefcJFonwAZ2eVCipmJD+jACrA6vpKk1KSe86tKkqmdzBAirt/Lc3b78umKJJCo7dgzZc8zb4udI9W8a5DeIZ78wCA95XSJaFkz0NB+d2br8xTCoZlHWxcdwmSDTMtHHQNr3A55yhuieeMs2QVt1Io2woA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729864122; c=relaxed/simple;
	bh=AWWxHlQ7+1+m8GRIlMTOKtAHKxDrjgZ5/Q1TV6hpEKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RJ8hNJBygkeW0sx6zH2I3RbpNdLS5KBj1obwUU4ixeN4zyuEIvLsN9jZ7bvguDpTISZFgqkVntbQNV4ri8V7pR6of2IleK3fP1SrMQTCJQTwWbyGqftIzxHNZn8xsUEXp2CsdIMfBEMukJ/eCAcgx6ZPjZkY1F+6qM8pxTmeQzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E8BBD339;
	Fri, 25 Oct 2024 06:49:08 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3E1D63F71E;
	Fri, 25 Oct 2024 06:48:37 -0700 (PDT)
Date: Fri, 25 Oct 2024 14:48:26 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Johan Hovold <johan@kernel.org>
Cc: Cristian Marussi <cristian.marussi@arm.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Sibi Sankar <quic_sibis@quicinc.com>, sudeep.holla@arm.com,
	ulf.hansson@linaro.org, jassisinghbrar@gmail.com,
	linux-kernel@vger.kernel.org, arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	konradybcio@kernel.org, linux-pm@vger.kernel.org,
	tstrudel@google.com, rafael@kernel.org
Subject: Re: [PATCH V3 0/4] firmware: arm_scmi: Misc Fixes
Message-ID: <ZxuhqkDoWF8IYQxL@pluto>
References: <20241007060642.1978049-1-quic_sibis@quicinc.com>
 <ZwfsmqInJlqkQD_3@hovoldconsulting.com>
 <ae5eaef9-301f-7d3f-c973-faa22ae780ee@quicinc.com>
 <ZxkjqEmkBAsC6UkL@hovoldconsulting.com>
 <c8e7420b-a7b4-89cd-1b6e-c1f6693c062d@quicinc.com>
 <ik4dyfbphm7lkeipm2dbr7cmdfxewxd4jtuz2jfnscfwcyo2r4@lrin5hnsqvyd>
 <83b635a7-fc69-7522-d985-810262500cb3@quicinc.com>
 <CAA8EJppx1OmYnfSsMDebRRTbNb3dfAE_MM55T1SpLccP=s_K1A@mail.gmail.com>
 <Zxty8VaMPrU3fJAN@pluto>
 <ZxueBWB9nJ9Mt7bW@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxueBWB9nJ9Mt7bW@hovoldconsulting.com>

On Fri, Oct 25, 2024 at 03:32:53PM +0200, Johan Hovold wrote:
> On Fri, Oct 25, 2024 at 11:29:05AM +0100, Cristian Marussi wrote:
> 
> > > > >>> [    8.098452] arm-scmi arm-scmi.0.auto: Failed to add opps_by_lvl at 3417600 for NCC - ret:-16
> > > > >>> [    8.109647] arm-scmi arm-scmi.0.auto: Failed to add opps_by_lvl at 3417600 for NCC - ret:-16
> > > > >>> [    8.128970] arm-scmi arm-scmi.0.auto: Failed to add opps_by_lvl at 3417600 for NCC - ret:-16
> > > > >>> [    8.142455] arm-scmi arm-scmi.0.auto: Failed to add opps_by_lvl at 3417600 for NCC - ret:-16
> 
> > I think dev_info could be an option from the SCMI perspective (as per my
> > other mail), the important thing in these regards is to NOT go
> > completely silent against fw anomalies...to avoid the the risk of being
> > silently ignored .... I'll see what Sudeep thinks about...
> 
> I agree.
> 
> But could the error handling be improved to look less scary for an end
> user by saying something about duplicate entries being ignored instead
> perhaps?
> 
> Printing something at info level and with a FW_BUG ("[Firmware Bug]: ")
> prefix as was done here:
> 
> 	https://lore.kernel.org/all/20230414084619.31524-1-johan+linaro@kernel.org/
> 
> should make it clear that this is not something for end users to worry
> (too much) about.

Sure...and thanks for the suggestion....I will cook something up around
this....

(I am probably too used to try to scary the FW guys that I forgot there
are also innocent bystanders like final users :P)

Thanks,
Cristian

