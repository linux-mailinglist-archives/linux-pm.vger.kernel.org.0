Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CCA75A20C1
	for <lists+linux-pm@lfdr.de>; Fri, 26 Aug 2022 08:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbiHZGSy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Aug 2022 02:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241183AbiHZGSw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Aug 2022 02:18:52 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 374C9CE48A;
        Thu, 25 Aug 2022 23:18:51 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id s6so717645lfo.11;
        Thu, 25 Aug 2022 23:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=A55HGbYQY2Lsh3pXU2s/MT7frhz3q170job4bpURDR8=;
        b=D9FXwwocqQuKuITVY17hqXcail+ZUw2Bdz/LklCoyjPV3zqoIZqqKyg1ul/oxSrxNi
         zSIGHC9p2/rthPck8wZDPwtSqK6xwXIAHA+bckmqvsq6Ub8zIUKP8Qi4urI8lQNDWZb6
         WJuOhB4CM2F34LlvnAuQCexb+9lquIzO5Z1sLt8P7pUsYA6yH2iLHsk2+H0C1JO6ZJ3I
         SLnpr2CS3aUIvQXoth67P/SeHTZhcwNMw2L2Lz0JeUZmolg9iBt9a5kq5KMALNHvEmkB
         gRk/SFyxsgdM8Rie130nVdcxxugqvQLom3HdxRc/38klaUZBrbEpM51YeJ10E+BxYdOS
         q66g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=A55HGbYQY2Lsh3pXU2s/MT7frhz3q170job4bpURDR8=;
        b=SUmFdRwTB1fNChD6BObh+6b6ZrQKESuPJJzEnuJ8DGbtmWd3zlwDBN28Z+uoAozQ/x
         RBgvQ2/docKBfU6w2+ty/NMusTUgPe/RoMtCgwfpWuLpwmHz8Y0JKnHQl9M71ZHrFXjZ
         y9YY/cH8C+7pIUOAUx0wTdEufv0EogRdl+e2yOgsCT1VN6zYDcV5gCNuiUtihS5/clcM
         vlDKHfTC+4oMEQ/19kwm9zJSHY5tfaBnD5bnr4XPyUu/IxI8BeV+bpkC97EmktzmXxoo
         Kg9SAvxNBjNHzriyVti5aIOeKNCmoWwAd1S1EVacH/l+fiuInfZZEqME7TrT8xszE7UE
         bJGg==
X-Gm-Message-State: ACgBeo2C3AzUDJP82HZmPFkMX0B6VokQxA3uHDlbGK+DQnhxW/nrPGho
        WwZoAMuvJZX8alVdK4sFkzSzsoW1HS7VLlFaFzg=
X-Google-Smtp-Source: AA6agR56PjLkcrFGDmjXRZ/cOvlTj/BMul2j1x5LUi/Wekp9qAXPt1csxnIlMMWojdGlDk+lXRbAqEiPptK7eI8tx4c=
X-Received: by 2002:a19:640a:0:b0:492:8df3:f29b with SMTP id
 y10-20020a19640a000000b004928df3f29bmr1923091lfb.306.1661494729300; Thu, 25
 Aug 2022 23:18:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220823193015.10229-1-macroalpha82@gmail.com>
 <20220823193015.10229-4-macroalpha82@gmail.com> <66b99ce4-752a-17e7-3213-26a898abd4a8@gmail.com>
 <SN6PR06MB5342ACD1362403FC9FE38627A5729@SN6PR06MB5342.namprd06.prod.outlook.com>
 <6e905128-0dd1-d3a8-09ad-2645c3e12625@gmail.com>
