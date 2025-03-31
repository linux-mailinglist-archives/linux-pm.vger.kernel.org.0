Return-Path: <linux-pm+bounces-24660-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03086A76BD5
	for <lists+linux-pm@lfdr.de>; Mon, 31 Mar 2025 18:19:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A09BE167821
	for <lists+linux-pm@lfdr.de>; Mon, 31 Mar 2025 16:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C18DB211A35;
	Mon, 31 Mar 2025 16:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QIt8+jCs"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E0A1E1A33;
	Mon, 31 Mar 2025 16:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743437961; cv=none; b=j9JqLC9LRhjd5kGoKPyEandbUUSbLAMIjSYKdQsHJfuFlxRT4jnok6ojrHblz5YQB6FEYQg8PGLjT4aCu9GxfYOMvsPFKf95nR4TwFrGoUccLlgHtuvTAurYTYf2uXte2wPo+glEPDbddyjIC7OBSn8rPT+5r5cpH0E0vEvhYl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743437961; c=relaxed/simple;
	bh=roewgQHfIruVDUH6EBm5hwC6KAdFcxTLxOaU1wDesD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WxbiUFWacp0MXX20jXqEEuibQGNrXvaA1ZtDeARBeRxV+IdzSGAO8gBd8yE/iCYgHVj1+cnghHNd6Phz8SW27dyy97LfAz7vdYp4U7t/n+kr8smzTduUQljRUhXKJBFRT1ZuY5GqXPuVLe15KbBf5ie7XERX/H48OinZlu5/RPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QIt8+jCs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB3EAC4CEE3;
	Mon, 31 Mar 2025 16:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743437961;
	bh=roewgQHfIruVDUH6EBm5hwC6KAdFcxTLxOaU1wDesD0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QIt8+jCszsenhJLqxRjIQ72UdAMpuyuHV4ASuccWd40QaBVxDAukNsXxWLxNnQGHE
	 TloayNmbYzjkzBGeEhfqlySbn7AseYwZcqnLZgSninGB/kjG/9icTNyiozQ+L7/eEy
	 Y/5BDdXP5cH5SlnHgsYjssXmdniLpiyNSsT+3IdccyfWGfQzcMgcI/j7c7aqokIb0M
	 fooQ3KvooOrk0sIsRJ5Em64cImbjbc5MDw5pt7HsLx02xfn9fvb3IQmyn0I4x6yDHy
	 wsGfnyUEmZWXf4H8niRF++DGSpUDb4Jd5K9xYU3gIn58N2RIzRUDFXW+vIFOBOS2Y2
	 88XvzLxidG6fg==
Date: Mon, 31 Mar 2025 18:19:10 +0200
From: Ingo Molnar <mingo@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Xin Li (Intel)" <xin@zytor.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	pavel@kernel.org, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
	hpa@zytor.com, xi.pardee@intel.com, todd.e.brandt@intel.com
Subject: Re: [PATCH v1 1/1] x86/fred: Fix system hang during S4 resume with
 FRED enabled
Message-ID: <Z-rAfosRsjRfm7Ts@gmail.com>
References: <20250326062540.820556-1-xin@zytor.com>
 <CAJZ5v0jfak9K_7b=adf5ew-xDiGHUEPSp5ZpAGt66Okj-ovsGQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0jfak9K_7b=adf5ew-xDiGHUEPSp5ZpAGt66Okj-ovsGQ@mail.gmail.com>


* Rafael J. Wysocki <rafael@kernel.org> wrote:

> On Wed, Mar 26, 2025 at 7:26 AM Xin Li (Intel) <xin@zytor.com> wrote:
> >
> > During an S4 resume, the system first performs a cold power-on.  The
> > kernel image is initially loaded to a random linear address, and the
> > FRED MSRs are initialized.  Subsequently, the S4 image is loaded,
> > and the kernel image is relocated to its original address from before
> > the S4 suspend.  Due to changes in the kernel text and data mappings,
> > the FRED MSRs must be reinitialized.
> 
> To be precise, the above description of the hibernation control flow
> doesn't exactly match the code.
> 
> Yes, a new kernel is booted upon a wakeup from S4, but this is not "a
> cold power-on", strictly speaking.  This kernel is often referred to
> as the restore kernel and yes, it initializes the FRED MSRs as
> appropriate from its perspective.
> 
> Yes, it loads a hibernation image, including the kernel that was
> running before hibernation, often referred to as the image kernel, but
> it does its best to load image pages directly into the page frames
> occupied by them before hibernation unless those page frames are
> currently in use.  In that case, the given image pages are loaded into
> currently free page frames, but they may or may not be part of the
> image kernel (they may as well belong to user space processes that
> were running before hibernation).  Yes, all of these pages need to be
> moved to their original locations before the last step of restore,
> which is a jump into a "trampoline" page in the image kernel, but this
> is sort of irrelevant to the issue at hand.
> 
> At this point, the image kernel has control, but the FRED MSRs still
> contain values written to them by the restore kernel and there is no
> guarantee that those values are the same as the ones written into them
> by the image kernel before hibernation.  Thus the image kernel must
> ensure that the values of the FRED MSRs will be the same as they were
> before hibernation, and because they only depend on the location of
> the kernel text and data, they may as well be recomputed from scratch.

That's a rather critical difference... I zapped the commit from 
tip:x86/urgent, awaiting -v2 with a better changelog and better
in-code comments.

Thanks,

	Ingo

