Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6BC7B48E2
	for <lists+linux-pm@lfdr.de>; Sun,  1 Oct 2023 19:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235229AbjJAR0W (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 1 Oct 2023 13:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235194AbjJAR0V (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 1 Oct 2023 13:26:21 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF30D9
        for <linux-pm@vger.kernel.org>; Sun,  1 Oct 2023 10:26:19 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-40572aeb673so129110045e9.0
        for <linux-pm@vger.kernel.org>; Sun, 01 Oct 2023 10:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696181177; x=1696785977; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nT7pagqUgpEeHd/BYI3RWZkltric+Zk6n3iICPRwFfU=;
        b=RoR2bGPVzdnCnLviXBwKLH0RYVLeBzo3Ny1WQnEUEDetUkV0aCkOPAvY/lp1XMy2jn
         O4/qzenLcabTHRb2Gmt+dEsI1oaVUWgpfn0AO9wKeYyiLIK+UOWiX3xrDfSjJD62U/Yf
         LFBKa9zDuNy/D1nt5s8PcQeBYI7hg2TcE7l4I9s0AMFgbijKZ+Wb+xTOGQy8HxRVUiOw
         WgPbZJxLnlz6RyVwpSKZY5sdYFUuUC76Rv5zNo996YoyslWduXxKb9HN2+m9SZaaCS8q
         DKDBTcY2BVnG1D/kVLLd6pxjBr2ZWkhLzwf+ey6K6HcP+ZcmTnAjUrvteCI2NgK9RZfN
         dfsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696181177; x=1696785977;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nT7pagqUgpEeHd/BYI3RWZkltric+Zk6n3iICPRwFfU=;
        b=K6X3XgWOtqMli18NQtibb7p1ri7Op6PBcCL/sImwSQd2NDA4SJYTdobXbWTDlTbinM
         eNFEsx2fZvJ2LQpda+FZXclW0X951jmiYF8vRs/HYurFXbThZP4mIdrtxMvDKC4Wptzo
         i+gFRKqUS0F75MxCveBALweChABHAlbPraIMxxY5cZ7vSa3IfM2kCDLPWKrXdDQE8JcE
         dYOskIs/cXTQ8iuWffptcJu1EO8l/YeG0Ecnps+mbOFijYgAI3dJAiIJndgH3w4E3S4I
         DSKhaJ+6qxV/0E5weeXrt7TwmJPEvoMaMMdW73+NBdj0EgWjDLvR+NAbB0Z6eNNyWh8k
         EiCg==
X-Gm-Message-State: AOJu0YyV0xSQdLCUJAudCQyNOrSL6yN0SOrgT7g3vGE3lmySF6lIY1ur
        KKXW0U6ksKN0O16vMzrRYbupLg==
X-Google-Smtp-Source: AGHT+IEGshf6p+xcOYqgQe106M5j/2Y9oSZ+muu0yMArZnkd7QanlgZUiL7HO9rxkphXyNvCHdRCXQ==
X-Received: by 2002:a05:600c:b4e:b0:402:95a0:b2ae with SMTP id k14-20020a05600c0b4e00b0040295a0b2aemr8211234wmr.32.1696181177528;
        Sun, 01 Oct 2023 10:26:17 -0700 (PDT)
Received: from [192.168.1.23] (host-2-99-112-229.as13285.net. [2.99.112.229])
        by smtp.gmail.com with ESMTPSA id z20-20020a7bc7d4000000b0040640073d25sm5586923wmk.16.2023.10.01.10.26.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Oct 2023 10:26:17 -0700 (PDT)
Message-ID: <cefe711b-d274-4d83-9dda-01f33b342387@linaro.org>
Date:   Sun, 1 Oct 2023 18:26:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] thermal: Introduce Qualcomm Thermal Mitigation Device
 support
Content-Language: en-US
To:     Manivannan Sadhasivam <mani@kernel.org>
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
From:   Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20231001155701.GA53767@thinkpad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 01/10/2023 16:57, Manivannan Sadhasivam wrote:
> On Fri, Sep 29, 2023 at 05:16:16PM +0100, Caleb Connolly wrote:
>> The Thermal Mitigation Device (TMD) Service is a QMI service that runs
>> on remote subsystems (the modem and DSPs) on Qualcomm SoCs.
>> It exposes various mitigations including passive thermal controls and
>> rail voltage restrictions.
>>
>> This series introduces support for exposing TMDs as cooling devices
>> in the kernel through the thermal framework, using the QMI interface.
>>
>> Each TMD client is described as a child of the remoteproc node in
>> devicetree. With subnodes for each control.
>>
> 
> Daniel expressed concerns in the past aganist representing TMD driver as a
> cooling device since it is not tied to thermal zones and the governors cannot
> use it. Instead he suggested to represent it as a powercap device with thermal
> constraints.

Hi Mani,

Forgive me as I'm not yet super familiar with the thermal subsystem.

As I understand it, the DT layout here enables each control to be 
referenced under the thermal zones, at least this is the approach taken 
in CAF 4.9.

Maybe I don't quite understand what you mean, are you saying that using 
thermal zones is the wrong approach?
> 
> So please look into that approach.

Any recommended reading? Or drivers I can use as a reference?

Thanks
> 
> - Mani
> 
>> This series is based on previous work by Bhupesh Sharma which can be
>> found at [1]. I'm sending this as a fresh series as it has been a
>> year since the original version and I have rewritten most of the driver.
>>
>> [1]: https://lore.kernel.org/linux-arm-msm/20220912085049.3517140-1-bhupesh.sharma@linaro.org/
>>
>> ---
>> Caleb Connolly (4):
>>        remoteproc: qcom: probe all child devices
>>        dt-bindings: thermal: Add qcom,qmi-cooling yaml bindings
>>        thermal: qcom: add qmi-cooling driver
>>        MAINTAINERS: Add entry for Qualcomm Cooling Driver
>>
>>   .../bindings/remoteproc/qcom,msm8996-mss-pil.yaml  |  13 +
>>   .../bindings/remoteproc/qcom,pas-common.yaml       |   6 +
>>   .../bindings/thermal/qcom,qmi-cooling.yaml         | 168 +++++++
>>   MAINTAINERS                                        |   8 +
>>   drivers/remoteproc/qcom_q6v5.c                     |   4 +
>>   drivers/remoteproc/qcom_q6v5_mss.c                 |   8 -
>>   drivers/thermal/qcom/Kconfig                       |  13 +
>>   drivers/thermal/qcom/Makefile                      |   1 +
>>   drivers/thermal/qcom/qmi-cooling.c                 | 520 +++++++++++++++++++++
>>   drivers/thermal/qcom/qmi-cooling.h                 | 428 +++++++++++++++++
>>   10 files changed, 1161 insertions(+), 8 deletions(-)
>> ---
>> base-commit: 9067f80db58bbce81d5f0703aa2fd261e88bc812
>>
>> // Caleb (they/them)
>>
> 

-- 
// Caleb (they/them)
