Return-Path: <linux-pm+bounces-11891-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD9C946D9F
	for <lists+linux-pm@lfdr.de>; Sun,  4 Aug 2024 10:54:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6EB6281429
	for <lists+linux-pm@lfdr.de>; Sun,  4 Aug 2024 08:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 898011F95A;
	Sun,  4 Aug 2024 08:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nuf+Linf"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485603FC2;
	Sun,  4 Aug 2024 08:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722761654; cv=none; b=KSueFx+gTvZbKvq406Cq8+zElWojm9udh7YSN9fOaM1LxndQMsYYN53OEI3tPwGwsPkQxA+NeDV3d6GhQ0j1T6qtBC+x/mroWS94zWzRo5SARO50bCgVnstFmihX7/1P6Ef9Z1f8O0BxMYquVJ1zYc8ucXRV0hll/FEUgM+Gv6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722761654; c=relaxed/simple;
	bh=EnPID6ABFQiU3CywfoiNeZaGER0APilwi5tKfaltBY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a10Xc2wy38m4rWiWYDAZWIqnRhdeeunUevAgYl8R1Cw8XqTn3V8k8qjtSrgRyJ/dwqmmNfCxGJFkUG4QIO2vmO9M/4S0iNZkZkzejByVT58tYG6/pthe4fI2YITOc9MFh9uMH2prG8ZjVT7fr+G/YCTwQ56CPIPKaaBqJcQM24U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nuf+Linf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55FEFC32786;
	Sun,  4 Aug 2024 08:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722761653;
	bh=EnPID6ABFQiU3CywfoiNeZaGER0APilwi5tKfaltBY0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nuf+LinfI/eaULfi7GdJGNc0oQ/mr6y8wiuY4CJAS1maGFsBWqYGZ+DVopBc39Nfz
	 lfbLbOIPH08EWtGGx8o60wqqmH9fOOcYEKD5GhXXxrrZK7mXPk/9MSdig8kIKMamdQ
	 23v7gUKpCNQTDCqCRp3v82yCnlSEqDcBey6ET66o=
Date: Sun, 4 Aug 2024 10:54:10 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "John B. Wyatt IV" <jwyatt@redhat.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>, linux-pm@vger.kernel.org,
	Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, John Kacur <jkacur@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>,
	"John B. Wyatt IV" <sageofredondo@gmail.com>
Subject: Re: [PATCH 0/2][RFC] Add SWIG Bindings to libcpupower
Message-ID: <2024080405-roundish-casket-2474@gregkh>
References: <20240724221122.54601-1-jwyatt@redhat.com>
 <1f5c24b6-f3ee-4863-8b7a-49344a550206@linuxfoundation.org>
 <Zqv9BOjxLAgyNP5B@hatbackup>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zqv9BOjxLAgyNP5B@hatbackup>

On Thu, Aug 01, 2024 at 05:24:20PM -0400, John B. Wyatt IV wrote:
> > On 7/24/24 16:11, John B. Wyatt IV wrote:
> > > SWIG is a tool packaged in Fedora and other distros that can generate
> > > bindings from C and C++ code for several languages including Python,
> > > Perl, and Go. We at Red Hat are interested in adding binding support to
> > > libcpupower so Python tools like rteval or tuned can make easy use of it.
> > > 
> > 
> > Can you elaborate on the use-case and what rteval currently does and
> > how it could benefit from using libcpupower with the bindings?
> 
> rteval is a Python program used to measure realtime performance. We wanted to
> test the effect of enabling some levels of idle-stat to see how it affects
> latency, and didn't want to reinvent the wheel. We thought that the Python
> bindings could be useful to other people as well who might want to call
> cpupower too from Python. I did some testing and was able to achieve this with
> SWIG. We sent the patchset to see what folks thought about this.

Is this going to require a built-time dependency on SWIG?  If not, when
would it be run, and who will be in charge of running it and updating
the bindings?

And finally, why do we need these at all?  You are saying these are new
tests that external tools will be using, but why, if external tools are
required to run them, are they needed in the kernel tree at all?  Why
isn't this just another external test-suite that people who care about
measuring this type of thing going to just run on their own if desired?

thanks,

greg k-h

