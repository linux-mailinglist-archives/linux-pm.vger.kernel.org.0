Return-Path: <linux-pm+bounces-26432-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D564EAA4287
	for <lists+linux-pm@lfdr.de>; Wed, 30 Apr 2025 07:38:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E35747A6CEA
	for <lists+linux-pm@lfdr.de>; Wed, 30 Apr 2025 05:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 436E41E3DF9;
	Wed, 30 Apr 2025 05:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TpTCV7Ff"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5871DF256;
	Wed, 30 Apr 2025 05:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745991509; cv=none; b=AN7a+oMs3Wa7QgV+PFcPojSiLRZUvyMIzqxtGnbEH05TAWWGL0/q63DEfWapmUpJiSzxLWDZ1KGrpmWYC/mEYkoMzfyE4qSNzJkcNsajzDkNNNEdVXdA63xG/zi5kx9bjQ0/aMcJdYSMput6nHTyHainWvq5gFUgW17EqeMF9+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745991509; c=relaxed/simple;
	bh=aRRFcZQEq86NHqNCp/LIOL2rz5eJ7YqwxxYfMjimMv8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wp9amcl93AvmtIC3CzysELHKyUwZ9f3YiCZ9Vvzn/FI9tUNA5MZwpfBYRTvI/B1Hufkd2Br1VJ1ccQRkH+5AJWVqOJG3O3KvGIV9yaC03Es8xIFf1fuw8WFT/6XVTN9Ya180tcu84F6safDJDVb0sFajIBwKKT9YYWdk17+yKm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TpTCV7Ff; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-39c1efc457bso4966826f8f.2;
        Tue, 29 Apr 2025 22:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745991506; x=1746596306; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g1vOz9IjbpiH+9TU1yAKVlKjXIIKj0BW1Ww0rtHXedg=;
        b=TpTCV7Ffa8hIaMrG88C21xGXuSuVO+BOM8xwphr3vTOUAPoVMzD1fi4O/eSfbEFsR/
         J3h/HlyqL/02i4X8UBmU08cI90S/2Hi8KZGWkht7ERPD9576ZDP4H0N0EljaEwYO2a5y
         1Pc9nzB5acNWOPGb7FmIHXYlPVhA8WhLnBQf+midx70dYCKVzpli/Huk9gaIznlau6lQ
         lpAYMB2mR2R91OAYe+zlVluRio70JehO+O11sgGZkqmOQJOIM8qxbedVrd25HViM+WjC
         KOjBDAdc6st0Wt/qTAK48DJnMriq/IRSH05IpSo7TALki5rUMngAF+ipDbYj9YwjsWd9
         XaNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745991506; x=1746596306;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g1vOz9IjbpiH+9TU1yAKVlKjXIIKj0BW1Ww0rtHXedg=;
        b=mnbsI+AlXTthoucokjZDHvQPh97mb7fJvm3QFA4+BA/rJcOMOrylXKjzceu5W1A1x3
         mdyhkIG8odL3qSFZuFBjC9+7hRRZUOZv3wXcEh/nSuTE3RtlYEIkueLQekYin5jwN7yj
         j10bgm4OMhXAxPMAMxb8kli5pyCAHTiELC6CJijH6uPAIJetAwLNxSMm/3lw9Q3iYv73
         BMmQYMLNSvWnJUuCosaLdPiIsCnCtLRkap9wOuq70um+ygpNjDGcxDSmjms6V9V7/VJ5
         kB4cWJgS/d1wbntuHMPVq+J5R803OzKMDLnM5iDU6s5XnzyvobHlX1FCbyynxunq8kxT
         mXuQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+s8+FC1Sk31nAIBGVA/2bAp/MXxBTu2ppKOBfXpHTMHBuzviv89K/OWVzpfw+a2MGppKhiXiU3ZthzYo=@vger.kernel.org, AJvYcCXK+hkPVhd1TlD2RcZC7+ddo1pKU5SZAWerI5YP5tGQHOVtnE+h90oFGOu3vjhBemJQrAZ1zJFWg/Q=@vger.kernel.org, AJvYcCXfAXg1HOXVO0UGk1Y08oTnf9QK7O4n907fM4rd2KjaxQuG/VkhY0tShQVYjm1R45jv5ekVpmrCWhWx@vger.kernel.org, AJvYcCXu9Pwmm1G8jzassvRFDeW09ybIzSnP5GyYaDm6+5i6UAjY/NEL/gMTNRfmwLgbjBxRGhhWjnfDrA03ly65@vger.kernel.org
