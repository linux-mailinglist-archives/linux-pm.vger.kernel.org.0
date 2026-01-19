Return-Path: <linux-pm+bounces-41124-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A334DD3AF6F
	for <lists+linux-pm@lfdr.de>; Mon, 19 Jan 2026 16:46:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6A86230019F6
	for <lists+linux-pm@lfdr.de>; Mon, 19 Jan 2026 15:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 477CD3806C5;
	Mon, 19 Jan 2026 15:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GXXSCU3C"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A06329C79
	for <linux-pm@vger.kernel.org>; Mon, 19 Jan 2026 15:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768837578; cv=pass; b=TBQeLNnZJNUhBatGCfvTO07aKU2gXxPTGh9v9+TJQtwCtyPpxfL5oEFxwwhCx3I+3k18ZILV0rrEWhxVD85sqBlJxKnqqAkiT1jXK2Qn+xsCCwcJyspbjw/rzCVkzYH6blc/+4ukCfw6pYjS8OrQ9bbRFwAxgELoSUEX302I4ME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768837578; c=relaxed/simple;
	bh=46u/WokqzTLpaWP1GT0SroKxBKxCn8SDXm21fmrsTi0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ooFQGaEUQZk2GMyYg9nHfnav78koOWnf+NXjGT6N2Vx01leSzr0liQtdcd5vS2SFYLHEQc3eClC9u9iSVxgydIxRlwh/xVJKkH1sbfqSUz1UJYzAeATZw0RQhBZqBb7DodAkzqemfMqLrZDA4dJIb50fOUrsnnB8w9NVaRGg3sk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GXXSCU3C; arc=pass smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1232c98f98cso314984c88.3
        for <linux-pm@vger.kernel.org>; Mon, 19 Jan 2026 07:46:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768837576; cv=none;
        d=google.com; s=arc-20240605;
        b=fi/M15NWZdVUNzlt/Ib9KwKRQt8BPPUFbzWUeEmi47U+B6kCwDir8qOCoArZwvL+0n
         B3nII5XagaZFH9RF4jAiVu+IZMATo98aP337edDEMx4qm72s8Zrk5U4dBQHoK6O5jwUW
         Z+TyYkqbJClOCTX42I9zJ0isgril/yIP05us1y/xsdsmFmfosXFQywtdgr6bF232Zp/8
         /0tI3O3/t6sCTXURVADMFUsklPQyk2URbJdMI+AmH9J+ug6g+blogKwJ6gtXWT84szre
         Afzn2MzeBDT6Yz86zgY75i/3/m1dCm3st8xHdnMF0dVXz8uXQAX5bJlfbjE96vKMe9p1
         8SVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=46u/WokqzTLpaWP1GT0SroKxBKxCn8SDXm21fmrsTi0=;
        fh=++wmROrF3OpUr755o5z6xKofkOuBsxksFc6Os+PXEbM=;
        b=HEsxdl6/rUfqZyEynsJQy5Kb9XohBPDEoK1sSeYqRwDVMtJ4k/DCZQ9w+fGgBDd65T
         X5jDyEMkCX3X4cKIG7eq861URO0JUL05JmHHfaJhEI+Zu70a1d1IELjRbs4bQIZAH2P/
         ZZ0Byqm8UZhbstmkZDnzZMF4NmLPPJ7YSVmUIJvC5n5PdaAXm+AQJInRSR2f2xoVI9xP
         GhPyQn7wEw1crStC85NvaMNFnijy13pn0v3oJe3KS7lyCSna+aDyzbBIMn5YWbUkfHp5
         iRmilG8JzVbRhJkvPCrg9oNULAXvtCSD9JLCD1STMvx1d/fmDKSnWBarlhL6svU15dZF
         fRbg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768837576; x=1769442376; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=46u/WokqzTLpaWP1GT0SroKxBKxCn8SDXm21fmrsTi0=;
        b=GXXSCU3CdBM8c+MgPSzgQooJIutWbrMebgtv0WvYE3ZbubHbcip+IwHvDJ9eq+wc2B
         Mka8HrKybre44Z5qJ81M4hwIGKs8x2I+658pDDoSYO5lAXNfuDFahjA5+wuKVOy1uqD5
         +QtGt8P8oTZgfrEpER3ICDP4awqpYwtUy0Cdfkkc5jUGjG5KLHrhtMt86+UkUrx9mL8+
         WKjjF0LOngCoioejgRfEY2bol8HvX5QXUMzXuFzgemphATe8K5EXp3BKdfXwsRtH7l3i
         hYQpfsAggJbzU9tB4Vr9HxzGWJfrreJyN649wORSxiagGFl1ze2jhWOJH0cugSxtW5nI
         PRbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768837576; x=1769442376;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=46u/WokqzTLpaWP1GT0SroKxBKxCn8SDXm21fmrsTi0=;
        b=JoF8yFjwScasfasMnGLCllLFo2ySyEputfeH+a/4aKi8H5DACCpTK7shwl1+5bLH/z
         zucrhA/u6922+SMvXHuxDByC4Z/V++f5EFZ/9D96dvAuiI36C06YMG8t6nmJ3vdGjmzH
         BAEHqAdtmagPdg9GlsGa0ELUIFUFgRUapkIDXwecWO6rN0AjFylsf1vLtRv3yo6Q56am
         CHyOFed10U8xCr+yEaEo1LY+X3cz+olsZYyRrXhCXNTP38afjiQfVf4/azjB9JnOg2zq
         vbMSu4LNeC/dz8mH60/S6MeWRSs3ozLNMbrygGtL+uegHUNb6rSXv3yDP2q8AsNq8bcb
         daog==
