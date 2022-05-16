Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A89E527D10
	for <lists+linux-pm@lfdr.de>; Mon, 16 May 2022 07:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239355AbiEPFff (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 May 2022 01:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239061AbiEPFfc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 May 2022 01:35:32 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD8A2DF34
        for <linux-pm@vger.kernel.org>; Sun, 15 May 2022 22:35:30 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id j28so2764746eda.13
        for <linux-pm@vger.kernel.org>; Sun, 15 May 2022 22:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c/IovKeDQ5OmYImuaDKw85Gvkz+g6dB9ube8wouUX0E=;
        b=GGajIGxKz4a1kdgVCnNp3TVY4oWNsaMBX25vD2wNxJjdlfjW0K2HSomOmhtNf8KlII
         I/KzDUxpS795xfRF8NdRofQwNVP/BcZW3gRgq5wCMrBCZXhJNS+FRleC+mG3irXz/3aO
         +mT31wgaBGkXLx4Qfi9CCUwCaASTGFEm4O6+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c/IovKeDQ5OmYImuaDKw85Gvkz+g6dB9ube8wouUX0E=;
        b=k0Fi8L0cIGe+WDnQeUbD3r8zx6+fkwHiEChdz/xfYvZ5c7QZPn5hCeJ1kU3uR2mAHa
         pnNHj4sNCSV6IIlyFU+kbxaxIMuI/fxs19c4+fGq+5XqTgbGRD42wKmCT/BbncW/VqEM
         smDK+9NpzkJzMu4Xeij5XXl3koNoLxs7HVhH5eHIrn4/vXBr6wwnrxqtUid/4Uxfc51L
         HrlEzG32nzCEch3k0fB+r1Af0GNny67A7nV2iuVdS+YCg61HEKkEOxgLBJt/VmYSClKW
         muLY55TWkC247rX2xUfmunV6XSzM9PlvWeEd1LEVl1bdtLCMhFWNlinEK+QaQxMHp59f
         Ud2w==
X-Gm-Message-State: AOAM531vGJEyMjw5o3M3wAIvBqqAsoB7GuWPj8c/4tSYxo55bOmVWXnr
        Q3MxUuI9amzFeMFsonbAx9aexmUKupyscZdmZeaAdQ==
X-Google-Smtp-Source: ABdhPJxkaaQU1pxAn/HNEptaZ1FK3UV5eSAHcvlMeQ1pJimMFp8UJ4ll80vonmeQUOiLh7XTmmmV9IDAbxXEwPO61wM=
X-Received: by 2002:a05:6402:11cd:b0:427:bda5:542f with SMTP id
 j13-20020a05640211cd00b00427bda5542fmr11486167edw.290.1652679329459; Sun, 15
 May 2022 22:35:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220505115226.20130-1-rex-bc.chen@mediatek.com> <20220505115226.20130-10-rex-bc.chen@mediatek.com>
In-Reply-To: <20220505115226.20130-10-rex-bc.chen@mediatek.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 16 May 2022 13:35:18 +0800
Message-ID: <CAGXv+5FW59B1Dq8eH=5KjEdTxgT64GuvYZHZ9LnnTuaVrK3XpQ@mail.gmail.com>
Subject: Re: [PATCH v6 09/10] arm64: dts: mediatek: Add MediaTek CCI node for MT8183
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>
Cc:     rafael@kernel.org, viresh.kumar@linaro.org, robh+dt@kernel.org,
        krzk+dt@kernel.org, matthias.bgg@gmail.com,
        jia-wei.chang@mediatek.com, roger.lu@mediatek.com,
        hsinyi@google.com, khilman@baylibre.com,
        angelogioacchino.delregno@collabora.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        "Andrew-sh . Cheng" <andrew-sh.cheng@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, May 5, 2022 at 8:04 PM Rex-BC Chen <rex-bc.chen@mediatek.com> wrote:
>
> Add MediaTek CCI devfreq node for MT8183.
>
> Signed-off-by: Andrew-sh.Cheng <andrew-sh.cheng@mediatek.com>
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt8183-evb.dts    | 4 ++++
>  arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi | 4 ++++
>  arch/arm64/boot/dts/mediatek/mt8183.dtsi       | 7 +++++++
>  3 files changed, 15 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183-evb.dts b/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
> index 8953dbf84f3e..7ac9864db9de 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
> @@ -412,6 +412,10 @@
>
>  };
>
> +&cci {
> +       proc-supply = <&mt6358_vproc12_reg>;
> +};
> +
>  &cpu0 {
>         proc-supply = <&mt6358_vproc12_reg>;
>  };
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
> index 8d5bf73a9099..b035e06840e6 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
> @@ -230,6 +230,10 @@
>         status = "okay";
>  };
>
> +&cci {
> +       proc-supply = <&mt6358_vproc12_reg>;
> +};
> +
>  &cpu0 {
>         proc-supply = <&mt6358_vproc12_reg>;
>  };
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> index cecf96b628b7..11caf3dd85cd 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> @@ -280,6 +280,13 @@
>                 };
>         };
>
> +       cci: cci {
> +               compatible = "mediatek,mt8183-cci";
> +               clocks = <&apmixedsys CLK_APMIXED_CCIPLL>;
> +               clock-names = "cci_clock";

Binding says there should be two clocks: the actual clock that drives
CCI, and a stable "intermediate" clock to switch to during clock rate
changes. So I think this should look like:

    clocks = <&mcucfg CLK_MCU_BUS_SEL>,
             <&topckgen CLK_TOP_ARMPLL_DIV_PLL1>;
    clock-names = "cci", "intermediate";


ChenYu

> +               operating-points-v2 = <&cci_opp>;
> +       };
> +
>         cpus {
>                 #address-cells = <1>;
>                 #size-cells = <0>;
> --
> 2.18.0
>
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
