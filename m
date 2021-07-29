Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8EC13DA195
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jul 2021 12:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236110AbhG2Ky3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 29 Jul 2021 06:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233413AbhG2Ky2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 29 Jul 2021 06:54:28 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A311AC061765
        for <linux-pm@vger.kernel.org>; Thu, 29 Jul 2021 03:54:24 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id h27so3581849qtu.9
        for <linux-pm@vger.kernel.org>; Thu, 29 Jul 2021 03:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=A0+vnStwHHWcv0kEG4jL+l5YMwp+7TPgb/XyNRNNEM8=;
        b=CvQK0lmU1Cgn3fBwhUY4Pb/3oGnP6zXUm6Nt+2u1WR3WPnGboq4LkpWkX5c8MNbLDF
         JU7Os0PunpXJa/OIfOo4/CqRf+DkTHAp74/fynC9qjy8s4GTaVvF7V7fW7IZ6gwD5sJv
         hFYdF+9mkl+z2pQ56Nk4KqSqvWEeDGkY/PYmhFJekM2qyjnYwEfmfRIWbvOJwwJlPg1h
         zQ3FD4mpznFc+Um8TRYFJQ/IZiIyyuVozChoV5/4vqDiw+nS3y4szK2t5j8vSDe0a17U
         YXpkJ0zGrMmFIg2l6Y5bAy3uoq45/Um1Hd3gDdUY//XxGgTqxVbqbnrNTwwFfRpyvk4+
         AfUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=A0+vnStwHHWcv0kEG4jL+l5YMwp+7TPgb/XyNRNNEM8=;
        b=SLYe16Mnqtm/SGloLtUZuRYKOjyfnQiqrWf3WFgyjiq0V+ij1amRozhC7gGWVMhuqu
         ISVuSVIAHvziUL4fyaI06HGBcSNFRLKXXfJL5m3NiqfBWcQQH/MvHFnt6MDDrLmp/ot7
         PZGnJOcCbh289sNVweNq7E4ckxvh3so0kMLDZFsiwIhIc6wArIN3pvlCVte1YCg+7B0d
         OMwUDfLA2DNF9oFB9VMJGmCXTrBjLQM7T7KyBOQCdzQm+yv6yI5OBVdW3hsyybW8komz
         V86BMx34tkrz6N/48ndVkhMPK4XmSYlNQWJuH5rRs1+8RRhOYZ7imP+0GbXAyWFF2M3f
         Kdgg==
X-Gm-Message-State: AOAM530s2NU77Sw36xDC4slTpiNtzG3TR/EXWBmHeLubVm2uANSlR45E
        1n3HxjwMzzAPf37zxd6sOqtAEQ==
X-Google-Smtp-Source: ABdhPJwCriNjT7vC1Ik6qXt63Lgc1Xgj5G1ZZlfdiSkKzttrxPvV/wdlnks/PTQ2+JCSkb5DNTQkGQ==
X-Received: by 2002:ac8:724c:: with SMTP id l12mr3667029qtp.372.1627556063856;
        Thu, 29 Jul 2021 03:54:23 -0700 (PDT)
Received: from [192.168.1.93] (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.gmail.com with ESMTPSA id a16sm1450021qkn.107.2021.07.29.03.54.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jul 2021 03:54:23 -0700 (PDT)
Subject: Re: [PATCH 14/39] arm64: dts: qcom: sdm630: Add TSENS node
To:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        ~postmarketos/upstreaming@lists.sr.ht
Cc:     martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210728222542.54269-1-konrad.dybcio@somainline.org>
 <20210728222542.54269-15-konrad.dybcio@somainline.org>
 <860f1120-c5a4-f531-3ea9-aa90c6b063dc@linaro.org>
 <2318377c-959a-a42b-81b5-44e2629570d5@somainline.org>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <afee55a8-d7d3-709a-ea4f-0306698c9976@linaro.org>
Date:   Thu, 29 Jul 2021 06:54:22 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <2318377c-959a-a42b-81b5-44e2629570d5@somainline.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 7/29/21 6:52 AM, Konrad Dybcio wrote:
> 
> On 29.07.2021 12:50, Thara Gopinath wrote:
>> Hi Konrad,
>>
>> On 7/28/21 6:25 PM, Konrad Dybcio wrote:
>>> This will enable temperature reporting for various SoC
>>> components.
>>>
>>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
>>> ---
>>>    .../devicetree/bindings/thermal/qcom-tsens.yaml       |  1 +
>>>    arch/arm64/boot/dts/qcom/sdm630.dtsi                  | 11 +++++++++++
>>>    2 files changed, 12 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
>>> index 4a2eaf28e3fd..d3b9e9b600a2 100644
>>> --- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
>>> +++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
>>> @@ -48,6 +48,7 @@ properties:
>>>                  - qcom,sc7180-tsens
>>>                  - qcom,sc7280-tsens
>>>                  - qcom,sc8180x-tsens
>>> +              - qcom,sdm630-tsens
>>>                  - qcom,sdm845-tsens
>>>                  - qcom,sm8150-tsens
>>>                  - qcom,sm8250-tsens
>>> diff --git a/arch/arm64/boot/dts/qcom/sdm630.dtsi b/arch/arm64/boot/dts/qcom/sdm630.dtsi
>>> index 1e54828817d5..7e9c80e35fba 100644
>>> --- a/arch/arm64/boot/dts/qcom/sdm630.dtsi
>>> +++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
>>> @@ -627,6 +627,17 @@ mnoc: interconnect@1745000 {
>>>                     <&mmcc AHB_CLK_SRC>;
>>>            };
>>>    +        tsens: thermal-sensor@10ae000 {
>>> +            compatible = "qcom,sdm630-tsens", "qcom,tsens-v2";
>>> +            reg = <0x010ae000 0x1000>, /* TM */
>>> +                  <0x010ad000 0x1000>; /* SROT */
>>> +            #qcom,sensors = <12>;
>>
>> Are all 12 sensors used ? I see that in a later patch "arm64: dts: qcom: sdm630: Add thermal-zones configuration" only 9 are used.
> 
> Hi,
> 
> if I recall correctly, they all give output but not all of the mappings were documented in the downstream sources and we have no documentation whatsoever :(

Right. In that case, why not change #qcom,sensors to 9 and add rest of 
the sensors if and when needed ?

> 
> 
> Konrad
> 

-- 
Warm Regards
Thara (She/Her/Hers)
