Return-Path: <linux-pm+bounces-36969-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1DD0C14B94
	for <lists+linux-pm@lfdr.de>; Tue, 28 Oct 2025 13:56:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B1C63BCCE3
	for <lists+linux-pm@lfdr.de>; Tue, 28 Oct 2025 12:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7207F32ABCC;
	Tue, 28 Oct 2025 12:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UPcypZgz"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D926C2DAFD2
	for <linux-pm@vger.kernel.org>; Tue, 28 Oct 2025 12:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761656210; cv=none; b=WOj0e+P+sDSqBI/2s8Otl+p+bHCaodxs5MvmvXHxHmwhJFPlbugDHHoO961UdIvRPqWGUFJ662hCLU4eMFfxS/cbRbKdO0podqXtPEPCqGojXsaMwTwy3uto7OZoRtTMfFrDVE8d+NyR3LDnr6tFj71jY66Y11bEUq2mx+iPe/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761656210; c=relaxed/simple;
	bh=j+D/qyt7Pw1B5Ingaklbk01v2dTvdYRTa494exV2Eno=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eTgCEXUBKR91UGtC60Ts5+byniXkCAOjcuWhacIVzJtD7sVS4w6rI4ELZCoGrDzhFh8iimNaj3gUB6u+4M5EHv8MNIQNf2gMUMjH3sGp0cwyjAoZeSEXm26jruiCKiPda6VsgHgsynM2ei34KCMbn92P/0EGDYLXz4k2b8Xt02E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UPcypZgz; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-781014f4e12so74314467b3.1
        for <linux-pm@vger.kernel.org>; Tue, 28 Oct 2025 05:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761656207; x=1762261007; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j+D/qyt7Pw1B5Ingaklbk01v2dTvdYRTa494exV2Eno=;
        b=UPcypZgzJi06J91sefhzN5nYMrQPpnCX/YyboKAQJr4L1E0MXqhzplESkEWFcUgYrW
         UMilj6k+pbfVXSQA2GUMvq/gO6b141d+EntMkaOmQ9euIXQVh96WUBvzXSxFCWQ6mq7M
         qm5q7H+XqLfeYzw4mIhkn4FA0EendE1ZFVx2kciR2ua2Bs7DwVAFQh1CL1ew8ydJ8ckj
         RSST4Yw2SPc77r0qoXZ7H3AsLR+3CvgRC83omQ6rH+n54HHVN8BdIGtk8QoIdBkM7Wzv
         /IUECGMwk2/1pUoPW85oOnALdoqQ4HG3aaj3ybf3/atg7mVzFw6pkmfjyW6vkXubuQ61
         aPDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761656207; x=1762261007;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j+D/qyt7Pw1B5Ingaklbk01v2dTvdYRTa494exV2Eno=;
        b=nhW84p2LQr32M2qQh9rQDT9oMAH4OKpz0xGUcE2XYvC+f5Aa2kgVz8uxTOsjuFhOqm
         RbtTUvEY06SBOrdXgDmP2eJnKB/3Q4OYxnswqEK2ObxxJuLc7E/iS/gAQE165+mAMQiY
         OkdiHI/3k31Ag9DtFOAf7ktG0de5Tsn7XN/sextMvBYYrQWTJ64KHD43GucSM+mhd+/4
         WCWAGtRIGTJe4UVQxMpoKCyRQUaUZRpPpcGEhsufy5+XP5N3mINBVXHuXkrJ+Xu1qVqX
         yqzTyz8JWRwtGxzMJfH+rZp9ndi8X4b2QWTTgn36ML/xYv/lMoZkFAeclrRM0Ed3UVUj
         Wrcg==
X-Forwarded-Encrypted: i=1; AJvYcCVYJaDmBDtPkVxBDWO96buhxSK7cK6UkJLPKtGDONAnzVxioHBWywmEdN7Wd1/tDAa2tfndqwRSrg==@vger.kernel.org
X-Gm-Message-State: AOJu0YysSPIci8epZpYNF0MxDu4berBKC3UEWq2CFEUKzYdjf17gpob4
	jxtGghyQIR5DYmPYNaIwsug8F6lbaUp4wlnb/bY8D1XxnsVsqIt8tDl8loTFj2avG9DHkpzS8ct
	9djawNTFVTay1wWO+JvNWA38SJljb+Eo=
