Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35F873194E9
	for <lists+linux-pm@lfdr.de>; Thu, 11 Feb 2021 22:13:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbhBKVMp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 11 Feb 2021 16:12:45 -0500
Received: from mail-40133.protonmail.ch ([185.70.40.133]:56965 "EHLO
        mail-40133.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbhBKVMk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 11 Feb 2021 16:12:40 -0500
Date:   Thu, 11 Feb 2021 21:11:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1613077915;
        bh=4VV/HM9KaFjIhM38yB9PwprOcTWzMzKSjBUn6r4t3EY=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=hHzE7DRXwMp8sYAYTIeA6IhCsyU0dqZNyaAU4OyLnMgWTSDRkYNHtj7MswuN7zhIS
         ebZZNDjxL2etJzLlEaJZIgknbzmqe53Qu7lk0AaqqOaykFCCgZwUTIXpZnEGemuEQS
         65mbAtY3u3+1kqF7PKD+blLDiBljl2NwTIha3RsM=
To:     Lee Jones <lee.jones@linaro.org>
From:   Timon Baetz <timon.baetz@protonmail.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Sebastian Reichel <sre@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Reply-To: Timon Baetz <timon.baetz@protonmail.com>
Subject: Re: [PATCH v3 3/7] mfd: max8997: Add of_compatible to extcon and charger mfd_cell
Message-ID: <20210211221132.5e8d156c.timon.baetz@protonmail.com>
In-Reply-To: <20201222095522.GC53991@dell>
References: <20201222070520.710096-1-timon.baetz@protonmail.com> <20201222070520.710096-3-timon.baetz@protonmail.com> <20201222095522.GC53991@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 22 Dec 2020 09:55:22 +0000, Lee Jones wrote:
> On Tue, 22 Dec 2020, Timon Baetz wrote:
>=20
> > Add of_compatible ("maxim,max8997-muic") to the mfd_cell to have a
> > of_node set in the extcon driver.
> >
> > Add of_compatible ("maxim,max8997-battery") to the mfd_cell to configur=
e
> > the charger driver.
> >
> > Signed-off-by: Timon Baetz <timon.baetz@protonmail.com>
> > ---
> >  drivers/mfd/max8997.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-) =20
>=20
> Applied, thanks.

Once https://lore.kernel.org/lkml/20210130172747.2022977-1-timon.baetz@prot=
onmail.com/
gets accepted, this is not needed anymore. Can this be reverted or
should I create a new patch?

Thanks,
Timon=20


