Return-Path: <linux-pm+bounces-21557-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1932A2C9FE
	for <lists+linux-pm@lfdr.de>; Fri,  7 Feb 2025 18:19:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDECD18805D2
	for <lists+linux-pm@lfdr.de>; Fri,  7 Feb 2025 17:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B33218FC72;
	Fri,  7 Feb 2025 17:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uHWfCybx"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091CD18DB21;
	Fri,  7 Feb 2025 17:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738948761; cv=none; b=j7yaf9lgZE5T72GiVbvRYHI1xXbHLxiBlJxDwBx0Hio0HTrLemvEXjTKROtm/mLKsPuxGYJkoGqyow6MCwQb/ma/IVUZSqgcqkFgKUElkqS2GQN0pGx9dfW86vrgPZoD5RA9pxo8vKxKsCcqaeDG2LX5CwerJmZ1ysDO4WOmq1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738948761; c=relaxed/simple;
	bh=sdUkcNhVQ5Ph1CRzdktcyKpovBSX+j6bHeJqjw6Pme0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cKaCtlUkwzOS3n0kNym4rpIskWljVMeIqmH78n99VGIKVz0bLyqIk/DVx+x7KzgPeUMk6HH7y59c/kfbPJ5CivF8HrQknPdfs3YKZykeYH668mWm/gfyE0jIdCULyqr/uURcggkw6z3+PdAtSbRzEks17FZT6cEzrltc5WWCAzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uHWfCybx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B03EDC4CED1;
	Fri,  7 Feb 2025 17:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738948760;
	bh=sdUkcNhVQ5Ph1CRzdktcyKpovBSX+j6bHeJqjw6Pme0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=uHWfCybxKmDKxLPbJCai952AKWzoeLRR3Xgsq8OWU4rCAoJoCLjOAzlXjv8EulxJ3
	 6u7B7/ggvChz2k6lf5SWWexSBkukKo68xlmPg75gzZXVjbfRfIZVrbBfVsWNFKIIKA
	 12FL1MJ729o+AlBBszUVeUY+VsHNxrOEaZO9mxHkutGSN/yosIE9R2D4e9W/iXhI1R
	 VcRA5LzJN6b9YipC4WBsA0TnU5/X3604LXYRHCs5KTkhzPmkjvLEYP8yaMDgHW0xxN
	 feAq+w82tWo01y3f9Il7gQ9kBHwGprddW+d6lQyZdTaPxIqEyxgTyNj4S6IEJGzofM
	 QEAvAhY2uHOLQ==
Message-ID: <52a3d4fc-b08c-499c-ba47-7a1d782b57db@kernel.org>
Date: Fri, 7 Feb 2025 18:19:12 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V8 06/14] rust: Add bare minimal bindings for clk
 framework
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Stephen Boyd <sboyd@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 Danilo Krummrich <dakr@redhat.com>, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Michael Turquette
 <mturquette@baylibre.com>, linux-pm@vger.kernel.org,
 Vincent Guittot <vincent.guittot@linaro.org>, Nishanth Menon <nm@ti.com>,
 rust-for-linux@vger.kernel.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Erik Schilling <erik.schilling@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Joakim Bech <joakim.bech@linaro.org>, Rob Herring <robh@kernel.org>,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
References: <cover.1738832118.git.viresh.kumar@linaro.org>
 <c68081e18d939aefc7f6dac798df6b72e81bba4b.1738832118.git.viresh.kumar@linaro.org>
 <Z6ShsuLykigNscz8@pollux> <Z6SiiRubSXGInbgj@pollux>
 <0cd42d2d683ea057e6034978b02c7f84.sboyd@kernel.org>
 <Z6VBo51g54xAmelQ@cassiopeiae> <20250207092448.n5mzbt6lg6zqud4a@vireshk-i7>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <20250207092448.n5mzbt6lg6zqud4a@vireshk-i7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/7/25 10:24 AM, Viresh Kumar wrote:
> On 07-02-25, 00:11, Danilo Krummrich wrote:
>> On Thu, Feb 06, 2025 at 12:05:59PM -0800, Stephen Boyd wrote:
>>> Quoting Danilo Krummrich (2025-02-06 03:52:41)
>>>> On Thu, Feb 06, 2025 at 12:49:14PM +0100, Danilo Krummrich wrote:
>>>>> On Thu, Feb 06, 2025 at 02:58:27PM +0530, Viresh Kumar wrote:
> 
>>>>>> +/// A simple implementation of `struct clk` from the C code.
>>>>>> +#[repr(transparent)]
>>>>>> +pub struct Clk(*mut bindings::clk);
>>>>>
>>>>> Guess this should be Opaque<bindings::clk>.
>>>>
>>>> Sorry, I meant NonNull<bindings::clk>.
>>>
>>> NULL is a valid clk. It's like "don't care" in the common clk framework
>>
>> Thanks for clarifying!
> 
>> Guess this should be Opaque<bindings::clk>.
> 
> So it should be this now ?

I actually meant NonNull<bindings::clk>, which I corrected in a subsequent mail,
where Stephen pointed out that NULL is a valid value for a struct clk.


