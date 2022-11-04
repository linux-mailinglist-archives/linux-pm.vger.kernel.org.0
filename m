Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCC6361A3B5
	for <lists+linux-pm@lfdr.de>; Fri,  4 Nov 2022 22:55:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbiKDVzJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 4 Nov 2022 17:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiKDVzI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 4 Nov 2022 17:55:08 -0400
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF59F2EF3D;
        Fri,  4 Nov 2022 14:55:07 -0700 (PDT)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-13c2cfd1126so6947723fac.10;
        Fri, 04 Nov 2022 14:55:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CZrbtISsCz00SpEOHgwZ2UbkTDqmb1drrY7PtcL5sr0=;
        b=ZYU6y3poRdhsyL9j8w855Xr9siK1ZFOcdwT2KA2rotcjcNxpdaBpMnFYDJt4j83GZz
         usC+egdrQaPKORasvmw1VBf5/KNgs9tL2LT7aK3xHn/h+MDUCtSbpUCYC4Ai1P8fl6Ur
         GKzOn5cPhJCz4Ajhlbuud6cm8Y6/gXTBXv+n3A2lgSN7ItNRiY2svIzVA8Z0bMXq6XZ5
         qwXssLhQPFG3RUFCvA40EROWmqFWbHRHC0Q7j54sykjqI4b4KrgWxM47mtG98gIDK6OH
         DGGmHCMTnmS4LH7CQnAvQznNh5x59r/H8kGPcqJBZ+ZjktRuZ4IMe2HgD0agj9bIK+vC
         pNww==
X-Gm-Message-State: ACrzQf0pq5IloZwUZj8kb5KabDDqGjF8yLycd8pWaryLe54BYDEzX+iD
        kSHcJuJCBiFLQm5YRrIdiD+4YZq3jA==
X-Google-Smtp-Source: AMsMyM5pwgKhywf/EVEkq6WDT9xsbjQN+o21g/IM5FhvKXdgBnakoCZWaurP/ipF+q6FUlZtwKUj5w==
X-Received: by 2002:a05:6870:338c:b0:13a:f214:ff51 with SMTP id w12-20020a056870338c00b0013af214ff51mr22580177oae.123.1667598907483;
        Fri, 04 Nov 2022 14:55:07 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id o65-20020aca4144000000b0035028730c90sm124549oia.1.2022.11.04.14.55.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 14:55:07 -0700 (PDT)
Received: (nullmailer pid 2894811 invoked by uid 1000);
        Fri, 04 Nov 2022 21:55:08 -0000
Date:   Fri, 4 Nov 2022 16:55:08 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Chunyan Zhang <zhang.lyra@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        Chris Zhong <zyw@rock-chips.com>,
        Zhang Qing <zhangqing@rock-chips.com>,
        devicetree@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Andrew F. Davis" <afd@ti.com>,
        Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
        Orson Zhai <orsonzhai@gmail.com>, Lee Jones <lee@kernel.org>,
        Markus Laine <markus.laine@fi.rohmeurope.com>,
        Artur Rojek <contact@artur-rojek.eu>,
        Dmitry Osipenko <digetx@gmail.com>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mikko Mutanen <mikko.mutanen@fi.rohmeurope.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Purism Kernel Team <kernel@puri.sm>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH v2 3/3] dt-bindings: power: supply: maxim,max17042: allow
 power-supplies
Message-ID: <166759890804.2894757.9957388407173837405.robh@kernel.org>
References: <20221102184501.109148-1-krzysztof.kozlowski@linaro.org>
 <20221102184501.109148-3-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221102184501.109148-3-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On Wed, 02 Nov 2022 14:45:01 -0400, Krzysztof Kozlowski wrote:
> MAX17042 Fuel Gauge uses power-supplies supplies:
> 
>   arch/arm64/boot/dts/freescale/imx8mq-librem5-r2.dtb: fuel-gauge@36: 'power-supplies' does not match any of the regexes: 'pinctrl-[0-9]+'
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changes since v1:
> 1. New patch
> ---
>  .../devicetree/bindings/power/supply/maxim,max17042.yaml        | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
