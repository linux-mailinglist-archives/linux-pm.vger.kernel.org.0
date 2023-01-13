Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8982F669427
	for <lists+linux-pm@lfdr.de>; Fri, 13 Jan 2023 11:32:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240048AbjAMKc3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 13 Jan 2023 05:32:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237529AbjAMKc2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 13 Jan 2023 05:32:28 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C941903E
        for <linux-pm@vger.kernel.org>; Fri, 13 Jan 2023 02:32:26 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id z8-20020a05600c220800b003d33b0bda11so714854wml.0
        for <linux-pm@vger.kernel.org>; Fri, 13 Jan 2023 02:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E1J8TfKxAjLsngCXA1LT3+4bWkI4/Q+xp3QooUAGOuk=;
        b=T4M1NdyXaxR6388FMBG02ClrQy9ReLVGnEOYWVJIk9mFSiMWC9/9wjBVKyYbfGtk7J
         T5F+B4J8lrhlxI7yX9zsjYRsP7BA90+JZyIeHMiXj56IOHopFisR6Hd+dw971jDcrAoB
         BfveftaiyHVE6kaaZ4qSyYIJvjxcT9txx1lm0CYx8LmcAubWQVMellpPEijh+4H+HjIT
         wqnD2RPzMM/NDwZiJqNCg7ZOX86VoEL7a10TUWY8I3wz23iI66LXjtA+FAr1f/GWBbWI
         KZvD9uoAbAMOhgftRnf35pUmbVOxWMld38FKYD+vKmFlIWfM24e9aaGjxZeMUnikQZ5B
         ZuGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E1J8TfKxAjLsngCXA1LT3+4bWkI4/Q+xp3QooUAGOuk=;
        b=7WaQR02lwItj8cHdFw7ziGAwnuIJCmZ9EBbZ53ABqnERhlYLJygSdCzmJLszajUjCb
         JC7Me1ZQ5a/WQwZ0oMchqXE6Z5028JvmDSf4vmPMu0u6bbUQpkzUPjK142xOs3aWwhO9
         5qtbHPbTGQOKiArzc0BTFBHIDwqBGl9CtCXcqbBnebm2NRsCTKEbygD4eQd8IMYsTkwH
         e5rt0TuISGYp58aaodDXZeyq9TT38rtBMdke/22Rc1vv67aTE87ZAjLoE88HZZZBbB+S
         UVyE2Pn1aDG/0jDguKG9Q1jlaThuBU4rTOP1scpKRI5JDY7//CGr9E4CI9Wd0FkbuyfT
         4abQ==
X-Gm-Message-State: AFqh2kr8c79ksvBd8qslH8nWur987+86pFXJpmuF47JTaI2vNA47oOio
        Cwj6Thvg/+2RzDoS1c0kKa+xQg==
X-Google-Smtp-Source: AMrXdXvc19MzVMs/4VLbtrwXz6shnUPJHbn4ZA0zMjQfi5xsmL+BiV4BaWO8N3Qp0oyFEHAeChVyqw==
X-Received: by 2002:a05:600c:1d97:b0:3da:268c:32e0 with SMTP id p23-20020a05600c1d9700b003da268c32e0mr396142wms.21.1673605945081;
        Fri, 13 Jan 2023 02:32:25 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id o19-20020a05600c339300b003cff309807esm27048167wmp.23.2023.01.13.02.32.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Jan 2023 02:32:24 -0800 (PST)
Message-ID: <ad21be61-98e3-2a47-cc0c-108839531bfd@linaro.org>
Date:   Fri, 13 Jan 2023 11:32:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v6 00/20] thermal/drivers/tsens: specify nvmem cells in DT
 rather than parsing them manually
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230101194034.831222-1-dmitry.baryshkov@linaro.org>
 <cdebb6a9-0bc3-70ef-53ef-4a48ead869da@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <cdebb6a9-0bc3-70ef-53ef-4a48ead869da@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 13/01/2023 07:29, Dmitry Baryshkov wrote:
> On 01/01/2023 21:40, Dmitry Baryshkov wrote:
>> Historically the tsens driver fetches the calibration data as a blob and
>> then parses the blob on its own. This results in semi-duplicated code
>> spreading over the platform-specific functions.
>>
>> This patch series changes tsens calibration code to per-value nvmem
>> cells rather than parsing the blob in the driver. For backwards
>> compatibility the old code is left in place for msm8916, msm8974 and
>> qcs404, the platforms which have in-tree DT files. For all other
>> affected platforms the old parsing code has been dropped as a part of
>> this series.
> 
> Amit, Thara. This has been lingering for quite some time whout any 
> attention from your side. Could you please review the patchseries? Thank 
> you!

I think this series has been long enough on the mailing list.

I've applied patches 1 -> 14

Thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

