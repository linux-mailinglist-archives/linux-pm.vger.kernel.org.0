Return-Path: <linux-pm+bounces-28304-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 519B1AD1C5A
	for <lists+linux-pm@lfdr.de>; Mon,  9 Jun 2025 13:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 202F616BA8F
	for <lists+linux-pm@lfdr.de>; Mon,  9 Jun 2025 11:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D79424EA85;
	Mon,  9 Jun 2025 11:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fMQeG99z"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78162747F
	for <linux-pm@vger.kernel.org>; Mon,  9 Jun 2025 11:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749467843; cv=none; b=LCyAoR6cE6Qm4Ztos5DiyO2RpTAQnx9gJq7weVAD75JCVWorLoRBy97oL9ZP64gLyo6Apzt2q388elAZ4okV4ntTqLis+dQxfteE1yV72zsWSadXcHElmD/U+3cGA53Jj9mfGYNNtvHYfltxRoo/rbrDwjz63mjSc/X/8VUHR/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749467843; c=relaxed/simple;
	bh=1rf4k3D4qfLQox3AK7UIIbUKUE/1gntkD5UCAGbx2u0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oh7oHusdpHzwRdUmd7uwFt06rfO0zVHN/SeI1XntoimfNfnaCQYBSSeF+neWZvJTOF0tTPlExLSv9Kn0+v3oFcIc3RG0xBl4xNbgJhMb/lMvD2KuqPB3Va5pz2wVpL7C3cXmGG9C05+aBqW0NJuE7Nym8ivfgvHsojoP3CkCO+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fMQeG99z; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-74267c68c11so3253524b3a.0
        for <linux-pm@vger.kernel.org>; Mon, 09 Jun 2025 04:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749467842; x=1750072642; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3jmcmYhpSc0FqNNEiRx4dLKTU/hJsjGZ9t0Q+PDFigY=;
        b=fMQeG99z3RP37VErZF4qBvYuv9ljrKs2oiihvq5I1j84xL+Tysuymn6ATaf0v4QIq8
         +5JD/ztWl/3cw5P+hupm7OsL17/YV/wsBmvxpv+ogZqDTAW06RFt7qcc+ghs0yCR6trj
         cDuY+ZDIkWqHhcPiJeoZ1Q18D+/+xzXdQQ3wbw34REQtXuPoMiSHQy4x9ggDK+aWnyVq
         W5tytAMTXKKVdVvJyHOTYnHN2uug4fW4Ux6Dj9IAMCwYs/8sDI59KMSIlQNileuHgYw1
         eX3f15cXxybID/eFKvhzMSO1p2bfZ7grLQs/BNA0LsfJDdjKaELDbjvk+2Kgu+PTTTIS
         TN6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749467842; x=1750072642;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3jmcmYhpSc0FqNNEiRx4dLKTU/hJsjGZ9t0Q+PDFigY=;
        b=PrALirGb1g2Mf54etF/OoOnab7UkxStlo+EK5hRlsz86iuqLRN18da5vcyqJyWHXaT
         4FBPLRKdxHAZaZgjRdPKOUIT+2a2ISmSqSPEA5K9S4JMTw2eqafBlTEh0BiXWQdBeMDn
         oB+xD6tFU2xViL50QBkqSVBK4Pw4vOxtF2e84h3D4lqNYLm+Fs/03DdfaWD1yJySEMj0
         wZ9DUGRicblshk9U9rJShiQ2dmhq/jXL7OIIPF6rB2GXuq0oOqXVqj9OfBSXDoi+OA6P
         G3YVgl1uUQEIH5Ul1h+5ZSFs1K0ZWon+mT/x1p/36TScPOxwaejB2vfTwjfWus73kV3e
         bL4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUdmxh72qGCIUgh85ZPNyfUxcdP25TN31qLNVqwvsyvRUxBT3xc0/adOxD0EFKq0lb4FDp1f22GEQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6iTp2yVPU9Owo2VxES55e6lYpwIDIpd7OyWvIKhWqHKWloa2i
	+RzgPRLEJ3ZaDHCUe4sXVa/gKxvodnd9nedjIXWg2WvvJmk5fp7zd5MyPbgA+1jwKIY=
X-Gm-Gg: ASbGncuD0buV3MKcQl6dgT4v7sa3pt5t2x6anDaGdZKehKRZGeu5++0iLkEFS2SfFEm
	pxnjEs9daNi2pMEEpxqjaopJESpgaLRLm1ZO1yBylv5vlFW4r0eKL23Rx3kC2iJIpC0HtrqC24Y
	Zus1tUJKscoq4KkPdUqfFU2gBdJmK9THBylOcMkcjAYTFFvhYajMxMjwSc7dJPLdFkn6wqmmQ2y
	xC4rSVH8ylQ648FqsXxsNNewsG+P9s+IRA7rSgW2zAGlslbKAXqEgFybvzQufopsUQBXMGDp9Al
	s1nnqPNfBdQEQWXZtJRtPDL9PJXjE6tg68JZyELeg7K5s4jB82c6
X-Google-Smtp-Source: AGHT+IEWqD5LrlH9rkiU0S5rSFvCTOABuN2T34dBr5ro8m9I229gWJ2E8+H+/Lj8DYJDHkqAZ13+KA==
X-Received: by 2002:a05:6a20:12c5:b0:1f5:9016:3594 with SMTP id adf61e73a8af0-21ee255c80cmr20215648637.18.1749467841762;
        Mon, 09 Jun 2025 04:17:21 -0700 (PDT)
Received: from localhost ([122.172.81.72])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7482b08571dsm5502621b3a.84.2025.06.09.04.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 04:17:21 -0700 (PDT)
Date: Mon, 9 Jun 2025 16:47:19 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Yury Norov <yury.norov@gmail.com>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH] rust: cpumask: Validate CPU number in set() and clear()
Message-ID: <20250609111719.gne4mhchivobyv3y@vireshk-i7>
References: <8b5fc7889a7aacbd9f1f7412c99f02c736bde190.1749183428.git.viresh.kumar@linaro.org>
 <aEJwm16HSwCyt7aB@Mac.home>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEJwm16HSwCyt7aB@Mac.home>

On 05-06-25, 21:37, Boqun Feng wrote:
> While this can fix the current problem, but it's not a good solution for
> the long run. Because outside a test, we should never use an arbitrary
> i32 as a cpu number (we usually get it from smp_processor_id(), or
> something else). So the `< nr_cpu_ids` testing is not necessary in
> normal use cases.

Thanks for the feedback Boqun.

I have sent a new version and hopefully took care of all the review
comments:

https://lore.kernel.org/all/cover.1749463570.git.viresh.kumar@linaro.org/

-- 
viresh

