Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82591135906
	for <lists+linux-pm@lfdr.de>; Thu,  9 Jan 2020 13:17:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730249AbgAIMRt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Jan 2020 07:17:49 -0500
Received: from mail-lj1-f169.google.com ([209.85.208.169]:43837 "EHLO
        mail-lj1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728974AbgAIMRt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Jan 2020 07:17:49 -0500
Received: by mail-lj1-f169.google.com with SMTP id a13so6962841ljm.10;
        Thu, 09 Jan 2020 04:17:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kJr9DdZZf2/ANld+Ul9RudgAsohen5RqZzNVnbAqTsg=;
        b=mjvHnzbEaIbsQ0NrLtzCJRIhUTVzBGpQVrz43beSCllrFgzbAODIdEWPM6fiwSkcIu
         xD/gC+72yKJXiV0m/oD9K9IyhwgwpCMl2rrp0ynPOetXgn3z4+wy5Frbb36/2PqTqZHn
         HcHBVnCKltDcjjTRy+NsKATYq8umfzgbRbIroF1FYyTOLdBhKJsARpLUQ/uDGdqqtnRj
         x6IL2kwuJCygf3xZtI5IguBxcK4MlZjaYTVcrO9+PrG2dTV90SlbpjXZByf6qskfTMDL
         OqSqTQJLRYLbZkRDtN7X6jbLlHh+aBwkl7O0axkckjmj46m89yeyNbKH73C2Pohga2Pk
         CpfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kJr9DdZZf2/ANld+Ul9RudgAsohen5RqZzNVnbAqTsg=;
        b=mmnLCRenYuIpPcCYNIcskTbby5qXek840Tuo5PVMhsabt/6hLGMiFda6f0AtuoWMOv
         4tgklh8KVwQerUkA9xC54GCqeOHfxSqiMjxF3ky46RV/9x9rkBJePy6zGAvSn3Wo2NcP
         uK6MZaaayT2g70Ol0SErzZKaIs8C1WxxAzj87AuIJM9J2Jjd0C595kCwwzaBL3cjl+Uj
         qIAbfHvIzYWtEXtO6SQDSXssZ6O+vZqNNjQ8lDjAurxIeOiG47DDj0FFAbFh+DgMLPG4
         OLkRG6iFzaX9oYn+VzNxeP80kk2QiGzTn7zy7JLxdU5jf9BJUbplX69fe9w/c2Jq7gyH
         +dOw==
X-Gm-Message-State: APjAAAWsOdZ/DKgQL8pGsPnLn6IdT/t3ACzHPs4IDw6bdsFSPcdHohcX
        J7ttc8iXIwwhS8LTPTu4PRCuF/IP6UIVthhCeQE=
X-Google-Smtp-Source: APXvYqwTcIlvIE0lUCJi3FRLOlS1u3VgGMOmgYWiU57KWCLBT1IzZv7XrENayxwaVo2Wm+OfP7BbhpaMMuEa7apsGDA=
X-Received: by 2002:a2e:943:: with SMTP id 64mr6356480ljj.17.1578572266871;
 Thu, 09 Jan 2020 04:17:46 -0800 (PST)
MIME-Version: 1.0
References: <08794fde-cdd0-287c-62bf-e2e3b8c80686@gmail.com>
 <20191203101509.wte47aad5k4mqu2y@pengutronix.de> <CAOMZO5Cn993y9VeFN6hPO3-cfNnUKiuFd_rqAZ8htz=dO6t6ig@mail.gmail.com>
 <CAOMZO5BniszDhWKkoWY=P62kv9cY160r9P=pjpbSOZasxJvdBA@mail.gmail.com> <77fff313-3f40-6b5e-fe30-5a65a189bdff@gmail.com>
In-Reply-To: <77fff313-3f40-6b5e-fe30-5a65a189bdff@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 9 Jan 2020 09:17:35 -0300
Message-ID: <CAOMZO5DyJ_niuoBX62B1NLkKRpYQQtKUiX06L62TmA6PNMKO5A@mail.gmail.com>
Subject: Re: Issue with imx_get_temp()
To:     Igor Plyatov <plyatov@gmail.com>
Cc:     Marco Felsch <m.felsch@pengutronix.de>,
        Zhang Rui <rui.zhang@intel.com>,
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

Hi Igor,

On Tue, Dec 3, 2019 at 11:36 AM Igor Plyatov <plyatov@gmail.com> wrote:
>
> Dear Fabio,
>
> > Does the following patch help?
> > http://code.bulix.org/l3rz2e-982595
>
> Thank you!
>
> Patch applied and will be tested.
>
> I will inform you about results.

Have you had a chance to test the patch?
