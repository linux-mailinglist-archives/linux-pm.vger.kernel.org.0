Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7E92349BE
	for <lists+linux-pm@lfdr.de>; Tue,  4 Jun 2019 16:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbfFDOGj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 4 Jun 2019 10:06:39 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37404 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727137AbfFDOGi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 4 Jun 2019 10:06:38 -0400
Received: by mail-wr1-f67.google.com with SMTP id h1so15991472wro.4;
        Tue, 04 Jun 2019 07:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5oG45nme3hdHX6i7eJJDdyXJn08RFQNe1Cw4gDr1kzo=;
        b=l1kZXPTpG/h5SL2ppPG1oxH/50AMWod0fyK7H1k5L6XYNlLzOlWWk09nKzE7mZg1c3
         0J47cOFkoaMVgS9KUREZp7nNVX0q2pOLkpWCNDUYlKEgxiNkh7Auci7Mn/w9kmWYPl3A
         rWM+YqmOSnbvzwi4mzEhCFWWguAw9mN5Y+3eDhksTpluKc4tG62Wu3r3k+de78ak2mIX
         ydKGBA0VDlIiH0SieVcggYd0IJDMH0tgSDeHaWj7MrUZrfi9v0Cuxe1Rq5YKS/dTJ4UL
         l39suM+FMUxkEh9Yj8xEDTMXtwCWm7fGbMJ3tepMN3dL+nvtTWyyWoXpFOAV/EeQ+diu
         04qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5oG45nme3hdHX6i7eJJDdyXJn08RFQNe1Cw4gDr1kzo=;
        b=DyIWwEB/sv+t/laL3zXf1uZNiZLMPhgS75NVPvUgcxUzaTOcHz6fXOgqEFnAp7MOsx
         VekEr3PUTjvPsgRvy6uzv7gb+AcZ8jvVqZf9hWi/S6J1Fg0f3d9of945pXyrZIKOgK98
         d3SHTwFkgUf8PbJhtUebc0RKLBdfgWeLTwUT/TEHLaXpA2Sz2dzUv28AT+K/xGPlfIdi
         Lsuh0oUQ+y4yYw+SsgSCJkRF24klEB+j46cI7Sqz32WDOlWWfw/dv2OJUWT+4P7v2ACC
         I7LFajloR2uA+kG1VsTSh9plVLo4wzmnlRSfvpx9xVlgZmpwEqrza4Wtb7LlaCTCKVLz
         yCig==
X-Gm-Message-State: APjAAAXcGqxgZZM5WZ1MPOcTYimnYI4f2Jfb0skkZOW1GLeqiNL2uGgP
        P9CCyR56pallef9xl8o+9SI=
X-Google-Smtp-Source: APXvYqxhlCDI9+yb0eU9m/WoaaTM1EvdPdEoRaHkuWKwIv+ipPtNIqJMjpS48mhMWBPaZsqkR8UeMg==
X-Received: by 2002:adf:fd09:: with SMTP id e9mr7283191wrr.292.1559657196193;
        Tue, 04 Jun 2019 07:06:36 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id k185sm2288618wma.3.2019.06.04.07.06.35
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 04 Jun 2019 07:06:35 -0700 (PDT)
Date:   Tue, 4 Jun 2019 16:06:33 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 07/16] PM / devfreq: tegra: Properly disable interrupts
Message-ID: <20190604140633.GA397@ulmo>
References: <20190501233815.32643-1-digetx@gmail.com>
 <20190501233815.32643-8-digetx@gmail.com>
 <20190604110744.GG16519@ulmo>
 <c2f2a8c8-1f30-34aa-9b95-a7a44e0ec96f@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="YZ5djTAD1cGYuMQK"
