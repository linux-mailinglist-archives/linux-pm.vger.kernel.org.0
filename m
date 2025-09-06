Return-Path: <linux-pm+bounces-34047-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A31B46BEA
	for <lists+linux-pm@lfdr.de>; Sat,  6 Sep 2025 13:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C77E7A02400
	for <lists+linux-pm@lfdr.de>; Sat,  6 Sep 2025 11:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F55285C87;
	Sat,  6 Sep 2025 11:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="imCk4z3a"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4AA927CB35;
	Sat,  6 Sep 2025 11:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757159642; cv=none; b=rGrw6kHe2IIMf6Ca9WsBuDpxjOi4ZhbWXWMr9yu0zPwag8+300CpvrH2YBBvmzZaLFLLo6DKMqGIk4l3aFIDeu7cB+eJSi4eDj2AB6a7Gd/v1imfDhnXIZAUPxhDMQw4DBA1JCPt7bXmGBxU4GR+KhUKaIDH5w6ncwIyLSsj5CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757159642; c=relaxed/simple;
	bh=2SVe/qF2MX4UfKUgnxa9tDBt4d6boWhrMnC7J+zjBkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=efoSlKYr9QSA4c6+ZgLMnAnEtS/KlU+Od5vgZj+tEr8LoNV3TKaKtUbdDzqdtdDYQHCYWxWg1NgBXOk7XZAGklx1HjrXvEchbb21hU7wHPBJvnCMOWiSENH0KX+QDgGb74/Myi80aVXrTJ541dXRWI8JK2RohAQDh3f7N8NbFk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=imCk4z3a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FFF6C4CEE7;
	Sat,  6 Sep 2025 11:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757159642;
	bh=2SVe/qF2MX4UfKUgnxa9tDBt4d6boWhrMnC7J+zjBkY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=imCk4z3a9aZTWdxNKwHA9hQSA7AAKS97fsCTZdKzwgpuwH+J+Fq5YrrbBDI1xn+oN
	 NgIyziz4qVxUG4+10DM2sSxCG2DUbra5TpjCPr29fl3jAWMSm013U7nERZnkZHej+S
	 Fdftm/20x22k+b0eCQvWl/kyOd6vZp4rnoczfdd8=
Date: Sat, 6 Sep 2025 13:53:59 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Danilo Krummrich <dakr@kernel.org>
Subject: Re: [PATCH v1 0/2] driver core/PM: Two updates related to power.no_pm
Message-ID: <2025090638-arson-scrawny-ceb5@gregkh>
References: <12749467.O9o76ZdvQC@rafael.j.wysocki>
 <2025082851-progress-unsliced-ade4@gregkh>
 <CAJZ5v0hn9NXvHPy6zV4R4y0AHtN2BfN41wjd5s7dos0wx6ih0Q@mail.gmail.com>
 <CAJZ5v0gj33W-2FOswYoBLQQyTj0wr_EuMUdLiL_tdt4t=ss-jg@mail.gmail.com>
 <CAJZ5v0ifvwbPs1VKBMpWdanBKUdHSZuNandbF9=uhec56DynNw@mail.gmail.com>
 <2025090658-cucumber-velvet-ae53@gregkh>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2025090658-cucumber-velvet-ae53@gregkh>

On Sat, Sep 06, 2025 at 01:53:11PM +0200, Greg Kroah-Hartman wrote:
> On Wed, Sep 03, 2025 at 01:33:18PM +0200, Rafael J. Wysocki wrote:
> > On Fri, Aug 29, 2025 at 9:09 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > >
> > > On Thu, Aug 28, 2025 at 1:20 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > >
> > > > On Thu, Aug 28, 2025 at 1:07 PM Greg Kroah-Hartman
> > > > <gregkh@linuxfoundation.org> wrote:
> > > > >
> > > > > On Thu, Aug 28, 2025 at 12:55:50PM +0200, Rafael J. Wysocki wrote:
> > > > > > Hi All,
> > > > > >
> > > > > > Applying this series will cause power.no_pm to be set for faux devices (so they
> > > > > > don't get processed unnecessarily during system-wide suspend/resume transitions)
> > > > > > and power.no_callbacks to be set along with power.no_pm (for consistency).
> > > > >
> > > > > Oh, nice!  I forgot about that entirely.  Should these be backported to
> > > > > older kernels as well?
> > >
> > > So do you want me to resend these patches with suitable Cc: stable tags?
> > >
> > > Alternatively, I can just apply them with the tags and route them
> > > through my tree, whatever you prefer.
> > 
> > In the absence of more feedback, this is what I'm going to do.
> 
> Thanks, sorry for the delay, been swamped with conferences and travel :(

Wait, I can take them right now, no need to resend them.

greg k-h

