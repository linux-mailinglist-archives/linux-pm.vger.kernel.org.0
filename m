Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3FAD580C57
	for <lists+linux-pm@lfdr.de>; Tue, 26 Jul 2022 09:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232048AbiGZHVw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 Jul 2022 03:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231951AbiGZHVv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 Jul 2022 03:21:51 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E2FBF68
        for <linux-pm@vger.kernel.org>; Tue, 26 Jul 2022 00:21:49 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id o12so15559615ljc.3
        for <linux-pm@vger.kernel.org>; Tue, 26 Jul 2022 00:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=BaHRyLExwhQJT5LoXWhyAV94oIh55w9luBR+4krs4UE=;
        b=IvRWCs+QRUbjysWNzcrXSCOLNDiVNIOzFM3qbLPrFROW6ff5JQQ3Y6fh6fWX/9xBAN
         P9GZnniPLle+tgVY9QCRN6g+97izf7kayF7CVc39++5MqmfER6vl4nkFdCH0Xp1X9A/X
         Np8igVpHxQGt/AWTPTI6oAoWJS6cBSk/z3WaNOT6cdfzJzC+iiAldLJlTOOrB959O7Vl
         /7rYfBgOTVGhx+uQi0FBSw6jRRriJYZXl6urd5fKzw8VnKeyYW/PsooBAVMr2C0sjdNu
         XLoYoQaNTK2HTLcyPqxVm7K0vNynn5I+nBtQ5sbAADgMQc2b+DAdSbQpQSswJZXYkTyJ
         SLcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=BaHRyLExwhQJT5LoXWhyAV94oIh55w9luBR+4krs4UE=;
        b=AuxR87D2QHs4dneIaHEo3JWUEPPfsuIT38pswzPMlDAJ/2IX7v2FGrlnQEQx/yzEfM
         GomZgNO5x81aovGW/dhNTHvCo2P+fvcT4w2BYbQJstTtL208QDcm5TMwebn9CrqMhOBi
         m4Q5erBk7UpHbVPhHnUEkQC4aDUfu1rmO6ljyN2pfCeLfJ1XSgaLDlKvRuqHI+yGzo2I
         F9NDzwyHck/+97KYhFFO9GzFtT/V8H9rI0vO6Yl46TQhVNhRVlQcxh2WiGjD96vtX4hq
         7CKGAJsJ8FlnnIJGmRBC5ues7wLg3RROaVOGq9v+asEinpp6EuCBNm+tldEfTlC0X5sq
         3s8w==
X-Gm-Message-State: AJIora+u9w6y79D+tKPrhiEcmQziFlygU7pom2De3jnvfkqeHTb0MDc1
        XrJ6WZfSiwOuAPs/EfaezoJTSKVmH30BfHbh
X-Google-Smtp-Source: AGRyM1uI68NeSyMBV7L10D0hiN3uZqFmqFNUzzXgBA5m7TamyyJaIsHnblRN0NsbOPTnr3qjKjVmXQ==
X-Received: by 2002:a2e:9797:0:b0:25d:e70d:a63e with SMTP id y23-20020a2e9797000000b0025de70da63emr5689874lji.248.1658820107619;
        Tue, 26 Jul 2022 00:21:47 -0700 (PDT)
Received: from [192.168.3.197] (78-26-46-173.network.trollfjord.no. [78.26.46.173])
        by smtp.gmail.com with ESMTPSA id u16-20020a2eb810000000b0025dff3737afsm1441063ljo.117.2022.07.26.00.21.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jul 2022 00:21:47 -0700 (PDT)
Message-ID: <2329cb6b-7385-c670-1601-b7a3827070df@linaro.org>
Date:   Tue, 26 Jul 2022 09:21:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 30/32] thermal/drivers/samsung: Switch to new of
 thermal API
Content-Language: en-US
To:     Daniel Lezcano <daniel.lezcano@linexp.org>,
        daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, khilman@baylibre.com,
        abailon@baylibre.com, lukasz.luba@arm.com, broonie@kernel.org,
        damien.lemoal@opensource.wdc.com, heiko@sntech.de,
        hayashi.kunihiko@socionext.com, mhiramat@kernel.org,
        talel@amazon.com, thierry.reding@gmail.com, digetx@gmail.com,
        jonathanh@nvidia.com, anarsoul@gmail.com, tiny.windzz@gmail.com,
        baolin.wang7@gmail.com, f.fainelli@gmail.com,
        bjorn.andersson@linaro.org, mcoquelin.stm32@gmail.com,
        glaroque@baylibre.com, miquel.raynal@bootlin.com,
        shawnguo@kernel.org, niklas.soderlund@ragnatech.se,
        matthias.bgg@gmail.com, j-keerthy@ti.com,
        Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
        Amit Kucheria <amitk@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "open list:SAMSUNG THERMAL DRIVER" 
        <linux-samsung-soc@vger.kernel.org>,
        "moderated list:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES" 
        <linux-arm-kernel@lists.infradead.org>
References: <20220725212637.2818207-1-daniel.lezcano@linexp.org>
 <20220725212637.2818207-31-daniel.lezcano@linexp.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220725212637.2818207-31-daniel.lezcano@linexp.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 25/07/2022 23:26, Daniel Lezcano wrote:
> The thermal OF code has a new API allowing to migrate the OF
> initialization to a simpler approach. The ops are no longer device
> tree specific and are the generic ones provided by the core code.
> 
> Convert the ops to the thermal_zone_device_ops format and use the new
> API to register the thermal zone with these generic ops.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
> ---
>  drivers/thermal/samsung/exynos_tmu.c | 24 ++++++++++--------------


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