Content-Disposition: inline
In-Reply-To: <c2f2a8c8-1f30-34aa-9b95-a7a44e0ec96f@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 04, 2019 at 04:40:18PM +0300, Dmitry Osipenko wrote:
> 04.06.2019 14:07, Thierry Reding =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > On Thu, May 02, 2019 at 02:38:06AM +0300, Dmitry Osipenko wrote:
> >> There is no guarantee that interrupt handling isn't running in parallel
> >> with tegra_actmon_disable_interrupts(), hence it is necessary to prote=
ct
> >> DEV_CTRL register accesses and clear IRQ status with ACTMON's IRQ being
> >> disabled in the Interrupt Controller in order to ensure that device
> >> interrupt is indeed being disabled.
> >>
> >> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
> >> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> >> ---
> >>  drivers/devfreq/tegra-devfreq.c | 21 +++++++++++++++------
> >>  1 file changed, 15 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-d=
evfreq.c
> >> index b65313fe3c2e..ce1eb97a2090 100644
> >> --- a/drivers/devfreq/tegra-devfreq.c
> >> +++ b/drivers/devfreq/tegra-devfreq.c
> >> @@ -171,6 +171,8 @@ struct tegra_devfreq {
> >>  	struct notifier_block	rate_change_nb;
> >> =20
> >>  	struct tegra_devfreq_device devices[ARRAY_SIZE(actmon_device_configs=
)];
> >> +
> >> +	int irq;
> >=20
> > Interrupts are typically unsigned int.
> >=20
> >>  };
> >> =20
> >>  struct tegra_actmon_emc_ratio {
> >> @@ -417,6 +419,8 @@ static void tegra_actmon_disable_interrupts(struct=
 tegra_devfreq *tegra)
> >>  	u32 val;
> >>  	unsigned int i;
> >> =20
> >> +	disable_irq(tegra->irq);
> >> +
> >>  	for (i =3D 0; i < ARRAY_SIZE(tegra->devices); i++) {
> >>  		dev =3D &tegra->devices[i];
> >> =20
> >> @@ -427,9 +431,14 @@ static void tegra_actmon_disable_interrupts(struc=
t tegra_devfreq *tegra)
> >>  		val &=3D ~ACTMON_DEV_CTRL_CONSECUTIVE_ABOVE_WMARK_EN;
> >> =20
> >>  		device_writel(dev, val, ACTMON_DEV_CTRL);
> >> +
> >> +		device_writel(dev, ACTMON_INTR_STATUS_CLEAR,
> >> +			      ACTMON_DEV_INTR_STATUS);
> >>  	}
> >> =20
> >>  	actmon_write_barrier(tegra);
> >> +
> >> +	enable_irq(tegra->irq);
> >=20
> > Why do we enable interrupts after this? Is there any use in having the
> > top-level interrupt enabled if nothing's going to generate an interrupt
> > anyway?
>=20
> There is no real point in having the interrupt enabled other than to
> keep the enable count balanced.
>=20
> IIUC, we will need to disable IRQ at the driver's probe time (after
> requesting the IRQ) if we want to avoid that (not really necessary)
> balancing. This is probably something that could be improved in a
> follow-up patches, if desired.
>=20
> >>  }
> >> =20
> >>  static void tegra_actmon_configure_device(struct tegra_devfreq *tegra,
> >> @@ -604,7 +613,6 @@ static int tegra_devfreq_probe(struct platform_dev=
ice *pdev)
> >>  	struct resource *res;
> >>  	unsigned int i;
> >>  	unsigned long rate;
> >> -	int irq;
> >>  	int err;
> >> =20
> >>  	tegra =3D devm_kzalloc(&pdev->dev, sizeof(*tegra), GFP_KERNEL);
> >> @@ -673,15 +681,16 @@ static int tegra_devfreq_probe(struct platform_d=
evice *pdev)
> >>  		dev_pm_opp_add(&pdev->dev, rate, 0);
> >>  	}
> >> =20
> >> -	irq =3D platform_get_irq(pdev, 0);
> >> -	if (irq < 0) {
> >> -		dev_err(&pdev->dev, "Failed to get IRQ: %d\n", irq);
> >> -		return irq;
> >> +	tegra->irq =3D platform_get_irq(pdev, 0);
> >> +	if (tegra->irq < 0) {
> >> +		err =3D tegra->irq;
> >> +		dev_err(&pdev->dev, "Failed to get IRQ: %d\n", err);
> >> +		return err;
> >>  	}
> >=20
> > This is very oddly written. tegra->irq should really be an unsigned int
> > since that's the standard type for interrupt numbers. But since you need
> > to be able to detect errors from platform_get_irq() it now becomes
> > natural to write this as:
> >=20
> > 	err =3D platform_get_irq(pdev, 0);
> > 	if (err < 0) {
> > 		dev_err(...);
> > 		return err;
> > 	}
> >=20
> > 	tegra->irq =3D err;
> >=20
> > Two birds with one stone. I suppose this could be done in a follow-up
> > patch since it isn't practically wrong in your version, so either way:
> >=20
> > Acked-by: Thierry Reding <treding@nvidia.com>
> >=20
>=20
> Thank you for the ACK! Although, I disagree with yours suggestion, to me
> that makes code a bit less straightforward and it's not really
> worthwhile to bloat the code just because technically IRQ's are unsigned
> numbers (we don't care about that). It also makes me a bit uncomfortable
> to see "err" assigned to a variable, I don't think it's a good practice.

Actually you should care that IRQs are unsigned. Implicit casting from
a potentially negative value can hide bugs. That is, once you've passed
that negative value into the IRQ API you loose the context that it could
be an error code. Hence I think it makes sense to always store values in
the native type, and only store them if they are actually valid.

In the above you have an error value in tegra->irq. In this particular
case it's pretty harmless because you don't do anything with it, but if
the circumstances were slightly different that could lead to problems
down the road.

On the other hand what I was proposing makes it pretty clear from the
context that err contains a valid interrupt number when it is assigned
to tegra->irq. There's plenty of similar constructs in the kernel if you
want to grep for it.

Also, it's not bloating the code at all. It's the exact same number of
lines of code as your variant.

Thierry

--YZ5djTAD1cGYuMQK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlz2euUACgkQ3SOs138+
s6E1xg//VEaIimnLjOPKS/SXwj53WZwYcCBxBw0rcz0hfLxvc2koOTQclwrAqcgw
f2kMpXl/rpn95DMuWxu70KLEgHvS/My3LfgoodO89313avryMAu+1qET0GbXmu9P
tiryS6CYPVMloA0NGrYWS1Lv44aQeAS1unn4tl3onioU+gnDJpSRRFQmManC4J0s
ySISWYpVJrWPASFSOWWOyfEk9QbJpn+teL0jQZbmYYGgIxLLGWUsE4ORV8VY6jAj
ayu/q+NyjWhMFXlvHWVfZ9BdnVTJhuJoxXDgc3OVrvSM2PKTYz/aqp+E2JDSVOwA
0lr8vdqPkpiTGlTtkYC0//+gHvoIz9jNQGfsmaUwyrUgKvqnP/MqQVAiKK5wJC8R
+Mentjj58fYwHmGCBBHXajPuBIPokx1O0obvOS9GLexxbOEDo15w5oG5bey6/eK2
WaFmo0UzeGXSB524cxHSyS+CbROwqAHE5INqjtvGRFXANRLiPWWTjh54p/Lz2mnk
KupTm6oKm7kJbnKx0hdnXmoHwmlWa5agXpEQAAMckF7fYfoW/Qvlz7xqamEEl12M
AvyYPGBElEwUFe0QzX3tNPXsZMMN+q6dtw8iQXKcCyaqLVgfPaKw0igyTIGQBGWX
/wFdvaYipW9Bk/BZTdM+IQU8gsLduxMsAfxecamzHTxO3sm9uAQ=
=TosC
-----END PGP SIGNATURE-----

--YZ5djTAD1cGYuMQK--
