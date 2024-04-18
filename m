Return-Path: <linux-pm+bounces-6615-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 462768A933F
	for <lists+linux-pm@lfdr.de>; Thu, 18 Apr 2024 08:40:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1474281EA4
	for <lists+linux-pm@lfdr.de>; Thu, 18 Apr 2024 06:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1854126AF0;
	Thu, 18 Apr 2024 06:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U9/1ulFU"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A20F21103
	for <linux-pm@vger.kernel.org>; Thu, 18 Apr 2024 06:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713422422; cv=none; b=I01piTv1ki0td1zJwMl358RkbCFff8uJcHINDJDx3wahDN1FerTStH64ixvt91s5FGlztrZwGsN5dXQgSP+DslO39/HjU3cF9z1hidCyuk8AMK7imCtYCVy+k3PbJMSOAQvmDS1Y8ciBsbX1GcE8yfDsgV00Myd6RiMYaRToZUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713422422; c=relaxed/simple;
	bh=EH03m7eOfHhtp/BcJ5vnIqquDs8mG7Y94m4YaqVAYs4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M8wDRBoOEtb4+lPENe6lVh0Nb8g8iaSzdeO+S8UDlNVQ5tluGyeF/uL8dITlKPZofD6SpZj5F5UY1gw/ZQCGT20wkvWUCmivXM5fUPdb+Ak1ekTPVpgHjyHlJpeqhVbPSQjU3FWfeAdf/hB9j92J9DKKJIzrrdBPP0kKPu/41OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U9/1ulFU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713422420;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lNvjTCc6FwOgFUSAbxLYa6iTeIgRgSjn22Bb0lwJRLg=;
	b=U9/1ulFUBzqd6S2PbUKeGYTv/zUsnalOvMDqvorK1XjMuZ1yO0vKzI/mbBokQD4Mooi+A/
	U5EdJJVtaICPTgJ6OCyQlQb8cMXyYtAM+zwiAX2UXBTdbilwtJxmJqyxaDQfERFcf2e3vo
	LDEpLwK3TXi/fo/uarMOupUOwlXkDNg=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-b3ZKLg6dMJy_edUXS9ICSA-1; Thu, 18 Apr 2024 02:40:19 -0400
X-MC-Unique: b3ZKLg6dMJy_edUXS9ICSA-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-5cf555b2a53so1157377a12.1
        for <linux-pm@vger.kernel.org>; Wed, 17 Apr 2024 23:40:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713422418; x=1714027218;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lNvjTCc6FwOgFUSAbxLYa6iTeIgRgSjn22Bb0lwJRLg=;
        b=FHrve0WS43jwkzUamnoFQmKAVYVaixseXIkEVbiUUuAX9RJYkI2pQJSy6LVkhmteT3
         cJiZGVQ/l5SDddKPno8MpZJP3wvkVES74IrwNXmHOgU6r+qvj066Tn3sctnNFPDbjrza
         Nomd/GeCdKAdr3XFeqPVcfxju+nveJYjhFnnPrV2Zw3amtaP6rJ703SxlrKb8NRcNUpR
         YDUybGK2Wf6h/9EoJ9NIUIJYt+WIHSlF3gb/7yYQ3ZsL51iWhWvYSfZjpcg3R/94YLSW
         Ykoa+Wig55N8SK+Uh8+47DYLTON1gKXaCpIZIUp6eQH6FS4E/Bfx9rQ2u2vIuBbkNqyT
         6ulw==
X-Forwarded-Encrypted: i=1; AJvYcCUKVJzt88lw6u4hIJpvD+eqKcXH3o4MIaLQOJZp3o1k1lHO36790tDKCFzQJSYpntjx2ZMhDYfo1co83ZL+kKbUSQ5iqN/hMbI=
X-Gm-Message-State: AOJu0YzglheHxftfnr0UOLCcYgLzbxCuSArZQ2Y1JFlF6PY2kdKV8489
	R3sd9MlKIjpzzjrV0KUaPfD98TCkwDUdiS5YihOWCyn5OXeKCRx0x0A0GOd0Uhv/vfMuJa97XWi
	Y1Qd19z8JRu4CJRhJvLzLu0nlF3CwirM0v7Ltc6x6M0t7uWebjgYKN1+ngVSk1XewPKru2J0xCT
	6peRPYY9CktIPMw86YJi5VtMM/P+M0X34=
X-Received: by 2002:a17:90a:f298:b0:2a4:6ce7:37ad with SMTP id fs24-20020a17090af29800b002a46ce737admr2168452pjb.5.1713422417936;
        Wed, 17 Apr 2024 23:40:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8Nqu/T3TcMgalwb0fgZz/LJ+EbTdQaBlb847ZkHwH6OthK4zjz68lfXhfvPUEvk2KNoUUWyOlK+WujobCKuY=
X-Received: by 2002:a17:90a:f298:b0:2a4:6ce7:37ad with SMTP id
 fs24-20020a17090af29800b002a46ce737admr2168419pjb.5.1713422417577; Wed, 17
 Apr 2024 23:40:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240416053909.256319-5-hpa@redhat.com> <202404170023.1zEGO9ja-lkp@intel.com>
 <CAHp75VeKCGSZTb5bGU4YNr9r-z+gXmk4GC5HOZCFcoRQRN37CA@mail.gmail.com>
In-Reply-To: <CAHp75VeKCGSZTb5bGU4YNr9r-z+gXmk4GC5HOZCFcoRQRN37CA@mail.gmail.com>
From: Kate Hsuan <hpa@redhat.com>
Date: Thu, 18 Apr 2024 14:40:06 +0800
Message-ID: <CAEth8oF8rXABQqhM89QH4dR=Gqjv-ZkwPHWMEfy434jN6eOtbg@mail.gmail.com>
Subject: Re: [PATCH v6 4/5] power: supply: power-supply-leds: Add
 charging_orange_full_green trigger for RGB LED
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: kernel test robot <lkp@intel.com>, Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>, 
	linux-leds@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
	Hans de Goede <hdegoede@redhat.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	=?UTF-8?Q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>, 
	linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, 
	oe-kbuild-all@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Apr 17, 2024 at 1:34=E2=80=AFAM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Tue, Apr 16, 2024 at 8:03=E2=80=AFPM kernel test robot <lkp@intel.com>=
 wrote:
> >
> > Hi Kate,
> >
> > kernel test robot noticed the following build errors:
>
> > All errors (new ones prefixed by >>):
> >
> >    drivers/power/supply/power_supply_leds.c: In function 'power_supply_=
update_bat_leds':
> > >> drivers/power/supply/power_supply_leds.c:42:17: error: implicit decl=
aration of function 'led_mc_trigger_event'; did you mean 'led_trigger_event=
'? [-Werror=3Dimplicit-function-declaration]
> >       42 |                 led_mc_trigger_event(psy->charging_orange_fu=
ll_green_trig,
> >          |                 ^~~~~~~~~~~~~~~~~~~~
> >          |                 led_trigger_event
> >    cc1: some warnings being treated as errors
>
> Probably you need a new dependency or so.

I will include Hans' two patches for led_mc_trigger_event() in v7 patch.

>
> --
> With Best Regards,
> Andy Shevchenko
>


--=20
BR,
Kate


