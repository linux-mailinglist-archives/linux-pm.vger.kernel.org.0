Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11BC27CD11E
	for <lists+linux-pm@lfdr.de>; Wed, 18 Oct 2023 02:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbjJRAH0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 Oct 2023 20:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjJRAHZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 17 Oct 2023 20:07:25 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D500AC4
        for <linux-pm@vger.kernel.org>; Tue, 17 Oct 2023 17:07:23 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2c50d1b9f22so52645191fa.0
        for <linux-pm@vger.kernel.org>; Tue, 17 Oct 2023 17:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697587642; x=1698192442; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yL5IHSgiOPCaseF8jxFxoTKSJkLG4FnIxMof3Q5FawM=;
        b=clXo2BuXwWDeIGHWv6y1m7WBxmQt5y7kTjRrxV5RlJ7+e4RmwbCkHBdPYHWmcpday+
         e6/HW3c/+1HuhSfRrVOBwA1ph13ytHoAh4u9tVwWF6VttJOHf9tMh8KJN6OzKDL8RuLd
         1ElbON6TzF86S9AhHUnouq75QrEyuySIsu1+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697587642; x=1698192442;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yL5IHSgiOPCaseF8jxFxoTKSJkLG4FnIxMof3Q5FawM=;
        b=SFYDnP3H+p7qHg0GX++cxzpf5roGbeeikaNi8nQtvJZVEI14IBB2ojqrOZOyuMVZCG
         7w86yAbXME+6Ab7v4NDFLAqm3FTIwxMfSr24VjhSzvi8miPfHYdLVY2J8yoR9CpNWnpE
         EfW89p5J0nIg04BNLF+C5YjMkPvYzz6KTVUCjn7YY+gahdcuojDnM/P3ZDQ50BX6QUsm
         Pv0glLPYPwVFPKE4qx5uM5bEhBSkhsjFGdK32ZnmNm6bvYAlJNdu//6emjfCbNN3KMu4
         lEZQCzher+mk7RT67UKzd+s+5cmNjad2SY6ozIRaQqZb/zddLnH48Pr66oYbI4wvbjAU
         TagA==
X-Gm-Message-State: AOJu0YzFWa6JifTbF3RIVZjaRAEgW2+/ZF9dn1CfE6GAitma799eFZd+
        4m1ZtlXmJMc3iTyZmEmXxundXJP7jQXZy3/fxoI7Pw==
X-Google-Smtp-Source: AGHT+IHdYpQ7b2GTg0pg2e6yXIg3WUzgg6FphjxIscthWaEOsQp4Vnpo/InQm+NVk8R54x4Et7gna/2lIz01hIOxMHE=
X-Received: by 2002:ac2:598c:0:b0:507:a33f:135d with SMTP id
 w12-20020ac2598c000000b00507a33f135dmr2672443lfn.4.1697587641970; Tue, 17 Oct
 2023 17:07:21 -0700 (PDT)
MIME-Version: 1.0
References: <20231017190545.157282-1-bero@baylibre.com>
In-Reply-To: <20231017190545.157282-1-bero@baylibre.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 17 Oct 2023 17:07:10 -0700
Message-ID: <CAGXv+5FwkBU3wfyZWWaiOgzLACfMVs4Bnu2KM4oSCUa28SzXVw@mail.gmail.com>
Subject: Re: [PATCH v5 0/5] Add LVTS support for mt8192
To:     =?UTF-8?Q?Bernhard_Rosenkr=C3=A4nzer?= <bero@baylibre.com>
Cc:     daniel.lezcano@linaro.org, angelogioacchino.delregno@collabora.com,
        rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dunlap@infradead.org,
        e.xingchen@zte.com.cn, p.zabel@pengutronix.de,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        ames.lo@mediatek.com, rex-bc.chen@mediatek.com,
        nfraprado@collabora.com, abailon@baylibre.com,
        amergnat@baylibre.com, khilman@baylibre.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On Tue, Oct 17, 2023 at 12:05=E2=80=AFPM Bernhard Rosenkr=C3=A4nzer
<bero@baylibre.com> wrote:
>
> Add full LVTS support (MCU thermal domain + AP thermal domain) to MediaTe=
k MT8192 SoC.
> Also, add Suspend and Resume support to LVTS Driver (all SoCs),
> and update the documentation that describes the Calibration Data Offsets.
>
> v5 changes are a lot smaller than originally assumed -- commit
> 185673ca71d3f7e9c7d62ee5084348e084352e56 fixed the issue I
> was originally planning to work around in this patchset,
> so what remains for v5 is noirq and cosmetics.

I see two series in my inbox and on the mailing list. Which one is the
correct one?

Thanks
ChenYu

> Changelog:
>    v5 :
>         - Suspend/Resume in noirq stage
>         - Reorder chipset specific functions
>         - Rebased :
>             base-commit: 4d5ab2376ec576af173e5eac3887ed0b51bd8566
>
>    v4 :
>         - Shrink the lvts_ap thermal sensor I/O range to 0xc00 to make
>           room for SVS support, pointed out by
>           AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora=
.com>
>
>     v3 :
>         - Rebased :
>             base-commit: 6a3d37b4d885129561e1cef361216f00472f7d2e
>         - Fix issues in v2 pointed out by N=C3=ADcolas F. R. A. Prado <nf=
raprado@collabora.com>:
>           Use filtered mode to make sure threshold interrupts are trigger=
ed,
>           protocol documentation, cosmetics
>         - I (bero@baylibre.com) will be taking care of this patchset
>           from now on, since Balsam has left BayLibre. Thanks for
>           getting it almost ready, Balsam!
>
>     v2 :
>         - Based on top of thermal/linux-next :
>             base-commit: 7ac82227ee046f8234471de4c12a40b8c2d3ddcc
>         - Squash "add thermal zones and thermal nodes" and
>             "add temperature mitigation threshold" commits together to fo=
rm
>             "arm64: dts: mediatek: mt8192: Add thermal nodes and thermal =
zones" commit.
>         - Add Suspend and Resume support to LVTS Driver.
>         - Update Calibration Data documentation.
>         - Fix calibration data offsets for mt8192
>             (Thanks to "Chen-Yu Tsai" and "N=C3=ADcolas F. R. A. Prado").
>         https://lore.kernel.org/all/20230425133052.199767-1-bchihi@baylib=
re.com/
>         Tested-by: Chen-Yu Tsai <wenst@chromium.org>
>
>     v1 :
>         - The initial series "Add LVTS support for mt8192" :
>             "https://lore.kernel.org/all/20230307163413.143334-1-bchihi@b=
aylibre.com/".
>
> Balsam CHIHI (5):
>   dt-bindings: thermal: mediatek: Add LVTS thermal controller definition
>     for mt8192
>   thermal/drivers/mediatek/lvts_thermal: Add suspend and resume
>   thermal/drivers/mediatek/lvts_thermal: Add mt8192 support
>   arm64: dts: mediatek: mt8192: Add thermal nodes and thermal zones
>   thermal/drivers/mediatek/lvts_thermal: Update calibration data
>     documentation
>
>  arch/arm64/boot/dts/mediatek/mt8192.dtsi      | 454 ++++++++++++++++++
>  drivers/thermal/mediatek/lvts_thermal.c       | 163 ++++++-
>  .../thermal/mediatek,lvts-thermal.h           |  19 +
>  3 files changed, 634 insertions(+), 2 deletions(-)
>
> --
> 2.42.0
