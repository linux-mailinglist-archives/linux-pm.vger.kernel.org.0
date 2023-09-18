Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7697A51CD
	for <lists+linux-pm@lfdr.de>; Mon, 18 Sep 2023 20:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229379AbjIRSMd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Sep 2023 14:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjIRSM2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Sep 2023 14:12:28 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38481103;
        Mon, 18 Sep 2023 11:12:21 -0700 (PDT)
Received: from mercury (dyndsl-091-248-188-252.ewe-ip-backbone.de [91.248.188.252])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6973E6607079;
        Mon, 18 Sep 2023 19:12:19 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1695060739;
        bh=U/6p9D/cU1z0SeNUvPLkslR25HKpH/Me6DaAQtDmwiQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=XyAHg+yfhcIXY5zOX6kbHwgddQuoa6KDfcIPxKAqihfFRZEvBlWKn4trg2hTDRIUr
         lHR4xv3TZQ4VykmFR1QeqBNZXDs0K7hhtdc+OEFztWQR8DqGz4KB7GeaCIlQ28Oq+K
         /9/kjfw2n8k03LGTMvB8txSE9usaUcrsUNtUFwn5HZMSegGGzH+BKfe/vobDQg9Hcw
         xkxRzQZ6JJIEsGhZ3sW8JVIQ7rvI1A4LGBW8I/rHke9n6UQZB7LpDkj5iQ5O1GGY9Q
         GuV6nOtILDg8ZsWawHXiSe35BTGF/fbtx8GZweyzMtEyJQBZ5jKD1PodkzK5Mr30HJ
         uz6G3c+3F6/0w==
Received: by mercury (Postfix, from userid 1000)
        id D9F8510604FE; Mon, 18 Sep 2023 20:12:16 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Linus Walleij <linus.walleij@linaro.org>, linux-pm@vger.kernel.org,
        kernel@pengutronix.de,
        Support Opensource <support.opensource@diasemi.com>,
        =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        patches@opensource.cirrus.com
In-Reply-To: <20230918133700.1254499-1-u.kleine-koenig@pengutronix.de>
References: <20230918133700.1254499-1-u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 00/32] power: supply: Convert to platform remove
 callback returning void
