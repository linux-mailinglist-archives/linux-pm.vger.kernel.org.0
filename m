Return-Path: <linux-pm+bounces-17246-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D32079C29D5
	for <lists+linux-pm@lfdr.de>; Sat,  9 Nov 2024 05:30:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C07A11C21574
	for <lists+linux-pm@lfdr.de>; Sat,  9 Nov 2024 04:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322FB22315;
	Sat,  9 Nov 2024 04:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kxM9qTZt"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AED6A55;
	Sat,  9 Nov 2024 04:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731126643; cv=none; b=bZVEYseoPnHcXh1qXEoOVlXH1oul8fD909iTYz6+fP9cPUriASqc4mlTBJ4y0zwb9r0dS9uBcLqfeNUGDKmVcejnWlUMMJUgx3C9Nf3uKdZ209eGLCwzlEyB6KpemXMV+KzwjCJRjGEV5tcZxB31wgffya6SvoOruZu34E+5Nd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731126643; c=relaxed/simple;
	bh=v3S0Uxy9aWLosqVI3AjsbrwXTYklXNQMqgB5SgHpcqk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MdUwTRKDxH5rGaY9GO+PVfHMImTw4TFrWCj1KkvfOjhwP4eUaAVfyg1Cvc9y86QnHAQqG7h8dY/zvO0FuMPHDop44GWVTqecu9BEh8YkIIgFFRjsPE1LcRLSn4nEjzeAiiucfKiZsaZpnubdOfJ+8KpYzsGbkIHwiRwm9GET7Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kxM9qTZt; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a9a4031f69fso461324966b.0;
        Fri, 08 Nov 2024 20:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731126640; x=1731731440; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rZThpHkzgLYu6UIAvqwDOVBtO2NGvUEElTIpv4BKZkk=;
        b=kxM9qTZtB7bAII+9me5xhRJ7sH/K629lZt3GGKGftxuJBBUbFOHhmW4PyVtXd+FsEA
         ZxF+xAF77bm6KmLOKUsmyACX66wzSwfAve1RKDT5C+tFEucIz4Uj69zceIUA9GVf4+Bq
         mQfYICNjZW4ktP90G+i5mywwTc144AhoUnkYXSXBdIJyOV7eK6DidI30k3W5JIhW1C4h
         RL6/o7jbRR2zClfSYrERaB1LyJDVouj8VQvVegHCDhaAjUbAxKQyabJeN0Te2Rl12mZp
         s51jiP3qmp3ihjGImtcU4DYKc1OZ5ysS2yEnEzf+b4iRj0XRRHBm9BJxpnVI1t/wrxki
         POhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731126640; x=1731731440;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rZThpHkzgLYu6UIAvqwDOVBtO2NGvUEElTIpv4BKZkk=;
        b=uHxbgsqzwxwcVgl9pbExby37JnTJkPnq3DFWEjQc1Btjz94HqzqRwkK55iSi+QFHXp
         v8avkpvL5MXkPAOgKRf9kUP4LCunOWElxK1VBuESaqXMs7VgDOhnDif/zBP77kduWRl6
         ix9B09pUlZNoFaDWE1r42ifomVhVxA5Bsq3d7AhJOw9KOB646OUfHWr2to1agJc+fZMn
         di75/Lvr99WqN3kgapjVptj7QPPDGXYXlKCu1cPX+jLlGYaXoZniiGQ/HUHwhfWaiyCJ
         uTDTBhPUPbA18/Qs2IBhhWCKFxj6Ki7TIET5g+PHHG0PiedZ54seordOV17FEcnDhMD0
         +VHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWkWlv+kSIWJFBfFiN0lmps6OFC9uSGxAYYi1QOOeAdBh/g0JXS+OhzqkfEqpLKU6n9/dXTks36fw==@vger.kernel.org, AJvYcCXse3a09KjqCuQTNTjyAw36LCFaTKl52RIi4zUT7ZdyVwKRJpN1aR/DWeos9qPzY1uaEXI8cLaDdPp2rP7j4uRhcDjQtg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwvRK66jfgfZuZi6rKfLYAwgc23CQv1xkrSTULog9TDRHejlDby
	KP8lCgtLNNiyfzxqDb4+9DGQQI+7ZXRfmFIHY7h6UIDqwJzbdLL8mhyzMKIW9fp/DBHrnDEr7Cj
	MuCUnFj4T6vickAK5EjSr1rGIQ68=
X-Google-Smtp-Source: AGHT+IFBOrzz/VTmw6H7sHjCz1RInm66IQCmEPK5PJRwrVDONRMaVjJ24+kj7QbmRMyEEIhAyBIhJmXctJ2hORgD4OA=
X-Received: by 2002:a17:907:2d88:b0:a9a:c651:e7d9 with SMTP id
 a640c23a62f3a-a9ef00190edmr469756966b.46.1731126638196; Fri, 08 Nov 2024
 20:30:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108232438.269156-1-hdegoede@redhat.com> <20241108232438.269156-2-hdegoede@redhat.com>
In-Reply-To: <20241108232438.269156-2-hdegoede@redhat.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 9 Nov 2024 06:30:02 +0200
Message-ID: <CAHp75VfxCEk1OhQZX8SEk8Enyf6mz1Tt0qxsTX9Xfouw8WOL-g@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] power: supply: power_supply_show_enum_with_available():
 Replace spaces with '_'
To: Hans de Goede <hdegoede@redhat.com>
Cc: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Andy Shevchenko <andy@kernel.org>, Sebastian Reichel <sre@kernel.org>, platform-driver-x86@vger.kernel.org, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
	Jelle van der Waa <jelle@vdwaa.nl>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 9, 2024 at 1:24=E2=80=AFAM Hans de Goede <hdegoede@redhat.com> =
wrote:
>
> Some enum style power-supply properties have text-values / labels for som=
e
> of the enum values containing a space, e.g. "Long Life" for
> POWER_SUPPLY_CHARGE_TYPE_LONGLIFE.
>
> Make power_supply_show_enum_with_available() replace these spaces with
> '_' when showing the available text-values. After this the output for
> a battery which supports "Long Life" will be e.g.:
>
> Fast [Standard] Long_Life
>
> or:
>
> Fast Standard [Long_Life]
>
> Modify power_supply_store_property() to accept both the original text-val=
ue
> with space and the alternative value with the spaces replaced by '_'.
> This allows users to write the value with '_' after seeing this on readin=
g
> the property.

...

> +static void power_supply_escape_spaces(const char *str, char *buf, size_=
t bufsize)
> +{
> +       strscpy(buf, str, bufsize);
> +       strreplace(buf, ' ', '_');
> +}

The bufsize in all cases here is sizeof(buf), making the above to be a
macro we may switch to 2-argument strscpy(). FTR, it embeds the check
that buf is an array.

...

> +       char escaped_label[32];

Even more, the but size seems also the same, can we have buf defined
inside the above?

--=20
With Best Regards,
Andy Shevchenko

