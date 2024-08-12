Return-Path: <linux-pm+bounces-12068-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8769E94ED3E
	for <lists+linux-pm@lfdr.de>; Mon, 12 Aug 2024 14:42:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 453432842B8
	for <lists+linux-pm@lfdr.de>; Mon, 12 Aug 2024 12:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF4A17B439;
	Mon, 12 Aug 2024 12:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="c0jsvWeA"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30DB516F0E6;
	Mon, 12 Aug 2024 12:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723466535; cv=none; b=MYrgbZ+TK37I3/Z+15QMHNGYF9989LODGier5vBy+8Vup1GW09dph+qrU5jb3Z4DKxXzbp3E40Kc3dhKijf16Ih6X1BsOZirtzE9/aiN08EbPUFBpyyy3Y0PhnOdwunLEI6wnctYWBAyql9X3mv2zeiQwd43WV1PGdzrod21qys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723466535; c=relaxed/simple;
	bh=xiYozym11rlBjc/daSc9DA/XWQH2VVg2UBUkV1MHm1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YKeFETioU0dLc5izrsDdRwW/XQ+ktlJGDFqsyxjghtH1gT8aW9edV9+A6DRIQhD69NGcDV0UhjrxkpuPRUrkpKNREUZpFzAXY/6Xod6FCDiPg/GvGsaefLWHzETui6KNgCukmFdVNShIW3+RlchWd88ABLu84kcjz+IBfcgrOvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=c0jsvWeA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8216EC32782;
	Mon, 12 Aug 2024 12:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723466531;
	bh=xiYozym11rlBjc/daSc9DA/XWQH2VVg2UBUkV1MHm1w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c0jsvWeA84+D38Vp+03s7j8vU17DqyCMRi8kNYkaryM2SmSLp9Iq+Hpj9uGVF7C3/
	 c9JaWo//BkXHqIo+LkSO9Qf8xOCHnFF+6NN8wVcJcHufDXhSNFXEKDt/TvUOduvTsh
	 zcqTYum4i2zEV7jOZ3d6DsxSwCCIpFHS5c8x+JZY=
Date: Mon, 12 Aug 2024 14:42:08 +0200
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
Message-ID: <2024081236-entourage-matter-37c6@gregkh>
References: <20240628095955.34096-1-christian.loehle@arm.com>
 <CAJZ5v0jPyy0HgtQcSt=7ZO-khSGex2uAxL1x6HZFkFbvpbxcmA@mail.gmail.com>
 <9bbf6989-f41f-4533-a7c8-b274744663cd@arm.com>
 <181bb5c2-5790-41bf-9ed8-3d3164b8697d@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <181bb5c2-5790-41bf-9ed8-3d3164b8697d@arm.com>

On Mon, Aug 05, 2024 at 03:58:09PM +0100, Christian Loehle wrote:
> commit 449914398083148f93d070a8aace04f9ec296ce3 upstream.
> 
> The logic for recent intercepts didn't work, there is an underflow
> of the 'recent' value that can be observed during boot already, which
> teo usually doesn't recover from, making the entire logic pointless.
> Furthermore the recent intercepts also were never reset, thus not
> actually being very 'recent'.
> 
> Having underflowed 'recent' values lead to teo always acting as if
> we were in a scenario were expected sleep length based on timers is
> too high and it therefore unnecessarily selecting shallower states.
> 
> Experiments show that the remaining 'intercept' logic is enough to
> quickly react to scenarios in which teo cannot rely on the timer
> expected sleep length.
> 
> See also here:
> https://lore.kernel.org/lkml/0ce2d536-1125-4df8-9a5b-0d5e389cd8af@arm.com/
> 
> Fixes: 77577558f25d ("cpuidle: teo: Rework most recent idle duration values treatment")
> Link: https://patch.msgid.link/20240628095955.34096-3-christian.loehle@arm.com
> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpuidle/governors/teo.c | 79 ++++++---------------------------
>  1 file changed, 14 insertions(+), 65 deletions(-)

We can't just take a 6.1.y backport without newer kernels also having
this fix.  Can you resend this as backports for all relevant kernels
please?

thanks,

greg k-h

