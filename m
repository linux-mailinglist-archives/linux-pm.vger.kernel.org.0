Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DBA3560FE3
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jun 2022 06:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbiF3EGH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 Jun 2022 00:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbiF3EGG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 Jun 2022 00:06:06 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7CEB3917A
        for <linux-pm@vger.kernel.org>; Wed, 29 Jun 2022 21:06:02 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id i1so20815204wrb.11
        for <linux-pm@vger.kernel.org>; Wed, 29 Jun 2022 21:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=r6t8QCIKP5jt4cj4r8j6WBXPO9YRMWQ4z6gQajB6+e0=;
        b=SIPa1zC27MlgWWPQjbAYTQRt/UfXTG4UqcQBwu89oJT5liWM329yZNp8YCb866ncMN
         bbLR3vErtoHoAOrT/VjfHKuVhoU2eKemSq93EffzmghnRmaC8VdbJuRMsXQwYtE5oADS
         zXecg+/z5kbQ2AVyDBBlBEPTFf7mNntX6I3C789RH41ytAocDrDTbCqJJj68YWxkeUBl
         ekAATFd1VKX5JDDwdnjl6w5SV1zj1QDqft08TB7d7P8gpA1mvGIIttvmaf078Ynj3Zwe
         ejyFjPyzZbuX+ZLSieV0djX6LyhiXHfXHOmbqlFOqBjQKXDNxqo8ugelZ8dQTiFEPLq1
         pYgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=r6t8QCIKP5jt4cj4r8j6WBXPO9YRMWQ4z6gQajB6+e0=;
        b=EbSu2M3EhMDejgKuL1MbrRDqdvW8i8KD0wuh9iR9pNoQmdGWd3aBMGPmO+VRsf65mJ
         d6Tw+fwfhADgkWcuO7F1M2fMiyFe9GQmMwrH3QGR4uruz33qcZn2cuB3fEd6wEbz2PFB
         BR1YoJYGiU2awSrJCaCYIWaf/Qooguz8xNpQQ5AvA0HKY2qag6/ZqHNptaXjnkc88pys
         do4NI962BsCZYr/18N5wxNSQ1FwHbQ6QsQ+JYb1KqMv5CJYSbD3BZSC796nLjNyBFlcK
         2p4PGyKaZvSSf5PKcE0/qv9s2xdyRrJiGSXAk/0be9crgu/5P6vb7PUrYPPDC/8FrRMJ
         IO4g==
X-Gm-Message-State: AJIora8PcMp5tSheasw4Dtse4DJhhWse8UAwYpP/qrZUIxoDTp3FrN0D
        fdFfqGwXcRvvjQV7RuJQbYSrxQ==
X-Google-Smtp-Source: AGRyM1uWvZbFTEOcOC6vcslMnpf8WygfEJOZFzS1FuIcaA1osdMMQ/4eOhBAucyNXwGbUMVfiDO1oQ==
X-Received: by 2002:a05:6000:1b86:b0:21d:21d2:3e12 with SMTP id r6-20020a0560001b8600b0021d21d23e12mr6288045wru.515.1656561960934;
        Wed, 29 Jun 2022 21:06:00 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id ba15-20020a0560001c0f00b0021bae66362esm15221348wrb.58.2022.06.29.21.05.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jun 2022 21:06:00 -0700 (PDT)
Message-ID: <024088fd-1511-7423-55fb-ebcd47a5a6c2@linaro.org>
Date:   Thu, 30 Jun 2022 05:05:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [RESEND PATCH 4/5] cpufreq: qcom-cpufreq-nvmem: Rename qcs404
 data to cpr_genpd
Content-Language: en-US
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     ilia.lin@kernel.org, agross@kernel.org, bjorn.andersson@linaro.org,
        rafael@kernel.org, viresh.kumar@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20220629130303.3288306-1-bryan.odonoghue@linaro.org>
 <20220629130303.3288306-5-bryan.odonoghue@linaro.org>
 <Yryj1Nv/Yu8wShzo@gerhold.net>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <Yryj1Nv/Yu8wShzo@gerhold.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 29/06/2022 20:11, Stephan Gerhold wrote:
> On Wed, Jun 29, 2022 at 02:03:02PM +0100, Bryan O'Donoghue wrote:
>> At the moment the CPR genpd based code is named after the qcs404 however
>> msm8936, msm8939 and other antecedent processors of the qcs404 can also
>> make use of this data.
>>
>> Rename it to reflect a more generic use.
>>
>> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> 
> There is another power domain that needs to be scaled together with the
> CPU frequency on MSM8916 and MSM8939: (VDD)MX. How do you handle that?
> 

Short answer, in another series to enable CPR on 5.x

We have code for CPR in a 4.19 tree that works but, it needs more work 
to be upstream-fit on 5.x.

CPR is deliberately omitted here to be submitted later.

In this series I'm just switching away from the default 
cpufreq-dt-platdev which breaks booting to qcom-cpufreq-nvmem.

Fair enough ?

---
bod
