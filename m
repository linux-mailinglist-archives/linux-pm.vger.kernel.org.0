Return-Path: <linux-pm+bounces-42098-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kHc3IOZvg2lgmwMAu9opvQ
	(envelope-from <linux-pm+bounces-42098-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 04 Feb 2026 17:12:22 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB220E9FE9
	for <lists+linux-pm@lfdr.de>; Wed, 04 Feb 2026 17:12:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D92E6300D611
	for <lists+linux-pm@lfdr.de>; Wed,  4 Feb 2026 16:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED20741B379;
	Wed,  4 Feb 2026 16:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WLQExACT"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD7940B6C6
	for <linux-pm@vger.kernel.org>; Wed,  4 Feb 2026 16:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770221523; cv=none; b=FN3gn9hM7cePCcvfp7HgR3UNWtNwAyo7GFTqvXuTZymWSpoYnCXtW9C6KxznUwLXSbK3gauSZxQID9pBvZzy7AsfYSzBEz3JsKJ3byZIls5STQifn9kWHzxJv05PisfEmskn80JGVU45mS232LK/iEOWfW2/vYqUK/F0oyt4Ghk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770221523; c=relaxed/simple;
	bh=waTyZD7vjq6hEX3yATfhrM2Y46/Rbyy8rFVjeXGEtBs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N6s2SsDoI8rB7+qIQb1fSbZH+hoZOlfTWf01K8gWP0LX4EGnfg6Rvwuz7ZlUiqVkq2fQ3HCIdjIrqQtSMOB1Sm36MFrX6XMG00Ie/4iOa7k7BH1x743yFnx3WXbvWpTa5pX63HwBW8W4dLOFrOZ0P2qte08PnjJVP7ekGu2ENxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WLQExACT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6951CC4CEF7
	for <linux-pm@vger.kernel.org>; Wed,  4 Feb 2026 16:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770221523;
	bh=waTyZD7vjq6hEX3yATfhrM2Y46/Rbyy8rFVjeXGEtBs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WLQExACTOwdDmC6z+CuZT3aeMEQ6T7YRnj7fkBDhI4E/hDHPbTYQqHMt2muUXm2fl
	 FPaA12DLNXbbFQ8UCU/TaUK6vx6SJ/OTs/Uu+d/ClrIeIy2celQna5oT4funJY9f+6
	 /rqu1zQ7/7DxHZZbbKwnKxmMbxLX9gZKFcKQA0ZUETZGqUWXHRsipDwQiUTa2VB42z
	 wR3NaCUzRaSd9w7PJ/WGrXFSk+M+DOtv7KxC+b36RdHT91fxdEjUicIoQAyY0KizN4
	 BZQPGbpSerQJJyKWOLaSsst/remRIXPIrQdj6iqE40BdB5nqUIjIn9Kn1/rcVM9cjm
	 0KI5ypJEJMnKQ==
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-66a68106cc6so337767eaf.1
        for <linux-pm@vger.kernel.org>; Wed, 04 Feb 2026 08:12:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXoQgwA8yVbyKfB5uSxXazXKHvkCJtohJyadWWYJhuWq2TYmdwn3HBhEcBWTGde0346zhaGKLCH5g==@vger.kernel.org
X-Gm-Message-State: AOJu0YygEzal0Rs2Tr71IKlUVmtogmEzu8UXxQfg7DWZdJHfg/AMALXB
	LkRSnY+HcJy2BuJtmLbXbx2VCwZf1cbOML9ycvIFcDqYPCOzXRIHypeUlhLKt/DqPy4rtArpPxM
	qDmFePagzaKnTT6PPbGLglDTSSm1+H4k=
X-Received: by 2002:a05:6820:4512:b0:662:f61e:75a8 with SMTP id
 006d021491bc7-66a2342cd74mr1436818eaf.65.1770221522515; Wed, 04 Feb 2026
 08:12:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260204090431.84978-1-akaieurus@gmail.com>
In-Reply-To: <20260204090431.84978-1-akaieurus@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 4 Feb 2026 17:11:51 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0g-emZAxdTZvN0ac6zMssazKMjNNn7nuYkg4cMcCmMFqg@mail.gmail.com>
X-Gm-Features: AZwV_QgHnQc3u9p12D90ogmiwzXPFs281pyGfR14sQhSyLnpBf5hyrepPva7mpE
Message-ID: <CAJZ5v0g-emZAxdTZvN0ac6zMssazKMjNNn7nuYkg4cMcCmMFqg@mail.gmail.com>
Subject: Re: [PATCH] PM: sleep: wakeirq: remove outdated comments
To: Wang Jiayue <akaieurus@gmail.com>
Cc: rafael@kernel.org, lenb@kernel.org, pavel@kernel.org, 
	gregkh@linuxfoundation.org, dakr@kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Gui-Dong Han <hanguidong02@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,linuxfoundation.org,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-42098-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-pm@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EB220E9FE9
X-Rspamd-Action: no action

On Wed, Feb 4, 2026 at 10:04=E2=80=AFAM Wang Jiayue <akaieurus@gmail.com> w=
rote:
>
> Remove the stale documentations. The comments claiming that
> dev_pm_*wake_irq*() helpers must be called with dev->power.lock held and
> only from rpm_suspend/resume paths are no longer correct, since
> pm_runtime_force_suspend/resume() call them lockless.

Well, pm_runtime_force_suspend/resume() are kind of special.

> Reported-by: Gui-Dong Han <hanguidong02@gmail.com>
> Closes: https://lore.kernel.org/all/CAJZ5v0jN9fU9NdWqc-+F5hiSEP4JkR=3D_qc=
dGzzHtk1i5tvCDbQ@mail.gmail.com/
> Fixes: c46a0d5ae4f9 ("PM: runtime: Extend support for wakeirq for force_s=
uspend|resume")
> Signed-off-by: Wang Jiayue <akaieurus@gmail.com>
> ---
>  drivers/base/power/wakeirq.c | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/drivers/base/power/wakeirq.c b/drivers/base/power/wakeirq.c
> index 8aa28c08b289..4f57058f2148 100644
> --- a/drivers/base/power/wakeirq.c
> +++ b/drivers/base/power/wakeirq.c
> @@ -269,9 +269,6 @@ EXPORT_SYMBOL_GPL(dev_pm_set_dedicated_wake_irq_rever=
se);
>   * starts in RPM_SUSPENDED state, and the first pm_runtime_get() would
>   * otherwise try to disable already disabled wakeirq. The wake-up interr=
upt
>   * starts disabled with IRQ_NOAUTOEN set.
> - *
> - * Should be only called from rpm_suspend() and rpm_resume() path.

I think that the removed line is still applicable to some extent.

It would be better to rephrase it to also cover the
pm_runtime_force_suspend/resume() case.

This also applies to the other analogous changes below.

> - * Caller must hold &dev->power.lock to change wirq->status

This one could also be rephrased to say that either the lock needs to
be held or runtime PM needs to be disabled before calling this
function.

>   */
>  void dev_pm_enable_wake_irq_check(struct device *dev,
>                                   bool can_change_status)
> @@ -303,7 +300,6 @@ void dev_pm_enable_wake_irq_check(struct device *dev,
>   * @cond_disable: if set, also check WAKE_IRQ_DEDICATED_REVERSE
>   *
>   * Disables wake-up interrupt conditionally based on status.
> - * Should be only called from rpm_suspend() and rpm_resume() path.
>   */
>  void dev_pm_disable_wake_irq_check(struct device *dev, bool cond_disable=
)
>  {
> @@ -328,8 +324,6 @@ void dev_pm_disable_wake_irq_check(struct device *dev=
, bool cond_disable)
>   * Enable wake IRQ conditionally based on status, mainly used if want to
>   * enable wake IRQ after running ->runtime_suspend() which depends on
>   * WAKE_IRQ_DEDICATED_REVERSE.
> - *
> - * Should be only called from rpm_suspend() path.
>   */
>  void dev_pm_enable_wake_irq_complete(struct device *dev)
>  {
> --

