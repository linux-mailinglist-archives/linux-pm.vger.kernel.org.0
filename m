Return-Path: <linux-pm+bounces-27341-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96165ABBCD3
	for <lists+linux-pm@lfdr.de>; Mon, 19 May 2025 13:42:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B4F53A71B8
	for <lists+linux-pm@lfdr.de>; Mon, 19 May 2025 11:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8986327586C;
	Mon, 19 May 2025 11:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YlCztRWz"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F9A275841;
	Mon, 19 May 2025 11:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747654880; cv=none; b=NqkOjRgyakfV7PsIPwGJelpiv0vyWiYeTKMejSy+td7UyOvSnI2SXdavRGu26LREIkrBzoeu+ekJKZrW3Cnp/0QH3Qp6hPC0mtNdLUgV8bH+BYKeVSYfHvfvGt/IaXGP4kCT305rec/ADqY6vF/q77POBaxfzdsrai+vp5Cunhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747654880; c=relaxed/simple;
	bh=XKSfFCNj8EnxgCES6aIVmpmQO7wWDa6AFurBdNDUS2E=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=oTMezcfTKmjFaK3KeajKgw/AB7QD+NGbE81prNXB2CDg4yafLF5pmdwwR0Ypl9UQIuNI5twMPbfV3E+cLNxNIqC1IU6N2jUGJABwpSRpyorW7gjfbW6c+jwxbSmJeZO0PPIZpBNGiRYrVhC17F57CkCuytGy6NHDaM1zOSGRDd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YlCztRWz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 044B2C4CEE4;
	Mon, 19 May 2025 11:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747654879;
	bh=XKSfFCNj8EnxgCES6aIVmpmQO7wWDa6AFurBdNDUS2E=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=YlCztRWzZg6BgJoATb8JE0jjkPjXxhTtmIk1S9phuKDjFaCn2vVlD5tS5MLbxF621
	 ZeDp2qAOZzdwpBEfpdSwQA5DM/9AqEgr4y4Z10jDS5+ncfwGaSVrhwls8LFTwlXm5q
	 G7PtEfYI0oOk/cpjSEu7AZQ4xRO/YPEWE+qZ18trp3CUSiw/EOlUap2EgSTY6qAzPJ
	 470WWKiQTRkTMIwgL3rOG1QaJrR5EaYqlER2FNQFVYN9HaGXXr9ppzkq8kcrBDwQXM
	 BnQ7qGCU19zKv/2AETQNndm7X99Pczx48EMOKPC9tEZYepvcBYl2LT/gz4kEhL2s0w
	 qfSGVY17POZug==
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 19 May 2025 13:41:12 +0200
Message-Id: <DA03Y4OQIZ50.157T5EEVHQVMI@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Miguel Ojeda"
 <miguel.ojeda.sandonis@gmail.com>, "Danilo Krummrich" <dakr@redhat.com>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>,
 "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <benno.lossin@proton.me>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 <linux-pm@vger.kernel.org>, "Vincent Guittot" <vincent.guittot@linaro.org>,
 "Stephen Boyd" <sboyd@kernel.org>, "Nishanth Menon" <nm@ti.com>,
 <rust-for-linux@vger.kernel.org>, "Manos Pitsidianakis"
 <manos.pitsidianakis@linaro.org>, =?utf-8?q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, "Joakim Bech" <joakim.bech@linaro.org>, "Rob
 Herring" <robh@kernel.org>, "Yury Norov" <yury.norov@gmail.com>, "Burak
 Emir" <bqe@google.com>, "Rasmus Villemoes" <linux@rasmusvillemoes.dk>,
 "Russell King" <linux@armlinux.org.uk>, <linux-clk@vger.kernel.org>,
 "Michael Turquette" <mturquette@baylibre.com>, "Andrew Ballance"
 <andrewjballance@gmail.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V12 13/15] rust: cpufreq: Extend abstractions for driver
 registration
From: "Benno Lossin" <lossin@kernel.org>
To: "Danilo Krummrich" <dakr@kernel.org>, "Viresh Kumar"
 <viresh.kumar@linaro.org>
X-Mailer: aerc 0.20.1
References: <cover.1747634382.git.viresh.kumar@linaro.org>
 <68906d67109c3b323b54469fb1ee44e10c1c5b1e.1747634382.git.viresh.kumar@linaro.org> <aCsQylyW7R5rC15m@pollux>
In-Reply-To: <aCsQylyW7R5rC15m@pollux>

On Mon May 19, 2025 at 1:06 PM CEST, Danilo Krummrich wrote:
> On Mon, May 19, 2025 at 12:37:18PM +0530, Viresh Kumar wrote:
>> +///     fn exit(_policy: &mut cpufreq::Policy, _data: Option<Self::PDat=
a>) -> Result<()> {
>
> This can just be `Result`, here and below.

Since I saw you mention this multiple times and I agree, I created a
clippy issue: https://github.com/rust-lang/rust-clippy/issues/14848

---
Cheers,
Benno

