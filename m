Return-Path: <linux-pm+bounces-26117-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E186A9AB03
	for <lists+linux-pm@lfdr.de>; Thu, 24 Apr 2025 12:51:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C27EC188B4D0
	for <lists+linux-pm@lfdr.de>; Thu, 24 Apr 2025 10:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7597721FF33;
	Thu, 24 Apr 2025 10:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VA0IZCrR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E0120D517
	for <linux-pm@vger.kernel.org>; Thu, 24 Apr 2025 10:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745491881; cv=none; b=Kvkkh7N6sUqfBC1IWvOOJTALH7w2SKqmKjSTkDtp5lkpMQ/zPKBvM3G6G2R+GiJcxDQM7gC1eCIb/yMKtUTyq8twLFmkR8PX3QNB6bVcTwlDpHx8v6OoHTa2u26+4ksvSGe3JOxN/dhLwrtH1sFYd4nDZXnY/9wjK8C8ArR0YXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745491881; c=relaxed/simple;
	bh=HG1//szgx01meAsMA7HuncrbLx0xZUsBwK+q9eqz9Kk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z86HQN7735Vx913bpk5G1SXX9UFajj9Z9TJIdSHg/TIP9gmiqpznqewp4kgsMPovzmTMxtyHrbnFKcFz12TsnGROHInFC9QFcHcvRCyLTC34kUN2JCIOuvApZJeyRPw9axzE3spoczpcli0tB5jOBQTt7HSEcOlvXQzenI9ypN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VA0IZCrR; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-301918a4e3bso912694a91.3
        for <linux-pm@vger.kernel.org>; Thu, 24 Apr 2025 03:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745491879; x=1746096679; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=x+abMdG/o8rmNfu60caQnUkqfKekYjtbcUEXVb0J6LQ=;
        b=VA0IZCrR/U13goc3N4DYtYt9lhoLnrtAxrFd/0ozd1/Li7IJllqpTJ2csq1J6E0xh/
         AdWWcA89hgX/tFczx/Uk/A/hkvT0GXCjWBgu2r6L2EHXZZn+Su4ww8Px2aFxghVEvksm
         uEF4Gw2tavhcDeWM5PVghquDCgllP2IZFuhKt0cIRpBWm/9fDcf7fdRES5BU6DUnPGSr
         a4R7AcyLASPq4FtlsjArIlODSLviHBCH9LpQKCpBkZme7JeHZbdpfnGFNMEtabo/9Kl4
         3Y+piNhTk5t8a8LRN3QDJF4gAy5jTyXhLto+htGrjtRan/rbBZPoqZ8UcXiefJEBKeq2
         sk9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745491879; x=1746096679;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x+abMdG/o8rmNfu60caQnUkqfKekYjtbcUEXVb0J6LQ=;
        b=WrVuFuoP1kedAXXlKZQ8DIagi6A6BwKZ9DNJB5vW94aeo/YENceo6pFYcJ5QvkTjtT
         q/hcN88yG5YiGSt3NjMx3yAy7pduErS8F8O7IYRk+U828MT3U32bWi3zCCl0NplEjhRH
         xVxwhvuD9eoqVWcsMArapc20OonRTIQHBjxFdOn7mYOQsf3myeonJ4k46ugpRVEV5+k8
         x/iGuX9UBoqqYhR7SLvNGtIaJUy/UTnlfMyzxquPTsOdZ1p7hILkfWBohvGK8sNZRKTF
         xJdvDt/I7feyvtrj25A0qdVDkWnNjWyxKeS3NWmQYt2Ku1NLekfd2t62BFS4tP0UCs2S
         wBkA==
X-Forwarded-Encrypted: i=1; AJvYcCWVgPRkeoED3x+lP7OPSa3OFBNbvP4b/20fZhJ2BcD0SzOEo0Lz+FrwsFHx7vI68pEr/4CtlhtszA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwN4k8G0bHuPDbZhdhbyf4+i8wMQgmQOs/qfX85zileWU/QVUkr
	N5iDO3CH9mBVqYiaI+dO80Ay+t3j5YbZfKtZmYgsUv0uY5UqqpjB17n5cJJoKK8=
