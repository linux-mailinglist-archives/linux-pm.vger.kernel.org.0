Return-Path: <linux-pm+bounces-30798-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C20DDB03F31
	for <lists+linux-pm@lfdr.de>; Mon, 14 Jul 2025 15:04:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F72818850C0
	for <lists+linux-pm@lfdr.de>; Mon, 14 Jul 2025 13:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F00FA23497B;
	Mon, 14 Jul 2025 13:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UArDJHtL"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE9C2E36F0;
	Mon, 14 Jul 2025 13:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752498272; cv=none; b=BRhE9g5K36uoxvQkB/HAT/QqBC33XdOBviKBg7QPx3hGHBeZwAMOw8HhVfSzqJE1O1HUQ9iLsDZr1zdhJS0EmOhMZiB0kig4yzDn9h9uy3xDn2HhZRsEES4+uk10YEVTlLSma6fSBfx0eIpEbsMj+4JAmXZ00btWy8O4nq8beCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752498272; c=relaxed/simple;
	bh=diav37jiaTDB5/BPwgT+0WGoc+iJmsDN4KmTv9KnmmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k4qcvuHRZr/06W/OHSFNEfbaz7B7J0WUrc1Vuwe50KIumUraCDuyrN4dq5uN9LX4zoTRz0WeccSxy9aAqev2LVkw9Q8Y0Z0kxLhojY5ymiIADrR5NwHxQxSXxMABlsHTfwsOdd8QXnFAcpyWBrDqFWBpfbkHWvSWKEnH6bNrCz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UArDJHtL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1504C4CEF4;
	Mon, 14 Jul 2025 13:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752498272;
	bh=diav37jiaTDB5/BPwgT+0WGoc+iJmsDN4KmTv9KnmmY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UArDJHtLSymi3gEKJfIyKNCFWM55EgGb+SoXY/ab2mHNsGkV5lfsJ0H65wZSe+U3k
	 bpKZqQHmufJcqLcCA+MUUz4ruIilzH6Z+CqUqq5/pdQPGDXV9ywtbkHXsmRpX4Usyy
	 mi0ZGmd/hTv3Mcx2l9nU8NmKZyXdb0/qwwIzmIf4=
Date: Mon, 14 Jul 2025 15:04:29 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Hsin-Te Yuan <yuanhsinte@chromium.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 6.6] thermal/of: Fix mask mismatch when no trips subnode
Message-ID: <2025071407-fender-passcode-b53c@gregkh>
References: <20250707-trip-point-v1-1-8f89d158eda0@chromium.org>
 <2025071012-granola-daylong-9943@gregkh>
 <CAHc4DN+kb8w+VVX0XAfN5YVo9M+RBatKkv8-nOiOTA+7yZjmfA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHc4DN+kb8w+VVX0XAfN5YVo9M+RBatKkv8-nOiOTA+7yZjmfA@mail.gmail.com>

On Mon, Jul 14, 2025 at 08:36:29PM +0800, Hsin-Te Yuan wrote:
> On Thu, Jul 10, 2025 at 9:33 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Mon, Jul 07, 2025 at 06:27:10PM +0800, Hsin-Te Yuan wrote:
> > > After commit 725f31f300e3 ("thermal/of: support thermal zones w/o trips
> > > subnode") was backported on 6.6 stable branch as commit d3304dbc2d5f
> > > ("thermal/of: support thermal zones w/o trips subnode"), thermal zones
> > > w/o trips subnode still fail to register since `mask` argument is not
> > > set correctly. When number of trips subnode is 0, `mask` must be 0 to
> > > pass the check in `thermal_zone_device_register_with_trips()`.
> > >
> > > Set `mask` to 0 when there's no trips subnode.
> > >
> > > Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>
> > > ---
> > >  drivers/thermal/thermal_of.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
> > > index 0f520cf923a1e684411a3077ad283551395eec11..97aeb869abf5179dfa512dd744725121ec7fd0d9 100644
> > > --- a/drivers/thermal/thermal_of.c
> > > +++ b/drivers/thermal/thermal_of.c
> > > @@ -514,7 +514,7 @@ static struct thermal_zone_device *thermal_of_zone_register(struct device_node *
> > >       of_ops->bind = thermal_of_bind;
> > >       of_ops->unbind = thermal_of_unbind;
> > >
> > > -     mask = GENMASK_ULL((ntrips) - 1, 0);
> > > +     mask = ntrips ? GENMASK_ULL((ntrips) - 1, 0) : 0;
> >
> > Meta-comment, I hate ? : lines in C, especially when they are not
> > needed, like here.  Spell this out, with a real if statement please, so
> > that we can read and easily understand what is going on.
> >
> I will change this in v2 if we end up going with this solution.
> 
> > That being said, I agree with Rafael, let's do whatever is in mainline
> > instead.  Fix it the same way it was fixed there by backporting the
> > relevant commits.
> >
> > thanks,
> >
> > greg k-h
> 
> `mask` is removed in 83c2d444ed9d ("thermal: of: Set
> THERMAL_TRIP_FLAG_RW_TEMP directly"), which needs 5340f7647294
> ("thermal: core: Add flags to struct thermal_trip"). I think it's
> beyond a fix to introduce this. Also, there were several conflicts
> when I tried to cherry-pick 5340f7647294. Compared to a simple
> solution like setting `mask` to 0, I don't think it's worthwhile and
> safe to cherry-pick all the dependencies.

Remember, every patch you add to the tree that is NOT upstream, will
almost always cause problems later on, if not immediately (we have a
lousy track record of one-off-patches.)  Also this prevents future
upstream changes from being able to be applied to the tree.

And as you will now be responsible for maintaining this for the next 3-4
years, do whatever possible to make it easy to keep alive properly.

thanks,

greg k-h

