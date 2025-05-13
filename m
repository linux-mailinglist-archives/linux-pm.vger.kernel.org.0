Return-Path: <linux-pm+bounces-27073-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE1DAB53A4
	for <lists+linux-pm@lfdr.de>; Tue, 13 May 2025 13:16:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 038957AE9BE
	for <lists+linux-pm@lfdr.de>; Tue, 13 May 2025 11:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05FC428D8EC;
	Tue, 13 May 2025 11:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mlj81oyJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CAA328D8D7
	for <linux-pm@vger.kernel.org>; Tue, 13 May 2025 11:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747134935; cv=none; b=D66yk3+aeCmzW+8v5npp+wMXbY+Hwvxv3bnHaZ7hTZOQW8FdpQ5aPqtPTIeSHNTW4ljacJLen+aeJqyufhqr3Xk+h6S55Ll5+6bKqvZ7+ZOH4bhoVV0KThYPnMVdsg9kjmS4wj+iyyHui3WGxgaxb5PSlrt7AdLMz+YkyQ64vm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747134935; c=relaxed/simple;
	bh=AhF8bIdnTy+Y/qxrf9w8y8UJ6QfJLOXbePlpFq4yrMI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z9Vt6kUG/DrH3ipbNpg5NgFg7NoDlmZxW3w4CBbgydAN5BkGeEseDDZ9i+JxJyVNNjPc0BP3toeHvCpJwIKNZ12j0BBDsiOWhvJAzdD8RY+OIS5tRixOrcUO5J9F/lJ5d+iLmYDLZN/Z2HZGUbrV/SaKdniyk0wX3sZskMp6anA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mlj81oyJ; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5f5bef591d6so11499027a12.1
        for <linux-pm@vger.kernel.org>; Tue, 13 May 2025 04:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747134932; x=1747739732; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AhF8bIdnTy+Y/qxrf9w8y8UJ6QfJLOXbePlpFq4yrMI=;
        b=mlj81oyJoJ64ktqmeZOytjre33jrHXdGJmYvnda9+Wmj/Zpmlk05crvmS8y3EC8oVY
         /qzcS+cx8H2VTTuuwYu2legqJedbrvycN7e81f5uAU/cYfcQRBQ7Qk5bnoj8jOns/omn
         TixGPUgcCoAFoDm4ghAt8z90E/g7dB8Leycs/c0VEaIlqRk9lncegIe+vs7ZuCn+VTgL
         /qjENpd3vQtaLL12Ju3V5V6QbxAy4TH8qVaSFYF2RXD7vULXQH+0wLDY9dn0DHvITvwD
         HLNn+Rzq+qLgOjThI24sSP/5IwV/0zD9K4VyxWgVCDQStoPt9PkDSZzLBQhxzEEs8wtB
         GqaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747134932; x=1747739732;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AhF8bIdnTy+Y/qxrf9w8y8UJ6QfJLOXbePlpFq4yrMI=;
        b=aA9Kg/htpcPH3FLW7z2e2nMHesaP+WG9yvRi6f/BhM6chlF6Z/7kgD05paqGRUsRuY
         jexY4GNv/UBXuIGjC/BSXOjg3FPFYgJXxZIpkfFAHLNHrCOXl+OPTJj8n6SDetG/vOyK
         Llj4IIK1bLZLr0o6dfH9jgFs9W0mGPB0mMKwKjGZVs7qfA5i0DPJhz+36xNbrJEqCtcj
         ELGRFhUNbR6QmVfRJp1iuBAlCS0WFW08ikW1XxHrf1jCS5jbvGAt/IWV03fzCewfKvBA
         ER+9DOeNPivFIynFJoROcgycrV1sPrPGCIyt+5EZdjjiL0vnJCc7nTeny4wlaNsK9vfL
         9lEg==
X-Forwarded-Encrypted: i=1; AJvYcCVJSDsvXt3pprvjtGitCVor7yndRDJlNaZz5ppIuid+2CUm7l37ock7Hqbedvjg6mToZRCMBfm++g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzN6cBYnftyWmMoJKbtD8oI/68XVz8fj7LL4KpJrOrCXCJSUEhn
	LqAx3hipW02gvkrtk3iRALBLSPpBb5J9zHNHkwPAYfCYa1DCSi7XEgoS7I5789aP0yfruqe19GZ
	abSGdQRkaS5XHBRyXagXudzGHRmNxctG7YCbYVw==
