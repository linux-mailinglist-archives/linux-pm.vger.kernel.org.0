Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B63C67359B
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jul 2019 19:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728284AbfGXRe3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Jul 2019 13:34:29 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:41064 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbfGXRe3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Jul 2019 13:34:29 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 19FE260850; Wed, 24 Jul 2019 17:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1563988981;
        bh=vSXvWkVwtHyHIwWUq+YF/QA1K+5/2Kp0EBP1AfqkbhI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ahaf0mBKbTF+F1aeJUQ79kAK029bTV05MMJUx6I25xzFFVkbqPodr7nhHfiCuHfcj
         z1bAYe3rMsxMMN3BlMpwB9UR0xVvbTD72R3dYcd8dQfZ6clZOERjwJt5tWYuMdfwNX
         Df2osXI7bUgqz8Evv1f3HCiQA0tkPDyrUc9SlyGA=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from [10.46.162.237] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: daidavid1@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5439B602FC;
        Wed, 24 Jul 2019 17:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1563988979;
        bh=vSXvWkVwtHyHIwWUq+YF/QA1K+5/2Kp0EBP1AfqkbhI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=YRiSSkVp3Wv93Z7oE+oJRIxrX2AUGkwjCFkS/7vr09crL6MtezV8F4R3jTbbGjSFA
         FP6Lp7c2I/FkaVIkXVmK77hA22QLFJ9tey92w3lTLJeBp94rRYZaMOoNcrXlyKEsbP
         3xW6iuqoARl0wlfW4VkjYwajnGjfNTuTyhfMeg9U=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5439B602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=daidavid1@codeaurora.org
Subject: Re: [PATCH 1/2] dt-bindings: interconnect: Update Qualcomm SDM845 DT
 bindings
To:     Stephen Boyd <swboyd@chromium.org>, bjorn.andersson@linaro.org,
        georgi.djakov@linaro.org, robh+dt@kernel.org
Cc:     evgreen@google.com, ilina@codeaurora.org, seansw@qti.qualcomm.com,
        elder@linaro.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <1563568344-1274-1-git-send-email-daidavid1@codeaurora.org>
 <1563568344-1274-2-git-send-email-daidavid1@codeaurora.org>
 <5d371ce7.1c69fb81.9650.8239@mx.google.com>
 <8c181f08-559b-5d77-a617-65cfd3d5da55@codeaurora.org>
 <5d3868a9.1c69fb81.876aa.ac30@mx.google.com>
From:   David Dai <daidavid1@codeaurora.org>
Message-ID: <8efd5c48-5d3a-97e1-1dec-6a9cdc4c8ef6@codeaurora.org>
Date:   Wed, 24 Jul 2019 10:22:57 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <5d3868a9.1c69fb81.876aa.ac30@mx.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 7/24/2019 7:18 AM, Stephen Boyd wrote:
> Quoting David Dai (2019-07-23 14:48:42)
>> On 7/23/2019 7:42 AM, Stephen Boyd wrote:
>>> Quoting David Dai (2019-07-19 13:32:23)
>>>> +- compatible : shall contain only one of the following:
>>>> +                       "qcom,sdm845-bcm-voter",
>>>> +
>>>> +Examples:
>>>> +
>>>> +apps_rsc: rsc@179c0000 {
>>> But there isn't a reg property.
>> I'll change this to the generic example with just apps_rsc: rsc {
>>>> +       label = "apps_rsc";
>>> Is label required?
> Any answer?
Not required.
>>>> +       compatible = "qcom,rpmh-rsc";
>>>> +
>>>> +       apps_bcm_voter: bcm_voter {
>>>> +               compatible = "qcom,sdm845-bcm-voter";
>>>> +       };
>>>> +}
>>>> +
>>>> +disp_rsc: rsc@179d0000 {
>>>> +       label = "disp_rsc";
>>>> +       compatible = "qcom,rpmh-rsc";
>>>> +
>>>> +       disp_bcm_voter: bcm_voter {
>>>> +               compatible = "qcom,sdm845-bcm-voter";
>>>> +       };
>>>> +}
>>>> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,sdm845.txt b/Documentation/devicetree/bindings/interconnect/qcom,sdm845.txt
>>>> index 5c4f1d9..27f9ed9 100644
>>>> --- a/Documentation/devicetree/bindings/interconnect/qcom,sdm845.txt
>>>> +++ b/Documentation/devicetree/bindings/interconnect/qcom,sdm845.txt
> [...]
>>>> +
>>>> +mem_noc: interconnect@1380000 {
>>>> +       compatible = "qcom,sdm845-mem_noc";
>>>> +       reg = <0 0x1380000 0 0x27200>;
>>>> +       #interconnect-cells = <1>;
>>>> +       qcom,bcm-voter = <&apps_bcm_voter>, <&disp_bcm_voter>;
>>>> +};
>>> How does a consumer target a particular RSC? For example, how can
>>> display decide to use the disp_bcm_voter node from mem_noc here? Maybe
>>> you can add that consumer to the example?
>> I was thinking that the association between the bcm voters and the icc
>> nodes would be handled by the interconnect provider, and that there
>> would be a set of display specific icc nodes with their own unique IDs
>> that the consumers could reference. I will mention this as part of the
>> description and provide an example.
>>
>> Ex: interconnects = <&mmss_noc MASTER_MDP0_DISP &mem_noc SLAVE_EBI_DISP>;
>>
> It looks backwards to me. Don't the consumers want to consume a
> particular RSC, i.e. apps or display RSC, so they can choose where to
> put the bcm vote and then those RSCs want to find MMIO registers for
> mmss_noc or mem_noc that they have to write to tune something else like
> QoS? If the MMIO space is the provider then I'm lost how it can
> differentiate between the RSCs that may be targetting the particular
> NoC.
The way that I view this is that the consumers consume both bandwidth 
and QoS from these physical NoC devices by getting some path between two 
endpoints on these different NoCs and applying some constraints. The NoC 
providers can accomplish that either by writing to MMIO spaces or by 
talking to some remote processor/hardware to tune its clock speed. The 
consumer doesn't interact with the RSCs directly, but can select a 
different bcm voter based on the endpoints that are associated with a 
particular bcm(apps or disp rsc). Each node(endpoints) will have its own 
BCM designation and an unique bcm voter.
> Maybe I've just completely missed something and this is all decided
> already. If so, sorry, I'm just trying to understand.
No problem, this just means I need to do a better job of explaining.

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