In-Reply-To: <6e905128-0dd1-d3a8-09ad-2645c3e12625@gmail.com>
From:   Maya Matuszczyk <maccraft123mc@gmail.com>
Date:   Fri, 26 Aug 2022 08:18:20 +0200
Message-ID: <CAO_MupJ4vUtxtz76aw5z_R+jS3_7HyWHVfgieQkxa9PdHjCEAQ@mail.gmail.com>
Subject: Re: [PATCH V9 3/4] power: supply: Add charger driver for Rockchip RK817
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Chris Morgan <macromorgan@hotmail.com>,
        Chris Morgan <macroalpha82@gmail.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-pm@vger.kernel.org, devicetree <devicetree@vger.kernel.org>,
        zhangqing@rock-chips.com, zyw@rock-chips.com,
        jon.lin@rock-chips.com, sre@kernel.org,
        Heiko Stuebner <heiko@sntech.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, lee@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pt., 26 sie 2022 o 07:52 Matti Vaittinen <mazziesaccount@gmail.com> napisa=
=C5=82(a):
>
> On 8/25/22 18:37, Chris Morgan wrote:
> > On Thu, Aug 25, 2022 at 03:54:06PM +0300, Matti Vaittinen wrote:
> >> On 8/23/22 22:30, Chris Morgan wrote:
> >>> From: Chris Morgan <macromorgan@hotmail.com>
> >>>
> >>> Add support for the Rockchip rk817 battery charger integrated into th=
e
> >>> rk817 PMIC.
> >>>
> >>> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> >>> Signed-off-by: Maya Matuszczyk <maccraft123mc@gmail.com>
> >>> ---
> >>>    drivers/power/supply/Kconfig         |    6 +
> >>>    drivers/power/supply/Makefile        |    1 +
> >>>    drivers/power/supply/rk817_charger.c | 1157 ++++++++++++++++++++++=
++++
> >>>    3 files changed, 1164 insertions(+)
> >>>    create mode 100644 drivers/power/supply/rk817_charger.c
> >>>
> >>> +
> >>> +static void rk817_charging_monitor(struct work_struct *work)
> >>> +{
> >>> +   struct rk817_charger *charger;
> >>> +
> >>> +   charger =3D container_of(work, struct rk817_charger, work.work);
> >>> +
> >>> +   rk817_read_props(charger);
> >>> +
> >>> +   /* Run every 8 seconds like the BSP driver did. */
> >>> +   queue_delayed_work(system_wq, &charger->work, msecs_to_jiffies(80=
00));
> >>> +}
> >>
> >> I really think we would benefit from some more framework code which co=
uld
> >> handle the periodic polling tasks and the coulomb counter drift correc=
tions
> >> when battery is full/relaxed. I think I might revive the simple-gauge =
patch
> >> series...
> >
> > Possibly, does such exist or is that a future endeavor?
>
> No. Such a feature does not exist upstream. It was just some babbling I
> did here :) I started drafting something "generic" that would do polling
> of coulomb counter / battery state (full/relaxed) and then perform some
> 'CC resetting' to correct drifitng error and compute the SOC based on CC
> values. That would obviously just be a machinery that calls driver
> callbacks. I did support for two ROHM chargers using this concept but I
> had to switch to some urgent tasks before I managed to do proper
> testing. Might get back to that later though (depending on the other
> duties).
>
> > I'm only really
> > doing the polling because that's how the BSP driver was set up (and I
> > think it makes sense to not repeatedly check for teeny-tiny changes all
> > the time).
>
> I am far from being and expert on the chargers so I can't say if this is
> the "de-facto" way of doing things. I just have a feeling this (this
> meaning periodic reading from HW and then returning the 'cached' values
> to user-space) is quite common (I may be wrong though, many others
> including Sebastian and Linus W have _much_ more insight into how
> chargers/charger drivers/user-space operate). Caching/polling sounds
> like a task that could be implemented in the framework code rather than
> in many individual drivers. (This comment does not mean I would expect
> You to write such a framework for this driver - as I said, I am just
> pondering aloud and waiting to see how others think of this :] )
>
> > If there's an existing framework let me know, otherwise I'll
> > keep my eye out in the future and revise this if I can when it's live.
>
> So no existing framework and please, don't hold your breath waiting for
> one ;) It's still great to know that you can be pinged if I manage to
> cook-up something.
Feel free to ping me too, I started the work on mainline rk817 charger
driver and I've got device with battery connected to rk818 chip just
laying around and I assume that it's quite similar to rk817.

Best Regards,
Maya Matuszczyk
