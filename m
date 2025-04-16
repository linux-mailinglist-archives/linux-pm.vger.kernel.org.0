Return-Path: <linux-pm+bounces-25537-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F219BA8B6E9
	for <lists+linux-pm@lfdr.de>; Wed, 16 Apr 2025 12:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80AAE3BDA36
	for <lists+linux-pm@lfdr.de>; Wed, 16 Apr 2025 10:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1799F23496F;
	Wed, 16 Apr 2025 10:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JD+HC2/K"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C1822DF96
	for <linux-pm@vger.kernel.org>; Wed, 16 Apr 2025 10:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744800021; cv=none; b=Vy85mDGdbHsDmE8smr8dCK8KkUj9/eftbs95HFoiJNA6qvuy+5UbzAodAgKuaY1dmiW1YetepDwxWZzUQxd/0oYJBvf/y88d3fkGQ6BTBDzAtm7o40AGanoT530QN17+OJYrDF6dGv2WUt5fx4uIREnNZo1ruq/NwONE/d5MzP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744800021; c=relaxed/simple;
	bh=AW7LAXhV4M8nrRRBsTVlNww4j59JMk/7529JME2B/rc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h1fb/ygf9dDHI5vxy8eEPAtfGpPOkLZbdvgG+DXwoPO0TSTurzc483iU68GxJJOmEElyER8wwY89nsUBnwzqYGsNjYxiA4iZQY+FBiBe21OOlZskPF2Iy9pyffbn0ODa9nB8VcUHCq5HDWtV7wk1NVAadkNgmxr0yls+bHRXU9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JD+HC2/K; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7376e311086so8670961b3a.3
        for <linux-pm@vger.kernel.org>; Wed, 16 Apr 2025 03:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744800018; x=1745404818; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ttWNacvPGMYQA86vkqzo9EZOaHGhJM4Jor7D4v7bz+0=;
        b=JD+HC2/KLl5Kw1IwDPOQX1FlAefqYt5X4wCei0hd2eRydlFAvDFGe5D872rawwIKpb
         tp5hIEPbOxZdeMzAsYCu9B7HUXtxXErxMBAqaCtE6NpMOP+epDQIx6bTe8VSaQThnFvX
         YNgbTWwtKQ258NojH3FFi+DYLcIWIeEXFTReA9k89RMiOV7csOOHBkWMXGtY0slfGQ7f
         lLTOKdoPwDdrSTTXLhqagSTfbp0wr70b+A9Dk0vj+SlqbFNJX9rGdHKAKeEXg549PWp1
         Y2Vb4Ta8yi3b66F6coUD0kfIMJXDTOpBbnqaoRL50Lv1YM+3yMCPYV8oCmCh7KZQsRYZ
         hnyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744800018; x=1745404818;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ttWNacvPGMYQA86vkqzo9EZOaHGhJM4Jor7D4v7bz+0=;
        b=Lw5tD2kCXot1hrEwizwpfzcVtd14ZcR6khpBvuSRSdasJOM+zN36jqLxzv1d/BVnFf
         S5bXYQD1v0xqzPWkHYPtw6qdkg3XTbJUZAmma5EC3c3nplL0HTuPyewIiJO4LyySKoaz
         utbuxon0D/p7xU/jDze+xWfPtJ02HXWD2O/XvaZdEBGzMQHkcJZ7oFdopbzaTSjqxaxf
         /xVuA1Auo/Q7JaFFAACfkJhLR+NBtVYb+2eBTkCkmn4Ifp52Yv5BHOtpwrLO90GvD1wa
         EqhXqxpi9C+E2keYuEBnxOox0xG6ddokSeln1GPgHqaZjgOqzDF5+se46DBonTnseqHC
         KT8A==
X-Forwarded-Encrypted: i=1; AJvYcCXyIo1MaRXyLYQmoPGhYx2dQne/yRVaQsAHy+1T4BWkrNqb5vV6fcrKns97F/wdpaND5mLmY+lz2g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+tp94JEOXVHo5InGgxDl16iW8w+fcYdOZDEES7zDqLRL9ij9l
	s2lWaQCh2YcVY8znQC0mEQr9wIeCpUE3Vr9W7KjO1GhvgC9DZT+5GiZAa6Cwzlk=
X-Gm-Gg: ASbGncuwVI1GKo8fS4d091briBubOndXtVC/AKLx0N3lnCgwcPZjz9KmKKoHHqzi/k+
	3Qj5aGtKM/DPpW6G3PrdvVeDtjwRqdXu8cafAwcESg3Ne1DU7h2fdHgyncveu4yLoxvArPAMafj
	FDAWg5KCKtg6OFQIA2qTRC4vYpztlLUi9X8IPjpEHF9OswIMrIXdTHL/sCGKoIvsgUyXsiPwIMr
	30Fi68lk21BepqEqITNlpVhUgzF1shu77cqhkC0BfRN3zFNvvH5JfwoyanhoRxnZTdbxAFGY64Z
	XIDUaHDNVz0vZHmSQKUJSSdoYdISzK+/aKZwnMXbXw==
X-Google-Smtp-Source: AGHT+IGwBbJAub8B5aJaGw+Dq2HNzt5OaEsdk5WiMT3ZEcrD7+h/HrHX+IN/nBZbxfI2sbK6SePbFw==
X-Received: by 2002:a05:6a20:9c8a:b0:1f5:8eb1:d5d2 with SMTP id adf61e73a8af0-203b3e90173mr1985396637.13.1744800018636;
        Wed, 16 Apr 2025 03:40:18 -0700 (PDT)
Received: from localhost ([122.172.83.32])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b0b2221e78csm808883a12.73.2025.04.16.03.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 03:40:18 -0700 (PDT)
Date: Wed, 16 Apr 2025 16:10:16 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Danilo Krummrich <dakr@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@redhat.com>,
	Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	rust-for-linux@vger.kernel.org,
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
	Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Joakim Bech <joakim.bech@linaro.org>, Rob Herring <robh@kernel.org>,
	Yury Norov <yury.norov@gmail.com>, Burak Emir <bqe@google.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Russell King <linux@armlinux.org.uk>, linux-clk@vger.kernel.org,
	Michael Turquette <mturquette@baylibre.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V10 14/15] rust: opp: Extend OPP abstractions with
 cpufreq support
Message-ID: <20250416104016.mkzyitdm4moz4qts@vireshk-i7>
References: <cover.1744783509.git.viresh.kumar@linaro.org>
 <a940d1b1a02d99fdc80ba8d0526c35a776854cb3.1744783509.git.viresh.kumar@linaro.org>
 <Z_9v24SghlIhT62r@pollux>
 <20250416095943.f3jxy55bamekscst@vireshk-i7>
 <CANiq72=MQmUop5UzeeN-r7gAE0ep8Z+EUaLuA6exeazhZCHqLw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72=MQmUop5UzeeN-r7gAE0ep8Z+EUaLuA6exeazhZCHqLw@mail.gmail.com>

On 16-04-25, 12:31, Miguel Ojeda wrote:
> On Wed, Apr 16, 2025 at 11:59 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > +// Frequency table implementation.
> 
> ///
> 
> > +        // Returns a reference to the underlying [`cpufreq::Table`].
> 
> Ditto.

Hmm, I did not use /// as the comments were added to private
definitions.

Sorry for the dumb question, but why should we use /// in such cases ?
They will never show up in documentation anyway, right ?

-- 
viresh

