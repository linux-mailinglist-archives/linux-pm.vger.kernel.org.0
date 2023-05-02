Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9FB76F41C8
	for <lists+linux-pm@lfdr.de>; Tue,  2 May 2023 12:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233960AbjEBKgz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 2 May 2023 06:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233966AbjEBKgM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 2 May 2023 06:36:12 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85C654EED
        for <linux-pm@vger.kernel.org>; Tue,  2 May 2023 03:35:47 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-51fcf5d1e44so3090665a12.3
        for <linux-pm@vger.kernel.org>; Tue, 02 May 2023 03:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1683023747; x=1685615747;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1k/rwLcFO2bB3Oa74LdI4dO5dKJGAnDPj2NzOWcALug=;
        b=FxTb+Whw3s4DsO+LoDJSIj9HK/kqLMLJw5iBHlim3UjK1ozu2HxriBtEICQMGvIr2V
         z8pWvpLlDbSlP9orffy5OMwDMsOUpoJdfHrJjo5lSH7ZLI0NIrTGkdk9srG+MmqLMyf2
         rdS9Rsc6sS1J/zPo6ZtaEkyQHUZNiE1pwYrsA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683023747; x=1685615747;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1k/rwLcFO2bB3Oa74LdI4dO5dKJGAnDPj2NzOWcALug=;
        b=Pp9qbHcglVgz+rkItgVTJDCKJ1H/0odom+IEKZbIsRKtBpcbd5xEwUPkfJ0Y3Krhh3
         tTs/wlPwzD+oQa/z3Jq0+PjqQ4x/Rg02MFMG9ZljYBhlTo5qXkkPSlXkdPPvrWp8Ks4i
         nZd9MNnJQKQumn8bmurVWsSygDcn80G2IgCuCJX7BaKRB7MpRky1ZwEl2RpVAyfTXuuL
         LI7Nl2MU3blyyf4Ps+IQ5gpszO5jL+eO8G16cgBBma3p66jAq9wrUFEkQFrpTJ+CMecN
         Hsye2lz/joW9JfrcMEerohITd1FMLgCJfxjZ8E8b/Ub8YXOOZd5cPcCtKl+k0tjpm48d
         OoZg==
X-Gm-Message-State: AC+VfDzYGz26awvBB9AGI2Zam5oPou3VIzJsVh7In5TobyaNvZBHNX1N
        nB/1vccvQpiE//BlY81xJ+eOJg==
X-Google-Smtp-Source: ACHHUZ7ArtFdVhB+1t61Ffe4OEgVtAY5Cs3jlOqJpXteLdfbH8M29DO6/5eoroavSX0VUh4PxTp2DA==
X-Received: by 2002:a05:6a21:329f:b0:f0:a282:a343 with SMTP id yt31-20020a056a21329f00b000f0a282a343mr22950107pzb.16.1683023746979;
        Tue, 02 May 2023 03:35:46 -0700 (PDT)
Received: from google.com ([2401:fa00:1:10:b873:4627:7ea:a0dd])
        by smtp.gmail.com with ESMTPSA id j14-20020a17090a588e00b0024e2980574asm1052755pji.4.2023.05.02.03.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 03:35:46 -0700 (PDT)
Date:   Tue, 2 May 2023 18:35:41 +0800
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     bchihi@baylibre.com
Cc:     daniel.lezcano@linaro.org, angelogioacchino.delregno@collabora.com,
        rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, rdunlap@infradead.org,
        ye.xingchen@zte.com.cn, p.zabel@pengutronix.de,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        james.lo@mediatek.com, rex-bc.chen@mediatek.com,
        nfraprado@collabora.com, abailon@baylibre.com,
        amergnat@baylibre.com, khilman@baylibre.com
Subject: Re: [PATCH v2 0/5] Add LVTS support for mt8192
Message-ID: <20230502103541.GB3388518@google.com>
References: <20230425133052.199767-1-bchihi@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230425133052.199767-1-bchihi@baylibre.com>
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Apr 25, 2023 at 03:30:47PM +0200, bchihi@baylibre.com wrote:
> From: Balsam CHIHI <bchihi@baylibre.com>
> 
> Add full LVTS support (MCU thermal domain + AP thermal domain) to MediaTek MT8192 SoC.
> Also, add Suspend and Resume support to LVTS Driver (all SoCs),
> and update the documentation that describes the Calibration Data Offsets.
> 
> Changelog:
>     v2 :
>         - Based on top of thermal/linux-next :
>             base-commit: 7ac82227ee046f8234471de4c12a40b8c2d3ddcc
>         - Squash "add thermal zones and thermal nodes" and
>             "add temperature mitigation threshold" commits together to form
>             "arm64: dts: mediatek: mt8192: Add thermal nodes and thermal zones" commit.
>         - Add Suspend and Resume support to LVTS Driver.
>         - Update Calibration Data documentation.
>         - Fix calibration data offsets for mt8192
>             (Thanks to "Chen-Yu Tsai" and "N�colas F. R. A. Prado").
> 
>     v1 :
>         - The initial series "Add LVTS support for mt8192" :
>             "https://lore.kernel.org/all/20230307163413.143334-1-bchihi@baylibre.com/".
> 
> Balsam CHIHI (5):
>   thermal/drivers/mediatek/lvts_thermal: Add suspend and resume
>   dt-bindings: thermal: mediatek: Add LVTS thermal controller definition
>     for mt8192
>   thermal/drivers/mediatek/lvts_thermal: Add mt8192 support
>   arm64: dts: mediatek: mt8192: Add thermal nodes and thermal zones
>   thermal/drivers/mediatek/lvts_thermal: Update calibration data
>     documentation

Tested-by: Chen-Yu Tsai <wenst@chromium.org>

on a MT8192 Hayato Chromebook. Sensor readings look OK. Haven't tried
stress testing to hit thermal threshold yet.
