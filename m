Return-Path: <linux-pm+bounces-42951-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AB9QGFSfmGnJKAMAu9opvQ
	(envelope-from <linux-pm+bounces-42951-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 20 Feb 2026 18:52:20 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C8ADF169E2F
	for <lists+linux-pm@lfdr.de>; Fri, 20 Feb 2026 18:52:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 676EB3025669
	for <lists+linux-pm@lfdr.de>; Fri, 20 Feb 2026 17:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F423366542;
	Fri, 20 Feb 2026 17:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XkXXRdn3"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7D0366070
	for <linux-pm@vger.kernel.org>; Fri, 20 Feb 2026 17:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771609885; cv=none; b=l3IhFTRgfEV1p2aIkZxI2QGleOCrXMMuurjGGpB+bEgEGP4XKki+RpEgDi+ATmNKNBgJvBvphyLHUsF4Fykl5U3ZnHGIrZO3wUd84wiHckw3SVozQasoaLIaTpH3ShOOEFUtIo2c6FAW2Rc6UU/ANJrs35vL4GFCj3JovGkhhVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771609885; c=relaxed/simple;
	bh=LCZsbY0WlkLDQaB+g3+Nolk280ujbFsPA+yQ4pCMsbQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IK4CHc8jTrdA0vNk1U+z8mTo1llHrlr9MAoEJRaZjZSQBWRvophltFqV0Dbd1Bb9IrcD25umlySXrBtN4z331oUcw0GZ0wcQ6XWl8MYagJHj2vQ1mJ9XUYEEX0fejD4PtAdK3cMO2hyqIyqCSIoDlDj2CA/KLG0HP1KVBSIyKpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XkXXRdn3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E19F6C2BC87
	for <linux-pm@vger.kernel.org>; Fri, 20 Feb 2026 17:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771609884;
	bh=LCZsbY0WlkLDQaB+g3+Nolk280ujbFsPA+yQ4pCMsbQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XkXXRdn3F6OLSGvMtoYhWea3hwd7rj5rpPY1A0NzIFJ46pP+XBJ+Wmx2xxNeH2r5R
	 riw7uuD3bICVYvFIlvFq7fNsUyepUVK2MDRofNPl5YJjj4Om4kLbNc58JEHkbq2krs
	 qtKwUi6siUfzvgnuw4ZpRDlPweBfJwcWaUEyz/pqiWA3L89qqfhbEp/n66PfDh9kKB
	 j+VaAZNnLReB60nfZ0zJ2LOkKqaUq2QapC68G0xW4ueYzSjEJX/l4Xk/Pu31c0iEWf
	 mzmMewilVRHoJfNkcj9Q/ucVcVCEf1BQS6ME2Q+YSJqnSL++oEhOnSrUAuNgpGrBNC
	 eOaxrD4f35RzQ==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-38706f96202so14999831fa.3
        for <linux-pm@vger.kernel.org>; Fri, 20 Feb 2026 09:51:24 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX8Mm+E9mV96ZWOOXHkxWPJ0ast9Kpaqg2rqbO6UKkFu0hh4ZEdt5ip46UkaJOrjCsNfkaWlUL1Rg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxCasss42bNAL/IHD64c8jB9qyEH8PV4qZ+gSi9n/9pqcIl2rSt
	tqzw3Q/0mUhcGPJxbElEzdjojZ3faqMqtqrPkXmQwLlmLvbSblNkbb1ny57zf5Ry6cbMzzA5D0E
	9FdxSiiW0UTKD7vLXUuIeWI6QKKhG2+0=
X-Received: by 2002:a2e:be1a:0:b0:383:24fe:4eaf with SMTP id
 38308e7fff4ca-389a5de4d48mr1328121fa.30.1771609883065; Fri, 20 Feb 2026
 09:51:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260220-unique-ref-v15-0-893ed86b06cc@kernel.org>
 <20260220-unique-ref-v15-9-893ed86b06cc@kernel.org> <CANiq72myc+tCEHm0WtZspZHWwsSzvesxsmUvk31=GCdUN_zVNA@mail.gmail.com>
In-Reply-To: <CANiq72myc+tCEHm0WtZspZHWwsSzvesxsmUvk31=GCdUN_zVNA@mail.gmail.com>
From: Tamir Duberstein <tamird@kernel.org>
Date: Fri, 20 Feb 2026 12:50:46 -0500
X-Gmail-Original-Message-ID: <CAJ-ks9n2N5fCVdEF-jLsjLhAiyY7HLHA1dbanmxqEj1vuqfuKw@mail.gmail.com>
X-Gm-Features: AaiRm50BHJk8sWqZZGVukWMOtaBDUYkSm_Z-CQij1pvKGbmHOip5UB_YSDsNkM0
Message-ID: <CAJ-ks9n2N5fCVdEF-jLsjLhAiyY7HLHA1dbanmxqEj1vuqfuKw@mail.gmail.com>
Subject: Re: [PATCH v15 9/9] rust: page: add `from_raw()`
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, Benno Lossin <lossin@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
	Leon Romanovsky <leon@kernel.org>, Paul Moore <paul@paul-moore.com>, Serge Hallyn <sergeh@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Igor Korotin <igor.korotin.linux@gmail.com>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
	Stephen Boyd <sboyd@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-security-module@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-pm@vger.kernel.org, 
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42951-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,garyguo.net,protonmail.com,google.com,umich.edu,linuxfoundation.org,intel.com,paul-moore.com,gmail.com,ffwll.ch,zeniv.linux.org.uk,suse.cz,collabora.com,oracle.com,ti.com,vger.kernel.org,lists.freedesktop.org,kvack.org];
	RCPT_COUNT_TWELVE(0.00)[40];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tamird@kernel.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid,rust-lang.org:url]
X-Rspamd-Queue-Id: C8ADF169E2F
X-Rspamd-Action: no action

On Fri, Feb 20, 2026 at 12:34=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Fri, Feb 20, 2026 at 10:52=E2=80=AFAM Andreas Hindborg <a.hindborg@ker=
nel.org> wrote:
> >
> > +    /// Create a `&Page` from a raw `struct page` pointer
>
> Please end sentences with a period.
>
> > +        // SAFETY: By function safety requirements, ptr is not null an=
d is
>
> Please use Markdown in comments: `ptr`.
>
> > +    /// `ptr` must be valid for use as a reference for the duration of=
 `'a`.
>
> Since we will likely try to starting introducing at least a subset of
> the Safety Standard soon, we should try to use standard terms.
>
> So I think this "valid for use as a reference" is not an established
> one, no? Isn't "convertible to a shared reference" the official term?
>
>   https://doc.rust-lang.org/std/ptr/index.html#pointer-to-reference-conve=
rsion
>
> In fact, I see `as_ref_unchecked()` and `as_mut_unchecked()` just got
> stabilized for 1.95.0, so we should probably starting using those were
> applicable as we bump the minimum, but we should probably use already
> a similar wording as the standard library for the safety section and
> the comment:
>
>   "`ptr` must be [convertible to a reference](...)."
>
> where the term is a link to that section. Cc'ing Benno.
>
> I have created a (future) issue for that:
>
>   https://github.com/Rust-for-Linux/linux/issues/1225
>
> Cc'ing Tamir since this is close to the cast work, so it may interest
> him as well.

Thanks Miguel -- FWIW there's no current cast work on my plate, I
believe everything was merged except for provenance which was a bit
too hard to work with given MSRV.

