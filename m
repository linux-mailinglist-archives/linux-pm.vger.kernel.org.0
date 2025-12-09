Return-Path: <linux-pm+bounces-39330-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 83BCECAEFDA
	for <lists+linux-pm@lfdr.de>; Tue, 09 Dec 2025 07:03:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B13E13004D0D
	for <lists+linux-pm@lfdr.de>; Tue,  9 Dec 2025 06:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76AEE262FD0;
	Tue,  9 Dec 2025 06:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G+caIsU1"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3EE015746E
	for <linux-pm@vger.kernel.org>; Tue,  9 Dec 2025 06:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765260217; cv=none; b=aupPGEfx/0vACuM/AmQ3HFTq/kTcek3DZ8VkpPvZGC6zFiGiGSKlXoOR9Vghrn4es0yZNQU9SbYbKI4d/rZf5/z4ailoJGVlRALmXQfkxYm3i8wMzW3uZhfwlPj3Z9x9LzfVf1W/fmhEddSw39TrfNXL4iv58k15+n6Qe1jw5cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765260217; c=relaxed/simple;
	bh=oBTZ2Ya3LFBT5ZFu+p8mzczZGzmeB6TLslS1Fe8miAw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aFyPlwpuvbssxbXdBYVvj0wEv9ylXtmEBri4xnQOkjXnDHw6+6YY7vI700wGoO+pHiJKArbemXerCIsvUB0f2d4pby37Ih2I5H9qb4ISEW0uYyX96LKlCERwZtCU7cQE6zTQ1buhurrUX04g8a8q+4mcAj+9uCHPQahkhRuYnV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G+caIsU1; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-787ff3f462bso63352207b3.0
        for <linux-pm@vger.kernel.org>; Mon, 08 Dec 2025 22:03:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765260215; x=1765865015; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oBTZ2Ya3LFBT5ZFu+p8mzczZGzmeB6TLslS1Fe8miAw=;
        b=G+caIsU1gjUUcvnjO3f/5z5p4fpH4yNPWgs8oPssTsJRGAwAVMWZhT5KZ/SOF9c87K
         euGgD7wRC3Zlqc58HZCwakYVxOqa7Bqh+kZeJRMUQJW2c6FGxnU1TkWoUlbvRXmco/Up
         9/LuCskaR/8hfi5J61bb+Oqim7PozPZF2WE9nBz9gWbt1JR/Wr3ckxkpjEjx2cakbOR8
         eZi0O8UubfbGAvQsDqTHwlAQmJXIBvxLxPHzszENoePtI4BTCRQMNrGcq9zq0N6ZIpd5
         jLzro2CnXy0AL4anuLt3VY/sKp9Wk3uKOBXkvFRNnRW1P+q5E1a5ro/gPE0gc0cRapL8
         or2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765260215; x=1765865015;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oBTZ2Ya3LFBT5ZFu+p8mzczZGzmeB6TLslS1Fe8miAw=;
        b=ZjDG8L0AYlt2oBxHiIMy3t0UwQEJLwOPzUmOBvYMOtlloBr37T4a/KC3RcGOfRIIPq
         Re8wXpGig9zwlh5KCisYGN5farUqPW1/fPj6bBB7DU+F7GMBsqlfY5D43hox8uVf0EAL
         vj84n32Kx8GHp8kibPMacfA0HDplYdB8FrCE0PW6/dTm3cqfjjHRR2D4Yt2pYpjA3w0C
         fvOQi6pwSGHWGnIMsQaSFPcJ7iMi7SHt/iv60gjjd88Tn8V+/ScZ1VyGe34Y2z1RniNS
         Sv2XZw1OK3E6rqBDTU0+sguE5m+RxlHvwZzUxNZCMLO6PP+3HK8Ysl/pFK6AnafAOjzM
         S7kQ==
X-Forwarded-Encrypted: i=1; AJvYcCVq+my3/5sCGOFW1bc/wtXsjZ6L3+amLiq1h/JpUbYHG0jn3o1560snfiGrcNWT52PuWbggBWLJnA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxUu0FjmjviWqrg03WqBuit7x8qqvA+v9VPjzqi+rlX8SSzNn80
	CxzOdw89i9HG8i+CHUzR0L6r76SwjFdHbXjTnbn5KCCqWY/b+4UxlYXvd8gFb094AgBi7WNhV67
	m1TuOF7/DlJKVVQ2e9YUqBzwXE9IuDZU=
