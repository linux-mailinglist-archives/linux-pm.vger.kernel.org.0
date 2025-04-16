Return-Path: <linux-pm+bounces-25532-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E28FA8B595
	for <lists+linux-pm@lfdr.de>; Wed, 16 Apr 2025 11:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65367444D4A
	for <lists+linux-pm@lfdr.de>; Wed, 16 Apr 2025 09:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F80235362;
	Wed, 16 Apr 2025 09:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p2elSX90"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5917233D9E
	for <linux-pm@vger.kernel.org>; Wed, 16 Apr 2025 09:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744796246; cv=none; b=cfJ6Uxzvw2wkM1EJksk/Tj3wP6mowjv4VS8hdNLYSJQjqge0M0y8YDZQdQmvStKLXIDol3p5KiqJj265b0bKEbCfPkydbRTmHSIdDDYlH0Dq0TvC7yUCZCS+PULT1HGRrQVG8Y3CAC8vAIDakR7GQAurKALGL68EUmq4wn1PcYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744796246; c=relaxed/simple;
	bh=xDRV50am1uwJ3dYPe1nR1llHcTg9L3o2BG7AtzvBVzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b9BmtQJ8H6ghc52mThkrcKIf21bgCWUhWdqXXYbQTl4/GLWQzdt65H9ZouC29xCfmTZv9oLIHNyyoeSTxHXUxyzMa35vsX9T6emQsTeVeiAAm7MoYmIopKhESX6aDpmULlsgZkYI/g6awsTwGc/WvAIqe7ITDRH2cqz5w2oKXhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=p2elSX90; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-af59c920d32so4774834a12.0
        for <linux-pm@vger.kernel.org>; Wed, 16 Apr 2025 02:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744796243; x=1745401043; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EuIyIm6sZTMZArdD30j0ddzGV/xgeW5+S45t3DvjQXo=;
        b=p2elSX90HFZ0pjIQGQoZSW6MRqgjtDmV5TRbyPnn80uA1caj0vIW2FoPNmEyR8az1S
         5ccPww6scRnBGgkW6nC0iYdO5Xg+nxWxKN3u/7Pw1FPEZD2/MXE7NsOtoUoxPtnlm0N4
         nkoE+Mw5i5iD62crBVi3lxoreC5HIfCsSE3t2ehpySodxRb9rTHpyWNlDtCrK9TnHInl
         kK/ARizgpI/BY0M09p+3TGN6aOlWumi/lYFguet3zUa6rFshi2frqcTgOgSD5oNqffpz
         4457/yVbTGQj8yMZR7QxUkG0r7xFjkcPYKCPfA9XOYKTh5KSzA14zog6qp41ZGUgGFpU
         zMyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744796243; x=1745401043;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EuIyIm6sZTMZArdD30j0ddzGV/xgeW5+S45t3DvjQXo=;
        b=n2n5tr1EOTrWas2WVvSdCPj4qvURmenxNxPZYShOZSDibjfJCooppq05wIjG/iKwNl
         ECMWsvy7cS4a9mPGaSy5atbR5pNWA9P04he1resnleHKC2E+v9lqBJM5tQiTsyyA85pU
         HM+mqZNOZn8aUE8jYlh5EW2dd1fbgjwbQ51rLW8RDEkq3qCTbFkpLFZWAtCtl224955f
         Pb31/0J69JtG4RSGAioq3PaQOEnqgv39HjHJSOD+5DWUCW2t5cHJbbr0ViziB3EtVBmr
         +GOSIihoZeFgjLU76oClNQxD3YW6vX90adNmWKxYXoNK3iPuAywTzu8jbJ5YP/23przX
         qkzA==
X-Forwarded-Encrypted: i=1; AJvYcCVpVIKsODHflI9UJzVkY2yKlPtbqjOkFv8aKTpgUtFB2R6V9q64gW3U/1pQ1SPTy1nkNQuT8n3PUg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh7L5KMwknI2UqbdEn+zDRpqlRpNmh8Zxb9m2fpgRJeZEb2gzy
	irfFfCeCu2/fc5VwIIG5/gYk+E2tVLNI0zElQCOXz8yYd7e04IkbFuv6E/iWqEY=
