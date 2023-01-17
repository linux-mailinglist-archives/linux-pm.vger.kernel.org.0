Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB4E66D47F
	for <lists+linux-pm@lfdr.de>; Tue, 17 Jan 2023 03:44:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235452AbjAQCox (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Jan 2023 21:44:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235788AbjAQCnk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Jan 2023 21:43:40 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 645782FCC2
        for <linux-pm@vger.kernel.org>; Mon, 16 Jan 2023 18:38:34 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id q10so9842362wrs.2
        for <linux-pm@vger.kernel.org>; Mon, 16 Jan 2023 18:38:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NN7ra9RM5RwWoUr/tsRU6zWH7d53cck2M9uCu21ulu0=;
        b=Oab9zK27rpgas0uCStmMiykRixxSbqgEkfw41hgaNMTL3tWA/9pi5puiL/ERXYkLpY
         47CVxZnDTCYkPZYPSRRJtwc2YEPI2H8WG04kN/t0Yj7L8Y9VCdPsL0JbZgU4Y61r5BP7
         aI2tvd6ObvUqLjXmHJrdE6l49kAt4Q9e4kyb2C7DgrtVXS8lZfhzp/PW/bK1eUHcMxKh
         X0b15FwntkLtmhjqK5URNhh/7EG/7EJfWfVq2reEB+dc65bjju+Ns4noGV1tO/jClh/p
         tuHzdKSruPdk1ivcgcMG6kVLQSGD4bxz/xcpDV89E7ryXofXsqkiV2n5G/F/L55GAkC9
         EaqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NN7ra9RM5RwWoUr/tsRU6zWH7d53cck2M9uCu21ulu0=;
        b=dctSFJQwMzd4ykauv9AUJoig8lhWTHFk8oEf40QfuxFd8ZQASKMDrCnrou9r+dvB7g
         yqWcCy25Z7O4aPJUO1Fe41kes33V2hL00ooSRzBqlt0kz1a2TZOFLCj7o9mekMWQuueK
         A8oNbp9ndKH0ffOV12HOKu5nlp8LJLLjkIqTy0G0Rb3WWQ9CNXMAE+x/BoGznWbrh2HZ
         geLjD6sj/OUQAjokepKXVtVBblKM4Nir23lP0dz+Tl0PesBS4cvMCONQx3I83DHGOxr9
         SridMNsUcaEU9X6lFByjVzfWYlPxMScoF76T7uMlmJhNjCmNW7YYGhbRyrLvRIKGQ+zJ
         w45g==
X-Gm-Message-State: AFqh2kpGGBa82LvRkKFwzNSAxwglA/9nDfsco8eVquxt9aZoA12MeF8K
        nS4mHu6j21IuhPFY8wIFxcqsdw==
X-Google-Smtp-Source: AMrXdXt/uADrirudTtbLAThIF7D33RBC/uAACiFdsfTZOuuirWxs/Jfbl29q/QJSTS1dIZHczsAv2g==
X-Received: by 2002:a5d:4e51:0:b0:2bd:f5df:2696 with SMTP id r17-20020a5d4e51000000b002bdf5df2696mr1122371wrt.67.1673923049035;
        Mon, 16 Jan 2023 18:37:29 -0800 (PST)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id f2-20020adff982000000b002bde537721dsm9634581wrr.20.2023.01.16.18.37.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jan 2023 18:37:28 -0800 (PST)
Message-ID: <c1e3db0d-7593-b0fc-043b-60538faf9ba2@linaro.org>
Date:   Tue, 17 Jan 2023 02:37:27 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 0/4] soc: qcom: Introduce PMIC GLINK
Content-Language: en-US
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Subbaraman Narayanamurthy <quic_subbaram@quicinc.com>,
        Johan Hovold <johan@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
