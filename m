Return-Path: <linux-pm+bounces-22107-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 156E9A366D4
	for <lists+linux-pm@lfdr.de>; Fri, 14 Feb 2025 21:24:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D9E41895670
	for <lists+linux-pm@lfdr.de>; Fri, 14 Feb 2025 20:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F66198A11;
	Fri, 14 Feb 2025 20:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H51KPdFl"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C570019066D;
	Fri, 14 Feb 2025 20:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739564687; cv=none; b=Pm1Q3tSpDm2g8rWkc2MB2ZkjapoAG4h6lz8Q+r34brmY8KEvhWxAocFZn3tpm3kUa1YHInjLwL13D4UdFMvkJxu+v68xPoe7lC0tgtJ2fzt7gnVR8NFpA9LnPXZ6MluZkjluIlI6Fo7zeTI5PFz+iCPxfPga6DZugSTuSZnqOdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739564687; c=relaxed/simple;
	bh=bCH5bqvcaIOMu8AtEhHMduHrLldLHxk+IB++yM9jvTw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LwscspPDNWgTwQVA16SivDCsqGR9qZIxAZJ3gYjO4f6GCerYtZN5hDq+kygahXzlrxuTvRlXbT2i4QshSmT+RjPh98hTFHoV4jWMoQMlvc1cwY5YP8L9QDLq43qQyRd/ygWl/9zJBP/+lGvOINg5ziEI5aX1gKaVVf6qftRReQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H51KPdFl; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2fc0ab102e2so536716a91.1;
        Fri, 14 Feb 2025 12:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739564685; x=1740169485; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3p4NWmc8ditZ/XLLp37+2EiA/PYp9yKBL0C/xM4/3Fg=;
        b=H51KPdFl8DhqtvkPdj1BL3FTCEzZVuPjP3aE/WwYgHPxH6fcBDAL5iDxhdpOqFLsH7
         tNLLJt+El/nQEat9R7Y0pf1yywdKZWsVnApT5WEMIZ9RmDEJ9Gp43D6afEUWOYqJ/o7j
         kmGhOxIx/4EowxJo81/YAEgTxSpSsNVPL2s0O7wadQe3mT1rMFdShFnkXdT+sTZmYSCW
         zJxhd9MpDeCt7C0wmhmwj5BwLQxeDGAnp1XtG21xz6FgE8AUeYMrc4LguymJeJ2UcnvI
         x+mdsi+LOO0BUi56AdajYXEQon+P4akFuSXCMWSKxfmdEuz8qekUBe/rzgV6Xg1c6dc4
         bO4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739564685; x=1740169485;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3p4NWmc8ditZ/XLLp37+2EiA/PYp9yKBL0C/xM4/3Fg=;
        b=dTtCuDPsmGoHv0IYbwAreh6sbicdE1+LjctGtFNp/xVmWgPnhauIfbLcKOl+UI5imu
         Yzsu4doDGP2r6Nn4EcUY325sUpBMY0mHzbLl5cFppr9Xes5PUs4BpLD/oSPnPsEn/cWm
         T+CiSyAcxQfpvgeYpzLSr9/s6I5mRjgrmnFEV6uxjf3Fxb4d8I7PMfJA4qUKA5u1kcPX
         c3EsrvPDcQTEdpG/jeRuCqAsvxl+ibR7Jr87WPc45ODUeC2CPKuTNfqjcrZvH9BOIa+q
         gkjW9UyBRJ3d/8ANEJt40T8CFEjDTkm7Tcym6ZV8wIv8PJPigtcbxgkkojx0VJQMiN6n
         Gxhw==
X-Forwarded-Encrypted: i=1; AJvYcCUrO56pz8qj6ku5eJPvMaVOsQR7gSe64uGjVsOXAXQCT5nyzX1Z5yMoYiwYAuwUFSUw0/QsxUL829c=@vger.kernel.org, AJvYcCX/e2bHVkqQzWWOT1rhaOelXI7wCgz31iHIyyFRmGEjiRRK+4C6l7D+x2qAJncTtO3GR/c4RTcPLgusREQIrjc=@vger.kernel.org, AJvYcCXXbGj2M9zaD1bSaDU+GtggbwBlkSfjFzdUYXOgX5KBAKgUNDh9Rocu8U/CNtTRthNIpGopUY7F8FK7Dio=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0zGZtoov6ij0dTz+2Yhq0s9FaO7l43e8ldq4JAWyD3kXolZlL
	oze5PanFrOVSrRzb/lt0v9pYMDpWCJyjopNt1Gg9+QYHmXmlmi6X39mLeBeYhl/ufMCGphgZDye
	2lDnRGF08Gxa/FVYdSSOmKpgT228=
X-Gm-Gg: ASbGncvpKdLmO2cBr7evPR3ir6wcChHlA45kn3SVKtcGv3fFF+3QXz9wrHb/KjtPrC7
	IUkB4dZ5A0SSYuhPcnfvyz53Tehr8sTMOLGjW9hrPepaH3305aLdZfadYnHz3AH5yDJJ8163h
