Return-Path: <linux-pm+bounces-21770-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68191A30288
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 05:29:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F866188C29F
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 04:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEBEA1D89E5;
	Tue, 11 Feb 2025 04:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f1lH2wA5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664E41B3934
	for <linux-pm@vger.kernel.org>; Tue, 11 Feb 2025 04:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739248154; cv=none; b=SRKazt3NVTefGS9l1EfhuTTQaN+njCnpCUHE2x45kSthXZj1ma7SsQ6KRv3KWPdPmDgb+7SYTnbUBzZZksrRrzUmLA6Eh/llYvpploT2JfaM/CKudvCm1+0L11shKMZa7AMQ6RlRLuFZcysWmcrc2e/YRItgLZ58iXyN8GjpKIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739248154; c=relaxed/simple;
	bh=Eh4D03RgjRhUFUGbjnsrtoBwi4K6jy62lBsis7HXjqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u1ea9u3yYzVPLtR1Vee374RlZteMj40zGYPaIRlGWl6iyE/BWQz+19kNqxujGUlg/XyoqvXB7nnpajYMDRp2pQDyUofCxFysX0NstheH5MrYAEGShZFN/JUh5Ki8uQjaAmZEr8BAdomdzVzDLHTU4GmuKK5cupU4ptMB28b9/vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=f1lH2wA5; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-21f62cc4088so54312805ad.3
        for <linux-pm@vger.kernel.org>; Mon, 10 Feb 2025 20:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739248152; x=1739852952; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R17/qsybBuUiE11sy3rr55GZQNSwgogOHqxcTs41IzQ=;
        b=f1lH2wA5c+GEQJ2sWtBPc+H2CEQ2imOGaLoqqT50wfH4IWfpp8hphQvdC5hQbbZFdt
         V9aYMo8agAqzEDzYwubf/YsXrHQllogzyA/SZ9iXDkxEKeq2erutvmB68QQEgT5sS5eM
         437oiMV9qxBz6xR1RkN4dgXT+uZtXuA+/7c40km/PEBqzxuK1KKQ2++1/jFOxHha95MX
         eLbMF302QRRhEAyBSm0TtSTQ1JP24Bvjvix0brns0sznYh8jYpF2odg9s3kvo/J8W8aC
         uiaI+7XW/C+48kHlmmrau+mjrunZE1Tl1fxitKxAILvfofvtxqx7E9vcrTVRRnIXxQd6
         EeFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739248152; x=1739852952;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R17/qsybBuUiE11sy3rr55GZQNSwgogOHqxcTs41IzQ=;
        b=pQO13R0q2yqb9lcvQ4TFcssAslOv88yUIj/W/bFUkroH/6xEZ2DOpeySaaChRVSnTY
         0H9g9iiUbnp1+EEeUoqN7dfQ8rm/wBhDvd9y9IFRGKy/IohJRjqSYbl/nu/vk8giSbfe
         QTR2wu5KUq0bm15Rel66UjiSJmu3SZKu14bCMMlEDZCd57jDV6b43NGW/2Lmk2dkV87k
         0u5oVqEc0g12oGx8SvSKnWRSqFgGAxMjKMY60x2iKmRpHLulGyzkoVhsCZifsL1mpQwT
         +k3FJqcFvzpKnRtOjq0owsOI9/Gxq+i1taUdw+Y/cPzaL2zUZdZY2umtiN6Yg9EmVOjG
         3t/Q==
X-Forwarded-Encrypted: i=1; AJvYcCU30x2yxcW9ICTBnVjbqenQI1/JFAOexjJhiTcl9Nxn4mFGWpw9Eh4PqocIWtyKzVauhyeFH5JIlQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0soNadmPyZi7qS2HSYl22X+rB18z0YhKEoHTX3vt3B7czOzCv
	heHgLuszBnJb7rQNaaODV5qIFjFGalx/HWdOfAZwbfC903STgFpZ45Vrkef6txk=
X-Gm-Gg: ASbGnctb0GDM4N17kmaXv68p8Rt+w5zNC6FcTwR/8IEsP8yxMRkqpt38QGQ2YOudrdc
	L2vXAjFKtFK5CKSEBjy8f9rnDe3t+F4QxZxdh1Sd1j3QLD76BU07okRkaaJAhzYfu4O6giXyexW
	BaS8inxJs4T2eTWNPUQH6nPy+d0t6nM4Ak2lFc/CF4myPlDDWL20W1k0034xVNTZ/kSoMLJQPtp
	LOZ/u7oZ5OVLw96gcKEEVqNuRBPrEDyggBPkx1UFK8N/t3mNTMsPaGOPfvcWub/aiCF6XEQPVC4
	pY9ev+W5OvYo2dCazw==
X-Google-Smtp-Source: AGHT+IEZcBKkgQvgu0Gja7oPmp7ETDL4kRRxy2BoBNXWnfh9afk9yQuRY7Pd92NDnJpb7opE0F3HeA==
X-Received: by 2002:a17:903:2309:b0:215:a04a:89d5 with SMTP id d9443c01a7336-21f4e1cf038mr280431035ad.2.1739248151630;
        Mon, 10 Feb 2025 20:29:11 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ad51aecfa58sm8630725a12.25.2025.02.10.20.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 20:29:10 -0800 (PST)
Date: Tue, 11 Feb 2025 09:59:08 +0530
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
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V8 04/14] rust: Add cpumask helpers
Message-ID: <20250211042908.nyftiw7gtxosfjwc@vireshk-i7>
References: <cover.1738832118.git.viresh.kumar@linaro.org>
 <db0166341ce824c157d0c58c240b3efc6aec6f6e.1738832118.git.viresh.kumar@linaro.org>
 <Z6qTelPSqpFk439l@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6qTelPSqpFk439l@thinkpad>

On 10-02-25, 19:02, Yury Norov wrote:
> On Thu, Feb 06, 2025 at 02:58:25PM +0530, Viresh Kumar wrote:
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index ee6709599df5..bfc1bf2ebd77 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -4021,6 +4021,7 @@ F:	lib/cpumask_kunit.c
> >  F:	lib/find_bit.c
> >  F:	lib/find_bit_benchmark.c
> >  F:	lib/test_bitmap.c
> > +F:	rust/helpers/cpumask.c
> 
> Sorry what? I never committed to maintain this thing, and will
> definitely not do it for free.
> 
> NAK.

Okay. I will add a separate entry for Rust cpumask stuff.

> > +#ifndef CONFIG_CPUMASK_OFFSTACK
> > +void rust_helper_free_cpumask_var(cpumask_var_t mask)
> > +{
> > +	free_cpumask_var(mask);
> > +}
> > +#endif
> 
> This is most likely wrong because free_cpumask_var() is declared
> unconditionally, and I suspect the rust helper should be as well.

Non-trivial C macros and inlined C functions cannot be used directly
in the Rust code and are used via functions ("helpers") that wrap
those so that they can be called from Rust.

The free_cpumask_var() function is defined as inline only for the
CONFIG_CPUMASK_OFFSTACK=n case and that's where we need this wrapper.
For the other case (CONFIG_CPUMASK_OFFSTACK=y), Rust code can directly
call free_cpumask_var() from the C code and we don't need this helper.

> Please for the next iteration keep me CCed for the whole series. I
> want to make sure you'll not make me a rust maintainer accidentally.

Sure.

-- 
viresh

