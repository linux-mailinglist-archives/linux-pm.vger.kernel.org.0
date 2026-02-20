Return-Path: <linux-pm+bounces-42929-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YPK1LuM8mGkWDwMAu9opvQ
	(envelope-from <linux-pm+bounces-42929-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 20 Feb 2026 11:52:19 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 16DF916709D
	for <lists+linux-pm@lfdr.de>; Fri, 20 Feb 2026 11:52:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E1EB830965B0
	for <lists+linux-pm@lfdr.de>; Fri, 20 Feb 2026 10:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC28233F8BA;
	Fri, 20 Feb 2026 10:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JABONran"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F6033DED5
	for <linux-pm@vger.kernel.org>; Fri, 20 Feb 2026 10:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771584562; cv=pass; b=r2MXfKwLuw/FKNlu3TTiHUNZ1mRlTmPGIfAS8NBaRFg2AOMODqxjJ7obik/QrUBnT5bl9knpmsE9F1RHeUhghiSsTQiA7QCbttxS7ZtAEEk3/OobpUWVBHV4QrvI0EMPxorFoYKeZA17D79eNCFGuVN8iRlqwPOMuevNIRwYNnM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771584562; c=relaxed/simple;
	bh=aOLVDIR4WnlUw1nvqXwQwf234Bh2W6bojDklxd8Gees=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oas8Ys6l5wIEMMj34hJarg2sOi5hRvRth33yvAGbDyBPiEMPh+qJfQ8qFdWpfkygrXjHhIsa8gC/nH6MYZ30ooBnBamQ1P2G9aAlCMjKvP9hVmWl/DN3KGsO9gMJbXowbjjZiK4OEnLH4s1pSkCyYnzZqoYF3FRZSZcjdweh3Tc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JABONran; arc=pass smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-483a233819aso14970845e9.3
        for <linux-pm@vger.kernel.org>; Fri, 20 Feb 2026 02:49:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771584558; cv=none;
        d=google.com; s=arc-20240605;
        b=MIyucy1K/wDPCQUrBUIJEuIQwpD4+wQdsml9bYyMJgrwaPa8+ydKzArPSIKthrFC5m
         2qGbPpFaNtHNQuJWNjVlMwUQGCO0sWwfjVOSDZQJpKEpSHyabSZ1wwL1KexhhPnZ9VSM
         daCfWmSSWmkkxGO2chuuKldjU5UfthrrseNGkn8Sl+uUMwjAM4ChZxAU1KGTdiIVSBMz
         Le1pssXPkmi0OLy5vXTSP1sSGHMaBRxhR2pmkYjan+adzJGQdBmLbsGxRoDVAGXytPMA
         39CsJkwpsJUa4u48Dgb+pQci8V3MRFCfawqOCLbI7sabeSU5upRK0ehL2M10Td68whkI
         y4XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ab0aEJOyc1j8sAVck7x1NuXrJJFBzT+zHKOVXAo2rqQ=;
        fh=K0yYtDKn1h6vZ2AcMQdgqvck6cUymTssPBY3I+oeD+s=;
        b=cwMH5dbTiZnMSujulBdYXk0UcXJcWzqivoVAeRsCO2VaXXa2EtoN9D4/BhIQ9u2d95
         InYjE86wDsB0hN3c5r3RD/nTszdaXWKxbQNMqZJb5fQXROm6nVRoSFeA9y6fUot8dEJv
         NFAkliz94j1rMHlZNcFn9+cjBDZG8FMpxg0uCSGdowhibB6FW6WyhevbW6A71YZQ3JJf
         z8dIfqw28Vg/89YoRwA6X+cnG++jYo4QGHrdRL0MBhAqJjtD0sVwDG09fOyVz9vv1h/k
         vlepLOqCKPuqB/AeGfEGc7v5xXnNU2y0zKPnAHb+qnNaUeLepV5Y/pS2yIUYvXBD4QQv
         LPBw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771584558; x=1772189358; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ab0aEJOyc1j8sAVck7x1NuXrJJFBzT+zHKOVXAo2rqQ=;
        b=JABONranC/t/ZRWaTeXGCdbAg3MlyNGEm32nb8g+0L+PjkN0k7v4kud2f/Lc8HtI9p
         RSJ70uRPi9eRvWSiQdR4rSEaIEyNlubpm35GfQ3YOcWC3G9WcVSK61xAwUJAmv+fEQjH
         U0VDLzRhvDs3mprDIFVy3TKWENLnYZA8lvak3zCs19Vc7dc+4ymdsOOcoNXANG+9O4wA
         yAElmODqtzgqw7FDaasHWfeg3jDiHmL7dRWAknBHeykcq12ka7XVCsyOk7kCewg+AQ13
         iGKyafSskeM/uBbKXgMnW0Dq60qRd6tC6hK6mVrNBSjRBZQXO7HJmMLT1etJbZnXuKpV
         q+4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771584558; x=1772189358;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ab0aEJOyc1j8sAVck7x1NuXrJJFBzT+zHKOVXAo2rqQ=;
        b=rXJZPGNyCMw3s8w9XZUzsLvpTg+bJyE2+GrdbWfBKZ92TCXHbiIXoXCYd4Ville68A
         Dp/b3ifZny9ZZZuIZ7brQ3jpv/XaNGGIkXustOx2jkYljh1Sl9RoUf0Qj+EWEEBvSr/z
         hBN9I7qn3U1y/ZiK3MAb/rgA2NxtihzuZ85ecGo0Rc1j8H//PDQpRzrNTynk2cwPBESE
         SVHLEOStZ0QW1jQjKGUWGnYbltXT2zltgrJrTTHqmJmHApnnpdwhaDVojAjvkRp6ZivT
         8Sm2uGHyexcOEbtEJFvVBhpb5KUa9XOBY77k4TB6xDItGH6yd8BsMFbYp8yfJNgLYwbp
         GnwQ==
X-Forwarded-Encrypted: i=1; AJvYcCXka322IKEbWdV6UDznansi/uvc6ZnhmRmTKfdpKtxunGwDuktLA1YamwLYm+SfRuO/ZGBGKyhGqQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyYX87Of253MKHGHIk040IGJJtVHo9ddhr2CNNjYIaKvsjhVCeD
	cTbcnwDjlyOY2rql3nOUFsIL7TeKbh703AG/TUKGND37sX70/FPUL7CK8E+AlINF5gnKa1+m+l3
	aVT4vKnU4a98lfYmXJ67ewczX8tSwLKMnzl2NFfPh
X-Gm-Gg: AZuq6aIBwNpqdxTLMnEAv7Ds0HbEGJw7ai0lOdVVXBL2DZD+WFl107gsOy5M008SKG8
	a62YFyscaqmzElLJR5JVQoJsqClH6OQ2XmLysJYRurr7LWtrI9Em+/WR3OjDwVabQ1OMcoGcZST
	9Dv9HVsBqq6xW7JEjs07hRpdaA4Srd8xyeunoMI30c3P8FFUI128Ow/W5tnBYEizUq0FecA/FMB
	5vF2DUJb44dYJLXkm/wfVYPcsKn16+cLUd6sIovFfXiWd0fYv4VJECB8fkoiBhTKOs11LE/zfjq
	2szW0eR82bX9nSMkKIC9XqNIdPaqhP0yVC6etw==
X-Received: by 2002:a05:600c:5289:b0:483:71f7:2782 with SMTP id
 5b1f17b1804b1-48398b0990dmr130223325e9.12.1771584557648; Fri, 20 Feb 2026
 02:49:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260220-unique-ref-v15-0-893ed86b06cc@kernel.org> <20260220-unique-ref-v15-9-893ed86b06cc@kernel.org>
In-Reply-To: <20260220-unique-ref-v15-9-893ed86b06cc@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 20 Feb 2026 11:49:06 +0100
X-Gm-Features: AaiRm51MAhLW1OtRkAHOYwRwshfGarw67yqaE2vYRvgLvB2RCqsl8u_ReojFPGo
Message-ID: <CAH5fLggNQD+TbA7rXVB5w+O+qHcJcYC4u0b3W+mHR2DZiUe4eQ@mail.gmail.com>
Subject: Re: [PATCH v15 9/9] rust: page: add `from_raw()`
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42929-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[38];
	FREEMAIL_CC(0.00)[kernel.org,garyguo.net,protonmail.com,umich.edu,linuxfoundation.org,intel.com,paul-moore.com,gmail.com,ffwll.ch,zeniv.linux.org.uk,suse.cz,collabora.com,oracle.com,ti.com,google.com,vger.kernel.org,lists.freedesktop.org,kvack.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aliceryhl@google.com,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pm];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,samsung.com:email]
