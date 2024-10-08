Return-Path: <linux-pm+bounces-15336-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF50994FC1
	for <lists+linux-pm@lfdr.de>; Tue,  8 Oct 2024 15:29:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E377B249FC
	for <lists+linux-pm@lfdr.de>; Tue,  8 Oct 2024 13:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189C21E0B9D;
	Tue,  8 Oct 2024 13:23:47 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA181E0DCC;
	Tue,  8 Oct 2024 13:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728393827; cv=none; b=jLHB3ZO+wr5+LMw+dQX6Ig/4Pif3bu2mdQYacSIKj2OqzsqhaWbKax2GiOb3gDBXGbyaN/g4kr26qQrYaTwhse6j9ZpHXxlt3zao1fs7NHW5IWLeIOLWKVjipmpOlbdHKx65WoBd4M6mcrMwui68AvD8a2vqdoBsPHwJIaIExNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728393827; c=relaxed/simple;
	bh=6OT1XfjuaTyy8T43dxZOB3hKvdIL46jtJEZ9BIPIx3g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s5Mvxhv34we/u8zsg4MEqbfbue71PpFyQ8I23j9d+/hFHWLYVHkGbzSHKBm6bTgaw9jiiPhpwxq7m8fk9mHW0ncDha9yMKh9cXjIV3hswL2e3V0cMhK47m50DRggiZPEhwD3QN7phmDyBdeJ0KFuLhpCCq+xL0IgWwRMm4gGUuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6e2772f7df9so44484607b3.2;
        Tue, 08 Oct 2024 06:23:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728393822; x=1728998622;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nCY3NIx/eYd1xSXTQBGOOuko+7cH0vhvxDiWRgqK6Zw=;
        b=kwuoWMoz3kmf5t9es67h8pKIUnY4N+UxQCj9IMNCnOFIRDroLfNfQowlCp8Pe4ItrK
         1vzDhG0FahnwbAw8C6AWnKhccGf6HK72WwRLu8vxrc/bn08KeJo0pLw1OcYe810eqGIR
         x1nbVpuTFJ29fEqpnKl8ZHSjCEqRaLKUjMQU9M+gY062HOtrHPAijiP04mZwdqj62sgA
         BXzznyHqpBwsBpXbIqM/1yz0hHyY2xkefEMrAYMC9mXBKxY+yXGEJKWoFQPZlg+BLRUZ
         v/mX13LSbeOm7xhyR4y8X1dlsAMrYmCk6nJDzm3JWsy279nC85xFkVKRPpYujblwcPt1
         papw==
X-Forwarded-Encrypted: i=1; AJvYcCU4tVXB4qs1L90tAF9/XfDq0gBlk7Wc7cfBtPMnpNp3iPq1Z9a51/4GRTQ+KNMS0eIHvhEDM//UGXdR@vger.kernel.org, AJvYcCVIR3fm7XmJPUwShnhMH1U1H9NdeMS7hSl1jrqP/eTxfDE7NHaBmDD31BzqIljhuGLzvXP2psyi5c9ugdsoUJsHqL0=@vger.kernel.org, AJvYcCVT07qWShDnqiKeN7j5kA7ujMrCRNOCp9cDSgQR+TtdudhvvsokwZtbPuGKuWZELVq2DVulXI1OpFUP@vger.kernel.org, AJvYcCVd9hnf+jkTSS2WfMv+bt8GaYUtbNJRX8wuDLLUQix8GnEweJRZFXLrt+Oz1GRXk2SmsEbeOOvpboZT@vger.kernel.org, AJvYcCW5tiAHIRJGbVBWZD1RP9RpRkmbLYesZ3daboDQIWjOM30ABimvcxwoFbYgzieOAgxCXB7vgyrucINiWiRx@vger.kernel.org, AJvYcCW7mSOGxncShBgLXIAym4DoUowgagEkGo0qwUkqCkEecmC8LhzpedD81o5GXA0ccwFdmzCEGqXhWtA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxvsvd9xn1lzCsqkTrmTjOQpyp3baME0OimBDE6FZpNJXGreECa
	8iEGBTeCGpia7rdb+ucT9+5dKzZrWq8x0XZREbxFq5wYmtGQtml4IUQdlVaQ
