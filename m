Return-Path: <linux-pm+bounces-21112-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD9F0A22855
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jan 2025 05:58:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2B153A6DB8
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jan 2025 04:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 267FE1494D8;
	Thu, 30 Jan 2025 04:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VZ3ptfxc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7021113C690
	for <linux-pm@vger.kernel.org>; Thu, 30 Jan 2025 04:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738213100; cv=none; b=U0+DXErs0PFrh1OAr+srPeQ5CwUL+xVqH0HsF+ZSfrVipk64AOiUN6G1lwgGN5xMUjEEPeHy2f5oyQP4Xid2AUrMCQt7ZIqkRM75ruYA4QbmM+QDJUuQxbfbcnHXuiCEHfTPvIlo8iheqiq54Lz6d0Z7F8o1+LkHcYxZE5d3Qs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738213100; c=relaxed/simple;
	bh=MKUSs+HYsIDDz0bOcM/JRSk4kuQYkVAn0CJXFl2q5xw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dIJCgOVyyDL/s3iTaBtfUtPHNT1PiQt9W26XOSrs2vmTGYcM35rV7zlmT/L4vxFN0wewT4edlApGz+KNqa6/PbjL5+gHROWMOfBKFnMYEDxerQOQVQX+tL1mSL1/afP1e5FRUfoUWlTMrZumf12soURV0/aG/xB6tFhRXRh7CKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VZ3ptfxc; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-216401de828so5680425ad.3
        for <linux-pm@vger.kernel.org>; Wed, 29 Jan 2025 20:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738213098; x=1738817898; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XeFAClo/GRnpnoHmOXhQ8WOtII3WuA8AKf+fEiZpfXQ=;
        b=VZ3ptfxcjw/XLwZKVIw4Fvrf+4kv0NvyZeT/jc3W798tSPXya71/DluFWmZBiYvom+
         OQH7+i8SIy6v5pMm+/0E8vC0MDTsb52Y/9t5E5LwSb+4BXCtyaiJLtdiS7r1Bh/d4aPT
         UQ4syvs1pI8R0Z8H7QBopEq5UU6BsjATA+/eXe8jFcHGSntUj7/smrNWi6gvq2wdbpfU
         aqgFLm2NnBA0hUknOZm3OqOvMb+TLHmNhMi8u2hlR6WfZZpXPl/eN+HMktCcyIiSTsBr
         MSGRJfHwiHw5wiAi+gqe8ywTKIgsa0pXj/i+YgammTYrqCeavjKDSA4la9oWq3UwPmix
         oIow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738213098; x=1738817898;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XeFAClo/GRnpnoHmOXhQ8WOtII3WuA8AKf+fEiZpfXQ=;
        b=l0LwkSqcabO53i3QgIHbv4vvwbhM0IlqvP/oUPl1P6aj1oDE+wcVskk/CAd3WjNkQf
         a7lFMbvEmmo9qivDhO1AR1gr+vfQG0m2ffS93RoD+TTayLuxY9p1qDnjJ+HwofHrmler
         JmhRDG5Xsj+gJ6pJCJZr4sCAUSAtximUaXE2NIu9+BqQCvcLl5RcsbE6p9+h37WRhAWw
         EHlIvq1Ks4iGNw7EufpGdx+GaivCp2HHLaOoJSLswXFi5RZdxUPTq6vnBU7Cqa/yfwRg
         jW++OqCs7W6XE/IprWxCR88xUQuaBls0mWDo3/shqslKQUK83eRotCV56seI7dWfvWsq
         CNiw==
X-Forwarded-Encrypted: i=1; AJvYcCVfd9csGqnfmCiqCm6VHoMbylfyNy7rnEd69Wu65FEI+GVfzY+PrYXkKVc8qmR3zzWBEINC0djDgg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyQtjhJbheWtm9U2CiZ+afcGsmYUmTA/Ys2nRdtDB1ogdxCBA0e
	z1KB0t/5O6IXdIKEw5iKRJv76wG9kWH7LoHZl8yzBO6uFhRWEBHoqjOy/xKnp5s=
X-Gm-Gg: ASbGncsT8RKpdJuNO1UueH6Fi23LxWsznLTVN6kiavBUWstZJ5d2K8g2XUOaR3aCsh7
	FKUUTG+Hy0w2SPElNZsFLngy0lJ7lmgFIebCaTI+t7zxuuEiVIsh03Oqgb8+WhWiJtqs3bomB6E
	SHL8t0gqgsjMLaphHME+y5TaIhh/Zkt+5xFdJcNkwbKo6Ae5ovne8LF8DVqg/DS/je9eRn0TOvv
	dwJuT0EEMSXU2363Mrc/rjhUaKODVSfQenX1i7hoDpXe8MDOAEdw6pqn/bsd3AAMFfLGfjWPOKa
	/GeLWRhhIyHSWdaT3A==
X-Google-Smtp-Source: AGHT+IFc+mkM3u7DrCjTmTvkjYFQF/552EVImTVoRgjOM4B63d3mf/fH/ik7UoquQ9a318LnCDssxQ==
X-Received: by 2002:a05:6300:44:b0:1ed:7540:45e1 with SMTP id adf61e73a8af0-1ed7a5d54c1mr9431995637.33.1738213097717;
        Wed, 29 Jan 2025 20:58:17 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-acec04794bcsm414717a12.51.2025.01.29.20.58.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 20:58:17 -0800 (PST)
Date: Thu, 30 Jan 2025 10:28:14 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Anisse Astier <anisse@astier.eu>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v2] rust: macros: enable use of hyphens in module names
Message-ID: <20250130045814.ve2jsdi3wmzdlhbw@vireshk-i7>
References: <20250122131812.466080-1-anisse@astier.eu>
 <20250122133952.501055-1-anisse@astier.eu>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250122133952.501055-1-anisse@astier.eu>

On 22-01-25, 14:39, Anisse Astier wrote:
> +    /* Rust does not allow hyphens in identifiers, use underscore instead */
> +    let name_identifier = info.name.replace("-", "_");

With CLIPPY=1 W=1, this gives:

warning: single-character string constant used as pattern
   --> /mnt/ssd/all/work/repos/kernel/linux/rust/macros/module.rs:186:45
    |
186 |     let name_identifier = info.name.replace("-", "_");
    |                                             ^^^ help: consider using a `char`: `'-'`
    |
    = help: for further information visit https://rust-lang.github.io/rust-clippy/master/index.html#single_char_pattern
    = note: `-W clippy::single-char-pattern` implied by `-W clippy::all`
    = help: to override `-W clippy::all` add `#[allow(clippy::single_char_pattern)]`

warning: 1 warning emitted

This fixes it:

diff --git a/rust/macros/module.rs b/rust/macros/module.rs
index 1eff30d2ca6a..2e740bbdb598 100644
--- a/rust/macros/module.rs
+++ b/rust/macros/module.rs
@@ -183,7 +183,7 @@ pub(crate) fn module(ts: TokenStream) -> TokenStream {
     let info = ModuleInfo::parse(&mut it);

     /* Rust does not allow hyphens in identifiers, use underscore instead */
-    let name_identifier = info.name.replace("-", "_");
+    let name_identifier = info.name.replace('-', "_");
     let mut modinfo = ModInfoBuilder::new(name_identifier.as_ref());
     if let Some(author) = info.author {
         modinfo.emit("author", &author);


Will include it in my V8 now, unless you have any objections to it.
Thanks.

-- 
viresh

