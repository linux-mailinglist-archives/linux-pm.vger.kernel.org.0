Return-Path: <linux-pm+bounces-42566-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gJCZAIDdjWna8AAAu9opvQ
	(envelope-from <linux-pm+bounces-42566-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 12 Feb 2026 15:02:40 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 587A112E0FB
	for <lists+linux-pm@lfdr.de>; Thu, 12 Feb 2026 15:02:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0E8AD3031EA0
	for <lists+linux-pm@lfdr.de>; Thu, 12 Feb 2026 14:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C60635BDAA;
	Thu, 12 Feb 2026 14:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nkcGJitf"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DB735C195
	for <linux-pm@vger.kernel.org>; Thu, 12 Feb 2026 14:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770904946; cv=pass; b=q79i4jONI8jXvJtzogDJqqjciQxUgRpagKou08iVtWatAc5HnF2Q6kaZfVDwvJIvpjfz9MXNBkNztFXH2h6GgTk9dl2wkbPC2+zfSmt/CmpjCjO0g9YdOCuMJWvxhUN3mCJzriY9dxZRpZdrx2tVjQ7N9Ui53Li/dGV105CJCXA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770904946; c=relaxed/simple;
	bh=JQdMCRkRLmIpXiZMZIzEwhlQnq6p9FnzGfa9kKgZNL0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hYxznSLGB1CCynpCxlqh50zwJLcMCrpczSb+M6wawCgtnCfZ53g81f2bnscLVGyRuMrCC2p0lNHqQTfEXioN/ghm0B9lItIOgkeOGWcGKclruEARABKmtGMRbnYtwHQLjn8bHy0Rzmzoa5C3zjK5NzzGg0dQFHW4fXcAONOXvsc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nkcGJitf; arc=pass smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-436317c80f7so1311703f8f.1
        for <linux-pm@vger.kernel.org>; Thu, 12 Feb 2026 06:02:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770904942; cv=none;
        d=google.com; s=arc-20240605;
        b=Fe8Emh+hsdt+6NjZSJBweyscFmhfE4ElHqi0ec5d4GPzAiUY7R05ZhLtW8q6sSInpr
         VMGfekng2xDSmK+znZaLFPQf5W62hxcqzP8KCzNgb0ID3ji8X2rqD94AsMHN+YFi3uMa
         LOVetJC4PrNRNQuPIzDXoBWgpiVXmCboa2wSY6YXWH8uQwjVisCmCCkWpt7CrlJ0lpdl
         ZJAGULwkDyXcjNeyI3tMyi/nTDGNK0SikcYxJQbgsy4PAJT28p+WKI54u2IXkPKRqYTh
         o94VKcCoMurWxeWYPz9tNX4H6u3+eDA1Mkvr63u1/d+SGHx/ZtOMdhGjxr9VgajofS9q
         LC1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JQdMCRkRLmIpXiZMZIzEwhlQnq6p9FnzGfa9kKgZNL0=;
        fh=zj7TuZntDGxYwoPFoNRJCTx9BKtgAU0giYaC9WhS0h4=;
        b=go23rjrbqDX6/OnRZYdQ/gbGuL3kulB0MGffscN0gMj+RsHUHawFppVzb9G6Oyb2+T
         gST0uHaZrJPOaBoDJjiKV7Wf8Awi6/AkhHx6DiC6CueIxJeW8ebkoUkXbWTo/TXS+lnz
         7h+ZxP19Rm41ht+McUh6bHdXA18lEriFBtEsb80QPSHi2hO6ZIXLz+IKxBelAVRPpNbl
         5gRnuv97XFqR1tlRuiDanF/QXvDccP2iSVoXRow+3uoPxuX5UHYaZt90c4zO5nGV+A43
         bkUsPkG5FfALZ2UQP570hLiDQ2ZHXGWhwRpF9P2M7yFMYou/9HdOC9kSqDoUiNMPmYhd
         vVxQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770904942; x=1771509742; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JQdMCRkRLmIpXiZMZIzEwhlQnq6p9FnzGfa9kKgZNL0=;
        b=nkcGJitfKN0G4OfJOrGGOkiJ4pep0Vj2H3zB2WHtir1skPnmZ2efKXXR4RuUFigA5R
         ELKCWtFkouZOXQnuR0tL7jhAx2Gr3bBXjvO6KWK6fH14AMZAPZj/G+9C9kA/EAS30mPk
         erAIoqjIVqObUE03pQFYFbtSuwZ7sFMM/8U8ZglXH1Q1vMITd/9c0J8am3BJd15dD3fJ
         qC8I4R+q8RlUzVM4NB7AN5O2+nKrj49RVgzuaf5a9dOCqcokCwbYzx6CPe5RLVR4uLMJ
         /rRAhxT6hS+Upz6G+tuDxAu8TfJXQvY9zC+jXEZRHS70MH9x4H4jBPbnxCT6tyPMqBQv
         7j0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770904942; x=1771509742;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JQdMCRkRLmIpXiZMZIzEwhlQnq6p9FnzGfa9kKgZNL0=;
        b=jjrz0A57FjTdU1XNlZ5N8zpJ8z5megI3wbAPhX16pldKYYJpVLiZS2kmpksgTeuTSm
         Vu+gpG5UGfcaEcrl2acjAGVkj189b35XppZVPradOg/Ln8Q1go11MRd8axr3LEA0frTf
         FxwJaUDhzkQ+dsGa/C5AglJ4L3OhsHNSiFY5RaezgXBhpg5cAPwW7B8LKeD9+lrlVtlW
         f+9fnOeaKkJVxJ6MIxYvdTz30Kk672N65LyUcm6vJA4cEOjElT8Y5606vK5/cKcFFBhH
         C6dQp1xVGQbfsN5FDhfMabO8uzliyyefMoacrIC3Ly/KzmNqvdjKvO+bnMlgT1hHy/4s
         0ByA==
X-Forwarded-Encrypted: i=1; AJvYcCVZ9Qfd17KzcAx3fbsVZcSUE5iX82pSLY+ofkdCfeOhG23NXjwUYDRSv0WCJg4paeX+O5KnRecgZQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywup3kUiYPfzbGf2IVIRRfq7OTyHz6r3sHGcfa2MQ6uRxdAzzd6
	I3gPWF+Q/YkF+tBbd41+ybMYKfoAmPUIBpFX2LNBdONM1hfN0M5tDKhZFIuinrfa3ysQMTSiyTj
	pUhTWmKvGC4Nw1h66fBg9nwV+vT2Sss+JtYxtMF6G
X-Gm-Gg: AZuq6aIcQe8dBauc+MoLUTdK42WvlaQnYq50UukUXBu4h72Um6qB0rwJuGbEEzqyVir
	oHU4bgaEoe+oSiPX2lh+b4kYiVSkQJ80d3Eln4pg1KdSS1yy7UuIwViclDDQy1arp4Ar8aZPOds
	J+rCctwbyYIbN4Rg8+JAnLVwgYnzSu19o32GcMosAcHX3paSm9qaopJJdJ7d61ZBoxhjCMq81OF
	gOFXxFz2IPuc76T94iou8AWFu5QbmkR2Osn7SxuDrGJpzbRlRhzYsjJX60ibC8A2l59X4o95jCS
	GXC60NQ299PjjjHWWnfQAr64MU0CN6ORgSwZos4D9yvxJKQsqiGoVREbFh22z3eiF6wHNQ==
X-Received: by 2002:a05:6000:208a:b0:435:932e:f924 with SMTP id
 ffacd0b85a97d-4378e6d8d92mr4583407f8f.2.1770904941572; Thu, 12 Feb 2026
 06:02:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260119-weightless-pelican-of-anger-190db0@houat>
 <DFSN4FDCYHMW.3J3237PEBV2ZP@kernel.org> <20260122-majestic-masterful-jaguarundi-d0abde@houat>
 <2F3D3A40-6EF9-46FC-A769-E5A3AAF67E65@collabora.com> <20260204-nickel-seal-of-poetry-8fdefb@houat>
 <91A92D84-1F2E-45F3-82EC-6A97D32E2A78@collabora.com> <20260204-angelic-vermilion-beagle-fd1507@houat>
 <20260209105047.693f2515@fedora> <20260211-flawless-feathered-boar-0b87ad@houat>
 <CAH5fLgiQE7mJBpAxv6xTVKKFWadg2GdVe31hRM6gNk3Vah61MA@mail.gmail.com> <20260212-lumpy-uptight-petrel-cac725@houat>
In-Reply-To: <20260212-lumpy-uptight-petrel-cac725@houat>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 12 Feb 2026 15:02:09 +0100
X-Gm-Features: AZwV_Qg2-1q5B4F446nU29Cn7SlWuusys2TSQd4MD8qGMnFLRNj2Nk7LREIXN9Y
Message-ID: <CAH5fLghyg-QzT11gehvwTb2ii4FA-dkse=QtYD0Tc5MT5Dhd7A@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] rust: clk: use the type-state pattern
To: Maxime Ripard <mripard@kernel.org>
Cc: Boris Brezillon <boris.brezillon@collabora.com>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Danilo Krummrich <dakr@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Drew Fustini <fustini@kernel.org>, 
	Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-riscv@lists.infradead.org, 
	linux-pwm@vger.kernel.org, linux-clk@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42566-lists,linux-pm=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[30];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aliceryhl@google.com,linux-pm@vger.kernel.org];
	FREEMAIL_CC(0.00)[collabora.com,kernel.org,linaro.org,linux.intel.com,suse.de,gmail.com,ffwll.ch,redhat.com,baylibre.com,garyguo.net,protonmail.com,umich.edu,vger.kernel.org,lists.freedesktop.org,lists.infradead.org];
	TAGGED_RCPT(0.00)[linux-pm];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 587A112E0FB
