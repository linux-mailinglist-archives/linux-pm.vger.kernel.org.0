Return-Path: <linux-pm+bounces-35098-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F06DFB8CDAD
	for <lists+linux-pm@lfdr.de>; Sat, 20 Sep 2025 19:12:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58A317B673F
	for <lists+linux-pm@lfdr.de>; Sat, 20 Sep 2025 17:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA353064A8;
	Sat, 20 Sep 2025 17:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3IVZQezj"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A994130648C
	for <linux-pm@vger.kernel.org>; Sat, 20 Sep 2025 17:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758388356; cv=none; b=Ep1GPvGPJAt8x+igIn+eqq+FNllBppB7DKyem1HAhoZm2VYmnvtQKl2r3V8RSYddX2v3zaqrjGWNtPnPHKol19u1nBD8QdNP/Yvqpf6yr3MsDE18OYTO49+QY83AnEEsXHcMMxFdYtqv5EkhuTvZIJJKJwrodAASMmKuEP27mmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758388356; c=relaxed/simple;
	bh=Gj1Ep/MJST8CACxWAubynz7i+zMqcF8h49oVjFnLgOM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MIKNpL3sBEv7c48HrNnmfE3sw0ADtIrK1+MgkOVy0HpSzR/vaX0X6kujju0ZaUKU0WjWP3UXZZtQN7lGFHt+qdOkhQLNMjX7BrdA6+vOIOku+AQL8A3Lml0erd+fOFoijCnWCQIEYt+rbGGBGHsmURRBs6BW7wt0MBYnzlgn/sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3IVZQezj; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45f2b062b86so19408865e9.1
        for <linux-pm@vger.kernel.org>; Sat, 20 Sep 2025 10:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758388353; x=1758993153; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gj1Ep/MJST8CACxWAubynz7i+zMqcF8h49oVjFnLgOM=;
        b=3IVZQezjkGRGY6jnZJUt2i+7WB3R0jDFvJ7S3CpqjSTX0Go0KM4dgBQaC5qeaLM7SZ
         MZBOmRWse7OxHunxwEPMleKziE8OpjqcsTBIFIxckSMSeiGfl8VsnlNDRedpN4cWYrcM
         63JobxUMPd9Ef2Fl/w8VvBA+lm3xJVXO9cueYXQLd9IEFQ6K/HM6axlSV5PG3+/7zabB
         lHRSh2NHXozM1z4/MIpktKncf6rHZ8cHoZT2+HSXtMLajrVoOvztL1PBd51XkXNQs6EP
         46qB+neSN+QgJ07PjdIAEdajmKfXNbjW4FNJT5ulbl+YMeoogNGxYcy/T1WSFKEGZsq1
         tLxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758388353; x=1758993153;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gj1Ep/MJST8CACxWAubynz7i+zMqcF8h49oVjFnLgOM=;
        b=QHQZDKjKRMPvXA/tdFLvRrkQAjsVOq3/Dzdf4JjHEDByN37TyagPYiYOGr/+O5zgM+
         F4Pi4N9zlUvImW8DfhVgTXsICjxOEtVwbWHFV23Etn10/2rmliYUzUM/QEvpNvJ3M2WM
         nPbDF7T2N+2YzVcqEmKyg/qhQNJu8gqblVNCp3UHV+q4F0wcurtdo6+L3nEito4fk/0H
         SecACBzSBRqhQeYmkaMAvPQCPI136Nif/jFe37LBzDjShkRxM4HVHP+yVjgfHclkinYh
         aIIQ/QAoD8vK14wa6QK+sCwAnWir4NiJ136AQ5lXZZB3TiMe9WnQx5NENCrtq0O1ga6w
         tlWg==
X-Forwarded-Encrypted: i=1; AJvYcCUaWwKqmCklK3F/87hFN7uBiDQmUlFfMZpXLsS6IMc5rioDKvnmzHzqn2Z8EtS2q8swDo38mVAkhQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxJhRtGEvLgKOMVcpXfqDctfKQZdYalFTz7uHbyDsVD/yQwQYDM
	0bAjx2mOFjUCM9aIVqyGHeguMpG9QNvTc7VLX+BO9BPm5yQGH5c5p7xMmxG9e6DgG5PENQYFQOa
	bKLIr2i7kkIqhQ/2a0DN/XgdwHcFcm6M04JrgSM5u
