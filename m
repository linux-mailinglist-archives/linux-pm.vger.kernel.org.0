Return-Path: <linux-pm+bounces-21932-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4829A32009
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2025 08:34:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E4343A3C9F
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2025 07:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D113A20468E;
	Wed, 12 Feb 2025 07:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bWBKFMZn"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB881FF1C8
	for <linux-pm@vger.kernel.org>; Wed, 12 Feb 2025 07:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739345683; cv=none; b=Xv3s/e/ykSR1v2ygYDUuyDPEDujRj5g+n/waZdz0WWc4GFnhgxitwW+6hPVdlH26+hoUfZQ+N0ltQwcnirSC+qi8iXqTV3OcGwePwp8kT8JMts5Kw+L0boGfvbJ2AoyiRMbzyTxquykXq9uVwd9Tqamh7GckWJqqx3A/ng8H2o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739345683; c=relaxed/simple;
	bh=xKZQeC8QlmSbvkB9BK44DQ6sGPlxDTX+bVywm5YMmj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iGgQij64dzJQ6GLMRodLwxqaHIey44l+vZ9XrrW3LR4xNWVQ0zLEwqad+iq5T+xlPu2Sq/uCV2SqCn51dohslRUpgK7N6PIx4ju0pdndXSzuF0jo5oUBBpZiVVy7Wd7alElsIC2OFERLXtz4CtuufhlXLHXvAAlKALY7q5nVsH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bWBKFMZn; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-21f50895565so74360275ad.2
        for <linux-pm@vger.kernel.org>; Tue, 11 Feb 2025 23:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739345681; x=1739950481; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gBZVQXzGj/Nj2dxnCyApeR+oIxTqVjbcwS+DUCxmMZo=;
        b=bWBKFMZnmiLu5Jb+el07taK6pY24LrKMKt8GmUEH1zlq0+O5Jm954HK2CoZwHJN0YX
         LuinVGVEwQKzztFmxSCjnnAmjkrp4kCcdg8KeVK75wW5dV4A3RiVh+UFv3U29qbu+v3o
         7Gb1vXmyuODRDjzGPwpmT2/PyT5h131eJ19ABx3WE/+iF99iE9Nl7D9Pl7PCbSe0y+1n
         udKH3ZbJCqzcc62GmiVtvVrsEzvM/qPKig09OeCbfPxFxvCEUkowak4Y2idYbYcoYZro
         u2CDVyZ9b5KyUvnlHnpJtm1ZN/PUkltlxM0aqgxdxHbtfmPVuHdEdu7rw3YH3blPvn2E
         3xOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739345681; x=1739950481;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gBZVQXzGj/Nj2dxnCyApeR+oIxTqVjbcwS+DUCxmMZo=;
        b=goaxWYyybISK9CMRxgle15q+FlHoqmHdmc/F0b/Xlir/xEXZK11pMG/Has1gC5xvCe
         lxsb+8pXsHBRC5157fr1q+1Ju+UYmenKLsajrCqN0cDahyftTFLXXrKKA62H2ktQgpW+
         ZHPQHs3R1m/B20BAu5jGypLRB6mKwNdzfkEenMpKHZyh+8okUgTyoeuseXTDcqWT2fdb
         7QmS9oDQB0UO9mHKPPNIc5dFUL9PKmPnrbHOybrBfQ1lATAa4l2otP2+75fXSHfzcSYg
         Pmd2/HvnM9J+KxoOX9zX9yjnZTDUjNv0Y3YB3UBoSTwPSeGxvYQhXySgwfoGjLE15B8d
         uIhQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKBamiw/W15TZdGBWDt/CYuloxNxlFkVcUiaiunoyy6vYT2usvtSh4tmCgGe+kKbipm0Ku5PQaAA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwwIy2G7ut9pu/CJa5ljn16OmtOYR+FPR2z2xm5Yi6savAS4D2C
	KZEhY6g0s8s2ZrJktOIOGj/Qzb7JGU16KmbYyzuqVniBRcoRaKpIfuNUbDz5y30=
X-Gm-Gg: ASbGncvAMJwLnYzVGh+FOXbxopUHx5Y16DrX7/7fJkGZEVzT0H+oLjUIesAlNn/5ES/
	ymsZznlC8Ey6ePI+xP7IVSkbqAQhn2OyphW4FkX+XSSt++v3DQzjVk+2yrJvgXXbSgUZFahgWZ2
	mO3nkiD5FDkdd44krRHtsqBEdNsw2EZzJ045IPzbA15KU740RzuQDQLohZDub1tRUgJpaHfiMeN
	i3z+SHzvNfjciDKCCrYOb6Y6h1WFuvne5b/SWMoFbY3gmNtDFIwbmGGOo9HpbRn3tPEe19n2WUy
	L1QYMRdItq6FDg5DkQ==
X-Google-Smtp-Source: AGHT+IG+5sMijvsVWogU7ykbigna0UHmysXJKLgwHilyqSb7VE5FnliyWRdOolJC+q6GU38VtdsVhw==
X-Received: by 2002:a17:903:124e:b0:212:996:3536 with SMTP id d9443c01a7336-220bdedcf55mr32555755ad.10.1739345681224;
        Tue, 11 Feb 2025 23:34:41 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f36511846sm107668125ad.37.2025.02.11.23.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 23:34:40 -0800 (PST)
Date: Wed, 12 Feb 2025 13:04:38 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Yury Norov <yury.norov@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Danilo Krummrich <dakr@redhat.com>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
	rust-for-linux@vger.kernel.org,
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
	Erik Schilling <erik.schilling@linaro.org>,
	Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Joakim Bech <joakim.bech@linaro.org>, Rob Herring <robh@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Jason Gunthorpe <jgg@nvidia.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V8 04/14] rust: Add cpumask helpers
Message-ID: <20250212073438.bjhfgefz7t4dxobi@vireshk-i7>
References: <cover.1738832118.git.viresh.kumar@linaro.org>
 <db0166341ce824c157d0c58c240b3efc6aec6f6e.1738832118.git.viresh.kumar@linaro.org>
 <Z6qTelPSqpFk439l@thinkpad>
 <20250211042908.nyftiw7gtxosfjwc@vireshk-i7>
 <Z6t51xodSV21ER4M@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z6t51xodSV21ER4M@thinkpad>

On 11-02-25, 11:24, Yury Norov wrote:
> To begin with, this is the 8th version of the same patch, but you
> only now bothered to CC someone who is listed in MAINTAINERS. This is
> not how the community works.

Yes, this was my mistake. I assumed get_maintainers would Cc all
relevant people, but I overlooked the fact that these are new files,
so it didn’t include the maintainers. Unfortunately, the same issue
occurred with the clk bindings. Miguel pointed it out at V7, and I
corrected it immediately. There was no intention to bypass anyone.

These bindings had been in my tree since earlier versions, but I
hesitated to post them before V6 because I wasn’t confident in writing
bindings for a framework I didn’t fully understand. I eventually
shared them in V6 to unblock my series but inadvertently missed Cc’ing
few, as mentioned above.

> You also made it a patch bomb that touches multiple critical and very
> sensitive subsystems. You link them to an experimental and unstable
> project, and do it in a way that makes it really easy to slip through
> maintainers' attention.
> 
> Not speaking for others, but please for cpumasks create a separate
> series and start thorough discussion.

Agree, its better to post these separately.

-- 
viresh

