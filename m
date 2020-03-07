Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 816C617C9EC
	for <lists+linux-pm@lfdr.de>; Sat,  7 Mar 2020 01:52:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbgCGAvx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Mar 2020 19:51:53 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46696 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbgCGAvx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Mar 2020 19:51:53 -0500
Received: by mail-pf1-f194.google.com with SMTP id o24so1902603pfp.13;
        Fri, 06 Mar 2020 16:51:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=skFcNwjthieJP7sfKB/M5QNBEnIrH81qXi4ZuvR5djg=;
        b=l18WCI1TN3rqxsUOpYhZQ3/fq9phH85TBCpcWGcQS49YSPYIQdrjc692qZ7FzTN+op
         488oR7rShJN3X5O1mO4hc3n9t0Rjo11NlXKlVTCZFS/+nA7pZGzG9nV7GFg9LE+twuwz
         pIC37vtJMVP1EfDiGa0TIaCTxez9k16KJKwv5pykJVVBLvKGByl78TDJKrsDupfHLc17
         TpPPMICQPP2sNqAtzAVJbJtj5f3WZleShFnso9bEYPBRMGZt7Ff1NM7iKj0JUSY+KvBF
         fXTh/d3jvMeBZYp00q9uLDcrlJxcdr/hQhVSTlH34p500BPtTfJQLZZOPW9URYjTeWSI
         2vkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=skFcNwjthieJP7sfKB/M5QNBEnIrH81qXi4ZuvR5djg=;
        b=hBovPc0jyhqMuBdMQA4khUhzCJV+yJc5Am5FNIcEUxVZUqi5e3ybPs8+U50ymJ7PvZ
         uiYPv6pGqzIVhLGdeN2KRhT4zVcxgVa7dGndeFwG06+hMSZPLXFUkc9C0A9NK+AWqJu4
         bdHyL7+oV3PSO5WMw969E0BQ2UJaUxDiCxaOrPB/JByY9U6Ap4zmBkupopiRBYe3Vo4W
         5nghcEB6gFeAe2peu/xOgtLr9y72ndPko87YqC8/HNQYraL+t9DAUcj4yMxD+xcHvCZF
         hx+l3AoivXVyyfzZKNh603FeTohS/qYt80oFf2PYQ0odbzSC9MGa6C5OHE2d6RuuJvlU
         7/3Q==
X-Gm-Message-State: ANhLgQ1TJh0T7kJ2aAYQ9BwmFnFGWDqGeuANutE9ydUXUFag/90CNt9u
        rW90bwNPe+GXea8fVFGvuDs=
X-Google-Smtp-Source: ADFU+vtSQp9AWTTxOFlya+y8suvpoKkjEitYDODYKQsTl7ClwUFUeZRpe5JzxUchhAi7ZxyXVM9GJg==
X-Received: by 2002:a63:5401:: with SMTP id i1mr5547231pgb.181.1583542310016;
        Fri, 06 Mar 2020 16:51:50 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3c2a:73a9:c2cf:7f45])
        by smtp.gmail.com with ESMTPSA id 9sm32356910pge.65.2020.03.06.16.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2020 16:51:49 -0800 (PST)
Date:   Fri, 6 Mar 2020 16:51:46 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "amit.kucheria@verdurent.com" <amit.kucheria@verdurent.com>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Ronald =?iso-8859-1?Q?Tschal=E4r?= <ronald@innovation.ch>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LINUXWATCHDOG <linux-watchdog@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH 3/5] input: keyboard: add COMPILE_TEST support for
 KEYBOARD_IMX_SC_KEY
Message-ID: <20200307005146.GM217608@dtor-ws>
References: <1583509356-8265-1-git-send-email-Anson.Huang@nxp.com>
 <1583509356-8265-3-git-send-email-Anson.Huang@nxp.com>
 <20200306193310.GI217608@dtor-ws>
 <CAKdAkRRhXE6Hviqx90_5hWmP7YQnKO2QLJgDYnzt_CPjeH7D0A@mail.gmail.com>
 <DB3PR0402MB3916EA7BAACBBE64F2609DB6F5E00@DB3PR0402MB3916.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB3PR0402MB3916EA7BAACBBE64F2609DB6F5E00@DB3PR0402MB3916.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Mar 07, 2020 at 12:18:38AM +0000, Anson Huang wrote:
> Hi, Dmitry
> 
> > Subject: Re: [PATCH 3/5] input: keyboard: add COMPILE_TEST support for
> > KEYBOARD_IMX_SC_KEY
> > 
> > On Fri, Mar 6, 2020 at 11:33 AM Dmitry Torokhov
> > <dmitry.torokhov@gmail.com> wrote:
> > >
> > > On Fri, Mar 06, 2020 at 11:42:34PM +0800, Anson Huang wrote:
> > > > Add COMPILE_TEST support to i.MX SC keyboard driver for better
> > > > compile testing coverage.
> > > >
> > > > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > >
> > > Applied, thank you.
> > 
> > Actually, not:
> > 
> > ERROR: "imx_scu_irq_register_notifier"
> > [drivers/input/keyboard/imx_sc_key.ko] undefined!
> > ERROR: "imx_scu_get_handle" [drivers/input/keyboard/imx_sc_key.ko]
> > undefined!
> > ERROR: "imx_scu_call_rpc" [drivers/input/keyboard/imx_sc_key.ko]
> > undefined!
> > ERROR: "imx_scu_irq_unregister_notifier"
> > [drivers/input/keyboard/imx_sc_key.ko] undefined!
> > ERROR: "imx_scu_irq_group_enable"
> > [drivers/input/keyboard/imx_sc_key.ko] undefined!
> > make[1]: *** [scripts/Makefile.modpost:94: __modpost] Error 1
> > make: *** [Makefile:1282: modules] Error 2
> > 
> > If you want to enable compile test coverage you need to provide stubs for
> > the above functions.
> 
> These i.MX SCU drivers depends on IMX_SCU, I already add the COMPILE_TEST
> to IMX_SCU driver as well, that is why I put these patches in a patch series.

Adding "|| COMPILE_TEST" you are removing hard dependency on IMX_SCU,
which as you can see can result in broken build.

> Maybe
> I can add stubs as well to make sure build passed even when IMX_SCU is NOT compiled?
> Will send V2 to add stubs, it makes more sense.

It is up to you whether you make IMX_SCU buildable with COMPILE_TEST
and leave the sub-driver as is, or add the stubs and make sub-drivers
buildable even without IMX_SCU being present.

Thanks.

-- 
Dmitry