X-Gm-Gg: ASbGnct5nJN4t9zS7vfpZaunvBudIrQq5jQ8B4OBy/E8glOfGbyj+RdvBNOtK8Y1c1N
	hfZYAYGuE9cUEocfZosY06hfQoXi4rcpmkv2W1iQFvkHuk6jaxk6vHd210cPieAASdq1fM4xZyz
	/m51DjB88Vg/0yor/Pk1wUXabRattx2wXZ5cam2GFYDnYZX4cayG0EmKj+2k2yqa0RGKV98LWkC
	zuihhc=
X-Google-Smtp-Source: AGHT+IF+4bGibPipIgcJxYKVfn8BssHq8357Z0KdCsFz2M+fcQoYEotuvWkwJadILn9AOtmYWB0Q/o9Ht+aVSBuXwCM=
X-Received: by 2002:a05:6000:2c03:b0:3ee:2ae2:3f35 with SMTP id
 ffacd0b85a97d-3ee7bad118cmr5460258f8f.6.1758388352843; Sat, 20 Sep 2025
 10:12:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910-clk-type-state-v2-0-1b97c11bb631@collabora.com>
 <20250910-clk-type-state-v2-1-1b97c11bb631@collabora.com> <aMG6JVMcMxVuX7De@tardis-2.local>
 <3D936C1B-FBA9-4964-859C-84BB665BBE3B@collabora.com> <175834480479.4354.6269916774389395049@lazor>
In-Reply-To: <175834480479.4354.6269916774389395049@lazor>
From: Alice Ryhl <aliceryhl@google.com>
Date: Sat, 20 Sep 2025 19:12:17 +0200
X-Gm-Features: AS18NWDvOSD7Ew9WoF-qENluBOtHGPEWpUP8mLuio2luAr2ur7aLvfUzGRJxJH0
Message-ID: <CAH5fLgib2a7UK0cYqy1cM6h_OZDMWf+JX+KpXXCJNTZchyfP5A@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] rust: clk: implement Send and Sync
To: Stephen Boyd <sboyd@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Michael Turquette <mturquette@baylibre.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, linux-clk@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 20, 2025 at 7:06=E2=80=AFAM Stephen Boyd <sboyd@kernel.org> wro=
te:
>
> Quoting Daniel Almeida (2025-09-10 11:47:30)
> > Hi Boqun,
> >
> > > On 10 Sep 2025, at 14:49, Boqun Feng <boqun.feng@gmail.com> wrote:
> > >
> > > On Wed, Sep 10, 2025 at 02:28:27PM -0300, Daniel Almeida wrote:
> > >> From: Alice Ryhl <aliceryhl@google.com>
> > >>
> > >> These traits are required for drivers to embed the Clk type in their=
 own
> > >> data structures because driver data structures are usually required =
to
> > >> be Send. See e.g. [1] for the kind of workaround that drivers curren=
tly
> > >> need due to lacking this annotation.
> > >>
> > >> Link: https://lore.kernel.org/rust-for-linux/20250812-tyr-v2-1-9e0f3=
dc9da95@collabora.com/ [1]
> > >> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
> > >> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> > >> Reviewed-by: Danilo Krummrich <dakr@kernel.org>
> > >> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> > >> Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
> > >
> > > This tag list looks a bit weird to me. Why is there a SoB from you
> > > before Alice's SoB? At least for the usage I'm familiar with, outside
> > > the case of Co-developed-bys, multiple SoBs is used for recording how
> > > the patches are routed. For example, if I have a patch that has my So=
B
> > > and I send it to you, you queue in your tree and then send out to oth=
er
> > > maintainers for merging, in general you would put your SoB after mine=
 in
> > > that case. But I don't think that's case here? Alice's patch has only
> > > her SoB:
> > >
> > > https://lore.kernel.org/rust-for-linux/20250904-clk-send-sync-v1-1-48=
d023320eb8@google.com/
> > >
> > > What's the intention of the SoB tag here?
> > >
> > > Otherwise the patch looks good to me. If we get the tag list resolved=
,
> > > feel free to add:
> > >
> > > Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
> > >
> > > Regards,
> > > Boqun
> > >
> >
> > You have to include your SOB when submitting patches from others.
> >
> > This is something I tend to forget often, so I made sure it was there. =
The
> > order may be indeed off though.
>
> Yes the order is wrong. The first SoB should be the commit author.

One optoin is to just land the original patch:
https://lore.kernel.org/all/20250904-clk-send-sync-v1-1-48d023320eb8@google=
.com/

Alice

