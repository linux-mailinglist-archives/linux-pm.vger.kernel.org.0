Return-Path: <linux-pm+bounces-21653-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4543CA2E605
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 09:06:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7E26166961
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 08:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6CCC1B86CC;
	Mon, 10 Feb 2025 08:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m27lSY7O"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433D117B402
	for <linux-pm@vger.kernel.org>; Mon, 10 Feb 2025 08:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739174802; cv=none; b=W9Gnb3ktmKGggKcP4w6ETigtuQqlU+cLm9BPiPChO2D33m5hTwDrtnL/4YIDwDDx92eiaNmndf61/IjsmLzUtQTX4cfsE/RmaeQhIJsmSOQS0wn+dS9MQKEhVfr94Hrz06SrPWwynE9ccRRDlHQvC+uTHQOGoEhHAJGsRdzYtvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739174802; c=relaxed/simple;
	bh=A3OrU86yFSA3UhFhMSz4sxiRiOlmLl05dbOqahKg9xw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QucRjk7X/ggRUkMezVDmjX8gGWY3ELBy7Z2M85KkXMkkwbA5bSTWz5S2CN1QbIQEP8fTZgyIUiIMJxNykq8c9wE9SKa1i0ndNod3TUixr1b4lY9KGxWNAoXo213FCLVehBIOdWh2IjbvPyLpvEI63D3MQfiJ2o+dg5NMhUB+nO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=m27lSY7O; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-21f6a47d617so23853525ad.2
        for <linux-pm@vger.kernel.org>; Mon, 10 Feb 2025 00:06:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739174800; x=1739779600; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IVXeQyKN4QJ5pjBqKy+7ctyC/+A7eWtC3q0uB/7UlNk=;
        b=m27lSY7Oo1Mk0TmNYy7yC37wyNWccthhFHF1r5bBI3BKVictqc0OamNVc3I8Hj6zJP
         Jk4J8V2jDafWpDymraz8Jeo33YNbHgKbxkNVAFruJaeIiRTPhnqGAsQVnvnPlw6H/7pO
         G/ZbScaLirb0/zJmNFMOqLA4AID9CigV1cFd/Q8lJLUsvJ/0T0SWo3ulSmNCUKaPuMe+
         Lan6a7EVuH45zIW99KaTD7tS8drPvUu5FpckkC6gzcw7GRV9kplLS8mmzxbS01vdfcxa
         t3XEEtNAbcG7fP8VSPBy2hDcrzr9yuNxvm60lm7BqN76T5II/y3SfCH2MlDolmFiCxE8
         G7wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739174800; x=1739779600;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IVXeQyKN4QJ5pjBqKy+7ctyC/+A7eWtC3q0uB/7UlNk=;
        b=qodA/kdQ3h9RYsslq3arZss0mJE0GFJFfiBtQVR0RGEoDkP7XgcUeFVem00SMQdIpd
         E2lgA+GKyaywcA06IByXfXKc5vKbIDAFBBFVvrAJHyeHvNR3+Uv/LC2kxEV6J0j2kK17
         bjwaIbi31Y1oi/cUNgIDwSvcrttbqe9lX5t3D/Yfhakx+t5TNrF/aSJE5DxXo2L61hnN
         sgDKuq7VkwnS2H+5zUW5LXDhEBvLtm71/eVHc3sNyqkeNyFYzDQ5sJ65lXIvgACmcPQT
         UxNoQsiQzPsVuNpsaC3MIXidPVbhHd2SUTZgZT79rnLruDH/bGeiW/f7Q781+OrGJGe5
         53iQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSg4u0ktpFtX4+ZGoT9C3mkXU6D2tqG3kTfFXnGkTjxt/fZ1y8QfgGYzFmoqMToDFUG+e/2JyhOw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/KwE1pDEqkJe/Z8DxsMdLoNWtJ4lEzxYwHPew6LjejvPfHlRk
	a+2joUK5XWydV3b+Ty3Bkqd7Ol8lGVx0JOIn3EVUOcXxum1188Xrjj8M7wq/wmw=
