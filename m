Return-Path: <linux-pm+bounces-10893-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B53092C2C4
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jul 2024 19:47:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BBD81C20ADB
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jul 2024 17:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B762F1B86F4;
	Tue,  9 Jul 2024 17:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UN6j+YN5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C561B86ED;
	Tue,  9 Jul 2024 17:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720547216; cv=none; b=eRmAwjj3alKcoGfSx3mLd+EDFeFq+rVa8mjinxnh+gqH0ogFVdE7iSk+FKvEx7k4qnNFGraxAvxwfDtuISL4OV3Rjh2Vf8U8cfNDc1Gak0GgzEE98kpaBl1HpcljcQudZUyrWDcU4iBNCOZS47RLHJc2rm5jXX+cUFXMQYN5XsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720547216; c=relaxed/simple;
	bh=GsQFfaSRcL+AkT/EMBnuBAKgPaSMtsLA8LszxcoUHlg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sioYIpWonEyxqM/+NLMxi9zWc62b3QGdCCaeLLiW3RYOr+mwYCMHV+ptlRNdnwGTw+1CQBiN3JBZn5fNcuAZDtzPAKt7cEOl5krfkkmVh/Q7XOqmpXWdt3pMxX1/YUN7fxNLYpuXXGShm3FRdHLRaN613e/1fvU+Y08OliFEbFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UN6j+YN5; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-447f2f5891cso12016371cf.2;
        Tue, 09 Jul 2024 10:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720547214; x=1721152014; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c4EteS+g5P2KsWzL1nRT1ZGJ+E/RL4GUaEWIIDrIWAs=;
        b=UN6j+YN5DG+o6tpBOr5qKSvMCwJ1HU7jOd5UitmWqFTDDHEH/tEV+KW5x9+JdT3HPT
         CcXyvhiGL7v8uVd9eIe5Ix+5jAfMt0C/yM+Oua5GGZVBe/9R7EBD3DOeM+dI9FLnJdbS
         KCXyDdVY+6CCel8SLV2B6uwgN1WGRS77a4jeF1xjyaTewCXyPqZbNU5BHwrud1+QG2Kg
         g4fBAT2unsMl6ESmpfqkEWa3mmiwZQ9aBr8HUVchnc6wzNieNOLF0dVAWnJ1zlpIcFt6
         5GspiQanJ+FbjGSowVRHJaGc1YNI4XJB+thiKFaPN/AgW/RN4nq0KVgZnYnZJN4Qs2aj
         jsYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720547214; x=1721152014;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c4EteS+g5P2KsWzL1nRT1ZGJ+E/RL4GUaEWIIDrIWAs=;
        b=CLgBhfDd1+5B84CwceEB7HRgoqXBliRare9JBcF/m5Ipj3WGmeJxuaBs9emWD4Pvr6
         9a2TAbpN94KWsx3Gv+bs+x2E4Qf0b9mvA4vnOaaMraQxFUbnhH0nDgMHCSS6bGKpu6/i
         iMJgchtXY94vdWQOURwnl3YQG97Rprbre6pRGCFM4Flpp8N4mATSsJE8wEWOC/k2Gyo3
         i5OMtc8uzZUcAciCViB+Pc9Bxwxuv2QxV67DMGkV9dGEeBF6hczAVl5HQgIR5nSGGYV0
         SV6VC7EvCyKB3VByLrWN/1JXMqX8H4ml0gUKTetYheBS2cVqzjUZvylkgtqTXH++K75O
         BKnA==
X-Forwarded-Encrypted: i=1; AJvYcCXvI4VXLH8yybZNGWQTy34eoXYgdM1QX6Oc/wH9ocp/76OKXf9UQMpeChQ65L0atMnkhTXBPKIoAwBaRsIyBl/1oZyW1ucrzuGTdJ939DAza7HIMJxiXie3pZLACFI5J/jkD+9UrJJs3ffhWCasdGRh0qPfyNBby4TZ7JFcKzqTCANJfdPAeQ==
X-Gm-Message-State: AOJu0YwCbffmIx+WKB4otqUiKRZyzrEF/wiamjVcHDNGyzKyHXYevwAe
	mjvMNXr0H1IK14jSP+JFD5Z0KjCNZvutspxgOJfuArFNh285v0Lo
