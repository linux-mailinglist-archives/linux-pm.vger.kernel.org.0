Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1B5130724
	for <lists+linux-pm@lfdr.de>; Sun,  5 Jan 2020 11:45:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725990AbgAEKpH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 5 Jan 2020 05:45:07 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35066 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbgAEKpH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 5 Jan 2020 05:45:07 -0500
Received: by mail-ed1-f68.google.com with SMTP id f8so1595615edv.2;
        Sun, 05 Jan 2020 02:45:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8ax7Bi05vgrJmzngf+xtOFDsv5kALe+w7MknchjX4Js=;
        b=jfjJ72gUCzGQSVsKpwC18tjNR0thm+bVi0vJ659Am1E3HZrD0MDg9H210eoloZHawg
         Q2NBgN2+nLx2z58apQVVx38cZrSzgp6TBV5NiK4cu7LQ354nLkOXZmv+iHaEmWtutikc
         SnmWE/pqnupASOymwQVnApJhibVOsUmrrKcV6bi4eBZhF47nkJKFTetbjlLQMKbEO6p0
         U+42eRsdzgsureVOlYFWEal3Qn3USeqolGk9yLbF6HeUA3QUp9YPyTqscbTKY3EcKVSn
         vHrUYKwPf/9D9C0StgNcSJ5H0puy4qdGek83fqXTiwgyqfjTy3lqDFY63PTmv9lLN7kO
         WFaQ==
X-Gm-Message-State: APjAAAWlGOBGkromih4SLnVj+FyGJgzmKK/pw/9J1ndqiVlFhb3Q02zn
        Iy1nDUm6MitJwWd0lO7F1ITia2aqlZg=
X-Google-Smtp-Source: APXvYqzJUsUV6CQ30dQsAN3uPqR7MLwvlIhoESVQMxtXze1aDmwPaBuVacFCKnyZ3mmsoR9wPywczw==
X-Received: by 2002:a05:6402:2c3:: with SMTP id b3mr99882659edx.207.1578221105028;
        Sun, 05 Jan 2020 02:45:05 -0800 (PST)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com. [209.85.221.44])
        by smtp.gmail.com with ESMTPSA id qc1sm5909075ejb.49.2020.01.05.02.45.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Jan 2020 02:45:04 -0800 (PST)
Received: by mail-wr1-f44.google.com with SMTP id y11so46490698wrt.6;
        Sun, 05 Jan 2020 02:45:04 -0800 (PST)
X-Received: by 2002:a5d:6b88:: with SMTP id n8mr79214587wrx.288.1578221104126;
 Sun, 05 Jan 2020 02:45:04 -0800 (PST)
MIME-Version: 1.0
References: <20200105012416.23296-1-samuel@sholland.org> <20200105012416.23296-5-samuel@sholland.org>
 <CAGb2v67sphtqQiaFKNjOhRbWXmWpVestuSb89Wdjmp1Lc7dWMg@mail.gmail.com>
In-Reply-To: <CAGb2v67sphtqQiaFKNjOhRbWXmWpVestuSb89Wdjmp1Lc7dWMg@mail.gmail.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Sun, 5 Jan 2020 18:44:52 +0800
X-Gmail-Original-Message-ID: <CAGb2v648d2UFo81shetRfHENwW_f1O8stD_a6x6vu43TEpQ+2A@mail.gmail.com>
Message-ID: <CAGb2v648d2UFo81shetRfHENwW_f1O8stD_a6x6vu43TEpQ+2A@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH v2 4/9] power: supply: axp20x_ac_power: Add
 wakeup control
To:     Samuel Holland <samuel@sholland.org>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Oskari Lemmela <oskari@lemmela.net>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Jan 5, 2020 at 6:24 PM Chen-Yu Tsai <wens@csie.org> wrote:
>
> On Sun, Jan 5, 2020 at 9:24 AM Samuel Holland <samuel@sholland.org> wrote:
> >
> > The AC power supply input can be used as a wakeup source. Hook up the
> > ACIN_PLUGIN IRQ to trigger wakeup based on userspace configuration.
> >
> > To do this, we must remember the list of IRQs for the life of the
> > device. To know how much space to allocate for the flexible array
> > member, we switch from using a NULL sentinel to using an array length.
> >
> > Because we now depend on the specific order of the IRQs (we assume
> > ACIN_PLUGIN is first and always present), failing to acquire an IRQ
> > during probe must be a fatal error.
> >
> > To avoid spuriously waking up the system when the AC power supply is
> > not configured as a wakeup source, we must explicitly disable all non-
> > wake IRQs during system suspend. This is because the SoC's NMI input is
> > shared among all IRQs on the AXP PMIC. Due to the use of regmap-irq, the
> > individual IRQs within the PMIC are nested threaded interrupts, and are
> > therefore not automatically disabled during system suspend.
> >
> > The upshot is that if any other device within the MFD (such as the power
> > key) is an enabled wakeup source, all enabled IRQs within the PMIC will
> > cause wakeup. We still need to call enable_irq_wake() when we *do* want
> > wakeup, in case those other wakeup sources on the PMIC are all disabled.
> >
> > Signed-off-by: Samuel Holland <samuel@sholland.org>
> > ---
> >  drivers/power/supply/axp20x_ac_power.c | 91 +++++++++++++++++++++-----
> >  1 file changed, 74 insertions(+), 17 deletions(-)
> >
> > diff --git a/drivers/power/supply/axp20x_ac_power.c b/drivers/power/supply/axp20x_ac_power.c
> > index bc2663cd47fa..177b5c1eee8f 100644
> > --- a/drivers/power/supply/axp20x_ac_power.c
> > +++ b/drivers/power/supply/axp20x_ac_power.c

[...]

> > @@ -284,12 +335,14 @@ static int axp20x_ac_power_probe(struct platform_device *pdev)
> >                 return -EINVAL;
> >         }
> >
> > -       power = devm_kzalloc(&pdev->dev, sizeof(*power), GFP_KERNEL);
> > +       axp_data = of_device_get_match_data(&pdev->dev);
> > +
> > +       power = devm_kzalloc(&pdev->dev,
> > +                            struct_size(power, irqs, axp_data->num_irq_names),
> > +                            GFP_KERNEL);
> >         if (!power)
> >                 return -ENOMEM;
> >
> > -       axp_data = of_device_get_match_data(&pdev->dev);
> > -
>
> This change doesn't seem related, nor is it needed.

Nevermind, I see it.

> >         if (axp_data->acin_adc) {
> >                 power->acin_v = devm_iio_channel_get(&pdev->dev, "acin_v");
> >                 if (IS_ERR(power->acin_v)) {

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
