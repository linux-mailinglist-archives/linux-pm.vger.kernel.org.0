Return-Path: <linux-pm+bounces-42239-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sBKaEcxDhmmbLQQAu9opvQ
	(envelope-from <linux-pm+bounces-42239-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 06 Feb 2026 20:41:00 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D98D0102DEE
	for <lists+linux-pm@lfdr.de>; Fri, 06 Feb 2026 20:40:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2EC8C3004638
	for <lists+linux-pm@lfdr.de>; Fri,  6 Feb 2026 19:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A65A30DEDE;
	Fri,  6 Feb 2026 19:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tgsBEUKL"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C6530594E
	for <linux-pm@vger.kernel.org>; Fri,  6 Feb 2026 19:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770406856; cv=none; b=i2KYTeysDsUCGa+3cR4Ez3h11BLvhgzUbb6sfx1NYOy8vHcAz+HFWs9+aWpKxZyJxbW5SAC1AOLUtpc/d3pi7Ey1hNujDBTPZlsDPx1KUcnKZLSg2tGcv6V3sBn4r/PeE6ZrG1EXqISkNJnnE7Ez/BUhq3wcYaNGHjS6lRVqtzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770406856; c=relaxed/simple;
	bh=IEQSbo9h9+yvZ98xxxBIycLena/WpJQOlCQSJKHWVPQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c0MYLhxCX10Qr2uSOA5MO63hRYrD1ZFG1CPCC3PjoPkH0Y5vFAUNQUnN6rdd1BM4917o/5LC4CpH1XJhjRMaB2XlCagLPGhfHj1egZ2yNqLOmDB03x0rwAvpiYsHQlam8ZitmqxzztVQGbnuZ8e8uJLYqJVqGFj+pnvaJtRrhxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tgsBEUKL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CACB3C19424
	for <linux-pm@vger.kernel.org>; Fri,  6 Feb 2026 19:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770406855;
	bh=IEQSbo9h9+yvZ98xxxBIycLena/WpJQOlCQSJKHWVPQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=tgsBEUKLyW5KPAuND4P6ACg1Ys6kmWROh2aZEVOirJ4OKzA6ALlSNUPt2wRfn7kSC
	 Q3mMGQm7y7/FsMyMFp0COFi1WRL2UEC879s5CaRmRnNEwxMypgSSqbwKtYTpA82swE
	 kX2ivTWv+L8Pv+B0A46/TFqdIZqs6YVmzxkfU+HamgsqIPaXV0PN0h0sydyBFNQqQ7
	 s5XI9OD+yCtXJ5nPxcS0SfBZEIRJJeKp7nNLthFEfusA1yz2QZc9bKjci09hwAaHt3
	 Bd1qGXx+RMTeM4HZR+2fetMPJ1Fpc9mXVhsxYBj9Gut/jTZzfOeyLDhexTZZAxOMJP
	 Kve896NcgwuXg==
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-3f9ebb269c3so1201700fac.3
        for <linux-pm@vger.kernel.org>; Fri, 06 Feb 2026 11:40:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCULBRTgNvxGW69v8j2qRpePNA66EZZj7hVK5RpbiU7I2RQE4h9rgweGpa79OHKQLRy6n5hUqA7WgQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzoDHHJc4IEeorby/+/TFgEj76AXwJIWUjm51DXkVZqUNUuRbMm
	qrLSPI2sdxDVjMacUv/vcayR36PKiGSUuIxuonO78yQ0/TcLz4/5d1n6mwDb3iojkMNSfv3+Tiz
	6lG47/Mvami2oLAcyYjhzdm4MNi8sUxM=
X-Received: by 2002:a05:6870:44c9:b0:40a:62b7:1619 with SMTP id
 586e51a60fabf-40a96f90eacmr2285019fac.46.1770406854855; Fri, 06 Feb 2026
 11:40:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260206-noirq_async_suspend-v1-1-d10f2418df4c@nxp.com>
In-Reply-To: <20260206-noirq_async_suspend-v1-1-d10f2418df4c@nxp.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 6 Feb 2026 20:40:42 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0i7zuAmvWGPjGKkMKV=qmpc6dJOQXRUVUoqtzd1bdeEdw@mail.gmail.com>
X-Gm-Features: AZwV_Qhckt70t2bi-9O-bxdlqcv5NjF49hN3W2p-Zq1pDjHXSwssofw3i8fgzD8
Message-ID: <CAJZ5v0i7zuAmvWGPjGKkMKV=qmpc6dJOQXRUVUoqtzd1bdeEdw@mail.gmail.com>
Subject: Re: [PATCH] PM: sleep: core: Fix race condition in async noirq suspend
To: Jacky Bai <ping.bai@nxp.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, 
	imx@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42239-lists,linux-pm=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-pm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nxp.com:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: D98D0102DEE
X-Rspamd-Action: no action

On Fri, Feb 6, 2026 at 4:03=E2=80=AFPM Jacky Bai <ping.bai@nxp.com> wrote:
>
> A race condition occurs during the noirq suspend stage when accessing
> bitfields in struct dev_pm_info, causing system suspend to hang.
>
> During async noirq suspend, leaf devices are queued for asynchronous
> processing while the main suspend thread continues clearing the
> 'work_in_progress' flag of other devices, including potential parents
> of those leaf devices.
>
> In struct dev_pm_info, 'work_in_progress' and 'must_resume' are
> bitfields stored in the same byte. This creates a race when:
>
> 1. A leaf device's async thread sets its parent's 'must_resume' flag
>    via dpm_superior_set_must_resume()
> 2. Simultaneously, the main thread clears the parent's
>    'work_in_progress' flag
>
> Since bitfield operations are not atomic, concurrent modifications to
> the same byte can corrupt both fields. This leaves the parent device
> in an incorrect state, causing the system suspend to hang.
>
> Fix this by adding lock protection around the bitfield accesses to
> ensure atomic read-modify-write operations.
>
> Fixes: 443046d1ad66 ("PM: sleep: Make suspend of devices more asynchronou=
s")
> Signed-off-by: Jacky Bai <ping.bai@nxp.com>

There is a fix for this already in my tree, see

https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/=
?h=3Dpm&id=3D0491f3f9f664e7e0131eb4d2a8b19c49562e5c64

> ---
>  drivers/base/power/main.c | 20 +++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index 189de5250f256bdc1cdc33006b2c386d0794485f..561e24c257d779db51a0f0d50=
dcfee61e98de64f 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -633,7 +633,9 @@ static bool __dpm_async(struct device *dev, async_fun=
c_t func)
>         if (!is_async(dev))
>                 return false;
>
> +       spin_lock_irq(&dev->power.lock);
>         dev->power.work_in_progress =3D true;
> +       spin_unlock_irq(&dev->power.lock);
>
>         get_device(dev);
>
> @@ -656,8 +658,11 @@ static int dpm_async_with_cleanup(struct device *dev=
, void *fn)
>  {
>         guard(mutex)(&async_wip_mtx);
>
> -       if (!__dpm_async(dev, fn))
> +       if (!__dpm_async(dev, fn)) {
> +               spin_lock_irq(&dev->power.lock);
>                 dev->power.work_in_progress =3D false;
> +               spin_unlock_irq(&dev->power.lock);
> +       }
>
>         return 0;
>  }
> @@ -698,7 +703,10 @@ static void dpm_async_resume_subordinate(struct devi=
ce *dev, async_func_t func)
>  static void dpm_clear_async_state(struct device *dev)
>  {
>         reinit_completion(&dev->power.completion);
> +
> +       spin_lock_irq(&dev->power.lock);
>         dev->power.work_in_progress =3D false;
> +       spin_unlock_irq(&dev->power.lock);
>  }
>
>  static bool dpm_root_device(struct device *dev)
> @@ -1407,13 +1415,19 @@ static void dpm_superior_set_must_resume(struct d=
evice *dev)
>         struct device_link *link;
>         int idx;
>
> -       if (dev->parent)
> +       if (dev->parent) {
> +               spin_lock_irq(&dev->parent->power.lock);
>                 dev->parent->power.must_resume =3D true;
> +               spin_unlock_irq(&dev->parent->power.lock);
> +       }
>
>         idx =3D device_links_read_lock();
>
> -       dev_for_each_link_to_supplier(link, dev)
> +       dev_for_each_link_to_supplier(link, dev) {
> +               spin_lock_irq(&link->supplier->power.lock);
>                 link->supplier->power.must_resume =3D true;
> +               spin_unlock_irq(&link->supplier->power.lock);
> +       }
>
>         device_links_read_unlock(idx);
>  }
>
> ---
> base-commit: 9845cf73f7db6094c0d8419d6adb848028f4a921
> change-id: 20260206-noirq_async_suspend-645bd6b8305e
>
> Best regards,
> --
> Jacky Bai <ping.bai@nxp.com>
>
>

