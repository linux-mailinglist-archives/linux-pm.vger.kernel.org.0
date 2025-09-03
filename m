Return-Path: <linux-pm+bounces-33698-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62EF9B41C58
	for <lists+linux-pm@lfdr.de>; Wed,  3 Sep 2025 12:54:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24793682C7A
	for <lists+linux-pm@lfdr.de>; Wed,  3 Sep 2025 10:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F362FB992;
	Wed,  3 Sep 2025 10:52:12 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EC912FB63F;
	Wed,  3 Sep 2025 10:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756896732; cv=none; b=LUWnRbKw15mT0heXU3GTdC18YlOM6evDNS/TUS9oaDPi+yo4pgTWLzW+MXMTHgQYXu7h5thwCELfnR4R398/eZkqHeklYejvXulKu0T4cUGVnKKIVUqpCB5N889yvUA+EmNIr0DgqhT2v7aP9dn/Rpl1dGI7PCLxeignokSHD08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756896732; c=relaxed/simple;
	bh=w7nuUSP0f817FXPXAUem6RI/OKXBGEG3thaO9lBwwTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o/hufiGEYS5Qz+d9VE6vYinDERefyDsTYMP+hKBYxv/ZwTH3yW1GGd8TKrhWFZlRJIChzNqFsUN1pqNGvkNVr+awsjUF4njavin21B9N/zQe83Mu1+T+YAvXsE32Q8JxVbmPZJQHZNiv9VTJahbCO+gH60fl16ijFW5wY9DzmAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4C72914BF;
	Wed,  3 Sep 2025 03:52:02 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.68])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ACADB3F694;
	Wed,  3 Sep 2025 03:52:06 -0700 (PDT)
Date: Wed, 3 Sep 2025 11:52:03 +0100
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
Message-ID: <aLgd0/7peYBA4z87@e133380.arm.com>
References: <20250821172408.2101870-1-yeoreum.yun@arm.com>
 <aLW5OIgv8/bvvY9E@e133380.arm.com>
 <aLXjVNCbT6YeWlSS@e129823.arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLXjVNCbT6YeWlSS@e129823.arm.com>

Hi,

On Mon, Sep 01, 2025 at 07:17:56PM +0100, Yeoreum Yun wrote:
> Hi Dave,
> 
> > On Thu, Aug 21, 2025 at 06:24:03PM +0100, Yeoreum Yun wrote:
> > > This series introduces initial support for the SCTLR2_ELx registers in Linux.
> > > The feature is optional starting from ARMv8.8/ARMv9.3,
> > > and becomes mandatory from ARMv8.9/ARMv9.4.
> > >
> > > Currently, Linux has no strict need to modify SCTLR2_ELx--
> > > at least assuming that firmware initializes
> > > these registers to reasonable defaults.
> > >
> > > However, several upcoming architectural features will require configuring
> > > control bits in these registers.
> > > Notable examples include FEAT_PAuth_LR and FEAT_CPA2.
> >
> > This looks OK to me now, except for one or two minor issues (see
> > replies to the patches).
> >
> > I think we will need a way of testing all the code paths before this
> > should be merged, though.
> >
> > Have you tested all the code paths, or are there some things that have
> > not been tested?
> 
> I've tested for pKVM, nested and nhve and crash path
> (I do my best what can I do for modified path).

Was that just confirming that the kernel boots / does not crash?

What about CPU suspend/resume and hotplug?

My concern is that most of the defined SCTLR2_ELx bits won't affect
kernel execution unless the corresponding hardware features are
actively being used -- so while we know that the patches don't break
the kernel, this may not prove that SCTLR2_ELx is really being
initialised / saved / restored / reset correctly.

> > Since this code is not useful by itself, it may make sense to delay
> > merging it until we have patches for a feature that depends on SCTLR2.
> 
> Whatever I pass this detiermination for maintainer.

Sure, that's just my opinion.

Either way, this doesn't stop anyone from building support for specific
features on top of this series before it gets merged.

Cheers
---Dave

