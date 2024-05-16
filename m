Return-Path: <linux-pm+bounces-7919-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 336588C7C85
	for <lists+linux-pm@lfdr.de>; Thu, 16 May 2024 20:31:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6BD91F22EDF
	for <lists+linux-pm@lfdr.de>; Thu, 16 May 2024 18:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F490156F28;
	Thu, 16 May 2024 18:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CwU2n6eV"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59563156C7C;
	Thu, 16 May 2024 18:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715884100; cv=none; b=BzlV2T8Ns8SEDgN+DqmhmXufEx6hocw5S9ePWlCijcoUAJZ1O/04DCOiXB09wXd+YlIxJO/qOtznoskO+OucdZzl4JKZ+zfWgSCJSjZjglY9Jftpvg+trk3pTCCM8pQKyd2lKl8ag+w1oTZ3hVxpsK6MA5ZCPk7D3rSBlpuWLYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715884100; c=relaxed/simple;
	bh=sT5rh3M+x1YJYckp/JlnwaL9GidKt++aphUT4lC1FnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xyt8pBeLvJ+B8EnYYRkCADcXoDFlxVxOzpRqfZ1NvDbRUyFKJci7++fHTeb/RLeutHfQjUtaGKr5m8U+lh0vcvD16LdGWY+Z5oxlty+reaLziwKWsIWuVJ6xAVXgc4RQS+Ad+IEvFAqol0+VFCbSV+xDnD5f57AOp9qX6gWOlF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CwU2n6eV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BC99C4DE1B;
	Thu, 16 May 2024 18:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715884099;
	bh=sT5rh3M+x1YJYckp/JlnwaL9GidKt++aphUT4lC1FnU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CwU2n6eVL6NNCAgVieVMspD5xWKrfd4OQgqj3WrEwdlG6PoaKeIxdU3Nl+vyMBQI9
	 aECP/pmMps/AXBG2ymUF9F2xlzxsOY/W018DVcO3dYu2pSP9wo5eQo/i8ox8Gk8gLl
	 +x83O4W6y/LIIff5vLbn7YgmPlSw09nvi2tYfLic=
Date: Thu, 16 May 2024 20:28:16 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH RFC] kobject_uevent: notify uevent sysfs file on changes
Message-ID: <2024051634-replica-unbalance-b39d@gregkh>
References: <20240516-uevent-sysfs-notify-v1-1-2ebb39930c09@weissschuh.net>
 <2024051640-earthen-granite-0847@gregkh>
 <74e7cc7b-3b3f-4dae-bcb2-7eb4f9d478cd@t-8ch.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <74e7cc7b-3b3f-4dae-bcb2-7eb4f9d478cd@t-8ch.de>

On Thu, May 16, 2024 at 07:41:07PM +0200, Thomas Weißschuh wrote:
> On 2024-05-16 13:17:34+0000, Greg Kroah-Hartman wrote:
> > On Thu, May 16, 2024 at 12:27:58PM +0200, Thomas Weißschuh wrote:
> > > The sysfs file "uevent" that exists for each device
> > > contains the same information that is attached to uevents emitted via
> > > netlink (or the usermode helper).
> > > This is useful for userspace which interacts with sysfs directly,
> > > without using (lib)udev.
> > > 
> > > However it is not possible to actually get notified when the data in
> > > the "uevent" file changes.
> > 
> > What is wrong with listening to the uevent that is happening when the
> > file changes?
> 
> It requires netlink or libudev which is not available or ergonimic for
> all userspace programs.

But that's the api involved for this thing.

> Shellscripts, simple C applications, programing languages without
> access to netlink/libudev.

You can have a shellscript run for every uevent if that's all you have,
why not just do that?

> I noticed this when using the "Waybar" application[0] and missing power
> supply event updates. Both me and the authors of Waybar expected sysfs
> notifications to work for uevent files.
> 
> Using sysfs notifications looks like an easy quality-of-life
> improvement.
> 
> > > Enable these notifications, so that the "uevent" file can be used
> > > together with inotify and friends.
> > 
> > uevent files are meant to be listened to by the uevent itself, why not do
> > that?
> 
> I can't parse this sentence, sorry. Could you elaborate?

The uevent file just mirrors what was sent in the uevent.  It isn't
there to be polled, it's just there to be read if you want the
information later on for some reason (i.e. coldplugging).

I recommend just using libudev to register for the events, don't try to
parse the files yourself, that way is madness :)

Or register for the netlink events you care about, you can filter very
easily that way to only get the ones you want, that's why the netlink
interface is used.

thanks,

greg k-h

