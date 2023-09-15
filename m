Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB7A97A2004
	for <lists+linux-pm@lfdr.de>; Fri, 15 Sep 2023 15:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235418AbjIONni (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Sep 2023 09:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235421AbjIONnh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Sep 2023 09:43:37 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F40C2701
        for <linux-pm@vger.kernel.org>; Fri, 15 Sep 2023 06:43:31 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-52eed139ec2so2492402a12.2
        for <linux-pm@vger.kernel.org>; Fri, 15 Sep 2023 06:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694785409; x=1695390209; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nxUa3lcSOYCvMd3Uempcm0pEvmeb+dGRyDtftI7YkD4=;
        b=Y29w6srkXEQOis2n/iOFQ0o+rQY8Y9WURsV1MVDEoGVNow4IgzC9Mrb3wGrBPCvDRD
         EIwmnkpcZKp2cdEJPkBjcPU/Y3U9beLLBx/9OKilfkPzgCDXKftCZJnhLKkduVZFD558
         wQx82Q72iYhR7wFlnAGtLV6YzdZwETTgyxiqTvsDqD6wle6ZFVlFi1CZyJ/KyvwAbxGP
         R8airCOiWxOOFphMB/UX0P6evqsTEDkCCN7WIyF3bcmn2jTJEQhD1/Nve3G+4MsBlfph
         82HrT7ELL4AnjPRSg8VutqcBF+v/wryVCPMf3clOPqpgiFwDIUdebh+t4tVdU6QaGRWj
         5VYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694785409; x=1695390209;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nxUa3lcSOYCvMd3Uempcm0pEvmeb+dGRyDtftI7YkD4=;
        b=tqTiPU/CW/KIlB3u0HwVMrpvVnu0f27LW9hhJxNjt2ZRB80ysYWfW2afDSrz35btaK
         4XcO7j/RkrXI5Ymhp9TTTzRuXUWYhCCdanD3bPbdWvZUOqCTCAjayVQEJsfcb+qKzEKQ
         07cbs/YXxCR9XLRcqhLqvneQSJOZy+yBbgQ2y4iokXhUBSM9hXO6J3GsUFHtZ8FVDvJo
         321n7kV0DP/ebmYtMF4RvCxYbq201IAGOEAGKUSuhPUxPAc1qhEdxzFm5vqzUKSVKi3e
         xfjRrlv7FHSMU3JHxdijVXI8NEgzUpzeozpiGTdpPc/p7AXiN3Okrppcn5qweZhGY2D3
         3X9Q==
X-Gm-Message-State: AOJu0YxMPH3lqeM8MR8rA9PYnmrgkdPl5/lFs3Wua0lTHQZ9z89vEisU
        I+5rWUiOdsTZkGfBXPY5zi7eiw==
X-Google-Smtp-Source: AGHT+IHoJNwEFYQp7rMPD1uinycu+15SOkdAgTmDGBrBxlvD7rjzpyl6ehYbqTcN1XpYAQKuSyAn2w==
X-Received: by 2002:a05:6402:3c4:b0:526:9626:e37d with SMTP id t4-20020a05640203c400b005269626e37dmr1576947edw.37.1694785409513;
        Fri, 15 Sep 2023 06:43:29 -0700 (PDT)
Received: from [192.168.37.232] (178235177024.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.24])
        by smtp.gmail.com with ESMTPSA id o7-20020aa7d3c7000000b005233deb30aesm2297964edr.10.2023.09.15.06.43.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 06:43:28 -0700 (PDT)
Message-ID: <978fd46d-8142-41e6-9c62-df678018d6c2@linaro.org>
Date:   Fri, 15 Sep 2023 15:43:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/53] icc-rpmh multi-RSC voting groundwork
Content-Language: en-US
To:     Mike Tipton <quic_mdtipton@quicinc.com>
Cc:     Georgi Djakov <djakov@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230708-topic-rpmh_icc_rsc-v1-0-b223bd2ac8dd@linaro.org>
 <c067a45f-9629-d516-9e56-36538e4ff6db@kernel.org>
 <20230807215739.GA9621@hu-mdtipton-lv.qualcomm.com>
 <10520827-dc01-475c-b09a-35cefc9e0a62@linaro.org>
 <20230913012951.GA19284@hu-mdtipton-lv.qualcomm.com>
 <ffc58838-c306-49f3-a90a-95b2cf02ae3d@linaro.org>
 <20230914023239.GA25147@hu-mdtipton-lv.qualcomm.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20230914023239.GA25147@hu-mdtipton-lv.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 14.09.2023 04:32, Mike Tipton wrote:
> On Wed, Sep 13, 2023 at 10:31:49AM +0200, Konrad Dybcio wrote:
>>> The applicable voters should likely be defined in the target-specific
>>> headers, rather than the common qcom,icc.h. The bit range used for them
>>> could be common, but each target may only support a small subset of the
>>> total set of possible voters across all targets.
>> I'm not sure how client drivers would then choose the
>> correct path other than
>>
>> switch (soc) {
>> case 8450:
>> 	tag = QCOM_ICC_TAG_VOTER_8450_HLOS;
>> 	break;
>> case 8550:
>> 	tag = QCOM_ICC_TAG_VOTER_8550_HLOS;
>> 	break;
>> ...
>> }
>>
>> which would be unacceptable.
> 
> The same general way it's handled for the endpoint bindings, which are
> already target-specific. 
> 
> Any client drivers hardcoding the endpoint bindings in their driver
> would have to include the appropriate, target-specific binding header
> (e.g. qcom,sm8550-rpmh.h). That would only be possible if their driver
> file is itself target-specific. Otherwise, it would have to pull the
> endpoint bindings from devicetree. Or just use the recommended
> of_icc_get() and let devicetree do everything for them. Same for the
> target-specific voter tag bindings.
> 
> Clients can also specify their tags in devicetree. They don't actually
> have to call icc_set_tag() directly. For example:
> 
>     #include <dt-bindings/interconnect/qcom,sm8450.h>
> 
>     interconnects = <&mmss_noc MASTER_MDP QCOM_ICC_TAG_VOTER_DISP
>                      &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_VOTER_DISP>;
> 
> Then when they call of_icc_get() for this path it'll automatically have
> QCOM_ICC_TAG_VOTER_DISP set for them.
I think I'd skew towards the "define everything in the DT" approach.

One thing that makes me uneasy to go on with this approach is the
question whether there is a case in which we would want to switch
from e.g. voting through DISP to voting through APPS (or similar)
from within a single device.

Konrad
