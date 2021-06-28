Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A42F43B5C23
	for <lists+linux-pm@lfdr.de>; Mon, 28 Jun 2021 12:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232629AbhF1KIp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Jun 2021 06:08:45 -0400
Received: from mout.gmx.net ([212.227.17.21]:36185 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232733AbhF1KIk (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 28 Jun 2021 06:08:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1624874759;
        bh=dk+4B2EPDHZqnuPFi/AP937+sSbCnrQEg/Cfq8zAITM=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=YXl1dK9hAWZ72C4yTzIzb3aMOl16gsO59oBhTDhZKEme4UL6I+uWj4S05iEnxlXEg
         VBgueRuyEytdJUJqb5X3JRr1RSHmhAiYWMBb2Qg+Q3evgCAyd9XbjkP+OGq09rDN/g
         tBDrQZGBiJqAJjvShGenywVHm0efBiHIt7WPdy1k=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [80.245.73.39] ([80.245.73.39]) by web-mail.gmx.net
 (3c-app-gmx-bs72.server.lan [172.19.170.208]) (via HTTP); Mon, 28 Jun 2021
 12:05:59 +0200
MIME-Version: 1.0
Message-ID: <trinity-de0268f6-e2f2-4ce9-abdd-8016c593894c-1624874759475@3c-app-gmx-bs72>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Frank Wunderlich <linux@fw-web.de>,
        linux-mediatek@lists.infradead.org,
        Amit Kucheria <amitk@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Aw: Re: [PATCH v4] thermal: mediatek: add sensors-support
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 28 Jun 2021 12:05:59 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <9eb45f06-1303-1438-7ba0-b9ccaa898b34@gmail.com>
References: <20210608154530.70074-1-linux@fw-web.de>
 <9eb45f06-1303-1438-7ba0-b9ccaa898b34@gmail.com>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:uUyJaECQIvtuZsd5/3sgXqXrQh3TqH+yL6eKcIbcVVWsq3fQjrRu0wVKQa9m2PoIHITPh
 tJ66UtdTQ/xrmnIWr+Dj7CaiMpmEsewmmf+dhOHgTWhbG2LMeUj/LzNMlntEZLK+iJ5o2ucwBRWu
 JyITlb2phwUXv3EZiUNKlOozexlFs4SBsQaUPC2jCdApKLuaAwH/GlHe8EqOumGkHjQrOu8OvDu5
 axtiwmh0U9kNN8DQHYV7QPPctXVBvOLLmkAfNKsNXWWVaRgMn0/qfBAm06le1HueANt62Rsv6xkk
 eU=
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:R0LOCk1W4mQ=:RKHoPwjzwWpfhU8Ndp9jD1
 tf+crTRufbN9fEMKGPQBdnG2Ryi6JKeih97sklAm5NCzhXlNRpKKV9jCHs0sjuzggC37fNZJG
 6eZBWJm7k7YNQKK+vCn0Yxu5zom/gVGX87ciV3/902l0WChErYPJsAjRVfi7Rw9mCI8z48STQ
 WN9Vdg5Zfdof6a+QBJ8vrxpQ2HfDZ/4WsleGiM+sy4jRVxBi0joOYGF89Yi1/JQ7CLiUNvlzY
 OVZvAjdZmsUHD1aQPKLmYy9DNJxUW8h0AzxkJmfWBsHpCJ/jWcdff5eg6TdSKWUKZTuPjvKPS
 U4r6Ove+c62huflNXIOwb3CByI+OatBp/VNyXDDBSOG7Jvrkqc+cCkcNPoTMXiFmwkekWXs1V
 IeuTScISTV2RrY7LQ/2hzxzAan2KDFN/wUa6ndbcyl3EjzMnftNn+YV9gBF+lHsMAWCCm1nL3
 SqBtae3j3t5RN8XIba6EVdEufhcJREueJa83/eAG4prmLexYgKV996sVzNvWp9STD+GBY1BS2
 t9QngD6df/+3THpld1Zh50E364uQc8u4v5W1j8iR+2LZWsMaLnLuC2Mk+HtEpd74t4/Gt8Of2
 OF5d75nTIbzb5v3FQPIsICg09x5onCBhO6kbeXcXloJPNEaJDdu9L+XO+aBxF5myfSxTJaEeb
 7khAG/n3HtWfz83dfW7tjJmAFrHrM72YF8QpGr3DUVaucY5Wh+FFrQyf25TcQMMUA62q2ZV7E
 JmsWb/4oC2v/Mj6WdjqtsNFuiZvc0JYOWr+d/WldLFeWgmXTkLq0NhsH7XIaXDOZS0Z46kSwV
 BbnyNv2QskVUBWKLqwmh8jB6mKkinhysnmaBz3Hsy7edx0Axcw=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

A gentle ping as it is reviewed but not yet visible in thermal tree [1] i =
guess it should do,right?

regards Frank

[1] https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git/log/=
?h=3Dthermal/next

> Gesendet: Mittwoch, 09. Juni 2021 um 10:09 Uhr
> Von: "Matthias Brugger" <matthias.bgg@gmail.com>
> An: "Frank Wunderlich" <linux@fw-web.de>, linux-mediatek@lists.infradead=
.org
> Cc: "Frank Wunderlich" <frank-w@public-files.de>, "Daniel Lezcano" <dani=
el.lezcano@linaro.org>, "Amit Kucheria" <amitk@kernel.org>, linux-pm@vger.=
kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel=
.org
> Betreff: Re: [PATCH v4] thermal: mediatek: add sensors-support
>
>
>
> On 08/06/2021 17:45, Frank Wunderlich wrote:
> > From: Frank Wunderlich <frank-w@public-files.de>
> >
> > add HWMON-support to mediateks thermal driver to allow lm-sensors
> > userspace tools read soc temperature
> >
> > Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
>
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
>
> > ---
> > v4: change message to dev_warn as suggested by matthias
> > v3: drop no_hwmon
> > v2: drop ifdef and used devm_thermal_add_hwmon_sysfs
> > ---
> >  drivers/thermal/mtk_thermal.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_therm=
al.c
> > index 97e8678ccf0e..ede94eadddda 100644
> > --- a/drivers/thermal/mtk_thermal.c
> > +++ b/drivers/thermal/mtk_thermal.c
> > @@ -23,6 +23,8 @@
> >  #include <linux/reset.h>
> >  #include <linux/types.h>
> >
> > +#include "thermal_hwmon.h"
> > +
> >  /* AUXADC Registers */
> >  #define AUXADC_CON1_SET_V	0x008
> >  #define AUXADC_CON1_CLR_V	0x00c
> > @@ -1087,6 +1089,10 @@ static int mtk_thermal_probe(struct platform_de=
vice *pdev)
> >  		goto err_disable_clk_peri_therm;
> >  	}
> >
> > +	ret =3D devm_thermal_add_hwmon_sysfs(tzdev);
> > +	if (ret)
> > +		dev_warn(&pdev->dev, "error in thermal_add_hwmon_sysfs");
> > +
> >  	return 0;
> >
> >  err_disable_clk_peri_therm:
> >
>
