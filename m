Return-Path: <linux-pm+bounces-43862-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QH8qIFUdq2mPaAEAu9opvQ
	(envelope-from <linux-pm+bounces-43862-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 19:30:45 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C08AD226AD7
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 19:30:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 09A1C303A10D
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2026 18:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA7B036D4F7;
	Fri,  6 Mar 2026 18:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oVUHl5SH"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5455D36F413
	for <linux-pm@vger.kernel.org>; Fri,  6 Mar 2026 18:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772821841; cv=none; b=YmrekvuoLmBBuG1yRVX0DP/VVjqpwBS+edOBChRWsryI4YtwfTgBYJVMGRqSdjTY5MAC+os3cFyOu7FqejFBf8riFdMwsbuOMw9NpYFCnZWTykcnLXo54eJqku1k0sPExZ9jAERJ3hW8lAEdcp2hyKvV/GGNR0E1v0+AfhEX8BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772821841; c=relaxed/simple;
	bh=LTq3EwkT8e7IlnARHCTcb6JovAHpUfs6XJuyaAc9yyc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TtJpFyHwZwnapnR63D2+AtG5a06MVJwYFpNazteDL4V1JaqUfwWw5TbN2T8IiwykJFbaazF35HInxGNyvyh3RYxUQVsUTcbuHS6Ooqd26FlhWdw0Xf1pxpjH2RRi7lrh7UWq0O/Nlw79LD540lwgI6Emj+z66WhxkOFk1D4MfEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oVUHl5SH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C936DC19425
	for <linux-pm@vger.kernel.org>; Fri,  6 Mar 2026 18:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772821840;
	bh=LTq3EwkT8e7IlnARHCTcb6JovAHpUfs6XJuyaAc9yyc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=oVUHl5SH8ujn6fOBZ1ghCHe/pij6+Ge4jxHJNwsqj29U47fQEToNtdkwypISU//Hh
	 uvn6nxxQB//9qnzTXHoXwnzhz1LQcfAjdDNwQvOS6U6I4wzhxZpBaGhhFg32bVnYgW
	 TfJlMoM0I0J8hAC+oy0odPMhgwEN08qYUlpcZ5uwAsk1NMqeyJHpLWo4wn5mxoHadw
	 QGclpSScO2wOWhKtZoX080JFyGaYcsZpzp2gIzrWVskqKWSoYGYdo/sYReztEITUFV
	 0GeJSSCmtPGRNIxYBeSyQSLhE2GSvRhn+vu7Iok255yzKoTYmcXsasFf5Aj2jPmUvc
	 sC+vD3vJwj1SQ==
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-662f9aeb782so7112599eaf.3
        for <linux-pm@vger.kernel.org>; Fri, 06 Mar 2026 10:30:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUZSjTsyA7huQ8jH1z/HX2NCpGX//IKqUHgL07Pp5VA5XhDIxPwZ/pU0Zyt+2oMwIjqWqU7iv9H2w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzMSQVSW9XBEiyzyVVXmyj44hAtsV4+5VR2A6hb/npnQ8rEFxNm
	pjOE26qdK/G6SF8zqt5qRUoHPQHb1pvj3mlNyFtgbzHzv1RVDvPEnvshWilkbV64j/v4nibMgxQ
	sQ9IryRKrjR1Vifb9aEK1Dc+fFXVXPWQ=
X-Received: by 2002:a05:6820:2224:b0:678:f430:3556 with SMTP id
 006d021491bc7-67b9bd78839mr1791696eaf.73.1772821839948; Fri, 06 Mar 2026
 10:30:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260301012246.66404-1-neelb2403@gmail.com>
In-Reply-To: <20260301012246.66404-1-neelb2403@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 6 Mar 2026 19:30:28 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0ivbdcbO9W-tPrjoU0e9oMWO9aXiRbbA=Jx6x-a31nd9Q@mail.gmail.com>
X-Gm-Features: AaiRm52FqnjJXUpEuJkiif9iw-YA3io_JnIXmIY3gC4l9mrSWyHIxIN6_ibmSxQ
Message-ID: <CAJZ5v0ivbdcbO9W-tPrjoU0e9oMWO9aXiRbbA=Jx6x-a31nd9Q@mail.gmail.com>
Subject: Re: [PATCH] PM: runtime: add system sleep callbacks to EXPORT_*_RUNTIME_DEV_PM_OPS()
To: Neel Bullywon <neelb2403@gmail.com>
Cc: rafael@kernel.org, jic23@kernel.org, paul@crapouillou.net, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: C08AD226AD7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43862-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.957];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Sun, Mar 1, 2026 at 2:22=E2=80=AFAM Neel Bullywon <neelb2403@gmail.com> =
wrote:
>
> DEFINE_RUNTIME_DEV_PM_OPS() sets pm_runtime_force_suspend() and
> pm_runtime_force_resume() as system sleep callbacks via
> _DEFINE_DEV_PM_OPS(),

