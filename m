Return-Path: <linux-pm+bounces-39156-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C8FC9EAB1
	for <lists+linux-pm@lfdr.de>; Wed, 03 Dec 2025 11:14:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 03BD8341724
	for <lists+linux-pm@lfdr.de>; Wed,  3 Dec 2025 10:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F13CA2E8B66;
	Wed,  3 Dec 2025 10:14:18 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313D02E888C
	for <linux-pm@vger.kernel.org>; Wed,  3 Dec 2025 10:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764756858; cv=none; b=CqmORZWDEkoAwBi8qujLrRMGF7/91ww9By2mW4mTNqtoWR1zoT2fYgf2ojQJvk6Fr0e/jNgJQ176dzjiPuBc3FTJj1XKzph+JDNzMq1jB2HMyRcgnUYF3XLqRv7bGBMCW0jYPFjGAXjDHnfIqbHc91qVN3iF7OY3jzTXeiWEOU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764756858; c=relaxed/simple;
	bh=7ykrGGwCG5UVuu6S46Y+mkYJETdoJx86HhNwtYYoBJs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UA5Jomo2bTxoPZZ9c9n1VGRDb8WiLzxgpI+9qdrA+8VpVquCWsq1/26HEatlZhUPhSXOE47fMyjKIpgoxdc5KQPnIQb8TDisRt8rw29yzO73rjHgP7Sz4qWWRpGVrl7VPyj2Ske2yhKj4SceD/KGiafwKV7WJ9AEmesliBirjw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-559748bcf99so5130309e0c.3
        for <linux-pm@vger.kernel.org>; Wed, 03 Dec 2025 02:14:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764756856; x=1765361656;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=08y1I8cftAKXa2ZRDPk1QAbO3eRq2UKMz/WOuMZJTrE=;
        b=shP4cj6jCf7kTEg7NHWjdK4iL+aQ3li4/J+TIHiAwxqDRen3IAJtqfyS5Ss1UKf4V1
         8gqYAXNx3ELDnjNqHkJLHFgQYOOpo0/Ow2CcS6RHc9dOAy2AwrzxjfzpkVitmYHXWEeG
         incgrq7SFIKD++oEf6gRX9IRxmLM8VPTE3xtClWqxjDlDz4nkdT6tuW3zIZGwhtsCGV+
         7ktCGGX/z2JFIheSR3mv2sTTluKaHu4NrkUmEvzQx9sKRIlOeQ2dw01E+eAUJnhdcTDP
         V8XFQQg1cvJZYcYNJwJMqFppdaIovZAnIkmspE6PDsuitaRcAjqgu2+AaYyc+jXiUoGl
         uR9w==
X-Forwarded-Encrypted: i=1; AJvYcCWypTuSqKb770CBGymMcKUDkX0AQFnecMjV3znmPgoxfQWLlbJMXGltJPETN5wEBlQu+JLaLo7wJw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxYH1qXcc6k3l2m6V8IXC/zOCXlKBf66OVz0BAYaP71sKC55zwZ
	r9rtF2pxa2npQUtg3RaIRiq2yTKXXdx3kEtaE3UEjaoDcTw3mWYGIlxOp7OAfJG8
X-Gm-Gg: ASbGncsjdlZ64xnAqQdAvThT9/rDMoynmdjQA250ihJosFC6rWLsnJFUaaa3n8w6mMz
	rQ5k87/IMb3du9hbQoWxAd94W4RCWChyDjC3fr3UC4avfHbA6+twENDyADw8hiOahMhJkcRb3QK
	RmRphe5KGtNDdiqdtS6NomGj1KIi1OrcNIRkNNqdChOuICnBe0uLPqWBzrg084z7TFWf2406cNN
	H+8PoDYYbWcQD93TbpW1B96+LuH8TVcARNdU3zTFiVAOF4yEsTTl0AoUm50ogMUEmUpWC6xp+Hw
	juolNWHdnP3wcuNI9Pxlbu2Kpq3/eHFjB+pUb7dzUoH1+W5Q6RcqMM9uvbKBqLG6d7wc9xCshI7
	lwHSPEp35uaJR+DtwV0Brq7C+5MfrrQ2DG/vm25OC+qGbHvFUWfe8DyVfPBrFFyRZl7rrMkcdaq
	lXyQvhuT4QerooE2xOfDVJP/8gw6g+Z9VQMqu1Ji4Xkb7dk7YNOuWW
