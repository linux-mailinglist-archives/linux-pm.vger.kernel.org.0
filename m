Return-Path: <linux-pm+bounces-41999-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJG9JwxagmlhSwMAu9opvQ
	(envelope-from <linux-pm+bounces-41999-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 03 Feb 2026 21:26:52 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1424DE796
	for <lists+linux-pm@lfdr.de>; Tue, 03 Feb 2026 21:26:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7BA1C301456D
	for <lists+linux-pm@lfdr.de>; Tue,  3 Feb 2026 20:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC72E36D504;
	Tue,  3 Feb 2026 20:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lN0OqDEk"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9EE7368263
	for <linux-pm@vger.kernel.org>; Tue,  3 Feb 2026 20:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770150409; cv=none; b=SGGssADLWTR5nv56rFox8ZfVOZbpKLDkUsZdMii51bedv11SkVMtgo62EcKsebTTsagCSfmuNcDlTHY6QrB6kGmsjQtjvieHtgJxdaeDr4ngC5QIEGIlQC9633x8TW7ROj3rT/OSHtHl5hYwhVNjqHu+V2xaDpZnXZTVsiJsIXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770150409; c=relaxed/simple;
	bh=y073T1yIgUAWwJK20GIKSzqOOEqMEVdklnBJmPrdlRM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MEZ2IiAn4d8glNzARtLtapBnikkMg9HMyIaRDfcunMfL3J5OsPhTPru3gjdC+6EjPwwfIBcpH773Mneb/4TSWwrt6XIbA+5jMUxkj1OiujPPgZzEGlYojl3Wv2WTjJGqzgvbCPm/cjtrQxIL0zqhFWTWkaWsIfj3RC3yVZobr1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lN0OqDEk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65CEEC19425
	for <linux-pm@vger.kernel.org>; Tue,  3 Feb 2026 20:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770150409;
	bh=y073T1yIgUAWwJK20GIKSzqOOEqMEVdklnBJmPrdlRM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lN0OqDEkRyjkTPhtzU64Bxw2HBPlVJdNm467MWwQFQDzhot8dXL1mPCcTp0+U0Dja
	 xBjqRUf1avR304k3YgxqRqmWcVg7BzbID1mo88v/YjXz1ctqEADuzuwe8LQFHQSQ3N
	 AZ4XaYDm+ui1t03O4zQFpDvBEpCYnv4Ex6VC84plVqoycOULPOmSbNs8x5m6yCRHaU
	 WKPc5lHxAknnByCVpSYtSba86pfyDAZ8KntQTjvWbKyNK9clfb2L5lbr5W4knNxOC8
	 0+8w9uR/KJOuouK0/QB5ncVNY4R4sWXcBpZrEYVH01F5wTAmZj6RF2+dDzH9aHmpbu
	 N/U+eUEQbwmIg==
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-4042f55de3aso179514fac.1
        for <linux-pm@vger.kernel.org>; Tue, 03 Feb 2026 12:26:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUfYBG6j9y4Q3Iok0fE0nHIXheRC13gJIEKUk2ytbwLJEWZg+nRwS+I2xriHmwNaOVd36IdyoJ3DQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyWs7OtIjRaemjVXePYy7+hBCd/dB1B1OUaJnr20fAR1dVVazMv
	V8xWA6u2+GRwO6dcQwain3YUUlghlAD3pu5QegpHVxCHA+595nHowuJaT/w3IGtUtAmA6AlTRTK
	b5LY3B5SzOg4aj1WBEv8bJln1tLBNY7A=
X-Received: by 2002:a05:6820:3106:b0:662:f763:c530 with SMTP id
 006d021491bc7-66a32ab4247mr280342eaf.3.1770150408468; Tue, 03 Feb 2026
 12:26:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260203031943.1924-1-hanguidong02@gmail.com> <cf5945f4-83b5-4fee-8f37-bdc8048eacab@web.de>
In-Reply-To: <cf5945f4-83b5-4fee-8f37-bdc8048eacab@web.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 3 Feb 2026 21:26:36 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jGuMrwsuR-8XbmD+WXwdK1V4t9G6VSS7KPveCJ1N2TCA@mail.gmail.com>
X-Gm-Features: AZwV_Qgx45p71_0z_5XsAXuhmmmpkmUinKiqFuBpbbBS1EIRB3XM9tgx8qluD44
Message-ID: <CAJZ5v0jGuMrwsuR-8XbmD+WXwdK1V4t9G6VSS7KPveCJ1N2TCA@mail.gmail.com>
Subject: Re: [PATCH v2] PM: sleep: wakeirq: harden dev_pm_clear_wake_irq()
 against races
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Gui-Dong Han <hanguidong02@gmail.com>, linux-pm@vger.kernel.org, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Tony Lindgren <tony@atomide.com>, 
	LKML <linux-kernel@vger.kernel.org>, Jia-Ju Bai <baijiaju1990@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,kernel.org,linuxfoundation.org,atomide.com];
	TAGGED_FROM(0.00)[bounces-41999-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[web.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-pm@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bootlin.com:url]
X-Rspamd-Queue-Id: F1424DE796
X-Rspamd-Action: no action

On Tue, Feb 3, 2026 at 10:16=E2=80=AFAM Markus Elfring <Markus.Elfring@web.=
de> wrote:
>
> =E2=80=A6
> > +++ b/drivers/base/power/wakeirq.c
> > @@ -83,13 +83,16 @@ EXPORT_SYMBOL_GPL(dev_pm_set_wake_irq);
> >   */
> >  void dev_pm_clear_wake_irq(struct device *dev)
> >  {
> > -     struct wake_irq *wirq =3D dev->power.wakeirq;
> > +     struct wake_irq *wirq;
> >       unsigned long flags;
> >
> > -     if (!wirq)
> > +     spin_lock_irqsave(&dev->power.lock, flags);
> > +     wirq =3D dev->power.wakeirq;
> > +     if (!wirq) {
> > +             spin_unlock_irqrestore(&dev->power.lock, flags);
> >               return;
> > +     }
> >
> > -     spin_lock_irqsave(&dev->power.lock, flags);
> >       device_wakeup_detach_irq(dev);
> >       dev->power.wakeirq =3D NULL;
> >       spin_unlock_irqrestore(&dev->power.lock, flags);
>
> Would it become feasible to apply a scoped_guard() call?
> https://elixir.bootlin.com/linux/v6.19-rc5/source/include/linux/spinlock.=
h#L585

Yes, it would, but in a separate patch.

