Return-Path: <linux-pm+bounces-20498-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4395AA129AC
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jan 2025 18:21:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66DC916757F
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jan 2025 17:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7B181553BB;
	Wed, 15 Jan 2025 17:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GNh/Sh2R"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CAE270812;
	Wed, 15 Jan 2025 17:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736961665; cv=none; b=NtoTxzhOq+F1XdEho6IActEFqTMkxIxheTqTfTnPvXI1gcCxNreP2ycrAc+HVKhJgtYiG9gOpGhnhFQ8im9VkzTIpeMkNyrB4ER5RMpBtz1JyxFFDdVoKHqEtjTfO+e7yn8eAEE65TbSJ2fHNwWzgw85TRcVU2LwIViK5mh8p80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736961665; c=relaxed/simple;
	bh=idndYGRuDCLSrzsIcv8CVqEM1gx5hlvJHQ2Fg5xwLvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e/8sXfHBIZCePNioBAcvOEgXhhKRY7ICdpL+dR+CvHWMIYDZA9TKOxNQYezaa61aX+COdnVBmnu2TN1M4IEalM1howFXocWwDjXY/pmj59FppP6WFSW6ZTNmxgSxfIrNNWUCjMofck/+rNRXGZTQgUQUuIEaYpa9gPHVOSL/whc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GNh/Sh2R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C1B2C4CED1;
	Wed, 15 Jan 2025 17:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736961665;
	bh=idndYGRuDCLSrzsIcv8CVqEM1gx5hlvJHQ2Fg5xwLvI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GNh/Sh2RUKen3Jv4RXnSkAnI7F7dUZVsbF5BSpRyIJT1cHDTwm/ZGydq3uX2HbjcM
	 6zQu1FjgUlJVYf6mR/eXvlDZrRBKLaKBzc7IBy7/F9gf6s/erxme7gislaY/PVk9IF
	 8Pd8z7S78IkohWaoP8Ne6fsal9vTKuMB97/iphGk=
Date: Wed, 15 Jan 2025 18:21:01 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rob Herring <robh@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dirk Behme <dirk.behme@de.bosch.com>
Subject: Re: [PATCH V7 04/16] rust: device: Add property_present()
Message-ID: <2025011520-slam-showy-fea9@gregkh>
References: <cover.1736766672.git.viresh.kumar@linaro.org>
 <f43fe3f7b3151a89c261ad728b0f3bb2fc24caef.1736766672.git.viresh.kumar@linaro.org>
 <2025011429-gossip-hash-12e3@gregkh>
 <20250115071538.efb2ipmbmynvwt3p@vireshk-i7>
 <20250115073515.hxoflf65mq3pyhpx@vireshk-i7>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250115073515.hxoflf65mq3pyhpx@vireshk-i7>

On Wed, Jan 15, 2025 at 01:05:15PM +0530, Viresh Kumar wrote:
> +Rob/Dirk,
> 
> On 15-01-25, 12:45, Viresh Kumar wrote:
> > On 14-01-25, 19:42, Greg Kroah-Hartman wrote:
> > > On Mon, Jan 13, 2025 at 04:52:59PM +0530, Viresh Kumar wrote:
> > > > This implements Device::property_present(), which calls C APIs
> > > > device_property_present() helper.
> > > > 
> > > > The new helper will be used by Rust based cpufreq drivers.
> > > > 
> > > > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > > > ---
> > > >  rust/bindings/bindings_helper.h | 1 +
> > > >  rust/kernel/device.rs           | 7 +++++++
> > > >  2 files changed, 8 insertions(+)
> > > 
> > > Want me to take this in my driver-core tree now for 6.14-rc1?
> > 
> > Sure, Thanks.
> 
> I now see that Rob/Dirk have sent [1] a bigger patch earlier which adds
> this functionality along with other DT bindings. Though it isn't
> merged yet.

That's still in the RFC stage, I'll take this now so that when the RFC
patchset is rebased/resubmitted, it will be smaller.

thanks,

greg k-h