X-Google-Smtp-Source: AGHT+IFlj5HHWX5SzOEx20JEvV47thSveIPfWIGcacS8V3NDB+yyN7WzuhDBJ3LSYy0CFsivwyGcsQ==
X-Received: by 2002:a05:6102:5113:b0:5db:d07c:21a9 with SMTP id ada2fe7eead31-5e48e3aa193mr367850137.35.1764756855876;
        Wed, 03 Dec 2025 02:14:15 -0800 (PST)
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com. [209.85.221.179])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5e24dce4a6fsm7121179137.9.2025.12.03.02.14.15
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Dec 2025 02:14:15 -0800 (PST)
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-55b2f2ae1cbso4306364e0c.1
        for <linux-pm@vger.kernel.org>; Wed, 03 Dec 2025 02:14:15 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUi+2i8jwrg8Txii6R1UmJTDl+SImaQntdFAw/HOZ6r+0SJwDC/N/EqlQ2UH3c04bQ1peHxI4k46A==@vger.kernel.org
X-Received: by 2002:a05:6102:579a:b0:5df:c1ac:8ad4 with SMTP id
 ada2fe7eead31-5e48e01012fmr426535137.0.1764756375911; Wed, 03 Dec 2025
 02:06:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015071420.1173068-1-herve.codina@bootlin.com>
 <20251015071420.1173068-2-herve.codina@bootlin.com> <f74ab0a2-b74b-4b96-8469-a716c850e230@gmail.com>
 <CAL_JsqJDOYuzutMHMeFAogd5a_OX6Hwi8Gwz1Vy7HpXgNeYKsg@mail.gmail.com>
 <5cf2a12a-7c66-4622-b4a9-14896c6df005@gmail.com> <CAL_JsqJjm12LxpDg6LmpY=Ro_keHwnrWiYMLVnG=s_pSP4X2WQ@mail.gmail.com>
 <072dde7c-a53c-4525-83ac-57ea38edc0b5@gmail.com> <CAL_JsqKyG98pXGKpL=gxSc92izpzN7YCdq62ZJByhE6aFYs1fw@mail.gmail.com>
 <55076f4b-d523-4f8c-8bd4-0645b790737e@gmail.com> <20251202102619.5cd971cc@bootlin.com>
 <CAMuHMdXogrkTAm=4pC0B+Sybr=PR3XovnBgmiEyTvUMmJHvBRA@mail.gmail.com> <20251202182834.65d7f0a1@bootlin.com>
In-Reply-To: <20251202182834.65d7f0a1@bootlin.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 3 Dec 2025 11:06:04 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU4y3Faz1nJo5CeYdPY9dgetWrLE9bMdba_QeWwXX41CQ@mail.gmail.com>
X-Gm-Features: AWmQ_bm_vwtlSlkiVojLd-rzxo_k4pikXV0aLj6bs5bAdLDXgMj28SXkaqQFKI0
Message-ID: <CAMuHMdU4y3Faz1nJo5CeYdPY9dgetWrLE9bMdba_QeWwXX41CQ@mail.gmail.com>
Subject: Re: [PATCH v4 01/29] Revert "treewide: Fix probing of devices in DT overlays"
To: Herve Codina <herve.codina@bootlin.com>
Cc: Kalle Niemi <kaleposti@gmail.com>, Rob Herring <robh@kernel.org>, 
	Matti Vaittinen <mazziesaccount@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, Peter Rosin <peda@axentia.se>, 
	Arnd Bergmann <arnd@arndb.de>, Saravana Kannan <saravanak@google.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Charles Keepax <ckeepax@opensource.cirrus.com>, 
	Richard Fitzgerald <rf@opensource.cirrus.com>, David Rhodes <david.rhodes@cirrus.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Mark Brown <broonie@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Daniel Scally <djrscally@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Len Brown <lenb@kernel.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>, 
	Dave Jiang <dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
	Dan Williams <dan.j.williams@intel.com>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Wolfram Sang <wsa@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-clk@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-sound@vger.kernel.org, 
	patches@opensource.cirrus.com, linux-gpio@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-spi@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org, 
	Allan Nielsen <allan.nielsen@microchip.com>, Horatiu Vultur <horatiu.vultur@microchip.com>, 
	Steen Hegelund <steen.hegelund@microchip.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Herv=C3=A9,

