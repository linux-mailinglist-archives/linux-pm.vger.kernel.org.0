Return-Path: <linux-pm+bounces-31079-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CAE0B0AC01
	for <lists+linux-pm@lfdr.de>; Sat, 19 Jul 2025 00:12:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D8587AE977
	for <lists+linux-pm@lfdr.de>; Fri, 18 Jul 2025 22:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43A5722157B;
	Fri, 18 Jul 2025 22:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aKX3zY8I"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6FA2206B1
	for <linux-pm@vger.kernel.org>; Fri, 18 Jul 2025 22:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752876758; cv=none; b=oVKUZsOuzTodnJ2HRdoQFD8O/FfIwaFfR0j+hi4VBVtNLXpt4lK3ov3TnKKcBS3Z+c/e2YVPzlaGA3H2VGru/PFEuH1F3qyVPdesdBB55C3FOEqBdJr9QOxGse6YiM1y5X9urFBra8+rE/MdNcq5/vJ2jGkF2sBHgrBuJAjMtXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752876758; c=relaxed/simple;
	bh=s2LRce76CJwiXLOU9vnxXVPe7lpgVvqpKmVUxNBAKA8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MV78eAcNkP+Z2Izk9wlJSXpREIHijF7Ofb2otKKDCalKs8Jd6CvPkQ+UxyOZurfwuube1/sWwIRx/dQulIxUYDIRlEtfqGsdg29PxUzCKgQPT8yZWzHTYcTJpGTDy4d7tfnUiYBYvaqpfOzq+idq4DaDslJrdDe2N35hl8ddYqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aKX3zY8I; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-87f2ba094dcso948284241.3
        for <linux-pm@vger.kernel.org>; Fri, 18 Jul 2025 15:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752876755; x=1753481555; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jIrNkVkuP3tAwP6xtLC+nJ+0yeYDuWdBnWckVwi1yf8=;
        b=aKX3zY8IyhRL5ygkxH4rzsPpph1pnfHYjFBztqojBNBHMxIpuNJHJTUfkBNk/FduzB
         N7Zzi3CmVBKhUFakBScu8qNqkY+h9IDacmtk4Fc8RIDk/MaqyUa4XbhlKaqyITwKDKvE
         QXqmd3aLT+ZVytWlg7l+yNHWd6RzhgngE8zrnDSAyClY6GXNPEEwko21JL10llyWKS73
         1I27MtLopbktErWvWz2X4zdlm0em6QmGmGGtG3fRDuJGx+Rs6F5jfvAXoPoEJ07DWrZ8
         4AuRpSdo65WvAzl1weiRk8V98PA6jE0Amf2tYT2QsTgQ3fj9H3BO1yb0DFU0XIU0TgcD
         NCHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752876755; x=1753481555;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jIrNkVkuP3tAwP6xtLC+nJ+0yeYDuWdBnWckVwi1yf8=;
        b=K7NWNupQA1KC2lVnLM5upDBQnYJeDWthsTmVkwOzez/7zD03GvpW41lM6WjKDqmJcD
         jGsk45qgzZW2ZzPV7Ry9g6ybAk/fYzY57PTuwoxnHWjmvfoCYxTRmBZaT8C+XUza+DlD
         a18ThWW6ro4BfTfDqgftuJjBHv9oA3APzdrAm06XZnCyIGwbqdg5uMZ/WaqgFIUrXYys
         blPAHKG9PT3S82JXK6ZW9qigzsh6pKK9OAoe35QVi0tx4/UyVF2PZj7vrSQlbb4fjAQF
         MpvqOCm39LK1WZ/7KbHR2SAhYw6BlB/SA4fpbmB1JZ/DHVCvAsCKI3PnFMJclK/RpwkM
         0vlQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMlC67MoaNSxMUXb747iRO+ff7qNvgWkP14Mjj5TgPfuh3AHGvLDgsHO6E+JlccBzONJK5MKzNLQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+nBUd00exsZycphXezFzTkrWnq1MlmaHjKacDf2l3gXn1LL5e
	Bw6tIwxtTLihAsqsHDj7ADjJOCPaCtCjC58KC5lniykjrgZY7CHcUjw+vPBg/51L64cpIGRn13K
	XYsAImVfNaftm3x5LR3jtEfMVAETLEI7wDuonsE9Z