X-Google-Smtp-Source: AGHT+IGHTIOszHjbB8Cp0KSLwVZ1wRZ12dUicem58K+FexjxdiJQ7n4mvkoksokc/zKZDjzkaEQv2g==
X-Received: by 2002:ac8:7d0d:0:b0:440:b945:806b with SMTP id d75a77b69052e-447fa908400mr41380691cf.48.1720547214100;
        Tue, 09 Jul 2024 10:46:54 -0700 (PDT)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-447f9b26c83sm12561391cf.2.2024.07.09.10.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 10:46:53 -0700 (PDT)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 937191200068;
	Tue,  9 Jul 2024 13:46:52 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Tue, 09 Jul 2024 13:46:52 -0400
X-ME-Sender: <xms:i3eNZlmuPLDFBmQ-a3D20M5MIKeVc1cz9GWakEn8N3WAg41jgXDJQA>
    <xme:i3eNZg1OfL71es_n5b0zEHDtaL4dcjsoImggWDZWBPnRF0bSYmFhUgMbCqFuA9RiI
    ufao4655ewmizlDfw>
X-ME-Received: <xmr:i3eNZrpBafpDI-EJEiyvxnBkGckVGb1TUN8Fc4G_Psun2zFucMFRoUpO129vPg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdelgdduudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueeviedu
    ffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:i3eNZlmEOViz8umcOz4Y3a_z40dkmrZa1JeGshXwvUwTZHnYRm1DVA>
    <xmx:i3eNZj0Utan8h4tuzDSefSS5fS33aVAcVs0Chnb4uU74jUnqgaKaoA>
    <xmx:i3eNZksIawGJ2WnjzZuCfBHDnUFWiJQJ0Abe8p2BAQA-Ok5T1cW_AA>
    <xmx:i3eNZnV7x-UbrBUsX-QituzNM2Xxq8odv6RXXb-5upL4nzas0tIzpA>
    <xmx:jHeNZq17Z12Pz5lROR7eLFbaB2dwqaf5kIYDPzM55S2OaH6JNriXx6aC>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Jul 2024 13:46:50 -0400 (EDT)
Date: Tue, 9 Jul 2024 10:45:32 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>, linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
	rust-for-linux@vger.kernel.org,
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
	Erik Schilling <erik.schilling@linaro.org>,
	Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
	Joakim Bech <joakim.bech@linaro.org>, Rob Herring <robh@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH V3 1/8] rust: Add initial bindings for OPP framework
Message-ID: <Zo13PB-fZ8B9WEYy@boqun-archlinux>
References: <cover.1719990273.git.viresh.kumar@linaro.org>
 <fe8e9a96b29122876346fc98a6a9ede7e4f28707.1719990273.git.viresh.kumar@linaro.org>
 <ZoVvn0QCSR8y4HQJ@Boquns-Mac-mini.home>
 <20240709110245.o73xnrj6jsvz2v2w@vireshk-i7>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240709110245.o73xnrj6jsvz2v2w@vireshk-i7>

On Tue, Jul 09, 2024 at 04:32:45PM +0530, Viresh Kumar wrote:
> On 03-07-24, 08:34, Boqun Feng wrote:
> > On Wed, Jul 03, 2024 at 12:44:26PM +0530, Viresh Kumar wrote:
> > > +// SAFETY: `OPP` only holds a pointer to a C OPP, which is safe to be used from any thread.
> > > +unsafe impl Send for OPP {}
> > > +
> > > +// SAFETY: `OPP` only holds a pointer to a C OPP, references to which are safe to be used from any
> > > +// thread.
> > > +unsafe impl Sync for OPP {}
> > > +
> > 
> > Same for the above safety comments, as they are still based on the old
> > implementation.
> 
> Do I still need to change these ? Since we aren't always using ARef
> now.
> 

Correct, you will still need to change these. You're welcome to submit
a draft version here and I can help take a look before you send out a
whole new version, if you prefer that way.

Regards,
Boqun

> -- 
> viresh

