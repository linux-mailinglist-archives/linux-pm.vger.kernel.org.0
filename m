Return-Path: <linux-pm+bounces-25604-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 58128A9150B
	for <lists+linux-pm@lfdr.de>; Thu, 17 Apr 2025 09:22:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23AF97A875B
	for <lists+linux-pm@lfdr.de>; Thu, 17 Apr 2025 07:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13E51218EBA;
	Thu, 17 Apr 2025 07:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b7a58EL2"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0C0217F36;
	Thu, 17 Apr 2025 07:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744874562; cv=none; b=GD9SYXd2GGAo3032z7o6+1n3ERdZdA9QCOXakFcfpdKosVumOM/UDyifmmXsiIQjv3qZjhQpxqHSqI2Ya6M0MjPbdIpZEA5qUCB4np8XahseXM1N6IsR+jwl4VvvCmb2AS+Yts+30buldP9NZvmrSUEfWwiKezSWuGZGxPkiCL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744874562; c=relaxed/simple;
	bh=0S+KpR1ZAK42RiiHVxB5z5tMzy93HJ/YyCYV0Oi7ty0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dz+aL7wVd6feq8VRVtx9fSAgR5QUdvjLLdb5hPlGzitjKrvfL4ot4ARzoc20G09VELlY5sOSP8KapPCAs1Qril0VDe9ZY28gZJKQAKVgqrXjlzXqVwG/TOEd4t7e03ao+zFShYL7jHsGyHRYcqs3WV5L75cFT6oD+JBer0GU7es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b7a58EL2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD22AC4CEE7;
	Thu, 17 Apr 2025 07:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744874561;
	bh=0S+KpR1ZAK42RiiHVxB5z5tMzy93HJ/YyCYV0Oi7ty0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b7a58EL2fd9RmleKNHO/3n0vOEeE2AToG5GTLnbZ+uQDI+I+GAEgnl5fma+849t7E
	 Wk/SrtOMNdJkJTI0mU7/7NMLONooC7su6n24L+zNIPdB2pb6GmIPzFwUW6AY/ynsM6
	 MqIfFhyvp3VJSBap/7NrfI2e/P2UiCTbG4HksW1AJQn1gD6xuN/1pRTMIYG0hoAmCE
	 yM4btPDfx/MOnTswdBGOUX8OqrS6r2LWn7HvigUj0aGJqjwz2oI//fXDUkMW6vakFp
	 beh08dViYlr3gdkTRyywfLs56wu34GTvdf4R4BJLgYL6LoeknZKKr/qGvp+kvBB8W0
	 FuuqAPGNVfyzg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1u5Ja5-000000008O2-1v5L;
	Thu, 17 Apr 2025 09:22:41 +0200
Date: Thu, 17 Apr 2025 09:22:41 +0200
From: Johan Hovold <johan@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Johan Hovold <johan+linaro@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	"Rob Herring (Arm)" <robh@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] cpufreq: fix compile-test defaults
Message-ID: <aACsQUADxYHTQDi1@hovoldconsulting.com>
References: <20250417065535.21358-1-johan+linaro@kernel.org>
 <a0739b6b-b043-47f1-8044-f6ed68d39f2c@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0739b6b-b043-47f1-8044-f6ed68d39f2c@linaro.org>

On Thu, Apr 17, 2025 at 09:10:09AM +0200, Krzysztof Kozlowski wrote:
> On 17/04/2025 08:55, Johan Hovold wrote:
> > Commit 3f66425a4fc8 ("cpufreq: Enable COMPILE_TEST on Arm drivers")
> > enabled compile testing of most Arm CPUFreq drivers but left the
> > existing default values unchanged so that many drivers are enabled by
> > default whenever COMPILE_TEST is selected.
> > 
> > This specifically results in the S3C64XX CPUFreq driver being enabled
> > and initialised during boot of non-S3C64XX platforms with the following
> > error logged:
> > 
> > 	cpufreq: Unable to obtain ARMCLK: -2
> 
> But isn't this fixed by my commit (d4f610a9bafd)? How is it possible to
> reproduce above error when you are NOT test compiling?

Correct, but this was how I found the issue and motivation for
backporting the fixes including yours which was not marked for stable.
 
> > Commit d4f610a9bafd ("cpufreq: Do not enable by default during compile
> > testing") recently fixed most of the default values, but two entries
> > were missed
> 
> That's not really a bug to be fixed. No things got worse by missing two
> entries, so how this part could be called something needing fixing?

I'm not saying it's buggy, I'm explaining that the identified issue was
recently fixed partially.
 
> >  and two could use a more specific default condition.
> 
> Two entries for more specific default - before they were ALWAYS default,
> so again I narrowed it from wide default. Nothing to fix here. You can
> narrow it further but claiming that my commit made something worse looks
> like a stretch - and that's a meaning of fixing someone's commit.

Relax. I'm not blaming you for doing anything wrong here.

I sent a fix for the same issues you addressed and Viresh let me know
that he had already merged a fix for most of the issues:

	https://lore.kernel.org/lkml/20250416134331.7604-1-johan+linaro@kernel.org/
 
> > Fix the default values for drivers that can be compile tested and that
> > should be enabled by default when not compile testing.
> > 
> > Fixes: 3f66425a4fc8 ("cpufreq: Enable COMPILE_TEST on Arm drivers")
> 
> 
> > Fixes: d4f610a9bafd ("cpufreq: Do not enable by default during compile testing")
> 
> That's not correct tag - it introduced no new issues, did not make
> things worse, so nothing to fix there, if I understand correctly.

Fair enough, I could have used dependency notation for this one.

Let me do that in v3.

> > Changes in v2:
> >  - rebase on commit d4f610a9bafd ("cpufreq: Do not enable by default
> >    during compile testing")

Johan

