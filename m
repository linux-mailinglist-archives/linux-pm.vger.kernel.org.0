Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 293927801F
	for <lists+linux-pm@lfdr.de>; Sun, 28 Jul 2019 17:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726195AbfG1PYa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 28 Jul 2019 11:24:30 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43749 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbfG1PYa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 28 Jul 2019 11:24:30 -0400
Received: by mail-lj1-f196.google.com with SMTP id y17so31466503ljk.10;
        Sun, 28 Jul 2019 08:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XESaxjYdas5a8N8eff8KwYDLiyaFr2Owam2TYo7fjSM=;
        b=H/8RrtQD+LS5GhQeXc2KchdCjwhty4e3aqG+Fd+pLIFD9+jfqrHh3TYKi5S92fF4Ib
         bJ8YzxRxO4LLwCSNnL3xOX09lcNVU8WbUnD8Z50heIzbE8oeSgG+nzqcy9ycQ7cWp4BS
         yXRgqGYfbkQiRKYEyUQfwN6N/JcfQV8SNO38av45f0yN40rsRPmqMgRt+6fwYyWjECTZ
         o2ucVaVowEo4FwEIa1XHpPQJeC9z6QvExUTTnX/11ZJh3KFrxhb1dlVpDSLjDZ4TtIRn
         Sh/wAWpW4ia4aKMBPNiewJaeZqwd72jH0xOB6epMnRblIT1s4iRT9Gwl7I6bQlN1JA3o
         6Qnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XESaxjYdas5a8N8eff8KwYDLiyaFr2Owam2TYo7fjSM=;
        b=n/lIzGWdRLPqpuVZJBm3FcXzWoEsG11ZRnsuC54mel6CBA/BP9nnBH7Zsx9C99xCjY
         b1kWpKElV17QHvZTt7A1Gua5EN9uZp6rBwTHlfCFm7QnqHO0wfMlwbxfoHxZloin2sxF
         rvU30IWnFTy+pg60O34ai1jbS1am4CgbhzxzcnaPWpYRMVOM1Y0ynn2mKdxQtBKBzU5q
         nQp0ZuhK7YVWWCtkuOj7dkyHo34CDaqywrfRIUGuj1RhU5OlknvmpHLtLFI+SEl9EOom
         1VWd623UrtklIxp4gzJEHjF5F2eKDicZx9wagXFaeUgjjd1gv/QcQ4gGvJStq4foRnoN
         lA/A==
X-Gm-Message-State: APjAAAU2IAe1ZcbMo7zFlRUADTqXRgS1etpxalA5RVRZETfWhKQlZ9As
        /dkqLjDEPcIkAIVuS2EsnVG2aNlOpd8um2AjES0=
X-Google-Smtp-Source: APXvYqx0B5SfSllnaGRSgBXv5UCoIVvQyJqr+nIa2jGuBzm9lAem+hJ+CEoU8GXntWmPJEoF/luetozWB5qey+P03G0=
X-Received: by 2002:a2e:4e12:: with SMTP id c18mr4951431ljb.211.1564327467967;
 Sun, 28 Jul 2019 08:24:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190705045612.27665-1-Anson.Huang@nxp.com> <20190705045612.27665-5-Anson.Huang@nxp.com>
 <CAEnQRZAZNMBx3ApVmRP8hYPw0XY_QgR-saE6WLcT8oZmHPCxSA@mail.gmail.com>
 <20190727182636.GA7170@bogon.m.sigxcpu.org> <CAOMZO5C_g5bO-yqhoLbb6geUcmzi4necjdQ_P2tROq2vzEPOqQ@mail.gmail.com>
 <20190728075858.GA15144@bogon.m.sigxcpu.org>
In-Reply-To: <20190728075858.GA15144@bogon.m.sigxcpu.org>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Sun, 28 Jul 2019 12:24:30 -0300
Message-ID: <CAOMZO5CpURvqawVA=MhYxdAKABzVWWenVMfWZ7D=CKR_qtP7QQ@mail.gmail.com>
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
        Lucas Stach <l.stach@pengutronix.de>,
        Chris Healy <cphealy@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Guido,

On Sun, Jul 28, 2019 at 4:59 AM Guido G=C3=BCnther <agx@sigxcpu.org> wrote:

> Yes, this fixes it for me, thanks!

Thanks for testing it.

I will send a formal patch tomorrow.

Regards,

Fabio Estevam