X-Gm-Gg: ASbGnctnjYltPHFAM786IH1JmuOjf3bgxaq26gkNIdMphMc/SGw89tI6UnGZeQsvTpA
	Wptcx/9gzCNt6cOBhy0Iklhnnwu4af4gjwSYzjy1j3E55TkyOsRsVlv9YbIpm7otCdy6YpL5kj2
	YoOh8hKf8paE480NS8gYHl0f/ZqMWEKLrIlh14z82gUPxhjU87f7tDfGRoGDpuyndQPZieTxfuq
	NyhiA==
X-Google-Smtp-Source: AGHT+IHqzXLJx75F2qb9KYvvxpmMgwH/YmcBnQgwUFOH7sTlkDIVL8YHbPz1GDBuXdA7F8h/Zam9hm0TzgDZoiYbtXE=
X-Received: by 2002:a05:6102:5804:b0:4e7:bf31:2f68 with SMTP id
 ada2fe7eead31-4f95f57dc6bmr6312022137.25.1752876755166; Fri, 18 Jul 2025
 15:12:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250718071842.2483378-1-saravanak@google.com>
In-Reply-To: <20250718071842.2483378-1-saravanak@google.com>
From: Saravana Kannan <saravanak@google.com>
Date: Fri, 18 Jul 2025 15:11:58 -0700
X-Gm-Features: Ac12FXxTzaU3RgPlAaabBlkH1dGpCrRFrIZWUl1Wv2VlvLbK_ZMRbxI2isfJol8
Message-ID: <CAGETcx86B52TLxR4=UHYfG3ZeOBa6_UV9b_b4zzbf=SbS5BPjA@mail.gmail.com>
Subject: Re: [RFC PATCH v1] PM: wakeup: Provide interface for userspace to
 abort suspend
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <len.brown@intel.com>, 
	Pavel Machek <pavel@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Danilo Krummrich <dakr@kernel.org>
Cc: kernel-team@android.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 18, 2025 at 12:18=E2=80=AFAM Saravana Kannan <saravanak@google.=
com> wrote:
>
> Once suspend starts, it can take a while before file system sync
> finishes and all the userspace threads are frozen. During this time,
> there can be events that originate in userspace that would require the
> suspend to be aborted.
>
> The only way to abort suspend from userspace as of today is to grab
> and release a kernel wakelock using the /sys/power/wake_lock and
> /sys/power/wake_unlock files. This has the disadvantage of:
>
> * Doing the useless work of creating and destroying wakelocks.
> * If the userspace entity crashes after the wake lock is created, we
>   get a wake lock/memory leak.
>
> To avoid all this and simplify the interface, this patch allows
> canceling a suspend by writing UINT_MAX value to the
> /sys/power/wakeup_count that is meant for tracking wakeup events.
>
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>
> Rafael,
>
> If the idea looks good to you, I can also update Documentation and sent
> it as a non-RFC patch. I'm not too tied on what file we use to trigger
> an abort from userspace as long as it's possible.
>
> Thanks,
> Saravana
>
>  drivers/base/power/wakeup.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
> index d1283ff1080b..9316de561bcc 100644
> --- a/drivers/base/power/wakeup.c
> +++ b/drivers/base/power/wakeup.c
> @@ -1008,6 +1008,8 @@ bool pm_save_wakeup_count(unsigned int count)
>         if (cnt =3D=3D count && inpr =3D=3D 0) {
>                 saved_count =3D count;
>                 events_check_enabled =3D true;
> +       } else if (cnt =3D=3D UINT_MAX) {

Sorry, to match what I said in the commit text, this should be count
=3D=3D UINT_MAX.

-Saravana

> +               pm_system_wakeup();
>         }
>         raw_spin_unlock_irqrestore(&events_lock, flags);
>         return events_check_enabled;
> --
> 2.50.0.727.gbf7dc18ff4-goog
>

