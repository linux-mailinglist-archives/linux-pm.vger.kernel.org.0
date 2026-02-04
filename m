Return-Path: <linux-pm+bounces-42072-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4DghFpw4g2ngjwMAu9opvQ
	(envelope-from <linux-pm+bounces-42072-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 04 Feb 2026 13:16:28 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AB9D9E5B01
	for <lists+linux-pm@lfdr.de>; Wed, 04 Feb 2026 13:16:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D727300D323
	for <lists+linux-pm@lfdr.de>; Wed,  4 Feb 2026 12:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E6C3ED12E;
	Wed,  4 Feb 2026 12:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W7bbEAPk"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E876C3ED117
	for <linux-pm@vger.kernel.org>; Wed,  4 Feb 2026 12:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770207083; cv=none; b=ucVBCdiZtaDBHZXu6sLOx0fHK+yDHaLIz+o0NyKRUHXvp/vSJpXwBPwFLD6KbZwkG2u0Mz4gpaXaHWGskcGCjSJWhGMdVX/ujYW3ZLHRQ77MuADZ2N+z4AyZZAjZwqXEbPpIp54vniXNGMAurYoNy7EtQHYZmw4UkH8CxbWGpi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770207083; c=relaxed/simple;
	bh=Kz6L9l8Ma46Pgn1fGupZuUgdb9x+v6rfWYvYciyHSGE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fyXGdLDy6p8S3Nv/POpbxU9gfXmUQ/qSckjij/R61qr6rVIJBo/7Pa6gyqUZXY+NYlFAOxXaSXH20ig61EyQE4pKlbDoFauCcyDT6QTNtLqHt+3e/UaaxW8gYNedv0RjcYlHA7wKt3VJ+DsTqLu4zT/WU2GiY4lNkegw9b5c65w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W7bbEAPk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 904BCC2BC86
	for <linux-pm@vger.kernel.org>; Wed,  4 Feb 2026 12:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770207082;
	bh=Kz6L9l8Ma46Pgn1fGupZuUgdb9x+v6rfWYvYciyHSGE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=W7bbEAPkM+Yd2zIRMoGo/NKsTDCfkDDWb8SNAm88owAPR+aFskCSij+QnQwM64Gx6
	 0oxF8ECINhl6+k1XIQLPNMPndbFzr7ESv6YiVOvgU0QovGrn9KKhVOVCUbEPPRCmzY
	 xDFarA2qJ1FxbPbRFzxcmNrC0Q5zeoE5FmVdrgd0V4gBQPhM8Rq7izl/z2ia42ScXk
	 1j9P+9Ij9Tftd2D2uhtHaIiWxJlyWIu/lgsfTljgocN0dBg81QxYWuoyNgWtT99Kv0
	 rKq0lnJ2VySRRfkWx1UOoWDrnU0yuhMInUVpRpidBjo5yRCbn7ueABWsgvzWEH/tjV
	 guBJ0PUwcQmgw==
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-4043b27ddeaso3845193fac.1
        for <linux-pm@vger.kernel.org>; Wed, 04 Feb 2026 04:11:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWQf17eMya/0oWdRCjNEBgi/qkT0nLTu46pWUzgwNF6vsAuUnK/50t9DGWd9NTQH+XVVj+zJnuVJw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxqvxqnaRRKmeyn0W0kScjoScEgS3k0xFwCYJmAF/WZ3LS7SD5t
	COmAiSE0eqC6LxDrSvMgsd82GFuwhO317PRFqgC1Wd9KDdNH+4KGQmeyZBwIH/PbUgG4Xadz0Yn
	EL5/ZvK799BjUyoNl0q1+ciDjs0JBYlI=
X-Received: by 2002:a05:6820:1516:b0:662:c5c5:4fac with SMTP id
 006d021491bc7-66a23eefb2amr1255993eaf.79.1770207081637; Wed, 04 Feb 2026
 04:11:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12852589.O9o76ZdvQC@rafael.j.wysocki> <CAB8ipk_VX2VPm706Jwa1=8NSA7_btWL2ieXmBgHr2JcULEP76g@mail.gmail.com>
In-Reply-To: <CAB8ipk_VX2VPm706Jwa1=8NSA7_btWL2ieXmBgHr2JcULEP76g@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 4 Feb 2026 13:11:09 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iScM-1nTXuex3rhhWOhe+NcVj1X-ObKY=c5TnZk_eB7A@mail.gmail.com>
X-Gm-Features: AZwV_QhTHE8XfOXa95M3ho25PeSXLnb3dw53m4EaIsWJrvX_DMPtR8c7d-icIuA
Message-ID: <CAJZ5v0iScM-1nTXuex3rhhWOhe+NcVj1X-ObKY=c5TnZk_eB7A@mail.gmail.com>
Subject: Re: [PATCH v1] PM: sleep: core: Clear device async state upfront
 during suspend
To: Xuewen Yan <xuewen.yan94@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Saravana Kannan <saravanak@google.com>, Xuewen Yan <xuewen.yan@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-42072-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_ALL(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-pm@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AB9D9E5B01
X-Rspamd-Action: no action

On Wed, Feb 4, 2026 at 3:57=E2=80=AFAM Xuewen Yan <xuewen.yan94@gmail.com> =
wrote:
>
> Hi Rafael,
>
> On Wed, Feb 4, 2026 at 4:38=E2=80=AFAM Rafael J. Wysocki <rafael@kernel.o=
rg> wrote:
> >
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > In all of the system suspend transition phases, async state of all
> > devices needs to be cleared before starting async processing for any of
> > them because the latter may race with power.work_in_progress updates fo=
r
> > the device's parent or suppliers and if it touches bit fields from the
> > same group (for example, power.must_resume or power.wakeup_path), bit
> > field corruption is possible.
> >
> > Rearrange the code accordingly.
>
> Could we use the following patch:

Yes, we can make this change.

> diff --git a/include/linux/pm.h b/include/linux/pm.h
> index 98a899858ece..afcaaa37a812 100644
> --- a/include/linux/pm.h
> +++ b/include/linux/pm.h
> @@ -681,10 +681,10 @@ struct dev_pm_info {
>         struct list_head        entry;
>         struct completion       completion;
>         struct wakeup_source    *wakeup;
> +       bool                    work_in_progress;       /* Owned by
> the PM core */
>         bool                    wakeup_path:1;
>         bool                    syscore:1;
>         bool                    no_pm_callbacks:1;      /* Owned by
> the PM core */
> -       bool                    work_in_progress:1;     /* Owned by
> the PM core */
>         bool                    smart_suspend:1;        /* Owned by
> the PM core */
>         bool                    must_resume:1;          /* Owned by
> the PM core */
>         bool                    may_skip_resume:1;      /* Set by subsyst=
ems */
>
> Due to byte alignment, the size of struct dev_pm_info remains unchanged,

I had considered making it, but I thought it would cause struct
dev_pm_info to grow.

> while also preventing concurrency issues between work_in_progress and
> other variables. Additionally, with this modification, there=E2=80=99s no=
 need to traverse the
> device list twice.

Sure.

I'll just commit the above change with your sign-off, please let me
know if there are any issues with that.

Thanks!

