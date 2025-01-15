Return-Path: <linux-pm+bounces-20462-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 038D4A11B56
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jan 2025 08:54:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 641977A34CE
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jan 2025 07:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA15F22E419;
	Wed, 15 Jan 2025 07:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XGWcrPpJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6AD2080E3;
	Wed, 15 Jan 2025 07:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736927653; cv=none; b=Y8Frgld25/bTKfa9wOaEaTQUnLDJ8dDgA4JLY1ucozMsMYdFacN0rfgF1pQzCqp92KoaURTEmgy/LmlyOKInQUo+4ekXqtesV9OekIv1o/V9fU9y3xoSRbmDy8HpxPgfkWkpWyctXTNOkPCcWG+XtnmRF6S4hunOY5BEKbk8uo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736927653; c=relaxed/simple;
	bh=X/l7FawYSYHZ8Mlk4c11D/X+JSdiQqQGx6oXqhwxltI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s67vwdS8NVXaFxtMvwapbOOw91HeyPJRcNXLhkF1WHcsi0PqraNRK17sHAswKNmblRN+uJxeRQt+I6mhgrtxu5xHnXOn5tIljQNYb5gRlLMsiM+5C1qlADRdJD5NU3pvA/+9TUOX1oRLPHkTCf8TIvLpd2gbyyJDmfbZZdF1kVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XGWcrPpJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63CADC4CEDF;
	Wed, 15 Jan 2025 07:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736927653;
	bh=X/l7FawYSYHZ8Mlk4c11D/X+JSdiQqQGx6oXqhwxltI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XGWcrPpJ6nABvT/fCNgWSbZjkfZfOOsoyS/ePHXistwysWxqrIGeLqOvMLN11755z
	 oR19wctirpYRMWsMH2eGSNtFh1aBQtXFTI+sYfzbgQGEilnbTyqfni+TKbIPRPGUz6
	 8rRozkj3dM+e2jkt/m2Bo7116CgNe0+1yfRUQk0U=
Date: Wed, 15 Jan 2025 08:54:09 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH V7 03/16] rust: cpu: Add from_cpu()
Message-ID: <2025011537-shuffling-unpaved-121a@gregkh>
References: <cover.1736766672.git.viresh.kumar@linaro.org>
 <854f7b8c9cbcc7f38fe5ed548290f41224478b40.1736766672.git.viresh.kumar@linaro.org>
 <2025011430-humiliate-expansive-2ea4@gregkh>
 <20250115072050.72oeibi735k3pjdq@vireshk-i7>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250115072050.72oeibi735k3pjdq@vireshk-i7>

On Wed, Jan 15, 2025 at 12:50:50PM +0530, Viresh Kumar wrote:
> On 14-01-25, 19:44, Greg KH wrote:
> > > +pub fn from_cpu(cpu: u32) -> Result<&'static Device> {
> > > +    // SAFETY: The pointer returned by `get_cpu_device()`, if not `NULL`, is a valid pointer to
> > > +    // a `struct device` and is never freed by the C code.
> > 
> > I thought it was pointed out that it could be freed when a cpu was
> > hot-unplugged?  Or is that a different device in the cpu code?  We seem
> > to have 2 of them and it's not obvious which is which :(
> 
> I did reply [1] to that earlier. The CPU can get unregistered but the
> memory for the device is never freed (it is part of struct cpu). Some
> calls on the CPU device may fail later on (if called for an unregisted
> dev), but should never crash the kernel.

Ah, but that's not really something that SAFETY should override, right?

Yes, you know your implementation of this will stop using the pointer in
the hotplug callback before it goes away but that's not documented here.
And having the device "fail" afterward isn't really ok either as you are
relying on the driver core to always check for this and I'm not so sure
that it always does on all codepaths.

But, I'm ok with this for now, as you are just copying the bad C model
at the moment, but it really feels like a huge foot-gun waiting to go
off.  Any way to put some more documentation here as in "use this at
your own risk!"?

thanks,

greg k-h

