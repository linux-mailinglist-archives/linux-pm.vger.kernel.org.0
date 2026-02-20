Return-Path: <linux-pm+bounces-42946-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ADMiLQ+bmGkTKAMAu9opvQ
	(envelope-from <linux-pm+bounces-42946-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 20 Feb 2026 18:34:07 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B22169BD1
	for <lists+linux-pm@lfdr.de>; Fri, 20 Feb 2026 18:34:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BE97F3042B4B
	for <lists+linux-pm@lfdr.de>; Fri, 20 Feb 2026 17:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 243B3365A16;
	Fri, 20 Feb 2026 17:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GUmovhQZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E165E3659FF
	for <linux-pm@vger.kernel.org>; Fri, 20 Feb 2026 17:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771608845; cv=pass; b=K7naka3CWNLpto3uS/W8S79mORtxqtj05k0VUhCHIJdy3PDUrFn+dNU4bGfdltprdSV3LVTbkzkqOC0Ap8/vKFU0Fpni//RgP17NHEUNorWbL2Y76mzj2gaftEX3ZC1jFsX8M7ETTVULPIUWyuQWH092yMt/K884UTnoXTvBbnw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771608845; c=relaxed/simple;
	bh=dW69iUku9IRFksYkhFKb49OwK2nuvLOXPied0JTmtvA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HH1V0TmtfhafVvWeq14DE0MDgTVz2j4vf58XlqMw6bEurZOwUuM9WUOtjQCDnSlhsLeMeMG/KLLhSq3CkDcUHFfKWT0nMKPYjomc5YYPUchNVR8A/8+8PuRIRfHxg/2mWhpXCfzoO4gx1VI5VGR8cGU6FVpZ9ZRaZ006fVC+pZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GUmovhQZ; arc=pass smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-127148c2112so221440c88.3
        for <linux-pm@vger.kernel.org>; Fri, 20 Feb 2026 09:34:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771608843; cv=none;
        d=google.com; s=arc-20240605;
        b=lrcszayNABtZ8byAXcqY0lKgOSZ0tBcrIaneFTkp3w6em6L4tKZzMSBH374Q+Z1zyj
         9KYqtfEQqverp2VWjMJuTzMk1YgbDcXSuapAh4aqqrbKUlFK2n/FvpZ4T4R7zWQnQ/NM
         jZVLikYwMH2zr1nDaWeLFCTHTbFQZlf5k9iG6nW3emTHiCRdOMGOYHAoI89MCqi6b5eV
         OVxw90ARrZS56j/ZZkzkUpOoI5Pe5/QEgCXRxGhuS+l99jbVqMk+Y5Cp2j8+sRwZ/JE/
         oDO5J9EpwxGMQcIm5nSwLmwSNUtWW0aIps5h8lgO4uGjVWBdr/yjooMo3LEptRG9tmdQ
         7oRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=B3RiLfffpu7Ffa96sGXtUyFTXMqhEfmtMEWOofkZHzs=;
        fh=31igz7UKk6GXf4u/hykLTXRBAl5mquaHIyvLVQwtQuU=;
        b=c7oklJ+lohKKFQ7uA665eZH7EucbX3h6kB9mAouPEAGm7g/bQE+GtHnbUaGTGc2Erz
         0F0XIEXR40x8ePaxTAW6Pu4Tci02JHszZxL5vY+ocZIRwbnFKDNNIcnxuiET80KRayOc
         rRmkATsAcyMl/s6u6ZYJLRKZFYSAN/n+iM6QybqkHyFO7uTnS19j66upMv0Gb7hVJLVC
         BIyRu5n3nVa727U+VtgiWMuVKNrrUW3be/cdambmMbIrWVluy4wXMkVLtLITBF/BGGZ9
         05hSmGT3wBhAEVRJFUe3VjPALsBO1Av/LEANOtJg/Zl5WLTNuE7ObNNLT0Qcy1Ev6rmB
         LLUA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771608843; x=1772213643; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B3RiLfffpu7Ffa96sGXtUyFTXMqhEfmtMEWOofkZHzs=;
        b=GUmovhQZ0/gL6Csm9lB/oZvXQzoRbh+uVmBzc8YSv+cMKg9Uubues33H/9RyfdILfj
         k+zc557ufFVnuu02HgkHoFuAOrYPjf492rTJMSJs+Y14GZdZJ6vatA+cSh9f6oo963Io
         d0+6cjq3IXdboW94NV5+1nI2XbXJvpX520Bj2HNaDdIOD88O4E6cx87O+l9159ye1JVx
         z5ECFYUXaEaFv94IyKrGZwFgzAl9mjpRAIoxg2VDDG4MXRpqli7BRe0VZzFziNXygZdF
         C5HOej3GIe0ixLu5QAUeJFlzHR9sfGixz9LuDB31Pak32LJ1sCx/7snoqduumBjN/l3T
         gKng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771608843; x=1772213643;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B3RiLfffpu7Ffa96sGXtUyFTXMqhEfmtMEWOofkZHzs=;
        b=bMNVkdQLn/C0TkkmA+HDIxtnr7HcFVSD1HMoAyBs/W1SXsXzzlBBEUWQUMcisKnQ7s
         xRZQ3erverJY8/OxE8stV2HRNKOW49qStEwA5EELjuWKqjLqb2ykiGvP79+tuKwU+3V+
         iC6JZgWp6DK7oxKGxy3DTbOATJvaxgb/nHuNnK/K3TOybfeTJ4JsllfRWXJW/LSLYRuL
         IshS/PtMbk3+XV4Yhm8sKfSu/rrTkWNk22C2W+R85/ISOB93dL8h5cg1cSzUW9CdTeip
         s1yNSl5EumJ4xyEomM6uOHg8CTpV54nwW8xGUpbnIACWMQxAQfcHtvqHcSaGO38Eu793
         BCWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfx9n7+LglOJTvIivEWgRw9bLwsRqWt5XBBhHhg5aT1ZNH/56HhFJNG8gyMBS1CpCLGu/25lIHWA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5ja4Jzkyk2Kz62qhNN+zDSS4l0eOuKACMkTJd5DlsoV4TGIJW
	juoxLu+LTEqwByH8KWnRsZI8N4Qw94hougeTQ8OwkJcRXv7m0SwsmczDgO+drqs2x8m7YQTjJAL
	XEzowvjf/F4BiFjqBjR818Wql8XBRGdU=
X-Gm-Gg: AZuq6aJASx5G/v2fb1FBS5g6BfWB3/D4OHznJBwP2gejD6GienKy+nSL/fBezJdda9Z
	e2pOn59+++DlbXSOCgpWwYfHc7xPY2uWJd9f7NKy/I50A/qRGFbX9EvcSY9iQBvdnTC61NGhD/W
	q0o8JDeogLUJbxKJQR3EE6Rdgnkkcq6VLjb66jZ2A2ZT/xaYJZSC7YCEu01WrF0PGPlujuS7H8O
	RYG5NfEYiFMUefBTcyzs6kOMavOfF2gw1+j0tkpj/jQaFtYtxLtw67P+rpW9eIg5VIvCN8juck7
	Pmw0GmhRUCBV3u8F5eNdPoIk+W9r3bOU/+Ss66PtBnnr+eHUIe/ROfp7ab5Q8L/JX9ZTwbk4sp0
	9QlJEYuAKyvxL+Amg4JCXVBO/
X-Received: by 2002:a05:693c:2c17:b0:2ba:674a:dbe8 with SMTP id
 5a478bee46e88-2bd7bdbce7cmr74947eec.8.1771608842904; Fri, 20 Feb 2026
 09:34:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260220-unique-ref-v15-0-893ed86b06cc@kernel.org> <20260220-unique-ref-v15-9-893ed86b06cc@kernel.org>
In-Reply-To: <20260220-unique-ref-v15-9-893ed86b06cc@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 20 Feb 2026 18:33:49 +0100
X-Gm-Features: AaiRm53lo0keI-FayfnRj4AYfVuM2jzmE06bNyAO-n4MO92LWSUkvblDHz_tCFM
Message-ID: <CANiq72myc+tCEHm0WtZspZHWwsSzvesxsmUvk31=GCdUN_zVNA@mail.gmail.com>
Subject: Re: [PATCH v15 9/9] rust: page: add `from_raw()`
To: Andreas Hindborg <a.hindborg@kernel.org>, Tamir Duberstein <tamird@kernel.org>, 
	Benno Lossin <lossin@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42946-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[40];
	FREEMAIL_CC(0.00)[kernel.org,garyguo.net,protonmail.com,google.com,umich.edu,linuxfoundation.org,intel.com,paul-moore.com,gmail.com,ffwll.ch,zeniv.linux.org.uk,suse.cz,collabora.com,oracle.com,ti.com,vger.kernel.org,lists.freedesktop.org,kvack.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miguelojedasandonis@gmail.com,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pm];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,rust-lang.org:url]
