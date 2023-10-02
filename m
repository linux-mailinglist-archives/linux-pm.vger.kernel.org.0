Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D83C7B56B5
	for <lists+linux-pm@lfdr.de>; Mon,  2 Oct 2023 17:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237754AbjJBPOr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Oct 2023 11:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237850AbjJBPOp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 2 Oct 2023 11:14:45 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE3B7BD
        for <linux-pm@vger.kernel.org>; Mon,  2 Oct 2023 08:14:40 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-405417465aaso158545445e9.1
        for <linux-pm@vger.kernel.org>; Mon, 02 Oct 2023 08:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696259679; x=1696864479; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ld9KM5DFyTv+ue6x8CTZGB2m+OY/rycHawCXAqGvLjk=;
        b=WRQaOSnwu9v+lURfvHg14EO3EiKcbeQibMX5xVDP6/BxfuC37zR5yeOqNr/12cprqr
         g06llDa+qQaAN4+wbTU02EjNx4/QkBPVusX0d713zt9ErhiQC+3fD+4kdMajv46TWCOV
         m40soVDa+8KqW2R2uYYMBY8P/EluSl6/Ald3oW0CL7l1UfSUzeyPDwKMAY88LkiP9Vp2
         lDF29YnozsuaL/qKpp5AfnnSW0T/hKRnXSJJ1nlxAtXCSk7Se1RMs6ee9JollFu38nHG
         dFZdgmS5ywLgYCubrTmbvcU0I+Vecnzps7gU8CQcE3nB3bKGZjWyaUjR+0Q+H11wUFXO
         Vjpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696259679; x=1696864479;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ld9KM5DFyTv+ue6x8CTZGB2m+OY/rycHawCXAqGvLjk=;
        b=mtivlFmf/NG6n91o2Jhyq8yES0NW/hxcJuxiUzTbKQz+JdQUcbSm9kPFZ2Dhurtmc/
         J3X1s9TTrpYyv+jNbCnkwraFnC8IBDdr6nX+g9lNDyPRG/YbMPBFczCwr0CxL+gPrXW1
         wT58Odvr8LtmUqToNzRrWjlz4XiD98S1cNthUDnARkUx26y1SB/L1zUC+heNrUU6OuCJ
         uymnVTOVr4Cgg/V2/OPjq/ybKRy8ANd5vMmYbkeQSmo1Mj+vfbfe3PeCzBgSFZnV7rYf
         lisW63wEEBeCrnULYRYNkA3IKXyAATOmXvVStfVOHkXllRVkFueg+a5rU0kzqyfbp6hN
         M82g==
X-Gm-Message-State: AOJu0Yyw/7AwHaE6PD2FJNGbgrWuE6H3k61HBB1nRD/MrtVtPuzwl/Nu
        wyO4S4oFGpTGj+noCUJjkhLUeQ==
X-Google-Smtp-Source: AGHT+IGbuOpzfVIChIMgvdGIc4SwNvthLh0HCEHGr3cjdAoa9ovxtmPcnEnUm29nwVeNswcX21Zusw==
X-Received: by 2002:a05:600c:364f:b0:406:3977:eccd with SMTP id y15-20020a05600c364f00b004063977eccdmr10439727wmq.33.1696259679173;
        Mon, 02 Oct 2023 08:14:39 -0700 (PDT)
Received: from [192.168.1.8] (host-2-99-112-229.as13285.net. [2.99.112.229])
        by smtp.gmail.com with ESMTPSA id k16-20020a05600c0b5000b003fe61c33df5sm7471025wmr.3.2023.10.02.08.14.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Oct 2023 08:14:38 -0700 (PDT)
Message-ID: <317a532a-6687-4a7a-b865-dde8fa9fa7f6@linaro.org>
Date:   Mon, 2 Oct 2023 16:14:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] thermal: Introduce Qualcomm Thermal Mitigation Device
 support
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bhupesh Sharma <bhupesh.linux@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org
References: <20230905-caleb-qmi_cooling-v1-0-5aa39d4164a7@linaro.org>
 <20231001155701.GA53767@thinkpad>
 <cefe711b-d274-4d83-9dda-01f33b342387@linaro.org>
 <20231002145239.GA12041@thinkpad>
 <CAA8EJppn-f6R3ObGvagqkg1_KtXGgtNAgRn-LQiN3ORSHQY3-Q@mail.gmail.com>
