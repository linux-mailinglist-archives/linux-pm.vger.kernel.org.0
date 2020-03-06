Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 196CB17C6C3
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2020 21:05:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbgCFUF4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Mar 2020 15:05:56 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:45981 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbgCFUF4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Mar 2020 15:05:56 -0500
Received: by mail-io1-f66.google.com with SMTP id w9so3282945iob.12;
        Fri, 06 Mar 2020 12:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LdHJwrkU78nb5BuTKVZ6D/qa0v1tI9iVbXcfDOAUWuU=;
        b=BVmVik9dEamfXCKxb1sLMxZf1hIIA5pfcOZWjfAX/DioN021Z0EsuQfByfA3W9RI8X
         udxDHDvpvOug6ueLZrkWnFyWB9Keq/z6Q99PFzJxvsrKRnimpJE67CLnoBQqfwrb/v/b
         IzF0H7MmpNEXuPCyqhOpE6eecf9yq31mP+K+Lvpwr46nTPY8kavB9VYVFS0VfwsQdbQi
         5ToS7dkAWfgy6I2w/gPi+DCF/2bNoxx3Mz/EMHxC4Jp4AwWM3JmnleU8JyEiOvxAoENL
         41t2XgsspS8B6Wuvu/RlgYJ0gvo7Y9Zt6i8jw2zBxixJzUD0kMkIl9x8CNv9hencif4m
         lBHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LdHJwrkU78nb5BuTKVZ6D/qa0v1tI9iVbXcfDOAUWuU=;
        b=ARFcdYZMX/BYTNIm3MsTacIboc0a6Pcb1vJyGTmSCzqPAMbAFix74DDv5l2nB8pSjA
         3E0uo/ZMgqcp3X2d/XsSZj+lv2dzxUHhPFIGdLdHmase5kwdCKxO0FSbzHcLTA1PfNCB
         yRY0XBSIH3IaQuw6PBo5V7fS03OZ6ZHISGaG1IAQrdLGaJEGivqSreXna7cObJSD2SrM
         qfvaDDvmd5YG0qptMDeQ8x0VEM8DeXxz+MWnOLpcD3ICG4cabtpEPjilBkLEaYFdI0GU
         OjS3HDs/C5Ncb0VoShUdveNmuIO1v5unkG+xQOfdhmzmDLHb2cKHHmRZaE8UP4GKsmtZ
         9Yqw==
X-Gm-Message-State: ANhLgQ1eNVXL91HTDS1lfwA9POkDPe4Y+cU9QuO8UDj5UUCHtKMX4CyV
        GBRnuWNzPz6D0t1mjxu+xoPd95GDB0K0gxjTp0w=
X-Google-Smtp-Source: ADFU+vsGjBjSrVYdatEoW+ATr/qixFBpxQ+PrizOrE4IkcNicUVbWIuaSYnV3CVB0PtynC6ROLYZ1+L0CjdsBSoYE0Y=
X-Received: by 2002:a02:c942:: with SMTP id u2mr4773355jao.49.1583525154366;
 Fri, 06 Mar 2020 12:05:54 -0800 (PST)
MIME-Version: 1.0
References: <1583509356-8265-1-git-send-email-Anson.Huang@nxp.com>
 <1583509356-8265-3-git-send-email-Anson.Huang@nxp.com> <20200306193310.GI217608@dtor-ws>
In-Reply-To: <20200306193310.GI217608@dtor-ws>
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date:   Fri, 6 Mar 2020 12:05:42 -0800
Message-ID: <CAKdAkRRhXE6Hviqx90_5hWmP7YQnKO2QLJgDYnzt_CPjeH7D0A@mail.gmail.com>
Subject: Re: [PATCH 3/5] input: keyboard: add COMPILE_TEST support for KEYBOARD_IMX_SC_KEY
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        amit.kucheria@verdurent.com, wim@linux-watchdog.org,
        Guenter Roeck <linux@roeck-us.net>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        =?UTF-8?Q?Ronald_Tschal=C3=A4r?= <ronald@innovation.ch>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        linux-rtc@vger.kernel.org, Linux PM <linux-pm@vger.kernel.org>,
        LINUXWATCHDOG <linux-watchdog@vger.kernel.org>,
        NXP Linux Team <Linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Mar 6, 2020 at 11:33 AM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> On Fri, Mar 06, 2020 at 11:42:34PM +0800, Anson Huang wrote:
> > Add COMPILE_TEST support to i.MX SC keyboard driver for better compile
> > testing coverage.
> >
> > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
>
> Applied, thank you.

Actually, not:

ERROR: "imx_scu_irq_register_notifier"
[drivers/input/keyboard/imx_sc_key.ko] undefined!
ERROR: "imx_scu_get_handle" [drivers/input/keyboard/imx_sc_key.ko] undefined!
ERROR: "imx_scu_call_rpc" [drivers/input/keyboard/imx_sc_key.ko] undefined!
ERROR: "imx_scu_irq_unregister_notifier"
[drivers/input/keyboard/imx_sc_key.ko] undefined!
ERROR: "imx_scu_irq_group_enable"
[drivers/input/keyboard/imx_sc_key.ko] undefined!
make[1]: *** [scripts/Makefile.modpost:94: __modpost] Error 1
make: *** [Makefile:1282: modules] Error 2

If you want to enable compile test coverage you need to provide stubs
for the above functions.

Thanks.

-- 
Dmitry
