Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76AD453A473
	for <lists+linux-pm@lfdr.de>; Wed,  1 Jun 2022 13:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351344AbiFAL4l (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Jun 2022 07:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233840AbiFAL4k (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Jun 2022 07:56:40 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C6226D965
        for <linux-pm@vger.kernel.org>; Wed,  1 Jun 2022 04:56:38 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id z7so1803737edm.13
        for <linux-pm@vger.kernel.org>; Wed, 01 Jun 2022 04:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=YaYk+jNlpnsP2SdoC1Ms7kfQnoUGnJ939oNIovBFnWI=;
        b=RVF5EM+oQMk9RmJlDSvOC3qin7I+XdS5Tm22VxdQppgNyi0Lze67Yob4Pb8r2qnqRA
         9yhk7UbxTMz0dqzyAw1RCsLK/e8XIeznMgXZy/mUZovy8KVDjJGttFxPm/jjrGeuWhJC
         6rqdDNQZ2LH311CUfm8rfn3acT+ujGaLQqX+u8Q9sQjMpG7xX7H9ru+Nf7Lhtj+GcKFe
         qOPgO9O3fSsGnzsYb+nec63t1hA+RN4CDctwv0E47Gq5G5SFuUmfvnfeYcZrJf2Oc8XO
         CTRcTHiMGJ5YQuvVekHLD15xViFK4iQDclWFoJsqAT0TCVVb+/IB4V38iVGl0kSZy5Ei
         ar9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=YaYk+jNlpnsP2SdoC1Ms7kfQnoUGnJ939oNIovBFnWI=;
        b=UAXZixs9+PpwC3K5p3znxVCCaDbkOEdShPZ+0xUQFG0USwyw95dKRBIcK9vh57mqQS
         ysTu5o/dAML6v+1Dk9c9nfL6hnSqaArxA1SSkPpm1KUtQ2VObnF73nMMAx6uwSneLkG6
         AqR/6Cejoi6rA++0OY5z74VaJvSzHMRGzse5QTOIkFmBrt8u+t3JbrsOw1ThN0WzPsyX
         chbeeQjK4/c2Z0AKaPcJRk1YqS7XjFH2Yu8cWiyExQWjrg7/X1g+Q04tx5eg5a3BFYgP
         bGit4scChIdn324dMmEQjU/xVhVzPBd7jllJNiRNrLwkJ+I6xJROH62k6A7EqM/usXmj
         ztYg==
X-Gm-Message-State: AOAM532vBTUsGYX+NRm/0baXZNA/wgJ4oq6kH8ltP0IgRUtSYgDDMG51
        mRJGX6S2xx4gbr1tAr5paPb7hQ==
X-Google-Smtp-Source: ABdhPJzAm/t5Eh+gxuP3n4cFhN4V0yA1zRNlg4rHowMMAV7QI5pRFmtiF9eVNiUYHPMqCyNZtN3bpA==
X-Received: by 2002:a05:6402:42d4:b0:416:5cac:a9a0 with SMTP id i20-20020a05640242d400b004165caca9a0mr69853210edc.86.1654084596665;
        Wed, 01 Jun 2022 04:56:36 -0700 (PDT)
Received: from [192.168.0.179] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id x9-20020a1709064a8900b006f3ef214e2csm653472eju.146.2022.06.01.04.56.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jun 2022 04:56:36 -0700 (PDT)
Message-ID: <06f13727-adf6-6a33-1648-f85a7941e1e4@linaro.org>
Date:   Wed, 1 Jun 2022 13:56:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 8/8] interconnect: imx: Add platform driver for imx8mp
Content-Language: en-US
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, djakov@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        abel.vesa@nxp.com, abailon@baylibre.com, l.stach@pengutronix.de,
        laurent.pinchart@ideasonboard.com, marex@denx.de,
        paul.elder@ideasonboard.com, Markus.Niebel@ew.tq-group.com,
        aford173@gmail.com
Cc:     kernel@pengutronix.de, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        Peng Fan <peng.fan@nxp.com>
References: <20220601094156.3388454-1-peng.fan@oss.nxp.com>
 <20220601094156.3388454-9-peng.fan@oss.nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220601094156.3388454-9-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 01/06/2022 11:41, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add a platform driver for the i.MX8MP SoC describing bus topology, based
> on internal documentation.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

> +
> +static struct platform_driver imx8mp_icc_driver = {
> +	.probe = imx8mp_icc_probe,
> +	.remove = imx8mp_icc_remove,
> +	.driver = {
> +		.name = "imx8mp-interconnect",

How do you match/bind the driver?

> +	},
> +};
> +
> +module_platform_driver(imx8mp_icc_driver);
> +MODULE_AUTHOR("Peng Fan <peng.fan@nxp.com>");
> +MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS("platform:imx8mp-interconnect");
> diff --git a/include/dt-bindings/interconnect/fsl,imx8mp.h b/include/dt-bindings/interconnect/fsl,imx8mp.h
> new file mode 100644

Bindings are separate patch.

> index 000000000000..732547577c76
> --- /dev/null
> +++ b/include/dt-bindings/interconnect/fsl,imx8mp.h
> @@ -0,0 +1,59 @@
> +/* SPDX-License-Identifier: GPL-2.0 */

Dual license.

> +/*
> + * Interconnect framework driver for i.MX SoC
> + *
> + * Copyright 2022 NXP
> + * Peng Fan <peng.fan@nxp.com>
> + */
> +



Best regards,
Krzysztof
