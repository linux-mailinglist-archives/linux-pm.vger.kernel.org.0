Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22FB45EDEE8
	for <lists+linux-pm@lfdr.de>; Wed, 28 Sep 2022 16:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234407AbiI1OhB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 28 Sep 2022 10:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234087AbiI1OhA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 28 Sep 2022 10:37:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DCCCAB419;
        Wed, 28 Sep 2022 07:36:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2760261EC2;
        Wed, 28 Sep 2022 14:36:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62B6AC433D6;
        Wed, 28 Sep 2022 14:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664375818;
        bh=AKYUXMSFyJEZ3MGh7qhq3oHM1Mb/mSjFZvL+qW4J4Xw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cilv0RnWY6aMcLrOusXlX2smuNnfveULRAIwVCDtx9cP9A+F7KiyS9pnTLXK8GoFN
         iYNGFqn1cI5XffnO+PzjmkI4o2+hNjz6eyHFR9heN6HD4HrkItuvqggRHRN1jFglRA
         o2FZCXXxFyGIXzlacxBkMPz4Aoh1Gb91/fQfMjBe6FoasNyEUEzk8sL2vgcA6hdtR8
         336BaQCy71O1WY4us+f4/JcBHSCeBsavWWoISeUu7R87yHPm7A8jYTc5xI5l4n9m75
         V+0upk/xVcP4CotURW7XiVT+TRuDVmSDmoH92HBcUEmlPPjmujUpt2z9SDpEHftDmN
         7H/T/XXYM3GUg==
Date:   Wed, 28 Sep 2022 15:36:52 +0100
From:   Lee Jones <lee@kernel.org>
To:     Chris Morgan <macroalpha82@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, zhangqing@rock-chips.com,
        zyw@rock-chips.com, jon.lin@rock-chips.com,
        maccraft123mc@gmail.com, sre@kernel.org, heiko@sntech.de,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        philip@pscan.uk, mazziesaccount@gmail.com,
        Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH V10 3/4] power: supply: Add charger driver for Rockchip
 RK817
Message-ID: <YzRcBJ7HHstO49Eq@google.com>
References: <20220827021623.23829-1-macroalpha82@gmail.com>
 <20220827021623.23829-4-macroalpha82@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220827021623.23829-4-macroalpha82@gmail.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 26 Aug 2022, Chris Morgan wrote:

> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Add support for the Rockchip rk817 battery charger integrated into the
> rk817 PMIC.
> 
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> Signed-off-by: Maya Matuszczyk <maccraft123mc@gmail.com>
> ---
>  drivers/power/supply/Kconfig         |    6 +
>  drivers/power/supply/Makefile        |    1 +
>  drivers/power/supply/rk817_charger.c | 1211 ++++++++++++++++++++++++++
>  3 files changed, 1218 insertions(+)
>  create mode 100644 drivers/power/supply/rk817_charger.c

Applied, thanks.

-- 
Lee Jones [李琼斯]
