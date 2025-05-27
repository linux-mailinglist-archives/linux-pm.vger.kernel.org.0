Return-Path: <linux-pm+bounces-27688-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB76BAC4FDC
	for <lists+linux-pm@lfdr.de>; Tue, 27 May 2025 15:33:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46E0B3B4011
	for <lists+linux-pm@lfdr.de>; Tue, 27 May 2025 13:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E48B327146A;
	Tue, 27 May 2025 13:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fIMZ3+5/"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61E629A9;
	Tue, 27 May 2025 13:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748352817; cv=none; b=BADSl08PvhD216p449v+1M2A5Qjb6shN+eHi4n08DqCAiry0Gv3wuLB4qAh3kwHasAL5u9saSFDIFn2U71ZGfI13zmPEJoEzClKghNb624PzlkKlcTsGFAUAQObL/x/3i0h2ggIGaacmq+BOsqrxcwrmqC4I0NbuqNFY5z9ffP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748352817; c=relaxed/simple;
	bh=Yreqtg9dXS+66jF3KiKpeR9AoTTlKwBiTIy4diGcyQY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HRgzrym6xjISj6jgdvGS6MNYPzwK/ZoGky6JK8Jf5S924UgV4uR8M0yLPMmZORwWcFTGW3OCgNMRiipPJ3XJEIYyMex7pAjuvLxqwMiipGA9uV3RiWjHC2WeFTj5VQzFYhF08Vh9Cr2C2Goyr6TIxVz990l/t9/yjrQDWJji/I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fIMZ3+5/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 207A0C4CEEB;
	Tue, 27 May 2025 13:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748352817;
	bh=Yreqtg9dXS+66jF3KiKpeR9AoTTlKwBiTIy4diGcyQY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fIMZ3+5/0ZqRdXA3U2cwAYmSlVzYIb3hJEsVnFRsN7eOilKcfNioI1MQJQiN2E8WJ
	 3Tm7PatE7f3l8xFMGR4SQPj7iEUjOnjtRS3tGiv5R3izTRT0rKZhO94eruptlTv+nR
	 RaBfMs131bLmk0HCm4Z7gR7WL8PHvMGA9yk+kYv59rFJ4wDM4GOdhhfDfpVu9+Kd6r
	 jCgI0cPIY0s3HqytDx4pLOzrzsglE7LDTCb5ShL6VLgDPn0JXllFZeYhbzplAJHG6V
	 HRxvxCumTcO/1s2NOQBTwJSr6O9fCoqk/VsPC7wtUokAuhjmZ/tGM7CZvHsofll4y6
	 ox5ZiV2hBovPA==
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-60634f82d1aso613472eaf.3;
        Tue, 27 May 2025 06:33:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUkyoSJ6jaaGV5LiJBqqPh7rw21icfqwhNHa7EuZsya7u9DdMwioOIPBQxsqY/GHbgL1gDHinkiS/k=@vger.kernel.org, AJvYcCUmI9bpKsU8gXRiSI/91pf9CzZMuZAglg9ArvL1dolQK48tQFo+JJQQW5F/Kc9WLjctC2suiilHunA3cCv6myo=@vger.kernel.org, AJvYcCVeRkZm4D7BtIRfZQLUhP/9rC54pWqrLnRlTYyIVMouVxz1XmRD+X4qKNi1AA6C7Fa8uwWrGkUkLn54mkw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyouD4LQTii9BIviHcngA/Sj3XSjxgozRjyvD3UeZrRIyIvyipB
	S3sHuHNJ/iotGhUHRsvBjyGFkeVPF0LiRgqgdn6wNpWcJlW+bVHG5VGIw46+6fk6Z/uVANFFcJc
	rSBufk6gDThbshZzp/vwHW13aL0LEgLo=
X-Google-Smtp-Source: AGHT+IFau92567au2cPuYAeAGw2urSGzecPQifSVDg7w8zBs1XpWLq+I5vuHek99lyWJrrswIdCtvq7ShRJx7g096Yc=
X-Received: by 2002:a05:6808:6f97:b0:404:ee1a:2057 with SMTP id
 5614622812f47-40646845fc8mr6864503b6e.29.1748352816387; Tue, 27 May 2025
 06:33:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <9d93c783cc4419f16dd8942a4359d74bc0149203.1748323971.git.viresh.kumar@linaro.org>
In-Reply-To: <9d93c783cc4419f16dd8942a4359d74bc0149203.1748323971.git.viresh.kumar@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 27 May 2025 15:33:25 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iSnZkEOmmeVnLJ=f+EQB5Xsa8yZY5g-0kEZm+Rovdnag@mail.gmail.com>
X-Gm-Features: AX0GCFvTqkJYSrSEu4gGBevBj1ylrAXBrfzJpN8JKF5VCANJ8k_C8tCnFZbj2o0
Message-ID: <CAJZ5v0iSnZkEOmmeVnLJ=f+EQB5Xsa8yZY5g-0kEZm+Rovdnag@mail.gmail.com>
Subject: Re: [PATCH] rust: opp: Move `cfg(CONFIG_OF)` attribute to the top of
 doc test
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
	Stephen Boyd <sboyd@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, linux-pm@vger.kernel.org, 
	Vincent Guittot <vincent.guittot@linaro.org>, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 27, 2025 at 7:33=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.o=
rg> wrote:
>
> Move the `#[cfg(CONFIG_OF)]` attribute to the top of the documentation te=
st
> block and hide it. This applies the condition to the entire test and impr=
oves
> readability.
>
> Placing configuration flags like `CONFIG_OF` at the top serves as a clear
> indicator of the conditions under which the example is valid, effectively
> acting like configuration metadata for the example itself.
>
> Suggested-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> Rafael,
>
> Sorry for the trouble, one more patch to apply :(

No problem, applied.

Thanks!

>  rust/kernel/opp.rs | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/rust/kernel/opp.rs b/rust/kernel/opp.rs
> index c2bdc11f3999..a566fc3e7dcb 100644
> --- a/rust/kernel/opp.rs
> +++ b/rust/kernel/opp.rs
> @@ -575,6 +575,7 @@ extern "C" fn config_regulators(
>  /// frequency.
>  ///
>  /// ```
> +/// # #![cfg(CONFIG_OF)]
>  /// use kernel::clk::Hertz;
>  /// use kernel::cpumask::Cpumask;
>  /// use kernel::device::Device;
> @@ -582,7 +583,6 @@ extern "C" fn config_regulators(
>  /// use kernel::opp::Table;
>  /// use kernel::types::ARef;
>  ///
> -/// #[cfg(CONFIG_OF)]
>  /// fn get_table(dev: &ARef<Device>, mask: &mut Cpumask, freq: Hertz) ->=
 Result<Table> {
>  ///     let mut opp_table =3D Table::from_of_cpumask(dev, mask)?;
>  ///
> --
> 2.31.1.272.g89b43f80a514
>
>

