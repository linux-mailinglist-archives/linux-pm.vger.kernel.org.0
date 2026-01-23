Return-Path: <linux-pm+bounces-41388-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CAHrJC3ec2nMzAAAu9opvQ
	(envelope-from <linux-pm+bounces-41388-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 23 Jan 2026 21:46:37 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FCE07AB7B
	for <lists+linux-pm@lfdr.de>; Fri, 23 Jan 2026 21:46:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 81BAF301C8A2
	for <lists+linux-pm@lfdr.de>; Fri, 23 Jan 2026 20:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7A32272E6D;
	Fri, 23 Jan 2026 20:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cm9HnZcj"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D052A1BA
	for <linux-pm@vger.kernel.org>; Fri, 23 Jan 2026 20:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769201187; cv=none; b=q8SFC66GlpC8mXRRYqH/2RgUMQEz4swEerlljENZxipwtaWov1ofmqMXi9LQnXAWcIpw1gIS9W9f9dLX2t1q8B4rChM0IIuW0pGL7Tk/f1F+WpLJA5/eKJSPNCKb8bDcHSr/7w1hi4NxsQMc7hEFyXBzoA4e2IIasP9RTcItw14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769201187; c=relaxed/simple;
	bh=7Qm/44egmQYoIl8PPXso+O2QrJvSUKYpURvUJ8k9OLw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eQZHvKbzTw/AsTBQu2/vs6MCIWYlxgdoes/Va9AMvr+P9MegoSrbPUnukM/MeVuGTcJomQEc+kWVDksF+jHEojHipNBm5RlVSw2TJQjUfFWVFVhF4bnNQ1a19BZ9LGop6Q73Jv38C1rWKZNNPyIzCBeXWhSaZ+NfA+fvSAkLz/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cm9HnZcj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29714C4CEF1
	for <linux-pm@vger.kernel.org>; Fri, 23 Jan 2026 20:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769201187;
	bh=7Qm/44egmQYoIl8PPXso+O2QrJvSUKYpURvUJ8k9OLw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=cm9HnZcj+qLk+I0qmBn2IggqCFbYPy+NyRHTIu86kDPScr4XatigyMwncIwncAFi1
	 agu/cAmkdNBS6TRldj99nUlxL+wur5A1+LE1Yf1d2Y9ob2xt8X4QQPhazN0Z79Es7I
	 NXEoLnTnbJrpRbFvXfw45IV0kZJgVyUiqFnQVlwWa1yVkK5mrixWGztD1qdM4jfn0E
	 jwZJIPIMwrHZXWSsjP1W3mRKgtYT2D0MsSrBiT6C6q+758EaMSOgU2SGPE2C+rV5xt
	 WD9AHdIqb6Zqp+O3f9xsNVqq7zhznpVMpn4LiuO7i/zK10Sw1KMS2upmWRraT+exuF
	 hG2oPKs3xhcEw==
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-662bd803aabso1851917eaf.1
        for <linux-pm@vger.kernel.org>; Fri, 23 Jan 2026 12:46:27 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVVmJsWEYRz5uyvl9DLgWQN4u+V6GZw4oQd5aBBYS8eqnijUBszxtSM6UEqCKm32StlIBEhqdCvYw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwAuHw9BvRzK5e2UaPCqK1x5wYzMcKtq/VOg6fi8dW+9PPRDd+b
	LDz0CsijwXNvrnX8WbsYoNcC8oafAtxfeZTJablA3llI0oeDx5U/gCzssBHGH4/4y+yHqtGKKsC
	ytQiqCQ/zo9Vu1WzrMwFHsXfgdJEqEhA=
X-Received: by 2002:a05:6820:190b:b0:660:f3ed:930b with SMTP id
 006d021491bc7-662caf75425mr1809636eaf.22.1769201186308; Fri, 23 Jan 2026
 12:46:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2257365.irdbgypaU6@rafael.j.wysocki> <3033265.e9J7NaK4W3@rafael.j.wysocki>
 <0d066ce0-b0bf-43f2-a1c4-56e5ac47cce1@arm.com>
In-Reply-To: <0d066ce0-b0bf-43f2-a1c4-56e5ac47cce1@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 23 Jan 2026 21:46:14 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iVPDY5wvz0KY7aHJXnX=7ZCMbqi1G5mWTYdYsi2xf9+g@mail.gmail.com>
X-Gm-Features: AZwV_QgNbMjVZuemlB_b2qwMUgsKbo1GxdsCJcehXHxOXN7CI63yJ2lORwAJVr0
Message-ID: <CAJZ5v0iVPDY5wvz0KY7aHJXnX=7ZCMbqi1G5mWTYdYsi2xf9+g@mail.gmail.com>
Subject: Re: [PATCH v1 1/5] cpuidle: governors: teo: Avoid selecting states
 with zero-size bins
To: Christian Loehle <christian.loehle@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Doug Smythies <dsmythies@telus.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-41388-lists,linux-pm=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-pm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pm];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Queue-Id: 2FCE07AB7B
X-Rspamd-Action: no action

On Wed, Jan 21, 2026 at 2:10=E2=80=AFPM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> On 1/14/26 19:44, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > If the last two enabled idle states have the same target residency whic=
h
> > is at least equal to TICK_NSET, teo may select the next-to-last one eve=
n
>
> s/TICK_NSET/TICK_NSEC

Yup, thanks!

> > though the size of that state's bin is 0, which is confusing.
> >
> > Prevent that from happening by adding a target residency check to the
> > relevant code path.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/cpuidle/governors/teo.c |   10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > --- a/drivers/cpuidle/governors/teo.c
> > +++ b/drivers/cpuidle/governors/teo.c
> > @@ -388,6 +388,15 @@ static int teo_select(struct cpuidle_dri
> >                       while (min_idx < idx &&
> >                              drv->states[min_idx].target_residency_ns <=
 TICK_NSEC)
> >                               min_idx++;
> > +
> > +                     /*
> > +                      * Avoid selecting a state with a lower index, bu=
t with
> > +                      * the same target residency as the current candi=
date
> > +                      * one.
> > +                      */
> > +                     if (drv->states[min_idx].target_residency_ns =3D=
=3D
> > +                                     drv->states[idx].target_residency=
_ns)
>
> We need to check that min_idx isn't disabled though, otherwise we now ski=
p a
> potential (enabled) idx=3D=3D1 if min_idx=3D=3D2 and min_idx is disabled.

Not really because idx is the current candidate state and it is
enabled.  We'll use idx if this check is true, not min_idx.

So I think I only need to fix the typo above.

> Other than that LGTM and with that check and the nit above:
>
> Reviewed-by: Christian Loehle <christian.loehle@arm.com>

Thanks!

> > +                             goto constraint;
> >               }
> >
> >               /*
> > @@ -410,6 +419,7 @@ static int teo_select(struct cpuidle_dri
> >               }
> >       }
> >
> > +constraint:
> >       /*
> >        * If there is a latency constraint, it may be necessary to selec=
t an
> >        * idle state shallower than the current candidate one.
> >
> >
> >
>

