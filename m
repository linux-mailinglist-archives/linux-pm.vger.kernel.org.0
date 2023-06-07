Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C462A726986
	for <lists+linux-pm@lfdr.de>; Wed,  7 Jun 2023 21:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232650AbjFGTKY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Jun 2023 15:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbjFGTKX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Jun 2023 15:10:23 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5CCD8E
        for <linux-pm@vger.kernel.org>; Wed,  7 Jun 2023 12:10:21 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f7368126a6so36262305e9.0
        for <linux-pm@vger.kernel.org>; Wed, 07 Jun 2023 12:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686165020; x=1688757020;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VFeShRA+Q6MS4Ek7wrmqu5wkSlrfRx+GR/9GaQRXmkc=;
        b=kdRjS7QkftlEs2gNCywQCzAIY2DE7VuHmhIS9URwDm20q6NGx+XDjhkb47Aeyp/qbB
         IdfdwT0mrfZhKGrS5MnbYShxFoL7wRG5D2cpKcCY/bleVHs/Kcip+Cnx/K4q/SyYgQZ/
         B70ReBFlN4elHlR+m6eTqfKnjFRV9n8bBW/Ur0wLDBU4Kn4tCkDKdXF0nTbcKc56bAj2
         shl4+DfFY8GuvCiapiwST0DPXcMtLYfw52dkTf4+pEEt7InleS7L2duPt7WfYNuK01UX
         3l3ckyPy59gjkYXUz5X1fMRPC7WRTaVZjokbdeEL2/nlJI/GCba/bA+h9yXoRhqo/r+z
         2r/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686165020; x=1688757020;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VFeShRA+Q6MS4Ek7wrmqu5wkSlrfRx+GR/9GaQRXmkc=;
        b=Ytuwj2qgzTN6x5FnGnV7OjeUf8FM7+Ahdr04vOdSyglyEsqRlwGrZwpVFVkiAGTKLO
         wTO5xiE/ZLTSbxgUrgoFsrufgyeJtBLl4gR1r5Tb4bEX1BMSEHky9k+LfXr2XeN8TJli
         3Ov/RtVO+GeK9IjR2FRCYaZXD6KAq2YYx0A0z4DyfORiwiVLclTZfcekodZbw/55G3Jx
         MM60rpLrD553nE66TzfYIhH950I3oc55zhM7iUJl8Jh4VECT6gXYvzo70bYCkWFsu3v7
         EdSyUk/pYt3TaxuKi/f4zHSmEgSdU4PXa1zMcGIJYAM9UvOjNulHjwhkkNjctOkXhbqH
         nlZw==
X-Gm-Message-State: AC+VfDy7yVMRpOCGT/i4hHCSltdmjP82WMR67AR6MyswjQNOpyj9Bb5b
        P407fjBgqgXAQgnan/3yMwpypEZnj2PVq8dnBkA=
X-Google-Smtp-Source: ACHHUZ6bg692mXS/KEoB17CJEgvXvyhDx0YLPnm4+gHv4fC9Ycdu8cTyHV10BHVxNOhbERj547inkg==
X-Received: by 2002:a05:600c:287:b0:3f6:f7c:b3fa with SMTP id 7-20020a05600c028700b003f60f7cb3famr5372333wmk.31.1686165020277;
        Wed, 07 Jun 2023 12:10:20 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:3a59:921c:4758:7db5? ([2a05:6e02:1041:c10:3a59:921c:4758:7db5])
        by smtp.googlemail.com with ESMTPSA id n2-20020a05600c294200b003f7ba52eeccsm3039016wmd.7.2023.06.07.12.10.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 12:10:19 -0700 (PDT)
Message-ID: <507b5daa-73e7-8d21-4f73-c56f88c6bf77@linaro.org>
Date:   Wed, 7 Jun 2023 21:10:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 2/3] thermal: qoriq_thermal: only enable supported sensors
Content-Language: en-US
To:     Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
        Peng Fan <peng.fan@nxp.com>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
Cc:     "amitk@kernel.org" <amitk@kernel.org>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Alice Guo <alice.guo@nxp.com>
References: <20230516083746.63436-1-peng.fan@oss.nxp.com>
 <21914890.EfDdHjke4D@pliszka>
 <3120c2d5-4473-5b72-29bf-d841e806878f@linaro.org>
 <1966575.usQuhbGJ8B@pliszka>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <1966575.usQuhbGJ8B@pliszka>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 07/06/2023 19:42, Sebastian Krzyszkowiak wrote:

[ ... ]

>> Hence, the thermal_zone_device_register_with_trips() is not called, the
>> thermal zone is not created neither updated.
> 
> Again - that's not the case the check is there for. It's there for zones that
> do exist and that do get registered, because REGS_TMR only gets set *after*
> all the zones are already registered (the driver as it is right now does not
> know which sites it should enable before registering the zones). Because of
> that, the first value a zone gets after being registered is always bogus,
> because no monitoring site has been enabled yet at all.

Ok, I misunderstood. I thought that was for failing registered thermal zone.

Would enabling the site in ops->change_mode do the trick ?







-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

