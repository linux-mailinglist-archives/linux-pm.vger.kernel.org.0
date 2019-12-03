Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D504110FE76
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2019 14:13:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbfLCNM7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Dec 2019 08:12:59 -0500
Received: from mail-lf1-f49.google.com ([209.85.167.49]:38505 "EHLO
        mail-lf1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbfLCNM7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Dec 2019 08:12:59 -0500
Received: by mail-lf1-f49.google.com with SMTP id r14so2915060lfm.5;
        Tue, 03 Dec 2019 05:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xL+wwaRMBv9RSY39RaXiUDci1/m24RW4l6zvHxar+tc=;
        b=npXjDGoyg1aRDYuFip3UFWBcqi0KI7PGwXUdKKMaSdLZpbuXsmOVKspSp1dIxAxMK0
         +ytYzmmCzX1PU2SZhocTG4K4m/HLJqopdsCf9sk2eUzKOaN7ub6w5/2dVrGoEnbDUu7D
         yo89c1d7rrj6rgfHD5PwOD5w7lwR/sCyDn01KfwaO8wUyH2CAnB1P5V7ManXBcSr60FK
         /OvqlFAr/s561m5JLSabtK2+h4DwQAMoHV/8CAmunaUWbKtxs4u/mi9FrzQ+ClxVU5Y1
         ndsL0wmPosCTTmN/gk/vYwcowBklRHotxOzVcQa84/p5wDUAPTLPLJgCvBxq9DwYZomM
         4uNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xL+wwaRMBv9RSY39RaXiUDci1/m24RW4l6zvHxar+tc=;
        b=Mhe2BZ3LhMXaUGvYGLg4GXXFhqGERNEi5Adsw8n5qVISgn0XZbHc+uNFY1OYhP55PR
         VFbi+MYinWHWO7HAwvzKO709Wx76VKwF7f+R7ProaXAI3fdsybPnf5uPR3QOnzcqlt/I
         D7WBgOUQ1pLuaaLIT1trmvexFjNkIhAJqgzav/jgwsN+Og5iRnNm0rhWy3iZN68G24+2
         5b4XnndJzfnsYJHPwkC6sRG58kvKmkt2ToMf7aBzKANFmsyPxgdQE65e3W/rafG1+tEx
         TFXds4AUfC+XPd99UUWNVF3Gllp4ioZpQ3nVBa7RFqALmkTYaHxZTovZjQRWI/g4J0vO
         JYJg==
X-Gm-Message-State: APjAAAX9ijGw7TPu9pnWV+QktLNMbNXtmFZff6TyNkX0BGry56QcrKLk
        lKpzWGBp2gFq2jdW2f2XDmvt4DP337OILkBpIfA=
X-Google-Smtp-Source: APXvYqyYlRr2czlmWkaMRwNWwQhGg3p+za24wre1ZLqjna9dtb+Jb7nGBb3H9ISdXGBmfc2ddR6+wWglH31E2UJpZ9g=
X-Received: by 2002:ac2:4119:: with SMTP id b25mr2718591lfi.90.1575378776541;
 Tue, 03 Dec 2019 05:12:56 -0800 (PST)
MIME-Version: 1.0
References: <08794fde-cdd0-287c-62bf-e2e3b8c80686@gmail.com>
 <20191203101509.wte47aad5k4mqu2y@pengutronix.de> <CAOMZO5Cn993y9VeFN6hPO3-cfNnUKiuFd_rqAZ8htz=dO6t6ig@mail.gmail.com>
In-Reply-To: <CAOMZO5Cn993y9VeFN6hPO3-cfNnUKiuFd_rqAZ8htz=dO6t6ig@mail.gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 3 Dec 2019 10:13:11 -0300
Message-ID: <CAOMZO5BniszDhWKkoWY=P62kv9cY160r9P=pjpbSOZasxJvdBA@mail.gmail.com>
Subject: Re: Issue with imx_get_temp()
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     Igor Plyatov <plyatov@gmail.com>, Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>, linux-pm@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Dec 3, 2019 at 9:04 AM Fabio Estevam <festevam@gmail.com> wrote:
>
> Hi Marco,
>
> On Tue, Dec 3, 2019 at 7:15 AM Marco Felsch <m.felsch@pengutronix.de> wrote:
>
> > Mh.. it seems that the irq gets enabled before a irq-handler is
> > registered. As your backlog shows the thermal_zone_device_register()
> > triggers a imx_get_temp() and during boot the irq_enabled is false and
> > it seems that your temperature is below the alarm_temp. So in such a
> > case the enable_irq() is executed. I don't know what happens if we
> > enable a irq without a irq-handler.
>
> I think your analysis makes sense.
>
> Should we move the ' data->irq_enabled = true' just prior to calling
> thermal_zone_device_register()?

Or maybe we could call thermal_zone_device_register() later?

Igor,

Does the following patch help?
http://code.bulix.org/l3rz2e-982595