References: <20230113041132.4189268-1-quic_bjorande@quicinc.com>
 <9e831252-7198-7983-8a52-0e745688452d@linaro.org>
 <20230117023238.GB2350793@hu-bjorande-lv.qualcomm.com>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20230117023238.GB2350793@hu-bjorande-lv.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 17/01/2023 02:32, Bjorn Andersson wrote:
> On Fri, Jan 13, 2023 at 05:10:17PM +0000, Bryan O'Donoghue wrote:
>> On 13/01/2023 04:11, Bjorn Andersson wrote:
>>> This implements the base PMIC GLINK driver, a power_supply driver and a
>>> driver for the USB Type-C altmode protocol. This has been tested and
>>> shown to provide battery information, USB Type-C switch and mux requests
>>> and DisplayPort notifications on SC8180X, SC8280XP and SM8350.
>>>
>>> Bjorn Andersson (4):
>>>     dt-bindings: soc: qcom: Introduce PMIC GLINK binding
>>>     soc: qcom: pmic_glink: Introduce base PMIC GLINK driver
>>>     soc: qcom: pmic_glink: Introduce altmode support
>>>     power: supply: Introduce Qualcomm PMIC GLINK power supply
>>>
>>>    .../bindings/soc/qcom/qcom,pmic-glink.yaml    |  102 ++
>>>    drivers/power/supply/Kconfig                  |    9 +
>>>    drivers/power/supply/Makefile                 |    1 +
>>>    drivers/power/supply/qcom_battmgr.c           | 1421 +++++++++++++++++
>>>    drivers/soc/qcom/Kconfig                      |   15 +
>>>    drivers/soc/qcom/Makefile                     |    2 +
>>>    drivers/soc/qcom/pmic_glink.c                 |  336 ++++
>>>    drivers/soc/qcom/pmic_glink_altmode.c         |  477 ++++++
>>>    include/linux/soc/qcom/pmic_glink.h           |   32 +
>>>    9 files changed, 2395 insertions(+)
>>>    create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml
>>>    create mode 100644 drivers/power/supply/qcom_battmgr.c
>>>    create mode 100644 drivers/soc/qcom/pmic_glink.c
>>>    create mode 100644 drivers/soc/qcom/pmic_glink_altmode.c
>>>    create mode 100644 include/linux/soc/qcom/pmic_glink.h
>>>
>>
>> How does the USB PHY and a USB redriver fit into this ?
>>
>> Is the host supposed to manage both/neither ? Is the DSP responsible for
>> configuring the PHY lanes and the turnaround on orientation switch ?
>>
> 
> As indicated above, the firmware deals with battery management and USB
> Type-C handling.
> 
> The battery/power management is handled by the battmgr implementation,
> exposing the various properties through a set of power_supply objects.
> 
> The USB Type-C handling comes in two forms. The "altmode" protocol
> handles DisplayPort notifications - plug detect, orientation and mode
> switches. The other part of the USB implementation exposes UCSI.
> 
> The altmode implementation provides two things:
> - A drm_bridge, per connector, which can be tied (of_graph) to a
>    DisplayPort instance, and will invoke HPD notifications on the
>    drm_bridge, based on notification messages thereof.
> 
> - Acquire typec_switch and typec_mux handles through the of_graph and
>    signal the remotes when notifications of state changes occur. Linking
>    this to the FSA4480, is sufficient to get USB/DP combo (2+2 lanes)
>    working on e.g. SM8350 HDK.
>    Work in progress patches also exists for teaching QMP about
>    orientation switching of the SS lines, but it seems this needs to be
>    rebased onto the refactored QMP driver.
>    I also have patches for QMP to make it switch USB/DP combo -> 4-lane
>    DP, which allow 4k support without DSC, unfortunately switch back to
>    USB has not been fully reliable, so this requires some more work
>    (downstream involves DWC3 here as well, to reprogram the PHY).

Oki doki that makes sense and is pretty much in-line with what I thought.

We still have a bunch of typec-mux and phy work to do even with 
adsp/glink doing the TCPM.

Thanks for the explanation.

---
bod