X-Rspamd-Queue-Id: 17B22169BD1
X-Rspamd-Action: no action

On Fri, Feb 20, 2026 at 10:52=E2=80=AFAM Andreas Hindborg <a.hindborg@kerne=
l.org> wrote:
>
> +    /// Create a `&Page` from a raw `struct page` pointer

Please end sentences with a period.

> +        // SAFETY: By function safety requirements, ptr is not null and =
is

Please use Markdown in comments: `ptr`.

> +    /// `ptr` must be valid for use as a reference for the duration of `=
'a`.

Since we will likely try to starting introducing at least a subset of
the Safety Standard soon, we should try to use standard terms.

So I think this "valid for use as a reference" is not an established
one, no? Isn't "convertible to a shared reference" the official term?

  https://doc.rust-lang.org/std/ptr/index.html#pointer-to-reference-convers=
ion

In fact, I see `as_ref_unchecked()` and `as_mut_unchecked()` just got
stabilized for 1.95.0, so we should probably starting using those were
applicable as we bump the minimum, but we should probably use already
a similar wording as the standard library for the safety section and
the comment:

  "`ptr` must be [convertible to a reference](...)."

where the term is a link to that section. Cc'ing Benno.

I have created a (future) issue for that:

  https://github.com/Rust-for-Linux/linux/issues/1225

Cc'ing Tamir since this is close to the cast work, so it may interest
him as well.

Cheers,
Miguel

