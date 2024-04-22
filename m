Return-Path: <linux-pm+bounces-6774-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 370628ACAB4
	for <lists+linux-pm@lfdr.de>; Mon, 22 Apr 2024 12:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFA4D1F22414
	for <lists+linux-pm@lfdr.de>; Mon, 22 Apr 2024 10:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 358BF145335;
	Mon, 22 Apr 2024 10:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ud7D1pak"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4541144307
	for <linux-pm@vger.kernel.org>; Mon, 22 Apr 2024 10:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713781856; cv=none; b=euPH19xIDsMgfIn9YZEN0FqiQh9FPiZM9TnxrrLGwun1fBPKCVoGtFtQ+SlkJc9SHJGRjvKcE/aaICuxhITwDImdEJ1sO/WxlRLW5OD7Z5iHJXX9bkmMc1Xl0FHxt/HeBxGNM+Z1rhefi9g/blD6ebzQHY6x6rPfa63IXbLjWTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713781856; c=relaxed/simple;
	bh=YeDcYif+zDkHv19iBPgDSKK6Yx0J30FDJC2BzwsHGkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rLdm60lz/959N8zwYxS5DXjxtYqzf8NIJOqgqKlOkmZM2stgM4ksqKMGZpdBQPb4WMRlV7dgEA1Fzoo29+To8S138qMElw+Nk2BRXHbbuELicNx6FXzGXFObhEvJKmDu8mohmwbOqYvOSG8q1B19KgMUwMQ1OiTvNFLz7h+zhLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ud7D1pak; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-36c15989a31so400385ab.2
        for <linux-pm@vger.kernel.org>; Mon, 22 Apr 2024 03:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713781853; x=1714386653; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tKvKShPD6e4jW0fEjFt1J89IUkhFZDroLQfz2r7xoxA=;
        b=ud7D1pakDx2PpC4Uc+Z0CyrKHAn2uMtkg6YCu9t3iBJvFGOWBU4FHUtVH50NHZaOwi
         EL3KId9U96GK/tNSD+Zlgw0zLGOSKfRq/UpQdBAFRwKqGTMbRsh/vBGYVcOleZhwMk9e
         KfN9g6mty39XsZDK7udlkXM1gE5L8Nu+wRcpatlWoGU0QvWqdYLvdFj+lzL7yTJLu0q+
         jXDgr/wuyKamS40MAH30V15yz1R9yQpcySvn/MkS8DSWEzxojkVpC2l/1ZDtxn4bSEiK
         FzcLEJr2ea2c4AqyDAdzm5fQDI38QDQYyhOuio3qJseTzYxW3wpw4hOfWVfxgc6WQSE+
         MBAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713781853; x=1714386653;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tKvKShPD6e4jW0fEjFt1J89IUkhFZDroLQfz2r7xoxA=;
        b=NAIdIt1/QrhZKau56+uTPNm3qRER3pSNl1uLB3VJkT8p7wwpKWvDcJkKFb2ZsK3oxf
         zXLqqiL+4jkmCRc8Gj/BETWpkK/DGAJAagNGwcR8mtcPlvlAKx6evflpB0JsnL1L5Z6I
         k/Umcgc9SEsmbP6pT+egIXyrVGX0B5l8iAdDEA2LP/coiZN8P4rv7mNLPsUm3+CV0SFJ
         6onINiUPomkzvlNwyTAou2XxHr5WTjaF39hlDEeIWNZXqytpc0/n8B6YrW6/C9m4yaeN
         c1q88SGDaJiSoC7iDlCzLOigtJXpchrv9adpcg0d+HHzTDKhv5IoCs3m28V5pBxU4b3Q
         ZN7g==
X-Forwarded-Encrypted: i=1; AJvYcCUvtTu4XTGWaiXbqVq4oGhxD4mShGKn+DqGUBY36kXF8Y795NN0r+D0snPEGB9tpBn+4lno/jUJQh5ZVmrIHlI5mcxHSmfW7fs=
X-Gm-Message-State: AOJu0Yz8duThyqDZD5w5rdJ1i8dHCuyNXJLy67qa4a7/utMffgeKszOa
	/C7WdMfOO0Mgr24jVWrYn6wm6hQrjvE5g0ZdatvXnGIr3YAn8trT6HywtvFhT6E=
X-Google-Smtp-Source: AGHT+IFMstOfkynojIXKMT7fdib7YBQsjSPodFp6FkukQeWvXC8QXVBhUf5fo2h3O99o9v1Dh/D+SQ==
X-Received: by 2002:a05:6e02:1848:b0:368:9799:fc30 with SMTP id b8-20020a056e02184800b003689799fc30mr13356900ilv.17.1713781852752;
        Mon, 22 Apr 2024 03:30:52 -0700 (PDT)
Received: from localhost ([122.172.87.52])
        by smtp.gmail.com with ESMTPSA id u3-20020a631403000000b005bdbe9a597fsm7366083pgl.57.2024.04.22.03.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 03:30:52 -0700 (PDT)
Date: Mon, 22 Apr 2024 16:00:50 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Benno Lossin <benno.lossin@proton.me>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>, linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
	rust-for-linux@vger.kernel.org,
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
	Erik Schilling <erik.schilling@linaro.org>,
	Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Joakim Bech <joakim.bech@linaro.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 3/3] cpufreq: Add Rust based cpufreq-dt driver
Message-ID: <20240422103050.tiecvamrd5upunou@vireshk-i7>
References: <cover.1712314032.git.viresh.kumar@linaro.org>
 <1792467a772b7a8355c6d0cb0cbacfbffff08afd.1712314032.git.viresh.kumar@linaro.org>
 <4ff5f30b-f2b8-4625-b3cd-ac08e4ffb068@proton.me>
 <8c4f2053-acbc-4f4a-93de-18f149c80869@proton.me>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c4f2053-acbc-4f4a-93de-18f149c80869@proton.me>

On 07-04-24, 10:17, Benno Lossin wrote:
> On 07.04.24 11:54, Benno Lossin wrote:
> > On 05.04.24 13:09, Viresh Kumar wrote:
> >> +// Finds exact supply name from the OF node.
> >> +fn find_supply_name_exact(np: *mut bindings::device_node, name: &str) -> Option<CString> {
> >> +    let sname = CString::try_from_fmt(fmt!("{}-supply", name)).ok()?;
> >> +
> >> +    // SAFETY: The OF node is guaranteed by the C code to be valid.
> >> +    let pp = unsafe { bindings::of_find_property(np, sname.as_ptr() as *mut _, ptr::null_mut()) };
> > 
> > Drivers should avoid calling `unsafe` code as much as possible. They
> > also should not be calling `bindings` code directly. Please write (or
> > find) abstractions for these `unsafe` calls.
> 
> Having re-read the cover letter, I see that you are already aware of
> this. If you need any help with creating the abstractions, feel free to
> reach out!

Thanks Benno. I am not sure what's the right approach here as there
are so many missing things (frameworks) I need. Though I don't need
full support for them but just a handful of APIs.

And then there is dependency on the generic support for device/driver,
platform device/driver, etc.

-- 
viresh

