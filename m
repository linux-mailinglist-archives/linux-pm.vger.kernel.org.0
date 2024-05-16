Return-Path: <linux-pm+bounces-7920-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 590BB8C7C8B
	for <lists+linux-pm@lfdr.de>; Thu, 16 May 2024 20:32:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE4041F236B6
	for <lists+linux-pm@lfdr.de>; Thu, 16 May 2024 18:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59790156C60;
	Thu, 16 May 2024 18:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XtAJMIjX"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2871C4688;
	Thu, 16 May 2024 18:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715884370; cv=none; b=Uhp0dykh7ILVz+HnUFauaHRArAdlBovdbgb3tQAk9TdayaKVlKbn7ignKLf04uHJIlkGe0rUoJeVAn5aJH4zvgzBpspowdBlboDJuso8ioDDmB9HmeFWM4x4qUd9wxtaBlgfqAvSLQ96/oTTqbPl/lN6ACT/CmGPNryNOMIXAh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715884370; c=relaxed/simple;
	bh=DlzrQS/rXH0P2O50Ihqdlyok5DY6gfoePae3FLr3hOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pFNwwhkb54iKNNftvUDqq9jDI+hN0LWsdnS/GHTlqDr6GlUXFLx0v7bt/BkuNv6dGLoHI1EcQFY/QEkNpUtL5xvn9CgHYtKUaD/a+kAcpidaOSXMQXJ8sQ5f/wMFRgZL7LI7h0Ml2CYGtq9XyFVJpP7Xo+eZIQKjhCXCCOR6eTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XtAJMIjX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18C6BC32782;
	Thu, 16 May 2024 18:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715884369;
	bh=DlzrQS/rXH0P2O50Ihqdlyok5DY6gfoePae3FLr3hOA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XtAJMIjX7JrluUUNTzTkGhkceQz3rJG6GX8ksOMSOt1FLX9AlTtI68YtbI0A3xwL1
	 jm7ELQb0o4keHev+r70V28K9H8FVbaOzS1d2EzqMOGnIrGMBhQVUexn5xOU6beua2M
	 4kt26wDOTbakn6f8dNkWchRS6o3E4OtXBpQDbn7o=
Date: Thu, 16 May 2024 20:32:46 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH RFC] kobject_uevent: notify uevent sysfs file on changes
Message-ID: <2024051618-creation-mutilator-c871@gregkh>
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
> Shellscripts, simple C applications, programing languages without
> access to netlink/libudev.
> 
> I noticed this when using the "Waybar" application[0] and missing power
> supply event updates. Both me and the authors of Waybar expected sysfs
> notifications to work for uevent files.

"Waybar" is anything but a "simple C application", the dependancy chain
it has is quite huge, adding libudev should be very easy, and probably
already there.  Oh look, it is there, upower already brings it in, so no
need to worry about adding another dependancy.

So I think maybe just using the library already in the program might be
simplest, even simpler than attempting to use inotify and friends (as
you don't have to figure out the actual file that you care about, gudev
has that information already for you, abstracted away properly.)

thanks,

greg k-h