Isn't that a mistake?

I'm not actually sure if it would work for everybody.  Stuff like USB
may want to use the exact same callbacks for runtime PM and
system-wide PM.

> but the exported variants
> (EXPORT_RUNTIME_DEV_PM_OPS, EXPORT_GPL_RUNTIME_DEV_PM_OPS,
> EXPORT_NS_RUNTIME_DEV_PM_OPS, EXPORT_NS_GPL_RUNTIME_DEV_PM_OPS)
> only set RUNTIME_PM_OPS() and omit SYSTEM_SLEEP_PM_OPS(). This
> means drivers using the export macros do not get system sleep
> support, contrary to what the documentation suggests.
>
> Add SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> pm_runtime_force_resume) to all four export variants to match the
> behavior of DEFINE_RUNTIME_DEV_PM_OPS().
>
> All current users of these macros are IIO drivers (bme680, bmp280,
> kxsd9, mpl115, bmi088-accel) and none implement custom system sleep
> callbacks, so this change is safe for all existing callers.

So maybe let IIO have their own set of macros?

> Suggested-by: Jonathan Cameron <jic23@kernel.org>
> Suggested-by: Paul Cercueil <paul@crapouillou.net>
> Signed-off-by: Neel Bullywon <neelb2403@gmail.com>
> ---
>  include/linux/pm_runtime.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
> index 41037c513f06..c6a6a0569b11 100644
> --- a/include/linux/pm_runtime.h
> +++ b/include/linux/pm_runtime.h
> @@ -42,18 +42,26 @@
>
>  #define EXPORT_RUNTIME_DEV_PM_OPS(name, suspend_fn, resume_fn, idle_fn) =
\
>         EXPORT_DEV_PM_OPS(name) =3D { \
> +               SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, \
> +                                   pm_runtime_force_resume) \
>                 RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn) \
>         }
>  #define EXPORT_GPL_RUNTIME_DEV_PM_OPS(name, suspend_fn, resume_fn, idle_=
fn) \
>         EXPORT_GPL_DEV_PM_OPS(name) =3D { \
> +               SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, \
> +                                   pm_runtime_force_resume) \
>                 RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn) \
>         }
>  #define EXPORT_NS_RUNTIME_DEV_PM_OPS(name, suspend_fn, resume_fn, idle_f=
n, ns) \
>         EXPORT_NS_DEV_PM_OPS(name, ns) =3D { \
> +               SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, \
> +                                   pm_runtime_force_resume) \
>                 RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn) \
>         }
>  #define EXPORT_NS_GPL_RUNTIME_DEV_PM_OPS(name, suspend_fn, resume_fn, id=
le_fn, ns) \
>         EXPORT_NS_GPL_DEV_PM_OPS(name, ns) =3D { \
> +               SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, \
> +                                   pm_runtime_force_resume) \
>                 RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn) \
>         }
>
> --
> 2.44.0
>