X-Gm-Gg: ASbGncvX4EM8ANE0LbN4pCoSMfJNj+P7dNtsdC51MJWlxe/coSnJkaBmj0EWC4OgCDo
	zrWYNcOpGZvjSSgGkdX26SDAEUs73muz0xa9SC0/kHL6oC8NdCObPmhluOm+y279gN8YIub6QbJ
	wUZ8HFT4i8UzQXhSnzDQ/fqpxYvsl7K75AGPLCFWfmNNXQx+VctSLyme+S4JlHy6DhbO++JcbFO
	wo7ceNYY5lGYhhA0gAfL8RmdwwHLo0ouiqwf21jdISxBZhdmU2BxlHpuZMliTC01f53n7uLFOxC
	C7PmIFAerDk/8KuF0sD/X3gkSOrlK5RnuUO9kMkOCA==
X-Google-Smtp-Source: AGHT+IGpKJwHUe6vHUfwkD5s7/iL/IigxAr6meNd1hlH8G0Vgd+Zb7hGpE427/lVCrNIM2lV9yojAA==
X-Received: by 2002:a17:90b:5487:b0:2fe:6942:3710 with SMTP id 98e67ed59e1d1-309ed26b9ddmr3148717a91.3.1745491878988;
        Thu, 24 Apr 2025 03:51:18 -0700 (PDT)
Received: from localhost ([122.172.83.32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-309ef03b27asm1124213a91.6.2025.04.24.03.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 03:51:18 -0700 (PDT)
Date: Thu, 24 Apr 2025 16:21:16 +0530
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
Subject: Re: [PATCH V11 13/15] rust: cpufreq: Extend abstractions for driver
 registration
Message-ID: <20250424105116.m6vnewh7b2tlmxy6@vireshk-i7>
References: <cover.1745218975.git.viresh.kumar@linaro.org>
 <a14f6927488b5c7d15930c37a3069f46a5c888a2.1745218976.git.viresh.kumar@linaro.org>
 <6fc3e178-60f9-4b0f-9c56-6d983e4d1eed@kernel.org>
 <20250424062910.6zk7amxq4gjxtw66@vireshk-i7>
 <c332c760-fa48-4159-a3af-e33bedc0e4ef@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c332c760-fa48-4159-a3af-e33bedc0e4ef@kernel.org>

On 24-04-25, 10:03, Danilo Krummrich wrote:
> Yes, driver-core-next won't be rebased.

Thanks. Here is the diff after rebase:

diff --git a/rust/kernel/cpufreq.rs b/rust/kernel/cpufreq.rs
index 8628f0bada02..55a219148eed 100644
--- a/rust/kernel/cpufreq.rs
+++ b/rust/kernel/cpufreq.rs
@@ -11,7 +11,7 @@
 use crate::{
     clk::{Clk, Hertz},
     cpumask,
-    device::Device,
+    device::{Bound, Device},
     devres::Devres,
     error::{code::*, from_err_ptr, from_result, to_result, Result, VTABLE_DEFAULT_ERROR},
     ffi::{c_char, c_ulong},
@@ -835,7 +835,7 @@ fn register_em(_policy: &mut Policy) {
 /// use kernel::{
 ///     cpu, cpufreq,
 ///     c_str,
-///     device::Device,
+///     device::{Bound, Device},
 ///     macros::vtable,
 ///     sync::Arc,
 /// };
@@ -879,7 +879,7 @@ fn register_em(_policy: &mut Policy) {
 ///     }
 /// }
 ///
-/// fn foo_probe(dev: &Device) {
+/// fn foo_probe(dev: &Device<Bound>) {
 ///     cpufreq::Registration::<FooDriver>::new_foreign_owned(dev).unwrap();
 /// }
 /// ```
@@ -1031,7 +1031,7 @@ pub fn new() -> Result<Self> {
     ///
     /// Instead the [`Registration`] is owned by [`Devres`] and will be revoked / dropped, once the
     /// device is detached.
-    pub fn new_foreign_owned(dev: &Device) -> Result<()> {
+    pub fn new_foreign_owned(dev: &Device<Bound>) -> Result<()> {
         Devres::new_foreign_owned(dev, Self::new()?, GFP_KERNEL)
     }
 }

-- 
viresh

