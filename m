Return-Path: <linux-pm+bounces-7465-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E71688BA5E7
	for <lists+linux-pm@lfdr.de>; Fri,  3 May 2024 06:10:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 878E1281709
	for <lists+linux-pm@lfdr.de>; Fri,  3 May 2024 04:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB562033A;
	Fri,  3 May 2024 04:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V9SEKv3q"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7871114F62;
	Fri,  3 May 2024 04:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714709451; cv=none; b=ezswlLzC8sQ7FDk5OJT1ttG0ASghWcRO9avr+SO9gzBGhD9CgIM4wductrzWyiTGgIKwi5h3jLpmCt3XnboNYka1TkR/nU81pG8CbRwmhv/zdsYKWjYRJMep5EtFWrMaysRMBWqnayxuWrk8+ZMYFtKfmiPHqXlAJkQhYr4cnug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714709451; c=relaxed/simple;
	bh=Pn8wOkWwNvxYZ7Vv1FaFcQq+js3Jglm2l8IYiJRYdAk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R+sU9J32TSHUj6qnmuwDTmvsNz5g6XUohd04QOaWTcQTtqwc9O0xAtUeB2Up9biNVv0IoBPgxUFbctLSqxzx3jzo9E5uIpgxOwx1/BY25Wjf8XeGuM2zr1KApCPcuthKdG1wiV6wcsQx6sQBRKMtM0PMQPEC175nsHGUMSlyahQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V9SEKv3q; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a52223e004dso1039400066b.2;
        Thu, 02 May 2024 21:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714709449; x=1715314249; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NkrXRclorIblbljSqK7bMmQZtO5xSNYIqmrSATHeQlM=;
        b=V9SEKv3q957IDR8r4+P/NG6wgJpghlTBNh0agxux+Yfi52/Cyk5Qrsp6KVfsnpHGkN
         An/Kiytp4E81fN/xQ9G1jCjxC8bElvjswUg/21OtlcpKTwA+BmyenE7MFDssCoU79KTR
         jTbqgigsm7hIZlIlO7Wl1e2cZ2YPfNzkrAokbsEWM4nt6wdfDhSPBY7lu5jb6xUn6/ue
         EVTPJh9Yy5G6lCywgjn0L8O4Xzdwp3vnX0fnhzIe+Lte/+vFSdS3yMFIMrubWdmJJVSG
         /KQYQdU40WuZ20x27MXSVUNq7HXet4K3E6rsARNApJGVdi49Lzy1Jz6natcMox82+xNp
         laHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714709449; x=1715314249;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NkrXRclorIblbljSqK7bMmQZtO5xSNYIqmrSATHeQlM=;
        b=RfCbr3HrqGu7d4UQWwoKvvDAXeSGBthgcv0PYBa/hjxT/0x+MHX7oZKAFNVtFR+MD1
         EHjgce64Wgj55ng03RESPdrHPsN/bFbExjdL9gSH/0/LziMITM74wIWpHh+dhboMsNGF
         gEN24EEmrGF2NxtN3DwfPlplwBePdhxkbpeooo3TOmXeKln0JgTi00Dr49empNV8uvYp
         o3AqFnpTHb8xxeg1r4zZfzGYkwD4ZB84Uq5wIW1BAV6jVfUD9CWUHDC5kueyqEE9sxU3
         RIciXvBrZQQKnPCxGbBYa8kVntHYBPwmlooKhk0W//m1FTIlOO7cDC3GQrWIs9SULlk+
         7WJA==
X-Forwarded-Encrypted: i=1; AJvYcCXk7dOYFW375LqT19GX1V7oR0dJv6qGSnUC7S0ta6BDyu7xET+G3wnSS7TKE0mzi1m3YuxR+zflopISb/kJtmYNMdyRZkOpUPM0A0TkCzoiJoJQO60/FBwP/ClFBZI7cYERmBc9OwhCzTwMNIYgJKVakz935jvdWCpajuON0QAVXdd633ptQG1z8A==
X-Gm-Message-State: AOJu0YwCWcX1brlLfLmSN/zfrMfJVZoYdGxvByKHIM4QMvM/aQcvhO/i
	z4VWZHXTiRXNK0bR2GdG1EECTY6DePB2JJEH0OMKwj8RkSHqeimLuI1qtD9jtnWrC79MpJ4n+Nc
	I/IAZ3CwzQfeXOf/qCBWeP4YKg1A=
X-Google-Smtp-Source: AGHT+IF9GGLhxOwKBZYH5+zGl83ulrFRzjbXWNeYsTgfFEBwN4JB+DXqu42t34I0G4Grg12vG9rHZp1zqeIg0CUggnk=
X-Received: by 2002:a17:907:7d8f:b0:a59:9876:1168 with SMTP id
 oz15-20020a1709077d8f00b00a5998761168mr19370ejc.45.1714709448749; Thu, 02 May
 2024 21:10:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240502211425.8678-1-hdegoede@redhat.com> <20240502211425.8678-7-hdegoede@redhat.com>
In-Reply-To: <20240502211425.8678-7-hdegoede@redhat.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 3 May 2024 07:10:12 +0300
Message-ID: <CAHp75VfOk2eeJM3SVPyhgCa6Ub5baAp=Yw_T1iMPTgpGY1q6pw@mail.gmail.com>
Subject: Re: [PATCH v8 6/7] power: supply: power-supply-leds: Add
 charging_orange_full_green trigger for RGB LED
To: Hans de Goede <hdegoede@redhat.com>
Cc: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Andy Shevchenko <andy@kernel.org>, Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>, 
	Kate Hsuan <hpa@redhat.com>, Sebastian Reichel <sre@kernel.org>, platform-driver-x86@vger.kernel.org, 
	=?UTF-8?Q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>, linux-leds@vger.kernel.org, 
	linux-pm@vger.kernel.org, Sebastian Reichel <sebastian.reichel@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 3, 2024 at 12:14=E2=80=AFAM Hans de Goede <hdegoede@redhat.com>=
 wrote:
>
> From: Kate Hsuan <hpa@redhat.com>
>
> Add a charging_orange_full_green LED trigger and the trigger is based on
> led_mc_trigger_event() which can set an RGB LED when the trigger is
> triggered. The LED will show orange when the battery status is charging.
> The LED will show green when the battery status is full.

...


> +       psy->charging_orange_full_green_trig_name =3D kasprintf(GFP_KERNE=
L,
> +               "%s-charging-orange-full-green", psy->desc->name);
> +       if (!psy->charging_orange_full_green_trig_name)
> +               goto charging_red_full_green_failed;

Side note(s): Actually this function (as I can see the current code)
can be made neater with a temporary variable for allocated memory, but
also entire file can be converted to cleanup.h at some point.

--=20
With Best Regards,
Andy Shevchenko

