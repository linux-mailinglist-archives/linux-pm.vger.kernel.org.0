Return-Path: <linux-pm+bounces-41928-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0HfyGlAPgWnmDwMAu9opvQ
	(envelope-from <linux-pm+bounces-41928-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 02 Feb 2026 21:55:44 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1652DD1575
	for <lists+linux-pm@lfdr.de>; Mon, 02 Feb 2026 21:55:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 686613004F34
	for <lists+linux-pm@lfdr.de>; Mon,  2 Feb 2026 20:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 804162C0281;
	Mon,  2 Feb 2026 20:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A3Ln8NAw"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8DF30F7EF
	for <linux-pm@vger.kernel.org>; Mon,  2 Feb 2026 20:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770065740; cv=none; b=knZ8+cIo9B8uMHJg3aDaYWt+SxVHcjGEOp57vVgFWX2zJkQQ7Oj1fNd/y7SlbqugRwr/q1aFRr/K77ZoGXVXLQ2WqKRvCyEuro6QxO2eBFoWJFLR5EAPQtCzpgrCXIDMWX9YqoFM0cdyrsZl+puzTTDc89OlAiU4b1vaeSItcRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770065740; c=relaxed/simple;
	bh=1aUjeloTGNxsBospztyc8sZYBvlLW5N8QNDPtH+e3bs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oMbn7rYPP9xgkP/qOMsEAmpfZaNEX9TmlNLo1Fd8mb6XRJDO3RodUwNqSmEzlMTRbz/Lo8nSr/ov4crv1pHzrh66eKVNFvd92kq36czV0j+niZHyMy/2TU4+mOYi7WlBTRaTqioCEa3yoART8UXJuCITub4z43L+EqJoCm/9r0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A3Ln8NAw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD3ECC19421
	for <linux-pm@vger.kernel.org>; Mon,  2 Feb 2026 20:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770065739;
	bh=1aUjeloTGNxsBospztyc8sZYBvlLW5N8QNDPtH+e3bs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=A3Ln8NAwY+nNCr5a2s2FNrfYaVpAoCPgouUPX1tChVEAoWxmY06QJZ7NCUsUSNm9T
	 wm2OquxM7eay2su/ifcxvb+lwblIy0bNdbLuxzvJ6CZt/4qnNv/Dzq2aKAdkx32vj2
	 bhE5oRKgMcexbLzVJqml3ViAcMQy9i8kb6UfjmNUc0O97I+xLM9AxFPmohar9/fbwu
	 +4v4Fo4LdKdJrzKPrxI3reXB2a5oCeXu+WsghjvGpU0x3Q1yfVSWIgJaIvdzRpoNm1
	 hSOzLjsx0N6yofLu5hBa2uYetKML5actHAXRSgQR49Y2Z5VUsCOk/L90wU5vDY5V/K
	 pMOw47CnM+Y5w==
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-663097987f6so2608412eaf.0
        for <linux-pm@vger.kernel.org>; Mon, 02 Feb 2026 12:55:39 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVNGtSvESE+pgTQn8jkuEz7aAvWjuhXbGtwy1bFiUh8Fvh2VaTZ2DUQgPLmGHgNdE+Obw+rw502KQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0Dg3HcwJietrL/Y8YaAwNTlLkqYbJIm884BmioGARnXLU+KKl
	TJnVEQ+ov8+YZGISoMtEbkaQMdx5VApQNKXTSXUKMmwILV1UhYsq3KZekpC33bHWSoBD0bB7k9d
	BP5FIY68BE9XeFBvHYYHFaioGEHAJ5H4=
X-Received: by 2002:a4a:e1da:0:b0:663:11eb:1176 with SMTP id
 006d021491bc7-66311eb1761mr4002461eaf.32.1770065738930; Mon, 02 Feb 2026
 12:55:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260131101254.56423-1-hanguidong02@gmail.com>
In-Reply-To: <20260131101254.56423-1-hanguidong02@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 2 Feb 2026 21:55:28 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0j=_57sMMQ9vunxGUAo6FS928SnX6nE8=8t4Kz+R2R3mA@mail.gmail.com>
X-Gm-Features: AZwV_QjTfSqPqOL5gZJxISow0wXoG1Hrto020jhqIMfigqaOSCvgeer-EKSQ06I
Message-ID: <CAJZ5v0j=_57sMMQ9vunxGUAo6FS928SnX6nE8=8t4Kz+R2R3mA@mail.gmail.com>
Subject: Re: [PATCH] PM: sleep: wakeirq: harden dev_pm_clear_wake_irq()
 against races
To: Gui-Dong Han <hanguidong02@gmail.com>
Cc: rafael@kernel.org, pavel@kernel.org, lenb@kernel.org, 
	gregkh@linuxfoundation.org, dakr@kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, baijiaju1990@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,linuxfoundation.org,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-41928-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-pm@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1652DD1575
X-Rspamd-Action: no action

On Sat, Jan 31, 2026 at 11:13=E2=80=AFAM Gui-Dong Han <hanguidong02@gmail.c=
om> wrote:
>
> dev_pm_clear_wake_irq() currently uses a dangerous pattern where
> dev->power.wakeirq is read and checked for NULL outside the lock. If two
> callers invoke this function concurrently, both might see a valid
> pointer and proceed. This could result in a double-free when the second
> caller acquires the lock and tries to release the same object.
>
> Address this by using double-checked locking. This retains the
> performance benefit of avoiding the lock when dev->power.wakeirq is
> NULL, consistent with the original logic, but adds a necessary re-check
> after acquiring dev->power.lock. Additionally, use READ_ONCE() and
> WRITE_ONCE() to annotate the shared variable accesses to avoid data races
> as defined by the kernel documentation.
>
> Based on a quick scan of current users, I did not find an actual bug as
> drivers seem to rely on their own synchronization. However, since
> asynchronous usage patterns exist (e.g., in
> drivers/net/wireless/ti/wlcore), I believe a race is theoretically
> possible if the API is used less carefully in the future. This change
> hardens the API to be robust against such cases.
>
> Fixes: 4990d4fe327b ("PM / Wakeirq: Add automated device wake IRQ handlin=
g")
> Signed-off-by: Gui-Dong Han <hanguidong02@gmail.com>
> ---
> While studying wakeirq, I noticed dev_pm_clear_wake_irq() handles
> sequential re-entry (via the NULL check) but may lead to a double-free
> on concurrent calls.
>
> I considered whether we should simply document that concurrent calls are
> forbidden. However, since the double-check locking pattern is
> straightforward and adds negligible performance overhead (we still skip
> the lock in the NULL case), I believe hardening the API is the better
> approach.
>
> I also noticed comments for dev_pm_enable_wake_irq_check() and friends
> appear outdated. They claim "Caller must hold &dev->power.lock" and
> limit usage to rpm_suspend/resume, yet pm_runtime_force_suspend/resume()
> now call them lockless. While this usage appears safe due to the specific
> context, it conflicts with the comments.
>
> I can submit a follow-up patch to fix this doc drift but am unsure
> whether to simply remove the restriction text or complicate it with
> exceptions. Guidance is welcome.
> ---
>  drivers/base/power/wakeirq.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/base/power/wakeirq.c b/drivers/base/power/wakeirq.c
> index 8aa28c08b289..acb520626195 100644
> --- a/drivers/base/power/wakeirq.c
> +++ b/drivers/base/power/wakeirq.c
> @@ -30,7 +30,7 @@ static int dev_pm_attach_wake_irq(struct device *dev, s=
truct wake_irq *wirq)
>                 return -EEXIST;
>         }
>
> -       dev->power.wakeirq =3D wirq;
> +       WRITE_ONCE(dev->power.wakeirq, wirq);
>         device_wakeup_attach_irq(dev, wirq);
>
>         spin_unlock_irqrestore(&dev->power.lock, flags);
> @@ -83,15 +83,21 @@ EXPORT_SYMBOL_GPL(dev_pm_set_wake_irq);
>   */
>  void dev_pm_clear_wake_irq(struct device *dev)
>  {
> -       struct wake_irq *wirq =3D dev->power.wakeirq;
> +       struct wake_irq *wirq =3D READ_ONCE(dev->power.wakeirq);

Just remove the dev->power.wakeirq access from here.

>         unsigned long flags;
>
>         if (!wirq)
>                 return;

Along with the check above because it is still racy.

>         spin_lock_irqsave(&dev->power.lock, flags);
> +       wirq =3D dev->power.wakeirq;
> +       if (!wirq) {
> +               spin_unlock_irqrestore(&dev->power.lock, flags);
> +               return;
> +       }

And just do the above.

WRITE_ONCE() will not be needed then.

> +
>         device_wakeup_detach_irq(dev);
> -       dev->power.wakeirq =3D NULL;
> +       WRITE_ONCE(dev->power.wakeirq, NULL);
>         spin_unlock_irqrestore(&dev->power.lock, flags);
>
>         if (wirq->status & WAKE_IRQ_DEDICATED_ALLOCATED) {
> --

