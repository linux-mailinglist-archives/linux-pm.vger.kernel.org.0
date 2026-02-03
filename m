Return-Path: <linux-pm+bounces-42005-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QHmvCshngmmETgMAu9opvQ
	(envelope-from <linux-pm+bounces-42005-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 03 Feb 2026 22:25:28 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A9E7DED5A
	for <lists+linux-pm@lfdr.de>; Tue, 03 Feb 2026 22:25:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E57F3301AF66
	for <lists+linux-pm@lfdr.de>; Tue,  3 Feb 2026 21:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF41364EA9;
	Tue,  3 Feb 2026 21:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i4UBkKbt"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DCD31B83B
	for <linux-pm@vger.kernel.org>; Tue,  3 Feb 2026 21:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770153925; cv=none; b=BRdUYI2ziDt0mnlkoofqFUQCe1sbxRZ2nyz0yNFtHYKwz0WJ02Uz/OOELEzHApOx6RB0rRU/uPV6x39wmJ/iDJawZiMnHfZdGU5BU9gstWoh0OD0I/juAFAkXp/rQhh1AQa1enEHBUMutjgTwfD1/+6fGAJG2MiLVGxDEv6cunE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770153925; c=relaxed/simple;
	bh=n1+Pk7RplV2GhJR8srF4ivjN6vLDM+BPY5ICy/zM7GQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I5m7tRim/fTSGOQDnhF/sVqkBlP7HWyvJeOTxGn+zLlstGSWgwj7tHV0C97cUHm6nwQ+sh+Aye4d5ww08sAcCGM+VxbLO6fQ97xq7CMdLq+kBj9OhEYOKFO/s1WeuCneI47kj1yuxgqHVdrDYHu5MH79nkyBZtQtCm2oC0RBfGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i4UBkKbt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD72AC2BCAF
	for <linux-pm@vger.kernel.org>; Tue,  3 Feb 2026 21:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770153924;
	bh=n1+Pk7RplV2GhJR8srF4ivjN6vLDM+BPY5ICy/zM7GQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=i4UBkKbtODKnWfeeybGSE85Q3pPmPttpHskJxVgsbOrW0xgdqbByeLJnlrkQu7irb
	 DowfydvbHEEEukHvwOjNYDsMeQJKs8aJ8VhxsCqTtiAHQVJ0/ntCAfnpo6Xx0Rzd1v
	 p2WU8GmuOLrVb0XXA5IBpt73v6MPQaQlI7EgB4dIF3GNVxWK56hNMNAr7eYy/h4UZ7
	 XPED83623vDhY9pYu2BURxz3P/3nqC/sCDnC6rkKSmFrNNz7TLCvbTSNSUAHfmLGGh
	 QroslK/Fu0hnGgL6g+mDoRy5E48X/kD1E95Sx5h7KFi9xqwhbsUpIYHnvtxNdd38QK
	 Ob9kSy5xX6mYA==
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-45effa36208so4271437b6e.1
        for <linux-pm@vger.kernel.org>; Tue, 03 Feb 2026 13:25:24 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXAOim9g7WS7azMa+kgNkLk23NRO6xR6Tlx0RcSDkzLZwZDJMkk+wGOvcJAFRpqlgfSCV8cDwZulg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwXt9ixJFolSqUFGzqzb4eOnRuZlREoFoSmPpk9T2P8lsosGMXj
	loL/MgcluHqaHCuXmqjawCyrM6Us6KI07/zKTSh+YIiLcErhaT5e4ae3mLGopq9ywGUJF5alkTc
	gsUuYsqJh4/SoZf6imSvh4aMPv9iIyMY=
X-Received: by 2002:a05:6808:1190:b0:45c:a59e:c6d4 with SMTP id
 5614622812f47-462d5a927f6mr439136b6e.58.1770153923899; Tue, 03 Feb 2026
 13:25:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260203031943.1924-1-hanguidong02@gmail.com>
In-Reply-To: <20260203031943.1924-1-hanguidong02@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 3 Feb 2026 22:25:12 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jN9fU9NdWqc-+F5hiSEP4JkR=_qcdGzzHtk1i5tvCDbQ@mail.gmail.com>
X-Gm-Features: AZwV_QjpDttSd2KGTM05f_YQs3e4vYhuIzVDY1G85o2U2IL4gLuvAl3aa8U1F-c
Message-ID: <CAJZ5v0jN9fU9NdWqc-+F5hiSEP4JkR=_qcdGzzHtk1i5tvCDbQ@mail.gmail.com>
Subject: Re: [PATCH v2] PM: sleep: wakeirq: harden dev_pm_clear_wake_irq()
 against races
To: Gui-Dong Han <hanguidong02@gmail.com>
Cc: rafael@kernel.org, pavel@kernel.org, lenb@kernel.org, 
	gregkh@linuxfoundation.org, dakr@kernel.org, tony@atomide.com, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	baijiaju1990@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,linuxfoundation.org,atomide.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-42005-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-pm@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7A9E7DED5A
X-Rspamd-Action: no action

On Tue, Feb 3, 2026 at 4:20=E2=80=AFAM Gui-Dong Han <hanguidong02@gmail.com=
> wrote:
>
> dev_pm_clear_wake_irq() currently uses a dangerous pattern where
> dev->power.wakeirq is read and checked for NULL outside the lock. If two
> callers invoke this function concurrently, both might see a valid
> pointer and proceed. This could result in a double-free when the second
> caller acquires the lock and tries to release the same object.
>
> Address this by removing the lockless check of dev->power.wakeirq.
> Instead, acquire dev->power.lock immediately to ensure the check and the
> subsequent operations are atomic. If dev->power.wakeirq is NULL under
> the lock, simply unlock and return. This guarantees that concurrent
> calls cannot race to free the same object.
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

Patch applied as 6.20/7.0 material.

> ---
> @Rafael J. Wysocki: While studying wakeirq.c, I noticed comments for
> dev_pm_enable_wake_irq_check() and friends are outdated. They claim
> "Caller must hold &dev->power.lock" and limit usage to
> rpm_suspend/resume, yet pm_runtime_force_suspend/resume() call them
> lockless. Should I submit a follow-up patch to simply remove these
> restrictions or complicate the text with exceptions?

Please just send a separate patch to fix the outdated comments.

Thanks!

> v2:
> * Remove the lockless check and perform the check protected by the lock
> to avoid races, as suggested by Rafael J. Wysocki.
> v1:
> * Initial fix attempt using double-checked locking.
> ---
>  drivers/base/power/wakeirq.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/base/power/wakeirq.c b/drivers/base/power/wakeirq.c
> index 8aa28c08b289..c0809d18fc54 100644
> --- a/drivers/base/power/wakeirq.c
> +++ b/drivers/base/power/wakeirq.c
> @@ -83,13 +83,16 @@ EXPORT_SYMBOL_GPL(dev_pm_set_wake_irq);
>   */
>  void dev_pm_clear_wake_irq(struct device *dev)
>  {
> -       struct wake_irq *wirq =3D dev->power.wakeirq;
> +       struct wake_irq *wirq;
>         unsigned long flags;
>
> -       if (!wirq)
> +       spin_lock_irqsave(&dev->power.lock, flags);
> +       wirq =3D dev->power.wakeirq;
> +       if (!wirq) {
> +               spin_unlock_irqrestore(&dev->power.lock, flags);
>                 return;
> +       }
>
> -       spin_lock_irqsave(&dev->power.lock, flags);
>         device_wakeup_detach_irq(dev);
>         dev->power.wakeirq =3D NULL;
>         spin_unlock_irqrestore(&dev->power.lock, flags);
> --
> 2.43.0
>
>

