Return-Path: <linux-pm+bounces-13238-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7619996637A
	for <lists+linux-pm@lfdr.de>; Fri, 30 Aug 2024 15:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 972181C2367C
	for <lists+linux-pm@lfdr.de>; Fri, 30 Aug 2024 13:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88FAB1AF4FE;
	Fri, 30 Aug 2024 13:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="SNYhTBDy"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E7B165F05;
	Fri, 30 Aug 2024 13:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725026148; cv=none; b=TdYqi74TOmRiB0O91oCAXnWMU09JgkEaQNQyy5eMws6guuZRZATPRS3g8ZV/fTNOcY5Z/eUQs++bTDEkko2oW7UEbB1Sq8PTEr6bPm17tWcGKIr2LABVXlt2uAYOX3X0x/dN4c2QvKWvYMUXWtCGQbtNhinbPDaxaMWNK/gToJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725026148; c=relaxed/simple;
	bh=R3wAHtlfT8KFaILLRqz1y1wT9mdP442l/JWdmVOnTaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uWKZCYzLzZvn37+hwGtR3y/994Rz66gMOf1DNW85YtiR23Kf6YF5jusJnldz8AUtAONvnCpl55jh2mricRWTBDNeDodd63E40JDjJKrnNj48X4yPMfJrU6OftlKq3RL7uJrAGpWisiLD2J6UwYnzr0ycXeJkSgrai4IR2Ld93oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=SNYhTBDy; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1725026144;
	bh=R3wAHtlfT8KFaILLRqz1y1wT9mdP442l/JWdmVOnTaI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SNYhTBDyuS+8t6UKhFeHUgS5dRK2aa1vij2rxuhiC/o1Jh259p1K87AAWcJGCytVd
	 7dBWl+qE7R6SpWXkIpd9IFrV2wTLZaCXoXe92nEcyh5LT9r+rv0TOnMiYpMkFKAHct
	 9PiFiXrXDw1ov/IvgzUninazSonCyyHfnqbI5IhS1UT1ZkTxNDcc0RvOzBM9TU4k8k
	 FgX363YP8E6VhdS5Kz0sksmeePw5Wlwzy5rz9CRtp7Au30dLx0B8jNZfCO3dieDwx1
	 noZ3aHklR+3qjnqwqMzZVjnMJs+seW93iRl8OZLi7V126iEP03s1IngnosvGnuGPBK
	 V/PqTnwyAqR+w==
