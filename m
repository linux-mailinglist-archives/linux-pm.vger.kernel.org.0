Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B80457722B
	for <lists+linux-pm@lfdr.de>; Sun, 17 Jul 2022 01:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232904AbiGPXIq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 16 Jul 2022 19:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232873AbiGPXIZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 16 Jul 2022 19:08:25 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE7D20BF7
        for <linux-pm@vger.kernel.org>; Sat, 16 Jul 2022 16:08:19 -0700 (PDT)
Received: from mercury (unknown [185.209.196.172])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 533C166015C4;
        Sun, 17 Jul 2022 00:08:18 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1658012898;
        bh=fOXepmQGdVD0J7ZN1PRnhmPW9wplr/+QLS4lPg9kc0w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JOHNl2UYGT9iJzhdb1VSsoWekzPGbq8fLdOU5C9GzUoK+PzTkY8Gqeoek1GOZ+SVF
         OHvFIItLsuAGPr38Q65xBS5T5UsjsYlt9y5pwbSQdIusFQzw+ocSZsl+M6a6emO2rG
         7bbhkaHzK9GoZRyVpJYDMIN8Q7yBK1E45d2HS8O4w39P0Vn2icTww/nrgIuQFjuTG0
         ppBkLXLRGRso8b5SfKAQw4+jf+4wkD3NOokCiCdy4IAcOPADe63wVX/0QKaUYgzcfd
         Rjis0qvMXIq39vmayWrQcpCVovH7zFqSghcba9v41BE7v9oWO//UdA2glrXhThFUY9
         9o33Cu2DCbj9w==
Received: by mercury (Postfix, from userid 1000)
        id 5B1ED1060428; Sun, 17 Jul 2022 01:08:15 +0200 (CEST)
Date:   Sun, 17 Jul 2022 01:08:15 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH] power: ab8500: Remove flush_scheduled_work() call.
Message-ID: <20220716230815.c5wdysxkrl3abkjx@mercury.elektranox.org>
References: <50d84193-a933-1301-b9d9-bf6cc01ee126@I-love.SAKURA.ne.jp>
 <20220609194329.bkvnxmxovnbqxuxg@mercury.elektranox.org>
 <CACRpkdaGAXvSEgR_k3obRv+yjaEDeaKfsYk1R9bvjQ9MY=WHBg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vxlggpunwp3hmwuj"
Content-Disposition: inline
In-Reply-To: <CACRpkdaGAXvSEgR_k3obRv+yjaEDeaKfsYk1R9bvjQ9MY=WHBg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--vxlggpunwp3hmwuj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jun 23, 2022 at 04:24:09PM +0200, Linus Walleij wrote:
> On Thu, Jun 9, 2022 at 9:43 PM Sebastian Reichel
> <sebastian.reichel@collabora.com> wrote:
> > On Thu, Jun 09, 2022 at 01:58:04PM +0900, Tetsuo Handa wrote:
> > > It seems to me that ab8500 driver is using dedicated workqueues and
> > > is not calling schedule{,_delayed}_work{,_on}(). Then, there will be
> > > no work to flush using flush_scheduled_work().
> > >
> > > Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> > > ---
> > > Please see commit c4f135d643823a86 ("workqueue: Wrap flush_workqueue()
> > > using a macro") for background.
> >
> > Looks sensible to me. Adding Linus to Cc and waiting a bit so that
> > he has time to review/test.
>=20
> Makes perfect sense.
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Thanks, queued.

> > @Linus I think it makes sense to add something like this to
> > MAINTAINERS or add the files to the "ARM/NOMADIK/Ux500 ARCHITECTURES"
> > entry, so that you will be CC'd.
> >
> > AB8500 BATTERY AND CHARGER DRIVERS
> > M:      Linus Walleij <linus.walleij@linaro.org>
> > S:      Maintained
> > F:      Documentation/devicetree/bindings/power/supply/*ab8500*
> > F:      Documentation/devicetree/bindings/power/supply/*ab8500*
>=20
> OK I fix something.

Thanks.

-- Sebastian

--vxlggpunwp3hmwuj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmLTRN8ACgkQ2O7X88g7
+ppUaBAAjxTBZFQHqtjYcpgByS2yYkXqZ/o7cWN+rdPWVZVmf3GR7khX6qVjlnfW
hoNvFJVGIg1O34JtG//hPeyCsj/uhA78d7nXYdK559UXJQjHIxi7jfNu+C/NUO1g
s/25TeU706AiWjM1/RQJGaL5Gif05VI4cMHJYrDPljEH5RAgXY93S1363jeZTBZd
wmvIhRTPyLj7asjbl0etWjsT7CJiypd/Lxnuun/PJXp0o6nzR8ectQB2dgTEtEYD
EZYyIoX0AONvwxJrveV4IItocm7yvKr8lEuVHXyHMl1G4arCa9WBWlyT2+BcZYbK
mUrNvu0+fI2v6rb5JxVPOBWH2nXMIJ1CYARc0LtAWqotZaC+lLh5H+1gjQyfQDQb
FytGjHayVjWk7+lyuYJHF9S4dwo6t0KaBuZqWhnLSmqd9cOtasbyBVIhMYpIwrRA
xAkPYeRB3ChryqHbijYuM2t+l1CkhOjRr97HdQ1QoATlprV/45ZjSR+nxSztuQLB
mhSB0dSE0VWi7+4cz8Sf+qg/7pQzAIhYp/W/Z1DHGlWPVKeS8M3tCwLgzrihtI/w
z8TurTwc1rD1R/f45uXVZA+IjAntkKfTJ0vhRzTTHg98P12p9kz+gbLT4l98hFdx
CH7HqtwSnzJmTa0YKXuln1iFaNmVS0i2oXT52JCzl80uhEdLQgM=
=ZWCM
-----END PGP SIGNATURE-----

--vxlggpunwp3hmwuj--