From:   Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <CAA8EJppn-f6R3ObGvagqkg1_KtXGgtNAgRn-LQiN3ORSHQY3-Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 02/10/2023 16:00, Dmitry Baryshkov wrote:
> On Mon, 2 Oct 2023 at 17:52, Manivannan Sadhasivam <mani@kernel.org> wrote:
>>
>> On Sun, Oct 01, 2023 at 06:26:14PM +0100, Caleb Connolly wrote:
>>>
>>>
>>> On 01/10/2023 16:57, Manivannan Sadhasivam wrote:
>>>> On Fri, Sep 29, 2023 at 05:16:16PM +0100, Caleb Connolly wrote:
>>>>> The Thermal Mitigation Device (TMD) Service is a QMI service that runs
>>>>> on remote subsystems (the modem and DSPs) on Qualcomm SoCs.
>>>>> It exposes various mitigations including passive thermal controls and
>>>>> rail voltage restrictions.
>>>>>
>>>>> This series introduces support for exposing TMDs as cooling devices
>>>>> in the kernel through the thermal framework, using the QMI interface.
>>>>>
>>>>> Each TMD client is described as a child of the remoteproc node in
>>>>> devicetree. With subnodes for each control.
>>>>>
>>>>
>>>> Daniel expressed concerns in the past aganist representing TMD driver as a
>>>> cooling device since it is not tied to thermal zones and the governors cannot
>>>> use it. Instead he suggested to represent it as a powercap device with thermal
>>>> constraints.

I think so, see for example in CAF 4.9 [1]

As far as I can tell, the QMI TMD service was written specifically *for*
the cooling_device API, so it's a bit of a chicken and egg problem
trying to coerce it to some other form...

That all being said, I can definitely see the potential value in using
the powercap framework. Especially if it would let us tie the TMD
controls more directly with the remoteproc device and more easily
integrate it with DTPM.

For example, would it also make sense to adjust these values to preserve
battery life? Which API makes the most sense for that?

[1]:
https://github.com/android-linux-stable/msm-4.9/blob/384eee701481c3dd08822819cf4d5f1da5729db1/arch/arm64/boot/dts/qcom/sdm670-thermal.dtsi#L661
>>>
>>> Hi Mani,
>>>
>>> Forgive me as I'm not yet super familiar with the thermal subsystem.
>>>
>>> As I understand it, the DT layout here enables each control to be referenced
>>> under the thermal zones, at least this is the approach taken in CAF 4.9.
>>>
>>> Maybe I don't quite understand what you mean, are you saying that using
>>> thermal zones is the wrong approach?
>>
>> Thermal framework expects each thermal zone represented in DT to have atleast
>> one corresponding thermal sensor defined using "thermal-sensors" property. But
>> with TMD, there is no thermal sensor AFAIK.
> 
> As far as I understand, no. It is perfectly fine to have 'cooling'
> devices, which react to external thermal monitoring events. I might be
> mistaken, but I think that is the case here, isn't it?
> 
>>
>>>>
>>>> So please look into that approach.
>>>
>>> Any recommended reading? Or drivers I can use as a reference?
>>>
>>
>> drivers/powercap/arm_scmi_powercap.c seems to be a good reference.
>>
>> - Mani
>>
>>> Thanks
>>>>
>>>> - Mani
>>>>
>>>>> This series is based on previous work by Bhupesh Sharma which can be
>>>>> found at [1]. I'm sending this as a fresh series as it has been a
>>>>> year since the original version and I have rewritten most of the driver.
>>>>>
>>>>> [1]: https://lore.kernel.org/linux-arm-msm/20220912085049.3517140-1-bhupesh.sharma@linaro.org/
>>>>>
>>>>> ---
>>>>> Caleb Connolly (4):
>>>>>        remoteproc: qcom: probe all child devices
>>>>>        dt-bindings: thermal: Add qcom,qmi-cooling yaml bindings
>>>>>        thermal: qcom: add qmi-cooling driver
>>>>>        MAINTAINERS: Add entry for Qualcomm Cooling Driver
>>>>>
>>>>>   .../bindings/remoteproc/qcom,msm8996-mss-pil.yaml  |  13 +
>>>>>   .../bindings/remoteproc/qcom,pas-common.yaml       |   6 +
>>>>>   .../bindings/thermal/qcom,qmi-cooling.yaml         | 168 +++++++
>>>>>   MAINTAINERS                                        |   8 +
>>>>>   drivers/remoteproc/qcom_q6v5.c                     |   4 +
>>>>>   drivers/remoteproc/qcom_q6v5_mss.c                 |   8 -
>>>>>   drivers/thermal/qcom/Kconfig                       |  13 +
>>>>>   drivers/thermal/qcom/Makefile                      |   1 +
>>>>>   drivers/thermal/qcom/qmi-cooling.c                 | 520 +++++++++++++++++++++
>>>>>   drivers/thermal/qcom/qmi-cooling.h                 | 428 +++++++++++++++++
>>>>>   10 files changed, 1161 insertions(+), 8 deletions(-)
>>>>> ---
>>>>> base-commit: 9067f80db58bbce81d5f0703aa2fd261e88bc812
>>>>>
>>>>> // Caleb (they/them)
>>>>>
>>>>
>>>
>>> --
>>> // Caleb (they/them)
>>
>> --
>> மணிவண்ணன் சதாசிவம்
> 
> 
> 

-- 
// Caleb (they/them)
