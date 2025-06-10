Return-Path: <linux-pm+bounces-28351-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E196AAD3315
	for <lists+linux-pm@lfdr.de>; Tue, 10 Jun 2025 12:04:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B21B117423C
	for <lists+linux-pm@lfdr.de>; Tue, 10 Jun 2025 10:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2792428BAA1;
	Tue, 10 Jun 2025 10:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TyNXnWp/"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8361728BAAC;
	Tue, 10 Jun 2025 10:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749549769; cv=none; b=l/zS1gRT+oMG8tZe1AiX46djkjenUbqa61zrkOBf413RTZvVnLMwMWdGMaufr7wD1vnzK5z0J7EOGczxKzKFvBM21kgpYpmmZCP7RHEsWOBq7hd8kf8yZJ4igVk+x6RU7fVQFNqBExlv0Fv5PuxUAx3EAS8IvM++tQB4iZsHvFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749549769; c=relaxed/simple;
	bh=10QgRGlAdUB6j196B6SS3g0F3Ydy3EG+vkL/4Ux7/yU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S0ZfdKC4Mh+riWhBpyyrbV1A3p6hgxvgMqx8JSPay4Fx0zTHowjpBjVM35Ba9VekoAj5bgegRMsuAf3DiKuqv0hjtHPYSJC8H3uzzw+FjCQ9qnkE/5vdGeP0nLcyzXH9g3OTKZ77wMBEnoA+ZMGof25vS/QgwDdNwY9211Cj6Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TyNXnWp/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4620C4CEED;
	Tue, 10 Jun 2025 10:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1749549768;
	bh=10QgRGlAdUB6j196B6SS3g0F3Ydy3EG+vkL/4Ux7/yU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TyNXnWp/XjQS6G0rz7cg62OU0fVgQI9t7GZyP3AL8lXjRSLvNNWVvo1Z+C1Px+G7C
	 bfqql6lAhNvSWb97v6YVR9KqPc3dTHQ0C28RU9QR3dM9hWRLhKix+ccrwYeW3O2O5D
	 aTb/expteWzTEbdnUl7Um7Q3L0vVug/814OLGsXE=
Date: Tue, 10 Jun 2025 12:02:46 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>, rafael@kernel.org,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
	mcgrof@kernel.org, russ.weight@linux.dev, ojeda@kernel.org,
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, lossin@kernel.org, aliceryhl@google.com,
	tmgross@umich.edu, leitao@debian.org, david.m.ertman@intel.com,
	ira.weiny@intel.com, leon@kernel.org, fujita.tomonori@gmail.com,
	tamird@gmail.com, igor.korotin.linux@gmail.com, anisse@astier.eu,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH] rust: module: remove deprecated author key
Message-ID: <2025061038-trash-clammy-6e49@gregkh>
References: <20250609122200.179307-1-trintaeoitogc@gmail.com>
 <CANiq72==Xybm956Ete95e3YH7MTresNd3szxLg7GdzvhW1O+jg@mail.gmail.com>
 <826956a9-6a43-404a-8130-11a4a3dc663a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <826956a9-6a43-404a-8130-11a4a3dc663a@kernel.org>

On Mon, Jun 09, 2025 at 07:47:55PM +0200, Danilo Krummrich wrote:
> On 09.06.2025 19:39, Miguel Ojeda wrote:
> > On Mon, Jun 9, 2025 at 2:22 PM Guilherme Giacomo Simoes
> > <trintaeoitogc@gmail.com> wrote:
> >>
> >> Now that all in-tree modules have migrated to `authors`, remove:
> > 
> > Nit: I would have said "most modules", since we have new/remaining
> > ones (no need for a new version for this).
> > 
> > I think this patch is OK -- we could wait to do this more cycles, but
> > if we are doing it, then probably the sooner we do it, the simpler.
> > 
> >>  drivers/cpufreq/rcpufreq_dt.rs        | 2 +-
> >>  drivers/gpu/drm/nova/nova.rs          | 2 +-
> >>  drivers/gpu/nova-core/nova_core.rs    | 2 +-
> >>  rust/kernel/firmware.rs               | 2 +-
> >>  samples/rust/rust_configfs.rs         | 2 +-
> >>  samples/rust/rust_driver_auxiliary.rs | 2 +-
> > 
> > Andreas, Danilo, Greg, Viresh: if nobody is against it, I will apply
> > it this cycle. Acked-by's for your bits appreciated, of course.
> 
> Acked-by: Danilo Krummrich <dakr@kernel.org>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

