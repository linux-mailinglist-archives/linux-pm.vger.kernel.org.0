Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F05C78714
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2019 10:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbfG2IN1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Jul 2019 04:13:27 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34686 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbfG2IN1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Jul 2019 04:13:27 -0400
Received: by mail-wm1-f67.google.com with SMTP id w9so42409795wmd.1;
        Mon, 29 Jul 2019 01:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SyFl8pL1iDZjmoOSkzXlnQ91ZUZpLkZdLRiM5vUWoME=;
        b=RMc4NRl9Idazs+XYRc2PCVJrla+XcMB5QI9fW4vskcW4AWdCAjW114u0ltcwv3J3kS
         MejM0+8lWjKST59WU3AMIZxd4/R8oxvP5WYmQZ/s+MfdW0r6aFSv4SZMNIv8js7Nr4IX
         7Gaa0m/10cn1v9XCIjcejFparxRsgjkUPGkLrC907ae/L4wg583BzHLdcoNoI1Xw+JJL
         J4QUDcdP7QMkggQGmKsgFfCqz9l+OvK80s89AN0hnR8wIaN8/pIPLxO/Jq7oo4ieNU4W
         2n2Ym18F3HuEavyXhWQ9Wbjei3xF1zzsbxx0b3hGtD55UjczEVPEeLSlS6D+SvQpiqid
         wP1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SyFl8pL1iDZjmoOSkzXlnQ91ZUZpLkZdLRiM5vUWoME=;
        b=EOTzOhZSouXAe9wGvfqX8QNJf3XlGPafKuOvNgKeB/TkSASVeeW40rBN1KuIQoXIqt
         4pwMAVBsxcyVRPACcINZ+I/kaGgb+Ka5C91KSzZVENB/s321KJ3N2LfjlsiEuMdLhZ22
         jfO4WBxgL/dFzwn/BH/O0RXlO8p381udF3xxBDQ9jelJiZVA0VVq7lgOexOeYYFoXyf2
         sAi4UKlzX9Lex3PgOgf8vJQ9TBek8UI6MP2M9xJwAzliShy6pd9Gw6R6ZHnaCJMF1CaW
         r37HrFP4DzwC5ZD9Nx4y47KZrkeIO13o5Shwj1HP3F7TfsahdAcvreg/zDA38HyFO8Br
         5jXQ==
X-Gm-Message-State: APjAAAXw2JaYHpBjkta+ERTioOoc0IL8Aomsh1YsubRdopSHt05tKELL
        Qfcv6fFOdnGjmVKggncR3l7NvUMzM6vQq7JVwF4=
X-Google-Smtp-Source: APXvYqyJSF9giFQVsItTxUvBm5InpdKI0AD91vYK8YMt/vMVNe8Bcy9zHxVTrPIj7PKEgF2MKDJZ8Wm9t5JIOx9xuEE=
X-Received: by 2002:a7b:c247:: with SMTP id b7mr102240187wmj.13.1564388004695;
 Mon, 29 Jul 2019 01:13:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190705045612.27665-1-Anson.Huang@nxp.com> <20190705045612.27665-5-Anson.Huang@nxp.com>
 <CAEnQRZAZNMBx3ApVmRP8hYPw0XY_QgR-saE6WLcT8oZmHPCxSA@mail.gmail.com>
 <DB3PR0402MB3916233A56CF5DF778115716F5C30@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAEnQRZCrZybzcy__u4p_Eq4zSVc2ESyfKLk5sPf1JYba1JSOiA@mail.gmail.com>
 <20190727161736.4dkfqgwftre67v56@fsr-ub1664-175> <DB3PR0402MB391600891BA75DFFA9674058F5DD0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAEnQRZB6tmYFA8wwh0Fm49LTTDuCLq-SWVfrcUkRWWBo=0U13w@mail.gmail.com>
 <DB3PR0402MB391627F725AA7237BCACBE87F5DD0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAEnQRZBrmikenTvnh7syhy=PDPcTL3fn2TJ+ya=ToZ+SFmH5tw@mail.gmail.com>
 <CAEnQRZDSjmcU8Q7+kMeFf12tx0NuMNjrcsgnXayvHpu4ChwHGA@mail.gmail.com> <DB3PR0402MB3916F32F03E542AEFBD39A43F5DD0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
In-Reply-To: <DB3PR0402MB3916F32F03E542AEFBD39A43F5DD0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Mon, 29 Jul 2019 11:13:12 +0300
Message-ID: <CAEnQRZBqdGY9A69ew=ukdp1iWVR_jvJih-cZPx_XzAri+xWppA@mail.gmail.com>
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

On Mon, Jul 29, 2019 at 10:49 AM Anson Huang <anson.huang@nxp.com> wrote:

> > We are all set then. Thanks Anson for clarifications!
>
> Thanks, so we are all clear about this issue, need to wait thermal maintainer to review
> the rest patch in this series, but I did NOT receive any response from thermal sub-system
> maintainer for really long time, NOT sure when the thermal patches can be accepted.

This is really unfortunate. I think it is safe to do a RESEND of the
patches as it has
been at least 3 weeks since your first send them.

Pick any reviewed-by you got and do a resend.
