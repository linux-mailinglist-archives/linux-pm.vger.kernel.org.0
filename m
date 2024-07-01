Return-Path: <linux-pm+bounces-10290-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD04491E546
	for <lists+linux-pm@lfdr.de>; Mon,  1 Jul 2024 18:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FBAB1F239C0
	for <lists+linux-pm@lfdr.de>; Mon,  1 Jul 2024 16:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADFA116D9AB;
	Mon,  1 Jul 2024 16:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d77onVSY"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813AD16D4FA;
	Mon,  1 Jul 2024 16:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719851162; cv=none; b=V83VVtv3r4UVNNW3ptbRm8g5iJBR7QZYdCUSk2AztG+/dBnyxMOWsy6fQlIvAmSLajAn3aWG5tk9i/fpWG/s9ZewFISZkFbdH4OMD/VWRL+rOxq9kvwTgaIZYGldVN3GqBD5tLtM+trk5S7XMgPHhGQk9/1nw8kti1Xer2OEMGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719851162; c=relaxed/simple;
	bh=i2p4aaSgboVOcolrZ90RECvdYTcJ1USBCygQy2QTziw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OcIy9zIf1gk7AWmGod6Nq4ZxhZGqDrhghnODgSsWWh9CuwafG+zVddKiVVoGWL5JgE3RltYNw2FsrCsebEpM254rtxv84BYeJUU1Dt2lLT2/4kKYIEyTal3n+dAdVXj4+yzcDET3T7MZy+0w2ENEWdbSy+YBug8jiILpsTttoq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d77onVSY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D624CC116B1;
	Mon,  1 Jul 2024 16:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719851162;
	bh=i2p4aaSgboVOcolrZ90RECvdYTcJ1USBCygQy2QTziw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d77onVSYc8BEMNtz7rqBIgvwtJNEiip01DtHmR64QLR7B8Im0xyihZR76UUBcVB0m
	 d56WfQ3oOI2iROdUpkRWADPn04GRmDvBl4oe80ijWUb6niT7Ptn9pmJMA6lWQWMzx2
	 M+2f8PGijqa0HPQNLFVNQCAWfHEfaZygT64KQ673cdFB3ANbV4EQQVTivHAam9VO2t
	 bMawRR1GdQ/zCNjtU6anCdYQ2PLP7lDpRDf2YPW3DDTVWkfU+wrIh1kiUpmLE2X241
	 eyeJ7OUTNR/STGToWI0b37yS118E/dEfEpwhsDR04+2qpQXaXvdmztj7tCYL6PmwUl
	 dK9fIdsLj1AuA==
Date: Mon, 1 Jul 2024 10:26:00 -0600
From: Rob Herring <robh@kernel.org>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rafael@kernel.org, linux-pm@vger.kernel.org,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] thermal/core: Introduce user trip points
Message-ID: <20240701162600.GA4119789-robh@kernel.org>
References: <20240627085451.3813989-1-daniel.lezcano@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240627085451.3813989-1-daniel.lezcano@linaro.org>

On Thu, Jun 27, 2024 at 10:54:50AM +0200, Daniel Lezcano wrote:
> Currently the thermal framework has 4 trip point types:
> 
> - active : basically for fans (or anything requiring energy to cool
>   down)
> 
> - passive : a performance limiter
> 
> - hot : for a last action before reaching critical
> 
> - critical : a without return threshold leading to a system shutdown
> 
> A thermal zone monitors the temperature regarding these trip
> points. The old way to do that is actively polling the temperature
> which is very bad for embedded systems, especially mobile and it is
> even worse today as we can have more than fifty thermal zones. The
> modern way is to rely on the driver to send an interrupt when the trip
> points are crossed, so the system can sleep while the temperature
> monitoring is offloaded to a dedicated hardware.
> 
> However, the thermal aspect is also managed from userspace to protect
> the user, especially tracking down the skin temperature sensor. The
> logic is more complex than what we found in the kernel because it
> needs multiple sources indicating the thermal situation of the entire
> system.
> 
> For this reason it needs to setup trip points at different levels in
> order to get informed about what is going on with some thermal zones
> when running some specific application.
> 
> For instance, the skin temperature must be limited to 43°C on a long
> run but can go to 48°C for 10 minutes, or 60°C for 1 minute.
> 
> The thermal engine must then rely on trip points to monitor those
> temperatures. Unfortunately, today there is only 'active' and
> 'passive' trip points which has a specific meaning for the kernel, not
> the userspace. That leads to hacks in different platforms for mobile
> and embedded systems where 'active' trip points are used to send
> notification to the userspace. This is obviously not right because
> these trip are handled by the kernel.
> 
> This patch introduces the 'user' trip point type where its semantic is
> simple: do nothing at the kernel level, just send a notification to
> the user space.

Sounds like OS behavior/policy though I guess the existing ones kind are 
too. Maybe we should have defined *what* action to take and then the OS 
could decide whether what actions to handle vs. pass it up a level.

Why can't userspace just ask to be notified at a trip point it 
defines?

If we keep this in DT, perhaps 'notice' would be a better name that 
doesn't encode the OS architecture details.


BTW, can we decide what to do about 'trips' node being required or not? 
That's nearly the only DT warning left for some platforms.

> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  .../devicetree/bindings/thermal/thermal-zones.yaml        | 1 +

Please make bindings a separate patch.

>  drivers/thermal/thermal_core.c                            | 8 ++++++++
>  drivers/thermal/thermal_of.c                              | 1 +
>  drivers/thermal/thermal_trace.h                           | 4 +++-
>  drivers/thermal/thermal_trip.c                            | 1 +
>  include/uapi/linux/thermal.h                              | 1 +
>  6 files changed, 15 insertions(+), 1 deletion(-)


