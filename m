Return-Path: <linux-pm+bounces-42930-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0L0DMvg8mGkWDwMAu9opvQ
	(envelope-from <linux-pm+bounces-42930-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 20 Feb 2026 11:52:40 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA161670A5
	for <lists+linux-pm@lfdr.de>; Fri, 20 Feb 2026 11:52:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 09ACD306F008
	for <lists+linux-pm@lfdr.de>; Fri, 20 Feb 2026 10:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D7C933F385;
	Fri, 20 Feb 2026 10:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WrSMJnVF"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618C82C11E4
	for <linux-pm@vger.kernel.org>; Fri, 20 Feb 2026 10:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771584613; cv=pass; b=c026fYVrLo2AVNtlFYkppQOkBYmSIrcBsZ54oEZGTwtMRA1ywD9IxisnuNe/Y1WfrgH3OoSJWium6n4LH7XdcZ+KUJkMOejCK6M87bbnVuNd6Nm82gm6lUx/Zb24h08ADBCVvSDl9GJKJWBhRm+rywRzdkorGtTXpHWm8PxfU5U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771584613; c=relaxed/simple;
	bh=oIngJ6S5SUKbvESTbw5vt2bQmTdKhr5N3+wDe58Yw5E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pWEcQhxWZDmUURa7DAR1AtVQTOo5Mq60QtuLX+3q264G/mGJZHMt++cd2tjbadBx2MXpCFMR8ukoK8TNigcOXjgVTdRFDXolegjt1VoGeMOjuFxhz+q4V6/Wj8/qpyRPhjnzVWCJZ0+DZB872/lbit1GLZHHVnMqYQJD0jB3Ekk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WrSMJnVF; arc=pass smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-43638a33157so1805132f8f.1
        for <linux-pm@vger.kernel.org>; Fri, 20 Feb 2026 02:50:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771584610; cv=none;
        d=google.com; s=arc-20240605;
        b=e8lcv9QYdVrewpc7/5xohvNDHeWHGWEnar8oHKYm0XP/MBJcc62r0gotRMp2D8UHZ3
         r7iC3mjNdqdPnBGJkAwRTiCfrqJPz6+l6fV0Ki+gyq9eIpB+o4HIT+h1xM4pb813i5OJ
         V2+aTk2Hv4XCFm0rZ4tK9DkIru4YtDAV7TQwv5zwKA6UtVIlZci3D58rQfYbxTWmrV97
         FvXvjAAnkMB0Uk6GPdj/JjUrJJ1dx7yxL1On/2vloTiCAQPJoJcQokHtvJDK4FoR3Cs3
         GWEPlTfyntkJXdeoFLVnQ2jhnD2JIWgSEWagLfk5wA+pt3MWQS7BuKEW2HHv6CHzd4QH
         5GKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UAf0+WPiEFSXz/CCPkkC3DmUlSyhmOoTBssum21ipoU=;
        fh=I7ZlH/rLUaFmrZYmJauNe1R/28CTyx7zfOXqNfJ2vgo=;
        b=ArE2rEwrfI71H9XMcLYzB+3EcsSmVNl6twqXL8UzfhzS2kse1pnqYLFVYCM/qD1WTm
         CIM0Qb2ReOdT4L4G5i2MrluiORRco3FuStaP2PS7H3sqQjQeIP/A4tf9cZ3Kvf8uuiHy
         9eK7Z/L8OEo5ckDecPXtClrU1tLjDyBtTtYknjMlUuSlfh/qWnVOG8C2SkKHovmswlNB
         I5h4oIpYCTFzlCLMDOYNM8Qfs2DFgzD+aa703YwDN5F2Zw4kpXh4dwcJG0vKYOcHGBHq
         xpn4Xyi/A7WcR1oQD+bhA+Tqv7gEgJ7ZaM4PScJGA8fUzuW7kmNRnM9YtE7WLCOu20/N
         8kHg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771584610; x=1772189410; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UAf0+WPiEFSXz/CCPkkC3DmUlSyhmOoTBssum21ipoU=;
        b=WrSMJnVF5uBG1etU8Ao1aJIH79rL4B/ID7aOQVzdXbXEAdapztjr+4Ojw8JeHNFzt2
         dlIX5bMaHjSwAwqSEjpbFcjWcCz/Ytn+K1E6hC7kI3h9qjQUDh33ZJHsKdwmHuuhVGRP
         YFF0cE/9CorGsiF8nd1xmbzJ3t3K/qoPOti9J8BMYJ/xUB/nPHYgwPenjrQey3oTVuLG
         c1sOzkT6SCPTSC1qWfTj6n+lkDppOSu17WoIm0D9qCdM74Q/2YDEWRK19PZ3iOOmz7QI
         hGSxz50RSjTI4gysJQiaeqVVYLKibaZlO+bWe1TNVaOl6HXS7zjCEKcoetqQAgYiZCyB
         y61g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771584610; x=1772189410;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UAf0+WPiEFSXz/CCPkkC3DmUlSyhmOoTBssum21ipoU=;
        b=mjVqpfJgUrdoGsXT5C+o4SVi1l2FMiIj/a2z3w+SrCUJdZTBL4YTtFVViTk+v7OQrQ
         myPp8ybpMV5VI0J6W7RCOmcATqKvB2PQlxUaS4NLV6T41S8DQiCux8t9qYzR2LtSvnNX
         oW7gvvwiDgmlQeEE/7uLAKKmGdsrkP93JFibJofjlE4Dr0j5CrvgagAdNVYgNKWWNSde
         EfYBpqnOhKp79WXvymA/PyALXe4iZOOCMimwl+EpvUDT9GVRFexNLxQ8pjYW3Dp/I3Fg
         nhx+HkFUc4Pjs0AYrbxYSGl7Hdxa42sWAmqD/TBpgKgv3H3dPX9nJhwP6RUirMHbs/6n
         EeKw==
X-Forwarded-Encrypted: i=1; AJvYcCVhuDKNSydA5dd2aplRsvFIieBnLMHLnc6Gou9YNlvQRgoqj+y+W3Fl5WNBJafbvoJucVZPF+4xhg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwU2/p1OB8d4O/JPmDCUHw9xY9C5x4w5uXSwoRJBbA8j9jsRSPp
	M3LJsj56mhRCXSYreAEsqzF46Xh5v92OzOj/l7qHn9rDPoxFeyLtk9RQFacC/t70L2e7peS/IiY
	GrI5KP/GQZdthiGm4kLc6wds6MzQbLR4krYyrHGuh
X-Gm-Gg: AZuq6aIUxcCKmCE8Y8qxBGocFeiYjwgR5rSJZzaUazeP4PjwDCGJRDOwHz6u/hwlrNm
	FQCPsCtMm+/1OuPoDzH9gpvkIre/IhZzIUAq2X/7nnXrrxohzWbNP1JJo/tWBOUDV07t+asJkNv
	mzceJ2mwDRht354x9tyBcqe9s0ixSwXxvxA9f9OWphDeLUY1UBK2aikTHWa31C3Y0qYCRLu66wd
	mtqr6zZ86LIvY93UpG5l6+KaICMUAK1crXx/hRCBEbY9uebMoY4G3MWtNY65rSWMRQK4c8Esz1X
	kpsxNWsLLBXtEY0FtOrSumIjrSRdvABYvGwMWg==
X-Received: by 2002:a05:6000:2409:b0:435:95c9:6895 with SMTP id
 ffacd0b85a97d-43958e00ce5mr15101201f8f.18.1771584608836; Fri, 20 Feb 2026
 02:50:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260220-unique-ref-v15-0-893ed86b06cc@kernel.org> <20260220-unique-ref-v15-3-893ed86b06cc@kernel.org>
In-Reply-To: <20260220-unique-ref-v15-3-893ed86b06cc@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 20 Feb 2026 11:49:57 +0100
X-Gm-Features: AaiRm525n9TXR47KvplRQPUHuuUwgU5iN4_ng3kUHWK8LN9TrQcHulfhA1IhjZ4
Message-ID: <CAH5fLggNjCZ3AvHnhO8O0cmd33B3zMbfq+hhNvonznTsLLtgYw@mail.gmail.com>
Subject: Re: [PATCH v15 3/9] rust: Add missing SAFETY documentation for `ARef` example
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
	linux-pci@vger.kernel.org, Oliver Mangold <oliver.mangold@pm.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42930-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[39];
	FREEMAIL_CC(0.00)[kernel.org,garyguo.net,protonmail.com,umich.edu,linuxfoundation.org,intel.com,paul-moore.com,gmail.com,ffwll.ch,zeniv.linux.org.uk,suse.cz,collabora.com,oracle.com,ti.com,google.com,vger.kernel.org,lists.freedesktop.org,kvack.org,pm.me];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aliceryhl@google.com,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pm];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,collabora.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,pm.me:email]
