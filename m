Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2097B5851
	for <lists+linux-pm@lfdr.de>; Mon,  2 Oct 2023 18:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238460AbjJBQ27 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Oct 2023 12:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbjJBQ27 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 2 Oct 2023 12:28:59 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C3EBB4
        for <linux-pm@vger.kernel.org>; Mon,  2 Oct 2023 09:28:53 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-405417465aaso159624415e9.1
        for <linux-pm@vger.kernel.org>; Mon, 02 Oct 2023 09:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696264132; x=1696868932; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QaSfphef0KwZ1Qx5UmeI5tAf0p6t+dtkVd/0GulncbM=;
        b=qeIsNXPdFvvFnsBuEkU1p4darVUr9H4oa5/yA0nEN4HPM+cXBRAhgEbz+6rOPus/eq
         V1MMroc66K41UjcbfA+pDN6N8zyzyMDzsRgNcCaBlz5pjoVmK4KZt/CmbIUBqj6EOlXX
         kWy/rHyJNDksOWmhFVipzIxwjXACRGBOYuPzHfGgK1KAj9KxCV5Rm3DMza9a9yp63npm
         aijkInB+kWvnET8N/fuEm/IOoLvoEbPOBilzOjlTMJbwC75Iuvjs2J+72Xy8T/MwfJ9Z
         9/fGUUIXffR3QUNMWxiCzjUgGSHZINEYhT6+nulF+2SZ9a71kpPnluc4AufvPVdnPcm0
         63lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696264132; x=1696868932;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QaSfphef0KwZ1Qx5UmeI5tAf0p6t+dtkVd/0GulncbM=;
        b=wOxzBHmJxcTFlVnReBt5TQsmwUZGe7EVY1N44IjIS2f6Mdmjk4o8JFn6sCauxXtZAX
         Fxc/P8iIMizHM+HiyCjTJv45npji+PDgOk/cirDGjXN/14hhDRPcbQAJ2hm4rzuz3mF5
         1/T+hgB7Ld8XrZ40YyORMsHcLuuGXOmXyqSNUBpVLx3t/uvYuJR/jLpWZ8+lEFFmF5S/
         KudpEER/58wSsParMYI7RCPP1ejWIsj09btI40fq1WW4EOUwQqqt3kAbV2pWYEX5URTJ
         JTncArR3nLBokpTMDn+7eiF28MbBqhXQ20LdG0RMS2+mf6pezUWPRTtAM6EpveSs1F6a
         YVgQ==
X-Gm-Message-State: AOJu0YxPnOlPKxPShYAdi55+uaTUmoWRKAgcAEYxFDoLYJQczcbBQ1tT
        R5hVXTZke9uiQcZPCTOz34wIVQ==
X-Google-Smtp-Source: AGHT+IH8O+8ivy0ZtrKVbyTSw8mmrl2ZLIuK89I8kjo8ZPnnlXWUnAO0Sc4uz4RPEyL7jrEIP4EJeQ==
X-Received: by 2002:a7b:cb8d:0:b0:406:177e:5df7 with SMTP id m13-20020a7bcb8d000000b00406177e5df7mr10883374wmi.29.1696264131854;
        Mon, 02 Oct 2023 09:28:51 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:8861:9b54:432d:d4f5? ([2a01:e0a:982:cbb0:8861:9b54:432d:d4f5])
        by smtp.gmail.com with ESMTPSA id n20-20020a1c7214000000b003fee567235bsm7608750wmc.1.2023.10.02.09.28.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Oct 2023 09:28:51 -0700 (PDT)
Message-ID: <3135a5a7-4e7a-4f8c-a288-682d6385b587@linaro.org>
Date:   Mon, 2 Oct 2023 18:28:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 0/4] thermal: Introduce Qualcomm Thermal Mitigation Device
 support
Content-Language: en-US, fr
To:     Manivannan Sadhasivam <mani@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Caleb Connolly <caleb.connolly@linaro.org>,
        Andy Gross <agross@kernel.org>,
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
 <20231002155814.GB12041@thinkpad>
 <CAA8EJpowGjnecOjr9h4r3=UXSrE4VdptoLADpQq3gDv_W9D3OQ@mail.gmail.com>
 <20231002161308.GC12041@thinkpad>