Received: from notapiano (pool-100-2-116-133.nycmny.fios.verizon.net [100.2.116.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 399EF17E1047;
	Fri, 30 Aug 2024 15:55:43 +0200 (CEST)
Date: Fri, 30 Aug 2024 09:55:41 -0400
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Linux PM <linux-pm@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>,
	regressions@lists.linux.dev, kernelci@lists.linux.dev,
	kernel@collabora.com
Subject: Re: [PATCH v3 00/14] thermal: Rework binding cooling devices to trip
 points
Message-ID: <42f62311-b541-4b0f-8b90-ca1a5dfe1e6c@notapiano>
References: <2205737.irdbgypaU6@rjwysocki.net>
 <ff528ebb-2c09-4b03-a641-4a306b31ff62@notapiano>
 <CAJZ5v0gjt3ptZ8=qJcXagZfXrJbpcz7nDwZxRvg50PytdNScRQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0gjt3ptZ8=qJcXagZfXrJbpcz7nDwZxRvg50PytdNScRQ@mail.gmail.com>

On Mon, Aug 26, 2024 at 11:58:12AM +0200, Rafael J. Wysocki wrote:
> On Sat, Aug 24, 2024 at 8:45 PM Nícolas F. R. A. Prado
> <nfraprado@collabora.com> wrote:
> >
> > On Mon, Aug 19, 2024 at 05:49:07PM +0200, Rafael J. Wysocki wrote:
> > > Hi Everyone,
> > >
> > > This is one more update of
> > >
> > > https://lore.kernel.org/linux-pm/3134863.CbtlEUcBR6@rjwysocki.net/#r
> > >
> > > the cover letter of which was sent separately by mistake:
> > >
> > > https://lore.kernel.org/linux-pm/CAJZ5v0jo5vh2uD5t4GqBnN0qukMBG_ty33PB=NiEqigqxzBcsw@mail.gmail.com/
> > >
> > > and it has been updated once already:
> > >
> > > https://lore.kernel.org/linux-pm/114901234.nniJfEyVGO@rjwysocki.net/
> > >
> > > Relative to the v2 above it drops 3 patches, one because it was broken ([04/17
> > > in the v2), and two more that would need to be rebased significantly, either
> > > because of dropping the other broken patch or because of the recent Bang-bang
> > > governor fixes:
> > >
> > > https://lore.kernel.org/linux-pm/1903691.tdWV9SEqCh@rjwysocki.net/
> > >
> > > The remaining 14 patches, 2 of which have been slightly rebased and the rest
> > > is mostly unchanged (except for some very minor subject and changelog fixes),
> > > is not expected to be controversial and are targeting 6.12, on top of the
> > > current linux-next material.
> > >
> > > The original motivation for this series quoted below has not changed:
> > >
> > >  The code for binding cooling devices to trip points (and unbinding them from
> > >  trip point) is one of the murkiest pieces of the thermal subsystem.  It is
> > >  convoluted, bloated with unnecessary code doing questionable things, and it
> > >  works backwards.
> > >
> > >  The idea is to bind cooling devices to trip points in accordance with some
> > >  information known to the thermal zone owner (thermal driver).  This information
> > >  is not known to the thermal core when the thermal zone is registered, so the
> > >  driver needs to be involved, but instead of just asking the driver whether
> > >  or not the given cooling device should be bound to a given trip point, the
> > >  thermal core expects the driver to carry out all of the binding process
> > >  including calling functions specifically provided by the core for this
> > >  purpose which is cumbersome and counter-intuitive.
> > >
> > >  Because the driver has no information regarding the representation of the trip
> > >  points at the core level, it is forced to walk them (and it has to avoid some
> > >  locking traps while doing this), or it needs to make questionable assumptions
> > >  regarding the ordering of the trips in the core.  There are drivers doing both
> > >  these things.
> > >
> > > The first 5 patches in the series are preliminary.
> > >
> > > Patch [06/14] introduces a new .should_bind() callback for thermal zones and
> > > patches [07,09-12/14] modifies drivers to use it instead of the .bind() and
> > > .unbind() callbacks which allows them to be simplified quite a bit.
> > >
> > > The other patches [08,13-14/14] get rid of code that becomes unused after the
> > > previous changes and do some cleanups on top of that.
> > >
> > > The entire series along with 2 patches on top of it (that were present in the
> > > v2 of this set of patches) is available in the thermal-core-testing git branch:
> > >
> > > https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/log/?h=thermal-core-testing
> > >
> > > (note that this branch is going to be rebased shortly on top of 6.11-rc4
> > > and the thermal control material in linux-next).
> > >
> > > Thanks!
> >
> > Hi,
> >
> > KernelCI has identified a boot regression originating from this series. I've
> > verified that reverting the series fixes the issue.
> 
> Thanks for the report!
> 
> There was a bug in the original patch [12/14] that would cause
> symptoms like what you are observing to appear, which was reported on
> Friday and has since been fixed in the tree.  Please see:
> 
> https://lore.kernel.org/linux-pm/CAJZ5v0iw7uXE_cfU5VXOjFDg9GM8Hu0+hKxqfzU3v0OM5KK9oQ@mail.gmail.com/
> 
> You probably have not tested the fixed tree yet, so please let
> kernelci run again on it and if the issue is still there, please let
> me know.

Indeed it has been fixed.

#regzbot fix: 'thermal/of: Use the .should_bind() thermal zone callback'

Thanks,
Nícolas