X-Google-Smtp-Source: AGHT+IF24MagOcPGW+aiXWTvUfci3RUEVLMRU+XbtgYBAc9bJXXtAADDZlKmnfOAhWjgutKv8hu1TOI1+305rKUa+Gk=
X-Received: by 2002:a17:90b:384a:b0:2ee:cbc9:d50b with SMTP id
 98e67ed59e1d1-2fc4103d1ebmr245319a91.4.1739564684871; Fri, 14 Feb 2025
 12:24:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1738832118.git.viresh.kumar@linaro.org> <db0166341ce824c157d0c58c240b3efc6aec6f6e.1738832118.git.viresh.kumar@linaro.org>
 <Z6qTelPSqpFk439l@thinkpad> <20250211042908.nyftiw7gtxosfjwc@vireshk-i7>
 <Z6t51xodSV21ER4M@thinkpad> <CANiq72=3MR9F9ur-aQYP4P81RBreAr=UiGg5iaSuFjjd5Q4Y7Q@mail.gmail.com>
 <Z66oWuLwY4X9Ou9D@thinkpad> <CANiq72=Yy8e=pGA+bUHPZhn+D66TmU3kLSjAXCSQzgseSYnDxQ@mail.gmail.com>
 <20250214191103.GH3886819@nvidia.com>
In-Reply-To: <20250214191103.GH3886819@nvidia.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 14 Feb 2025 21:24:31 +0100
X-Gm-Features: AWEUYZlQfDk3KdlkX87QSgmQBgzvj_9kUJuWl1DKFReZ4mhVoDc0DlTBJSkE9N8
Message-ID: <CANiq72=tDhUEjdBmVTPv4cFeD8iiKwJAQD3Cb1=Y4KnE-vh2OQ@mail.gmail.com>
Subject: Re: [PATCH V8 04/14] rust: Add cpumask helpers
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Yury Norov <yury.norov@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@redhat.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, linux-pm@vger.kernel.org, 
	Vincent Guittot <vincent.guittot@linaro.org>, Stephen Boyd <sboyd@kernel.org>, 
	Nishanth Menon <nm@ti.com>, rust-for-linux@vger.kernel.org, 
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, Erik Schilling <erik.schilling@linaro.org>, 
	=?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
	Joakim Bech <joakim.bech@linaro.org>, Rob Herring <robh@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	linux-kernel@vger.kernel.org, Uros Bizjak <ubizjak@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 14, 2025 at 8:11=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> Sure, but it was said, by many people, many times, that "Rust is
> allowed to break".

A lot of people have said many things (especially in online fora), and
many of those things are contradictory, but that does not really mean
anything.

> This is not just my incorrect impression. For instance read Philipp's
> note to Christoph:
>
> https://lore.kernel.org/all/293df3d54bad446e8fd527f204c6dc301354e340.came=
l@mailbox.org/

Philipp probably sent that message with his best intentions, but he is
not part of the Rust subsystem nor speaks on our behalf.

He may have been speaking for other groups, or maybe just his own
opinion -- I do not know.

Moreover, sometimes suggestions like his may be referring to
particular subsystems (like the one that was discussed in that
thread), e.g. like block decided to take an approach where Rust is
allowed to break, rather than speaking globally.

Finally, ambiguous terms are used in many cases to refer to different
parties: "Rust community", "Rust people", "Rust team", "Rust
maintainers"... I have started to ask people to avoid doing that (at
least in the LKML), please, and be concrete if possible.

> And Greg's version:
>
> https://lore.kernel.org/all/2025013030-gummy-cosmic-7927@gregkh/

I cannot speak for Greg, sorry.

I can read his message in the following ways:

  - I can read it as a general ability of subsystems to potentially
agree to treat Rust code as something like staging, like block's plan.

  - I can read it within the context of those patches, where, as far
as I know, Danilo et al. stepped up to maintain it, like Andreas did
for block.

  - I can read it as the fact that the Rust subsystem will help,
best-effort, to bootstrap Rust and help with integration where
possible.

We need maintainers' help and expertise from other subsystems to
succeed. And we do not want to force other subsystems into dealing
with Rust. That is why the deal was that we would contact and wait for
other subsystems to handle Rust and so on. It is also why I asked, in
the very meeting where it was decided to merge Rust, that in exchange,
we would eventually need some flexibility by maintainers that may not
want Rust in their subsystem but that nevertheless may be the owners
of core APIs that other users of Rust in the kernel need. I did so
because I knew the day would come we would be in the situation we are
in that email thread.

> I've heard the same statements at conferences and in other coverages
> like LWN. Frankly, I never much believed in this story as workable,
> but it was advanced by many people to smooth the adoption of Rust
> bindings.

Again, people may make statements, but they may be local to their
subsystem, or just their opinion, or it may be a misunderstanding, and
so on and so forth.

It is very hard to keep hundreds of maintainers on the same page.

> I do not agree with "Didn't you promise Rust wouldn't be extra work
> for maintainers?" in your document. Clearly there is a widespread
> belief this kind of promise was made, even if it was never made by
> you. "Rust is allowed to break" is understood to be the same as saying
> it won't cause extra work.

Sorry, but I have to strongly push back against this paragraph.

Are you really saying that, because people out there may think
something, we cannot claim anymore that we did not promise something?

Furthermore, I don't agree with your assessment in your last sentence
at all. Even if it was decided to allow Rust to break globally and at
all times, it does not mean Rust is not extra work. It is, because
collaboration would be still needed with different subsystems and so
on. The plan has always been to not have Rust be something hidden in a
corner. For instance, see from 2020:

    https://lore.kernel.org/all/CAHk-=3DwipXqemHbVnK1kQsFzGOOZ8FUXn3PKrZb5W=
C=3DKkgAjRRw@mail.gmail.com/

> However, I am glad we are seeing a more realistic understanding of
> what Rust requires of the community over the long term.

That is good, but to be clear, from my point of view, the approach
mentioned in the document I wrote is what we have always said.

Cheers,
Miguel

