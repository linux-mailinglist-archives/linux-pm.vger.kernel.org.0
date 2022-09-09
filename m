Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E53AB5B3EE6
	for <lists+linux-pm@lfdr.de>; Fri,  9 Sep 2022 20:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbiIISeQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Sep 2022 14:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbiIISeP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Sep 2022 14:34:15 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11201139AE7;
        Fri,  9 Sep 2022 11:34:12 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1oWipH-0007Ij-Qj; Fri, 09 Sep 2022 20:34:03 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Chris Morgan <macroalpha82@gmail.com>, linux-pm@vger.kernel.org
Cc:     Heiko Stuebner <heiko@sntech.de>, jon.lin@rock-chips.com,
        Chris Morgan <macromorgan@hotmail.com>, zyw@rock-chips.com,
        maccraft123mc@gmail.com, zhangqing@rock-chips.com, lee@kernel.org,
        robh+dt@kernel.org, linux-rockchip@lists.infradead.org,
        philip@pscan.uk, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, sre@kernel.org,
        mazziesaccount@gmail.com
Subject: Re: (subset) [PATCH V10 0/4] power: supply: Add Support for RK817 Charger
Date:   Fri,  9 Sep 2022 20:33:48 +0200
Message-Id: <166274831282.21181.10815388429575993690.b4-ty@sntech.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220827021623.23829-1-macroalpha82@gmail.com>
References: <20220827021623.23829-1-macroalpha82@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 26 Aug 2022 21:16:19 -0500, Chris Morgan wrote:
> This series is to add support for the Rockchip rk817 battery charger
> which is present in all Rockchip RK817 PMICs. The driver was written
> as a joint effort by Maya Matuszczyk <maccraft123mc@gmail.com> and
> myself Chris Morgan <macromorgan@hotmail.com>.
> 
> The driver requires some basic parameters be described about the
> battery in the devicetree such as the maximum capacity, the minimum
> and maximum voltage for the battery, the maximum charge current, the
> maximum charge voltage, and the value of sample resistors and sleep
> currents.
> 
> [...]

Applied, thanks!

[4/4] arm64: dts: rockchip: add rk817 chg to Odroid Go Advance
      commit: a5d5e515ed89709de8ad2537cd9d611b95e1928b

With the binding having gotten applied, this could go in.
It just leaves the charger-driver to be handled.


Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
