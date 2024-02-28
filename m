Return-Path: <linux-pm+bounces-4519-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 091B986B559
	for <lists+linux-pm@lfdr.de>; Wed, 28 Feb 2024 17:57:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C58A1F257AE
	for <lists+linux-pm@lfdr.de>; Wed, 28 Feb 2024 16:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6DB1208D5;
	Wed, 28 Feb 2024 16:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QB3r/qRI"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833866EF10;
	Wed, 28 Feb 2024 16:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709139414; cv=none; b=AO9r6dvSAPHnY77flnajr7nEd8Ihii6wlz/bL8muV0Kfm01k1BKtiLx51DtRNsl539dyNpMPS+vXZvsI1z+QQqPoymnXvkGb7cKOl8BT4Y6Zn2I6awCxNXLZuTcL/QpYNhv4exTXaPZati0nukhmngR95vjnvdZHIb1CsjePvE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709139414; c=relaxed/simple;
	bh=j8GW5PM05J1eAob6plV8ZY09tWLXwx3VfJvudI3zpx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CeXZkFt1pczSsIvS+we5M3kKEkpfwZwVT7Tpdy5X/Eq29l6e1T7drYG6qhVlyCrqgT077A6+QwduBZkB1w1t4Hg1KhlROtMYf634jFSd7l+1ALtIum79oEKFQ2gqgYyzPFCYV97uZTC+j8sTF/oLRtqkGv5VcgYkciOCF+6k0L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QB3r/qRI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3549AC43399;
	Wed, 28 Feb 2024 16:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709139413;
	bh=j8GW5PM05J1eAob6plV8ZY09tWLXwx3VfJvudI3zpx0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QB3r/qRIx/u9gXVXlbY/IYNL+g/tdiv0GzEOVBTyiHegvQDwBaTaGjm7ZE9xY89+6
	 f/G6zZzL13nXctyCJdnlEZ82fh/dKtLCwe/VWu05aGyZQfgk1KlNjakwk4rCEaG4CB
	 h0ovQZ0b016/rxeNkJVs1xgKwPvghpQdKPozy1fYsurBDtoKprTzYUS8yTNUZy5ere
	 bwk9XgA3aSqr6Yb1M7CM5DRbTw6dK6xsxZp/EcW0kaPikflydMFjZvDb+YsnlS/AvQ
	 BpJn++NEwa0OIGTeU4W+Jo4t14JZYPnCMy2GmIQbOzY1GGGZ6GzxYrw3bGT08Ryy+w
	 3C5lLT+c6ioKg==
Date: Wed, 28 Feb 2024 09:56:51 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: Kees Cook <keescook@chromium.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>, rui.zhang@intel.com,
	gustavoars@kernel.org, morbo@google.com, justinstitt@google.com,
	stanislaw.gruszka@linux.intel.com, linux-pm@vger.kernel.org,
	linux-hardening@vger.kernel.org, llvm@lists.linux.dev,
	patches@lists.linux.dev, Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] thermal: core: Move initial num_trips assignment before
 memcpy()
Message-ID: <20240228165651.GA2158263@dev-arch.thelio-3990X>
References: <20240226-thermal-fix-fortify-panic-num_trips-v1-1-accc12a341d7@kernel.org>
 <6a6be01d-3453-4268-8b2e-0279cc20835d@linaro.org>
 <CAJZ5v0h87k6xoi-9V0Cfb2rHQcr-STfG_bNWpzfoj4Dy46U0Lw@mail.gmail.com>
 <f81af0ae-7458-47d3-90ae-71d5217ee7dd@linaro.org>
 <202402270816.0EA3349A76@keescook>
 <bbc65508-eb0e-4d63-921b-85d242cc556f@linaro.org>
 <202402270852.E46A5268@keescook>
 <3ed4ad69-1229-4834-95b7-9397364ea401@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ed4ad69-1229-4834-95b7-9397364ea401@arm.com>

On Wed, Feb 28, 2024 at 08:41:07AM +0000, Lukasz Luba wrote:
> Hi Nathan and Kees,
> 
> On 2/27/24 17:00, Kees Cook wrote:
> > On Tue, Feb 27, 2024 at 05:47:44PM +0100, Daniel Lezcano wrote:
> > > Ok my misunderstanding was I thought sizeof() was calling _bdos under the
> > > hood, so when calling sizeof(flex_array), it was returning the computed size
> > > inferring from the __counted_by field.
> > 
> > Yeah, sizeof() has a very limited scope. __builtin_object_size() has
> > more flexibility (via the 2nd argument, "type"), but it was still
> > compile-time only. __builtin_dynamic_object_size() was added to bring
> > runtime evaluations into the mix (initially to support the alloc_size
> > attribute, and now includes the counted_by attribute too).
> > 
> 
> Thanks for your earlier emails explaining these stuff.
> Do you have maybe some presentation about those features
> for the kernel (ideally w/ a video from some conference)?

I think Kees's 2022 and 2023 talks at LPC are a good place to start:

https://youtu.be/tQwv79i02ks?si=Nj9hpvmQwPB4K3Y4&t=452
https://youtu.be/OEFFqhP5sts?si=u6RnOP641S8FkouD&t=614

https://outflux.net/slides/2022/lpc/features.pdf
https://outflux.net/slides/2023/lpc/features.pdf

Cheers,
Nathan