X-Gm-Gg: ASbGncsbKE3OLVxtbXbe3vjb4WGE1LEyH4CyRMdSzLhe41aG0b+uloRCB5XY90gSN7t
	pCuM+5ktg6YZlsehquwWIhPGb6qmFm2uInuqD0zDx4/V8VZRD9NErJdxr1Xw/ohm/DVoE5+0rx7
	PJ+0nHm/ItGJjOKFThTr0UqYHgEMZBP1vuxtjzB3vIcTDls8YIxcvceH7y8qBBzw6Io3zJPO4D3
	nBUdakmkIj8Zyzwf4saSU0sEeE3Rp+F5BFI+cJzl1esM2w6UclZ8RkTNAiQ/WRJ
X-Google-Smtp-Source: AGHT+IGtsJS49buUuXnldsSwr5pJwsNb6Tuyy9XWwb84EZE/f+Q+JyeRVvi5lf9lAmTAXAn6fgo6kde6+3fayMiFpV8=
X-Received: by 2002:a05:690c:6a83:b0:784:92a3:68b3 with SMTP id
 00721157ae682-78617e4187emr31380357b3.12.1761656206790; Tue, 28 Oct 2025
 05:56:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251026033115.436448-1-superm1@kernel.org> <20251028111730.2261404-1-safinaskar@gmail.com>
 <CAJZ5v0iziWj0dWWFMz-otXAt2c1PBp6RwQKVjt_hwbrU4B_fVg@mail.gmail.com>
In-Reply-To: <CAJZ5v0iziWj0dWWFMz-otXAt2c1PBp6RwQKVjt_hwbrU4B_fVg@mail.gmail.com>
From: Askar Safin <safinaskar@gmail.com>
Date: Tue, 28 Oct 2025 15:56:09 +0300
X-Gm-Features: AWmQ_bntAnYoYljGIuyjMjnQaWJ0nwhoVeromC8zJngYVgMffRf91LGENVsp4dM
Message-ID: <CAPnZJGCOR_zCOvLPdyYARQrZdafvBGwkXaDO-MGA6axw4etEsA@mail.gmail.com>
Subject: Re: [PATCH] PM: hibernate: Restore GFP mask in power_down() for HIBERNATION_PLATFORM
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: superm1@kernel.org, lenb@kernel.org, linux-pm@vger.kernel.org, 
	mario.limonciello@amd.com, pavel@kernel.org, rafael.j.wysocki@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 2:49=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
> What kind of damage are you talking about, specifically?

Again: "pm_restore_gfp_mask" will restore "gfp_allowed_mask" to its
normal value,
which will contain __GFP_IO and __GFP_FS. Thus "pm_suspended_storage" will
start to return false.

But "pm_suspended_storage" is called here:
https://elixir.bootlin.com/linux/v6.18-rc3/source/mm/swapfile.c#L1895

(Also, please, read that big comment at this link.
Well, I have to admit I don't understand it in full.)

This check is needed to prevent swapping out pages during hibernation.

Call chain is so:
swap_writeout -> folio_free_swap -> folio_swapcache_freeable ->
pm_suspended_storage

So by calling "pm_restore_gfp_mask" we allow pages to be swapped out.

But we already wrote hibernation image by that point!

So swapping pages will make our swap partition inconsistent.

Moreover, as well as I understand, whole reason why we deal with GFP mask
in hibernation code is to prevent swapping out pages.

We restrict GFP before creating hibernation image here:
https://elixir.bootlin.com/linux/v6.18-rc3/source/kernel/power/hibernate.c#=
L463
.

We do this (as well as I understand) to prevent pages from swapping out.

And, starting from that moment, as well as I understand, we should
not restore GFP mask until either:
- we resume
- hibernation will abort for some reason (for example, "wake up event
detected during hibernation")

Again: I'm not trying to insult anybody. I'm just trying to help. And
to understand PM code.

I'm not sure that my explanations are correct.

In any case I think it will be good idea to add comment explaining why
restoring GFP mask
is safe there.

I'm attempting to write code to fix this bug:
https://lore.kernel.org/linux-pm/20251023112920.133897-1-safinaskar@gmail.c=
om/

And this is why I'm trying to understand PM code.

--=20
Askar Safin

