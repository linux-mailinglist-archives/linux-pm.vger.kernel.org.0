Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B65D519CFE8
	for <lists+linux-pm@lfdr.de>; Fri,  3 Apr 2020 07:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732903AbgDCFqF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 Apr 2020 01:46:05 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:45274 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730550AbgDCFqF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 Apr 2020 01:46:05 -0400
Received: by mail-vs1-f65.google.com with SMTP id x82so4164237vsc.12
        for <linux-pm@vger.kernel.org>; Thu, 02 Apr 2020 22:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S4XNepmeOooAZ1+s30LlQ+CWVHmuUGaSrMEBEx9YwGo=;
        b=zIZsDrrcJTGyEaY5wJrQpWkaz8MwaasE7La+XUSJtg3/Fei8sHG6TmlNUnjdV7T8wX
         1FIaPRHwHluCkALganU6p5noYpWnVJvyIcTBe/kRZvpNkl0XRMrzCX5rf92cMtef4pqC
         mAnt9li35bOeUdLroCDFuMJGkqRiePNH/be4Pxcwvu/tpzxeR/WQu3iVky+eJ+PODVFi
         FziBzTQuwvkfBRaQbRN1MBwYaHBeLy2LEHuO8dbafMgAdj+9bWofkpNNeErdiyWGXIFE
         HYIHu9XnCX4FetnrNoz53MjaDLTaShXiszb1qIIrvZZWtkXGaHxZg55ongNI0Mv/UmTj
         AYMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S4XNepmeOooAZ1+s30LlQ+CWVHmuUGaSrMEBEx9YwGo=;
        b=UByMjcYmwjXBqmOXrRKMWQugy/g4/0qaOpWC6FordxyPwUYvnKtUkHoWQlQ4/EUEJN
         7cX/Qwes2NqlzlJSkODXk/tAsqfh3XLZG3atFtyuFHcEqLUHtQg+MxF2sca+3gPyEDDR
         QvotkNC/I0eaguIHpbxva2dsVe7iOU/emmjClMo0kYJwOMoWuc2Fd4HG9cokp3vLbbor
         0c7XU/+CCb/fQLn2cLC01knwzjaj0Ud2twpQbfmgbmczn7mHdlGJAVK5jgGzvOf4V8Bo
         Vh4+Mphp842Ek+F/WEf49ie3Qi/FA8S3wX7L3czj0xGiGnPqhEok7Pk49lfFpeN74tew
         6L3g==
X-Gm-Message-State: AGi0PuaUflPKKBStDcmMdS0wGoF8hxB+AfLahFW9brjtY8yZnBgJ79QE
        zSncPqAZbAB9rsEUv4onTpdwpJRE4l2uU/FfYB9OSw==
X-Google-Smtp-Source: APiQypKwPJ3eQAj3UmcqOc18/vQnRNsFvQw3FTV9eUmQpOy4PLfT3A7xYCqvCkwaapvUhQCilHz1KbZizZs8pohCCcQ=
X-Received: by 2002:a05:6102:104b:: with SMTP id h11mr5288832vsq.182.1585892764055;
 Thu, 02 Apr 2020 22:46:04 -0700 (PDT)
MIME-Version: 1.0
References: <1584966504-21719-1-git-send-email-Anson.Huang@nxp.com>
 <1584966504-21719-3-git-send-email-Anson.Huang@nxp.com> <CAHLCerNG3ZBbWrTwXxCbd1BOfyHxuvpAuo5tW_bNKgWcO5zESA@mail.gmail.com>
 <DB3PR0402MB3916AF241DE20AB9CCE1A4C2F5C70@DB3PR0402MB3916.eurprd04.prod.outlook.com>
In-Reply-To: <DB3PR0402MB3916AF241DE20AB9CCE1A4C2F5C70@DB3PR0402MB3916.eurprd04.prod.outlook.com>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Fri, 3 Apr 2020 11:15:53 +0530
Message-ID: <CAHLCerMEn7g3a-MG9xiiLKMUCLXjKRiuZ_wMjRjPJCXvDMzDdA@mail.gmail.com>
Subject: Re: [PATCH V3 3/3] arm64: dts: imx8mp: Add thermal zones support
To:     Anson Huang <anson.huang@nxp.com>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Horia Geanta <horia.geanta@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        lakml <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Apr 3, 2020 at 9:04 AM Anson Huang <anson.huang@nxp.com> wrote:
>
> Hi, Amit
>
> > Subject: Re: [PATCH V3 3/3] arm64: dts: imx8mp: Add thermal zones support
> >
> > On Mon, Mar 23, 2020 at 6:05 PM Anson Huang <Anson.Huang@nxp.com>
> > wrote:
> > >
> > > i.MX8MP has a TMU inside which supports two thermal zones, add support
> > > for them.
> > >
> > > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> >
> >
> > [snip]
> >
> > >
> > > +       thermal-zones {
> > > +               cpu-thermal {
> > > +                       polling-delay-passive = <250>;
> > > +                       polling-delay = <2000>;
> > > +                       thermal-sensors = <&tmu 0x0>;
> >
> > No need for 0x0, just use 0
>
> OK.
>
> >
> > > +                       trips {
> > > +                               cpu_alert0: trip0 {
> > > +                                       temperature = <85000>;
> > > +                                       hysteresis = <2000>;
> > > +                                       type = "passive";
> > > +                               };
> > > +
> > > +                               cpu_crit0: trip1 {
> > > +                                       temperature = <95000>;
> > > +                                       hysteresis = <2000>;
> > > +                                       type = "critical";
> > > +                               };
> > > +                       };
> > > +
> > > +                       cooling-maps {
> > > +                               map0 {
> > > +                                       trip = <&cpu_alert0>;
> > > +                                       cooling-device =
> > > +                                               <&A53_0
> > THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> > > +                                               <&A53_1
> > THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> > > +                                               <&A53_2
> > THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> > > +                                               <&A53_3
> > THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> > > +                               };
> > > +                       };
> > > +               };
> > > +
> > > +               soc-thermal {
> > > +                       polling-delay-passive = <250>;
> > > +                       polling-delay = <2000>;
> > > +                       thermal-sensors = <&tmu 0x1>;
> >
> > No need for 0x1, just use 1
>
> OK.
>
> >
> > > +                       trips {
> > > +                               soc_alert0: trip0 {
> > > +                                       temperature = <85000>;
> > > +                                       hysteresis = <2000>;
> > > +                                       type = "passive";
> > > +                               };
> > > +
> > > +                               soc_crit0: trip1 {
> > > +                                       temperature = <95000>;
> > > +                                       hysteresis = <2000>;
> > > +                                       type = "critical";
> > > +                               };
> > > +                       };
> >
> > You need a cooling-map here since you have a passive trip point.
>
> Currently, there is no cooling map defined for soc thermal zone, the cpufreq cooling
> is mapped to cpu thermal zone already, so do you think it is OK to leave it as no cooling
> map, or it is better to put cpufreq cooling for soc thermal zone as well?
>

If there is no cooling, why do you need a passive trip point? Just
make it a hot trip that will send you a nofication (if .notify
callback registered).

Regards,
Amit
