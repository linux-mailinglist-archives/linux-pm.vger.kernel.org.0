Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A712177F391
	for <lists+linux-pm@lfdr.de>; Thu, 17 Aug 2023 11:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349745AbjHQJgF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Aug 2023 05:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349777AbjHQJfo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Aug 2023 05:35:44 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F1B93588
        for <linux-pm@vger.kernel.org>; Thu, 17 Aug 2023 02:35:26 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-58d70c441d5so11985097b3.2
        for <linux-pm@vger.kernel.org>; Thu, 17 Aug 2023 02:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692264924; x=1692869724;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9jrWcKsuRHAES1JrWmSyQeR1SR9GLYxBzoi8rlke3/o=;
        b=Nu3gB65G6oFkYg+qLYZhRa06QtzZ1u59Tw07LB7Nnbo9VgwdvMq9ib7vFYSST65SCd
         OUvy4KHlUIYvb9D69TQ717avXhyXnUSz0gmuFRDuymrXkFpuCwVNrw6hpwsjuZiGxAHv
         y+c7MeMelZcsSyffWvJxMQxXD3XHjB21XK2tT3xkSJLkNShMEVrVpTgxEjiAB2v3eUUO
         tisBxHMoLTo3L5ytD0EcNCTMR62g12BKqbIuU5gcRhhSJWLtqxXYoplZmJzDvt+ws9p8
         YpgrIGgo0dO8XRZTCpD1Dw6SqqKDMQL0NnUKLfcHPDBz+KEQNxDZCNmIi/N+bK7Gl3x3
         BI4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692264924; x=1692869724;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9jrWcKsuRHAES1JrWmSyQeR1SR9GLYxBzoi8rlke3/o=;
        b=IMU90U+Ku/h8Ol0W5cvgeKi0K5vNzNqJ7/mab7sIwPamcEQzTMt4VpNKcRLhTX7bBv
         BvePp9Tzuvro1W6yzb7Qh1nik/LwxZMEE19kwJWUgjIn94YrSbTFQgWAy/HfNn0nkHVp
         +uNtt/NjeW6kExV0C2X1TW/ljVZPgVRMN1JByQhwQTiWJTVDH7SOCYN+4aCY2oVZmkem
         9Xhc8JBXAXT9eujiU6AQJy/zmKX6jP7A8NpKHaISez51KpqKZs0Ap398MYB3aDrQbl1Q
         gV6ElhruCB5WsEByjTXB9n6YZetKFIsO0E6npptuCRa1V2RPsKrSV1BGgZ1ZkX4pSU7A
         GWXA==
X-Gm-Message-State: AOJu0Yzd1c7jyZvqNN38u04AlthpZnsOw1PW3ELhGtWTKApWnjCBIVWv
        AsgsOr8tZxmyteCcVxhbjLqNP+X4z3QTxnRSSwo4uA==
X-Google-Smtp-Source: AGHT+IHncMULMzGUQdNwYaYlv0puyzHj4VofRYRUVT3IrVbMJOw8BDgywY3RUPcKrd2f7LfSBz+BnezxAa47zN9mI9I=
X-Received: by 2002:a81:48cd:0:b0:583:2df2:35f3 with SMTP id
 v196-20020a8148cd000000b005832df235f3mr3779861ywa.1.1692264924457; Thu, 17
 Aug 2023 02:35:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230814104127.1929-1-peng.fan@oss.nxp.com> <CAPDyKFowxz_Ndy5uFmXaTmQoY1SUNNg7-R04JUUXX0n=5FH_fA@mail.gmail.com>
 <DU0PR04MB9417C7E1BBD75E90D8755F518817A@DU0PR04MB9417.eurprd04.prod.outlook.com>
In-Reply-To: <DU0PR04MB9417C7E1BBD75E90D8755F518817A@DU0PR04MB9417.eurprd04.prod.outlook.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 17 Aug 2023 11:34:47 +0200
Message-ID: <CAPDyKFptQsJqo3s4FLpnmCGmY3v2ywW1y0sCVozekZUsj7RWPA@mail.gmail.com>
Subject: Re: [PATCH V4 0/8] genpd: imx: relocate scu-pd and misc update
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 14 Aug 2023 at 13:46, Peng Fan <peng.fan@nxp.com> wrote:
>
> > Subject: Re: [PATCH V4 0/8] genpd: imx: relocate scu-pd and misc update
> >
> > On Mon, 14 Aug 2023 at 12:36, Peng Fan (OSS) <peng.fan@oss.nxp.com>
> > wrote:
> > >
> > > From: Peng Fan <peng.fan@nxp.com>
> > >
> > > V4:
> > >  Update commit message in patch 4
> > >
> > > V3:
> > >  return -EBUSY instead of return 0 in patch 4
> > >
> > > V2:
> > > Move drivers/firmware/imx/scu-pd.c to drivers/genpd/imx
> > >
> > > This patchset is to upstream NXP downstream scu-pd driver patches.
> > > patch is to relocate scu-pd to genpd
> > > patch 2,3 is to support more PDs
> > > patch 4 is to not power off console when no console suspend patch 5 is
> > > to suppress bind patch 6 is to make genpd align with HW state patch 7
> > > is to support LP mode in runtime suspend, OFF mode in system suspend.
> > > patch 8 is to change init level to avoid uneccessary defer probe
> > >
> > > V1:
> > > This patchset is to upstream NXP downstream scu-pd driver patches.
> > > patch 1,2 is to support more PDs
> > > patch 3 is to not power off console when no console suspend patch 4 is
> > > to suppress bind patch 5 is to make genpd align with HW state patch 6
> > > is to support LP mode in runtime suspend, OFF mode in system suspend.
> > > patch 7 is to change init level to avoid uneccessary defer probe
> > >
> > >
> > > Dong Aisheng (1):
> > >   genpd: imx: scu-pd: change init level to subsys_initcall
> > >
> > > Peng Fan (7):
> > >   genpd: imx: relocate scu-pd under genpd
> > >   genpd: imx: scu-pd: enlarge PD range
> > >   genpd: imx: scu-pd: add more PDs
> > >   genpd: imx: scu-pd: do not power off console if no_console_suspend
> > >   genpd: imx: scu-pd: Suppress bind attrs
> > >   genpd: imx: scu-pd: initialize is_off according to HW state
> > >   genpd: imx: scu-pd: add multi states support
> > >
> > >  drivers/firmware/imx/Makefile            |   1 -
> > >  drivers/genpd/imx/Makefile               |   1 +
> > >  drivers/{firmware => genpd}/imx/scu-pd.c | 193
> > > +++++++++++++++++++++--
> > >  3 files changed, 183 insertions(+), 12 deletions(-)  rename
> > > drivers/{firmware => genpd}/imx/scu-pd.c (70%)
> > >
> >
> > I am fine to pick up patch 1 -> patch 6, to let them go in for v6.6.
> > Should we do that or defer until the complete series is ready?
>
> Please take patch 1-6 first. I could handle patch 7 issue in a separate
> patch, since patch 7 is orthogonal to other patches.

Okay, I have now queued up patch 1-6 for v6.6 via my genpd tree.

In regards to patch4 (no_console_suspend), did you manage to have a
look at the patch [1] I sent a few days ago?

Kind regards
Uffe

https://lore.kernel.org/all/20230810162119.152589-1-ulf.hansson@linaro.org/
