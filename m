Return-Path: <linux-pm+bounces-16462-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D1B99B04EA
	for <lists+linux-pm@lfdr.de>; Fri, 25 Oct 2024 16:02:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9AC71F244BD
	for <lists+linux-pm@lfdr.de>; Fri, 25 Oct 2024 14:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1715B1487C8;
	Fri, 25 Oct 2024 14:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SRBx6Rbx"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC482212168;
	Fri, 25 Oct 2024 14:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729864932; cv=none; b=SznTjFjikCbOvNGQJe+/08mSBa22HNj6/sY9KMlno9pIHPSftRsu+1k17noc6A4m6NxJ9/kthCo6uQpnMVDi2T28r5CyqEGTJASfiCrxxGkCkmFfMzn7FzkCP5I2CGyZnQKIDhpqUy50zRMDciU6kYh4Cj9hqIPf3lWOfBCmOQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729864932; c=relaxed/simple;
	bh=uOUytvJeyy3SqYRpdRsBWf13Adk6SJC8Eee84d3Etug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fZKjaC9WnWegxuITYYWKQtj+dDiQVT5dL10ZPIj02DM3c8vZ8cEyzeAvfWhRvE/+z7sdrZvW8RBFcm3VbDFUYQtY4RxNbx/YaVfx89o5Hosc0nOQ9gWHAZu1x2uwX0DgKM3TU8nud9TqPjhe5isBgiqSa/2nvnMGiYaEXimehvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SRBx6Rbx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69293C4CEC3;
	Fri, 25 Oct 2024 14:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729864931;
	bh=uOUytvJeyy3SqYRpdRsBWf13Adk6SJC8Eee84d3Etug=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SRBx6RbxR5nuw+gDjyclmxQ45SMY1Z/wdsODDoBv6EDDt+cfCE0A8C09z77A44GsG
	 Fl3YD9mvL1lKw75XRpaHg4GDOFkWuf0rDOOA25f/rDWFltcJup7FlMmxYPb1fe1l36
	 9pKZsLZAeWLDgbjbtmwylseIT/ExTOBC6HhCqjcHtxPdZtRxeRzK7tIY9veBhxdNrz
	 J3KfUdiFeCmCbu+Jzx+XX8M5fGkJ/hlWtA7Py7Hv6ozszRWqhEpSBRNSl3ahtscPrX
	 CUGmopX0JoU2qGKy31gd2JdOD+mQapW8KxNxUfdoP/9XSVC+rwwhSm/v+d0/Oo3SFO
	 qF2//B8TjtyLw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1t4Kta-000000005yi-0WFi;
	Fri, 25 Oct 2024 16:02:30 +0200
Date: Fri, 25 Oct 2024 16:02:30 +0200
From: Johan Hovold <johan@kernel.org>
To: Sibi Sankar <quic_sibis@quicinc.com>
Cc: sudeep.holla@arm.com, cristian.marussi@arm.com, ulf.hansson@linaro.org,
	jassisinghbrar@gmail.com, dmitry.baryshkov@linaro.org,
	linux-kernel@vger.kernel.org, arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	konradybcio@kernel.org, linux-pm@vger.kernel.org,
	tstrudel@google.com, rafael@kernel.org
Subject: Re: [PATCH V4 0/4] firmware: arm_scmi: Misc Fixes
Message-ID: <Zxuk9jlibn8ffEVZ@hovoldconsulting.com>
References: <20241023102148.1698910-1-quic_sibis@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023102148.1698910-1-quic_sibis@quicinc.com>

On Wed, Oct 23, 2024 at 03:51:44PM +0530, Sibi Sankar wrote:
> The series addresses the kernel warnings reported by Johan at [1] and are
> are required to X1E cpufreq device tree changes [2] to land.
> 
> [1] - https://lore.kernel.org/lkml/ZoQjAWse2YxwyRJv@hovoldconsulting.com/
> [2] - https://lore.kernel.org/lkml/20240612124056.39230-1-quic_sibis@quicinc.com/
> 
> The following warnings remain unadressed:
> arm-scmi arm-scmi.0.auto: Failed to add opps_by_lvl at 3417600 for NCC - ret:-16
> arm-scmi arm-scmi.0.auto: Failed to add opps_by_lvl at 3417600 for NCC - ret:-16
> 
> They indicate that duplicate opps are reported by the SCP firmware and
> they are seen during probe. They will get addressed by firmware updates. 
> 
> Duplicate levels:
> arm-scmi arm-scmi.0.auto: Level 2976000 Power 218062 Latency 30us Ifreq 2976000 Index 10
> arm-scmi arm-scmi.0.auto: Level 3206400 Power 264356 Latency 30us Ifreq 3206400 Index 11
> arm-scmi arm-scmi.0.auto: Level 3417600 Power 314966 Latency 30us Ifreq 3417600 Index 12
> arm-scmi arm-scmi.0.auto: Failed to add opps_by_lvl at 3417600 for NCC - ret:-16
> arm-scmi arm-scmi.0.auto: Failed to add opps_by_lvl at 3417600 for NCC - ret:-16
> arm-scmi arm-scmi.0.auto: Level 4012800 Power 528848 Latency 30us Ifreq 4012800 Index 15
> 
> ^^ exist because SCP reports duplicate values for the highest sustainable
> freq for perf domains 1 and 2. These are the only freqs that appear as
> duplicates and will be fixed with a firmware update. FWIW the warnings
> that we are addressing in this series will also get fixed by a firmware
> update but they still have to land for devices already out in the wild.

Thanks for sorting this out, Sibi!

I guess the above description is clear enough too as to why the
opps_by_lvl warnings should stay (in some form).

Johan

