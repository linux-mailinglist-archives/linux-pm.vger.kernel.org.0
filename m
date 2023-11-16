Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F07A87ED89E
	for <lists+linux-pm@lfdr.de>; Thu, 16 Nov 2023 01:38:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbjKPAiv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Nov 2023 19:38:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235056AbjKPAit (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Nov 2023 19:38:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C39A1A3
        for <linux-pm@vger.kernel.org>; Wed, 15 Nov 2023 16:38:46 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92D87C433CB;
        Thu, 16 Nov 2023 00:38:45 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
        id 311901062B6C; Thu, 16 Nov 2023 01:38:42 +0100 (CET)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, linux-kbuild@vger.kernel.org,
        Manivannan Sadhasivam <mani@kernel.org>,
        Cristian Ciocaltea <cristian.ciocaltea@gmail.com>,
        linux-actions@lists.infradead.org,
        Sean Wang <sean.wang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-mediatek@lists.infradead.org
In-Reply-To: <20231104211501.3676352-16-u.kleine-koenig@pengutronix.de>
References: <20231104211501.3676352-16-u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 00/14] power: reset: Drop platform_driver_probe() and
 convert to platform remove callback returning void
Message-Id: <170009512218.785165.16271461927880645389.b4-ty@collabora.com>
Date:   Thu, 16 Nov 2023 01:38:42 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On Sat, 04 Nov 2023 22:15:02 +0100, Uwe Kleine-König wrote:
> there are two different types of patches here that would justify to
> different series. But as the patches are not independant I chose to put
> them in a single series.
> 
> The first three patches drop usage of platform_driver_probe(). This is a
> concept that isn't so relevant any more today. I didn't check, but it
> saves typically only a few 100k and there are thoughts to deprecate it
> to simplify the core. Getting the usage right is not trivial though the
> at91 drivers got it nearly right. The alternative to these patches is to
> add __ref to the driver struct ideally with a comment describing the
> need like is e.g. done in commit 5b44abbc39ca ("platform/x86: hp-wmi::
> Mark driver struct with __refdata to prevent section mismatch warning").
> 
> [...]

Applied, thanks!

[01/14] power: reset: at91-poweroff: Stop using module_platform_driver_probe()
        commit: 099806de68b75a0fe114376b1ee162fdff572ecc
[02/14] power: reset: at91-reset:: Stop using module_platform_driver_probe()
        commit: 12389c657b623da34ba9b30306e13919d0b42f3a
[03/14] power: reset: at91-sama5d2_shdwc: Stop using module_platform_driver_probe()
        commit: dde74a5de817e0a011e4783cf26295d7f6fdca26
[04/14] power: reset: as3722-poweroff: Convert to platform remove callback returning void
        commit: 904e582f0c7282b3d7c76c73c06f3ad3b0910335
[05/14] power: reset: at91-poweroff: Convert to platform remove callback returning void
        commit: a31438ece3ec27057c77822b0b0bc0614798c425
[06/14] power: reset: atc260x-poweroff: Convert to platform remove callback returning void
        commit: 6f539f3151721f1c90fcdafa2962c19a8efc1afc
[07/14] power: reset: ltc2952-poweroff: Convert to platform remove callback returning void
        commit: 6642b13206b2225b0d75451f5dd763574a2c8bb0
[08/14] power: reset: mt6323-poweroff: Convert to platform remove callback returning void
        commit: 99f7fa6c7cc573ebe2529959723b71b4d12ec2f5
[09/14] power: reset: qnap-poweroff: Convert to platform remove callback returning void
        commit: 1a0457ab2ce81d92c2077a79080141d924884c5f
[10/14] power: reset: regulator-poweroff: Convert to platform remove callback returning void
        commit: 6f7be7b2f15a654a5f08b7d37df282c171b9380b
[11/14] power: reset: restart-poweroff: Convert to platform remove callback returning void
        commit: aedd4da0aa27fe9d0b03b3fbf62376aebbfc385b
[12/14] power: reset: rmobile-reset: Convert to platform remove callback returning void
        commit: 30d26d2be83de0d036f59f384b805dd3bf4bf5ef
[13/14] power: reset: syscon-poweroff: Convert to platform remove callback returning void
        commit: 2973706c4160ed8c1e695b4dfef4bdb3124c5753
[14/14] power: reset: tps65086-restart: Convert to platform remove callback returning void
        commit: 0bf7207e09673144df6425b2cad8bcb015e3501a
[15/15] power: reset: at91-reset: Convert to platform remove callback returning void
        commit: 20cea2b59abe33b80536b936b6729c88d1de2624
[16/16] power: reset: at91-sama5d2_shdwc: Convert to platform remove callback returning void
        commit: 054eb2377523530404fb64c24c8747feb022c5b4

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

