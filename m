Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC077C7195
	for <lists+linux-pm@lfdr.de>; Thu, 12 Oct 2023 17:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379455AbjJLPfA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Oct 2023 11:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378304AbjJLPe5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Oct 2023 11:34:57 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 189E1BE
        for <linux-pm@vger.kernel.org>; Thu, 12 Oct 2023 08:34:56 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40651a72807so11917865e9.1
        for <linux-pm@vger.kernel.org>; Thu, 12 Oct 2023 08:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697124894; x=1697729694; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AlYbARuGOvayK2I8gPmBtlTVphiwdBhXgzXNKnIpdgQ=;
        b=dLW1QH4GEbS/jBNDsbmYOlK/rKTpAsNIBuwxsxTRwtfus1bRVn42gzcGT/NXKTRcr7
         his/elYT+j9sk4RTtLsIxv76EOrp6T+wJnsPVnCmhsCznjOnP+CQLCOPKBwClGvSSi7d
         rLmUILReAbJ8dPushIZIb26vpaqX8StdpCOxquQ0r4qxim8ij5qu5sgBZ4iCYJPSbJud
         BrBcRa5DHU575qBGqPqlooRYEa3i8BNfwaYboe71JNMGyIDmdIEt6ntF+mjJW45uupYB
         XsKWGwWb1PAt0mSvz/STYgV7e7wj78zNMyCjUy9BSf/L1cx8v97RaKpwvWn4vmNWEYAO
         J2mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697124894; x=1697729694;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AlYbARuGOvayK2I8gPmBtlTVphiwdBhXgzXNKnIpdgQ=;
        b=lynXyoDkd5ZG2U4js94vlXeeP8+mj33pE6xMdFtgXujI5fChTSL55hGXRNWT6zwc3s
         6AH+YwkJHHZWkJQFqnTHTWpvnleXLtHJ1cPLzjgDy6zimZaLEHd50ZJcAF946N9K9nTe
         q8CEy6mwx7cyWi2nqcUGERbxyMN/53v9IynE7vROToYL6CRjio5P6PUwP11kvr0nXHaW
         1rObBkYwwGfxsEemfnGiVmFYn1TtLupXZKQH65npyeb0z1RdFtvvJP18swj02yKQUgK4
         at0zFBPD5RbY7OVfvGXI41JouZdlj2xAAizJZI8LgVQyuvgPsVoRa9rEM/4xzo6qEJO8
         4HvA==
X-Gm-Message-State: AOJu0Yw9upsS8j6rt7+EfSpw5Cs9Hq5NLIfzYtQStrQhw8qSXUoiRyoL
        a3TN0ivVG4aVqS8jAW2Lf2cc3w==
X-Google-Smtp-Source: AGHT+IGg2dDbelEwQ6AKXVaNt6xSv454CPd0Ugdfj//8oRMrxMj2ciXjjzeqOjOTyIL2fKUpCJJCrg==
X-Received: by 2002:a1c:7917:0:b0:405:3d27:70e8 with SMTP id l23-20020a1c7917000000b004053d2770e8mr20865780wme.36.1697124894284;
        Thu, 12 Oct 2023 08:34:54 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0? ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.googlemail.com with ESMTPSA id x3-20020a05600c21c300b004053a6b8c41sm135419wmj.12.2023.10.12.08.34.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Oct 2023 08:34:53 -0700 (PDT)
Message-ID: <c8cf0994-be7f-4ed0-9e9e-a2f81fd9709a@linaro.org>
Date:   Thu, 12 Oct 2023 17:34:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] imx6q related DT binding fixes
Content-Language: en-US
To:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20231012080033.2715241-1-alexander.stein@ew.tq-group.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20231012080033.2715241-1-alexander.stein@ew.tq-group.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12/10/2023 10:00, Alexander Stein wrote:
> Hi everyone,
> 
> while working on i.MX6Q based board (arch/arm/boot/dts/nxp/imx/imx6q-mba6a.dts)
> I noticed several warnings on dtbs_check.
> I'm also not sure whether thse patches warrent a Fixes tag, so I only added that
> for patch 3. All of these patches are independent and can be picked up
> individually.
> 
> Patches already merged:
> * 0268e1ae25949 ("dt-bindings: trivial-devices: Remove national,lm75")
> * 57db57ae15a97 ("dt-bindings: display: fsl,imx6-hdmi: Change to 'unevaluatedProperties: false'")
>    which deprecates v1 patch 3

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