X-Google-Smtp-Source: AGHT+IG9lW3ss6lvHQzkqBRDQWf2Spp+0t7ZgvbHru6AqYI2VcjL0BvfVU2pFedGmTNyKCwJrhXoeQ==
X-Received: by 2002:a05:690c:3010:b0:6db:d7c9:c97b with SMTP id 00721157ae682-6e2c72b2c50mr100116867b3.40.1728393822212;
        Tue, 08 Oct 2024 06:23:42 -0700 (PDT)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com. [209.85.128.177])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e2d93f7d31sm14189067b3.135.2024.10.08.06.23.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2024 06:23:40 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6dde476d3dfso44521347b3.3;
        Tue, 08 Oct 2024 06:23:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU+ISYAIBhuY0g8rE9c8T93ziHCl6aI76ouUTyfgRgHuNI/fgX+ZFedU9ByRlxqdJl4qb0Z0W4dtRs2@vger.kernel.org, AJvYcCUF1LhhaKBvVaHpkjMMbNq9fP2bK68iFLpKHeg8hNoyw9l1VlyniCwLd6CNgytoCH1G+3Qz3GA58kc=@vger.kernel.org, AJvYcCULMidi62rLg1Ft1WgrxSvPid2Kz3EbMWFzz8a9qd7yAXm5yW2IXdDIjTzddbU7Eyr42cHA7svj8Xyk@vger.kernel.org, AJvYcCWICvtZdLkyDvJj/OntEyhNXA+zXg1fhqGWJJtTtSjveehBeJQ7qUi8vpmprQJZ5IZ1IEP4O0+Hsjh72JPX@vger.kernel.org, AJvYcCWwGF9qYeLNNNO7aC9pULxGUXDquM8O+BdN32SrgPJbzmMxQP6hwrK6Woz+efe38HibgvYkJ/kzaK5TkXsWdh7gCgI=@vger.kernel.org, AJvYcCXybXbIoAec9rn4061dvYucXnbh+D49ldnga1Pl9KmdT8zaxwbYGqSXPrj3hXfdoaJ7RZ3jC09gHtJ6@vger.kernel.org
X-Received: by 2002:a05:690c:fc2:b0:6e2:1090:af31 with SMTP id
 00721157ae682-6e2c6fc7e31mr116307267b3.3.1728393819734; Tue, 08 Oct 2024
 06:23:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240822152801.602318-1-claudiu.beznea.uj@bp.renesas.com> <20240822152801.602318-6-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20240822152801.602318-6-claudiu.beznea.uj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 8 Oct 2024 15:23:26 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU_kyPb9VAosStrwmQg9vOMgyogQu==u1XQEBWFQLbSdQ@mail.gmail.com>
Message-ID: <CAMuHMdU_kyPb9VAosStrwmQg9vOMgyogQu==u1XQEBWFQLbSdQ@mail.gmail.com>
Subject: Re: [PATCH 05/16] soc: renesas: sysc: Move RZ/G3S SoC detection on
 SYSC driver
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

Hi Claudiu,

On Thu, Aug 22, 2024 at 5:28=E2=80=AFPM Claudiu <claudiu.beznea@tuxon.dev> =
wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> Now that we have a driver for SYSC driver for RZ/G3S move the SoC detecti=
on
> for RZ/G3S in SYSC driver.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Thanks for your patch!

> --- a/drivers/soc/renesas/rzg3s-sysc.c
> +++ b/drivers/soc/renesas/rzg3s-sysc.c
> @@ -85,6 +97,39 @@ static int rzg3s_sysc_probe(struct platform_device *pd=
ev)
>         sysc->dev =3D dev;
>         spin_lock_init(&sysc->lock);
>
> +       compatible =3D of_get_property(dev->of_node, "compatible", NULL);
> +       if (!compatible)
> +               return -ENODEV;

Please use of_match_device() and of_device_id.compatible instead.

> +
> +       soc_id_start =3D strchr(compatible, ',') + 1;
> +       soc_id_end =3D strchr(compatible, '-');
> +       size =3D soc_id_end - soc_id_start;
> +       if (size > 32)
> +               size =3D 32;
> +       strscpy(soc_id, soc_id_start, size);
> +
> +       soc_dev_attr =3D devm_kzalloc(dev, sizeof(*soc_dev_attr), GFP_KER=
NEL);
> +       if (!soc_dev_attr)
> +               return -ENOMEM;
> +
> +       soc_dev_attr->family =3D "RZ/G3S";
> +       soc_dev_attr->soc_id =3D devm_kstrdup(dev, soc_id, GFP_KERNEL);
> +       if (!soc_dev_attr->soc_id)
> +               return -ENOMEM;
> +
> +       devid =3D readl(sysc->base + RZG3S_SYS_LSI_DEVID);
> +       revision =3D FIELD_GET(RZG3S_SYS_LSI_DEVID_REV, devid);
> +       soc_dev_attr->revision =3D devm_kasprintf(dev, GFP_KERNEL, "%u", =
revision);
> +       if (!soc_dev_attr->revision)
> +               return -ENOMEM;
> +
> +       dev_info(dev, "Detected Renesas %s %s Rev %s\n", soc_dev_attr->fa=
mily,
> +                soc_dev_attr->soc_id, soc_dev_attr->revision);
> +
> +       soc_dev =3D soc_device_register(soc_dev_attr);
> +       if (IS_ERR(soc_dev))
> +               return PTR_ERR(soc_dev);
> +
>         return rzg3s_sysc_reset_probe(sysc, "reset", 0);
>  }

My first thought was "oh no, now this is handled/duplicated in two
places", but if you later migrate the chip identification support for
the rest of RZ/G2L devices to here, it may start to look better ;-)

One caveat is that soc_device_match() can be called quite early in
the boot process, hence renesas_soc_init() is an early_initcall().
So registering the soc_device from a platform_driver might be too late,
especially since fw_devlinks won't help you in this particular case.
However, I think all real early calls to soc_device_match() are gone
since the removal of the support for R-Car H3 ES1.x, and all remaining
calls impact only R-Car and RZ/Gx (not G2L) SoCs.

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

