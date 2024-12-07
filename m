Return-Path: <linux-pm+bounces-18736-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AC869E7FED
	for <lists+linux-pm@lfdr.de>; Sat,  7 Dec 2024 13:47:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 238DC1883C6C
	for <lists+linux-pm@lfdr.de>; Sat,  7 Dec 2024 12:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B6E2CA6;
	Sat,  7 Dec 2024 12:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="ebHc7v9j"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A7E22C6E7;
	Sat,  7 Dec 2024 12:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733575656; cv=none; b=EzCOpsurBcpebQanWbH//C1BmN1m92FFyIe8RM9c/8wHrPVZgomN7ZylqQnNKbNHWhCP3OBdntz84BX3W+airgI+0wDyqsMaGoOe/M1Lj4r7E0gYZd8GkRXZRkCVNLHZVyKG3Ku4qX9V9q58VOBX5AV8P4RV0S3eewQwLUue6p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733575656; c=relaxed/simple;
	bh=y4VW5ZRiACtCLkBYlNRSSFPuoas6Ic3oW//NPP7IXRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kWBTjQk4S+HYc4HhJxMWJKEVlcgqFV560D36MCMmWHe+kksIG71W+cKIZScCjpq7Gf0YXY4bWISZ+GWuM3XLCr2A7Xoc7D8cUXLYvrUaDClHS2e4IrrR4P2BwjqbI61OwmKAfCYbUAybX6j5z3IjWItp9aWFhbLZz+GVNwxeBrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=ebHc7v9j; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=TJDDUIbWS9yNi7PeF4BStBvdpOpia5YZBMJZqbobf7I=; b=ebHc7v9j8vvVNotb
	RXH9iV8c+MLhqEQic5OioB0XFYF14Yda1ytSOca9DUJ+krGppXjqpmYwit65BmoRDEBj1vILHvlmr
	d8AxZN2y2nl5yaOprmhOu4YT0cvfppLax7jSSiWAoCDjxNRwkVgy3r01ffkSeSxxAJGRt90woO+bc
	7CVQ7WqSY6Wu8VdzRRoiGIn9T0O8DVJw3Y7ePL+WU7D91RirjdEIdc+IZ/mPiOpKdPjdKBD5ip0/e
	a52OJ+vNTvqhES21kEWLnD0WUyoTIRKNcTJPM0deb/Z235Arprz70F1UY4gWhvgi8rEaF4c1QKovV
	tKvf+Kp3EARWWIu59A==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1tJuDU-0040k0-0r;
	Sat, 07 Dec 2024 12:47:24 +0000
Date: Sat, 7 Dec 2024 12:47:24 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PM / devfreq: Remove unused
 devm_devfreq_(un)register_notifier
Message-ID: <Z1RD3Ec1IJ2jY5TZ@gallifrey>
References: <Z0iWPCzjv9YQ4kO_@gallifrey>
 <20241028021344.477984-1-linux@treblig.org>
 <CGME20241128161146epcas1p46768d7685092deaa817119db30fd12f2@epcms1p4>
 <20241207052209epcms1p45818db425ba84821003b6d735bc0e957@epcms1p4>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20241207052209epcms1p45818db425ba84821003b6d735bc0e957@epcms1p4>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 12:46:15 up 213 days, 0 min,  1 user,  load average: 0.04, 0.04,
 0.01
User-Agent: Mutt/2.2.12 (2023-09-09)

* MyungJoo Ham (myungjoo.ham@samsung.com) wrote:
> >* linux@treblig.org (linux@treblig.org) wrote:
> >> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> >> 
> >> devm_devfreq_register_notifier() and devm_devfreq_unregister_notifier()
> >> have been unused since 2019's
> >> commit 0ef7c7cce43f ("PM / devfreq: passive: Use non-devm notifiers")
> >> 
> >> Remove them, and the helpers they used.
> >> 
> >> Note, devm_devfreq_register_notifier() is still used as an example
> >> in Documentation/doc-guide/contributing.rst but that's just
> >> an example of an old doc bug rather than anything about the function
> >> itself.
> >> 
> >> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> >
> >Ping.
> >
> >Thanks,
> >
> >Dave
> 
> When I search github, it appears that vendors are using this API.

Hmm OK.
Of course there's a lot of random junk on github, so it can be tricky
to know what's current/real/relevant.

> NVIDIA:
> https://github.com/NX-Development/android_kernel_nvidia_nvidia/blob/c9ade3b5e32a12b8cf6f33a632dc39209194e4e8/drivers/devfreq/governor_wmark_active.c#L624
> 
> Samsung:
> https://github.com/Vaz15k/android_kernel_samsung_a54x/blob/8ac517c37c606746213064857dc240e99eba80d2/drivers/soc/samsung/exynos-llcgov.c#L107
> 
> Realtek:
> https://github.com/BPI-SINOVOIP/BPI-M4-bsp/blob/25f5b88ec4ba34029f964693dc34028b26e6c67c/linux-rtk/drivers/devfreq/realtek/governor_rtk_ltl.c#L114
> 
> 
> 
> Please don't remove ABIs used by vendors even if
> they didn't upstream their drivers.

Hmm OK.
Do you think they should be using this ABI or do they have the same bug as 
is fixed in 0ef7c7cce43f ?
I guess they don't care.

Dave

> Cheers,
> MyungJoo.
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

