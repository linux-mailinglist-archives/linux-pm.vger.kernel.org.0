Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C91410EBE1
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2019 15:55:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbfLBOzB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Dec 2019 09:55:01 -0500
Received: from mout.gmx.net ([212.227.17.20]:47481 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727362AbfLBOzB (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 2 Dec 2019 09:55:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1575298480;
        bh=pO4twjMhFwzlu5BSTIRckttzQ5eUzZw5pVofzAEoACQ=;
        h=X-UI-Sender-Class:From:To:In-reply-to:Subject:Reply-to:References:
         Date;
        b=UVU4JIQhpUVoYU6bGgXMVkPFAMDEq9g/YGU6WhUIZKkps3seqN4QT47SyTOQT4pki
         GDlQYZgybPMD8nQvc80Ps0nRB1rG47y+QIDUzimH8EZY78e+sTRkrG2V8EexkO4x3a
         LzMnJcS621O/980ACLGBXgwO00ZMuzpO/Um3PuNo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from corona.crabdance.com ([173.228.106.103]) by mail.gmx.com
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MjjCF-1hwNfH0rO7-00lAIR; Mon, 02 Dec 2019 15:54:40 +0100
Received: by corona.crabdance.com (Postfix, from userid 1001)
        id 78AA06E85603; Mon,  2 Dec 2019 06:52:56 -0800 (PST)
From:   Stefan Schaeckeler <schaecsn@gmx.net>
To:     rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, amit.kucheria@verdurent.com,
        heiko@sntech.de, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
In-reply-to: <20191118052413.D729B6E85603@corona.crabdance.com> (message from
        schaecsn on Sun, 17 Nov 2019 21:24:13 -0800 (PST))
Subject: Re: [PATCH] thermal: rockchip: enable hwmon
Reply-to: schaecsn@gmx.net
References:  <20191118052413.D729B6E85603@corona.crabdance.com>
Message-Id: <20191202145256.78AA06E85603@corona.crabdance.com>
Date:   Mon,  2 Dec 2019 06:52:56 -0800 (PST)
X-Provags-ID: V03:K1:DO9/n43e80iU6R7ZGRDJIullECdHSYKNtZWbFAGZOFzyMKqOXcB
 3bjfR4s2Fw/q9vOXCGVeIxffDi+d1jykW1BvMe3ZwtBMhxDGTpxg4T3AbaxriaeWAuaE3Eh
 63V/ipJy9muNtsXzTqjFxvQ75CwXjqyoFUxtsMjd7H3eTlEng5BZSbbZKuCxUIViF/jBsBC
 kCjXydUflFH54BZx9JyQA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:3psRJ6OuQo4=:j5kT/FDHk+toEgfFRieJZO
 wMpJsAqg5CvsIPwcTskinP355X66zmnGFeiILP+cya1QEF3TPTjK5wniZ14t9b2d3CR4E/G4W
 QoVaKKLcHZ2pmCJ2Y4M1zm3NEYZD7L1EWtn1HbS7lhi94HwtQcC8Dj8PDkSHb0lmGZl/XIPtX
 cb4Z1nGEdyk2UESc2e8Tx8P9HQArwTm4NR52go+ohfw6KKpoiYMClMxGSbvcyNjn21QILzP2p
 Z04F5m9o0+uwuDtUcpkU9/0cDsvkMjif8zf4B5HsgOVIMg7rHXre0In2zEOqJ1kQyy9IkfUKa
 QeGEWAQ1OwZEqs6qLoSFNSjOI1EDU8eCYMY7mPgikA2fUk+YyAu7jtAt1nrif5Xrs5p6cyaoL
 pzPeWU7vHwczFQUnKYBDSSaSsEAzRhqDHTMgbCAZHaxIuOa2x8PnKkut8Izo1jiWARUnC15+i
 wKIh72bgSglmHQHVHCJIBUu+fIkAZsnYZrV9xVU+F7+NBDtlFx8+2JZ41XVdhGwtavNWFpK6p
 jPyN+jSoZ2O8dadiE2ls2tsOuFC7DcdJMLcvTRkTUK08b/tktA4IeLgEphYrxHPw45Xol8zgC
 Pbhcg1G5wqoyHckHWyVGTIodZoy73ttwIW0NUTbw5R7D5K6SfiwstOYQxBardySP+weH88GlJ
 kaM7Ci9shzoCUL2Q5oT4+QDlOIe+mc1MGukCSsJRQSXn3cIZ+dtGcYZdcE3gRcpO1S10Hs4Lr
 INgh5L+PJIpi7kDb+c3CFgeyMR3yoPXX2hYWPf89lSz2UHOUyx+JAT69E403myEDMcGMFfxG/
 KDfdCzRcAbclv8d35+GwfRlRRAZ4h1YTQmuZxubXpIb0pSvYbSZd3ua9z54kYO3RTuTuDcDao
 TAy9ErRGZAbSXpdeQ/VilM/9bUi59q0eosCSwaUPBVkPxMrylVmFO9Sb9bbgVIheuZGGWFxD6
 bGJUJ/biKPp5KuC/kGDMOBiD5MtSHJ7uCjR4pvZzDhb2C7vwtE2IIh/7GDzINgnwaW0Ciez5S
 uiAu7UuMYeWoGa6x8eoZvqjEoAU9YX/0wHeHPN3YsPGUfPl2SlvG4uZ8JEhjJaqISld0kmRVx
 WT5f9WYWpTgcIZv8Jf/s3EbJVmvUc4EOZ7T41/VI9y5ybOnIg2kAj+OGoNEfiszwiZwvLIU6K
 0bzpZuDfRyNNue5nhxfLOcAgjNjFnQCYL0B63msjICE5zlHN+teRqur53GU/wWO9+JV7i5Dky
 +XMASyu43OkLS2Y6SSqrp2H0v9Yu8bxijHwE9dQ==
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello linux power management mailing list and others,

New month, new try. Could someone review this patch, please. I would reall=
y
like to see the Rockchip RK3399 temperature sensors hooked up to the hwmon=
 API.

~ Stefan

> Enable hwmon for the soc and gpu temperature sensors.
>
> Signed-off-by: Stefan Schaeckeler <schaecsn@gmx.net>
>
> ---
>  drivers/thermal/rockchip_thermal.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockch=
ip_thermal.c
> index 343c2f5c5a25..e47c60010259 100644
> --- a/drivers/thermal/rockchip_thermal.c
> +++ b/drivers/thermal/rockchip_thermal.c
> @@ -19,6 +19,8 @@
>  #include <linux/mfd/syscon.h>
>  #include <linux/pinctrl/consumer.h>
>
> +#include "thermal_hwmon.h"
> +
>  /**
>   * If the temperature over a period of time High,
>   * the resulting TSHUT gave CRU module,let it reset the entire chip,
> @@ -1321,8 +1323,15 @@ static int rockchip_thermal_probe(struct platform=
_device *pdev)
>
>  	thermal->chip->control(thermal->regs, true);
>
> -	for (i =3D 0; i < thermal->chip->chn_num; i++)
> +	for (i =3D 0; i < thermal->chip->chn_num; i++) {
>  		rockchip_thermal_toggle_sensor(&thermal->sensors[i], true);
> +		thermal->sensors[i].tzd->tzp->no_hwmon =3D false;
> +		error =3D thermal_add_hwmon_sysfs(thermal->sensors[i].tzd);
> +		if (error)
> +			dev_warn(&pdev->dev,
> +				 "failed to register sensor %d with hwmon: %d\n",
> +				 i, error);
> +	}
>
>  	platform_set_drvdata(pdev, thermal);
>
> @@ -1344,6 +1353,7 @@ static int rockchip_thermal_remove(struct platform=
_device *pdev)
>  	for (i =3D 0; i < thermal->chip->chn_num; i++) {
>  		struct rockchip_thermal_sensor *sensor =3D &thermal->sensors[i];
>
> +		thermal_remove_hwmon_sysfs(sensor->tzd);
>  		rockchip_thermal_toggle_sensor(sensor, false);
>  	}
>
> --
> 2.24.0
>
