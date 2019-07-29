Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72CF778634
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2019 09:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbfG2HV3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Jul 2019 03:21:29 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33533 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbfG2HV2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Jul 2019 03:21:28 -0400
Received: by mail-wr1-f66.google.com with SMTP id n9so60677652wru.0;
        Mon, 29 Jul 2019 00:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OmnUcMUVxe9qZyEWWIormUbuzEUv2UONqbilRZIkZOs=;
        b=htmsTnU+J/YrxKgm+PeiOkBSwhHVH0uNZw4qIM5tuLC2SgaswPgPC403mB3mi2Xqod
         udHQeT5HB82KFIhumYOKzZP9C2wPBtZVv5u3HOqw7nhWTdPGRqY7ltAPm1+nbfkN5xDK
         HR1U6eQS+xM9rGcYLiqr1WFVA0Z9tvL27eCFchA2Jga+SMAreGWa0QfVuynJZpmrP5Vu
         UXLJ771gOeXtycPTC+Hkqo/7R9LL7DP8F/CDb4q3UeBwD7hcsklj7h2UBq5/1hy/vovw
         osI5lUQRIE0EnyuJyhoVAR0oQKuyX1wOYGBxaMlHk4Q3jROXLOEMeD0WABOFf39T5fz+
         ZBdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OmnUcMUVxe9qZyEWWIormUbuzEUv2UONqbilRZIkZOs=;
        b=AhVLxSL1zRmxOs6mKRabQ52ed03zd5x86IemwKe7TTJLHQ9i58wvmOa2QQSYewB67+
         CVafyARhEK0hFzM3jU5TAijxF2rxe0nWLvl0lzoxqwmVguUIYLT0Lmtv6ORs9IcNPuS3
         Np8BYJRntH2DvWiDlNZucdHxVFfqziKYj2eFtKqUyqkQSgvpwz95ctlBNNOTkRv/zbTe
         cjdDJehEZYK65PHYPyUq7gzm80piTJYBVey0SLFVdgIBl5pP9Pxl08UCyMkzyXf+UgZG
         /ALuuhCHfzT3WtHA9I8uZNFB5YA4zO19Rn8dWZVxnaro5+vRc5Jax1uwYj+iYFdftfIu
         UJiw==
X-Gm-Message-State: APjAAAXarHh4Oi6CgJtDkNI0Kjeu4hvy9BdJ1LVzxWd8dZkicArk3dWD
        eVxyzo5RpHMeJlBrwt4WHoZLrHY01sjlz74TdkpA5Qt4rIS+5K7p
X-Google-Smtp-Source: APXvYqzk7QV8VpWwnSuPJlBSETXIe8AltBmDlBWTRlXUH1BvMfbt/6T3Ue9gxeDQPFxzotZ4OMTNG2gxxNFTin/+OMM=
X-Received: by 2002:a05:6000:14b:: with SMTP id r11mr44520639wrx.196.1564384885995;
 Mon, 29 Jul 2019 00:21:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190705045612.27665-1-Anson.Huang@nxp.com> <20190705045612.27665-5-Anson.Huang@nxp.com>
 <CAEnQRZAZNMBx3ApVmRP8hYPw0XY_QgR-saE6WLcT8oZmHPCxSA@mail.gmail.com>
 <DB3PR0402MB3916233A56CF5DF778115716F5C30@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAEnQRZCrZybzcy__u4p_Eq4zSVc2ESyfKLk5sPf1JYba1JSOiA@mail.gmail.com>
 <20190727161736.4dkfqgwftre67v56@fsr-ub1664-175> <DB3PR0402MB391600891BA75DFFA9674058F5DD0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAEnQRZB6tmYFA8wwh0Fm49LTTDuCLq-SWVfrcUkRWWBo=0U13w@mail.gmail.com>
 <DB3PR0402MB391627F725AA7237BCACBE87F5DD0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAEnQRZBrmikenTvnh7syhy=PDPcTL3fn2TJ+ya=ToZ+SFmH5tw@mail.gmail.com>
In-Reply-To: <CAEnQRZBrmikenTvnh7syhy=PDPcTL3fn2TJ+ya=ToZ+SFmH5tw@mail.gmail.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Mon, 29 Jul 2019 10:21:14 +0300
Message-ID: <CAEnQRZDSjmcU8Q7+kMeFf12tx0NuMNjrcsgnXayvHpu4ChwHGA@mail.gmail.com>
Subject: Re: [PATCH 5/6] clk: imx8mq: Remove CLK_IS_CRITICAL flag for IMX8MQ_CLK_TMU_ROOT
To:     Anson Huang <anson.huang@nxp.com>
Cc:     Abel Vesa <abel.vesa@nxp.com>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "edubezval@gmail.com" <edubezval@gmail.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Carlo Caione <ccaione@baylibre.com>,
        =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jul 29, 2019 at 10:20 AM Daniel Baluta <daniel.baluta@gmail.com> wrote:
>
> <snip>
> > > Your explanation makes a lot of sense. We will take care today of Abel's
> > > patch.
> > > What do you think about Fabio's patch? I also think this is a valid patch:
> > >
> <snip>
>
> >
> > Hmm, when did Fabio sent out this patch? I can NOT find it...
> > I also have a patch in this series (#4/6) doing same thing on July 5th...
> >
> > https://patchwork.kernel.org/patch/11032783/
>
> He didn't send the patch yet. It was just a request for test here:
>
> http://code.bulix.org/pd88jp-812381
>
> But, now I see is exactly like your patch here:

... pressed send to early.

https://lkml.org/lkml/2019/7/5/19

We are all set then. Thanks Anson for clarifications!
