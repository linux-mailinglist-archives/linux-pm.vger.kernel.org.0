Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE4CD7D5BD0
	for <lists+linux-pm@lfdr.de>; Tue, 24 Oct 2023 21:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344207AbjJXTty (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Oct 2023 15:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344305AbjJXTtx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 Oct 2023 15:49:53 -0400
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C8E8129;
        Tue, 24 Oct 2023 12:49:49 -0700 (PDT)
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-581fb6f53fcso2891841eaf.2;
        Tue, 24 Oct 2023 12:49:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698176989; x=1698781789;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=agKMir3qcuKi14ldHG71aEKuRkt+lScGsRzAjnaqW/E=;
        b=vF9xmLUxrZ5rPMx5sOUnehlSIul6bvhfnarpTXse7o6u5CXkoykX0ta43F1mHFb/lW
         IVUK9/0RdYFtZ2D3pwj5g007ksyGJ29nob9MOSN5Mo/muRM+UfK8QY5eM1IVJcuAXGjc
         nJklLRMp0gdyS1zloK4+xEua/D4ZpY7wcGNcIY3uOcU+MlndOMGrvTi1ElvjGznxEcvV
         Ba7UZtwB6ovNuD4D/BP5LWeMyXU3nC6F/m1hOi8YrvMubiC4rKEsES0BjcgSYFDVVguX
         v6L2jG467lV70QCXTr+BHGVQ8ZORYL0QqMNbDi8Q99MAODS2hQivRYF61flLQKZUIcGz
         qudA==
X-Gm-Message-State: AOJu0YyIQ0DbowtRm1kw1qaDKpR/Fediqt7GM4+nHPgSa9jb/BLpOiFb
        K9CZZ8W0D2spoGAjsyO28A==
X-Google-Smtp-Source: AGHT+IHyx9HB+5+xduv+DWRMK6EwebWorzR3T6o2xTNeFxgl5EwZIRIwryDhY3qLSLdiLQZ2wQLsaQ==
X-Received: by 2002:a4a:e0ca:0:b0:581:e303:807c with SMTP id e10-20020a4ae0ca000000b00581e303807cmr12970213oot.5.1698176988888;
        Tue, 24 Oct 2023 12:49:48 -0700 (PDT)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r134-20020a4a378c000000b00582014b0138sm2165972oor.39.2023.10.24.12.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 12:49:48 -0700 (PDT)
Received: (nullmailer pid 452036 invoked by uid 1000);
        Tue, 24 Oct 2023 19:49:46 -0000
Date:   Tue, 24 Oct 2023 14:49:46 -0500
From:   Rob Herring <robh@kernel.org>
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Marek Vasut <marex@denx.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux@ew.tq-group.com, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/5] dt-bindings: soc: imx93-media-blk-ctrl: Add LDB
 subnode into schema and example
Message-ID: <20231024194946.GA434797-robh@kernel.org>
References: <20231020130019.665853-1-alexander.stein@ew.tq-group.com>
 <20231020130019.665853-3-alexander.stein@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231020130019.665853-3-alexander.stein@ew.tq-group.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Oct 20, 2023 at 03:00:15PM +0200, Alexander Stein wrote:
> Document the LDB bridge subnode and add the subnode into the example.
> For the subnode to work, the block control must scan its subnodes and
> bind drivers to them, do not misuse either simple-bus or simple-mfd
> here.
> 
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
>  .../soc/imx/fsl,imx93-media-blk-ctrl.yaml     | 44 +++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/soc/imx/fsl,imx93-media-blk-ctrl.yaml b/Documentation/devicetree/bindings/soc/imx/fsl,imx93-media-blk-ctrl.yaml
> index b3554e7f9e76..5ba66dfb0e05 100644
> --- a/Documentation/devicetree/bindings/soc/imx/fsl,imx93-media-blk-ctrl.yaml
> +++ b/Documentation/devicetree/bindings/soc/imx/fsl,imx93-media-blk-ctrl.yaml
> @@ -24,6 +24,12 @@ properties:
>    reg:
>      maxItems: 1
>  
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 1
> +

Presumably the child nodes are MMIO? If so, missing 'ranges'.

>    '#power-domain-cells':
>      const: 1
>  
> @@ -46,9 +52,16 @@ properties:
>        - const: csi
>        - const: dsi
>  
> +  bridge@20:
> +    type: object
> +    $ref: /schemas/display/bridge/fsl,ldb.yaml#
> +    unevaluatedProperties: false

We do this style a lot, but another way to do child nodes is:

type: object
additionalProperties: true

properties:
  compatible:
    contains:
      const: fsl,imx93-ldb

This way avoids applying the fsl,ldb.yaml schema twice and ensures the 
right LDB compatible is used. 

Rob