X-Gm-Gg: ASbGncv8ECTr6nGB8K/NCccUWQyDnnaGypdONVxTlOwabc+q9uD97kOxzlPFVwiJt+M
	hhox31QiP9zZN0LB/gpY1coVyPEKRgCMwLxKulzyV+7o0+sHbSvibP3kpdU0hwNyB+30EHGmcY8
	RKLxheO9BeO3GQssyXXvvhvW8Zpwjsa192jAFK0c0KFCvv3CsvOjGlZSzIfrqHJYW4j4jmKxQl5
	lm1kB/lHqQICR62Z2qodZGW2DjMZQbw1ORl2fEh3VySVrMfBJY/oTvJ5RrWb+Jsti+AtLqjnoj/
	1GOVIz+S6geLZrdusg==
X-Google-Smtp-Source: AGHT+IHM4kYVoFgxrWVd43dBTvU4IzoZ0Z6Z31Y/z3cQy6J4+x70snoVsJeMXCdxFbw0M5vVFErOEQ==
X-Received: by 2002:a05:6a00:2289:b0:72d:65c1:ad01 with SMTP id d2e1a72fcca58-7305d509d46mr23026216b3a.21.1739174800438;
        Mon, 10 Feb 2025 00:06:40 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-730764c4b51sm3623175b3a.55.2025.02.10.00.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 00:06:39 -0800 (PST)
Date: Mon, 10 Feb 2025 13:36:37 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Stephen Boyd <sboyd@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Danilo Krummrich <dakr@redhat.com>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Michael Turquette <mturquette@baylibre.com>,
	linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Nishanth Menon <nm@ti.com>, rust-for-linux@vger.kernel.org,
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
	Erik Schilling <erik.schilling@linaro.org>,
	Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Joakim Bech <joakim.bech@linaro.org>, Rob Herring <robh@kernel.org>,
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH V8 06/14] rust: Add bare minimal bindings for clk
 framework
Message-ID: <20250210080637.ic4fxcn6tmllqgaq@vireshk-i7>
References: <cover.1738832118.git.viresh.kumar@linaro.org>
 <c68081e18d939aefc7f6dac798df6b72e81bba4b.1738832118.git.viresh.kumar@linaro.org>
 <Z6ShsuLykigNscz8@pollux>
 <Z6SiiRubSXGInbgj@pollux>
 <0cd42d2d683ea057e6034978b02c7f84.sboyd@kernel.org>
 <Z6VBo51g54xAmelQ@cassiopeiae>
 <20250207092448.n5mzbt6lg6zqud4a@vireshk-i7>
 <52a3d4fc-b08c-499c-ba47-7a1d782b57db@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52a3d4fc-b08c-499c-ba47-7a1d782b57db@kernel.org>

On 07-02-25, 18:19, Danilo Krummrich wrote:
> On 2/7/25 10:24 AM, Viresh Kumar wrote:
> > On 07-02-25, 00:11, Danilo Krummrich wrote:
> > > On Thu, Feb 06, 2025 at 12:05:59PM -0800, Stephen Boyd wrote:
> > > > Quoting Danilo Krummrich (2025-02-06 03:52:41)
> > > > > On Thu, Feb 06, 2025 at 12:49:14PM +0100, Danilo Krummrich wrote:
> > > > > > On Thu, Feb 06, 2025 at 02:58:27PM +0530, Viresh Kumar wrote:
> > 
> > > > > > > +/// A simple implementation of `struct clk` from the C code.
> > > > > > > +#[repr(transparent)]
> > > > > > > +pub struct Clk(*mut bindings::clk);
> > > > > > 
> > > > > > Guess this should be Opaque<bindings::clk>.
> > > > > 
> > > > > Sorry, I meant NonNull<bindings::clk>.
> > > > 
> > > > NULL is a valid clk. It's like "don't care" in the common clk framework
> > > 
> > > Thanks for clarifying!
> > 
> > > Guess this should be Opaque<bindings::clk>.
> > 
> > So it should be this now ?
> 
> I actually meant NonNull<bindings::clk>, which I corrected in a subsequent mail,
> where Stephen pointed out that NULL is a valid value for a struct clk.

Ahh okay, so no changes required now. Thanks.

-- 
viresh

