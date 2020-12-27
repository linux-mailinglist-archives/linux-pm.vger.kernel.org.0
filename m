Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC9C2E31FE
	for <lists+linux-pm@lfdr.de>; Sun, 27 Dec 2020 17:57:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbgL0Q5Y (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 27 Dec 2020 11:57:24 -0500
Received: from mail-ot1-f43.google.com ([209.85.210.43]:36027 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbgL0Q5X (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 27 Dec 2020 11:57:23 -0500
Received: by mail-ot1-f43.google.com with SMTP id d20so7393252otl.3;
        Sun, 27 Dec 2020 08:57:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=TObSc2rN2u01if4JX76VdLUyjWOAUXL7fU5P8PBtpkM=;
        b=g5jQBoqD+PalW/6iUwd12NegR4Wf/bn5PWfxRue1ExYzHlP45ItpqZ8MtfL5RbRV9a
         /UKtgU8tmkFC0b6ba2bJl/XAR7y72FCdYXIXow2YGbHQ2SBqUlN6RJNat0CahRbHBvBq
         0gkRkBvkNd6ygmRFEVEnsC+RmOCanXbKn2nsXUUFulNuhrJ0F8lLQhsqDRmOLNdFtWxo
         szqJnopzC0vq+K1D77zz9vI2831FZr0/3HEZgA3TT4URJlIOagvdGLa+Sa3rtiaXDiW+
         k+9JFvFXPuadTBjY57EiMPaPZ+vgx3joNpiNWQRsBI4f1xhUlTf7MpVP54WwYPQD7HU/
         gmTw==
X-Gm-Message-State: AOAM532I8sAcuGRFLMjUynx7Nh5z5hE6LYdvH1f9Y8l5IOULdFJaT0gi
        9LoW6HFQjLueeO/NAwDwRw==
X-Google-Smtp-Source: ABdhPJzI+JDdO/V+OlTYv1dpS5qIypw11v1uqG0HcyZZgUUJzAQL9TRwlx44+N9mra2kD+OYyuT5Vw==
X-Received: by 2002:a05:6830:214c:: with SMTP id r12mr30777477otd.208.1609088202417;
        Sun, 27 Dec 2020 08:56:42 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id o135sm8531474ooo.38.2020.12.27.08.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Dec 2020 08:56:41 -0800 (PST)
Received: (nullmailer pid 1338176 invoked by uid 1000);
        Sun, 27 Dec 2020 16:56:21 -0000
From:   Rob Herring <robh@kernel.org>
To:     Roger Lu <roger.lu@mediatek.com>
Cc:     linux-mediatek@lists.infradead.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Xiaoqing Liu <Xiaoqing.Liu@mediatek.com>,
        YT Lee <yt.lee@mediatek.com>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        HenryC Chen <HenryC.Chen@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kevin Hilman <khilman@kernel.org>,
        Nicolas Boichat <drinkcat@google.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        Angus Lin <Angus.Lin@mediatek.com>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        Charles Yang <Charles.Yang@mediatek.com>,
        Fan Chen <fan.chen@mediatek.com>, Nishanth Menon <nm@ti.com>,
        Mark Rutland <mark.rutland@arm.com>
In-Reply-To: <20201227105449.11452-2-roger.lu@mediatek.com>
References: <20201227105449.11452-1-roger.lu@mediatek.com> <20201227105449.11452-2-roger.lu@mediatek.com>
Subject: Re: [PATCH v10 1/7] [v10, 1/7]: dt-bindings: soc: mediatek: add mtk svs dt-bindings
Date:   Sun, 27 Dec 2020 09:56:21 -0700
Message-Id: <1609088181.501243.1338175.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, 27 Dec 2020 18:54:43 +0800, Roger Lu wrote:
> Document the binding for enabling mtk svs on MediaTek SoC.
> 
> Signed-off-by: Roger Lu <roger.lu@mediatek.com>
> ---
>  .../bindings/soc/mediatek/mtk-svs.yaml        | 75 +++++++++++++++++++
>  1 file changed, 75 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/mediatek/mtk-svs.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/soc/mediatek/mtk-svs.example.dt.yaml: example-0: svs@1100b000:reg:0: [0, 285257728, 0, 4096] is too long
	From schema: /usr/local/lib/python3.8/dist-packages/dtschema/schemas/reg.yaml

See https://patchwork.ozlabs.org/patch/1420728

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