X-Rspamd-Queue-Id: 16DF916709D
X-Rspamd-Action: no action

On Fri, Feb 20, 2026 at 10:52=E2=80=AFAM Andreas Hindborg <a.hindborg@kerne=
l.org> wrote:
>
> Add a method to `Page` that allows construction of an instance from `stru=
ct
> page` pointer.
>
> Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
> ---
>  rust/kernel/page.rs | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/rust/kernel/page.rs b/rust/kernel/page.rs
> index 4591b7b01c3d2..803f3e3d76b22 100644
> --- a/rust/kernel/page.rs
> +++ b/rust/kernel/page.rs
> @@ -191,6 +191,17 @@ pub fn nid(&self) -> i32 {
>          unsafe { bindings::page_to_nid(self.as_ptr()) }
>      }
>
> +    /// Create a `&Page` from a raw `struct page` pointer
> +    ///
> +    /// # Safety
> +    ///
> +    /// `ptr` must be valid for use as a reference for the duration of `=
'a`.
> +    pub unsafe fn from_raw<'a>(ptr: *const bindings::page) -> &'a Self {
> +        // SAFETY: By function safety requirements, ptr is not null and =
is
> +        // valid for use as a reference.
> +        unsafe { &*Opaque::cast_from(ptr).cast::<Self>() }

If you're going to do a pointer cast, then keep it simple and just do
&*ptr.cast().

Alice

