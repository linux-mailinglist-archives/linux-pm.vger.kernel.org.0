Return-Path: <linux-pm+bounces-37124-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B97BC21529
	for <lists+linux-pm@lfdr.de>; Thu, 30 Oct 2025 17:56:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F1FC5627B2
	for <lists+linux-pm@lfdr.de>; Thu, 30 Oct 2025 16:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C982741AC;
	Thu, 30 Oct 2025 16:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QlMB7Dxw"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8782E0B44
	for <linux-pm@vger.kernel.org>; Thu, 30 Oct 2025 16:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761843019; cv=none; b=i+WrwO121R6YlcSFPyP3qmAETEQEFO/tA4zf8l+MjoPnHoceOEKxns/wfnV3sHpUEvZdQEhflctatcIliEisQULaxoVotyJOHx3IpEinaD9JQY7fJHsFJey8RhJexm+kcoaITIeu0TksPWtLeRx15BeQs2lNgmfD2iPqnv8rtSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761843019; c=relaxed/simple;
	bh=VVy8tbUD3Ds1T7QsmSlLfYhJ41rXLA290c2MjqkFJVg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OkK9bBZIfws9okvRrc5KulOB0rXMEA7EW3qBeh2uZEwpZSs/7ra/MDdDOHeFb/oFeWh/UjCHK4oihE29zDHLF05AsMUBlQpuGB4IwgnkTEpQ9miesFwRgsI+Gao23QkX0decip4gfNhWGthDWSbMYrz8dsGAw5Hb16w97eBvfk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QlMB7Dxw; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-26987b80720so1710075ad.2
        for <linux-pm@vger.kernel.org>; Thu, 30 Oct 2025 09:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761843017; x=1762447817; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VVy8tbUD3Ds1T7QsmSlLfYhJ41rXLA290c2MjqkFJVg=;
        b=QlMB7Dxw+aVrAdbSUWU0bipn23Xfve7pppXiQG79QFpCrpXyoMO8KZBNoq7a1rtmbS
         4gxFGT15a65Fa8TM8upk3VOQqJZ5+VbO7fjKGR8abQX3rkTCSXPaP1yOnflhCMKpEgcO
         +3cy3G2+WLq6HNbhVZHDlbKmvgZoXkttFBiI1iBPqSF4RVCgoFK3Svji5aq7nLJBixog
         Qg6bDb6tpIU7GTKMq+Y0EHmyfgfwhq3mzPbmmjNlXw23muzhxx7hGoalRFR2UQShT5oY
         DTuB+/obSiIxwhudLi7GcUKBacHSmw/s5yKkiN+NVzuBoBzVyDMFb6ZQSdxvPFOE3n5C
         AreA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761843017; x=1762447817;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VVy8tbUD3Ds1T7QsmSlLfYhJ41rXLA290c2MjqkFJVg=;
        b=HFfC4BOpbSW/sipf9IObnbzx8qsuJk5bqB3m9cUESIhzN77qFN1M8jcIBcXQHSJogN
         dpFgcYPfqs8PY+EmvCqlMqtGac1UdcIl3eVaf8Xw0UVCRIEKd5Tk5au4Aiacr82R613U
         xp0agOMB6waL85K4S7XnvUEXPgrgQlhAEiD7UQP2BWTIOjpYWaJQ6i0Pu0fJ1/vSDCIZ
         aeaWc20wFCkq784lFSPCs/S6ypx6Ht1KQY78kPKcfQyv4wQfc1OuZA0CyU4LSnP3wYIf
         SWRU3CUFLch290KS8hCqjishW8EOjQEpEiyl2xoDrU1nbhxMzFAfyEC5NEHru7/t1EZb
         avrw==
X-Forwarded-Encrypted: i=1; AJvYcCU0rsuahWpUnsjg6J9jpRFI/+o7U7VURnFUaDI/HUbuHaW5EPYuHJustCJm2NSg3ZAQxoj0dqg+cw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0PGaRL1yLnBwuQrk7BP76N12Hz1lyA9hWK3esLFfTdA5uY7pR
	YV0HET1aUL9Q9w55clxk+PJMN7RRba8E2ZWahO5YKWAStucVoKW9wS2pfsK8wJqRQ5IKYchuK7K
	wolt99mD4s2jeZ7J1xcKoGTIfaXhXLj8=
X-Gm-Gg: ASbGncsRlnF0hbyrIZKG8JnHcFQkVqm9yZagDfwvhsXr3/XUMugLjkoDJq1q7JK2QIY
	xVHMD3THM/OJ+D2oAPjNgKpfGjnJxQXo9PWA+eOQixxD7I0tzLsKcXouhvYcs2yPNmkagKBy+SG
	OvOuianExHp+3G/MEMXPJO/Th1A73VEIvo1sup96m3aYk/riwbY07GQsLaiGjhgaLz8VjORCygH
	GpYCWgXimWYVLeDX/D91DAsuOg7A/NvPAElXIJUHRH+9hSv6i2tj1TInASj+wzTGUQ2FXsmUEIV
	JJTflubzjAIUC6ooeupzU1YebB82RiG3DEOzxrABJkVH7+Bb5HP4lvC8TKzn93Vbg8EsBlPian1
	nxOI=
X-Google-Smtp-Source: AGHT+IHIwOHRSXqelvV1Sdf63ytImuxsi6mN867ttFRk6bB9U4Bt6FvCqQWaRN3cWMuEbnRRwlVbLx8M4DZOhZxBczg=
X-Received: by 2002:a17:903:234e:b0:294:b58e:6580 with SMTP id
 d9443c01a7336-2951a545f7fmr2497775ad.10.1761843017022; Thu, 30 Oct 2025
 09:50:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251001-unique-ref-v12-0-fa5c31f0c0c4@pm.me> <20251001-unique-ref-v12-2-fa5c31f0c0c4@pm.me>
 <87sef08mjk.fsf@t14s.mail-host-address-is-not-set>
In-Reply-To: <87sef08mjk.fsf@t14s.mail-host-address-is-not-set>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 30 Oct 2025 17:50:04 +0100
X-Gm-Features: AWmQ_bkaCQLlBdplFGaXs_s6rBEi5hnyY5mzRPNbjRg2sfBfQKwQOTLK3O0jQnQ
Message-ID: <CANiq72kuRNvovHK5r24kh23mo5wp2bpx-EjGMOyNBOF1YzukvA@mail.gmail.com>
Subject: Re: [PATCH v12 2/4] `AlwaysRefCounted` is renamed to `RefCounted`.
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Oliver Mangold <oliver.mangold@pm.me>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Benno Lossin <lossin@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dave Ertman <david.m.ertman@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, Leon Romanovsky <leon@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Asahi Lina <lina+kernel@asahilina.net>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-pm@vger.kernel.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 3:57=E2=80=AFPM Andreas Hindborg <a.hindborg@kernel=
.org> wrote:
>
> Since this patch touches so many moving parts of the rust tree, it is
> going to be a cat and mouse game regarding rebasing this thing. It also
> touches a lot if peoples code. I am not sure how something like this
> would merge. Do we need ACK from everyone @Miguel?

Yeah, any rename (or generally namespace/path change) is always
painful due to the flag day change, and thus ideally best avoided if
there is a practical way to do so (e.g. keeping the old name for a
while).

And, yeah, treewide changes generally need Acked-by's from the
relevant maintainers.

Cheers,
Miguel

