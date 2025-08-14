Return-Path: <linux-pm+bounces-32391-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 332EEB2613D
	for <lists+linux-pm@lfdr.de>; Thu, 14 Aug 2025 11:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A08F03A0636
	for <lists+linux-pm@lfdr.de>; Thu, 14 Aug 2025 09:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3C52F83DA;
	Thu, 14 Aug 2025 09:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YDBscpxD"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873662E92DD
	for <linux-pm@vger.kernel.org>; Thu, 14 Aug 2025 09:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755163999; cv=none; b=Cjo1F9RbbDSWkwHiuWCgDDyeQUmF57x6qGupbhOa4XiG6VvaG3vqq/iy+/onUA6af1Y3x/9Y3o3Gi8omj+W33dGTJUAJJy0T7SB6Wb+anoqVMYs9MvqQDmbK9naXL+uUya/18+O7bkdCAls3DbynPhtEat8bH4ps8Rw/m6cyUl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755163999; c=relaxed/simple;
	bh=0gM4P2+1/T/+38ZTBChRF/kXSK6T1iDcWw4qbZja++o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uSuf4M33dxdGgh8sHYQF7MnrquXbEj3WwExfLgtkS6V+3gJKJ7/Z9J86Hto+ZG6aVjga5fZn/rfxk0wtOKv9W5IEoLkus6qudsl8KF8xEon0EMf548U6I5/M6fl95dnC4umBWoXJeJtBtHSil3Eha26cpsH2n3orJyx9Iy6LJf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YDBscpxD; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-76e2e88c6a6so711937b3a.1
        for <linux-pm@vger.kernel.org>; Thu, 14 Aug 2025 02:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755163997; x=1755768797; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=97uhtudkNMK5UOUbW8xAkf4ktNa2lEEMb/M2K9wPi10=;
        b=YDBscpxDfuxNoFpC8tHnWpRopz5ucs/vCcV50Xyl57Q9Dai7rsAQdobrrda7uxi/cm
         GfLHQZhHtnBDJoqv8sFtrw4wLo0g0LASeXo9KnOXTzfqlWMJT0nGnabtjQVgM9aYTnUc
         n9RNRg1ovKQ1nCU8CIefO9RV2Vf+iq7Q62nHsYGaq+ZaPVO57UDQYMNEjkX/LuhGaeTd
         SQydQ+K6hEGmnwEI4mtqOhOyWphwGgvKGKhYIbtPujOsjrZDDZhjWA0rwEgNlArLWuzI
         pxNiRcMuIlL0/VFrqZUc+jBaKX9HxZbQlOZkYWopFAfB/Gwjyw3zXcnvJHqGS5Anzl2z
         icXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755163997; x=1755768797;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=97uhtudkNMK5UOUbW8xAkf4ktNa2lEEMb/M2K9wPi10=;
        b=XrTAKuQ47PLHBZwk1d0zcQHNf0orGY8Q4Ohr2vF85EcDnLQPXDYhNia3y745pFyuvF
         rFniHmTVM9O12m+akzROHiOUKy0PsIJcre9A7PnfkizYxw2VuuZc5Lqt7hJaNlFKlaQK
         qO7fnd2a5WrAEnB4To1TSKWUVHOe5ZpJI5DeuP37j5kGVtP/1/NTkfca3Bn8A+COr/DN
         1DqW0Z9kKgi3emRRPCO0yqKv/k90NcwLWD1Q1AFxqs/z0gCI0lUtzTUT04vIoo+ibKQu
         qlDwZqXH/PLa5IF6qD6WQnUOeQSzFYKf+ZbCL2MC7jqn66YwxJrFLtR25/kKoQujGGSZ
         5OMA==
X-Forwarded-Encrypted: i=1; AJvYcCW/Wy8+7feXt4Q6gfngf9hEJpzWGWLf7IRVpdncYBarNjxBKVsfyJWG7AFdbGvishgXr65vT0vcSg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxIvRfWkgPMUd8kLi3p6y6+tyaJto+E3wkjY10KRbY6rCtfbJWL
	25f9gDn9cBb0RZ9jQsHLGnd+KNOozKpVd1uOqby0E8qLrSbThz95aVtUQatLF1VsyNM=
X-Gm-Gg: ASbGncs+n3TEe1qnaueAbCXkZYWUrdWQinKfhz3ci2BY3cAP80RJmBSMyJT9nFr4Xyo
	JSdvZSMTp0lYkuhzPfLxJLNEoAwCMQrYx1PUtA3DhAizs2FJR6EAV65tPcqcaRzXrm7Ls9FQETB
	KIxFSweHmjjkHbYWUqQZOS+68XrvoVsdTYVL89JzFAP4AE3Mw+mM2pSPK7bBidbnsfQM1lkFk2p
	i6b1x+v05Io4QIhYkjj47Q1OYAJUsLbUcu0Ngb5qgmz1DMMvLWI8s8qJZvSUNTw3XAERmDzI9ba
	i/1aFwkmhk1L5CKLnuuX8OIrXSVooS7kPePhZCC5Rslt9iNgHLt2JyF/4vbvaQbONdSJOVllbZP
	TrDjf+4jK9JbXxAkxweMcf2CU
X-Google-Smtp-Source: AGHT+IFy/7RDjF0U+OSnhBCxHWxK5dAZ48NiN2cIVg2ZnqQ/azV24PgRQXm1YdY8wqvBXOnUK4P7OA==
X-Received: by 2002:a05:6a00:22d5:b0:76b:995c:4bb1 with SMTP id d2e1a72fcca58-76e2fd434e1mr3525599b3a.15.1755163996646;
        Thu, 14 Aug 2025 02:33:16 -0700 (PDT)
Received: from localhost ([122.172.87.165])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bcdd40f63sm34159888b3a.87.2025.08.14.02.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 02:33:15 -0700 (PDT)
Date: Thu, 14 Aug 2025 15:03:13 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Benno Lossin <lossin@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, linux-pm@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 11/11] rust: cpufreq: replace
 `MaybeUninit::zeroed().assume_init()` with `pin_init::zeroed()`
Message-ID: <20250814093313.wossgn7jk35pc4c4@vireshk-i7>
References: <20250814093046.2071971-1-lossin@kernel.org>
 <20250814093046.2071971-12-lossin@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814093046.2071971-12-lossin@kernel.org>

On 14-08-25, 11:30, Benno Lossin wrote:
> All types in `bindings` implement `Zeroable` if they can, so use
> `pin_init::zeroed` instead of relying on `unsafe` code.
> 
> If this ends up not compiling in the future, something in bindgen or on
> the C side changed and is most likely incorrect.
> 
> Signed-off-by: Benno Lossin <lossin@kernel.org>
> ---
>  rust/kernel/cpufreq.rs | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