X-Rspamd-Queue-Id: 3FA161670A5
X-Rspamd-Action: no action

On Fri, Feb 20, 2026 at 10:52=E2=80=AFAM Andreas Hindborg <a.hindborg@kerne=
l.org> wrote:
>
> From: Oliver Mangold <oliver.mangold@pm.me>
>
> SAFETY comment in rustdoc example was just 'TODO'. Fixed.
>
> Signed-off-by: Oliver Mangold <oliver.mangold@pm.me>
> Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
> Co-developed-by: Andreas Hindborg <a.hindborg@kernel.org>
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
> ---
>  rust/kernel/sync/aref.rs | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/rust/kernel/sync/aref.rs b/rust/kernel/sync/aref.rs
> index 61caddfd89619..efe16a7fdfa5d 100644
> --- a/rust/kernel/sync/aref.rs
> +++ b/rust/kernel/sync/aref.rs
> @@ -129,12 +129,14 @@ pub unsafe fn from_raw(ptr: NonNull<T>) -> Self {
>      /// # Examples
>      ///
>      /// ```
> -    /// use core::ptr::NonNull;
> -    /// use kernel::sync::aref::{ARef, RefCounted};
> +    /// # use core::ptr::NonNull;
> +    /// # use kernel::sync::aref::{ARef, RefCounted};
>      ///

Either keep the imports visible or delete this empty line. And either
way, it doesn't really fit in this commit.

>      /// struct Empty {}
>      ///
> -    /// # // SAFETY: TODO.
> +    /// // SAFETY: The `RefCounted` implementation for `Empty` does not =
count references and never
> +    /// // frees the underlying object. Thus we can act as owning an inc=
rement on the refcount for
> +    /// // the object that we pass to the newly created `ARef`.
>      /// unsafe impl RefCounted for Empty {
>      ///     fn inc_ref(&self) {}
>      ///     unsafe fn dec_ref(_obj: NonNull<Self>) {}
> @@ -142,7 +144,7 @@ pub unsafe fn from_raw(ptr: NonNull<T>) -> Self {
>      ///
>      /// let mut data =3D Empty {};
>      /// let ptr =3D NonNull::<Empty>::new(&mut data).unwrap();
> -    /// # // SAFETY: TODO.
> +    /// // SAFETY: We keep `data` around longer than the `ARef`.
>      /// let data_ref: ARef<Empty> =3D unsafe { ARef::from_raw(ptr) };
>      /// let raw_ptr: NonNull<Empty> =3D ARef::into_raw(data_ref);
>      ///
>
> --
> 2.51.2
>
>

