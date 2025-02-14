Return-Path: <linux-pm+bounces-22119-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B6EA36853
	for <lists+linux-pm@lfdr.de>; Fri, 14 Feb 2025 23:37:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9C103AF45D
	for <lists+linux-pm@lfdr.de>; Fri, 14 Feb 2025 22:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1BC01FC0E6;
	Fri, 14 Feb 2025 22:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MpsCY9b9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24EB31DE2B4;
	Fri, 14 Feb 2025 22:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739572632; cv=none; b=OPu1UBH08AAH4OSO0auv+2L7fzEKVIb0VActHifbzlbJyeRK0Vc3gmTF2qvuhzEvSWq9islUNESAsrwai8tHKz9bJUfU1B59bbJwjAY8J7ieEebC5nkun0KXBVBzchQRxfIaHSivCymNZvTlZjqzOePLTWmjCF3PC2JX4IKJqAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739572632; c=relaxed/simple;
	bh=Bs60h0N8fnkKtRjpLMziT0T6dlheBegFD8UUIfzUq7Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PIstqstXp2E5IBEEG87HC6tmPtPT8TM8JyvtbvyAr0bO+btcCr1/11KF+z4bKOKGyhkV44IT2TWhZYd3uBEqKFP2oy4nwqVC8rXEW4nkaVnZu1w7DJtoi7u2EillWcCzhvXgUAfAt5o/9Fplto9BoueMK0I+4N7kwoeVpOOSJPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MpsCY9b9; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2fbf706c9cbso557021a91.3;
        Fri, 14 Feb 2025 14:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739572630; x=1740177430; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OdevA1flai+NyKTLVYDy9L1A4OOTYCbLo9KPs3hmNuY=;
        b=MpsCY9b9bDhvR7o9+BHvQnjaKYKl+x5+cbe47buMbNxh5AbakIre1Wm4BSTS6tn/2O
         U0EwA0jfHY28/WKqH+k6NPVk3SfZq1NI9XFqEKuVNVzkPZ4AJeWqr6IepCQwnCAoRqxd
         1flL/MyrW6Tqpc2oIKzlrsRx7gQ+ZeMPiTP8hpDX9YXUvkwhjebIxQ0BcDhYXhm2tkT2
         4KX1RxjgXQlywAVmE7H4aK/mvE0xto/OaNGFImmXchy6j7/Bhw2ayUuEMaXF2EHzSZ7I
         KluKKKKo/2PuoSgpDOpAO7GEgOP988AonZ256kWIMg2TPT475ywho84AL0/l8KtVJBr1
         PTsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739572630; x=1740177430;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OdevA1flai+NyKTLVYDy9L1A4OOTYCbLo9KPs3hmNuY=;
        b=kHrmU1xUyswUyvx9x9GUYa0EoxWEfXuNMPiEvxShipbp9CQaoJ1gKjxo78j0sUdCzf
         elda8Upe9kTppu+J6bnFMVIfTLbooKB5GuUwT/buZdjITEijvru+mfEvJnt0E7+YBt4H
         PfFTOg4Ew/n/8/kefMaVvzC3B1NVkzM1bFhSdhSiF4MG2zvtIlbjsqPDmlC0LfT4YXyp
         Du0GtMzEEru1+UCq4Y9F39cGLMSd1PVl7IKq2nGLTHNCVVGQjZnZLAGYKBiMlLj8MyGa
         aXzrYmXMvkzV90G3aVhLZ75pMWMj5NLcePPY/HwTDDoIb6R7SyVs0chZQge5qx4sFkOJ
         Vk4A==
X-Forwarded-Encrypted: i=1; AJvYcCUrfC7N16tBERKfiKHLGqWL9A7Fzr6lbE1SrgkonhwcepRxVjv2m8ncEnL6UAkc1zJ9oE3Ppjy2I3B+H2Fg1Fk=@vger.kernel.org, AJvYcCVyzOuNsE+2BOqnqI7EpnqJD96k61zi915KKqVp4C9td37JDHhsw6iqzKG6hz46Qz3Qd3yvadHMOHw=@vger.kernel.org, AJvYcCWey86OIHVMYVmGM0/dkPHTjTkuLTRbriRZwayDsi25kqZ2/plRUpfxrg4GR86hygi4SwlwZroB2sL4tNU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3bphV1TbAx+SjI8xwYT0S9ar32GhO2XbW0ZluiW7L01pe1JRF
	ZVO42UhXUXYs+CX4iklYdAqCzM2fKHEbMTR3sSyMkcYTwKpSRZ0loosN8ho2mao17Q5sAn3Mx6z
	6Y0qSOe57D/zQbBYeyrrg/Am3uMc=
X-Gm-Gg: ASbGncu6Z5UzqGLSpRccr23t0xFhCN78kuQGTuAdRhLc9iCL8sm/yp8KX+MGUNUjzWh
	hy9YHf21ZJD7sScH6TMSTjoVSCTg1z4TpAyFTgPfuLYswFSM3yxVERrcNJy/2B1a1qDF0862s
X-Google-Smtp-Source: AGHT+IHfJdYJhNQjpN05/0eg1D/Ck5SGjm9iY29eg3CuAefNHS1mJ+fwTDyHWcfA+jNVrvYx3jAwma+PzZGFzNy3axk=
X-Received: by 2002:a17:90a:d2cf:b0:2fc:3262:9465 with SMTP id
 98e67ed59e1d1-2fc41153dd6mr480206a91.5.1739572630108; Fri, 14 Feb 2025
 14:37:10 -0800 (PST)
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
 <20250214191103.GH3886819@nvidia.com> <CANiq72=tDhUEjdBmVTPv4cFeD8iiKwJAQD3Cb1=Y4KnE-vh2OQ@mail.gmail.com>
 <20250214210637.GK3886819@nvidia.com>
