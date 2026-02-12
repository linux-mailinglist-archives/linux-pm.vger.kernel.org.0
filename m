Return-Path: <linux-pm+bounces-42553-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eLQ8KG29jWnL6QAAu9opvQ
	(envelope-from <linux-pm+bounces-42553-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 12 Feb 2026 12:45:49 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC3B12D1EF
	for <lists+linux-pm@lfdr.de>; Thu, 12 Feb 2026 12:45:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 472123007B28
	for <lists+linux-pm@lfdr.de>; Thu, 12 Feb 2026 11:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C40C34D93B;
	Thu, 12 Feb 2026 11:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XcXQ2kG0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0FC3469FA
	for <linux-pm@vger.kernel.org>; Thu, 12 Feb 2026 11:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770896744; cv=pass; b=I1AUfvoVOM0bbS6M4yrZXgIBTBNxACRUB0hvnmT01GDXwQny28+QrZJq1rg/34cIHc4z4FhMFznkQnMFjsPIcY4V6rJ+ZI19yyZGhum6KMj2xUWvuN6oCnsIwC4FtNtTOOXD4rHhuSslvtCu9m45bOZzmlAmised/u/NhDBxJZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770896744; c=relaxed/simple;
	bh=aGVkLIr22yJ6JQpgXmUzvygoH7/3iICzBNHCpv+ndoI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tyHhA3nfESAaixq6Qp0OoWrwRunoH5Z8cf5cc9opk7lqjKFu/BH4A5zlIZqlyDAXzXEFVkrOymNxAMO/xF/8HrpRH7jNXWwh11c8WsCV/kgaH9yHOt/77QMn+vGAJsGs4cyURSNHACBdbU56+E8xhwR7BytvFzPoVdzqaMzted8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XcXQ2kG0; arc=pass smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-124b07e5fe4so602142c88.3
        for <linux-pm@vger.kernel.org>; Thu, 12 Feb 2026 03:45:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770896741; cv=none;
        d=google.com; s=arc-20240605;
        b=hIaW5li+Ll4QykgsC8sCkbC42Cm6QAcRhFBNqKkrxzvRZGavNqYxu6SbxouK8CmDZd
         dy1d5CQLcfAZUUZk5dN9mYDdNpriy514NYk33dJF2wD7mk1ux0xm8VLGjRNgqib0Bpkn
         ocVY3T8Oudf9O8hE094TgDTtaqbEwDD+FgNEbhvIW1oGK1eWIe9OP3mralb9A8k8v3tG
         94zpLHzE9IKOKICqlM69Wb/XIk00eJgzhPRXqhj0Gs/4j+TIZXDEp8yC4L7xzFGzXAlh
         7jnQgOkE16UrTZkce4AuqRQ3DMuLV9sF8y8jUQlXXBPRTHLRD1zSnEBlIz5Qem5v1H4S
         8QTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aGVkLIr22yJ6JQpgXmUzvygoH7/3iICzBNHCpv+ndoI=;
        fh=qZS9jMDvwSQbwwvX2NuYHBLawqblIN2yYRw1JEJi2sg=;
        b=P8UsMVrdrFpnW2U4U/pQXanHYZdzPcTPhB8tFwM3dL6eoo/thxMTVdXiLKzcfvUOUp
         HRqLWrKvZG1zcoZFUwtyrvVOCSfuHhMGC4QlRw7BoPvN9RJZO2N/xk5ZEGNGKuw0JOfi
         UfSOZ6GGlkzkhW58jrzib/QtUxDmqLyeOuq4NjrgfCC+wnaaG9pyJ1cGDDcpkwK7tATW
         nNVJZJ8OuKQHm8SGXCBVLS4+hWmJkHfmi7ehg0p2KmbeWpk2Fqkv+J4u3Wcw05b8kGJi
         FDVRNVUlnWIhOZmLE+e88+wWHPSdftcKdctfoa8SymCHirun9ykE6UaAdHpEkoci3szi
         Mjcg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770896741; x=1771501541; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aGVkLIr22yJ6JQpgXmUzvygoH7/3iICzBNHCpv+ndoI=;
        b=XcXQ2kG0/4oTcSyjVdNx8+Np+emwCX7SxewOCDoYQO53GU1RfCDS+wbmFt8WJcVnPD
         S3ZGBGfvxltS3SsK8zLuIuBdr4eof35tH4TYPKzywNW1wwYlx7Vt8JxnQPPpmBSL0fCT
         ESYJoYHTkhuJTc3H07AfjOOQ5U5nLbjV4YXmG0VDO8pfsffKkNFkDJbqzk8hJ7/MwIZ4
         n+q7nhmjxJxcAzMVxSCtMU0vMwbxejKEn9280PjektUEpiOCTK/ceXDyO1QCLCRHImqw
         jBranbPi5vQl3qSlT5sJG+VfjFLUmejLYGAjQ9z1JqsCSabyLjcOYdMFrsvJXWmIYi7i
         mwYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770896741; x=1771501541;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aGVkLIr22yJ6JQpgXmUzvygoH7/3iICzBNHCpv+ndoI=;
        b=O/hFg6V9FWAHlJMOcU9f9KJNkwdWrHvgICHuBepB2j7hFe86qLUPC9SoX0QK5KOUib
         pednPY13zgswZMwLPCDlBPp+vsXKZl7ySWDpnDFn6aS+JmXbM3bOptX1gJr/ZL9k/KDf
         IX24GqJRsMxvF1WYYDNRmOyWgOMxlxH64wNXLFIDM2XVoWcboC/mBo5ItaK2MO0+Nli0
         /tdlfdzIVI1FRPQh+8IOIz9RnbwQeqkB07ZQE1CPaRuACBDV7/OdDhJbjqPpiyv9UjyQ
         cU3o0BHLcP+aQpGl0/rYH9oVHcXmmh1Vct5T7CU+Pq9bweEYphZIV5hn4o0G9hUF238M
         Tm/A==
X-Forwarded-Encrypted: i=1; AJvYcCXPRlV9xV/hlbgvtoJHozrWOM1ieVTRDT1DCxlKVTu905QnPD+txoN/7y+3V9tA073TAYPC/BjkLA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc47PCB4lhES8sjhW+CPp9qQ13L/NAT/Xr7dbCK1SpK5FL8U+k
	0nxPgmlKXGr/eUaaiRPiq0U9XZdAT3pORigSX2D8A8LU7NJUZ7CXZ2dhoUal3N4mkKMHfp/xOW+
	gDuGLl8B1Iz0sFf3J3YeUYbBQ+syrt/8=
X-Gm-Gg: AZuq6aIaNcrog+/bCJKC6zdV9k+Cd/H4mGgL1PZfn6/rn//UW5gXcxb4DXAD/NPgzXm
	BDsYcfO59EVgvWkpR/BlWkVWN4oEV/BK5tBynP3oN9CCgNLIb3tj/Nzw39MT6ziIvkRm36iwuXY
	CC8xObzR5jf87A2EYZXvdUansFIJkvkAPsFElpiuPTkgvmDEGlFbndlcE1d5hmKHE9vy6IRMyxL
	PvnEFQntRbSBczo5QH5A6KefDtdpfN+SPrgZMBS87J86mdEYcoN0jw15UNSbIf2cy3F1ZRkP+YZ
	IyvpGAPbpv429KLsGtxO6nLy7E+0me9Rf87bCOs0arzS8dbcB3lkhCXqkLBSMrbZ0CUoA2i+LSb
	ZxpYFS2st+jG7NdxaTWPesVNJ
X-Received: by 2002:a05:7300:aca6:b0:2ae:5245:d50e with SMTP id
 5a478bee46e88-2baa806e40bmr507989eec.8.1770896740603; Thu, 12 Feb 2026
 03:45:40 -0800 (PST)
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
 <DGCAAE4YEDLO.299F5M641E90B@kernel.org> <20260212-obedient-faithful-koel-d8aaf6@houat>
In-Reply-To: <20260212-obedient-faithful-koel-d8aaf6@houat>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 12 Feb 2026 12:45:28 +0100
X-Gm-Features: AZwV_Qgkz-xkhnIAg7JBqdav3KKnsGWyI0KDQ-RkibJi23X0-5wEzPLcw-SuW5I
Message-ID: <CANiq72m67XpoE-M2eiJn7RF3LvxRLKZ17YExJJFOFw+H0Bw39A@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] rust: clk: use the type-state pattern
To: Maxime Ripard <mripard@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>, Boris Brezillon <boris.brezillon@collabora.com>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Alice Ryhl <aliceryhl@google.com>, 
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42553-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miguelojedasandonis@gmail.com,linux-pm@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,collabora.com,google.com,linaro.org,linux.intel.com,suse.de,gmail.com,ffwll.ch,redhat.com,baylibre.com,garyguo.net,protonmail.com,umich.edu,vger.kernel.org,lists.freedesktop.org,lists.infradead.org];
	TAGGED_RCPT(0.00)[linux-pm];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: CEC3B12D1EF
X-Rspamd-Action: no action

On Thu, Feb 12, 2026 at 8:59=E2=80=AFAM Maxime Ripard <mripard@kernel.org> =
wrote:
>
> And the "oh but driver is using the API" is kind of ironic in the
> context of the Rust bindings which have globally been in that situation
> for years. You can't argue it both ways.

I don't think this is true, if I understand you correctly.

To give some context, when Rust was close to land in mainline, we were
explicitly asked to cut down what we had out-of-tree to a minimum of
APIs, which was fair. So I did exactly that, to a point where you
could essentially only declare a module for x86_64 and use `pr_info!`
in it (pretty much). I even considered dropping the `pr_info!` too...
:)

Then we started upstreaming bits piece by piece, getting agreement and
input from the relevant maintainers for each bit, and so on, which
took years for several reasons, one of which was precisely waiting for
actual users for APIs.

[ Others were getting maintainers engaged and involved for some of the
core APIs/subsystems, getting authors of the original code to submit
it upstream via patches was yet another, reworking and cleaning the
code with the new, better approaches we found meanwhile (like
pin-init), and so on and so forth. ]

Cheers,
Miguel

