Return-Path: <linux-pm+bounces-20466-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 585DFA11B8B
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jan 2025 09:09:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6CEB7A3DF6
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jan 2025 08:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26C8C231A49;
	Wed, 15 Jan 2025 08:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="R6RNCFlL"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7C823098F;
	Wed, 15 Jan 2025 08:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736928548; cv=none; b=Oqz0bFioesC/kSlFgtiWEvPFJs4LsT2p5cf99Yrw4t9vLpkrIqFX4/cD/GvxaW2+bHC64oHU8bQlLzbVmRJJf1c6Pk+iQzfnow2wTKrwckk/fNDacKB+equYZM/cIdPPTUgeylemzvZc23MGvfW3tgB3hIWzI2Vo2fXSpn0246E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736928548; c=relaxed/simple;
	bh=QVkkfviSVRJOqcZfgQ4bLIfzFOeeIgJNsUcxNpRJaNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uU7Yw6cdmI9CSBw0CYocuY2sG2AaekmWGlBG3Y4kJXQCevA31nhCtWgMYKgMaEmwv8393YhxikB2YV6+joBElW+iDB9NjijQCc4kAUgsj1DVtXK5EccNzdpyRYh7RLz6nR9V2GKGNI1FJeaHqZV3p/Zfkd1wY5AHW0aQlx6Cmw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=R6RNCFlL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9AC0C4CEDF;
	Wed, 15 Jan 2025 08:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736928547;
	bh=QVkkfviSVRJOqcZfgQ4bLIfzFOeeIgJNsUcxNpRJaNQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R6RNCFlL+Z4OGgB/vqF+BkAu+wF4wzldZVvkaRI71uilgJbSNfHzRtzhWcfcMUF+V
	 dkZoewmRGbIcd9KNEEkFdDmjFNhxn0N9aimMa0VhLGyYCcbTI8sYbZdL9HM03wHE96
	 4UjFnJyCRd9YiRUOJnglN/QPQbZo1BDVNc1ddxF4=
Date: Wed, 15 Jan 2025 09:09:04 +0100
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
Message-ID: <2025011556-regroup-swapping-623a@gregkh>
References: <cover.1736766672.git.viresh.kumar@linaro.org>
 <854f7b8c9cbcc7f38fe5ed548290f41224478b40.1736766672.git.viresh.kumar@linaro.org>
 <2025011430-humiliate-expansive-2ea4@gregkh>
 <20250115072050.72oeibi735k3pjdq@vireshk-i7>
 <2025011537-shuffling-unpaved-121a@gregkh>
 <20250115075859.mjpcvwctxx2vutpu@vireshk-i7>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250115075859.mjpcvwctxx2vutpu@vireshk-i7>

On Wed, Jan 15, 2025 at 01:28:59PM +0530, Viresh Kumar wrote:
> On 15-01-25, 08:54, Greg KH wrote:
> > Ah, but that's not really something that SAFETY should override, right?
> > 
> > Yes, you know your implementation of this will stop using the pointer in
> > the hotplug callback before it goes away but that's not documented here.
> > And having the device "fail" afterward isn't really ok either as you are
> > relying on the driver core to always check for this and I'm not so sure
> > that it always does on all codepaths.
> > 
> > But, I'm ok with this for now, as you are just copying the bad C model
> > at the moment, but it really feels like a huge foot-gun waiting to go
> > off.  Any way to put some more documentation here as in "use this at
> > your own risk!"?
> 
> What about marking it unsafe ? That would require callers to document
> why it is safe to call this. And yes add more documentation here too.

Sure, that's fine with me.

