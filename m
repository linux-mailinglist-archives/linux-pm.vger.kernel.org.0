Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F7D06B5D53
	for <lists+linux-pm@lfdr.de>; Sat, 11 Mar 2023 16:26:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjCKP0L (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 11 Mar 2023 10:26:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230418AbjCKP0K (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 11 Mar 2023 10:26:10 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C54D9DBB5A
        for <linux-pm@vger.kernel.org>; Sat, 11 Mar 2023 07:26:03 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id b10so8412788ljr.0
        for <linux-pm@vger.kernel.org>; Sat, 11 Mar 2023 07:26:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678548362;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1ocLrxz9PNmL7rxcHP9+sMO7kezIoSNjbehDL14u8SU=;
        b=TzU6eWA4meVSyp256D93bSUZ3gTytwUcoofo8swWobouTfAwodXIB4sjeDgT48Tusw
         ivU86pQx0LtA/JGdGgs3AhmifyQiPEXig0KIvezyGRYnc106eI35bhXqPihLuJB04ZWE
         /Pa0IbEv7LclMguWYMHbPkL4O3YleimksrxT+sFwFl09xR/hoRP9BLW5+N8LopHbrlLh
         CBkSU4SvtuOkZkrc8ysZ7nHAcgDD7ihmIr8779DJR4at8arw3qkCcp+lMYLeehdScnFm
         1QiNoG9BnJ8MaEv1EzDMoEJGAc/9/6xTvvR/oxGgntWxDVWsx1JJMpzEBXLzh1l2xjpq
         1Log==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678548362;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1ocLrxz9PNmL7rxcHP9+sMO7kezIoSNjbehDL14u8SU=;
        b=12ATFn7GoCr7hgvtiH/my806AhWrfUfr8GYsSVjog8QUPhJ7ClJqrqEqhiyizVIIWo
         68l1Dx5CYuQKO0IwMkEQRleClgyuqDpPQhDUy9WE44q/ghBglTcUe9zrJ/klHLBeJucc
         gNEz57hTxrQ+IAOtPEyxM2EfE+OMHcBVe4uwysiDyiJuIHC+ZMyZ8t4JDCpNVXh9+PC1
         7k+QdFYFIP007bwgz8MJ8s/I67T8g2364cCR+Qey+Zr1NiDXdf8+OL1GNPYJIbuJDHHh
         HjGKU0M1OBBC5+3hXtJ+E2wwrk3WoSPiMDvn+9mRccqi60LlDsPxdfAqXIdeINeAT/x+
         078w==
X-Gm-Message-State: AO0yUKXGl7DFJYtnd4ujypNFvvoJqdKyw9msWgYPBF4KyPN7icdjvJYY
        c/FbQjSo5hLroD1UdMT+vtymeg==
X-Google-Smtp-Source: AK7set9+alVCPes/LutSROZa3zyRKf96T2rZ97KnwF3tjoBPKGWNiB+AYEiydpEz6svx0r1ADsKhaQ==
X-Received: by 2002:a2e:8404:0:b0:298:6f32:c182 with SMTP id z4-20020a2e8404000000b002986f32c182mr3980792ljg.36.1678548362019;
        Sat, 11 Mar 2023 07:26:02 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id u3-20020ac24c23000000b004dda9e8233asm344904lfq.42.2023.03.11.07.26.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Mar 2023 07:26:01 -0800 (PST)
Message-ID: <74f154b1-a440-fa83-1a46-a5b9223f5760@linaro.org>
Date:   Sat, 11 Mar 2023 17:26:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v7 6/9] interconnect: qcom: rpm: Handle interface clocks
Content-Language: en-GB
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230228-topic-qos-v7-0-815606092fff@linaro.org>
 <20230228-topic-qos-v7-6-815606092fff@linaro.org>
 <68a5d81a-5de8-798a-c150-d74c8ad38cb7@linaro.org>
 <f848061a-763e-fbf2-860c-758373e953df@linaro.org>
 <CAA8EJpqh+A_YKbhSQB5sWj4EP9eQtNHeohDira9o-jrx3pPRNg@mail.gmail.com>
 <51c41e49-5183-551e-c796-5b3d792b422f@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <51c41e49-5183-551e-c796-5b3d792b422f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11/03/2023 16:38, Bryan O'Donoghue wrote:
> On 11/03/2023 14:35, Dmitry Baryshkov wrote:
>>> Its probably worthwhile experimenting to see if the*ufs*_clk can/should
>>> be added to the UFS device list of clocks.
>> While we were doing this for some of the clocks (PCIe and USB, if I'm
>> not mistaken), I think that generally this is not fully correct. In my
>> opinion it should be in the interconnect driver, who turns
>> corresponding clocks on and off. These clocks correspond to the SoC
>> topology, rather than the end-device.
>>
> 
> True enough, they are interconnect clocks.
> 
> The question is how to only turn them on when the device that depends on 
> them wants them.

I think we can turn them on an off from qcom_icc_set(). Each node can 
list required clocks.

-- 
With best wishes
Dmitry

