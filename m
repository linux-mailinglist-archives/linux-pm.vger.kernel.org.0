Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF8C4F085C
	for <lists+linux-pm@lfdr.de>; Sun,  3 Apr 2022 09:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346643AbiDCH6W (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 3 Apr 2022 03:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240580AbiDCH6W (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 3 Apr 2022 03:58:22 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 275BD377FF
        for <linux-pm@vger.kernel.org>; Sun,  3 Apr 2022 00:56:28 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id k2so346775edj.9
        for <linux-pm@vger.kernel.org>; Sun, 03 Apr 2022 00:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=i3fCaM44ai9Ho5+ESZukVkEPFkgIufFRH+KUn22jE48=;
        b=hGVybtUrDow3w4+aXDW5Inw9yqWEf6RZfy+hUPBhIJrK1JG/Q36mg+PSv7xCQZQdeg
         wx8VZmkvxwDay5fZA+lzSMxF4vQ/XaWCG/gkPbhwgBipIp/DzdXIN6zgOyp0k7kyrxi/
         a5x2Mrm2SsszctCbUzoCja9+r1SlHgJTi5ILQ2ZzjZjs0rio79m9dTEbeWbXBX5ZjtO6
         XbQNDac1U/rT3Oz+K9+gNJVq7yGmf8YCAUZ41TlQ/wueDBVbi+W+uGvCQXwdzHHlU+zP
         EQbhb3Vz4kpGO1yapURSIJjViUOYLV1EbDgFftGDlkEVjuVekxs+K+WmBBrFolgugui3
         pWVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=i3fCaM44ai9Ho5+ESZukVkEPFkgIufFRH+KUn22jE48=;
        b=aY0Ovfc/q6tRfj9P4YR2NQLQ7wYXR504jW2e5/VbYhrOzKHJ1zUkdNSQAH53yWOIXC
         gq+VNACFZsip6g5yEw9DMds/2W9ftI91rudeyhxRetH14Naf+6crO3sokovINnYzZ1gz
         AUzap+gBOJ1t1g4psvDKDzuuJ1AWF4HQkKZ0gOEqPGDUq6QUZ/5ARao/4c487GkXlJGc
         I5Pm8Ko6Gw28oSjLhoA2ayTv/LyXtP5b3L9aVlPd3z1NDuNy5J5vm5+mIECe6Z8olE2M
         x8nZyzTSrvcWCFnV1Ri07pMS2nmc9eZ9M5MuLSHfKl9nD00FQYfQfURZqo6xbe4zXrG8
         4ZbA==
X-Gm-Message-State: AOAM531+tSEPmOpYFSt5WEcHOZBSNP9XAK1wfckAtWuayK42yr4LvmcC
        Y/MwwYwNuBhF4i59qfDckyDzvA==
X-Google-Smtp-Source: ABdhPJzdy2udwHmdRbAFbbuf2ZcLAXsrnUeRk+iiT/GIIQUynNBEVmYR7RI8WMzEv22v4hzj0TxChg==
X-Received: by 2002:a50:fd94:0:b0:419:9ed:e870 with SMTP id o20-20020a50fd94000000b0041909ede870mr28389360edt.207.1648972586742;
        Sun, 03 Apr 2022 00:56:26 -0700 (PDT)
Received: from [192.168.0.171] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id ec10-20020a0564020d4a00b0041a68df1a71sm3432229edb.77.2022.04.03.00.56.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Apr 2022 00:56:26 -0700 (PDT)
Message-ID: <798f0244-95dd-cf2d-7bc5-02c72c7fa327@linaro.org>
Date:   Sun, 3 Apr 2022 09:56:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 6/6] dt-bindings: power: supply: qcom,smb2: add bindings
 for smb2 driver
Content-Language: en-US
To:     Kuldeep Singh <singh.kuldeep87k@gmail.com>,
        Caleb Connolly <caleb.connolly@linaro.org>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Amit Pundir <amit.pundir@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>
References: <20220401202643.877609-1-caleb.connolly@linaro.org>
 <20220401202643.877609-7-caleb.connolly@linaro.org>
 <20220403071426.GA49153@9a2d8922b8f1>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220403071426.GA49153@9a2d8922b8f1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 03/04/2022 09:14, Kuldeep Singh wrote:
> On Fri, Apr 01, 2022 at 09:26:43PM +0100, Caleb Connolly wrote:
>> Add devicetree bindings for the Qualcomm PMI8998/PM660 SMB2 charger
>> drivers.
>>

(...)

> 
>> +    pmic {
>> +      #address-cells = <1>;
>> +      #size-cells = <0>;
>> +      #interrupt-cells = <4>;
>> +
>> +      smb2@1000 {
>> +        compatible = "qcom,pmi8998-smb2";
>> +        reg = <0x1000>;
>> +
>> +        interrupts = <0x2 0x13 0x4 IRQ_TYPE_EDGE_BOTH>;
>> +        interrupt-names = "usb-plugin";
>> +
> 
> In-between new lines may not be required.
> And DTs use tabs instead of 2 spaces, we can follow that here also.

The DT examples in bindings use spaces. Either two (like YAML) or four
(for easier reading).

> 
>> +        io-channels = <&pmi8998_rradc 3>,
>> +                      <&pmi8998_rradc 4>;
>> +        io-channel-names = "usbin_i",
>> +                           "usbin_v";
> 
> Channel-names can be written in one line.

They match the format of io-channels, so this is quite readable.



Best regards,
Krzysztof
