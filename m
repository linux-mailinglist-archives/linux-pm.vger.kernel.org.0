Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4712D1FD7DE
	for <lists+linux-pm@lfdr.de>; Wed, 17 Jun 2020 23:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbgFQVsZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Jun 2020 17:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbgFQVsZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Jun 2020 17:48:25 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD56CC06174E;
        Wed, 17 Jun 2020 14:48:24 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id i8so2250331lfo.4;
        Wed, 17 Jun 2020 14:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5Jselfb+tn7C8hTjnU6+q8jejO6KT7yeJaOlgUUkDfU=;
        b=mwx5FqjFDSptmsKzHcONWpBLtprM57vaBgakUrQH//+Wi7aKJIAIWuPst+Zp0Iuhk3
         tfIlYgUDzeYSqxUUURx/O1dx7s2TvPzzgiE2BOy1dqoRKBK66qjg/mVCQkt0dJXpo3Si
         RwrJthyDNFbxLFXPejydJ9Q28ONzS1aPctaHlo31bNgQcGI5sQaLTfIO8JIhNmKCh+FF
         4VA6pZ7phh/s/FVUZT57NjB+vXPPivPPpJemdR3i11XE16SUYdZgLoY9MNPQQkp/oEoY
         9lLMohB4e94cWM+epe2qOogrOff4WMh1tRlevLQyiF9w25fRBJ7F/DzNTrRHbF03Ocgw
         OsCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5Jselfb+tn7C8hTjnU6+q8jejO6KT7yeJaOlgUUkDfU=;
        b=OjxrtoJT9PBDdzDNUXDDDJ/N5pM1BBH3Uu7wGxaRVWvDA78lOyHYnhzoxUHc+0F+pA
         hN6QdNAqv0f/nZpwtL1IegpC+fQU/I1bRBTsgNDVk7jEg/5a+MQCzRTqMwo3bygGxK5/
         EG7eOY0dEYXOtg8ozvz1Efyk2U/EVZaTlbXb0uhFqEdx4oBPuxzVHyptNgAf1YHbqUbg
         VvoHGl43ymRLPz9iqsgydw8y85pYVcyqFa49jNd0k69gaFrSuykYiBxrZFuKVHebuNxJ
         RLTuHuvPzdI2dDdima4yGuaQ1ODz+6+zhrAql6ipUwdeZL/JotDdB19TdErO/26hKjmZ
         ilFA==
X-Gm-Message-State: AOAM530qA/6stQJ9I6XAyw1ySuaQP77R0IZctKYvLGJ2VVQkXVrk6ZoU
        K5pxf+boxtjgm3Y3aYQX/VoyQPWC
X-Google-Smtp-Source: ABdhPJwRVLd8CkSuYn2vqquecgWKtSaPyyIaPzfp8KTngx8hhBHL8y1WDBsfFbYEaKVYw5U+60MERw==
X-Received: by 2002:a19:787:: with SMTP id 129mr500303lfh.147.1592430502790;
        Wed, 17 Jun 2020 14:48:22 -0700 (PDT)