X-Gm-Message-State: AOJu0YypyGlWp+K5JtDlsKlh8gRe0nI941AbJkg9ac2KkQsE0cLBOMu6
	oV5e16QSac1bgQUXpmb9/fUqdIZQzvvJwPbQfq01AYttkytggdfCw4mnAw9moI30gcvDJx3bkck
	HxOzDkwcph51rQUzLEFEjmTcGvio=
X-Gm-Gg: ASbGnctXo4mCxim84/aeN2zGcWZfYhT8Fl0amSxIWGDfUMu3BoG6Axen/v9wWLslWK5
	rLrVqZR7khOvlRP2RslAavLGRTVymNRPtkjm+mZQewaTk9A+Fu+buUtrIgm+zFOF+QAyouahC+U
	CZJhmflhQG2oDkAJDeUdgxdJk=
X-Google-Smtp-Source: AGHT+IEF3biAX+qwcRIhVXaBsHqjCnID1fR7IgjjywRLHdb3Hi+ewh34Uspjc2kaVKPCgKf/AKduAQlqgQ/MadlAK8Q=
X-Received: by 2002:a05:6000:4312:b0:3a0:7a7c:2648 with SMTP id
 ffacd0b85a97d-3a08ff3bd3fmr760243f8f.27.1745991505606; Tue, 29 Apr 2025
 22:38:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250429061803.9581-1-clamor95@gmail.com> <20250429061803.9581-4-clamor95@gmail.com>
 <uem7xcvoqaezqdagp5afdahpkbadyt2xplzq2vgj7rtkb3o2ty@stxwmj5rlhsc>
In-Reply-To: <uem7xcvoqaezqdagp5afdahpkbadyt2xplzq2vgj7rtkb3o2ty@stxwmj5rlhsc>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Wed, 30 Apr 2025 08:38:14 +0300
X-Gm-Features: ATxdqUGCq2a0annnMA6wDKyCPbBVBceXvOPQtMcE-PlrzSlw58mizVM2Ehq57l4
Message-ID: <CAPVz0n0oWB7G_9s5tEov4-E_kADegopMh0mST02Dv9w_e53EZA@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] power: supply: Add driver for Pegatron Chagall battery
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>, 
	Aradhya Bhatia <a-bhatia1@ti.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=81=D1=80, 30 =D0=BA=D0=B2=D1=96=D1=82. 2025=E2=80=AF=D1=80. =D0=BE 01:0=
6 Sebastian Reichel
<sebastian.reichel@collabora.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> Hi,
>
> On Tue, Apr 29, 2025 at 09:18:01AM +0300, Svyatoslav Ryhel wrote:
> > The Pegatron Chagall is an Android tablet utilizing a customized Cypres=
s
> > CG7153AM microcontroller (MCU) as its battery fuel gauge. It supports a
> > single-cell battery and features a dual-color charging LED.
> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >
> > [...]
> >
> > +     cg->white_led.name =3D "power::white";
> > +     cg->white_led.max_brightness =3D 1;
> > +     cg->white_led.flags =3D LED_CORE_SUSPENDRESUME;
> > +     cg->white_led.brightness_set =3D chagall_led_set_brightness_white=
;
> > +     cg->amber_led.default_trigger =3D "chagall-battery-full";
>
> ^^^ I fixed up the typo while applying.
>

Thank you!

> > [...]
>
> Greetings,
>
> -- Sebastian

