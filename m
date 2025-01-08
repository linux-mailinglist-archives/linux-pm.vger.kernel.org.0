Return-Path: <linux-pm+bounces-20084-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB06BA05A63
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jan 2025 12:50:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F6293A3058
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jan 2025 11:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E06E1F8EE3;
	Wed,  8 Jan 2025 11:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="znru9lfr"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DEC1F8AC5;
	Wed,  8 Jan 2025 11:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736337035; cv=none; b=ADJlpoLD4SODtDbAeFPu9OIUznOYDLkbuTfLWiT5eCbZGiJL9vWPzAIoalVIAfOoRqAVSAN3NYxnEhaa7ab2XGKg0hhxrJd3ceO7iiI7rkGuwYX8PwU2ILUGHHYpnijCRLPLt2S4OLKxKUyNawV0FNgAPUlPYOYDGxsxLTYLJto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736337035; c=relaxed/simple;
	bh=BoLXX7XYpxd/U6Nm2iQ92uiHNFw+C/LJDP8mzIvwnSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TNW+Gysh/m8fz+LtgdMxQdCgaL4qZRmHRdhk9xP8SiHDmDMJogsHY8UwUb2hvvpmIWjWHrYNcNYufsc/N0jppg2qKDaIJHkN8QZ4j2qFHYX61d1Hvo8atVtzL2m25zERhom6OjMdoHIQslUCf0OEBZFYpCTabPw7i5cg1OAUwsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=znru9lfr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 144F9C4CEDD;
	Wed,  8 Jan 2025 11:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736337034;
	bh=BoLXX7XYpxd/U6Nm2iQ92uiHNFw+C/LJDP8mzIvwnSI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=znru9lfr9V75NXHW+iSNLRjnR/4DL7+jL2AXjyw+PY6wVabWWJbVOd90v9y8kHpl8
	 JFWL85m9bkC7JYmXbc5NCIYVs/F04nZlsEsnF05yNO7rY2cDONRAkFEFSPv98wCfYA
	 HG1cXwXJIR0+/U2gcQXCnx8piFfB7ax1ahOyfQPk=
Date: Wed, 8 Jan 2025 12:50:31 +0100
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
Subject: Re: [PATCH V6 02/15] cpufreq: Add cpufreq_table_len()
Message-ID: <2025010855-cargo-quickness-a08f@gregkh>
References: <cover.1736248242.git.viresh.kumar@linaro.org>
 <867ba9728179ba21ff8f8aca97d416b72ccd63d9.1736248242.git.viresh.kumar@linaro.org>
 <2025010727-banner-monday-1941@gregkh>
 <20250108111253.tg6ixurijf2dvptx@vireshk-i7>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250108111253.tg6ixurijf2dvptx@vireshk-i7>

On Wed, Jan 08, 2025 at 04:42:53PM +0530, Viresh Kumar wrote:
> On 07-01-25, 12:59, Greg KH wrote:
> > On Tue, Jan 07, 2025 at 04:51:35PM +0530, Viresh Kumar wrote:
> > > Add a function to calculate number of entries in the cpufreq table. This
> > > will be used by the Rust implementation.
> > 
> > Again, why is Rust unique here?  Why wouldn't the C code also need this?
> 
> How about this:
> 
>     cpufreq: Add cpufreq_table_len()
> 
>     The last entry of a cpufreq table is marked by setting the frequency
>     field to a special value: CPUFREQ_TABLE_END. The C code manages to
>     traverse the table by checking the frequency field, until it reaches
>     CPUFREQ_TABLE_END.
> 
>     The Rust cpufreq bindings though will need to know the length of the
>     cpufreq table in advance, for example to check against an invalid index
>     value.
> 
>     Provide a helper to calculate number of entries in the cpufreq table.
>     will be used by the Rust implementation.

Odd, why can't Rust also know where CPUFREQ_TABLE_END is?  Why do you
have to do extra work here?  That feels wrong.

thanks,

greg k-h