X-Rspamd-Action: no action

On Thu, Feb 12, 2026 at 2:38=E2=80=AFPM Maxime Ripard <mripard@kernel.org> =
wrote:
>
> Hi Alice,
>
> On Thu, Feb 12, 2026 at 09:16:51AM +0100, Alice Ryhl wrote:
> > If you make the raw API unsafe, then that's okay but any use of an
> > unsafe API from a driver will receive very hard scrutiny.
>
> And that's totally fair to me. If drivers want to have a more optimal
> but potentially unsafe use of the API, then it should be flagged,
> documented and scrutinized.
>
> > Yes, there are occasionally good reasons to use unsafe from drivers,
> > but the entire point of this Rust exercise is to isolate unsafe code
> > outside of drivers as much as possible.
>
> So, aside from the risk of fuckups, are you concerned about something
> here? Do you expect that scrutiny to be constly on the maintenance side
> of things?

Well I do think it's mostly the risk of mistakes, yes.

> I guess what I'm asking is: except for the obvious "review" cost
> associated with it, why would that be a probleme if we have, say, a few
> dozen drivers using that unsafe API?

The reason I wouldn't really suggest the unsafe API is that, if I'm
the reviewer of said driver, then my review will be "just use a safe
API instead".

For example, if you really want explicit inc/dec calls for
convenience, we can make a safe API with a counter that returns an
error if you decrement more times than you have previously
incremented. Or if you prefer something else, I can think of several
other safe APIs.

> > If Daniel's proposal is inconvenient for some drivers, it would be far
> > better to have a third API that is both safe and convenient for those
> > drivers.
>
> Yeah, I guess I was expecting that one to come after we have a few
> unsafe drivers using it and we do need to consolidate / make it safe.

For most things, we implemented and used the safe API from the very
start. I'm not going to say there are never exceptions to that because
there *are* exceptions. But I don't really see why clk should be one
of them.

Alice

