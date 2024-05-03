Return-Path: <linux-pm+bounces-7466-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A64478BA5EB
	for <lists+linux-pm@lfdr.de>; Fri,  3 May 2024 06:13:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47B7A1F220E5
	for <lists+linux-pm@lfdr.de>; Fri,  3 May 2024 04:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D0AD208DA;
	Fri,  3 May 2024 04:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZL+nVtRf"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FCF1F951;
	Fri,  3 May 2024 04:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714709579; cv=none; b=hh1CWGDcryEiRyN0nE02OKo4MG9TNN+5yw5rl3DHk7bsM+QlzpQlBgcg6oY+3Au6V5sLQ3Ut9QJGDL2a+P0ZsVw3aS3b96fFUxd7y3WSJTECul/47TA7CP1n0Ma3Anqyoct05lZcQL+0sOTOrjQ1Hlw3QqJHGD4Tqeru0qZh28M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714709579; c=relaxed/simple;
	bh=3Ui4WPqD5BgRE7SgeV1kkk/d7gn4oNLSxqpNlox57TQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Suu4fNxxdNQNq8i1Cm06itkUXpsnMTsof1IoiegRuI2In1rV/QRh5w9u5D8Yj/eWkk6886dsrzjUlWpLgFJGHnCXbkF4weK7DwuT8JX2uDxrQkKgU4l/9lX5aR24i2aBrdXhxIoP8Fi2kgwzSnfSUxhLkMsWTAmMb9wTRuytzoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZL+nVtRf; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2e1fa824504so17143671fa.0;
        Thu, 02 May 2024 21:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714709576; x=1715314376; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AFxy0pLNhUuKLCOuJHfi23FeiTbHtiBwSm5DQpbJAF0=;
        b=ZL+nVtRfewr6Ss0ZMJMo0Jf4zwzn9EpDr4oNexrfL2eVWDFtYnH+k+mug+dBcrut+q
         svghUFKyMrCCNw7Z0xxDvhVsnB7xqHrZusLosyIIM/rso51PCv9FCMpK6dGvAluQjXp+
         WLUXxpH814VtYB4KR9/wLjoBt2vWXCirVaL9KKolRVbmH3nJUGKWqJyx5m+lrqBYNI0y
         fnCtrKiqC6IRoi23XZRFSB2K/15sdk3Xm0jaO2pEWrDhDwcBGZcU9UtRdNaJ1tCSY65h
         Y6d3R0mQLDc+D5MnYfu8UYQbjbzOgxu1fgiejwvLDZhp5wY5WWNSBa3f+Ur4JG0pHYrQ
         Th/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714709576; x=1715314376;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AFxy0pLNhUuKLCOuJHfi23FeiTbHtiBwSm5DQpbJAF0=;
        b=vzhNGBOO6vogjVa7vvVEU64zyQXqV7iQTFJX7swj/oz+Rapa6pWifOFGQDpqXbCtQD
         Y1jl71+vCPb79vL3QjS/kDsm9nuNgPSMMsPaizSa2kbs3PPOsvKY0WMAo5QoObR2TZ8s
         2WPBCNfCUMuEFqW1rn71Xd8bcyqNFrqZ1asH3huKVU49WfUOY0L2uQPL5jT1X37BFh9K
         DH6AshbZgbsELdvKXKNS/skmWM5LCyupppjXcHLuIv5VsXqqmkj2ZLoLdeTgs5mQ+Lcm
         DD5FdpgC6YJqPXp3ViVhYWd6PSwQvcDGI8CK0bvy/kAHpzFUYILDub3+zofv3ua5pmaQ
         HBKw==
X-Forwarded-Encrypted: i=1; AJvYcCVr4DEtqUP0WCw9CK4DGOLg5OPGX4qJNiFf3vtKDu2F3CTh0kuNrKhfApwnfceP4yAEoPuQJ9e+6zwyPrX2FEfIcq4EFxgkNzXfTPBCGOk4C7ogc+D4HWvHYF/qP2dzKMcLu048ro2v5hJJ/GLyHSQeQfQl3wR7kZWzA+hdY18uVzd3I72eOTqVKA==
X-Gm-Message-State: AOJu0YwqCFJYHRipBkz6RGHvfkDik0/+yoHYZ6abWGb5k7ajNdj0cwth
	ILav3VtwwTMEjDm/mDVN3rWSuhAHVai5Fgvyy2JqDbSESYqb0MJVF5fgUHyrsrXYZETFExpRipe
	UtrDRZaZZl0dCjmKOux6fOiDVbGQ=
X-Google-Smtp-Source: AGHT+IFqaAxMekfCF51hBaajl97VovKtZBxyj6z8XPSv6aroB6t+62riovpZ580IiLe5Zz3uFysGEoAJKPwk+B85JR8=
X-Received: by 2002:ac2:515a:0:b0:51b:6d63:e0e4 with SMTP id
 q26-20020ac2515a000000b0051b6d63e0e4mr941723lfd.29.1714709575744; Thu, 02 May
 2024 21:12:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240502211425.8678-1-hdegoede@redhat.com>
In-Reply-To: <20240502211425.8678-1-hdegoede@redhat.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 3 May 2024 07:12:19 +0300
Message-ID: <CAHp75VfLYyni8iS2TsB7jkoU8KNUnRxp8Zn6qoqGUmaHUTqxQA@mail.gmail.com>
Subject: Re: [PATCH v8 0/7] KTD2026 indicator LED for X86 Xiaomi Pad2
To: Hans de Goede <hdegoede@redhat.com>
Cc: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Andy Shevchenko <andy@kernel.org>, Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>, 
	Kate Hsuan <hpa@redhat.com>, Sebastian Reichel <sre@kernel.org>, platform-driver-x86@vger.kernel.org, 
	=?UTF-8?Q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>, linux-leds@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 3, 2024 at 12:14=E2=80=AFAM Hans de Goede <hdegoede@redhat.com>=
 wrote:
>
> Hi All,
>
> Here is v8 of Kate's series to add support for Xiaomi Pad2 indicator LED.
>
> I believe this is ready for merging now. Patch 6/7 has an Acked-by from
> Sebastien for merging this patch through the leds tree since it depends
> on the earlier patches. LEDs tree maintainers please merge patches 1-6,
> then patch 7 can be merged through the pdx86 tree indepdently.

independently

>
> This work includes:
> 1. Added the KTD2026 swnode description to describe the LED controller.
> 2. Migrated the original driver to fwnode to support x86 platform.
> 3. Support for multi-color LED trigger event.

for a / events

> 4. The LED shows orange  when charging and the LED shows green when the
>    battery is full.
>
> Moreover, the LED trigger is set to the new trigger, called
> "bq27520-0-charging-orange-full-green" for Xiaomi Pad2 so the LED shows
> orange when charging and the LED shows green when the battery is full.

Reviewed-by: Andy Shevchenko <andy@kernel.org>

One comment regarding use of devm_mutex_init() instead.

--=20
With Best Regards,
Andy Shevchenko

