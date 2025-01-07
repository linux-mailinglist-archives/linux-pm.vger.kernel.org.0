Return-Path: <linux-pm+bounces-20038-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A65AA03E81
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jan 2025 13:04:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A068418851C4
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jan 2025 12:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219E31DF725;
	Tue,  7 Jan 2025 12:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="N1t8sgOL"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E989F8C1E;
	Tue,  7 Jan 2025 12:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736251492; cv=none; b=m18+Tm2jXiFkbqXjmzfGL1VPZ7G0VpmAQD4jpt84ng2blT1MBnIP6QIaVMIcqsQd/snSSR/LLqJww7bW1ggTPQzqNrTDyMtzlXaVm16GnD4lsf6jCnGMCgM6XnErj1uddAY7ignYphOt+vFby4qxmow8aqVYqSVsoxJP9HDruio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736251492; c=relaxed/simple;
	bh=jNO66Lvk4gGfb8OygBeSWxfpSXrqWD1Y9OHqnXMeE/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eZnF4cko7J4zVgYUAMm4Zr3EcmshHgBAUbWCzEhw4pRo8iE2rq3iYoSGHvJI3iJcCj2skx50HEWwpoZXSIuIwqIQvPRZTMEv8Qqy8YZpPhOg5Rukp/0t3TU3OVHK5mW3mJtSQz9CONOzRMx3UZrTZUAk0wDnHuj+02SiRfcYqzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=N1t8sgOL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0C27C4CED6;
	Tue,  7 Jan 2025 12:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736251491;
	bh=jNO66Lvk4gGfb8OygBeSWxfpSXrqWD1Y9OHqnXMeE/8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N1t8sgOLXrjN3XykcLakSLLnQuc3KXVEIIznSgB6kTXrxZUyegGs4d2IS3/1MbcL0
	 PZyXt2Gez/0Lxx/mRnmW7GDemfXlIwTOA3JKEOMTdAU8TPWG5O7Ehkg3hN85oToGo0
	 u+HMFn5k1DxRd0ig3ikgADRgrgst3yymO76Qe9hE=
Date: Tue, 7 Jan 2025 13:04:48 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Danilo Krummrich <dakr@redhat.com>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
	rust-for-linux@vger.kernel.org,
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
	Erik Schilling <erik.schilling@linaro.org>,
	Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
	Joakim Bech <joakim.bech@linaro.org>, Rob Herring <robh@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V6 14/15] cpufreq: Add Rust based cpufreq-dt driver
Message-ID: <2025010707-repurpose-clapped-0d22@gregkh>
References: <cover.1736248242.git.viresh.kumar@linaro.org>
 <41a674fc8ebca6174bcc3af6cdd9155a18b19d42.1736248242.git.viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41a674fc8ebca6174bcc3af6cdd9155a18b19d42.1736248242.git.viresh.kumar@linaro.org>

On Tue, Jan 07, 2025 at 04:51:47PM +0530, Viresh Kumar wrote:
> +impl platform::Driver for CPUFreqDTDriver {
> +    type IdInfo = ();
> +    const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = Some(&OF_TABLE);
> +
> +    fn probe(pdev: &mut platform::Device, _id_info: Option<&Self::IdInfo>) -> Result<Pin<KBox<Self>>> {
> +        cpufreq::Registration::<CPUFreqDTDriver>::new_foreign_owned(
> +            pdev.as_ref(),
> +            c_str!("cpufreq-dt"),
> +            (),
> +            cpufreq::flags::NEED_INITIAL_FREQ_CHECK | cpufreq::flags::IS_COOLING_DEV,
> +            true,
> +        )?;
> +
> +        pr_info!("CPUFreq DT driver registered\n");

When drivers work properly, they are quiet.  Please don't make us have
to go and remove lines like this from new drivers being added to the
tree like we did for older drivers in the past :(

thanks,

greg k-h

