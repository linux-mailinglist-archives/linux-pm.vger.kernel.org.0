Return-Path: <linux-pm+bounces-18545-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB2B9E3C96
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2024 15:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 354772847D0
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2024 14:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 413B220ADE3;
	Wed,  4 Dec 2024 14:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aJ6u+l5V"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA0B20ADDA;
	Wed,  4 Dec 2024 14:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733322021; cv=none; b=B+62aF2NRLS7dUPSp3LxXNqzRb9V2usvDaDhE+sqBN55JKxwAEl8fsucLzB0WugHjMD/NayDqdeywotV8RwppeEMcnIm683dgIlaLhMEBee1sc05bM+LLeGbKc42FspEHthGBa71d2rC2oDqFZhk1A9s+8JilRKetXkf+57k+Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733322021; c=relaxed/simple;
	bh=F6pWanQlj63toLxU411hvlJXyDawT/sSO+sGghM2rRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=unGpdwwKXNqbkiOWwmQLiRza2zCng4+92G9b4ay+wQrzXSF33GrPCroqHf7I4rpr+7XUbaLJEbbhic57kvYqTHFU1zDhf5RSUY3RfUiIKiZtAzUcQmSMe2wdv1rM6+Mjg5yptjvhEM7uhlhbmG37dZQkd9sZaQ6S6gSiEo5olG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aJ6u+l5V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24247C4AF09;
	Wed,  4 Dec 2024 14:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733322020;
	bh=F6pWanQlj63toLxU411hvlJXyDawT/sSO+sGghM2rRk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aJ6u+l5V/fs2f3bA9skcQJMzMgTVQwKclrWkVnnMN1iyQZGVnpJkJWijVIWeMhBDn
	 l7BumcHi8JHIGJqyBKi5kwaU/h/Mg51SP8MLk9+ekwXiCSPjkbtHG7IVu7C2EgZHQn
	 tAjtGmmuKhW/8ZbdRciy7q+5Lt387efGij1bsj9c=
Date: Wed, 4 Dec 2024 15:20:17 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Linux PM <linux-pm@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Saravana Kannan <saravanak@google.com>
Subject: Re: [PATCH v1] PM: sleep: Update stale comment in device_resume()
Message-ID: <2024120404-work-confider-88f5@gregkh>
References: <2787627.mvXUDI8C0e@rjwysocki.net>
 <2024120450-makeshift-haggler-625c@gregkh>
 <CAJZ5v0hyi_2KL-h_+CbCSsZcQXEP3BspBxCbhzmfX2KydSfRKQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0hyi_2KL-h_+CbCSsZcQXEP3BspBxCbhzmfX2KydSfRKQ@mail.gmail.com>

On Wed, Dec 04, 2024 at 03:16:05PM +0100, Rafael J. Wysocki wrote:
> On Wed, Dec 4, 2024 at 2:12 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Wed, Dec 04, 2024 at 02:02:04PM +0100, Rafael J. Wysocki wrote:
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >
> > > There is no function called __device_suspend() any more and it is still
> > > mentioned in a comment in device_resume(), so update that comment.
> > >
> > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > ---
> > >  drivers/base/power/main.c |    2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > Index: linux-pm/drivers/base/power/main.c
> > > ===================================================================
> >
> > Are you not using git?  This looks like the old cvs output :)
> 
> I use git, but for patch generation I prefer quilt which has produced
> this patch.

From my .quiltrc:
	QUILT_REFRESH_ARGS="--diffstat --strip-trailing-whitespace --no-timestamps --no-index --sort -p1 -p ab"

makes it almost look like the git output :)