On Tue, 2 Dec 2025 at 18:29, Herve Codina <herve.codina@bootlin.com> wrote:
> On Tue, 2 Dec 2025 17:35:35 +0100
> Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Tue, 2 Dec 2025 at 10:26, Herve Codina <herve.codina@bootlin.com> wr=
ote:
> > > On Fri, 28 Nov 2025 10:34:57 +0200
> > > Kalle Niemi <kaleposti@gmail.com> wrote:
> > > > >>>>>> Test system testing drivers for ROHM ICs bisected this commi=
t to cause
> > > > >>>>>> BD71847 drivers probe to not be called.
> > > > >>>>> This driver (and overlay support) is in linux-next or somethi=
ng out of
> > > > >>>>> tree on top of linux-next?
> > > > >>>>>
> > > > >>>>> Rob
> > > > >>>> Yes the driver is in mainline linux: /drivers/mfd/rohm-bd718x7=
.c
> > > > >>> I don't see any support to apply overlays in that driver.
> > > > >> Ah. Sorry for the confusion peeps. I asked Kalle to report this =
without
> > > > >> proper consideration. 100% my bad.
> > > > >>
> > > > >> While the bd718x7 drive indeed is mainline (and tested), the act=
ual
> > > > >> 'glue-code' doing the overlay is part of the downstream test
> > > > >> infrastructure. So yes, this is not a bug in upstream kernel - t=
his
> > > > >> falls in the category of an upstream change causing downstream t=
hings to
> > > > >> break. So, feel free to say: "Go fix your code" :)
> > > > >>
> > > > >> Now that this is sorted, if someone is still interested in helpi=
ng us to
> > > > >> get our upstream drivers tested - the downstream piece is just t=
aking
> > > > >> the compiled device-tree overlay at runtime (via bin-attribute f=
ile),
> > > > >> and applying it using the of_overlay_fdt_apply(). The approach i=
s
> > > > >> working for our testing purposes when the device is added to I2C=
/SPI
> > > > >> node which is already enabled. However, in case where we have th=
e I2C
> > > > >> disabled, and enable it in the same overlay where we add the new=
 device
