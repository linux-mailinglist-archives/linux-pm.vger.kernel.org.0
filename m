Return-Path: <linux-pm+bounces-43809-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gFNoN/7LqmnUXAEAu9opvQ
	(envelope-from <linux-pm+bounces-43809-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 13:43:42 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D6EB220DCA
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 13:43:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 51A6C3073F71
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2026 12:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBE38221726;
	Fri,  6 Mar 2026 12:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G4tAOYqz"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BC521CC4F
	for <linux-pm@vger.kernel.org>; Fri,  6 Mar 2026 12:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772800610; cv=pass; b=Sq/NU1xgY5UVHP78Uan0MxYPVC0N9LdVt/vY7iQ8mvTJRG5t5AgzrFwFWaD/Tl0fjnxV0lYjBuNHI+1ORYvgL5uCXZRWIac7g7kqvTSX691/2xvNQJYLfcH9b7iF3oxnPZaWxgylNr/sV+48bs2rKgpgbHpcRkPnwbPRFF3q6xo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772800610; c=relaxed/simple;
	bh=HQEassPVGYM1jCdRfpSudNR1v3HtLxgtQuAEtQArpTE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z+r3S+OkAaLfbrDpMFws5pSeIeKLqjcz34M2ux9ulhAmaOFCtlsmqwPUoGa+2UtCaI7QJa1AVYHFa6+ab2ttD0ccB4f/4AEhroTMvlfMOjExQ1spllQswePmi9wj38f+TkaJtEQx2Vaa69Hz98XOX7rcB3+ZY46fWiN0cOxgS08=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G4tAOYqz; arc=pass smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2bd801b4078so785107eec.2
        for <linux-pm@vger.kernel.org>; Fri, 06 Mar 2026 04:36:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772800609; cv=none;
        d=google.com; s=arc-20240605;
        b=ch7oprbjSrFFEbPMrQ0HjbipRGny1gOverx5fnv1X13Sp9kq2+45Deq3C2868LhI8J
         y9ZkAMPM90jub8nipWweV1O8ETEnpeyCb8T6Od6CmioDcOTP1kgqgm8uFLsPS9cOc15H
         LOzWE8EFIf2aWVM/Z9zUESQTCMk3hMe9yVyDysQy6UEC5YviXtX0c2t5mwNZACv/7oiS
         cYqyZ8wADx9z3Eowt9y8ZuAot2Tt02f7aCeHvRrwMlK9BLYi2AeCoHpn+zTJOjQyx/ri
         dYrOYMO7hh5BGVUA1gn2gibFfUoIuDTOVc8yf0h+v35MLtENM9ZobseOdW1JficpC2Nz
         vS6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=knqD/zlQpWPkzS9PyTnnmuqyEYSvWpR1vlkN+XG+Guk=;
        fh=Gk7nmwqZn0FFkAoNWJEbGCT+s1cVtffLlFceeIWOZ+U=;
        b=JcpQ+vY8oAKY7F+1qvmYuxoyvK9XL0Ly9ysyJeOMyC2+Y9DYSxL0XvWhcu0cTflhuo
         F7Ug3KxGX1Y82zVoJbvhKGiWiCW4XOQPSX/JfSVJupAPex8b+SVWB7XzmY9A/0O2797r
         fFBmR3PqQW+DKLaOHqyCOqamUd9DpCfoNnV6dCWFdzHQh9zO2Rb+iEPYhXJxNaBl1ueC
         +Iu+bhE64URcbTO2xqGnlSxaTh9uSwYaKDdI7Bb1eJSqi8Sd/ZB7VuZrsAN7IW8K1Fak
         uYXaXPubkh4eP/HFEv6+nztI4KNUENvZ8UrN2ziubepg8/LHgksINh8cTNAoWBEL8bNq
         OtAg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772800609; x=1773405409; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=knqD/zlQpWPkzS9PyTnnmuqyEYSvWpR1vlkN+XG+Guk=;
        b=G4tAOYqzk9YUVw/CNcm5RnyA+RxL249pNcgMEcfMb/KCL1m9DqyQw0jZpaiJHZl/wB
         258u8SW4s8ZFOdhTmi3v+9W4qSnpFsRWjFvJPPYmNwvS0mWkF6veKm5cahWolh2hYAc2
         qyPUBHTUtfBxXMit2RZOk85GVDaCVkIVv2S6KIgPjlCUDOaKhrLyYXtVE9qlCDefrp5Y
         meWm21cr0Vm2OMgyMnb/G0a1eC4j8Fizosw/H8GgcALkp13cVFiLmzUmICupB6iACe6D
         tOosPmJgVWufTypW/PPHzzLTZeMSZN41yXcO8aSGDJdYFpD68WgHfwTPi1ZQplM+RqK4
         TWZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772800609; x=1773405409;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=knqD/zlQpWPkzS9PyTnnmuqyEYSvWpR1vlkN+XG+Guk=;
        b=STek6aegYIdl40mGzcqYxnuMNq6+4Ae12NXw0yPuz0lSVHYhv2Ci7W7D1unHc/mqYU
         pqOIhtMyIM0yiz/4RqxtoZyx9YQKzSAYHj41Fu6maldw2OWsg7RhUkf2LyT2TLgOIv2V
         tEjmLto/I6GyhT2OxjJaU6MOSD1I3YPYO9cFt1Q/gp/0vrlKaQwpEOEvGypnrTB4Cquu
         L8SzigScrhioCjVAM21gU6I9JKkjq/hJrvPyFOmPtV0UEgMRVZQoSMbUg3TGjgbQtrdv
         rjUTIF+KfVnfu90JaNXWjMxO+P25+II2H2XyNVORAzGzoiaykWqW3KtSredwghKCbCe6
         iwSQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6D68UPApUl3pbt5eWeh2pFkeCppLqGXPCcoTgdVAiALdSeK757ssT8A6zfgEcdpBOdW0pPqg8AA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxsG8ecZe4mEt7bl7O4lGXjy5B5ta3D8SXV6zHup9iC0OnQtAfB
	V70tn7rZvT7WgnNLyFKIemQ5EXDfwAXoSkaYszrkcwA42cRiWCtSRyrLAdavxatoLACivPfKxjD
	ol3KwRTMyl3PV8vg4XFofUn10Mr/qlE4=
X-Gm-Gg: ATEYQzzUT6bpCh+BpB6m12XiioVzhutrcFuoGUpORjXV+9mI2ZJeIWFWbl1zd89VRYD
	RsHUExj7+JhqHsNTfv3BhRboTpOYY5fQWdAB+RVA8zBbBzS/QCYBIfuPpKZCMpKyg54OrBXg+/l
	wjUL9L8qmkHCzSk+IftsX9n74h3JiTY+qy4OAT9wo16s5Dv1DBgYhk0k3w/M+KbPGiLdYajVYFs
	VuiToHqzGdU+n7KM5YZSUMy1O7Qxz6WXb5q3nQ7W4rTAPQhWay9XsDJF6Q5GHsvHL2E+UqpcKYW
	jHTNrZ538OtQj5T9l6oNKC5w4tUhe6aCQr/7Vz+8IzPFX/bYv4Fdtrt8wiOr0pRZW3KffTrZoME
	hyz9hrZEZR1lAaMZGKW/ZwNcz
X-Received: by 2002:a05:7300:148e:b0:2be:2912:ff65 with SMTP id
 5a478bee46e88-2be4e055899mr438556eec.3.1772800608643; Fri, 06 Mar 2026
 04:36:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260304195330.185829-1-jhubbard@nvidia.com> <DGU9O3HEY7CN.3OBR26YV3AHGT@garyguo.net>
 <ea3d6134-22ce-4715-be75-e6d41568c7eb@nvidia.com> <DGUA5GY2DGYN.3PG0FKLG7GFN1@garyguo.net>
 <DGUAE329P4FH.3QPNCVLNA99MC@garyguo.net> <0c4ae9ef-b803-4ead-a2c3-d5dc37592d5e@nvidia.com>
 <DGUUMXMLYH02.2ZIPQEXAJYTEG@garyguo.net>
In-Reply-To: <DGUUMXMLYH02.2ZIPQEXAJYTEG@garyguo.net>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 6 Mar 2026 13:36:36 +0100
X-Gm-Features: AaiRm52ifH2FYBZ84a06nnd-7ZSPspJMkRBn-0RHo0yD6BLwqFwbKKjW_sSOGls
Message-ID: <CANiq72mWdFU11GcCZRchzhy0Gi1QZShvZtyRkHV2O+WA2uTdVQ@mail.gmail.com>
Subject: Re: [PATCH] rust: cpufreq: fix clippy::double_parens warning in
 Policy doctest
To: Gary Guo <gary@garyguo.net>
Cc: John Hubbard <jhubbard@nvidia.com>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, linux-pm@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 6D6EB220DCA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43809-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[nvidia.com,kernel.org,linaro.org,protonmail.com,google.com,umich.edu,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid,garyguo.net:email]
X-Rspamd-Action: no action

On Thu, Mar 5, 2026 at 1:32=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote:
>
> I think we should either disable with
>
>     #[allow(clippy::double_parens, reason =3D "false positive before 1.92=
")]
>     fn update_policy(policy: &mut Policy) {
>
> or disable it globally for all Rust code before 1.92.
>
> Miguel, which one do you think is better?

Hmm... Disabling globally for all versions could also be an option --
not having this lint doesn't sound like a big deal, I think.

I guess it depends on how prevalent it is, i.e. how much we expect to
hit it for the 1.5 years or so (since we will eventually bump above it
anyway).

Or do you think the lint is very valuable?

Doing it globally for certain versions (i.e. `rust_common_flags`, not
just `KBUILD_RUSTFLAGS`) requires a bit of reorganization, so for
simplicity here in this series I would suggest a local `allow`, and
then we can see later on how prevalent it is to decide whether to do
it locally (whether per version or not).

I hope that helps.

Cheers,
Miguel

