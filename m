Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBD38E857D
	for <lists+linux-pm@lfdr.de>; Tue, 29 Oct 2019 11:26:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730271AbfJ2K01 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 29 Oct 2019 06:26:27 -0400
Received: from mail-lj1-f175.google.com ([209.85.208.175]:45768 "EHLO
        mail-lj1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727875AbfJ2K00 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Oct 2019 06:26:26 -0400
Received: by mail-lj1-f175.google.com with SMTP id q64so14594167ljb.12;
        Tue, 29 Oct 2019 03:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XXJ4yTre3lT2Hw451DHGum9ZE/PvKC28ALSpkKaZpzQ=;
        b=PVtNfW4XijiPFaMmyDWiKYevJ8Rnb+AuMPalMz+XGKSUUDzZGmB19dF+OPd+Cf7t8x
         AM5X/2XYgMyjwp1lINKaoqB70YPe+4nr9+G+nSi3wK+NxVo1uxLjvDxnqy3yKeBM3Yeb
         ietayrCkXZH7jE7r/YWqQ2Sb1zpm4jLfOWjwK4Y735P+vNEmyMgeSeT53ClgCeWNojIp
         m6zx9kwbh1Un8/jIDXYwUJnRnERjsZ5+G1SJRdPGNXWjRIIXM5aLubj8jIm/u9iRUcDW
         qL6IjUtTSOPdNq8laPS5fNErXTA8OZWpjNE8PQSwFIYEJhNawPFo18szPVc5JR6Bh3Dx
         slfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XXJ4yTre3lT2Hw451DHGum9ZE/PvKC28ALSpkKaZpzQ=;
        b=ddiPlUOQwXODtON3W8ExhpOWSAvenqmgkaBLRDitcoTkyTD96BoX772uiGE0TZV1ru
         3xyiiMVgubAQeDoe6v2uT1S95eK81XPB7ptTa5b+200KSMtsIupElRC0gG+TVbG04tAA
         TEMPFoEzPpu8I3683FHi57DT1RHP5kgSjSQyuHViMq+itFfY1fvZ0xeMZXc48sl84ozw
         AIU1EtEUqPDtRf5Q0437mZvaqQLUlkDgCMD6tnsJfr/yBWvqKEsdri+lfwQXCcYtmac4
         Zgu8porYCWSf31QNnBqkVxWmFrAYQFQCFAOS+8lLPSDoG7HpdPqM16lkDTBqS3mzz1sP
         ++Uw==
X-Gm-Message-State: APjAAAV63r3GSQ2yRGyLIrRB0mB/4fo+Qcmx67YBXynGgzr+8Vd2j7ys
        mWZoTylcpOX6Sf+pNqf8Q6ONvOx510FAcU1UIos=
X-Google-Smtp-Source: APXvYqzvkDNma91N0/j+LId1P0ave935Z1civdg7iP4tElQePFdC576p1UJ9upQws10oWtEnYzB9oLjay/5hPxgilts=
X-Received: by 2002:a2e:819a:: with SMTP id e26mr2054650ljg.26.1572344784090;
 Tue, 29 Oct 2019 03:26:24 -0700 (PDT)
MIME-Version: 1.0
References: <1572242618-18806-1-git-send-email-Anson.Huang@nxp.com> <1572242618-18806-2-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1572242618-18806-2-git-send-email-Anson.Huang@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 29 Oct 2019 07:26:25 -0300
Message-ID: <CAOMZO5AfyyqaAgn5enaW=Cncxinrp=TBAc+E_jWAWDLkYwA0=w@mail.gmail.com>
Subject: Re: [PATCH RESEND 2/4] thermal: imx8mm: Add support for i.MX8MM
 thermal monitoring unit
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     "rui.zhang" <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Catalin Marinas <catalin.marinas@arm.com>, will@kernel.org,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>, Ping Bai <ping.bai@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>, Li Jun <jun.li@nxp.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Olof Johansson <olof@lixom.net>, mripard@kernel.org,
        Vinod <vkoul@kernel.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        marcin.juszkiewicz@linaro.org, linux-pm@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        NXP Linux Team <Linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi  Anson,

On Mon, Oct 28, 2019 at 3:07 AM Anson Huang <Anson.Huang@nxp.com> wrote:

> +       ret = clk_prepare_enable(tmu->clk);
> +       if (ret) {
> +               dev_err(&pdev->dev, "failed to enable tmu clock: %d\n", ret);
> +               return ret;
> +       }
> +
> +       tmu->tzd = devm_thermal_zone_of_sensor_register(&pdev->dev, 0,
> +                                                       tmu, &tmu_tz_ops);
> +       if (IS_ERR(tmu->tzd)) {
> +               dev_err(&pdev->dev,
> +                       "failed to register thermal zone sensor: %d\n", ret);

You should disable the tmu clock in the error path.

> +               return PTR_ERR(tmu->tzd);
