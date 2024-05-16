Return-Path: <linux-pm+bounces-7918-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 890BC8C7B74
	for <lists+linux-pm@lfdr.de>; Thu, 16 May 2024 19:41:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28F581F229EF
	for <lists+linux-pm@lfdr.de>; Thu, 16 May 2024 17:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD8014533D;
	Thu, 16 May 2024 17:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="RGRniXv7"
X-Original-To: linux-pm@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1AD51E880;
	Thu, 16 May 2024 17:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715881274; cv=none; b=npMaAKB/T/K8cPoIUBxlGlc/5HSwlaCbsh5PQ9lg+PwGF7nWwDK7k0JNMaq6BDQezsKZaR6U6X6I9eeu4P1PHeLiuUUCA3UwI7Knk/yQ0He4LQD/kzQDPab2zgYyLtpV82C2TrRXfWmfHUpZysbN64Z7YrZeQHw34PMdoPWACzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715881274; c=relaxed/simple;
	bh=vI0ipwrO+rA38r05jmC2doxqTL2Cxt3UGgSgZmCgQ1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pahiozuInVy7p0GSvZ9Mpa9nxKvkAx3g5i8HKgn9SwlyIveW2G3IZG0RTPdt/AHHXzVzR0hrFN3BrBWqCn7vjPvWttC1DJclgB4lQIuKi4dhHDg6KbLbpT1puvwyYkH9Pq7LWy6lumKHI7kKZfdL4ucSDQiARx1pZW5hyXouYhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=RGRniXv7; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1715881267;
	bh=vI0ipwrO+rA38r05jmC2doxqTL2Cxt3UGgSgZmCgQ1k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RGRniXv7e07u7/z136+xgWJF/8A6VQ1EXb/ETGLbRpoEM3AYN93hR5Zsqm/7Givtc
	 Tbm2xbt+xqfusc9nAmruizWXi+ePo9Jto9UCg+AcBbiO29sZjoZz1+lf6z4B0ZH18L
	 hLZgv/Ud+KsQtCLNKY9wQ1uf54AhWR5ftp8NjQk4=
Date: Thu, 16 May 2024 19:41:07 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, 
	linux-pm@vger.kernel.org
Subject: Re: [PATCH RFC] kobject_uevent: notify uevent sysfs file on changes
Message-ID: <74e7cc7b-3b3f-4dae-bcb2-7eb4f9d478cd@t-8ch.de>
References: <20240516-uevent-sysfs-notify-v1-1-2ebb39930c09@weissschuh.net>
 <2024051640-earthen-granite-0847@gregkh>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2024051640-earthen-granite-0847@gregkh>

On 2024-05-16 13:17:34+0000, Greg Kroah-Hartman wrote:
> On Thu, May 16, 2024 at 12:27:58PM +0200, Thomas Weißschuh wrote:
> > The sysfs file "uevent" that exists for each device
> > contains the same information that is attached to uevents emitted via
> > netlink (or the usermode helper).
> > This is useful for userspace which interacts with sysfs directly,
> > without using (lib)udev.
> > 
> > However it is not possible to actually get notified when the data in
> > the "uevent" file changes.
> 
> What is wrong with listening to the uevent that is happening when the
> file changes?

It requires netlink or libudev which is not available or ergonimic for
all userspace programs.
Shellscripts, simple C applications, programing languages without
access to netlink/libudev.

I noticed this when using the "Waybar" application[0] and missing power
supply event updates. Both me and the authors of Waybar expected sysfs
notifications to work for uevent files.

Using sysfs notifications looks like an easy quality-of-life
improvement.

> > Enable these notifications, so that the "uevent" file can be used
> > together with inotify and friends.
> 
> uevent files are meant to be listened to by the uevent itself, why not do
> that?

I can't parse this sentence, sorry. Could you elaborate?

Thanks,
Thomas

[0] https://github.com/Alexays/Waybar/pull/2704

