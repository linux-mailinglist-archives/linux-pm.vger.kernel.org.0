Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4F34FF47E
	for <lists+linux-pm@lfdr.de>; Wed, 13 Apr 2022 12:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbiDMKQZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 Apr 2022 06:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbiDMKQY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Apr 2022 06:16:24 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33181366BE
        for <linux-pm@vger.kernel.org>; Wed, 13 Apr 2022 03:14:03 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id d10so1827653edj.0
        for <linux-pm@vger.kernel.org>; Wed, 13 Apr 2022 03:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=KM2/Oxykwb40B2psH2Zv/NEbgXt2fafuFObl/aJ40QM=;
        b=fWnQcK32ZqxXXjcfkbqvHAra+7V/mtZV4RKNUSVcaKr7bmO1lPN5DTkwFAX5hIiTtt
         kEvrEhwvcF2C7Q8JU5BEfdchQbxeOHUwySpBc/U2JGzKQWinhxYeXmmmTDA9RYJVh/6B
         Fz1yzE5YhzdKiN+twf/BVtCMRDBZPhebV6dTUpqfZJMJTmd1eYNg0bGnDRudCOdn1biV
         tuevggsbOZ1ds7z7aYlJvKsNrUqx1pNkU77XthCU0NAxqOjgBv/F126I2q0qEHEfUieT
         AZ1AGkr3Vr8MQJuHHnTazueQmkJVi3G2iWnCI7sMp47NXcfN2maWDcA9oBDV5lCA7aie
         jXWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=KM2/Oxykwb40B2psH2Zv/NEbgXt2fafuFObl/aJ40QM=;
        b=ntX1x53ByAMAJnEkKNVWI8tPR8W3WR7Aols8fc4HVaBvhvIcZLre+ojPg4Ciepkbzk
         CNkK1J5rj86f/dv7ozzxV07DgHzke52Mn/cBn91jAYUxyOC2wYoBC+lfDhmWLu3wMVSJ
         dIGmHHiDKBqP4kICZaOayHw5iWKU+1NLQmhsSKcdQzKdXLZvaEnbQ7wx36k8Y8UmaZZC
         ys5iC4WwEfja0All9+wDGljmEDNH94AHM6ivPe25mcC1yUcVow4zlG0A1gMAPShNZ2xk
         37lDa7TibZeCWyBeVHVN1b5HjlqTcu6UJXP4alwC0ZHIU5ROOybsGu9x2LhPAZNi0QNR
         0i4Q==
X-Gm-Message-State: AOAM533Rab8o9/si9WqKLdDDTgH2ZeaSSWzMCHmcBRY7lQ6cpcGVMNBL
        evO3sDgzGIbwZkhJhOiIiQ6oHw==
X-Google-Smtp-Source: ABdhPJzMZSTwvezOHbC8IrfRqFfgaoayzTHSBlWSaknEHLjmk5Yl9y/FmPuza1XdV9MuAps/ELs9vw==
X-Received: by 2002:a05:6402:40cb:b0:419:42de:65b6 with SMTP id z11-20020a05640240cb00b0041942de65b6mr43148921edb.66.1649844841738;
        Wed, 13 Apr 2022 03:14:01 -0700 (PDT)
Received: from [192.168.0.203] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id jr16-20020a170906a99000b006e4c05e8919sm13914751ejb.35.2022.04.13.03.14.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Apr 2022 03:14:01 -0700 (PDT)
Message-ID: <87c8d5ea-49e5-a85f-161b-49d0f7f1c345@linaro.org>
Date:   Wed, 13 Apr 2022 12:14:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v5 2/4] arm64: dts: ti: j721e: Add VTM node
Content-Language: en-US
To:     Keerthy <j-keerthy@ti.com>, robh+dt@kernel.org,
        daniel.lezcano@linaro.org, rui.zhang@intel.com, amitk@kernel.org,
        kristo@kernel.org
Cc:     linux-pm@vger.kernel.org, vigneshr@ti.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220412101409.7980-1-j-keerthy@ti.com>
 <20220412101409.7980-3-j-keerthy@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220412101409.7980-3-j-keerthy@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12/04/2022 12:14, Keerthy wrote:
> VTM stands for Voltage Thermal Management
> 
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
>  .../boot/dts/ti/k3-j721e-mcu-wakeup.dtsi      |  9 +++
>  arch/arm64/boot/dts/ti/k3-j721e-thermal.dtsi  | 73 +++++++++++++++++++
>  arch/arm64/boot/dts/ti/k3-j721e.dtsi          |  4 +
>  3 files changed, 86 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/ti/k3-j721e-thermal.dtsi
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
> index b4972dfb7da8..6290f563b8e7 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
> @@ -418,4 +418,13 @@
>  		interrupt-names = "int0", "int1";
>  		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
>  	};
> +
> +	wkup_vtm0: wkup_vtm0@42040000 {

No, same comments as Rob gave you for bindings patch.

Please fix them in entire patchset, instead of ignoring.


Best regards,
Krzysztof
