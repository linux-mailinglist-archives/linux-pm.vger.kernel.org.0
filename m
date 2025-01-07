Return-Path: <linux-pm+bounces-20035-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45CB7A03E6C
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jan 2025 13:00:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36BAA160CD9
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jan 2025 12:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4A61E9B3E;
	Tue,  7 Jan 2025 11:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uJQZtSEN"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80861E25FE;
	Tue,  7 Jan 2025 11:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736251188; cv=none; b=fSnnHdrIgdLtuH+Ntp7U4R1vPkfeHasq0nCvxDUD6XlvopD8KYA55eLgPg7zbLCcPARd75DiSzoexvAWn/o0JaMN8FLoc6loo2O2+WLKpZh+VWZldelKooeQT9IS8luN3ut2ccIlnD0pSvY/cELQcgTlVQKWkzvOMjILps1marc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736251188; c=relaxed/simple;
	bh=6Z2U0iw0kI6m8i6PtIB4z7wSp1MCMGFgNcIgiGGe19Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nyCh7B5W0VuPE9Gli+zeiuKmAxVEVLvFBpPWRkO8XM49vebnJLLQy3CLoyMOHbw6NKJfezWf6utIqHG+2X5keiGxgBkFPA1rw+8LWWS3JE79fSY9Z3TQLUE07ag+XBkHxufgUztZN10geAW534HtkfHWcArblEspDEaHt8zalJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uJQZtSEN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB9F8C4CED6;
	Tue,  7 Jan 2025 11:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736251187;
	bh=6Z2U0iw0kI6m8i6PtIB4z7wSp1MCMGFgNcIgiGGe19Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uJQZtSEN1lXNaFluGnk+w50lM1xdTi6tdk+S4TmqVJcFNS9fJbHlGZa+GeVKOwZ+8
	 4v3h2MN8EzIOVjg0U+ujlkQ0jD/1p0Mi5AtUQg4BjwUuCeSA7kch9ea6uaZNFekicg
	 iQx/T9OSdGeRFLhhWAvZtDcfgxyNtc+LkMtKbs0k=
Date: Tue, 7 Jan 2025 12:59:44 +0100
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
Message-ID: <2025010727-banner-monday-1941@gregkh>
References: <cover.1736248242.git.viresh.kumar@linaro.org>
 <867ba9728179ba21ff8f8aca97d416b72ccd63d9.1736248242.git.viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <867ba9728179ba21ff8f8aca97d416b72ccd63d9.1736248242.git.viresh.kumar@linaro.org>

On Tue, Jan 07, 2025 at 04:51:35PM +0530, Viresh Kumar wrote:
> Add a function to calculate number of entries in the cpufreq table. This
> will be used by the Rust implementation.

Again, why is Rust unique here?  Why wouldn't the C code also need this?

> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  include/linux/cpufreq.h | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index 7fe0981a7e46..6b882ff4dc24 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -783,6 +783,17 @@ bool cpufreq_boost_enabled(void);
>  int cpufreq_enable_boost_support(void);
>  bool policy_has_boost_freq(struct cpufreq_policy *policy);
>  
> +static inline unsigned int cpufreq_table_len(struct cpufreq_frequency_table *freq_table)
> +{
> +	struct cpufreq_frequency_table *pos;
> +	unsigned int count = 0;
> +
> +	cpufreq_for_each_entry(pos, freq_table)
> +		count++;

No locking is needed?  Why does anyone care about the length of this
table?

thanks,

greg k-h

