Return-Path: <linux-pm+bounces-15344-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ABEA995248
	for <lists+linux-pm@lfdr.de>; Tue,  8 Oct 2024 16:48:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02463287DD5
	for <lists+linux-pm@lfdr.de>; Tue,  8 Oct 2024 14:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F25B01DFE25;
	Tue,  8 Oct 2024 14:47:07 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7C81DF755;
	Tue,  8 Oct 2024 14:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728398827; cv=none; b=ntEKgEdQ75MMAsPdrxQBBbrCft1+SwRNkv8f0UT5LM2ksFKjF1/LjDZ6p5rqZED75ti8CdyFMidwxqdJwvslrqoG8II1mW5TwD78tSm7hwNSJ6p8Bacj/CrW5+3n04GTY11YB4OqZM84IKQ/w+PeZxrvGR0yZ0IDmia9YN04BlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728398827; c=relaxed/simple;
	bh=Y+zb33rVNjC2YbQs4WVewPjUBmIgniiq3rKNIeCtAQg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a+mlLkA0n0z598C6fkjjyncJ2s9es9irCfuQr5r0obeCP8lbMK2XrP4sYNtYppgAqAh4Q4/ngtgDMBLSCRRGYbXLQQrlQOTSxpLPMqZ3JucvIKUnJDlo0VgSrXes1ckHtjnMlkVwUxVO06W+uh2CjF2Q5YKSPvk3wIdVyc6CEbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e28e4451e0bso1479174276.0;
        Tue, 08 Oct 2024 07:47:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728398823; x=1729003623;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T5tpkiwx88FstrMnILDOBEQgP7OPo4qJyWyTH6XGvRU=;
        b=iHOrF0+MjPxqBtLrQWQwV12f3ZLd1d69YbkPMTiJquEVprARh4M4/CSLZJT0lnC5iT
         7DtZcebT5YbI1cuqHBosOqKOGvakuX0ALEAAlfYUyrw0OZNOMUhErgust/W7X20IOhBR
         Z6BMwHg3U7Vc6FwFxgJ6twjGD9RtSPeKC9Axea/DVWhnp6QCHhpzlTidW4EEOCwkuka6
         Px/+C4WaJQnl4El3rtrE7a10BYWu/KC5VgJGlp9HXGfSuLtc6QLY+DeYDdnryr5yKuNZ
         k+GLO5qxUS7fS+tOXVm++dJFyZenGvDxUlEaUMQPjKNpT03WJXLkPkEiHwElkeAclbo8
         TgRg==
X-Forwarded-Encrypted: i=1; AJvYcCVMv5l4K6+4pZdN30z/hwZ/Qo+Tp8pbvJcclie2RgP55F21xBrCt1KvR5VYo7YEyQycZjQHOfzhIytH@vger.kernel.org, AJvYcCVT4ZyhCql4BA39NaM7FaXm37nvlcDDFdn37CBR8x9LBag9C6uSGOw4PGKo7p7R4td7MI2vOxeYsh6x@vger.kernel.org, AJvYcCWH3zzwo/7ROcDacGklkRqco5iC308CblmwL4BT9g2UU0aknkZ+qzsJri9nA7po/KyCZVxhAS1qabEpyPkVVMtjwSs=@vger.kernel.org, AJvYcCWpBbUhW4a9hHRyL54xf6kitb/7Cfxs3GlEyN2kqqiT/MhqDCi9/uzCt0+nARnqSxgKKalXdy1H16M=@vger.kernel.org, AJvYcCXlJRVjWvnd3H79BQrFm967SzjksjKMnwQP7Wezd3QjaIJ4OxdWO0TX7U7qIlRTn8a2VLMXeqN/2fJT@vger.kernel.org, AJvYcCXwyebo0+QwS843ex+ksJwkeV3WFauxREmdJ/7nzko2XyjCiEnN8MkCQSECNJ9VvYcqoyCTLLMQVjcVcPpO@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd5YPrQqh2MetPZmHjhjGp2yLG71d+P2Mpzk6PKDhJuerSQ2cR
	UJzXB8enjcmOZ6GpOHvcPr/DrAc3hu4B7XBCBNZAd27FhOIK7zURwA+70iAU
