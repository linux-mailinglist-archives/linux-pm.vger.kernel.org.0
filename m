Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F171443C34
	for <lists+linux-pm@lfdr.de>; Wed,  3 Nov 2021 05:24:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231354AbhKCE1K (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 3 Nov 2021 00:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231326AbhKCE1J (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 3 Nov 2021 00:27:09 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41968C061714
        for <linux-pm@vger.kernel.org>; Tue,  2 Nov 2021 21:24:33 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id x9so1280997ilu.6
        for <linux-pm@vger.kernel.org>; Tue, 02 Nov 2021 21:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qd9niP3KfEBMw4HIl0dxDVF+NpZQ1ObcVJeYPjAsGSc=;
        b=HPtJMRW5T8UxUkbBR6GaM63fFwANkJW6W9Bif4jilZl+sVzZSwZ1/A0VDVRuvcxg01
         TeJn8wEHZi8eGbuexfg5M4xTXOhj9T9JpIx+WeE9g2sMuKGHYIuRRTbmZkQt7GQLiEoP
         rI2LD+XBU5OE14Y19R6r5EqQue09SKki/n10I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qd9niP3KfEBMw4HIl0dxDVF+NpZQ1ObcVJeYPjAsGSc=;
        b=RokrcsSyj4LtJDp04Xglc/AzBPY+6R9yTniOpWoGT/QzBs1Cawr4jBix3sgCZ4yXF8
         MpYsFAs+4H4YeIeqMaaZV5J7c/yPgxcqZYPsSp9htCk6g2cIJ3osX2Lu4r7tMwG/bpRC
         6uY5//jRZMYNajOBVy8EtQFxHT5eBTFthpS1b26L5pQ7hbMvp2TflWQvKAtVT2tZCRPS
         L/80k0xugpocnzinBEYLsQoL6t/BkySFcHZmCfwDi1joHRUHEQa8xs0mVq6wDYUSoetR
         MzD9Lj6umxv5qpWj4v+pyAOsQ+1nH4LbPlBdLkq3C8mf2phBFh9DtyLwdNT2PSuUw3lT
         ckHg==
X-Gm-Message-State: AOAM533fkg+MwIkibmAS8PftzHHvKglq6cfHyvAVox2YqgxA7VJc69zM
        910RRNbrbrUKo3cbP4nR9IH3A7BFM98PIRks4Fb0XA==
X-Google-Smtp-Source: ABdhPJy3oZIzJMttIMrK4JQVP+jPpcvnejYcs3cfvoEQi/cY6TDF0e9IPwvsIsX+mmqGss9bK7IZIXnvXQrZKbO7xvk=
X-Received: by 2002:a05:6e02:1aa2:: with SMTP id l2mr17121937ilv.114.1635913472602;
 Tue, 02 Nov 2021 21:24:32 -0700 (PDT)
MIME-Version: 1.0
References: <20211103033044.2777-1-ben.tseng@mediatek.com>
In-Reply-To: <20211103033044.2777-1-ben.tseng@mediatek.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Wed, 3 Nov 2021 12:24:06 +0800
Message-ID: <CAJMQK-jJYoBLoY2aw=BuhowJ7AENK_8y=GHVq5opHKfq5gD45Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] arm64: dts: mt8183-kukui: Update Tboard sensor
 mapping table
To:     Ben Tseng <ben.tseng@mediatek.com>
Cc:     Fan Chen <fan.chen@mediatek.com>, Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org, srv_heupstream@mediatek.com,
        Eduardo Valentin <edubezval@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Nov 3, 2021 at 11:31 AM Ben Tseng <ben.tseng@mediatek.com> wrote:
>
> According to auxadc change the readback value from raw data to Vsense.
> Update the tboard table that temperature map to Vsense.
>
> pull-up voltage: 1800 mv
> pull-up resistor: 75K
>
> Vsense = pull-up voltage * Rntc / ( pull-up resistor + Rntc )
>
> Signed-off-by: Ben Tseng <ben.tseng@mediatek.com>
>

Tested-by: Hsin-Yi Wang <hsinyi@chromium.org>

> ---
>  .../arm64/boot/dts/mediatek/mt8183-kukui.dtsi | 108 +++++++++---------
>  1 file changed, 54 insertions(+), 54 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
> index 8e9cf36a9a41..65447de64f06 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
> @@ -151,33 +151,33 @@
>                 #thermal-sensor-cells = <0>;
>                 io-channels = <&auxadc 0>;
>                 io-channel-names = "sensor-channel";
> -               temperature-lookup-table = <    (-5000) 4241
> -                                               0 4063
> -                                               5000 3856
> -                                               10000 3621
> -                                               15000 3364
> -                                               20000 3091
> -                                               25000 2810
> -                                               30000 2526
> -                                               35000 2247
> -                                               40000 1982
> -                                               45000 1734
> -                                               50000 1507
> -                                               55000 1305
> -                                               60000 1122
> -                                               65000 964
> -                                               70000 827
> -                                               75000 710
> -                                               80000 606
> -                                               85000 519
> -                                               90000 445
> -                                               95000 382
> -                                               100000 330
> -                                               105000 284
> -                                               110000 245
> -                                               115000 213
> -                                               120000 183
> -                                               125000 161>;
> +               temperature-lookup-table = <    (-5000) 1553
> +                                               0 1488
> +                                               5000 1412
> +                                               10000 1326
> +                                               15000 1232
> +                                               20000 1132
> +                                               25000 1029
> +                                               30000 925
> +                                               35000 823
> +                                               40000 726
> +                                               45000 635
> +                                               50000 552
> +                                               55000 478
> +                                               60000 411
> +                                               65000 353
> +                                               70000 303
> +                                               75000 260
> +                                               80000 222
> +                                               85000 190
> +                                               90000 163
> +                                               95000 140
> +                                               100000 121
> +                                               105000 104
> +                                               110000 90
> +                                               115000 78
> +                                               120000 67
> +                                               125000 59>;
>         };
>
>         tboard_thermistor2: thermal-sensor2 {
> @@ -185,33 +185,33 @@
>                 #thermal-sensor-cells = <0>;
>                 io-channels = <&auxadc 1>;
>                 io-channel-names = "sensor-channel";
> -               temperature-lookup-table = <    (-5000) 4241
> -                                               0 4063
> -                                               5000 3856
> -                                               10000 3621
> -                                               15000 3364
> -                                               20000 3091
> -                                               25000 2810
> -                                               30000 2526
> -                                               35000 2247
> -                                               40000 1982
> -                                               45000 1734
> -                                               50000 1507
> -                                               55000 1305
> -                                               60000 1122
> -                                               65000 964
> -                                               70000 827
> -                                               75000 710
> -                                               80000 606
> -                                               85000 519
> -                                               90000 445
> -                                               95000 382
> -                                               100000 330
> -                                               105000 284
> -                                               110000 245
> -                                               115000 213
> -                                               120000 183
> -                                               125000 161>;
> +               temperature-lookup-table = <    (-5000) 1553
> +                                               0 1488
> +                                               5000 1412
> +                                               10000 1326
> +                                               15000 1232
> +                                               20000 1132
> +                                               25000 1029
> +                                               30000 925
> +                                               35000 823
> +                                               40000 726
> +                                               45000 635
> +                                               50000 552
> +                                               55000 478
> +                                               60000 411
> +                                               65000 353
> +                                               70000 303
> +                                               75000 260
> +                                               80000 222
> +                                               85000 190
> +                                               90000 163
> +                                               95000 140
> +                                               100000 121
> +                                               105000 104
> +                                               110000 90
> +                                               115000 78
> +                                               120000 67
> +                                               125000 59>;
>         };
>  };
>
> --
> 2.18.0
>
