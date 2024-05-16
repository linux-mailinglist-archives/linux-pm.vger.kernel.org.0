Return-Path: <linux-pm+bounces-7909-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 97DEF8C7512
	for <lists+linux-pm@lfdr.de>; Thu, 16 May 2024 13:17:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37724B21F60
	for <lists+linux-pm@lfdr.de>; Thu, 16 May 2024 11:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313931459E1;
	Thu, 16 May 2024 11:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Vrs5ZgjU"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED24214535E;
	Thu, 16 May 2024 11:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715858258; cv=none; b=eGtRHky/ITgF0zznyNEOCWlHSSX+NK6lEYcJli4KYjCALJErR8iUkF7rS1lt0r3IpDhgbP5PtRkts1gI+YvBdkHsDsuTpj37Wg7T75s03eYr/qN0Gl+H0IrfbvhCqqLPQ3vJih29H12BK7ypfbX7+u9Hn2DLuNql1QPKC8h6KLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715858258; c=relaxed/simple;
	bh=c5e0mFp+ruu1GBzNvy2XnURTk5BTJbgaFDgtVzQ8PlE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MmhI+erpFuEB77i834F6jegwNo3G7PrEI31DN9CXDOHcL/skuv1fyvWDieM+gJzAw++ti3ukyCJmWK7l9PNTDDDyPaNC3pCuKx4Wd+trhQI0sIMNDaaN+57VnWRDeAtYFsmyjU0nlW1HAaiDHzJVFZ9m0ZCJgH7e5pvCeBMQErM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Vrs5ZgjU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BEB4C113CC;
	Thu, 16 May 2024 11:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715858257;
	bh=c5e0mFp+ruu1GBzNvy2XnURTk5BTJbgaFDgtVzQ8PlE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vrs5ZgjUEmZa2vpDT/Fzn2L7uuqxpZAunmzdTAlgy0bstG24a2UzvgBAa6gi+74qm
	 KnJWA/QMmhbfMN8b3W83K0rjvTBhnHZHEIiLKI7n7Pp19+P3/A//pbajwB1z8Qt2Ke
	 2hQxitoWhPbYLQWn9OZjS4wy3tAC6jn/r47s75NU=
Date: Thu, 16 May 2024 13:17:34 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH RFC] kobject_uevent: notify uevent sysfs file on changes
Message-ID: <2024051640-earthen-granite-0847@gregkh>
References: <20240516-uevent-sysfs-notify-v1-1-2ebb39930c09@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240516-uevent-sysfs-notify-v1-1-2ebb39930c09@weissschuh.net>

On Thu, May 16, 2024 at 12:27:58PM +0200, Thomas Weißschuh wrote:
> The sysfs file "uevent" that exists for each device
> contains the same information that is attached to uevents emitted via
> netlink (or the usermode helper).
> This is useful for userspace which interacts with sysfs directly,
> without using (lib)udev.
> 
> However it is not possible to actually get notified when the data in
> the "uevent" file changes.

What is wrong with listening to the uevent that is happening when the
file changes?

> Enable these notifications, so that the "uevent" file can be used
> together with inotify and friends.

uevent files are meant to be listened to by the uevent itself, why not do
that?

thanks,

greg k-h

