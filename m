Return-Path: <linux-pm+bounces-16452-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3BC9B03E4
	for <lists+linux-pm@lfdr.de>; Fri, 25 Oct 2024 15:23:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 588331F23715
	for <lists+linux-pm@lfdr.de>; Fri, 25 Oct 2024 13:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F8FE212189;
	Fri, 25 Oct 2024 13:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qigbiZLF"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1075212182;
	Fri, 25 Oct 2024 13:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729862597; cv=none; b=cQ07uO9eLDjoJtJc1IrDdP86DCTqJqsA371uTIKzF4ymt4OiB4Xm7UNhslAQ6tlVGmwOhdiD2iahUoBSNnxqWQd8/ILWHM75OmknIdT9Sy1BW+X/HfT+IBMKmRx1uZYg1s9eE9t4aD1orDFagUVAKKIcPq668n1E+QrS+08QR08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729862597; c=relaxed/simple;
	bh=YY9UvlcOqBf5DRsarl1HoVwp1U7xCRDNZBJwjTC1Psg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=olABTRiSRdH2fAlRUWwAGFnOxzgUn9fTBENk4WNzTeHVsa2cA5VE0mazu1KdAa2gJwMWNv3fqP+ypAHVCVdrEfp80wYnQ0HkSMAdDIgHT7hEu4r5OGx3jaCEXvpmzCqwXIf9iQ+IqGcvgISAbo8baCFV53yoTuSnjl/Wk6xbbs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qigbiZLF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58A7FC4CEC3;
	Fri, 25 Oct 2024 13:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729862596;
	bh=YY9UvlcOqBf5DRsarl1HoVwp1U7xCRDNZBJwjTC1Psg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qigbiZLFnX+GIepxzR9wLDhzmOecNscZEECPyjzV+3nM36PY8WGNDPsC4fKXXNXsf
	 3LF8Pz3nVPqYCNCVoPbtZOQyJz+bdQIdCNefPKmWOm94etYHW3g7KkwONtUsX4w6a8
	 9FMIfFuh8m4hU0+jrMdOPH5xxAN6BH2IGYIFv48Jmky7YZjW7pa12i7xi+KCmZ30vM
	 j3xd+C+G4utBRKx/whm+9uturi9kbBrBIGrjKV6HCO5L5WJfECzY3MaVnPK5D3nSVE
	 /KKYYuKZHiWhPwmVi6RA2OOLHSIH0t989wi66XRA1vgHkEc4p7T6u78g7c5CJnr1NB
	 nUiHCAnuhdCMg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1t4KHu-0000000035n-0L7h;
	Fri, 25 Oct 2024 15:23:34 +0200
Date: Fri, 25 Oct 2024 15:23:34 +0200
From: Johan Hovold <johan@kernel.org>
To: Sibi Sankar <quic_sibis@quicinc.com>
Cc: sudeep.holla@arm.com, cristian.marussi@arm.com, ulf.hansson@linaro.org,
	jassisinghbrar@gmail.com, linux-kernel@vger.kernel.org,
	arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org, konradybcio@kernel.org,
	linux-pm@vger.kernel.org, tstrudel@google.com, rafael@kernel.org
Subject: Re: [PATCH V3 0/4] firmware: arm_scmi: Misc Fixes
Message-ID: <Zxub1sn5usXTayPV@hovoldconsulting.com>
References: <20241007060642.1978049-1-quic_sibis@quicinc.com>
 <ZwfsmqInJlqkQD_3@hovoldconsulting.com>
 <ae5eaef9-301f-7d3f-c973-faa22ae780ee@quicinc.com>
 <ZxkjqEmkBAsC6UkL@hovoldconsulting.com>
 <c8e7420b-a7b4-89cd-1b6e-c1f6693c062d@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8e7420b-a7b4-89cd-1b6e-c1f6693c062d@quicinc.com>

On Fri, Oct 25, 2024 at 11:38:36AM +0530, Sibi Sankar wrote:
> On 10/23/24 21:56, Johan Hovold wrote:
> > On Wed, Oct 23, 2024 at 01:16:47PM +0530, Sibi Sankar wrote:
> >> On 10/10/24 20:32, Johan Hovold wrote:
> >>> On Mon, Oct 07, 2024 at 11:36:38AM +0530, Sibi Sankar wrote:
> >>>> The series addresses the kernel warnings reported by Johan at [1] and are
> >>>> are required to X1E cpufreq device tree changes [2] to land.
> >>>>
> >>>> [1] - https://lore.kernel.org/lkml/ZoQjAWse2YxwyRJv@hovoldconsulting.com/
> >>>> [2] - https://lore.kernel.org/lkml/20240612124056.39230-1-quic_sibis@quicinc.com/
> >>>>
> >>>> The following warnings remain unadressed:
> >>>> arm-scmi arm-scmi.0.auto: Failed to add opps_by_lvl at 3417600 for NCC - ret:-16
> >>>> arm-scmi arm-scmi.0.auto: Failed to add opps_by_lvl at 3417600 for NCC - ret:-16
> >>>
> >>> Are there any plans for how to address these?

> >> This particular error can be fixed only by a firmware update and you
> >> should be able to test it out soon on the CRD first.
> > 
> > Can you explain why this can only be fixed by a firmware update? Why
> > can't we suppress these warnings as well, like we did for the other
> > warnings related to the duplicate entries?
> > 
> > IIUC the firmware is not really broken, but rather describes a feature
> > that Linux does not (yet) support, right?
> 
> We keep saying it's a buggy firmware because the SCP firmware reports
> identical perf and power levels for the additional two opps and the
> kernel has no way of treating it otherwise and we shouldn't suppress
> them. Out of the two duplicate opps reported one is a artifact from how
> Qualcomm usually show a transition to boost frequencies. The second opp
> which you say is a feature should be treated as a boost opp i.e. one
> core can run at max at a lower power when other cores are at idle but
> we can start marking them as such once they start advertising their
> correct power requirements. So I maintain that this is the best we
> can do and need a firmware update for us to address anything more.

Fair enough, but if you end up respinning the series, please say
something about this in the cover letter so that we know why those
warnings are (rightly) left in place.

Johan

