Return-Path: <linux-pm+bounces-20774-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1764A18536
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jan 2025 19:30:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8FB0166BD5
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jan 2025 18:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB5C1F55FA;
	Tue, 21 Jan 2025 18:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CBVjj374"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB611F4E50
	for <linux-pm@vger.kernel.org>; Tue, 21 Jan 2025 18:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737484194; cv=none; b=F5docpBu1ethBsdMDA2N8mlmpVETgz95OsmE8TKJWh+rgmsYKPniWbS4DTebb8HrsZJ1vaOlHaM3p/wxaxumsw6oCy25j4fnE3GMbhW4867lpsGkp6w9tSPJQSQAOMCtUO9UFYoqeSvyukFvlEkAlSLqdSAj+OLNHf/qxp4vwiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737484194; c=relaxed/simple;
	bh=jqDzj+eTPBIMLC2SCvL3JbqmPEgXso2MiJ7GoqGTJng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wdmk0mKskk2JUOVw/TLV/Qa+C72GQEMxA7ulBXlXpeK0iw5fHu8PtWYw0l41qdQo3t8YOi/oXfMk07xztaPHSmi9x5AdbFMLeSwziqZrBc4Y9zVlkrsppErbOQ/lkj1988xer7Jwyc5r6Xw6nmSVNsd3cyAf+VPB5lncqSn6e5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CBVjj374; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43622267b2eso59610975e9.0
        for <linux-pm@vger.kernel.org>; Tue, 21 Jan 2025 10:29:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1737484190; x=1738088990; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xkAKeDcaoc8aic3fG+NCS5mGcWlbtV39f2bpcRLuxIs=;
        b=CBVjj374ySgZoWRqkz/ZOjaeJC02SUgJTl3e5wOoWNU4ivRFj6CtucAn/Eun3JucxH
         FQ+FKYQ6uK7khIZhR14Nw+5pJs/VzBdsbL9EXArk7eQGBALQ7nw+g7BnOhvTluVhD/E6
         kHX63P1iDAXceWcKVtKMJ9sqHFLsOYa+8b/skB9njTq53rClIVnqZQBrH/VJC9WDuKb/
         bXCPPVoajZGv92bDycH2b9RAJL0cEIdeDPnhLCbCtk8sAxbBVmJdHA1IP1JKVi42gJMB
         6v9navO29kRkaeLf0+a9NpT5s+gS8wVxsctQEkidvjqSKc7hu3KR/tm1iealqp+Ik6ct
         vuJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737484190; x=1738088990;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xkAKeDcaoc8aic3fG+NCS5mGcWlbtV39f2bpcRLuxIs=;
        b=QcDqnctYAMvcDR0ebKP5SrRd/XdFHCYqe3KZXOl5ybBinFw9BJEzHDAcg/TUAfKJqu
         pSCmEr96rSTSCTKNsEvWxQ96DZhalaauqkbtWLr8SC8LqulDZ2IdQAaxIga8dfRdZhRx
         bjk8iagVZSYlRDHQH5pte3XqWQL2G1vr4DPQovXAbsXUyEGEWVPpXbo+RSy8yCAXkTsB
         75GlCmOY/J7V6WaTYabuXUACKkxs+9PbaIWLHfJOpoS4WxD3SA5e2BQRxbQgKLRnjNAs
         U5gH3S0QgeHRjE0PkVLliVM4wV/sid3lMRvQZTu+xdQ2xENI19/1yc2IicacB0LzQdur
         /bYw==
X-Forwarded-Encrypted: i=1; AJvYcCVj5yHXV56m6Drp6G7+Ybv4wz8P+iVwl0XKCOKo8M7Kta3ex5e//aZis9Gaq0jNBXChq4iyOtavMg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzrNPfu70cX7bi+/s22VBh+VW5n2BY3PD5a8UP8hpa70j/1m8yQ
	msIME7YXviLjrUEm/foeS2MbvWaiCJ6rp48QRILzeOJFuVSMAwo//+gyXY94uOQ=