> > > > >> - then the new device does not get probed.
> > > > >>
> > > > >> I would be really grateful if someone had a pointer for us.
> > > > > Seems to be fw_devlink related. I suppose if you turn it off it w=
orks?
> > > > > There's info about the dependencies in sysfs or maybe debugfs. I =
don't
> > > > > remember the details, but that should help to tell you why things
> > > > > aren't probing.
> > >
> > > Rob reverted patches but I plan to continue my work on it.
> > > On my side, I need the reverted patches but I fully understand that, =
on
> > > your side, you need a working system.
> > >
> > > In order to move forward and find a solution for my next iteration, c=
an you
> > > send your overlay (dtso) used in your working and non working cases?
> >
> > Hmm, I must have missed when Rob applied (part of) this series, as I
> > do an overlay test (using the out-of-tree configfs) on top of every
> > (bi-weekly) renesas-drivers release, and saw no issues during the last
> > few months.
> >
> > So I applied this series and tested loading my SPI EEPROM overlay.
> > And it indeed breaks, with the culprit being this particular patch.
> >
> > Interestingly, quoting from this patch:
> >
> >    "While the commit fixed fw_devlink overlay handling for one case, it
> >     broke it for another case. So revert it and redo the fix in a separ=
ate
> >     patch."
> >
> > Where is the separate patch that redid the fix? I assume it is "[PATCH
> > v4 03/29] of: dynamic: Fix overlayed devices not probing because
> > of fw_devlink"?  Unfortunately that doesn't fix the issue for me.
> >
> > Quoting more from this patch:
> >
> >    "Closes: https://lore.kernel.org/lkml/CAMuHMdXEnSD4rRJ-o90x4OprUacN_=
rJgyo8x6=3D9F9rZ+-KzjOg@mail.gmail.com/"
> >
> > Strange that it claims to fix the issue reported there, as the failure
> > mode I am seeing is exactly the same as documented in that report?
> >
> > Do you know what is wrong? The overlay I am using is referenced in
> > the bug report linked above.
>
> The first patch "Fix probing of devices in DT overlays" didn't fix all ca=
ses
> and so Saravana reverted this patch and proposed "of: dynamic: Fix overla=
yed
> devices not probing because of fw_devlink".
>
> This second patch was needed to fix my use case even if more modification=
 were
> needed to have my use case fully fixed (other patches in my series).
>
> Rob applied those first patches from my series and some systems were brok=
en.
> The breakage has been reported my Kalle and Matti and led to a revert of =
culprit
> patches.
>
> I tried to understand what was wrong. I am pretty convinced that modifica=
tion
> done in "of: dynamic: Fix overlayed devices not probing because of fw_dev=
link"
> are really better than modification available in "treewide: Fix probing o=
f
> devices in DT overlays".
>
> I proposed an update [0] and I will be glad if you can also test this upd=
ate
> on your side and give me your feedback.
>
> [0] https://lore.kernel.org/lkml/20251202175836.747593c0@bootlin.com/

Thank you!

Unfortunately this does not fix the problem: I still need to do an extra
overlay rm/add cycle to make the SPI EEPROM work.

In addition, it triggers a bunch of new scary error messages:

rcar_sound ec500000.sound: Failed to create device link (0x180) with
supplier soc for /soc/sound@ec500000/rcar_sound,src/src-0
rcar_sound ec500000.sound: Failed to create device link (0x180) with
supplier soc for /soc/sound@ec500000/rcar_sound,src/src-1
[...]
rcar_sound ec500000.sound: Failed to create device link (0x180) with
supplier soc for /soc/sound@ec500000/rcar_sound,src/src-9
rcar_sound ec500000.sound: Failed to create device link (0x180) with
supplier soc for /soc/sound@ec500000/rcar_sound,ssi/ssi-0
rcar_sound ec500000.sound: Failed to create device link (0x180) with
supplier soc for /soc/sound@ec500000/rcar_sound,ssi/ssi-1
[...]
rcar_sound ec500000.sound: Failed to create device link (0x180) with
supplier soc for /soc/sound@ec500000/rcar_sound,ssi/ssi-9
rcar_sound ec500000.sound: Failed to create device link (0x180) with
supplier soc for /soc/sound@ec500000/rcar_sound,src/src-0
rcar_sound ec500000.sound: Failed to create device link (0x180) with
supplier soc for /soc/sound@ec500000/rcar_sound,src/src-1
[...]
rcar_sound ec500000.sound: Failed to create device link (0x180) with
supplier soc for /soc/sound@ec500000/rcar_sound,src/src-9
rcar_sound ec500000.sound: Failed to create device link (0x180) with
supplier soc for /soc/sound@ec500000/rcar_sound,ssi/ssi-0
rcar_sound ec500000.sound: Failed to create device link (0x180) with
supplier soc for /soc/sound@ec500000/rcar_sound,ssi/ssi-1
[...]
rcar_sound ec500000.sound: Failed to create device link (0x180) with
supplier soc for /soc/sound@ec500000/rcar_sound,ssi/ssi-9

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