X-Forwarded-Encrypted: i=1; AJvYcCVO8s8Znu04QVQjxF72aCfcd6f9R1mLTFOhX+p5jW4+8X105jnFhwTNuuwDm8cyOpCNnQbprTPjRQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp/XfOLlSwXJCBMJFE2LnRn67OC+NK8B6d54eVldspN1FHMuqS
	7EzHQjQ5gaqYiqbdWxTppAzCP64HyEu6iqTRolB15B+bcE7Xw+zWET85vHjn2VpEOTJ5m6/u3hc
	LolWvKfILEynAj98kvCgHLyrwcCoIhY4=
X-Gm-Gg: AZuq6aIx8z+XYa05FyNIL9hZ8mdNgBkzYqIQfC0hMWUfyhibugJoS0IHOlfzev1mwQI
	GtkUxhoJJjk3qVE8kKTmeSyLHNb6GaohK3EXV2MmuEDiZYMXFFn+jTEyr5p4K0kZqHX8plPdl17
	xJOabtVNSsuG7vphygIsvTn6X1gaL2yxCYtrzltyxDDDHXg0VHMarHqDAn7uAhpWUAIfwJ/Ec3q
	H3al18IDsfBxyNfB6Atz6h2N7uueyktYO8M23ESbdQYrQ4rec3VqiohquNG7akE8IOTjgLfjOvL
	A/5oMxtYhL/if7PFdJP7MbNfU4YcsdY4EKDuFiQx3lgzyd0WRkt5ce69FxHDvl/ypnNQ7W7Ku2R
	dPdbhGx2fPFENhgFIDEDJc9s=
X-Received: by 2002:a05:7301:3f13:b0:2ab:ca55:8940 with SMTP id
 5a478bee46e88-2b6b40fc353mr4845380eec.7.1768837574267; Mon, 19 Jan 2026
 07:46:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260107-clk-type-state-v3-0-77d3e3ee59c2@collabora.com>
 <20260107-clk-type-state-v3-1-77d3e3ee59c2@collabora.com> <DFSMRQFIYQPO.1A38Y84XZ1GZO@garyguo.net>
 <CANiq72kcRQShDgMJKZ+ekUEdP1T6Jr=4PDiMJCqnQjgCQEK_eA@mail.gmail.com> <DFSODY3NWRBQ.2VGQWXERVW1R1@garyguo.net>
In-Reply-To: <DFSODY3NWRBQ.2VGQWXERVW1R1@garyguo.net>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 19 Jan 2026 16:46:01 +0100
X-Gm-Features: AZwV_QjEkXpU0cn_dPvCmG7mx9ccCkl54ToiMM9A8sew4Jw7jWCplASiAflPTPs
Message-ID: <CANiq72kCi8=mK8V282O-tsbWvLC6M2vdc50mnLW3M3pWTACyOA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] rust: clk: use the type-state pattern
To: Gary Guo <gary@garyguo.net>
Cc: Daniel Almeida <daniel.almeida@collabora.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Danilo Krummrich <dakr@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-riscv@lists.infradead.org, 
	linux-pwm@vger.kernel.org, linux-clk@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2026 at 4:36=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote:
>
> Which crate are you talking about? I can't find a linked crate in the iss=
ue.

The commit message (i.e. not the issue) has an (unused) link with the
`sealed` crate:

Link: https://crates.io/crates/sealed [1]

Cheers,
Miguel