X-Gm-Gg: ASbGncug7UCIec1OkP+P/iG+6kfRIU1/Hgmxktx7snowFkz+ALt1rNsT7fJ+JEPbg8T
	GM6JudIoEVEXhBF9TryE4CGxSgulUUZvapXEYoJ6fD/dl9Uadxx5OCxc/63tc2x7pMdzcpM7zTP
	d7Ne8lq/A4mya+KidlxeNjpHqd6aZDnsE4pFBaqPS2rmWlWnwHCTygkq1D7nQLbvvxzvGZe9TsZ
	J7MnmG0sMq7YP/7Pw5Tp7a/J71fsSC+CJeDScXl0N0A8Dj2sB7b6Vd5VOygCFcl1L60QGyK
X-Google-Smtp-Source: AGHT+IHfUrUKD19ckbGWZSAxbod4Fwp6AvvMqNG6Dkq6zkY1uEsGnMGxwAgZfueRaa6lpWJgnlQp+Q==
X-Received: by 2002:a05:600c:350b:b0:431:58cd:b259 with SMTP id 5b1f17b1804b1-438914671fdmr193243775e9.31.1737484190523;
        Tue, 21 Jan 2025 10:29:50 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438904621cdsm187778135e9.27.2025.01.21.10.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 10:29:50 -0800 (PST)
Date: Tue, 21 Jan 2025 19:29:48 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: syzbot <syzbot+622acb507894a48b2ce9@syzkaller.appspotmail.com>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	cgroups@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net, elic@nvidia.com, 
	gregkh@linuxfoundation.org, hannes@cmpxchg.org, hawk@kernel.org, jasowang@redhat.com, 
	jirislaby@kernel.org, john.fastabend@gmail.com, kafai@fb.com, kpsingh@kernel.org, 
	kuba@kernel.org, len.brown@intel.com, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-serial@vger.kernel.org, mingo@redhat.com, mst@redhat.com, 
	netdev@vger.kernel.org, parav@nvidia.com, pavel@ucw.cz, rafael@kernel.org, 
	rostedt@goodmis.org, songliubraving@fb.com, syzkaller-bugs@googlegroups.com, 
	tj@kernel.org, yhs@fb.com
Subject: Re: [syzbot] [cgroups?] possible deadlock in
 console_lock_spinning_enable (5)
Message-ID: <6pdxz7oqr6442cczbec7n3cqtldrrpfsdk7ynqjguiqp6d5ucv@sibkx2lfldvu>
References: <0000000000001e66f5061fe3b883@google.com>
 <678a4e3b.050a0220.303755.0005.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="flx2psaakqlkzlmd"
Content-Disposition: inline
In-Reply-To: <678a4e3b.050a0220.303755.0005.GAE@google.com>


--flx2psaakqlkzlmd
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [syzbot] [cgroups?] possible deadlock in
 console_lock_spinning_enable (5)
MIME-Version: 1.0

On Fri, Jan 17, 2025 at 04:34:03AM -0800, syzbot <syzbot+622acb507894a48b2c=
e9@syzkaller.appspotmail.com> wrote:
> syzbot has bisected this issue to:
>=20
> commit bc0d90ee021f1baecd6aaa010d787eb373aa74dd
> Author: Parav Pandit <parav@nvidia.com>
> Date:   Tue Jan 5 10:32:02 2021 +0000
>=20
>     vdpa: Enable user to query vdpa device info
>=20
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D1440c2b058=
0000

syzbot got this somehow wrong, it started with the lockdep bug but then
switched to a different
| crash: BUG: unable to handle kernel paging request in bpf_trace_run3
so the bisecting session yielded (I believe) random commit, didn't it?

(The lockdep appears valid, with PSI enabled and the fault injection at
unfortunate place (with BPF'd tracepoint).)

Michal

--flx2psaakqlkzlmd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ4/nmgAKCRAt3Wney77B
SfWDAQD9atuzOG3FHcpa9TZop/UV7vy3rJ7Nt2Jbeo9pTOreKgEAoQlnyi+4Metp
9vIjKtqdXgf9fmKryAgGyrYpKRkNAws=
=bsM8
-----END PGP SIGNATURE-----

--flx2psaakqlkzlmd--

