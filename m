Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E28739E6BA
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jun 2021 20:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbhFGSgn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Jun 2021 14:36:43 -0400
Received: from mout.gmx.net ([212.227.17.20]:33103 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230289AbhFGSgn (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 7 Jun 2021 14:36:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1623090873;
        bh=veiWrZ68/aRMVKyuCZcb9fLCipe0nVzpbd5nvowzwto=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=TiHYVZPBlxYwHuVwDkOkLhNiD+oSkKmlFe9Rub6y82Im0FhEu5jpsZckZF7yM96dD
         VVUhOxPtUEOVn+m1zPR6t8Tzbgr15rPEFyx+aC+sCy8BJ860x9DGBNb2hUriuXARpq
         91/RROpwDpUgsfZtTVD+K4pfHepexquY1OPPN/4Q=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [217.61.152.109] ([217.61.152.109]) by web-mail.gmx.net
 (3c-app-gmx-bs17.server.lan [172.19.170.69]) (via HTTP); Mon, 7 Jun 2021
 20:34:33 +0200
MIME-Version: 1.0
Message-ID: <trinity-663afc91-2433-4785-af9b-3ca5d4744037-1623090872989@3c-app-gmx-bs17>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Frank Wunderlich <linux@fw-web.de>
Cc:     linux-mediatek@lists.infradead.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Aw: [PATCH v3] thermal: mediatek: add sensors-support
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 7 Jun 2021 20:34:33 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <20210420172308.134685-1-linux@fw-web.de>
References: <20210420172308.134685-1-linux@fw-web.de>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:ip0nyvLzh2YX44Uhf9v4yvoEe2mw7J7QthU4ZFFsIRct1zSudRF6b8ECYw5mNaEH7okJ/
 z6Aw7K+oSZKQJ395RKhHpgLBd+9eGpE57z8+vzav1WvG0oLC1uIeFL9yXzoi3uKJOwhh08K5qdgg
 fv68On+lnP15Sg83+pVQW/B6V90n4c45x76Uj2s3JUpv8GUgv60GXEtWtW+vEtkfRWZwUpjfXKtR
 6X6jE7uIlR8vUUWuyFh28oitByaAHEwCbACBsWZnCrCz8a5bC8onxKMvejxpLPeLzaShU4k5TxX9
 sM=
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:le5utTWPOeM=:0ESx69M38a2u70tlVpp4p3
 cPC0x2W3F2PeIim3TIOx7NXpKt0FouzXxFLZP/apENdqQC0e05iMty/O0LcqPFcxBmvmjWrHI
 xzLgYIUU0n9OB1PeaPuucDEpnSjsmBJkKEl1Fpcrcfk6Ps1tuWWo7bTJ9iHbAfgtgMpszWJcx
 4IOqlDq4/1DE4Ia6Gem2oaC4Lsu3baJDXw6vNr9enB/daksBvprPLb6UN/srjIR2/4GrzlGJn
 Ptmev0EWGNwqE7CngUgovjsUSLeUUtL9g1ARPqMeuS/iHjjtq1CyCm9rp6l9n0gkJ+SwAFMSN
 rn9SgnSTu2j3clYGEGx292yM3U1suyqSMKaxIvL5J0/Vnv5HJ3fWlJ54AHCpRPrtp6uM0Cjwp
 OkqvxTYwJ+Jpx0l8aied93NLgG7ZmzQIOnmrfjqjtjw01XgvI96OHZBWklloVppWZVOeSWt1p
 TuOIREVCe+JzJ7tK6/qRbqhoVJqQnAFoPrREt5bgaGxIrmNAysaIyBTbs/6AWvv26hwZBBWaU
 ei79NFnD/ZbOutVKXt8yKkWuTLLRajEewG1ThAG2BtUbNA+qfbK92tW1BxVdBN+LTNMXgNGbo
 q3OVMIIWINyHemDUpKgHh4M7YLRJ7kt5bU/y3Tr3Dv546vliTkhwfRHPabAJlEFiFOgbctLHZ
 am+L5usw8ZDwun/VjOoIPBs/4+WVpEUVEEMlbYO4xdtvJKtmioe7G0TMdXuWuO2ge6KytcyR4
 MxuNn7WGLYHX2y/78ORbb5yY9cia5GbcNDTPwwlrJZ3woHzcy7HguyWNHyqTLyWHrReli9ouf
 ykAlyTuFoNA+PGNYdB5/5r7EDRW6FStavENNM7gFpyeCVV7UAc=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

just a gentle ping ;)

regards Frank


> Gesendet: Dienstag, 20. April 2021 um 19:23 Uhr
> Von: "Frank Wunderlich" <linux@fw-web.de>
> An: linux-mediatek@lists.infradead.org
> Cc: "Frank Wunderlich" <frank-w@public-files.de>, "Daniel Lezcano" <dani=
el.lezcano@linaro.org>, "Amit Kucheria" <amitk@kernel.org>, "Matthias Brug=
ger" <matthias.bgg@gmail.com>, linux-pm@vger.kernel.org, linux-arm-kernel@=
lists.infradead.org, linux-kernel@vger.kernel.org
> Betreff: [PATCH v3] thermal: mediatek: add sensors-support
>
> From: Frank Wunderlich <frank-w@public-files.de>
>
> add HWMON-support to mediateks thermal driver to allow lm-sensors
> userspace tools read soc temperature
>
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
> v3: drop no_hwmon - now really, sorry
> v2: drop ifdef and used devm_thermal_add_hwmon_sysfs
> ---
>  drivers/thermal/mtk_thermal.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal=
.c
> index 149c6d7fd5a0..85964988684b 100644
> --- a/drivers/thermal/mtk_thermal.c
> +++ b/drivers/thermal/mtk_thermal.c
> @@ -23,6 +23,8 @@
>  #include <linux/reset.h>
>  #include <linux/types.h>
>
> +#include "thermal_hwmon.h"
> +
>  /* AUXADC Registers */
>  #define AUXADC_CON1_SET_V	0x008
>  #define AUXADC_CON1_CLR_V	0x00c
> @@ -1087,6 +1089,10 @@ static int mtk_thermal_probe(struct platform_devi=
ce *pdev)
>  		goto err_disable_clk_peri_therm;
>  	}
>
> +	ret =3D devm_thermal_add_hwmon_sysfs(tzdev);
> +	if (ret)
> +		dev_err(&pdev->dev, "error in thermal_add_hwmon_sysfs");
> +
>  	return 0;
>
>  err_disable_clk_peri_therm:
> --
> 2.25.1
>
>