Message-Id: <169506073687.1085711.8096694819191241787.b4-ty@collabora.com>
Date:   Mon, 18 Sep 2023 20:12:16 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On Mon, 18 Sep 2023 15:36:28 +0200, Uwe Kleine-König wrote:
> this series convert all platform drivers below drivers/power/supply to
> use remove_new. The motivation is to get rid of an integer return code
> that is (mostly) ignored by the platform driver core and error prone on
> the driver side.
> 
> See commit 5c5a7680e67b ("platform: Provide a remove callback that
> returns no value") for an extended explanation and the eventual goal.
> 
> [...]

Applied, thanks!

[01/32] power: supply: ab8500_btemp: Convert to platform remove callback returning void
        commit: dab952c77e5a0bad3a391b8cbb6995f32c9a7b6d
[02/32] power: supply: ab8500_chargalg: Convert to platform remove callback returning void
        commit: 465ec888880be0f3170b97a0e975bcb1e9b6961b
[03/32] power: supply: ab8500_charger: Convert to platform remove callback returning void
        commit: c5b08e1bfe087c42e43e64f308b16c6f79444dc9
[04/32] power: supply: ab8500_fg: Convert to platform remove callback returning void
        commit: 59016f4c0e106ec9ba3ac039bf7e96a474648ea6
[05/32] power: supply: acer_a500_battery: Convert to platform remove callback returning void
        commit: 179297b95198526fbef8f6b92f1b486502144861
[06/32] power: supply: act8945a_charger: Convert to platform remove callback returning void
        commit: 7a9a4966777b8df6e6f97f82073f4736a5274358
[07/32] power: supply: charger-manager: Convert to platform remove callback returning void
        commit: 403eebf95c38302cacc48c127e575461f0e798be
[08/32] power: supply: cpcap-battery: Convert to platform remove callback returning void
        commit: 02fecba679bbac3b16c2245e8e462b19fb36cedd
[09/32] power: supply: cpcap-charger: Convert to platform remove callback returning void
        commit: 1abbcff9f0c087e88ae542e0d6b0ee0689881027
[10/32] power: supply: da9030_battery: Convert to platform remove callback returning void
        commit: b5ba26ab7a886567759b793161cdd0aae4a76910
[11/32] power: supply: da9052-battery: Convert to platform remove callback returning void
        commit: ac67d7fd4e1bad9eac25c3a1a07e4aceda6e1ce3
[12/32] power: supply: da9150-charger: Convert to platform remove callback returning void
        commit: 749e18a800569e894e82fb5f68edd447311f9675
[13/32] power: supply: goldfish_battery: Convert to platform remove callback returning void
        commit: df1953bcb723538faff6ebb403ac321797f3b04f
[14/32] power: supply: ipaq_micro_battery: Convert to platform remove callback returning void
        commit: cbc3e1136d1f8b934cc41b4bc12f5c732d543c59
[15/32] power: supply: isp1704_charger: Convert to platform remove callback returning void
        commit: cf79047ed4a33704dd465723175041c22091d24c
[16/32] power: supply: lp8788-charger: Convert to platform remove callback returning void
        commit: 7810ba3c5110ce66652ec6bd2abb92da5d726c3b
[17/32] power: supply: max14577_charger: Convert to platform remove callback returning void
        commit: 81e487b8a4af24c28a3d5c90a6035356098720bb
[18/32] power: supply: max77650-charger: Convert to platform remove callback returning void
        commit: cd25ac3e3200626680dac92c9784cce4d59fdc6b
[19/32] power: supply: max77693_charger: Convert to platform remove callback returning void
        commit: 1d138270d2963b68d71852c363298460ea7435c7
[20/32] power: supply: max8925_power: Convert to platform remove callback returning void
        commit: 026f25f221866ea89a33697935995db6a1c25a52
[21/32] power: supply: pcf50633-charger: Convert to platform remove callback returning void
        commit: 6e3ed20e85aacaed7d3deede835a97029ea14560
[22/32] power: supply: qcom_smbb: Convert to platform remove callback returning void
        commit: 325cb83bbabcafa3e54528d40c86559dde271bc3
[23/32] power: supply: rx51_battery: Convert to platform remove callback returning void
        commit: 9f0da40ae798d3f32d649d1effef246f2c30f13e
[24/32] power: supply: sc2731_charger: Convert to platform remove callback returning void
        commit: 0569d4cfa800ba303647dbf8170d1e89bdee3ed9
[25/32] power: supply: tps65090-charger: Convert to platform remove callback returning void
        commit: 75d8365c94b685dd7377b0251d2407518dc49c02
[26/32] power: supply: tps65217_charger: Convert to platform remove callback returning void
        commit: 07a9398914327bb16584f24dfba02062a5967ab1
[27/32] power: supply: twl4030_charger: Convert to platform remove callback returning void
        commit: 83ef1dbc0de4a127661a175350696e9cfa88bbb1
[28/32] power: supply: twl4030_madc_battery: Convert to platform remove callback returning void
        commit: ac51982b04a05eb902a223b3bc83c032903b6ba7
[29/32] power: supply: wm831x_backup: Convert to platform remove callback returning void
        commit: fc7b34ae1347f4eb36f065458e53d6065cd85928
[30/32] power: supply: wm831x_power: Convert to platform remove callback returning void
        commit: dab68bbb5450ee17c9acf77916ac2ed659b1e2a7
[31/32] power: supply: wm8350_power: Convert to platform remove callback returning void
        commit: 42720969f394dc074ce1c99cd0c425b7dd6017ee
[32/32] power: supply: wm97xx_battery: Convert to platform remove callback returning void
        commit: 6f9fb8afe649a24c7df50ce2f7095b832713e648

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

