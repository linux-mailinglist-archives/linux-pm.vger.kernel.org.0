Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 432B316AA55
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2020 16:41:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727862AbgBXPl1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Feb 2020 10:41:27 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:53416 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727693AbgBXPl1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Feb 2020 10:41:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1582558884; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fnPhE73HTy68X/79Rt5u8gCjBCrld9+dBbPxi+dCrNI=;
        b=v00QjoGLGTqTESjdja8nQObk1SPFB5J2u9i/yBPFdYFCSvLTENiE2m77BTDMlSSagQnrnJ
        EZC8oSS8wjLnETNhylVvbwntdHPOHX7WEf9bUT5ccoZJQsCNrBw7LZQTF70dNdG9ApXSdj
        SsvEr6iZZsKab6ec4KH1AidT97EWpTA=
Date:   Mon, 24 Feb 2020 12:41:09 -0300
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [RFC PATCH 3/3] mmc: jz4740: Use pm_sleep_ptr() macro
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        od@zcrc.me, Linux PM <linux-pm@vger.kernel.org>,
        linux-mmc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-Id: <1582558869.3.4@crapouillou.net>
In-Reply-To: <CAPDyKFquXSB+ztXZQS4MPV20dRN_-CKJkmCF0A97pG+vJYRsbg@mail.gmail.com>
References: <20200211160321.22124-1-paul@crapouillou.net>
        <20200211160321.22124-4-paul@crapouillou.net>
        <CAPDyKFquXSB+ztXZQS4MPV20dRN_-CKJkmCF0A97pG+vJYRsbg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Ulf,


Le jeu., f=E9vr. 20, 2020 at 14:38, Ulf Hansson <ulf.hansson@linaro.org>=20
a =E9crit :
> On Tue, 11 Feb 2020 at 17:03, Paul Cercueil <paul@crapouillou.net>=20
> wrote:
>>=20
>>  Use the newly introduced pm_sleep_ptr() macro to simplify the code.
>>=20
>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>  ---
>>   drivers/mmc/host/jz4740_mmc.c | 12 +++---------
>>   1 file changed, 3 insertions(+), 9 deletions(-)
>>=20
>>  diff --git a/drivers/mmc/host/jz4740_mmc.c=20
>> b/drivers/mmc/host/jz4740_mmc.c
>>  index fbae87d1f017..09554f9831de 100644
>>  --- a/drivers/mmc/host/jz4740_mmc.c
>>  +++ b/drivers/mmc/host/jz4740_mmc.c
>>  @@ -1099,24 +1099,18 @@ static int jz4740_mmc_remove(struct=20
>> platform_device *pdev)
>>          return 0;
>>   }
>>=20
>>  -#ifdef CONFIG_PM_SLEEP
>>  -
>>  -static int jz4740_mmc_suspend(struct device *dev)
>>  +static int __maybe_unused jz4740_mmc_suspend(struct device *dev)
>>   {
>>          return pinctrl_pm_select_sleep_state(dev);
>>   }
>>=20
>>  -static int jz4740_mmc_resume(struct device *dev)
>>  +static int __maybe_unused jz4740_mmc_resume(struct device *dev)
>>   {
>>          return pinctrl_select_default_state(dev);
>>   }
>>=20
>>   static SIMPLE_DEV_PM_OPS(jz4740_mmc_pm_ops, jz4740_mmc_suspend,
>>          jz4740_mmc_resume);
>>  -#define JZ4740_MMC_PM_OPS (&jz4740_mmc_pm_ops)
>>  -#else
>>  -#define JZ4740_MMC_PM_OPS NULL
>>  -#endif
>=20
> All of the above code can be simplified in this way, without having to
> convert into using the new pm_sleep_ptr() macro, below.
>=20
> The only "penalty" would be that, the struct dev_pm_ops
> (jz4740_mmc_pm_ops) would then be referenced even when CONFIG_PM* is
> unset, thus the compiler would be able to throw it away.
>=20
> Just wanted to point this out.

Yes, what I had in mind with these macros is that in general the=20
suspend/resume functions should not be conditionally compiled, as they=20
might have errors which would only appear with specific configs, and=20
instead should be always compiled but thrown away by the compiler if=20
unused.

>>=20
>>   static struct platform_driver jz4740_mmc_driver =3D {
>>          .probe =3D jz4740_mmc_probe,
>>  @@ -1124,7 +1118,7 @@ static struct platform_driver=20
>> jz4740_mmc_driver =3D {
>>          .driver =3D {
>>                  .name =3D "jz4740-mmc",
>>                  .of_match_table =3D of_match_ptr(jz4740_mmc_of_match),
>>  -               .pm =3D JZ4740_MMC_PM_OPS,
>>  +               .pm =3D pm_sleep_ptr(&jz4740_mmc_pm_ops),
>=20
> If the driver would have runtime suspend/resume callbacks, then it
> would need the use the pm_ptr() macro instead, I guess.
>=20
>>          },
>>   };
>>=20
>>  --
>>  2.25.0
>>=20
>=20
> My overall feeling is that this series improves the code/behaviour,
> but I am also a bit worried about adding yet another pair of macros
> for dealing with CONFIG_PM* callbacks as it could add more confusion.
>=20
> An option could be to introduce only the pm_ptr() macro, then skip the
> optimization that pm_sleep_ptr() gives. This could make it easier to
> use, as you wouldn't need to decide between two macros. Just a
> thought.

One macro would be better than none.

Cheers,
-Paul

> I don't know what Rafael's thinks about this, let's see if he has some
> other ideas.
>=20
> Kind regards
> Uffe

=

