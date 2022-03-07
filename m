Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 448F74D072D
	for <lists+linux-pm@lfdr.de>; Mon,  7 Mar 2022 20:04:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244917AbiCGTEy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Mar 2022 14:04:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244930AbiCGTEy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Mar 2022 14:04:54 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D2B16E545
        for <linux-pm@vger.kernel.org>; Mon,  7 Mar 2022 11:03:59 -0800 (PST)
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id F31CE3F600
        for <linux-pm@vger.kernel.org>; Mon,  7 Mar 2022 19:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646679837;
        bh=J4AWHeY6kJDoGGWSDU0TUvtoqIxvWQeYEQ4e5H5diOY=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=PrcFxoJ6T4Yxd5Rab2Ln5S2fje0tbX0vAu7TMaqbYXum5KUpuBUrmjXyxQ6Tx4cJ7
         ICIGsCnaASAS6Tn9qLu8hvlR5vd97gb28pbOUY0+U5RTVFrCDTsGeVLUi7SQkHTY7o
         u3JEVWUyYOH8BtJ/4fw7Vzhhgb/thyJsLSqGOiN/DkioqwemltpS5s/rA3BJo3z5aq
         Y2FKjT5+M/LdCvZeBIk6LY8WD7fVpJc0OD7Qhtxr2HUd2qnk4tb/pZRiEyExnpM5Zl
         f/KakqcABNSELxmSSNR9jhpMGLmSb6tbHXknTNTc7g7+xOw/E92HrLYWt5oNrn5tXL
         LcPdxoxCxzyzA==
Received: by mail-ed1-f72.google.com with SMTP id e10-20020a056402190a00b00410f20467abso9160560edz.14
        for <linux-pm@vger.kernel.org>; Mon, 07 Mar 2022 11:03:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=J4AWHeY6kJDoGGWSDU0TUvtoqIxvWQeYEQ4e5H5diOY=;
        b=N1Ccboh10Hm93o6ByFn7V4f2fPLz+FULC6cgWmWkZetMsJUb9u7nCCdffRCjLtMGuY
         P/BRmXCrSolDErEFXlEVhF+vjgrEzav1HMsJ4ROJTJIfgwTLr2jryzT1gqguwS99Fgw6
         8HxI7vqWEggULB5JCqNM4+zz7I5qrLzm7fD6KMD9BMOJgQr2VH5BpJiFdNTCd9y0RBgv
         GncVWgBl5udQOAHwRzQF9eai3+nbWD3+N7OlylSnHG9kNHPrM0n5wy0fM/NDHa8w2xol
         ct1e+mgGKR7T2TCeakV5rehG25Rb26esqeTHqhyCXN908PocQhPoglXrNNRAp2EMtaSf
         qI3w==
X-Gm-Message-State: AOAM532KFkcNk8iaHWegjQRCBX/4FSYxlIi36nvA+K2tpcdXZCk/eXLH
        8I3R3RpsixD0tvQRkWQ9u3gvN5QJW5FZ+PRIB7LJf2c/GGhbb2eXJC0In0wzCdSODLZ8jGql7Lg
        NOzYyDCCE6kwuKRiEAdZh0v73szfqS9W01GH4
X-Received: by 2002:a50:aa87:0:b0:40f:28a0:d0d6 with SMTP id q7-20020a50aa87000000b0040f28a0d0d6mr12475410edc.368.1646679837655;
        Mon, 07 Mar 2022 11:03:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxKC+brW6i/AxkVvgIwi5JIxVP90rh2B8pfzbYSF4MakKIPVSeOvoB5oYLiqCOs67+OJ+fNaA==
X-Received: by 2002:a50:aa87:0:b0:40f:28a0:d0d6 with SMTP id q7-20020a50aa87000000b0040f28a0d0d6mr12475384edc.368.1646679837477;
        Mon, 07 Mar 2022 11:03:57 -0800 (PST)
Received: from [192.168.0.143] (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id n15-20020a05640206cf00b0041655b577f1sm1268973edy.25.2022.03.07.11.03.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Mar 2022 11:03:56 -0800 (PST)
Message-ID: <a728aaa0-bde9-b9a9-971a-2e4b52f2b7bf@canonical.com>
Date:   Mon, 7 Mar 2022 20:03:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 4/4] cpufreq: mediatek: add platform data and clean up
 voltage tracking logic
Content-Language: en-US
To:     Tim Chang <jia-wei.chang@mediatek.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, fan.chen@mediatek.com,
        louis.yu@mediatek.com, roger.lu@mediatek.com,
        Allen-yy.Lin@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        hsinyi@google.com,
        Jia-Wei Chang <jia-wei.chang@mediatek.corp-partner.google.com>
References: <20220307122151.11666-1-jia-wei.chang@mediatek.com>
 <20220307122151.11666-5-jia-wei.chang@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220307122151.11666-5-jia-wei.chang@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 07/03/2022 13:21, Tim Chang wrote:
> 1. add required header files and remove unnecessary header files.
> 2. some soc needs different min/max voltage shift and voltage tracking
>    attributes. make these variables into platform data to support
>    future soc.
> 3. add need_voltage_tracking variable to platforma data. if true, it
>    indicates soc is required to realize the voltage tracking between
>    voltage of sram and voltage of cpu by software approach. otherwise,
>    the voltage tracking is realized by hardware approach.
> 4. add opp frequency look-up function as mtk_cpufreq_get() and
>    registered in cpufreq framework.
> 5. update voltage_tracking() logic and drv_init(). in drv_init(), it
>    always sets highest opp voltage before return. it could prevent from
>    high-freqeuncy-low-voltage issue if two or more clients using the
>    same regulator.

One change at a time.

> 
> Signed-off-by: Jia-Wei Chang <jia-wei.chang@mediatek.corp-partner.google.com>

Your SoB does not match from field.

Best regards,
Krzysztof