X-Gm-Gg: ASbGnctPycaemmV8OEg+NToDjiC4lqMJ9/EhfSv6J3Y+9OdboErGF4IOGvSVmjRC9Zc
	gLHpvFmUpBqgyC1lOWKZyCwZMOR6oEX4EEA1wgMSGHaL5Fuh5Iyg9ig4IKohiAVCy/ZUs3Z0t+Q
	I9XW4JjmFTTtx8kyT5sjqymC6777dr2bQ=
X-Google-Smtp-Source: AGHT+IGXf+iDKLrrQHjlB4FGrZFbBhRWOjCFwyUy3x8K2OYM0ZMXpOMeBMC/MhaRMSqpdupGiUbH5DeaQQlfucFHbjA=
X-Received: by 2002:a05:6402:354a:b0:5e5:bb58:d6bd with SMTP id
 4fb4d7f45d1cf-5fca0759a40mr14459799a12.10.1747134932219; Tue, 13 May 2025
 04:15:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250502070109.inpes2ou3rxx2fxp@vireshk-i7> <20250506101311.142475-1-andrewjballance@gmail.com>
 <CANiq72k3ozKkLMinTLQwvkyg9K=BeRxs1oYZSKhJHY-veEyZdg@mail.gmail.com>
 <CAKohponbEEP4_weUuKkOGLRj5-1oOsoL_Zu_7W_SxB61hjsSCw@mail.gmail.com> <CANiq72mSDEwDQx6ePq20SRi40aCs95mwo6fShZ0WCK9rmiWVVQ@mail.gmail.com>
In-Reply-To: <CANiq72mSDEwDQx6ePq20SRi40aCs95mwo6fShZ0WCK9rmiWVVQ@mail.gmail.com>
From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Tue, 13 May 2025 12:15:20 +0100
X-Gm-Features: AX0GCFt2EYzacWRAlkaHJqajAcqqOrheeZjX9e1wO3lRfd_bCajvJq8aw75ONa8
Message-ID: <CAKohponPm5z0Rdy7FkYoo+YfhfQtfUUE65Oq9kYVNaCLRVPNUg@mail.gmail.com>
Subject: Re: [PATCH V11 00/15] Rust abstractions for clk, cpumask, cpufreq, OPP
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Philip Li <philip.li@intel.com>, kbuild test robot <lkp@intel.com>, 
	Andrew Ballance <andrewjballance@gmail.com>, a.hindborg@kernel.org, alex.bennee@linaro.org, 
	alex.gaynor@gmail.com, aliceryhl@google.com, anisse@astier.eu, 
	benno.lossin@proton.me, bjorn3_gh@protonmail.com, boqun.feng@gmail.com, 
	bqe@google.com, dakr@kernel.org, dakr@redhat.com, 
	daniel.almeida@collabora.com, gary@garyguo.net, joakim.bech@linaro.org, 
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux@armlinux.org.uk, linux@rasmusvillemoes.dk, 
	manos.pitsidianakis@linaro.org, mturquette@baylibre.com, nm@ti.com, 
	ojeda@kernel.org, peterz@infradead.org, rafael@kernel.org, robh@kernel.org, 
	rust-for-linux@vger.kernel.org, sboyd@kernel.org, tglx@linutronix.de, 
	tmgross@umich.edu, vincent.guittot@linaro.org, vireshk@kernel.org, 
	yury.norov@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 9 May 2025 at 09:43, Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
> I can still reproduce it on next-20250508 with defconfig RUST=y
> KUNIT=y RUST_KERNEL_DOCTESTS=y and then running in QEMU with e.g.
> `-machine virt -cpu cortex-a53`.

Here is the full log from my side: https://pastebin.com/u7UK58rQ). It
doesn't report
any failures.

Also here is the code we are talking about:

/// let mut mask = CpumaskVar::new_zero(GFP_KERNEL).unwrap();
///
/// assert!(mask.empty());
/// mask.set(2);
/// assert!(mask.test(2));
/// mask.set(3);
/// assert!(mask.test(3));
/// assert_eq!(mask.weight(), 2);

I don't understand how this test can fail at your end after the
first three `assert!()` have passed.

--
Viresh

