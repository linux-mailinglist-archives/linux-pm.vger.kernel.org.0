Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBB0213B279
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jan 2020 19:58:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728797AbgANS6M (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Jan 2020 13:58:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:43760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726053AbgANS6M (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 14 Jan 2020 13:58:12 -0500
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B93C524672;
        Tue, 14 Jan 2020 18:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579028291;
        bh=tf/o2SOslhx05jLtLdGaZMcY/dh7CAZd9De5mDkeMf4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rhHPwkDsEYo5s9OaBOs8zWlRq1ckApWqZBX6XG5ON2yMQCrS0rVFA3Oq4GbC81lMC
         k4fdwcZntrM+DImSAtEzIlVzTcp8eX64KU/Lvq0wTsx4+p35gL9opG8cMGcRXj3riC
         sTdrKifhnvYLTAsuwrV4+sJ9bMoEAkJLnsIEMt78=
Received: by mail-lf1-f48.google.com with SMTP id y19so10664157lfl.9;
        Tue, 14 Jan 2020 10:58:10 -0800 (PST)
X-Gm-Message-State: APjAAAXCrQIPlnIk0EvCCBETpQkuoV/9CtFag35bpQ2EDdvstQA2HIjv
        adfgYabIJznBapPNHZXnw2mIrk+IZjJ1hsMFP5k=
X-Google-Smtp-Source: APXvYqwHQ2f4elu47X/7QicsiPxxCMwcNqD1zJyF4zqRmDXWzwTdd9U1U4qAAURR3V9bYvYPHyPXbFdnwTsZfi93v+4=
X-Received: by 2002:a19:c80a:: with SMTP id y10mr2322353lff.177.1579028288854;
 Tue, 14 Jan 2020 10:58:08 -0800 (PST)
MIME-Version: 1.0
References: <20191217055738.28445-1-cw00.choi@samsung.com> <CGME20191217055106epcas1p11f2bc81d6bb2db3fc4bc257d78c337b9@epcas1p1.samsung.com>
 <20191217055738.28445-5-cw00.choi@samsung.com> <20191226210119.GA8706@bogus>
 <a54e4275-012e-77d9-bdbe-1aab64b5c12b@samsung.com> <76616499-7c19-06b1-461a-28ae17a76c60@samsung.com>
In-Reply-To: <76616499-7c19-06b1-461a-28ae17a76c60@samsung.com>
From:   Chanwoo Choi <chanwoo@kernel.org>
Date:   Wed, 15 Jan 2020 03:57:30 +0900
X-Gmail-Original-Message-ID: <CAGTfZH0K65ON0FQGUjQbr71_9VWJXTmRbih1gko6Pcuy+PL63Q@mail.gmail.com>
Message-ID: <CAGTfZH0K65ON0FQGUjQbr71_9VWJXTmRbih1gko6Pcuy+PL63Q@mail.gmail.com>
Subject: Re: [PATCH 4/9] PM / devfreq: exynos-bus: Replace deprecated
 'devfreq' property
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Leonard Crestez <leonard.crestez@nxp.com>, lukasz.luba@arm.com,
        =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rob,

On Mon, Jan 6, 2020 at 10:32 AM Chanwoo Choi <cw00.choi@samsung.com> wrote:
>
> Hi Rob,
>
> Gently Ping.

Once again, ping. Could you please review?

On v2[1], made separate patches for dt-binding.
[1] https://patchwork.kernel.org/cover/11304545/

>
> On 12/27/19 9:09 AM, Chanwoo Choi wrote:
> > On 12/27/19 6:01 AM, Rob Herring wrote:
> >> On Tue, Dec 17, 2019 at 02:57:33PM +0900, Chanwoo Choi wrote:
> >>> In order to remove the deprecated 'devfreq' property, replace with
> >>> new 'exynos,parent-bus' property in order to get the parent devfreq device
> >>> in devicetree file instead of 'devfreq' property. But, to guarantee the
> >>> backward-compatibility, keep the support 'devfreq' property.
> >>>
> >>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> >>> ---
> >>>  .../bindings/devfreq/exynos-bus.txt           | 16 +++++++--------
> >>>  drivers/devfreq/exynos-bus.c                  | 20 ++++++++++++-------
> >>>  2 files changed, 21 insertions(+), 15 deletions(-)
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/devfreq/exynos-bus.txt b/Documentation/devicetree/bindings/devfreq/exynos-bus.txt
> >>> index e71f752cc18f..c948cee01124 100644
> >>> --- a/Documentation/devicetree/bindings/devfreq/exynos-bus.txt
> >>> +++ b/Documentation/devicetree/bindings/devfreq/exynos-bus.txt
> >>> @@ -45,7 +45,7 @@ Required properties only for parent bus device:
> >>>    of buses.
> >>>
> >>>  Required properties only for passive bus device:
> >>> -- devfreq: the parent bus device.
> >>> +- exynos,parent-bus: the parent bus device.
> >>
> >> If you are going to do something new, why not use the interconnect
> >> binding here?
> >
> > As I knew, interconnect make the data path among multiple nodes
> > and set the average and peak bandwidth to the specific data path.
> >
> > It means that some data will be flowed from node_a to node_d
> > or the reverse way because each node has the tightly coupled
> > dependency for data flow.
> >
> >       node_a <-> node_b <-> node_c <-> node_d
> >
> >
> > On the other hand, exynos-bus.c driver is not related to 'data path'.
> > Each bus just need to control the their own frequency and voltage.
> > But, share the power line (regulator) between exynos-bus device
> > even if there are no any dependency of data flow.
> >
> > 'exynos,parent-bus' property just indicate the specific
> > devfreq device(parent bus device) which controls
> > the shared power line(regulator) in order to prevent
> > the h/w problem due to the wrong pair of frequency and voltage.
> >
> > 'exynos,parent-bus' property is only used to catch
> > the change timing of shared power line.
> >
> >
> > And,
> > as you commented, there are some data path among the exynos-bus
> > devices for the display h/w as following:
> >
> >       bus_display -> bus_leftbus -> bus_dmc
> >
> > In order to make the data path between bus devices,
> > interconnect binding is required. This approach[1] was posted.
> > [1] https://patchwork.kernel.org/cover/11305265/
> > - [RFC,v3,0/7] PM / devfreq: Simple QoS for exynos-bus using interconnect
> >
>
> Are there any other commentss?
>
>
> --
> Best Regards,
> Chanwoo Choi
> Samsung Electronics



-- 
Best Regards,
Chanwoo Choi