X-Gm-Gg: AY/fxX4M/OhtGr/gMW/PC6q7vLHiUxYz967tR14FxZKGqNh4AtapOIiQeiy3klPhE5e
	sjAl3eIcXMlYnK2uLwbCPWahbjfs28F+ZU670RPFtZD8UPP7QWmK/rgm0r8NrWYw7XNZ0zl9enP
	rGx0suosZ6gr6zlrTA8fO/n9hpsLDdcuc+SkupzS567nw3EYK2DRNa5i+SBDK8CVQE9FIP1ME38
	eEVxRvYr1PpOvd23NWqG6QwhkAjtclnnsI21ZrAG38hNgmY2vINrKYJh8rR4coG10f1GNzEj8tw
	TSCMKBk=
X-Google-Smtp-Source: AGHT+IFWSk+Gx5Hu+GxhdC19MWzg6caPjziHbN4HkRYzRB5k+1atfCOQ1Mi8C0lPsAyjisE59nr9CN3RG++h3+fh6BU=
X-Received: by 2002:a05:690e:b86:b0:644:60d9:865f with SMTP id
 956f58d0204a3-64467a685ccmr282456d50.43.1765260214852; Mon, 08 Dec 2025
 22:03:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231213083251.186935-1-chris.feng@mediatek.com>
 <20251021125446.4384-1-safinaskar@gmail.com> <e27d0392-11c4-4b9e-8ada-9db73f47dddb@amd.com>
In-Reply-To: <e27d0392-11c4-4b9e-8ada-9db73f47dddb@amd.com>
From: Askar Safin <safinaskar@gmail.com>
Date: Tue, 9 Dec 2025 09:02:59 +0300
X-Gm-Features: AQt7F2pBg8sUS-refhzV6U8KXOpDLQr9gIhi7WDltdVoC5E1oBVor853-rHhgg4
Message-ID: <CAPnZJGB2YAx03piGMLE=wLOQU9-gCpSdFZhBE5iECkDxwzYCFQ@mail.gmail.com>
Subject: Re: [REGRESSION][BISECTED] "Wakeup event detected during hibernation"
 on Dell Precision 7780 (was "[PATCH v4] PM: hibernate: Avoid missing wakeup
 events during hibernation")
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: chris.feng@mediatek.com, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, chetan.kumar@mediatek.com, 
	hua.yang@mediatek.com, len.brown@intel.com, liang.lu@mediatek.com, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, pavel@ucw.cz, 
	rafael@kernel.org, stable@kernel.org, ting.wang@mediatek.com, 
	regressions <regressions@lists.linux.dev>, 
	DellClientKernel <Dell.Client.Kernel@dell.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 5:29=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
> To me it sounds like it's potentially the same root cause for the early
> suspend wakeup as well as the hibernate wakeup.

Adding "gpiolib_acpi.ignore_wake=3DVEN_0488:00@355" or
"gpiolib_acpi.ignore_wake=3DINTC1085:00@355"
doesn't fix this bug.

> Are you closing the lid
> and putting the laptop in a bag or putting anything on top of it?

No. I just click "Hibernate" button using touchpad in GUI, and hibernate fa=
ils.

I just did some printf-debugging. Results:

We call
https://elixir.bootlin.com/linux/v6.18/source/kernel/power/hibernate.c#L870=
 ,
it calls
https://elixir.bootlin.com/linux/v6.18/source/kernel/power/hibernate.c#L723=
 ,
it calls
https://elixir.bootlin.com/linux/v6.18/source/kernel/power/hibernate.c#L636=
 ,
it calls dpm_suspend
https://elixir.bootlin.com/linux/v6.18/source/drivers/base/power/main.c#L22=
65 ,
that dpm_suspend returns error, and this error leads to
"Wakeup event detected during hibernation" message.

Any further pointers? How to debug?

--=20
Askar Safin

