Return-Path: <linux-pm+bounces-22054-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB7E9A3549F
	for <lists+linux-pm@lfdr.de>; Fri, 14 Feb 2025 03:20:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34BEE188EE2B
	for <lists+linux-pm@lfdr.de>; Fri, 14 Feb 2025 02:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 863DD2AF16;
	Fri, 14 Feb 2025 02:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="en4GRU6h"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC53D3C17;
	Fri, 14 Feb 2025 02:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739499615; cv=none; b=Sg7oqqv3T0/36B5eXwQnoH+GACaTXCMG8xtf7AN6jKBk8yBhpoYIIzNF5DH8qzxii9Il1/hRgo+DwSDDs+8XAzOjBAnRlubJfIiLMRQJzPC5Q4u/eLGCPbIVtF1I9AOmmZPQl//7Qj8fAQNU3pKwPP0KD2SocCV0huqACBAXyX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739499615; c=relaxed/simple;
	bh=jYP0+D9vE1xhJcqq2qnQolJIYnqYPkJoXLNihXv7O44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OLRe9Ar4SizsLukC2rxQv5+bZ2mc4By5Qrh7BPMbsjBULNCHrGcHfUFBt7+2y5wwQfg65eZpKiZPP9R1yHqFi42PBMYXVTMftB5zjQZmCYpiT0i8Wi3F4wyqFLIZ1fgYrt9jv+lDt9jbbQlQnF5MYKYjgwz1yO0pvlorDFDOB14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=en4GRU6h; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6f6ca1a8aa6so10212507b3.3;
        Thu, 13 Feb 2025 18:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739499612; x=1740104412; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=k5rJH9lwQCpm9j5rIEYTkviXPHjdbe+93D14r2lCU9M=;
        b=en4GRU6hXHOR2pA2W1+KMzKTP7EUqEn0dNYTSWAdibnPSu/QRtUDQ8B941UY4AE+zi
         T3XZvitCF16Hr4VzWyrq+oUk8F31OySkN3kbnPf5BKG9ps1TJcBpwwq8RssoyjjNTZid
         bG2UHK5Qd6y295hhCOmmW4eLgjubpinZ/UFMZTVLBY0xXVoWEqGq6xRoR76g0PPNxrjn
         gqATkeWGXzVOhgv7evXj4s8Hj2DEmYnxt7DUOQ74ubV6gppXttFsuBMW5mxRFbL2yBBK
         Q3GYJqacDIhFRAOziDFJk05fr3wyX3AAQi7cSvM6QMIcuWc49C1Wa/XmQSZM0PN/hLo/
         4TEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739499612; x=1740104412;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k5rJH9lwQCpm9j5rIEYTkviXPHjdbe+93D14r2lCU9M=;
        b=Hh63u6DuoptPFOupp7lYblEZxKyjLbYOg22A9elDZVdKIs83SKyrt0Gg7e6TPBNC2H
         OzNaS0MPlHJPmgw8ff2GGUc/pcEL7so4BFmz1/kBhqHOWFa+iEyCZnEMryDSJ8OfeBCz
         kbWGN550eHXOeZASi61O+igY4+CN25/+G/55OVW+PELoeJlH0tEGzalBcpw2VlTKfNQt
         iB3utdxOamJV6OKi11v5rPJ6qesYD4S5XBTEp/LgcbAMsujPxUc9CeXEoBPYj2TOlKdu
         7L3aLYKcWOimZgHtBeNCnGNE5dwH57Has4IHElfOvaXeAzvHdvMslmGWIOQIuGhUKxsU
         wkPw==
X-Forwarded-Encrypted: i=1; AJvYcCWJo24jI7dV3csBZv/kP8cVsPcSD5YGDX6PcIVt0TZZaJ0KcxuLqqCBK93fOIKPfDYpoBt+OF77TvA=@vger.kernel.org, AJvYcCWXU9EoyNbq97iBI+1dldJ3IaJwJzRPVooeKqUY6rCzRi+XYqyK7vWJld0EEBc3xiPCXi/GCuClsf4iPEs=@vger.kernel.org, AJvYcCXUCZBfvDMKqM/DIB4YgC0cFqaeexRqOPkC+foRV06GJOd/YoI/E8NDLupaQYq58EoWVgGMDO0TMj2eGmwfxog=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP5zjC9chzUidgkeqk/voE/2Mdr8Z76OkT3Dg+D9QeUHKIif9q
	ISe/Fq7IEj36GIg3IKmgkdnBA4afFx1jXnwxfa1fVKun8xestLH5
X-Gm-Gg: ASbGnct1iXJlZS/tjKJ4lHjO+QtuAs1MALMx43uQRd2qyLeN8ar42o/wgd2/H0iSkcX
	liaRZSX6s4ldpqMgu9Dljo+LP2A5ZM5gxrJyMJlseiQtzVPCu9FVQTyFi3rUVM+vwuc6xgHKK3U
	fZ9cmk/gZ/zGnuRgRvT5bZQwBbHukW3kIOdbzH7DI5hmJxF7DAiej7OOZGm5ff3D2U3xGIgxkP7
	XQFKhtWNRm+Cz28PpNgd7ysnIvKt65teCrPiFt3rxhab83I/ZIrsM0KB/OycUv3wTxZzReFiRIA
	nR4j/XEARs0CoPwg9js+JvYDlWaahfz83VwpKuuIo71vXCRYcwI=
