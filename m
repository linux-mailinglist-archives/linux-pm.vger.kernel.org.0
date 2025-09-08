Return-Path: <linux-pm+bounces-34157-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C18B48E13
	for <lists+linux-pm@lfdr.de>; Mon,  8 Sep 2025 14:49:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B423D1C20942
	for <lists+linux-pm@lfdr.de>; Mon,  8 Sep 2025 12:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7704305963;
	Mon,  8 Sep 2025 12:49:28 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E13E3054E4;
	Mon,  8 Sep 2025 12:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757335768; cv=none; b=fpxoNyFYmlzTAa9Y8vjfgIaQMTAuYAi4/w9CTECIQuxYCp0QV8Y/pEhBP9pBCaXaOxVjpBBn10mFhQ0pNwpYnJHTSzTRxL+nWAIxyCUqie6F3RtV8QdOLb7tf0wgLjDUdyPA4AJQbErq8RY0IPuQjf1pIzPHJLJ/W485Bhyl12k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757335768; c=relaxed/simple;
	bh=GyM+72vbTDFms4ytB64sVkatESAOpKSQs1BXwQZH6ig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pd2uoL5qXph9sx8+SNap25UT5eQAf6UuSEFm5FAQMoBjO4lQJrxhsznHg8gCqyx/nLDzFc2fnQhmYz2aZbiCzIDyPEUGmKdge+eVdkwFRz3M6+aFrC5hwJiVZ+tiM0H7iWB7tjvrBgHx3P5e27PvZrKwup12WIQtEuuZrKEfync=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 131D31692;
	Mon,  8 Sep 2025 05:49:12 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.68])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 72A663F694;
	Mon,  8 Sep 2025 05:49:16 -0700 (PDT)
Date: Mon, 8 Sep 2025 13:49:13 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: catalin.marinas@arm.com, will@kernel.org, broonie@kernel.org,
	oliver.upton@linux.dev, anshuman.khandual@arm.com, robh@kernel.org,
	james.morse@arm.com, mark.rutland@arm.com, joey.gouly@arm.com,
	ahmed.genidi@arm.com, kevin.brodsky@arm.com,
	scott@os.amperecomputing.com, mbenes@suse.cz,
	james.clark@linaro.org, frederic@kernel.org, rafael@kernel.org,
	pavel@kernel.org, ryan.roberts@arm.com, suzuki.poulose@arm.com,
	maz@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	kvmarm@lists.linux.dev
Subject: Re: [PATCH v4 0/5] initialize SCTRL2_ELx
Message-ID: <aL7QySSGoI5p0B70@e133380.arm.com>
References: <20250821172408.2101870-1-yeoreum.yun@arm.com>
 <aLW5OIgv8/bvvY9E@e133380.arm.com>
 <aLXjVNCbT6YeWlSS@e129823.arm.com>
 <aLgd0/7peYBA4z87@e133380.arm.com>
 <aLgvzKeEPn325aRO@e129823.arm.com>
 <aL630WeBwWoUGTBp@e133380.arm.com>
 <aL68enBTkmsjJGPy@e129823.arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aL68enBTkmsjJGPy@e129823.arm.com>

Hi,

On Mon, Sep 08, 2025 at 12:22:34PM +0100, Yeoreum Yun wrote:
> Hi,
> 
> > [...]
> >
> > > > > > Have you tested all the code paths, or are there some things that have
> > > > > > not been tested?
> > > > >
> > > > > I've tested for pKVM, nested and nhve and crash path
> > > > > (I do my best what can I do for modified path).
> > > >
> > > > Was that just confirming that the kernel boots / does not crash?
> > >
> > > Not only that, since the my last mistake, I've check it with debugger
> > > too -- set the SCTLR2_ELx as I expected.
> > >
> > > >
> > > > What about CPU suspend/resume and hotplug?
> > >
> > > Of course It's done both enter/exit idle and hotplug with related kselftest test.
> >
> > Were you able to step through these paths, too?
> 
> Yes. with debugger and some trick with:
>   asm volatile("b ." ::: "memory");
> 
> checking a cpu idle (by not loading any work) without any load and
> checking cpu-hotplug with kselftest's cpu-on-off-test.sh.
> 
> So, by hitting the "b .", I've stepped in and confirm the SCTLR2_ELx set
> as it intended.

OK, that sounds reasonable comprehensive.

[...]

> > Looking again through this series, I realised that the requirements for
> > this feature are not documented in booting.rst.
> >
> > Does the following patch look good to you?  If so, feel free to append
> > it to the series (with your Reviewed-by, if you're happy with the
> > changes).
> >
> > It's probably worth double-checking the bit numbers etc.  I wrote this
> > some weeks ago and then forgot about it.
> 
> I've missed this and Thanks for your efforts.
> The bits you documented have no problem as far as I checked.
> Let me include this too in next series.
> 
> (I'm still checking your suggestion to use .ifc. as soon as finish
> this. I'll repost it according to your suggestion)
> 
> 
> Thanks!

OK, I'll take another look when you repost.

Cheers
---Dave

