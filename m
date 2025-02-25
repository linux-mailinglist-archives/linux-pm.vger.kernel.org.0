Return-Path: <linux-pm+bounces-22869-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA81A43A4A
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2025 10:52:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6B1F18884CE
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2025 09:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E5B2627EA;
	Tue, 25 Feb 2025 09:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SRJt0Gw/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE681214208
	for <linux-pm@vger.kernel.org>; Tue, 25 Feb 2025 09:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740477059; cv=none; b=dpi4pg55iXmcFSZpiP2lETyj7jN3VdetbcQbZ4dLs3ZSSUppULY9fe+MJxkUekyHvkVVOIoJzhmXhd7JNTAlBq6VTV5Jhgd7jwLlrGZ+ZoRa0ccRI2ra3hVsIlY+fSg9Tf3Xnf54Zr409Wdo2e5U/zuY8Ev00x8Kw+5PjH1qH2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740477059; c=relaxed/simple;
	bh=p6BtO1SPEiYTgGfRVtTmaaauZNwaUPFNQtWx4//eHdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c/04IrRlToMDGzeOwAQFsf44L3nkJRtBQNtOTbmw0f60Pt4Br+I7xa424XfwzxLf4uJLLcY6OrQoHn5KGLoIq3M1kB7GsmOODdfOxPYV9NyRjgt7tHjjow75L5CFlUfXcsoahuJuhingloMa+A536PHkmI8B1+uj07NFDsaFbgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SRJt0Gw/; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-22100006bc8so93899665ad.0
        for <linux-pm@vger.kernel.org>; Tue, 25 Feb 2025 01:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740477057; x=1741081857; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mHFlVMAkFi70oXxJTi8F3j9ugzg66NFhSakMattK2Gg=;
        b=SRJt0Gw/CBCRugy4nlXziSvNcuFA9XuJnuCc79uMJ5Kf6kJv49gMzEgroeE1vDtBhk
         Q4Hf1CU/2BC0Ptn3WgGJ5rBtsLGVgyv9abpkBgy3zxKd/hb9+4BTQqV6roQLG49JR79E
         6voI2Kv8ISOcsIDbKRGMWk5k3byp2LMoxhtrgvyHOGnxF/cb9bZkkk8Ag50A+Cccyg/j
         F3xlKyrhll+RhDG0oRdg6Cbng4IchFRogcvrjyC4fPLr5Ovysnp0roDMjb3EtTHprP0a
         /vkJjHnPybFnSfYoqN2+L1Gjmo3GPRd3Zk6pn4SvMG1oOXEI6tNab1KXDqIdOzlb2ClJ
         Ut3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740477057; x=1741081857;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mHFlVMAkFi70oXxJTi8F3j9ugzg66NFhSakMattK2Gg=;
        b=JOxaW2twW1U4ucmfSYL62pxyZrGv57lfDZ6rSW1NkhUdHFpZSsRbINKlu/+1D5SRxW
         TuPBPI07tDMAVTlpa3C7GdDdE33rUrjW7kExKP0vTm1fx+3FAL7bX5Hq5SR703kwJdPm
         bQWkHV0zRvuEzUWE3q99k5Db1Cav70i7JueXbnpqhXJ73K8oE0wk38wM+Lw/3LFKfMts
         nbYJ6EqNRS8SGq4GySJtv4exD5B0VzDX5EF8EYk6FBAXtOnQ7J3Xba/7J6CuAJOaLBEr
         Q7gmZ2GJmZaqgDYehQgV35iORsQfEuPHihLCp/liV+oqh3LSGKAmycd/ywqoukroiLQq
         1NBQ==
X-Forwarded-Encrypted: i=1; AJvYcCW79RdoyfVsN3qlj0IRmna3jyHaCq+e4m1o6IwYm7JUj2d2vO5HRcI3cTwNEChJ17NUDbf3gD2DHA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4/MEUDHftvjANftNEoFFuopab9Oc+y9MokaRaGTQFJiyFQduo
	6QpLG1wNhsmHgseEojPCS3Z7RQQkf5gqG2IqxFRQHzrQ0lUefHi0P3S0EmW0sXg=
X-Gm-Gg: ASbGncu2STa/hRS3TZGxxoVvzpE/TUz1g4iyPCo5pRFOiFWmUyPhieZ+Rcm3QlccPic
	pZtJ+f6LEEls/YbG+Tsm4/RIZwuD5MDwF6WpU3LkaA+E/WcFhZA4gEJwTD8BxQsslp1dVaELCmT
	LzuXLYE5Wbj6kwfvVg8zStw7sXFJDGPPzk/Ek7ksGEOHqTnu/sb3a5PLXVWoWNm8uNTWgN3JrpU
	GrWavku/l848wogg9Be7cw3x0/LFiFk9qbLMW6AZAHv2/TTwIuEhhEetKCsHe0fwwEVf5pTOTzH
	BrjfsYJ+WJv3LdMx5eNmEbpukMM=
X-Google-Smtp-Source: AGHT+IEh9+WnAiY4cGXADIGyyOzeQbN1kuedINyZawngjXfyPvJCRIP88vK4skeZvmAi6UCA6cE6vg==
X-Received: by 2002:a05:6a00:929d:b0:730:8d0c:1064 with SMTP id d2e1a72fcca58-7347918cd47mr3591985b3a.18.1740477057199;
        Tue, 25 Feb 2025 01:50:57 -0800 (PST)
Received: from localhost ([122.172.84.15])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7347a6b8a82sm1071040b3a.6.2025.02.25.01.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 01:50:56 -0800 (PST)
Date: Tue, 25 Feb 2025 15:20:54 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Yury Norov <yury.norov@gmail.com>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Danilo Krummrich <dakr@redhat.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
	Erik Schilling <erik.schilling@linaro.org>,
	Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Joakim Bech <joakim.bech@linaro.org>, Rob Herring <robh@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Jason Gunthorpe <jgg@nvidia.com>,
	John Hubbard <jhubbard@nvidia.com>, linux-pm@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] rust: Add cpumask helpers
Message-ID: <20250225095054.fp5xdolezdh2yalc@vireshk-i7>
References: <20250224233938.3158-1-yury.norov@gmail.com>
 <20250224233938.3158-2-yury.norov@gmail.com>
 <9E7A81AA-6460-4F87-942E-2EEA145257F2@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9E7A81AA-6460-4F87-942E-2EEA145257F2@collabora.com>

On 25-02-25, 06:43, Daniel Almeida wrote:
> I don’t understand what is going on here. You apparently did not provide the
> Rust code itself.
> 
> Usually, when I see a “in order to prepare for …” I expect the actual patch to
> follow in the same series.
> 
> Right now - and correct me if I'm wrong - it seems like you’ve essentially added
> dead code.

Rust abstractions:

https://lore.kernel.org/all/cover.1740475625.git.viresh.kumar@linaro.org/

-- 
viresh

