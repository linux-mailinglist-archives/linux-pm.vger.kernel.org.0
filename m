Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93A6C3469B4
	for <lists+linux-pm@lfdr.de>; Tue, 23 Mar 2021 21:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233222AbhCWURJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Mar 2021 16:17:09 -0400
Received: from mail-io1-f41.google.com ([209.85.166.41]:33310 "EHLO
        mail-io1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233276AbhCWURA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Mar 2021 16:17:00 -0400
Received: by mail-io1-f41.google.com with SMTP id n198so19106054iod.0;
        Tue, 23 Mar 2021 13:17:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=20xlh8LGB3xwHBaeVz4zoEufs7vqABRi50X0pBG/dOI=;
        b=AfUG3OALQa6IDRMJVT+UYiFXnQC/qBHk1iyI+FwTb++1pUtN+VVEIkmSM+nF1ELZjo
         5qNh6Zd9Z+XXagTcKt7q+TsBflwOpd0WyJxVZhT3fYlch8wUJNhx45wJDH6w8r5eESKH
         /OD7+A1FvnbmvpGPY2Szp+Xgt30R2jSGLgfAeJyte3nSTEfQG5D4yePjE/tyHuoZCWPN
         lBMuhrYC3hDKQ5xkUxb1EHYC/CSfew2LJ/vGQs3r3UY51W8l5mH3kG7T2B1Zfp9kdOb6
         H80wMyZG3O6G3SZMqL9VgU6irhOcauCFKEW7PlZLrry5Bby/IIF5Is0cIeVZyid5gbd7
         Na1w==
X-Gm-Message-State: AOAM530wlijKhuo5XbM6IBkDyZMCTQNfzZ8fRqkTnHnWCEHln12+eWfg
        tBy4LnOwNicDRFHwmeaciw==
X-Google-Smtp-Source: ABdhPJwm5asRgRsRfOt9jGTSe8CCVpgMEZSzeTd8NVMQZp1yHuSHEBoVyGY9b1E8x2PRYMY5cFm2sA==
X-Received: by 2002:a05:6602:82:: with SMTP id h2mr5993265iob.20.1616530619907;
        Tue, 23 Mar 2021 13:16:59 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id r5sm9700408ilb.75.2021.03.23.13.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 13:16:59 -0700 (PDT)
Received: (nullmailer pid 1244769 invoked by uid 1000);
        Tue, 23 Mar 2021 20:16:47 -0000
From:   Rob Herring <robh@kernel.org>
To:     Roger Lu <roger.lu@mediatek.com>
Cc:     HenryC Chen <HenryC.Chen@mediatek.com>,
        Fan Chen <fan.chen@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Stephen Boyd <sboyd@kernel.org>, YT Lee <yt.lee@mediatek.com>,
        Kevin Hilman <khilman@kernel.org>,
        Nicolas Boichat <drinkcat@google.com>,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Charles Yang <Charles.Yang@mediatek.com>,
        linux-kernel@vger.kernel.org,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Angus Lin <Angus.Lin@mediatek.com>, linux-pm@vger.kernel.org,
        Xiaoqing Liu <Xiaoqing.Liu@mediatek.com>
In-Reply-To: <20210323135657.2701-2-roger.lu@mediatek.com>
References: <20210323135657.2701-1-roger.lu@mediatek.com> <20210323135657.2701-2-roger.lu@mediatek.com>
Subject: Re: [PATCH v13 1/7] dt-bindings: soc: mediatek: add mtk svs dt-bindings
Date:   Tue, 23 Mar 2021 14:16:47 -0600
Message-Id: <1616530607.423782.1244768.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 23 Mar 2021 21:56:51 +0800, Roger Lu wrote:
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

See https://patchwork.ozlabs.org/patch/1457219

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

