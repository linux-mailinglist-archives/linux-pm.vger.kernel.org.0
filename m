Return-Path: <linux-pm+bounces-20072-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9419FA052AE
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jan 2025 06:37:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4D2C166577
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jan 2025 05:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3B1F1A2380;
	Wed,  8 Jan 2025 05:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U+RzUYFX"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7849776C61
	for <linux-pm@vger.kernel.org>; Wed,  8 Jan 2025 05:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736314629; cv=none; b=Uc1Nz4AOW9P+iaXjUwWee/kHv40d0pOKsS+4yVnm7fglIf4AVRLB2RHanhOPl6Vvipk6ERm8Y4HrGf3hbp6SZTIAySm4iSXHtBcZPWD5VlR6aCK2RggULyr7w7GVodxXZPydCKyWOps8OhEym6qT3J80olL9h7O6TT/BmAS+WkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736314629; c=relaxed/simple;
	bh=2DDiY1StCn7sBSV4PmE1ZowtJKbcWaTTkafeFFEi2uI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QU/5eoCBlKrLcjYcp8p7IT/2KqhU1K4TjL6Fx9Sd4oo7zuezUPgitIXaXdR8bKr15uQEflSd06qlUQlZ6na2ld0kXFxcHNIU1kofMAdRz0+bD+9z/0t/UZ/KKN3CJuqqwe41vlWfg2TedCXPwmjOh2ZfhLl7Pho4ngSF3TOkDXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=U+RzUYFX; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-216634dd574so159610155ad.2
        for <linux-pm@vger.kernel.org>; Tue, 07 Jan 2025 21:37:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736314628; x=1736919428; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HYqYEywpcCZEjiw8UdXrncHGm7UENx7g7WFNYi18QkM=;
        b=U+RzUYFXS83m/NohDztsgmG1x+jINzbhuA6KxBYakf3jPcSGQmRzQ9+gGEUrE0OEt1
         kQqxACxeOXcoYbzPMW7oWa0+7EbQ1tQSEU2hHaHhfvLWK1BShy8JZrg+C36l7OPKEZCX
         3yN1si3YoVt6MFqAUxwmOjuxIjvEO85RjxsY31UINgHMRM9W9OBUI0ivXEK9kPXPZHR5
         J6saOCzHsQ8dLMpcgJU/1QLh6JUJ7SgSRNP5vlw6B/tGOFrWDZCjyhWWuVy1+gt5CUni
         a8iYTsfIUGfxQLqRN4fdu95gqprUDDXZqVd5dGQ6MD8qKa1h5tnCAtq03lB4TcTS+0js
         kwbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736314628; x=1736919428;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HYqYEywpcCZEjiw8UdXrncHGm7UENx7g7WFNYi18QkM=;
        b=ffUWgizKzf1qcd3YUUmwV5DZXc/phoA49z0Ac/8sHlnde2bX/se6OkRj5W7ivl1vca
         7oy4zF49vqGJF0qmq157jF65vZRUvF4jt2Q9jCoJd+or6YTruUh8BOa5JX7GdcUEjK34
         uhcxOr2C5C6PvvFxW5MNu4COGnPuxEmotBIlcoVtNr4Bw+6fwVoHSB0KOXnF3zB1wbc4
         lejtebIncS47R27kK+r1EDRQ/0ojr19Ialp8cbkI1Mx4ocadkk9m3SwKkxY3wH1her3M
         JMnCj8d1v6Y14Og88Zvw+8WjWWocq8okfR0vQX/ZR+Rqq9CdJDfwUMzu1uC2CqnpJGNd
         V4iQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5EuJIxzrzVPty13bXnsR94peGv7KtXtvg5aVMToaHTmP/o8z4XOg6n6rhwxmMeGQ1+kg+fVbRtw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzAxCF/+BjWBZimk/JzZE3bvcZwFouGaoeoN5sKXHROmkac932Q
	UeUeSplvaElQCr6CYkV5saQ8JZSoTbRt40Zk0JVzF/fP6U5qpjKaFbtGiwP+qIc=
X-Gm-Gg: ASbGncvhXOn2KTSVbepz/3mV0s4QK/HxtlQyeCwol7muJOLC/Nu9pzYtnpuqVfvbNIw
	ia5IITof+bBB8HvwsrIgk7sumQJc0eCOYBuzG2yC8nlRRHJ+gNBfyvWp6/QO5eXJaY+M9GaFP9k
	UJH17bNHtqDF53CosHU+gSg1raRhQrSE8bB5ymq8ayX0g6Tv155zT/J8i8Ek2WWS55m/5ixynBL
	MrC50WSklZW88j+Se80L+o1PSDVYIPRP/0zU81nDDBM7UkXe7CmjRitkW4=
X-Google-Smtp-Source: AGHT+IE4bFgUgzu2OixSWQWLbDsH8vKVi8CSJhd+pDmS3q/oKMKr51QQ7F+1+EHktqqlPcrrZSTC5Q==
X-Received: by 2002:a05:6a20:a10c:b0:1db:ec0f:5cf4 with SMTP id adf61e73a8af0-1e88d0d9c40mr3385398637.39.1736314627822;
        Tue, 07 Jan 2025 21:37:07 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad8dbb70sm34409124b3a.98.2025.01.07.21.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 21:37:07 -0800 (PST)
Date: Wed, 8 Jan 2025 11:07:05 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Greg KH <gregkh@linuxfoundation.org>
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
	Erik Schilling <erik.schilling@linaro.org>,
	Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Joakim Bech <joakim.bech@linaro.org>, Rob Herring <robh@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V6 03/15] cpufreq: Rust implementation doesn't parse
 BIT() macro
Message-ID: <20250108053705.cuog2jqj4x2oa5im@vireshk-i7>
References: <cover.1736248242.git.viresh.kumar@linaro.org>
 <9719ba8b3a921bd9f2cb7ebf902c54c708b5409d.1736248242.git.viresh.kumar@linaro.org>
 <2025010752-vagrantly-juiciness-cd81@gregkh>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025010752-vagrantly-juiciness-cd81@gregkh>

On 07-01-25, 13:00, Greg KH wrote:
> On Tue, Jan 07, 2025 at 04:51:36PM +0530, Viresh Kumar wrote:
> > Rust isn't able to parse the macro for now, avoid using it.
> 
> No, please fix it.  You don't want to have to fend off the checkpatch.pl
> cleanups that this would cause of people putting the BIT() macro back.

Yeah, I mentioned this in the cover-letter that we need to make Rust work with
it. I should have marked it as DO-NOT-MERGE patch.

I wanted to get an idea from others on how to fix it, which Danilo shared now.
Will try that.

> Make BIT() work properly for Rust code as well, it has to be done
> eventually, right?

-- 
viresh

