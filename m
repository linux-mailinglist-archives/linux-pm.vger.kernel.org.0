Return-Path: <linux-pm+bounces-8481-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D47758D6409
	for <lists+linux-pm@lfdr.de>; Fri, 31 May 2024 16:09:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A8B61C21E63
	for <lists+linux-pm@lfdr.de>; Fri, 31 May 2024 14:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CDBD15B96A;
	Fri, 31 May 2024 14:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mZY5mKrW"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813B97F482;
	Fri, 31 May 2024 14:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717164550; cv=none; b=UEJefSLC778fKWJCoJPf046h+oow/PBYv37ETqvh9a0yV6o62FqX9CMuylSTLRg+UyOfaF6pzkrlWTmgaCTH3V7mzQrloLbGqfTxs97ebIjVGiHjDcje9RjcgkbhduAXpY2mQMhh8mv+Qoox0pwo+F4FJqR7SOaLXGu2k6ITk6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717164550; c=relaxed/simple;
	bh=aFM2Jb8qdAj72Lk9TgS5888lrrIM6OyLs2/SIXp3HIQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NFoGikK/84uru3k3qnwUWnYTsjf8gd00iagbPG1XV2j1jsjcq9XeSv1pwnI0sAe5+RJPfaFtqMnjzr93UZFt3CvVV4l8h5rZ0852wHvRc37/joFDJ8ay+67F/VBa01Fm0+hjp28EMPP//AL9QRuSF+lMDXODTspm9r4rY+CK3qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mZY5mKrW; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-57a1fe639a5so1998433a12.1;
        Fri, 31 May 2024 07:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717164547; x=1717769347; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aFM2Jb8qdAj72Lk9TgS5888lrrIM6OyLs2/SIXp3HIQ=;
        b=mZY5mKrWV2nAhtRkrsiu2sBN/Q9x7fMCl4B/9D8SwVwbuVgZuiiTBQw/fT1y4G2BLx
         2ogdfJRbaXRz1w6bVSX/1D0jJ8/APL0YiwOdRnre88SDanM/d8p2smHmWyGIARPrdLi8
         HyAXo1bRueqFpvQfSFbx7ytnQajoS5icygl5oV1+5WEqzDnR6P092uf9GahJPhF9q1Og
         g0SsTG/M1wcVFpHrFjRNPdnuSP8TbA7aug0enZaN8fw8shjZrF4ppO6sNeo3bKalnlID
         TCA9z3pdhZ6Vc63z5sQkoF+NFCiMjFHxSd3kJrXfdjSrnIc6EMkUiQl70/U4vASCAcMx
         jV/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717164547; x=1717769347;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aFM2Jb8qdAj72Lk9TgS5888lrrIM6OyLs2/SIXp3HIQ=;
        b=EmswDLaXuhbvr93aO5+qOPlwoLSmYumoy3nKi9F+dlqi2RMGOqGogoerHqlkY9N9WE
         PThdfra8vYdMpfvPEqvFi2F1CZqGBeCGMed1pRnwaWO9JGNpF+xGEsW4mWmOPcbpbFJD
         irbgCzbzWIM2KIu1kB89u6NGdhjoRQltAmXuawfLLIahIawITEYEi5l52avbbYsdz65O
         6rUL9RVfd+tiXS/TXGnAPvxCCrhSnGNwT19TI7VSQwZ246/BCFIM2oEY3CRp1fPD/V01
         h3Pvs3Ba87QdhovlrJh+9Ag/PXi7x/v1kaFPmsAN2w2XhZQMSLyd7cgON9PAslH1U+K1
         egRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdiYG6GmKOVlwP1JCdQhYwxdQip8Gti23BqVdmtqk2mKgA3i60ZskXDiS8PSd2oovyVml920jKKKpTaGlZfAr52190sOu6ft/O9P1Bfm/kTEcqAV0Zll1fJtMFBshnzxxsAPRNgUPPS6iuhdZSMLpySyBvCpsohaq6XswVK9tcl8sRd/AATmYe7w==
X-Gm-Message-State: AOJu0Yw+ho0xWYVPac/5C6vhaoZjlSIq8F47618QNISHkf0silvnZpCX
	qVyiLlH/xFftNKlDvzDMzs/j76sN5wQ4jRxflgx/uSAmvKcpyvsgPhwVLI3eAykzxeqVY2pNmpq
	kpGfUgQY2vX0wbmk0PTqF+lm4/DI=
X-Google-Smtp-Source: AGHT+IF/zD6rw31aq7BZQFiY06MXYewfjYHfoi8wRsf/nUrmxds3d4Q9sx7MBmk449rVHvOdWE0hYp4fQhjOlBiApvI=
X-Received: by 2002:a17:906:6046:b0:a64:3518:f904 with SMTP id
 a640c23a62f3a-a681fe4e25emr140122566b.7.1717164546538; Fri, 31 May 2024
 07:09:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240531134702.166145-1-hdegoede@redhat.com>
In-Reply-To: <20240531134702.166145-1-hdegoede@redhat.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 31 May 2024 17:08:29 +0300
Message-ID: <CAHp75VeNxnLcZwq+WOh3huf09ou929Vgt50q=7HR-ruMuULuhg@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] power: supply: power-supply-leds: Add activate()
 callback to triggers
To: Hans de Goede <hdegoede@redhat.com>
Cc: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Andy Shevchenko <andy@kernel.org>, Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>, 
	Kate Hsuan <hpa@redhat.com>, Sebastian Reichel <sre@kernel.org>, platform-driver-x86@vger.kernel.org, 
	=?UTF-8?Q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>, 
	Heiner Kallweit <hkallweit1@gmail.com>, linux-leds@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 31, 2024 at 4:47=E2=80=AFPM Hans de Goede <hdegoede@redhat.com>=
 wrote:
>
> Hi All,
>
> This series adds an activate callback to the power-supply LED triggers to
> ensure that power-supply LEDs get the correct initial value when the LED
> gets registered after the power_supply has been registered.
>
> Note that in 6.10-rc1 commit 822c91e72eac ("leds: trigger: Store brightne=
ss
> set by led_trigger_event()") already solves this for the case were
> the trigger only changes only the brightness. Since the power-supply
> triggers can also set blinking and colors of mc LEDs that is not enough.
>
> Patches 1-2 do some refactoring / prep work and patch 3 adds the actual
> activate callback.
>
> This series applies on top of 6.10-rc1 + "[PATCH v10 0/6] KTD2026 indicat=
or
> LED for X86 Xiaomi Pad2" that series should show up in
> https://git.kernel.org/pub/scm/linux/kernel/git/lee/leds.git/
>
> soon, since this is also LED related I guess this could be merged
> through the LED tree too. Or Lee could provide an IB branch for
> Sebastian to merge that branch + this series through the psy tree.
> Sebastian, what has your preference ?

FWIW, LGTM,
Reviewed-by: Andy Shevchenko <andy@kernel.org>

--=20
With Best Regards,
Andy Shevchenko