Received: from [192.168.2.145] (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.googlemail.com with ESMTPSA id s9sm198055ljc.43.2020.06.17.14.48.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2020 14:48:22 -0700 (PDT)
Subject: Re: [PATCH v4 22/37] dt-bindings: host1x: Document new interconnect
 properties
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mikko Perttunen <cyndis@kapsi.fi>,
        =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@samsung.com>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
References: <20200609131404.17523-1-digetx@gmail.com>
 <20200609131404.17523-23-digetx@gmail.com> <20200617213726.GA2837398@bogus>
 <5303317a-2cb6-d7a8-361a-30867fc6eab7@gmail.com>
Message-ID: <8fc5c06f-ee0f-f907-6631-05b45b89c7da@gmail.com>
Date:   Thu, 18 Jun 2020 00:48:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <5303317a-2cb6-d7a8-361a-30867fc6eab7@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

18.06.2020 00:44, Dmitry Osipenko пишет:
> 18.06.2020 00:37, Rob Herring пишет:
>> On Tue, Jun 09, 2020 at 04:13:49PM +0300, Dmitry Osipenko wrote:
>>> Most of Host1x devices have at least one memory client. These clients
>>> are directly connected to the memory controller. The new interconnect
>>> properties represent the memory client's connection to the memory
>>> controller.
>>>
>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>> ---
>>>  .../display/tegra/nvidia,tegra20-host1x.txt   | 68 +++++++++++++++++++
>>>  1 file changed, 68 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.txt b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.txt
>>> index 47319214b5f6..ab4fbee7bccf 100644
>>> --- a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.txt
>>> +++ b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.txt
>>> @@ -20,6 +20,10 @@ Required properties:
>>>  - reset-names: Must include the following entries:
>>>    - host1x
>>>  
>>> +Each host1x client module having to perform DMA through the Memory Controller
>>> +should have the interconnect endpoints set to the Memory Client and External
>>> +Memory respectively.
>>> +
>>>  The host1x top-level node defines a number of children, each representing one
>>>  of the following host1x client modules:
>>>  
>>> @@ -36,6 +40,12 @@ of the following host1x client modules:
>>>    - reset-names: Must include the following entries:
>>>      - mpe
>>>  
>>> +  Optional properties:
>>> +  - interconnects: Must contain entry for the MPE memory clients.
>>> +  - interconnect-names: Must include name of the interconnect path for each
>>> +    interconnect entry. Consult TRM documentation for information about
>>> +    available memory clients, see MEMORY CONTROLLER section.
>>> +
>>>  - vi: video input
>>>  
>>>    Required properties:
>>> @@ -65,6 +75,12 @@ of the following host1x client modules:
>>>        - power-domains: Must include sor powergate node as csicil is in
>>>          SOR partition.
>>>  
>>> +  Optional properties:
>>> +  - interconnects: Must contain entry for the VI memory clients.
>>> +  - interconnect-names: Must include name of the interconnect path for each
>>> +    interconnect entry. Consult TRM documentation for information about
>>> +    available memory clients, see MEMORY CONTROLLER section.
>>> +
>>>  - epp: encoder pre-processor
>>>  
>>>    Required properties:
>>> @@ -78,6 +94,12 @@ of the following host1x client modules:
>>>    - reset-names: Must include the following entries:
>>>      - epp
>>>  
>>> +  Optional properties:
>>> +  - interconnects: Must contain entry for the EPP memory clients.
>>> +  - interconnect-names: Must include name of the interconnect path for each
>>> +    interconnect entry. Consult TRM documentation for information about
>>> +    available memory clients, see MEMORY CONTROLLER section.
>>> +
>>>  - isp: image signal processor
>>>  
>>>    Required properties:
>>> @@ -91,6 +113,12 @@ of the following host1x client modules:
>>>    - reset-names: Must include the following entries:
>>>      - isp
>>>  
>>> +  Optional properties:
>>> +  - interconnects: Must contain entry for the ISP memory clients.
>>> +  - interconnect-names: Must include name of the interconnect path for each
>>> +    interconnect entry. Consult TRM documentation for information about
>>> +    available memory clients, see MEMORY CONTROLLER section.
>>> +
>>>  - gr2d: 2D graphics engine
>>>  
>>>    Required properties:
>>> @@ -104,6 +132,12 @@ of the following host1x client modules:
>>>    - reset-names: Must include the following entries:
>>>      - 2d
>>>  
>>> +  Optional properties:
>>> +  - interconnects: Must contain entry for the GR2D memory clients.
>>> +  - interconnect-names: Must include name of the interconnect path for each
>>> +    interconnect entry. Consult TRM documentation for information about
>>> +    available memory clients, see MEMORY CONTROLLER section.
>>> +
>>>  - gr3d: 3D graphics engine
>>>  
>>>    Required properties:
>>> @@ -122,6 +156,12 @@ of the following host1x client modules:
>>>      - 3d
>>>      - 3d2 (Only required on SoCs with two 3D clocks)
>>>  
>>> +  Optional properties:
>>> +  - interconnects: Must contain entry for the GR3D memory clients.
>>> +  - interconnect-names: Must include name of the interconnect path for each
>>> +    interconnect entry. Consult TRM documentation for information about
>>> +    available memory clients, see MEMORY CONTROLLER section.
>>> +
>>>  - dc: display controller
>>>  
>>>    Required properties:
>>> @@ -149,6 +189,10 @@ of the following host1x client modules:
>>>    - nvidia,hpd-gpio: specifies a GPIO used for hotplug detection
>>>    - nvidia,edid: supplies a binary EDID blob
>>>    - nvidia,panel: phandle of a display panel
>>> +  - interconnects: Must contain entry for the DC memory clients.
>>> +  - interconnect-names: Must include name of the interconnect path for each
>>> +    interconnect entry. Consult TRM documentation for information about
>>> +    available memory clients, see MEMORY CONTROLLER section.
>>>  
>>>  - hdmi: High Definition Multimedia Interface
>>>  
>>> @@ -297,6 +341,12 @@ of the following host1x client modules:
>>>    - reset-names: Must include the following entries:
>>>      - vic
>>>  
>>> +  Optional properties:
>>> +  - interconnects: Must contain entry for the VIC memory clients.
>>> +  - interconnect-names: Must include name of the interconnect path for each
>>> +    interconnect entry. Consult TRM documentation for information about
>>> +    available memory clients, see MEMORY CONTROLLER section.
>>> +
>>>  Example:
>>>  
>>>  / {
>>> @@ -410,6 +460,15 @@ Example:
>>>  			resets = <&tegra_car 27>;
>>>  			reset-names = "dc";
>>>  
>>> +			interconnects = <&mc TEGRA20_MC_DISPLAY0A &emc>,
>>> +					<&mc TEGRA20_MC_DISPLAY0B &emc>,
>>> +					<&mc TEGRA20_MC_DISPLAY0C &emc>,
>>> +					<&mc TEGRA20_MC_DISPLAY1B &emc>;
>>
>> This looks odd or wrong. Each entry has 2 phandles? 
> 
> Each entry defines interconnect path, where MC is the start of the path
> and EMC is the end. So yes, 2 phandles for each path.
> 
> Please see arm/boot/dts/qcom-msm8974.dtsi for another example [1].
> 
> [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/qcom-msm8974.dtsi?h=v5.8-rc1#n1448
> 

Actually, there are even better examples:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/qcom/sc7180.dtsi?h=v5.8-rc1#n1044
