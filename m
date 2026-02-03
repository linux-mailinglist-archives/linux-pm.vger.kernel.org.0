Return-Path: <linux-pm+bounces-41996-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GIFoJl5VgmntSQMAu9opvQ
	(envelope-from <linux-pm+bounces-41996-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 03 Feb 2026 21:06:54 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BCFDDE599
	for <lists+linux-pm@lfdr.de>; Tue, 03 Feb 2026 21:06:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3EB3A307123E
	for <lists+linux-pm@lfdr.de>; Tue,  3 Feb 2026 20:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE2AB36827B;
	Tue,  3 Feb 2026 20:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MzELoxYT"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3F4366DC9
	for <linux-pm@vger.kernel.org>; Tue,  3 Feb 2026 20:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770149185; cv=none; b=eraLWqmqN7u1LfxLKOiMhTzwFP5C/NU4GUdPL5S4dzYWWK+nDrKZ+yrgu/52X+PBQB8czW7+S3j+LrpNTZIBiOvZvNqyOi5DOQnrXV6IWGG+kKK3GwvGYHZ93HKPrGtVFRr1Ykj9hAsy93b90hULqG5JgO962Nwr6+YWs+qJ2k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770149185; c=relaxed/simple;
	bh=wsOr4E70gzyr73ewqBPoF/xptJRXZy+cTtH+4B5AqeQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rFgZpXwD8lDum9MxV2UBAOacrktowDzFjtSu+i97FxsCamCUndoUYeODgPfcc+XwChjumL3YlsoRn3JUrgLF4f7l50gIv0Mh2D+u5p4rM71N7WAhIs3fbHnIuh5rahQ8f/EevVwLrJ8laOfPDSFfKCZl6bKlkG+XEsKNOEFTVmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MzELoxYT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 830C3C2BCAF
	for <linux-pm@vger.kernel.org>; Tue,  3 Feb 2026 20:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770149185;
	bh=wsOr4E70gzyr73ewqBPoF/xptJRXZy+cTtH+4B5AqeQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=MzELoxYT4vkYhR/6p/2mSpE1kgKYg1oNkK7U8w9sm5jgEcl2S/8FugpbHqJG3xgw1
	 O/ZXUfNVs0QZMM2vz7iUa4i9ZILX7dSY0IRZTTWuewa/gSfvNqt3OldvpfTMKhQdKB
	 9EPzWIFKiCIesQjnLsSkFEYT/mOHfWKhga4BsqwFdq4gFbnd3gS4Bh62iNRbsJwXSF
	 uiGPGtNI+W29WNyR1lM7JknYf8A2vYbzjqVQNZjzYMZObOM5gZwtUtjm8xmSZPocLs
	 kViZFd4Ckm8JGpAXGzTZ/rQ7JDNRwt6qezMvqUOIHXdaxTidQAMIKDixoZIWBH/89U
	 BjUc76qv6eTjQ==
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-45c70afbeebso3997561b6e.0
        for <linux-pm@vger.kernel.org>; Tue, 03 Feb 2026 12:06:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWHovS7tDewDsijwlQAKCXbyjBmtY+I51VdOmZFRN/lGfK2CwmYpZuPZ/RX8Mw4bdqthN+x5v44Kw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzZzi8DBRPyBGRWhk4otOSgxnMKTVsE0tykVJflYz/O9wmjsP+G
	G7LEkWzvSoobh72ZkxIjaBfCltrqiyrofeSKYssF5ZSxQwJ28DBDMUc6raSoRWg5ltmd3T2my/E
	YMNRfKtzqNWkD5zOMzvE7Pfo03HfdP/A=
X-Received: by 2002:a05:6808:1929:b0:45e:dbd9:afe4 with SMTP id
 5614622812f47-462d59c3fd0mr330313b6e.42.1770149184461; Tue, 03 Feb 2026
 12:06:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260203063459.12808-1-xuewen.yan@unisoc.com>
In-Reply-To: <20260203063459.12808-1-xuewen.yan@unisoc.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 3 Feb 2026 21:06:12 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hmAm8hJ2tNoamREH_K+vKj7q_VwaqBicKbqmmDNCOUnQ@mail.gmail.com>
X-Gm-Features: AZwV_Qgq5KbgASOfiigH0Saz0jOddLyX7WM5dcEU-bcON1MKDJC9eeh4ChRIhPE
Message-ID: <CAJZ5v0hmAm8hJ2tNoamREH_K+vKj7q_VwaqBicKbqmmDNCOUnQ@mail.gmail.com>
Subject: Re: [PATCH] PM: sleep: core: Fix sync issues between work_in_progress
 and must_resume
To: Xuewen Yan <xuewen.yan@unisoc.com>
Cc: rafael@kernel.org, lenb@kernel.org, pavel@kernel.org, 
	gregkh@linuxfoundation.org, dakr@kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ke.wang@unisoc.com, di.shen@unisoc.com, 
	xuewen.yan94@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FREEMAIL_CC(0.00)[kernel.org,linuxfoundation.org,vger.kernel.org,unisoc.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41996-lists,linux-pm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-pm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 1BCFDDE599
X-Rspamd-Action: no action

On Tue, Feb 3, 2026 at 7:36=E2=80=AFAM Xuewen Yan <xuewen.yan@unisoc.com> w=
rote:
>
> There is a synchronization issue when suspend async:
>
>      suspend-task:                           async-child-kworker
> dpm_noirq_suspend_devices
>  mutex_lock(dpm_list_mtx)                   async_suspend_noirq
>  list_for_each(dpm_late_early_list)         device_suspend_noirq
>   dpm_clear_async_state(parent);             dpm_run_callback()
>    reinit_completion()                       dpm_superior_set_must_resume=
(dev)
>    parent->power.work_in_progress =3D false;     dev->parent->power.must_=
resume =3D true;

Good catch!

The issue would affect suppliers too though, AFAICS.

> Because the power.work_in_progress and power.must_resume use the
> same byte:
> struct dev_pm_info {
>    ....
>   [56] struct completion completion;
>   [104] struct wakeup_source *wakeup;
>   [112] bool wakeup_path : 1;
>   [112] bool syscore : 1;
>   [112] bool no_pm_callbacks : 1;
>   [112] bool work_in_progress : 1;
>   [112] bool smart_suspend : 1;
>   [112] bool must_resume : 1;
>   [112] bool may_skip_resume : 1;
>   [112] bool strict_midlayer : 1;
>   ...
> }
>
> So, if suspend-task and child-kworker modify these two variables
> simultaneously, it will cause mutual overwriting issues.
> More severely, this may result in the work_in_progress variable
> not being set to false, preventing the __dpm_async() function from
> queuing work to execute the parent=E2=80=99s suspend function.
> Consequently, the completion event will never be finalized,
> ultimately causing the suspend process to be blocked.
>
> To resolve the aforementioned issue, the must_resume variable
> should be protected using dpm_list_mtx.
>
> Fixes: aa7a9275ab81 ("PM: sleep: Suspend async parents after suspending c=
hildren")

No, the patch below doesn't fix this one AFAICS.

> Fixes: 443046d1ad66 ("PM: sleep: Make suspend of devices more asynchronou=
s")
> Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> ---
>  drivers/base/power/main.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index 97a8b4fcf471..7ab42e065074 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -1407,8 +1407,11 @@ static void dpm_superior_set_must_resume(struct de=
vice *dev)
>         struct device_link *link;
>         int idx;
>
> -       if (dev->parent)
> +       if (dev->parent) {
> +               mutex_lock(&dpm_list_mtx);
>                 dev->parent->power.must_resume =3D true;
> +               mutex_unlock(&dpm_list_mtx);
> +       }

This is not sufficient because the suppliers can also be affected and
there are analogous issues in the other suspend phases.

>
>         idx =3D device_links_read_lock();
>
> --

So let me send my version of the fix.

Thanks!