In-Reply-To: <20250214210637.GK3886819@nvidia.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 14 Feb 2025 23:36:57 +0100
X-Gm-Features: AWEUYZlRuiv6mKhS9od7TfXZrZWpxFsdKXL1PjYCKlVITF8okDxoyQK93Or0kVY
Message-ID: <CANiq72mFKNWfGmc5J_9apQaJMgRm6M7tvVFG8xK+ZjJY+6d6Vg@mail.gmail.com>
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
	linux-kernel@vger.kernel.org, Uros Bizjak <ubizjak@gmail.com>, 
	Greg KH <gregkh@linuxfoundation.org>, Philipp Stanner <phasta@mailbox.org>, 
	Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 14, 2025 at 10:06=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> w=
rote:
>
> We don't have a community where there is a clear authority
> structure. If lots of people are repeating a thing, that thing usually
> becomes the consensus and common viewpoint regardless of who
> originated it. The repetition reflects community agreement and buy in
> of the idea.

We cannot be expected to chase down every maintainer in all online fora.

Not just because it is not viable, but because hopefully this is not
about who shouts the loudest (=3D=3D more often).

Moreover, we do not have the authority to set policy ourselves, and we
are not in the business of forcing things into other subsystems.

Now, if you are a maintainer, and you want to deal with Rust in the
kernel, then please do any of the following: send us an email, join
our talks, read the LWN articles about our talks (but do not assume
LWN comments are "consensus" somehow), join our MC in LPC, join
Kangrejos, and so on and so forth.

We have been open to talk to every single maintainer that wanted to
use Rust or that we needed to interface with, and other maintainers
can tell you that we have successfully worked with them.

> At the end of the day, only the policy adopted by the people merging
> patches really matters.
>
> The assumption being if respected people speak with authority on a
> policy they have also got buy in from the people responsible to
> execute it.

Sure, and that is why we talked to the actual, relevant, maintainers
and subsystems that are taking patches that are related to Rust.

We may not have talked to you directly or explain things to you, but
that does not mean we didn't talk to others.

> I also think you should merge your policy document to the tree, not
> keep it on a web page. That seems to be a big part of getting
> community agreed policy adopted.

Very happy to do so if others are happy with it.

I published it in the website because it is not a document the overall
kernel community signed on so far. Again, we do not have that
authority as far as I understand.

The idea was to clarify the main points, and gather consensus. The
FOSDEM 2025 keynote quotes were also intended in a similar way:

    https://fosdem.org/2025/events/attachments/fosdem-2025-6507-rust-for-li=
nux/slides/236835/2025-02-0_iwSaMYM.pdf

> Okay, that makes lots of seense. Please don't use "we" as well.. I
> have no idea who is included in your "we", or what to even call it.

In my emails in this thread, "we" means the Rust subsystem entry.

> Yet he does seems to be speaking with authority on this topic. His
> message was quoted on LWN and likely was read by a large number of
> maintainers.
>
> Is he not part of your "we"?

No, he is not part of the Rust subsystem entry, as you can easily
verify in the `MAINTAINERS` file.

And I can not speak for him either.

He, of course, has helped us a lot, like other kernel maintainers have.

By the way, the document, at the top, mentions:

    Like most things in the kernel, these points are not hard rules
and can change over time depending on the situation and what key
maintainers and the kernel community discuss.

> I think it was very clear, sorry, I don't read it your many ways at
> all.

Well, then please ask Greg, not us, and remember to Cc him, by the way.

> As a side note, I don't see how anyone can enact this plan without the
> support of Linus to do CONFIG_RUST=3Dn builds and put out a non-working
> rc1. IMHO it is yet unclear if this is real thing or an unproven idea
> block has that will run into problems.

Please ask Jens and the block layer -- Cc'ing Jens (Andreas and Boqun
are already Cc'd):

    https://lore.kernel.org/all/593a98c9-baaa-496b-a9a7-c886463722e1@kernel=
.dk/

Having said that, I am not sure what you mean by -rc1. It is in the
context of a friendly collaboration -- I assume the intention is that
Andreas et al. are given enough lead time on new features to fix them
before the merge window. For fixes, it may be harder, of course. Other
ideas: they may be able to config out certain parts too; or in the
worst case, in an emergency, Linus may decide to break Rust. They may
be able to tell you the details of their plan.

> It is, but also I think you need to take this challenge to succeed.

In fact, we are, and I explained above all the ways we are engaging
with maintainers and so on.

Please note that the fact that we may not tackle the challenge in the
way you would like does not mean we are not doing it.

> It is not clear at all. If you said Miguel never claimed it, then I
> would not complain. You said it correctly above, be concrete. Ideally
> acknowledge there were different policy ideas in wide circulation, but
> they did not get adopted.

We have never (intentionally) claimed that. We may have spoken
unclearly, we may have been misinterpreted by others, and we have
always been open for clarification.

Please see my previous email.

> I appreciate this point is realistically true, but look at how Philipp
> presented this 'no break' concept to Christoph as a no-work option for
> him.
>
> My main point here is that I'm glad things are getting straightened
> out, some of the conflicting policy ideas shot down, and the demands
> on maintainers are being articulated more clearly.

Again, to be clear: the approach we have followed has been quite clear
if you actually spoke to us, instead of taking for granted what
unrelated people may have posted.

> There is another we :)

I am not sure what you are trying to achieve here.

Cheers,
Miguel

