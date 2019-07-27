Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFDCB77BC0
	for <lists+linux-pm@lfdr.de>; Sat, 27 Jul 2019 22:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388079AbfG0URv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 27 Jul 2019 16:17:51 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44341 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387841AbfG0URv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 27 Jul 2019 16:17:51 -0400
Received: by mail-lf1-f67.google.com with SMTP id r15so22373187lfm.11;
        Sat, 27 Jul 2019 13:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TNmkt6r1wwZluVwfnTTUGV7AKJv+CJ4rclhv3bynhgE=;
        b=ru73Yj2pRqQDLD6iKXAYSgjhlhEIgBZZQT02f+jLPD8yVaXpKCY7K7LNKQSrKiJ2OL
         aAukl8H4Z7Jz0FXAa5MjGOVQsxNtA5b8RLTFH1vO/bVKf3EDt1e1XwTaNXhUU+dtrd5+
         bMSbDJxIGosG9XvFJBPNJ5he9UGUME7Gglvl+Ow19zvHJ/Ov8tQ7sC08p1u69oc0a6mX
         kvE5Ktgn3O/zZpohQMzl/iuAiWrn5yjuqFPsgpQszQSv5p2/YjS5Gp8P1BJzb9zwjYsW
         aiLED55ID7afVvRriFX0FFfuucsVOdye1JARsOta/7Wuu7vr3+wnVc+wX/oAk2MZVk9n
         jRbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TNmkt6r1wwZluVwfnTTUGV7AKJv+CJ4rclhv3bynhgE=;
        b=XRg0IBOC66LaP1rPUcVGLFcpVc4cdzH8d0KLJXE1bz2ql62/Cjthv0m3rLG67m1YTe
         bbM8z7eUPUfEGOlJCfvvdgR87JxmgcKmNttUjRdMgN9bwZxRjKuK5gNYVMQ+iWTwobvp
         GVyMsc5jH/92clhxVLUHT/zQYEDN+19xp7sl5VHH/cNhNpN2Y7j2+xKf6BZDnfb50GNP
         Nemn7BVAzl9kI751KIb3aScDI56rli88vGlPSgDTkFNxNjovBJUrhxX6DWCWXXaW+a92
         LNLeREJVkuYPDqwyBIbUHeKi7o4O53b3ICqprUjoC7B8ZS3El/66OmdwZU59WCwuxA9s
         R+IQ==
X-Gm-Message-State: APjAAAUr1rppyjdslnfM6uOAYbT5nWUA+/NC0VLA+oWsxXWb46Uw7UY+
        ukQR4MIXEGGhH4vC3ub0fjDxvYJU8RmLDBFxndI=
X-Google-Smtp-Source: APXvYqxpSbR1Bjz4XI/bIwcJDaFltZanQO8EpuyDV/1mHmh80RcaDU5FYXYbDZXzcAhwMCy9dV3VjhYwFCUXJT14/aM=
X-Received: by 2002:a05:6512:29a:: with SMTP id j26mr16237912lfp.44.1564258668333;
 Sat, 27 Jul 2019 13:17:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190705045612.27665-1-Anson.Huang@nxp.com> <20190705045612.27665-5-Anson.Huang@nxp.com>
 <CAEnQRZAZNMBx3ApVmRP8hYPw0XY_QgR-saE6WLcT8oZmHPCxSA@mail.gmail.com> <20190727182636.GA7170@bogon.m.sigxcpu.org>
In-Reply-To: <20190727182636.GA7170@bogon.m.sigxcpu.org>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Sat, 27 Jul 2019 17:17:50 -0300
Message-ID: <CAOMZO5C_g5bO-yqhoLbb6geUcmzi4necjdQ_P2tROq2vzEPOqQ@mail.gmail.com>
Subject: Re: [PATCH 5/6] clk: imx8mq: Remove CLK_IS_CRITICAL flag for IMX8MQ_CLK_TMU_ROOT
To:     =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>
Cc:     Daniel Baluta <daniel.baluta@gmail.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Carlo Caione <ccaione@baylibre.com>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Abel Vesa <abel.vesa@nxp.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        dl-linux-imx <Linux-imx@nxp.com>,
        "rui.zhang" <rui.zhang@intel.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        linux-pm@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>,
        Eduardo Valentin <edubezval@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Guido,

On Sat, Jul 27, 2019 at 3:26 PM Guido G=C3=BCnther <agx@sigxcpu.org> wrote:

> I noticed a boot hang yesterday on next-20190726 when loading the
> qoriq_thermal which I worked around by blacklisting it. The
> fsl,imx8mq-tmu node specifies a clock (IMX8MQ_CLK_TMU_ROOT) but does not
> seem to enable, shouldn't it do so?

Yes, I think you are right.

I don't have access to a imx8mq board at the moment, but something
like below would probably help:
http://code.bulix.org/pd88jp-812381

If it helps, I can send it as a formal patch.

Regards,

Fabio Estevam