X-Google-Smtp-Source: AGHT+IGguoYiGmnK1arkpNA0oHTATS5WHQcMpyRzwCVNGClVc/8aSgtIdbX1SqjWtK65NKQm7w3eZQ==
X-Received: by 2002:a05:690c:9b13:b0:6f7:534b:55fc with SMTP id 00721157ae682-6fb1f17e625mr100699197b3.7.1739499612547;
        Thu, 13 Feb 2025 18:20:12 -0800 (PST)
Received: from localhost (c-73-224-175-84.hsd1.fl.comcast.net. [73.224.175.84])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e5dae13a56bsm714407276.57.2025.02.13.18.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 18:20:11 -0800 (PST)
Date: Thu, 13 Feb 2025 21:20:10 -0500
From: Yury Norov <yury.norov@gmail.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@redhat.com>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
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
	Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
	Joakim Bech <joakim.bech@linaro.org>, Rob Herring <robh@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Jason Gunthorpe <jgg@nvidia.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V8 04/14] rust: Add cpumask helpers
Message-ID: <Z66oWuLwY4X9Ou9D@thinkpad>
References: <cover.1738832118.git.viresh.kumar@linaro.org>
 <db0166341ce824c157d0c58c240b3efc6aec6f6e.1738832118.git.viresh.kumar@linaro.org>
 <Z6qTelPSqpFk439l@thinkpad>
 <20250211042908.nyftiw7gtxosfjwc@vireshk-i7>
 <Z6t51xodSV21ER4M@thinkpad>
 <CANiq72=3MR9F9ur-aQYP4P81RBreAr=UiGg5iaSuFjjd5Q4Y7Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72=3MR9F9ur-aQYP4P81RBreAr=UiGg5iaSuFjjd5Q4Y7Q@mail.gmail.com>

Hi Miguel,

On Tue, Feb 11, 2025 at 10:37:26PM +0100, Miguel Ojeda wrote:
> On Tue, Feb 11, 2025 at 5:24 PM Yury Norov <yury.norov@gmail.com> wrote:
> >
> > No, not Okay.
> >
> > To begin with, this is the 8th version of the same patch, but you
> > only now bothered to CC someone who is listed in MAINTAINERS. This is
> > not how the community works.
> 
> Yeah, that is not good.
> 
> For what it is worth, we try to make this very clear:
> 
>     https://rust-for-linux.com/contributing#submitting-new-abstractions-and-modules
> 
> i.e. that maintainers need to be Cc'd and contacted as soon as
> possible (possibly even before writing the code).
> 
> > You also made it a patch bomb that touches multiple critical and very
> > sensitive subsystems. You link them to an experimental and unstable
> > project, and do it in a way that makes it really easy to slip through
> > maintainers' attention.
> 
> Not sure what you mean by "unstable project", but I agree that the

I mean that Andrew's branch got broken because of it.

> patch series, unless Viresh is the maintainer of the C side of
> everything added, it should be discussed and maintenance discussed
> accordingly before merging anything.
> 
> This is what we have done for everything else, and that has not changed.
> 
> I try to spot cases where this is not done, which is why I Cc'd you in
> v7 and told Viresh to please do so, and he did -- I don't think he was
> trying to bypass on purpose:
> 
>     https://lore.kernel.org/rust-for-linux/CANiq72=o+uc3ZnNrdkuoSGSL8apNE4z4QwpvsiLfGzXFywSLrQ@mail.gmail.com/

Yes, I see. Viresh didn't do that on purpose. Let's move forward. I'm
more concerned about lack of testing on rust side that ended up with
the patches withdrawal.
 
> > That would make things even worse. Before you wanted me to maintain
> > rust linkage. Now you want me to get approval from someone else who
> > maintains rust linkage. In case I need to change something, I want to
> > be able to just change.
> 
> Like Danilo mentions, there are several ways to go forward here. For
> some ideas/context, please see:
> 
>     https://rust-for-linux.com/rust-kernel-policy#how-is-rust-introduced-in-a-subsystem
> 
> (Thanks Jason for linking the page)
> 
> And, yeah, whoever ends up maintaining this, then they should of
> course be testing it properly with Rust enabled with a proper config
> for that and so on, just like one would do for anything else. By the
> way, it is possible to request Intel's 0day to build with Rust
> enabled.

Yes, this should be done. 0-day is already testing everything in my 
https://github.com/norov/linux repo. If you know right people, please
ask them to test bitmap-for-next branch with rust enabled. If there's
enough resources, please cover all the repo.

> (Side-note: to clarify, there are different parties involved here --
> "Rust team" is fairly ambiguous.)
>
> Cheers,
> Miguel

I'm the right person to look after rust bindings for bitops, inevitably.
I will take over patch 4/14 and submit it separately together with a
new maintenance entry.

I will not maintain any rust code. For 5/14, after I'll send my series,
Viresh, can you submit 5/14 separately and create a separate entry in
MAINTAINERS. Please make me a reviewer there.

I'll think about details over the weekend and will submit everything
early next week.

Rasmus, if you would like to help me reviewing this thing, please let
me know.

Thanks,
Yury

