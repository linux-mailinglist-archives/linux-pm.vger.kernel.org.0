Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACF896942D1
	for <lists+linux-pm@lfdr.de>; Mon, 13 Feb 2023 11:27:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbjBMK1N (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Feb 2023 05:27:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231316AbjBMK1K (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Feb 2023 05:27:10 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2A057ABE
        for <linux-pm@vger.kernel.org>; Mon, 13 Feb 2023 02:27:07 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id f23-20020a05600c491700b003dff4480a17so8083971wmp.1
        for <linux-pm@vger.kernel.org>; Mon, 13 Feb 2023 02:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Aj2Wj0j0p+0jN/Sd+98R01gUFlTgQHfDWnlZMgHgkcE=;
        b=Wo3bV+cZZ05yYZ0f95sJyhFYnLDCCd9XzFsJRJVouWNXEqSA6v1HiiF0WSlo6KJThM
         12/qjoZsG84VIfFmTQxD4raWAH/k13Mc9B5fcKJJDKs1rOE7lDAErLnESAqzOHOp9S96
         uuOW+MXhYrbt0xHR6uqgITJ3UlqnbU2vD79WhfPlIzSkqL1704HLoiM8x1LBWHbGS5YC
         Fyx89TDBrgJ7L8c4RgI3jEEUKdO34ZM+hqCZlvHK0Cl9psp4lxdyxIrC/59rqIqwQJw2
         5OUs/+KyxCzRc6xkJ8FPK1pxo4BW9n0Yykph/ghUwB0n+ObmITn/Z3qJMWkXymgOkoAx
         ZOhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Aj2Wj0j0p+0jN/Sd+98R01gUFlTgQHfDWnlZMgHgkcE=;
        b=neV8L4TcHx3NlBhufotwMnP0/IzY7HdcIHEbLDoujsJ0BK/ZSNVWRoTcZPSJuss8OP
         CH9WGi82+D6X9weeSVQIk+MLIdUB0x9w0DalMcSP+ajw+1tRGXS4dXkoPtfQmgd8YD+7
         l47T4/pT/QYztITiKVSbFVclUJPkBKOj6bdM19owLSr7dnY1rWB50vUFdLvrxWbtvWEp
         M7COM/9cNudKL48/ijG5GZE6Cfg38/3pwVBvThEO/tPrvOm3WisB8geJvw6ClJorRBan
         z9rbiEy3MMCuVi4vvgg0Ch9WH8EvgJj0jFRAzGAlVIaeFBfOEXQ/qyyoWlLtkuL5xw7d
         +dsA==
X-Gm-Message-State: AO0yUKXun4GhIL2Y+bvssl2UArgwJ362ULxCGft7zwFYRiWOF3SvY1po
        SstN3YeUkBftCL+Gayn/tCAvaA==
X-Google-Smtp-Source: AK7set+vhslzhSgf6yXlaDZ9sUaYyztU+0/ztHVTUdV+nGDyWPReO5kY6mXNcQoh+7S5T5gzw3f85g==
X-Received: by 2002:a05:600c:43c4:b0:3dc:5302:ad9 with SMTP id f4-20020a05600c43c400b003dc53020ad9mr22861616wmn.27.1676284026324;
        Mon, 13 Feb 2023 02:27:06 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id az10-20020a05600c600a00b003dc3f07c876sm17088598wmb.46.2023.02.13.02.27.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 02:27:05 -0800 (PST)
Message-ID: <a1c01c36-9519-dba8-7a4b-59b650566781@linaro.org>
Date:   Mon, 13 Feb 2023 11:27:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v6 1/3] dt-bindings: cpufreq: qcom-cpufreq-nvmem: specify
 supported opp tables
Content-Language: en-US
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Christian Marangi <ansuelsmth@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230208153913.24436-1-ansuelsmth@gmail.com>
 <20230213050430.n3wszmi5kslvhdtl@vireshk-i7>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230213050430.n3wszmi5kslvhdtl@vireshk-i7>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 13/02/2023 06:04, Viresh Kumar wrote:
> On 08-02-23, 16:39, Christian Marangi wrote:
>> Add additional info on what opp tables the defined devices in this schema
>> supports (operating-points-v2-kryo-cpu and operating-points-v2-qcom-level)
>> and reference them.
>>
>> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
>> ---
>> Changes v6:
>> - No change
>> Changes v5:
>> - Swap patch 1 and patch 2 to fix dt_check_warning on single
>>   patch bisecting 
>> Changes v4:
>> - Add patch split from patch 1
> 
> Rob / Krzysztof,
> 
> I am looking to apply this patchset for next release if it is ready, are you
> comfortable giving your Acks for the entire series yet ?

Look ok for me.

Best regards,
Krzysztof