X-Google-Smtp-Source: AGHT+IFlFWCicYCbRCtgun2HTOedWzJ/rIDScEBfLYhC3O+ChUgJABpyQ+DpaCSgOEirqxGjfq0pWw==
X-Received: by 2002:a05:6902:1b06:b0:e25:e358:cb4c with SMTP id 3f1490d57ef6-e289393eb3dmr11578229276.40.1728398823173;
        Tue, 08 Oct 2024 07:47:03 -0700 (PDT)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com. [209.85.128.175])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e28a593b359sm1369503276.1.2024.10.08.07.47.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2024 07:47:01 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6e20a8141c7so48085387b3.0;
        Tue, 08 Oct 2024 07:47:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUctkYi9VK4uCrc3fvujAdJYbxfO/cQvSAS1JsM7UYXI2oqwWQPhcL40LLu9FScdtB7hMd6rNz1Uch3/vBcjlAQJWQ=@vger.kernel.org, AJvYcCUs2u48/B7FQX7K/EFLHIGykBIcLg+dsUZ5yvGmIEF7A1dDUMU2lwOkDmQHP+7GPjq7IrUa8ImXop4=@vger.kernel.org, AJvYcCUznzZj31bFfZ7osiuz4m1eYFRo5tFY00t+VSj0lHs/IhUNJWf1QhJGkvnMLfHF7UofNLxR55Ww1sBZ@vger.kernel.org, AJvYcCVDPC2wyqHL9/7M3LDDP/SJoRe9U2jZL7Y3vip02IPI9n8u8DvLqrCCtZqOdbkXFotRWf5rZHznnHcf@vger.kernel.org, AJvYcCWImSDe+FCKgui4y+oU5o1B2jbA+NYjzCCxxUSP/C70XEpLBIoUala90nocvkJLSM9fuv4L9k4lgD7c@vger.kernel.org, AJvYcCXMJv2J48znTfgPCOJIDcGoQvC5cseAfzv/bHo5HaLanrMnseSLopqqwkAWSrPcni7wO9Hdnruwbg9wBElU@vger.kernel.org
X-Received: by 2002:a05:690c:fd1:b0:6e2:f32:bd2c with SMTP id
 00721157ae682-6e2c72f6ac7mr126767947b3.29.1728398821134; Tue, 08 Oct 2024
 07:47:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240822152801.602318-1-claudiu.beznea.uj@bp.renesas.com> <20240822152801.602318-8-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20240822152801.602318-8-claudiu.beznea.uj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 8 Oct 2024 16:46:49 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWcCGMf0At7=DN_PydZyriiOcpR=YQAqw-xsARSVF6Wyg@mail.gmail.com>
Message-ID: <CAMuHMdWcCGMf0At7=DN_PydZyriiOcpR=YQAqw-xsARSVF6Wyg@mail.gmail.com>
Subject: Re: [PATCH 07/16] reset: rzg2l-usbphy-ctrl: Get reset control array
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: vkoul@kernel.org, kishon@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, p.zabel@pengutronix.de, magnus.damm@gmail.com, 
	gregkh@linuxfoundation.org, mturquette@baylibre.com, sboyd@kernel.org, 
	yoshihiro.shimoda.uh@renesas.com, biju.das.jz@bp.renesas.com, 
	ulf.hansson@linaro.org, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, 
	linux-pm@vger.kernel.org, Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2024 at 5:28=E2=80=AFPM Claudiu <claudiu.beznea@tuxon.dev> =
wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> Before accessing the USB area of the RZ/G3S SoC the PWRRDY bit of the
> SYS_USB_PWRRDY register need to be cleared. When USB area is not used the
> PWRRDY bit of the SYS_USB_PWRRDY register need to be set. This register i=
s
> in the SYSC controller address space and the assert/de-assert of the
> signal handled by SYSC_USB_PWRRDY was implemented as a reset signal.
>
> The USB modules available on the RZ/G3S SoC that need this bit set are:
> - USB ch0 (supporting host and peripheral mode)
> - USB ch2 (supporting host mode)
> - USBPHY control
>
> As the USBPHY control is the root device for all the other USB channels
> (USB ch0, USB ch1) add support to set the PWRRDY for the USB area when
> initializing the USBPHY control. As this is done though reset signals
> get the reset array in the USBPHY control driver.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

