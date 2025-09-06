Return-Path: <linux-pm+bounces-34046-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 944A6B46BDD
	for <lists+linux-pm@lfdr.de>; Sat,  6 Sep 2025 13:53:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73CAC1BC5CEA
	for <lists+linux-pm@lfdr.de>; Sat,  6 Sep 2025 11:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E0827CB35;
	Sat,  6 Sep 2025 11:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0PEwHMD/"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9CD97082A;
	Sat,  6 Sep 2025 11:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757159594; cv=none; b=Um9q/xpARyWSrOU9yVU9VrlSPhcnqBsnXiIkd763LPyYXpyk03ekvSMmyt0UGNFcytqeT5yntOMdkIwYO0eaOHnsBT0wa04dDIGQLTFVX1FeevQ5jlOsT6fhzofi6tPDGtdaitx9YDSxwdRjL8/b7RlIMrQhU/SZt3ChsLNH+6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757159594; c=relaxed/simple;
	bh=nmIiC4173EF7fxnRng2oWd9HcHsPFBNkRzHACYvN6vM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bmzew9rlbeWZ5Wa78Ztw6RJZXHUbR0aVrAgMTd93MKzbxzX4p1Bgv+9AW2HaNJzKbKz/UIYTu0u3W7ES9E8LLAbArDv1t8rW/X+/JRvZabG0FhZh+tQDOu8RbJx8NVnKOYSGv//EFw6RhEscrkRy0uOY/8mAu3PWiWU91akF8hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0PEwHMD/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF4FBC4CEE7;
	Sat,  6 Sep 2025 11:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757159594;
	bh=nmIiC4173EF7fxnRng2oWd9HcHsPFBNkRzHACYvN6vM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0PEwHMD/B7bDAPHGtAOBhm5pu3CqWxwssw7V/2GWZsrmQtL2iTgBgywjpy3dfh6jq
	 E0SEonrNiC0bChC7QXnfWbRMAhZnE+F767VaV2+EjYQeVjBHZaB7941WWTI9mRC9Cu
	 LQknFYoh8Pi1hJDtk4AOhDk5u8qAaL769FdnRNJg=
Date: Sat, 6 Sep 2025 13:53:11 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Danilo Krummrich <dakr@kernel.org>
Subject: Re: [PATCH v1 0/2] driver core/PM: Two updates related to power.no_pm
Message-ID: <2025090658-cucumber-velvet-ae53@gregkh>
References: <12749467.O9o76ZdvQC@rafael.j.wysocki>
 <2025082851-progress-unsliced-ade4@gregkh>
 <CAJZ5v0hn9NXvHPy6zV4R4y0AHtN2BfN41wjd5s7dos0wx6ih0Q@mail.gmail.com>
 <CAJZ5v0gj33W-2FOswYoBLQQyTj0wr_EuMUdLiL_tdt4t=ss-jg@mail.gmail.com>
 <CAJZ5v0ifvwbPs1VKBMpWdanBKUdHSZuNandbF9=uhec56DynNw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0ifvwbPs1VKBMpWdanBKUdHSZuNandbF9=uhec56DynNw@mail.gmail.com>

On Wed, Sep 03, 2025 at 01:33:18PM +0200, Rafael J. Wysocki wrote:
> On Fri, Aug 29, 2025 at 9:09 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Thu, Aug 28, 2025 at 1:20 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > >
> > > On Thu, Aug 28, 2025 at 1:07 PM Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > On Thu, Aug 28, 2025 at 12:55:50PM +0200, Rafael J. Wysocki wrote:
> > > > > Hi All,
> > > > >
> > > > > Applying this series will cause power.no_pm to be set for faux devices (so they
> > > > > don't get processed unnecessarily during system-wide suspend/resume transitions)
> > > > > and power.no_callbacks to be set along with power.no_pm (for consistency).
> > > >
> > > > Oh, nice!  I forgot about that entirely.  Should these be backported to
> > > > older kernels as well?
> >
> > So do you want me to resend these patches with suitable Cc: stable tags?
> >
> > Alternatively, I can just apply them with the tags and route them
> > through my tree, whatever you prefer.
> 
> In the absence of more feedback, this is what I'm going to do.

Thanks, sorry for the delay, been swamped with conferences and travel :(

