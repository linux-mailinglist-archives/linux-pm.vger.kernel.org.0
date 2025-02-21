Return-Path: <linux-pm+bounces-22600-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE8F3A3ECEB
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 07:36:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D4F91891434
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 06:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BBA51FCD1A;
	Fri, 21 Feb 2025 06:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="idZAGIMr"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12BBA78F3A
	for <linux-pm@vger.kernel.org>; Fri, 21 Feb 2025 06:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740119712; cv=none; b=JSV2YrZ4lswk+UGaXmfWuTkiVQwylyQnZnIl0qwJ5x2u0BQeTQ8qKtdmL1dDdQGiI4Yd2FF8rld28fXGrMo7/M8B5h54WNz5yUBu3WyXdZHbj9iKjBZxV1CynFNDP1ed5+slw8BcZPhoRzknm49rxLTPe6jzOP60X3UGDU4u57g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740119712; c=relaxed/simple;
	bh=oc+EtHShi6bbNj9AJnLiY/NJj0NfEanMXEUTL2lUbmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hto5nPTIFUGQFFM49SgKudoRpKMYxVhquHuG+79R1+Cgox1bLtaX5NwSDA/d4huUmDzQHiVlsXnFm73RE0T3mO0I8AXnj4KcKyx4pJXMuc+z4jaXkrbQlm2jBDNFUL9BKJTDf+XYzS9NtGR9v40+HLnRqVXx4ek+jrzsULl0uzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=idZAGIMr; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2211acda7f6so36729275ad.3
        for <linux-pm@vger.kernel.org>; Thu, 20 Feb 2025 22:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740119710; x=1740724510; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4+iMivRKCEBsggc2rtGQq+coCu/bncplKGZAc6W2LxM=;
        b=idZAGIMr16AeU38mVAUPU1g9TanDgO5TeB7Pv4IqYTw6Sv/Iwz2dQT/nXj9EGQXEaV
         3SqdmwZz4Lo5Fda8PcJkT90hKaHznB3dEZUQbtNRl/i4L8HpxRNc1mHxDMRhtdo0A3Sm
         aFKT0MYtKtWXHTEAYH2eTMTxQaKq/L6wHJyRLYC3ZlTQCYWGU9y624JZ1/pK2N5bCvwC
         Bq1Ufa91CFoaCfQni5AvDauaED9YveH0TFTIhPoqnaDRWaBJ2KDzHPSlh7eObMngmwsW
         WR4+Qc6lO3Q8mD8nmz0VeZojSJTQIDoQ31SkZ19lGBT+mGbVN9D9WSwbJL2vD3M3lHqg
         t8tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740119710; x=1740724510;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4+iMivRKCEBsggc2rtGQq+coCu/bncplKGZAc6W2LxM=;
        b=eKKe9glh4tV28MYjeqdxDvnzjO6iMquqJJlx3SoW6jfJ3C+jzZehefX1ZrSRmDm1yU
         +CuOUXV/qaL/NXJ6F7jdtYyc8b0NYk5i/6Hbs7UJOIOqUachF41euNeiS/fo4aXt4JyI
         znmHSkOswRYfB9jVf+Deq81wYhYbUjFnaqZopl9dkIY6bF+iTns2pAotDEyH5Almqc+X
         YL3Vdso5mL4UxA2iMbeOq0zuCbcHiU3ygDYSTkyRKNN48PZ5M6TfcTRzblQP4i9xHG2F
         YbhecgGAs+Quyqas6MkpYZNXi9BA5xXFOZ27/JfdO9Uzi8FWbXEsABCp8tmjbUDvw9d8
         kBIA==
X-Forwarded-Encrypted: i=1; AJvYcCUyJd7PLD3oBcGAJIeTEnVQsnfbBDAHCwWZGuKjGK7umK68pItqe1Br92EVxOEctoRe7+Lx/NFh6Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YysVAzAQQ7kovClbXnsUML2VI+9irpUoL6+SNDi+9GWppFHhKgi
	xlcU1xp1heCxG6/S7KOlSHRkcycG8Js2m2aqYDj4yNufjmIl39naLYe09LyaN/0=
X-Gm-Gg: ASbGncvRkNjE4+vmDetzp51r3p8biwmY0DR204WeKNO8aAvF6Wt4qF8IV+bixYgnpsZ
	pHfX3AiBoMYvwPN5BgJOLwhWDFIwfNCCTU1c3JHVz/UdyfDn5w8tVWRAsMGOYtEfoJDCNGBBv06
	4jk6n8LoPQ1w1UwDswecSSyBG8DrtfW8MNzaOlAzXtIN0Z/I8LrxsRfV3sLDcOARyEQO6l9MI5o
	jQP7tXyP9CLhteASqk1FbJR+EQo8dieSMoY9sIuleUB5te7A1KDApevBcY1bMNOzwPm8BZx7Qb5
	y94LqgoiKbMfmA+c+4fSqHKBMqff
X-Google-Smtp-Source: AGHT+IEjF2u2RW/3YdAr0lHzjtV+TNOOgg3zCjt+GF/uyeQexQA0ARkffz5BS1YIj4YSEzPUqYDV+w==
X-Received: by 2002:a05:6a00:2e08:b0:730:76a1:3935 with SMTP id d2e1a72fcca58-73426ca8308mr2801175b3a.6.1740119710461;
        Thu, 20 Feb 2025 22:35:10 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7324273e324sm14929891b3a.88.2025.02.20.22.35.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 22:35:09 -0800 (PST)
Date: Fri, 21 Feb 2025 12:05:07 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Danilo Krummrich <dakr@redhat.com>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Nishanth Menon <nm@ti.com>, rust-for-linux@vger.kernel.org,
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
	Erik Schilling <erik.schilling@linaro.org>,
	Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Joakim Bech <joakim.bech@linaro.org>, Rob Herring <robh@kernel.org>,
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH V8 06/14] rust: Add bare minimal bindings for clk
 framework
Message-ID: <20250221063507.3vffn55hkmcn6x35@vireshk-i7>
References: <cover.1738832118.git.viresh.kumar@linaro.org>
 <c68081e18d939aefc7f6dac798df6b72e81bba4b.1738832118.git.viresh.kumar@linaro.org>
 <EC290802-2C5E-4ACA-A530-E776654C7E94@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <EC290802-2C5E-4ACA-A530-E776654C7E94@collabora.com>

On 17-02-25, 09:19, Daniel Almeida wrote:
> Hi Viresh
> 
> > On 6 Feb 2025, at 06:28, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > 
> > This adds very basic bindings for the clk framework, implements only
> > clk_get() and clk_put(). These are the bare minimum bindings required
> > for many users and are simple enough to add in the first attempt.
> 
> I am missing clk_prepare_enable/clk_disable_unprepare.
> 
> Otherwise I see no way of enabling and disabling clks. IMHO I would also
> consider these as “bare minimum”.

I have posted the clk bindings separately now:

https://lore.kernel.org/all/cover.1740118863.git.viresh.kumar@linaro.org/

-- 
viresh

