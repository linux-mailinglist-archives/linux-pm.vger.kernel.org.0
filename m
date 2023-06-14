Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7B4373089E
	for <lists+linux-pm@lfdr.de>; Wed, 14 Jun 2023 21:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236505AbjFNTmj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 14 Jun 2023 15:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239454AbjFNTm0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 14 Jun 2023 15:42:26 -0400
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C77D2;
        Wed, 14 Jun 2023 12:42:25 -0700 (PDT)
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-777a4926555so1446739f.0;
        Wed, 14 Jun 2023 12:42:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686771745; x=1689363745;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CK1lIeMRpP5NX2IUbidGPA9x3NrhjZEIeLvXrWDUjZM=;
        b=DtsPxFW43+Tl2Tlyviss72c5Ok3gtaCpwjcDICpKN4QPQOdYj1rqqhcU/+S00RFYZ2
         2oXfft/Oj5JzpormVmY0LEZGm1WONRWK04isU1oDT5u3RUKzppAC6uqQV6J0a0F+MSRe
         9xjyd1uHJWm13bqcHxBtj5ORUUEN4ZiFDZRCeKYcinw8KMzbEUhOHhuSfEPmYwN0/b59
         HDamI2c5d3yj//d/HBUfuDBWZlQ9V4titky8xnHSTVn2gSMf0WvH+ZEUwSODWo3pjzYq
         R4PAvz6iY6ytec3se5mVySqVDwHkjEFeXvmZ4sE8BFwLrjIwELiCW2ZOJC33UnF0JP26
         /cYA==
X-Gm-Message-State: AC+VfDwrROiR3jPhFy80sxTm8C5OAbYOlkhIWXSOCMIltuU+eKPAnm5d
        vF13SRUjKjkO5QOQ2ahyOw==
X-Google-Smtp-Source: ACHHUZ521hIVcunxwMoTkCfDDcToYbL+0uuF815H+XwWvyB0+8/6FRb/VUUMTFteDscyxqdDVUq05g==
X-Received: by 2002:a05:6602:2110:b0:760:effd:c899 with SMTP id x16-20020a056602211000b00760effdc899mr2257746iox.5.1686771744976;
        Wed, 14 Jun 2023 12:42:24 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id e22-20020a6b7316000000b00777b835f2bdsm5634110ioh.27.2023.06.14.12.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 12:42:24 -0700 (PDT)
Received: (nullmailer pid 2620040 invoked by uid 1000);
        Wed, 14 Jun 2023 19:42:21 -0000
Date:   Wed, 14 Jun 2023 13:42:21 -0600
From:   Rob Herring <robh@kernel.org>
To:     Varshini Rajendran <varshini.rajendran@microchip.com>
Cc:     broonie@kernel.org, alexandre.belloni@bootlin.com,
        robh+dt@kernel.org, tglx@linutronix.de, devicetree@vger.kernel.org,
        Hari.PrasathGE@microchip.com, arnd@arndb.de, davem@davemloft.net,
        gregory.clement@bootlin.com, netdev@vger.kernel.org,
        edumazet@google.com, linux-arm-kernel@lists.infradead.org,
        balakrishnan.s@microchip.com, manikandan.m@microchip.com,
        nayabbasha.sayed@microchip.com, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org, gregkh@linuxfoundation.org,
        mturquette@baylibre.com, sre@kernel.org,
        claudiu.beznea@microchip.com, kuba@kernel.org,
        linux-usb@vger.kernel.org, cristian.birsan@microchip.com,
        pabeni@redhat.com, mihai.sain@microchip.com,
        linux-kernel@vger.kernel.org, sboyd@kernel.org,
        sudeep.holla@arm.com, durai.manickamkr@microchip.com,
        dharma.b@microchip.com, maz@kernel.org, linux@armlinux.org.uk,
        conor+dt@kernel.org, balamanikandan.gunasundar@microchip.com,
        nicolas.ferre@microchip.com, krzysztof.kozlowski+dt@linaro.org
Subject: Re: [PATCH 20/21] dt-bindings: net: cdns,macb: add documentation for
 sam9x7 ethernet interface
Message-ID: <168677174053.2619982.8000584271971799835.robh@kernel.org>
References: <20230603200243.243878-1-varshini.rajendran@microchip.com>
 <20230603200243.243878-21-varshini.rajendran@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230603200243.243878-21-varshini.rajendran@microchip.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On Sun, 04 Jun 2023 01:32:42 +0530, Varshini Rajendran wrote:
> Add documentation for sam9x7 ethernet interface
> 
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
> ---
>  Documentation/devicetree/bindings/net/cdns,macb.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

