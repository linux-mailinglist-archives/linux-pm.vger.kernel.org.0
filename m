Return-Path: <linux-pm+bounces-20036-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4722A03E6F
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jan 2025 13:00:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B4533A2C8D
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jan 2025 12:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C001EBA18;
	Tue,  7 Jan 2025 12:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nRN8iLh/"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A142414AD2D;
	Tue,  7 Jan 2025 12:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736251246; cv=none; b=JNmfxr6TxTDlc6+z8iJhtsySj6bol3p1GnEvAnN/aP0kz+X8+N0SIdee1rQrmI9LNtkJVI9srBKeXjLGeKuwOs7ZZhX07jZa8+FL0Ve6I2KyQnfJhRt/8aSVsSJ3DT4YFWMiK7ofwY9pmpLj9sUPxAL2CTEEv+qOikCbOwX/CNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736251246; c=relaxed/simple;
	bh=ZR1lSFv84QRbwim/wKRWVL7gUxFQbxrvPHagzNf6QaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cep8GB1V4ui3xZHvvdhz1TfsBZVakCKdVaoRWNTpi89nbPSAtrzpC4jeEptm4o7WHfy/Rx/jBikCn4lUdGHH4B+kuvq7XUDuvh/b65GR5KRCn/icr+z4mCagrvJYqy2P4g4nynmpr2WPDbtzXXkaoEfZfc065z+OYE7Y/ilaYNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nRN8iLh/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6892C4CED6;
	Tue,  7 Jan 2025 12:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736251246;
	bh=ZR1lSFv84QRbwim/wKRWVL7gUxFQbxrvPHagzNf6QaM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nRN8iLh/rs2FsJy0gnvYqA0097zG572nuZ5+HRelaPIWaEy7xBotwxvAp4R786HaG
	 p2g+QGK7dHNQDQZJ9UysgKEfkYVFKvgtUr9/Cek6yB2VSQb0K9mC4Dlf9j0o6JXgyo
	 wQpkZVnWHjWKMTlmTkpB1EUeL2C8qO4OyPxso6s4=
Date: Tue, 7 Jan 2025 13:00:43 +0100
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
Subject: Re: [PATCH V6 03/15] cpufreq: Rust implementation doesn't parse
 BIT() macro
Message-ID: <2025010752-vagrantly-juiciness-cd81@gregkh>
References: <cover.1736248242.git.viresh.kumar@linaro.org>
 <9719ba8b3a921bd9f2cb7ebf902c54c708b5409d.1736248242.git.viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9719ba8b3a921bd9f2cb7ebf902c54c708b5409d.1736248242.git.viresh.kumar@linaro.org>

On Tue, Jan 07, 2025 at 04:51:36PM +0530, Viresh Kumar wrote:
> Rust isn't able to parse the macro for now, avoid using it.

No, please fix it.  You don't want to have to fend off the checkpatch.pl
cleanups that this would cause of people putting the BIT() macro back.

Make BIT() work properly for Rust code as well, it has to be done
eventually, right?

thanks,

greg k-h

