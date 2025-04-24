Return-Path: <linux-pm+bounces-26099-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABF57A9A522
	for <lists+linux-pm@lfdr.de>; Thu, 24 Apr 2025 10:04:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46C5E3ACA33
	for <lists+linux-pm@lfdr.de>; Thu, 24 Apr 2025 08:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A210A202995;
	Thu, 24 Apr 2025 08:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uyF0OaGF"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EEC219CCEA;
	Thu, 24 Apr 2025 08:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745481827; cv=none; b=N3+jiJa6oYm0eIEzEZP0gvPGyc+HmfCSBS9IYsUzH3GPiev3+C0OIvxZREgiYU3sQyqeiaHkyYWKsO8rtuwtFi/+AG+IcPj49VYf7N+fp8J0+RH5RsSoAOuYX2OjCNZ5+XsT9MTKZCiPAqr3HkKjvJgoqpjV2HDnUTt8bWpeApw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745481827; c=relaxed/simple;
	bh=yE8LuY/N+dXgVtHCmocmCD2z6tU/Hf9npEsFFbSKxX0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AK5+bPwsK9sqoO6XumAdNU6o04yWmrysjVmpI6b5Wu4NQ/sngshLXYlkwXKzQsM//DwJ7ka7HE/tAVo5Fve1PfPdgl4mg5tiN9jNhodr3vVXRewtFkX6Vbk0PuuDaJ4c/Khmd9ce81y+dMdNt8tJidj0jcHEowluvk3JiTTk/z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uyF0OaGF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98E01C4CEE3;
	Thu, 24 Apr 2025 08:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745481824;
	bh=yE8LuY/N+dXgVtHCmocmCD2z6tU/Hf9npEsFFbSKxX0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=uyF0OaGFxy+ZC3XCBALcUCeaJAMgCzBbVXOwMSTDrWTLYhGA1IB5KjJEL+FNBlD+d
	 ++Tyr9rZYp3e+Ovq8fOSc2m6Fm7Y0RUn+XjuNSjG/Peh5/kA2tlO4cYPzqespW3rUh
	 YxU/vROMhZ6EhISGgGhz8wbBh8F9UQCDNaRSpr6+u4BHpG+YDwMq3l4kNBgUk+9kS6
	 CTZDmC9csTSZpXYk8MuBnnlFEAZeEOLsVipquGBO+jGDStcSS3EEfcQahpJOi9/K/j
	 A38Dp83+afyNTxm5oxaXjdZhKpcOD9xcUtrglHlqASmRzf/UtmSZJF96MPjwvkkP/b
	 IpSGEZlx9SQXg==
Message-ID: <c332c760-fa48-4159-a3af-e33bedc0e4ef@kernel.org>
Date: Thu, 24 Apr 2025 10:03:37 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V11 13/15] rust: cpufreq: Extend abstractions for driver
 registration
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 Danilo Krummrich <dakr@redhat.com>, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, linux-pm@vger.kernel.org,
 Vincent Guittot <vincent.guittot@linaro.org>, Stephen Boyd
 <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
 rust-for-linux@vger.kernel.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Joakim Bech <joakim.bech@linaro.org>, Rob Herring <robh@kernel.org>,
 Yury Norov <yury.norov@gmail.com>, Burak Emir <bqe@google.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Russell King <linux@armlinux.org.uk>, linux-clk@vger.kernel.org,
 Michael Turquette <mturquette@baylibre.com>, linux-kernel@vger.kernel.org
References: <cover.1745218975.git.viresh.kumar@linaro.org>
 <a14f6927488b5c7d15930c37a3069f46a5c888a2.1745218976.git.viresh.kumar@linaro.org>
 <6fc3e178-60f9-4b0f-9c56-6d983e4d1eed@kernel.org>
 <20250424062910.6zk7amxq4gjxtw66@vireshk-i7>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <20250424062910.6zk7amxq4gjxtw66@vireshk-i7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/24/25 8:29 AM, Viresh Kumar wrote:
> On 23-04-25, 14:08, Danilo Krummrich wrote:
>> On 4/21/25 9:22 AM, Viresh Kumar wrote:
>>>
>>> +    /// Same as [`Registration::new`], but does not return a [`Registration`] instance.
>>> +    ///
>>> +    /// Instead the [`Registration`] is owned by [`Devres`] and will be revoked / dropped, once the
>>> +    /// device is detached.
>>> +    pub fn new_foreign_owned(dev: &Device) -> Result<()> {
>>> +        Devres::new_foreign_owned(dev, Self::new()?, GFP_KERNEL)
>>> +    }
>>
>> Btw. if you take it for v6.16-rc1, expect a conflict with [1].
>>
>> [1] https://web.git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-core.git/commit/?h=driver-core-next&id=f720efda2db5e609b32100c25d9cf383f082d945
> 
> Thanks for pointing this out. I believe this branch is immutable and
> so I can rebase over f720efda and send my pull request after yours is
> merged ?

Yes, driver-core-next won't be rebased.

