Return-Path: <linux-pm+bounces-41564-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CPsPH7/keGlftwEAu9opvQ
	(envelope-from <linux-pm+bounces-41564-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 17:15:59 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4964597918
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 17:15:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5455A3010603
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 16:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 580DA3612E7;
	Tue, 27 Jan 2026 16:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YPvi+p4q"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3361434F476
	for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2026 16:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769530535; cv=none; b=OI78uqspc0Cexwatl1GDvv8cAkxjRKCxGYRG/zzpsU0vq92QZe7U0rFd3qp5xMOLqM6KFX1KfqcbGrMW9XxUV6MpTElrs5+qmJ/8mWE1y/euYFtLKfP1ZY3wYPFfXmOFwanBr5QtOaMQg1Bpu0YIm7tu1ER9UQ/5k05EF2VJXk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769530535; c=relaxed/simple;
	bh=XzumbK+bcu3fqR36UKRZRGrtN/og5725vQ0Oh0QLSOU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RMjG3Db+6QCRIajyO2PEUuYC5b7V/8JEybTNfmAxr9YESScaALITyKET3ac2/37PdRHByiM32w3ClwYzQXMcBGsyCGL2ZlEsxJBdWwBSo6sY+wHfT5b1qn2s+8eueyKybcH4+902DA1XMI2OwF8Hh9N1ui5AAfDq2LndMH4JPVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YPvi+p4q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA94BC2BCB3
	for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2026 16:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769530534;
	bh=XzumbK+bcu3fqR36UKRZRGrtN/og5725vQ0Oh0QLSOU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YPvi+p4q6eHCIbJZThFSYH24yB5E0aI5h0/s7oMPj3WnvsJJtb9wnBjPJGTQrgBV0
	 bv68tQ1DtOe+q7qNFG/JQ1Cpr77hvwJZHnab8A05oUP4U6MmoS1t5NPN5qx3nwU/Fy
	 /bdhR979QCfFMAL14fLnK9MiiF8BuUPxqoRR/PHK73AANJtoldl/lr9cCLCeTLxgTy
	 ZaQg4PrYYd+Iolv8m2h/uaJ89tS+RlnZuMqUK4cF3l2YEHoBFL02t/49nhkqP/U3fG
	 3aWb1Ur0w7ZWjicQ25MU8IlPOjHxaMiEMx498AKXI+fJ/ph6LHnqyERpLdHjVAU5zg
	 bMNk1CzKLOUZg==
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-40423f8c5faso3346857fac.0
        for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2026 08:15:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW192GaY3++tLmosUaCKfcZOL16k5KbPwG4y5oXQvInuQAUSPjaVij9cMzcikBzVL0X6UI84ROKLw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyhBtwlagz9/f6lxHyuGO8CTglfG/p8hvWbqk+/RmWQQIWP23B3
	4M3Y1uftncj8ZBkjhJIZXeUW90Ce8Df/rhlnQl/vGVgDTHqP+nrCik/sUnSs4lyxAczNU4F1fSY
	hbKaqXtFlp4qpbLauHG9QFgqz+HfZyn4=
X-Received: by 2002:a4a:e1b4:0:b0:662:f543:5d3b with SMTP id
 006d021491bc7-662f54363afmr525037eaf.81.1769530533808; Tue, 27 Jan 2026
 08:15:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260124012133.2451708-1-wusamuel@google.com> <20260124012133.2451708-2-wusamuel@google.com>
In-Reply-To: <20260124012133.2451708-2-wusamuel@google.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 27 Jan 2026 17:15:22 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jWCdEVgQxOAkek4qqVHMx3Xx4_W3ov9bvdJP=0acX=Yw@mail.gmail.com>
X-Gm-Features: AZwV_QhA2857ovslXCLqyKjCKicGjIcJQZ5bsHbrqIJ3xN0iiE30rvHqvTrjTj8
Message-ID: <CAJZ5v0jWCdEVgQxOAkek4qqVHMx3Xx4_W3ov9bvdJP=0acX=Yw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/3] PM: wakeup: Handle empty list in wakeup_sources_walk
To: Samuel Wu <wusamuel@google.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-41564-lists,linux-pm=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,linuxfoundation.org,iogearbox.net,linux.dev,gmail.com,fomichev.me,google.com,android.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 4964597918
X-Rspamd-Action: no action

On Sat, Jan 24, 2026 at 2:22=E2=80=AFAM Samuel Wu <wusamuel@google.com> wro=
te:
>
> In the case of an empty wakeup_sources list, wakeup_sources_walk_start()
> will return an invalid but non-NULL address. This also affects wrappers
> of the aforementioned function, like for_each_wakeup_source().
>
> This patch updates wakeup_sources_walk_start() to return NULL in case of
> an empty list.
>
> Signed-off-by: Samuel Wu <wusamuel@google.com>
> ---
>  drivers/base/power/wakeup.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
> index 1e1a0e7eeac5..e69033d16fba 100644
> --- a/drivers/base/power/wakeup.c
> +++ b/drivers/base/power/wakeup.c
> @@ -275,9 +275,7 @@ EXPORT_SYMBOL_GPL(wakeup_sources_read_unlock);
>   */
>  struct wakeup_source *wakeup_sources_walk_start(void)
>  {
> -       struct list_head *ws_head =3D &wakeup_sources;
> -
> -       return list_entry_rcu(ws_head->next, struct wakeup_source, entry)=
;
> +       return list_first_or_null_rcu(&wakeup_sources, struct wakeup_sour=
ce, entry);
>  }
>  EXPORT_SYMBOL_GPL(wakeup_sources_walk_start);
>
> --

This looks like a fix for the for_each_wakeup_source() users.

I can apply it without the next two patches.

