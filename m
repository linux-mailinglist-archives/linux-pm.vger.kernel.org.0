Return-Path: <linux-pm+bounces-12199-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAED7951A2F
	for <lists+linux-pm@lfdr.de>; Wed, 14 Aug 2024 13:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 195121C21562
	for <lists+linux-pm@lfdr.de>; Wed, 14 Aug 2024 11:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9CFA1AED58;
	Wed, 14 Aug 2024 11:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IatgP3G6"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5591AED44;
	Wed, 14 Aug 2024 11:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723635638; cv=none; b=vFn75qqPKdDrSFb9il43d87sw6wKbnJUpEW9a31Jv7FP+XlZWJzcAPTu8WOInNKoOUGUlvQjIokUhlZKj2BpHNwPxC6Oi/Ck7fXH6ggSKo82bjlkcRybhlOJ17hGRULD/Wr7LMq5eCR/M6zo7LtZYvxClFOiZyJZOGerZ2lL4+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723635638; c=relaxed/simple;
	bh=3zOwJ/RvkDIoKUHW4GDZPcR1BR4iW1E+NQfRyxlf2mM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=djxB8K0tIDkCkCk7D5r1FbfovFA6vp/7+5cQr/T8mFBWIQG9XboHKpaTWLeuQBtW7QmnGSquZv8vB3HVphyjchpXPYGYfbyPGRZCXD5Em8vpz1bPeJmcyG4kG+cReEgOt2ZGtpvKrtiTKh+3dL80/ThTqzw8k0NEy5WvR8QqbiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IatgP3G6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 500B5C32786;
	Wed, 14 Aug 2024 11:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723635638;
	bh=3zOwJ/RvkDIoKUHW4GDZPcR1BR4iW1E+NQfRyxlf2mM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IatgP3G6sSK41eNmDbJS7NMbLvHOqkADS6yjtRorRyOiNLn6f1hXIDs/ra6sSWqqI
	 cuKj5HLpIVAWKAVkM0NYn7oOr63BOIt6NKGULLsMSyTOKRw5zY7UgLkA8FPUNuQE29
	 g1Y16/bdSa+Tp+UaP1HGGrB4mFokCC7ae8tJ7HP4=
Date: Wed, 14 Aug 2024 13:40:34 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Christian Loehle <christian.loehle@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, stable@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	vincent.guittot@linaro.org, qyousef@layalina.io,
	peterz@infradead.org, daniel.lezcano@linaro.org,
	ulf.hansson@linaro.org, anna-maria@linutronix.de,
	dsmythies@telus.net, kajetan.puchalski@arm.com, lukasz.luba@arm.com,
	dietmar.eggemann@arm.com
Subject: Re: [PATCH 6.1.y] cpuidle: teo: Remove recent intercepts metric
Message-ID: <2024081410-camping-letter-1d17@gregkh>
References: <20240628095955.34096-1-christian.loehle@arm.com>
 <CAJZ5v0jPyy0HgtQcSt=7ZO-khSGex2uAxL1x6HZFkFbvpbxcmA@mail.gmail.com>
 <9bbf6989-f41f-4533-a7c8-b274744663cd@arm.com>
 <181bb5c2-5790-41bf-9ed8-3d3164b8697d@arm.com>
 <2024081236-entourage-matter-37c6@gregkh>
 <86d4bf8f-186d-4a65-9f06-3e4d5a2a2e1c@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86d4bf8f-186d-4a65-9f06-3e4d5a2a2e1c@arm.com>

On Tue, Aug 13, 2024 at 02:18:53PM +0100, Christian Loehle wrote:
> On 8/12/24 13:42, Greg KH wrote:
> > On Mon, Aug 05, 2024 at 03:58:09PM +0100, Christian Loehle wrote:
> >> commit 449914398083148f93d070a8aace04f9ec296ce3 upstream.
> >>
> >> The logic for recent intercepts didn't work, there is an underflow
> >> of the 'recent' value that can be observed during boot already, which
> >> teo usually doesn't recover from, making the entire logic pointless.
> >> Furthermore the recent intercepts also were never reset, thus not
> >> actually being very 'recent'.
> >>
> >> Having underflowed 'recent' values lead to teo always acting as if
> >> we were in a scenario were expected sleep length based on timers is
> >> too high and it therefore unnecessarily selecting shallower states.
> >>
> >> Experiments show that the remaining 'intercept' logic is enough to
> >> quickly react to scenarios in which teo cannot rely on the timer
> >> expected sleep length.
> >>
> >> See also here:
> >> https://lore.kernel.org/lkml/0ce2d536-1125-4df8-9a5b-0d5e389cd8af@arm.com/
> >>
> >> Fixes: 77577558f25d ("cpuidle: teo: Rework most recent idle duration values treatment")
> >> Link: https://patch.msgid.link/20240628095955.34096-3-christian.loehle@arm.com
> >> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
> >> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >> ---
> >>  drivers/cpuidle/governors/teo.c | 79 ++++++---------------------------
> >>  1 file changed, 14 insertions(+), 65 deletions(-)
> > 
> > We can't just take a 6.1.y backport without newer kernels also having
> > this fix.  Can you resend this as backports for all relevant kernels
> > please?
> 
> Hi Greg,
> the email thread might've looked a bit strange to you but as I wrote
> in a previous reply:
> https://lore.kernel.org/linux-pm/20240628095955.34096-1-christian.loehle@arm.com/T/#ma5bcd00c4b0ffa1fc34e8d7fa237b8de4ee8a25c
> @stable
> 4b20b07ce72f cpuidle: teo: Don't count non-existent intercepts
> 449914398083 cpuidle: teo: Remove recent intercepts metric
> 0a2998fa48f0 Revert: "cpuidle: teo: Introduce util-awareness"
> apply as-is to
> linux-6.10.y
> linux-6.6.y
> for linux-6.1.y only 449914398083 ("cpuidle: teo: Remove recent intercepts metric")
> is relevant, I'll reply with a backport.

Please send all of these as a patch series for the relevent branches so
we know exactly what is going on...

thanks,

greg k-h