From:   Neil Armstrong <neil.armstrong@linaro.org>
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro Developer Services
In-Reply-To: <20231002161308.GC12041@thinkpad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 02/10/2023 18:13, Manivannan Sadhasivam wrote:
> On Mon, Oct 02, 2023 at 07:00:27PM +0300, Dmitry Baryshkov wrote:
>> On Mon, 2 Oct 2023 at 18:58, Manivannan Sadhasivam <mani@kernel.org> wrote:
>>>
>>> On Mon, Oct 02, 2023 at 06:00:37PM +0300, Dmitry Baryshkov wrote:
>>>> On Mon, 2 Oct 2023 at 17:52, Manivannan Sadhasivam <mani@kernel.org> wrote:
>>>>>
>>>>> On Sun, Oct 01, 2023 at 06:26:14PM +0100, Caleb Connolly wrote:
>>>>>>
>>>>>>
>>>>>> On 01/10/2023 16:57, Manivannan Sadhasivam wrote:
>>>>>>> On Fri, Sep 29, 2023 at 05:16:16PM +0100, Caleb Connolly wrote:
>>>>>>>> The Thermal Mitigation Device (TMD) Service is a QMI service that runs
>>>>>>>> on remote subsystems (the modem and DSPs) on Qualcomm SoCs.
>>>>>>>> It exposes various mitigations including passive thermal controls and
>>>>>>>> rail voltage restrictions.
>>>>>>>>
>>>>>>>> This series introduces support for exposing TMDs as cooling devices
>>>>>>>> in the kernel through the thermal framework, using the QMI interface.
>>>>>>>>
>>>>>>>> Each TMD client is described as a child of the remoteproc node in
>>>>>>>> devicetree. With subnodes for each control.
>>>>>>>>
>>>>>>>
>>>>>>> Daniel expressed concerns in the past aganist representing TMD driver as a
>>>>>>> cooling device since it is not tied to thermal zones and the governors cannot
>>>>>>> use it. Instead he suggested to represent it as a powercap device with thermal
>>>>>>> constraints.
>>>>>>
>>>>>> Hi Mani,
>>>>>>
>>>>>> Forgive me as I'm not yet super familiar with the thermal subsystem.
>>>>>>
>>>>>> As I understand it, the DT layout here enables each control to be referenced
>>>>>> under the thermal zones, at least this is the approach taken in CAF 4.9.
>>>>>>
>>>>>> Maybe I don't quite understand what you mean, are you saying that using
>>>>>> thermal zones is the wrong approach?
>>>>>
>>>>> Thermal framework expects each thermal zone represented in DT to have atleast
>>>>> one corresponding thermal sensor defined using "thermal-sensors" property. But
>>>>> with TMD, there is no thermal sensor AFAIK.
>>>>
>>>> As far as I understand, no. It is perfectly fine to have 'cooling'
>>>> devices, which react to external thermal monitoring events. I might be
>>>> mistaken, but I think that is the case here, isn't it?
>>>>
>>>
>>> Yes it is represented as cooling device(s). But I do not see any cognizant way
>>> to plug it with thermal zones i.e., unless TMD itself reports temperature of the
>>> modem, using it as a cooling device for external temperature events doesn't
>>> sound good to me.
>>
>> Why? We have compute, q6, wlan tsens sensors. So it seems natural to
>> tell CDSP to slow down if compute sensor reports overheating.
>>
> 
> TMD is for external devices such as PCIe modems as well. Is there a temperature
> sensor for that?

Is could, for example NVMe does.

But here Caleb only exposes the internal DSP over the TMD as cooling devices, so
it matches the tsens input we have.

Neil

> 
> - Mani
> 
>>>
>>> - Mani
>>>
>>>>>
>>>>>>>
>>>>>>> So please look into that approach.
>>>>>>
>>>>>> Any recommended reading? Or drivers I can use as a reference?
>>>>>>
>>>>>
>>>>> drivers/powercap/arm_scmi_powercap.c seems to be a good reference.
>>>>>
>>>>> - Mani
>>>>>
>>>>>> Thanks
>>>>>>>
>>>>>>> - Mani
>>>>>>>
>>>>>>>> This series is based on previous work by Bhupesh Sharma which can be
>>>>>>>> found at [1]. I'm sending this as a fresh series as it has been a
>>>>>>>> year since the original version and I have rewritten most of the driver.
>>>>>>>>
>>>>>>>> [1]: https://lore.kernel.org/linux-arm-msm/20220912085049.3517140-1-bhupesh.sharma@linaro.org/
>>>>>>>>
>>>>>>>> ---
>>>>>>>> Caleb Connolly (4):
>>>>>>>>         remoteproc: qcom: probe all child devices
>>>>>>>>         dt-bindings: thermal: Add qcom,qmi-cooling yaml bindings
>>>>>>>>         thermal: qcom: add qmi-cooling driver
>>>>>>>>         MAINTAINERS: Add entry for Qualcomm Cooling Driver
>>>>>>>>
>>>>>>>>    .../bindings/remoteproc/qcom,msm8996-mss-pil.yaml  |  13 +
>>>>>>>>    .../bindings/remoteproc/qcom,pas-common.yaml       |   6 +
>>>>>>>>    .../bindings/thermal/qcom,qmi-cooling.yaml         | 168 +++++++
>>>>>>>>    MAINTAINERS                                        |   8 +
>>>>>>>>    drivers/remoteproc/qcom_q6v5.c                     |   4 +
>>>>>>>>    drivers/remoteproc/qcom_q6v5_mss.c                 |   8 -
>>>>>>>>    drivers/thermal/qcom/Kconfig                       |  13 +
>>>>>>>>    drivers/thermal/qcom/Makefile                      |   1 +
>>>>>>>>    drivers/thermal/qcom/qmi-cooling.c                 | 520 +++++++++++++++++++++
>>>>>>>>    drivers/thermal/qcom/qmi-cooling.h                 | 428 +++++++++++++++++
>>>>>>>>    10 files changed, 1161 insertions(+), 8 deletions(-)
>>>>>>>> ---
>>>>>>>> base-commit: 9067f80db58bbce81d5f0703aa2fd261e88bc812
>>>>>>>>
>>>>>>>> // Caleb (they/them)
>>>>>>>>
>>>>>>>
>>>>>>
>>>>>> --
>>>>>> // Caleb (they/them)
>>>>>
>>>>> --
>>>>> மணிவண்ணன் சதாசிவம்
>>>>
>>>>
>>>>
>>>> --
>>>> With best wishes
>>>> Dmitry
>>>
>>> --
>>> மணிவண்ணன் சதாசிவம்
>>
>>
>>
>> -- 
>> With best wishes
>> Dmitry
> 