X-Gm-Gg: ASbGncuCZancQKmY3CBLyPbtPGonFaTSQWh47GA0+SeMy3E0EZEqu63/fnR+i55VhKj
	othU3M8tC+G2xR0v3iSwL7HA6gL2aoQf1i62h8wVlrxmQzPKX5a5qx3z/KJ2F2+zfd53qWJk1ea
	vNtPYe8S/mm4EAUfnwFPM3xe34VVAAzkVOf00b9gOWHOveWboRxQWqTjR2Kra6OGDp8f44prEU5
	ceV73iOIX3VyXRqjXi90J1axSYy5FKAS9tHypprXQ5v3sGw1sOeLWvVgm/NhmGVliXSRKn1kXyV
	PbsFF+Iq9p67ZDd4QYu1kQ/n/gny99t74gA1Mg+akA==
X-Google-Smtp-Source: AGHT+IGMj4OiKyJmwOzSShOY9H/GEFXprL1SUguzHiNfobC3rdZAN3fM5jCJbJJ86ToDX6h/RmYvCA==
X-Received: by 2002:a17:90b:2d10:b0:2ee:dd9b:e402 with SMTP id 98e67ed59e1d1-30863f18c46mr1987535a91.12.1744796242950;
        Wed, 16 Apr 2025 02:37:22 -0700 (PDT)
Received: from localhost ([122.172.83.32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-308611d6d2fsm1117988a91.1.2025.04.16.02.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 02:37:22 -0700 (PDT)
Date: Wed, 16 Apr 2025 15:07:20 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Danilo Krummrich <dakr@redhat.com>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
	rust-for-linux@vger.kernel.org,
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
	Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Joakim Bech <joakim.bech@linaro.org>, Rob Herring <robh@kernel.org>,
	Yury Norov <yury.norov@gmail.com>, Burak Emir <bqe@google.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Russell King <linux@armlinux.org.uk>, linux-clk@vger.kernel.org,
	Michael Turquette <mturquette@baylibre.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V10 11/15] rust: cpufreq: Add initial abstractions for
 cpufreq framework
Message-ID: <20250416093720.5nigxsirbvyiumcv@vireshk-i7>
References: <cover.1744783509.git.viresh.kumar@linaro.org>
 <ac6854885277b23f100c6033fab51a080cdb70eb.1744783509.git.viresh.kumar@linaro.org>
 <Z_904KuBhKbO738_@pollux>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_904KuBhKbO738_@pollux>

On 16-04-25, 11:14, Danilo Krummrich wrote:
> On Wed, Apr 16, 2025 at 12:09:28PM +0530, Viresh Kumar wrote:
> > +#[allow(dead_code)]
> 
> Why is this needed?

Looks like leftover from a previous version. Same for the other one.

I have also made a change to the cpufreq driver now to remove
`dead_code`, hope that is fine:

diff --git a/drivers/cpufreq/rcpufreq_dt.rs b/drivers/cpufreq/rcpufreq_dt.rs
index 81ede13909b7..0d1612ff5677 100644
--- a/drivers/cpufreq/rcpufreq_dt.rs
+++ b/drivers/cpufreq/rcpufreq_dt.rs
@@ -43,12 +43,9 @@ fn find_supply_names(dev: &Device, cpu: u32) -> Option<KVec<CString>> {
 struct CPUFreqDTDevice {
     opp_table: opp::Table,
     freq_table: opp::FreqTable,
-    #[allow(dead_code)]
-    mask: CpumaskVar,
-    #[allow(dead_code)]
-    token: Option<opp::ConfigToken>,
-    #[allow(dead_code)]
-    clk: Clk,
+    _mask: CpumaskVar,
+    _token: Option<opp::ConfigToken>,
+    _clk: Clk,
 }

> > +    pub unsafe fn data(&self, index: usize) -> u32 {
> > +        // SAFETY: By the type invariant, the pointer stored in `self` is valid and `index` is
> > +        // guaranteed to be valid by the safety requirements of the function.
> > +        unsafe { (*self.as_raw().add(index)).driver_data }
> > +    }
> 
> Those three functions above look like they're supposed to be used directly by
> drivers, but are unsafe. :(
> 
> It looks like the reason for them being unsafe is that with only the pointer to
> the struct cpufreq_frequency_table array we don't know the length of the array.

Yes.

> However, a Table instance seems to come from TableBox, which *does* know the
> length of the KVec<bindings::cpufreq_frequency_table>. Why can't we just preserve the
> length and provide a safe API?

The Table is also created from a raw pointer, when it is received from
the C callbacks. Also the Table can be created from the OPP table,
where again we receive a raw pointer from the C code.

I tried to do this differently earlier and finalized on current
version after some discussions on the list:

https://lore.kernel.org/all/2025011327-cubbyhole-idealness-d4cc@gregkh/

-- 
viresh

