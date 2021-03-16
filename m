Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2698433DB84
	for <lists+linux-pm@lfdr.de>; Tue, 16 Mar 2021 18:54:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbhCPRyR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Mar 2021 13:54:17 -0400
Received: from mail-io1-f50.google.com ([209.85.166.50]:42133 "EHLO
        mail-io1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239351AbhCPRyM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Mar 2021 13:54:12 -0400
Received: by mail-io1-f50.google.com with SMTP id u20so38105868iot.9;
        Tue, 16 Mar 2021 10:54:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=Z93rlUj9sdWeq37uZfM03RuUP74yX70Y9MLTGZ1xQjw=;
        b=e27tK+eOU1ayF0YZhD4iP21I89e/adqzgnYnwUeMh7rJbNJI8WLG9nfLWL6fZhm3sX
         sCXxlc+tZKt92fmcbKhwOILvGYli2sZDWpN1rfJsTxuFSzPoPfvauqZKUHpv0wEPYJNz
         xFzoULuBSL9OQIKBPh3zzuBjWaG+1IBDdGmlqX+Km9+3d0WAINSwhpa7Nw5iYRh1D+uu
         czpMrUhJMy7Bn6DAGFXQwhRZsEWkxDGAULuIXyxXfLdTS5e79LODYQEr5iToT46823mk
         9jT5hVZA/M8MR4gEoEspvmZGTKcY4Pxd//AcN8nczrN8+dYhcp5ORNlzCr5BdDATP7Ac
         Gr7g==
X-Gm-Message-State: AOAM533oUnr9C7vvlMbHmXNhWW//U16F9pDjnTCd3M5Jngj0qgSKJtj5
        kyKUPmYlDPUlMi5NFN9Zag==
X-Google-Smtp-Source: ABdhPJx9NqGassAFyEjEetsnxzPc4LiCv5OZO+q67dVfM9IFfAuk7yGqkR/agnODdaVp/QC2A1v/ig==
X-Received: by 2002:a05:6602:26cb:: with SMTP id g11mr4090124ioo.180.1615917252062;
        Tue, 16 Mar 2021 10:54:12 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id l16sm9795688ils.11.2021.03.16.10.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 10:54:11 -0700 (PDT)
Received: (nullmailer pid 3326118 invoked by uid 1000);
        Tue, 16 Mar 2021 17:54:09 -0000
From:   Rob Herring <robh@kernel.org>
To:     Roger Lu <roger.lu@mediatek.com>
Cc:     Kevin Hilman <khilman@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        HenryC Chen <HenryC.Chen@mediatek.com>,
        Angus Lin <Angus.Lin@mediatek.com>,
        Nicolas Boichat <drinkcat@google.com>,
        YT Lee <yt.lee@mediatek.com>, Stephen Boyd <sboyd@kernel.org>,
        Charles Yang <Charles.Yang@mediatek.com>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Fan Chen <fan.chen@mediatek.com>,
        linux-mediatek@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Xiaoqing Liu <Xiaoqing.Liu@mediatek.com>,
        Nishanth Menon <nm@ti.com>, linux-pm@vger.kernel.org
In-Reply-To: <20210315133018.4976-2-roger.lu@mediatek.com>
References: <20210315133018.4976-1-roger.lu@mediatek.com> <20210315133018.4976-2-roger.lu@mediatek.com>
Subject: Re: [PATCH v12 1/7] dt-bindings: soc: mediatek: add mtk svs dt-bindings
Date:   Tue, 16 Mar 2021 11:54:09 -0600
Message-Id: <1615917249.208932.3326117.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 15 Mar 2021 21:30:12 +0800, Roger Lu wrote:
> Document the binding for enabling mtk svs on MediaTek SoC.
> 
> Signed-off-by: Roger Lu <roger.lu@mediatek.com>
> ---
>  .../bindings/soc/mediatek/mtk-svs.yaml        | 81 +++++++++++++++++++
>  1 file changed, 81 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/mediatek/mtk-svs.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/soc/mediatek/mtk-svs.yaml: properties:nvmem-cells:maxItems: False schema does not allow 2
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/soc/mediatek/mtk-svs.yaml: ignoring, error in schema: properties: nvmem-cells: maxItems
warning: no schema found in file: ./Documentation/devicetree/bindings/soc/mediatek/mtk-svs.yaml

See https://patchwork.ozlabs.org/patch/1453275

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

