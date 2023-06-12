Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEB4572CA64
	for <lists+linux-pm@lfdr.de>; Mon, 12 Jun 2023 17:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238171AbjFLPii (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Jun 2023 11:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237415AbjFLPig (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Jun 2023 11:38:36 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3374319C
        for <linux-pm@vger.kernel.org>; Mon, 12 Jun 2023 08:38:35 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b33176880bso8342221fa.3
        for <linux-pm@vger.kernel.org>; Mon, 12 Jun 2023 08:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686584313; x=1689176313;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6j+4xQEH1M/R/NQt831AU88wINq39ctKhdxH/376xe8=;
        b=ZmYcILAuFJRWyFReOLXxXy2Gd7G6ysWJ/yBu6etw7IwytgQPZPqxjDFfvipbfw+GDy
         S3ZAbO83vbSZqdNeyj8b0ilsycbAjw5UzMCaH5RUruPNO99Tc4dTtd8ZkW3RkiseuqnO
         HmvxSZd2HyPJW/OGaXCIPagATwdi58gOees4HyLySflAFBV2D7oVRUon9zDHzIMnpgma
         0TI35pyFvCcD/JIJFye5cTBYyY1VdkhIbf5y2cYvkoi6RDA3Kgtvf0S2+s55PmbDr9jY
         C36u/NJmUhshqu1ecDnhDa9U9mI5n0NYvtalnjAY2h3EttEZfBRfjXc+bdkYlafP4KQz
         kG2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686584313; x=1689176313;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6j+4xQEH1M/R/NQt831AU88wINq39ctKhdxH/376xe8=;
        b=OW9jNxtxntf+9Af/411f6vntRaNcy9jiltJyDv0xsv0qJ/lQXKGJfGZfuN3kjNXrBu
         ylnueWLOgEO+rHU0KAAgr14quRBuSr17tkvh6x7w5xTiFFDnpX/RBCSUowFLwldR58Do
         0/hcKo0FKJBzf4a+RDSipF3ZLwZYNJsZg3aGET4aNfEiLOUg+W3g3NBP7uga/DG7l/ho
         q6ShYixof1W8rq08q2KBKzr21xSUXfpNl8HFUhT8kTSaRNeD5HZjOL82IsPNHqqOZqe1
         /brZiuferoLcbx46YiNKiWmjMiN2ho2rJwlcLACmfYB0cLICAwtRgWzkhRmPFVQHOLzS
         Wq1Q==
X-Gm-Message-State: AC+VfDz5FfcxrxpIeb3tggh0YlkXE6P+Qf+CgO71lkWlmzYDrwibtfIo
        pxI6mSdibCINGxXjeKedKWTJQw==
X-Google-Smtp-Source: ACHHUZ4Teau1vBIt9NE9tpRSAXxSnYawNGGHP0WPg9NHLirIprLF6ye3xlV7W9UxE9+b939q64+g7Q==
X-Received: by 2002:a05:651c:86:b0:2b2:104d:8f89 with SMTP id 6-20020a05651c008600b002b2104d8f89mr3097381ljq.0.1686584313327;
        Mon, 12 Jun 2023 08:38:33 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id i5-20020a2e8085000000b002ad994b0b51sm1812951ljg.16.2023.06.12.08.38.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 08:38:32 -0700 (PDT)
Message-ID: <ced1d731-d39f-5192-ca1d-882b7f3fc322@linaro.org>
Date:   Mon, 12 Jun 2023 18:38:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 15/18] ARM: dts: qcom: apq8064: provide voltage scaling
 tables
Content-Language: en-GB
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-clk@vger.kernel.org,
        Christian Marangi <ansuelsmth@gmail.com>
References: <20230612053922.3284394-1-dmitry.baryshkov@linaro.org>
 <20230612053922.3284394-16-dmitry.baryshkov@linaro.org>
 <ZIbez4RA0OoVfHzt@gerhold.net>
 <8c1085fd-8a73-d192-6624-d4f35728e68a@linaro.org>
 <ZIck0L-gK_a_jCtc@gerhold.net>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <ZIck0L-gK_a_jCtc@gerhold.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12/06/2023 16:59, Stephan Gerhold wrote:
> On Mon, Jun 12, 2023 at 04:33:09PM +0300, Dmitry Baryshkov wrote:
>> On 12/06/2023 12:01, Stephan Gerhold wrote:
>>> On Mon, Jun 12, 2023 at 08:39:19AM +0300, Dmitry Baryshkov wrote:
>>>> APQ8064 has 4 speed bins, each of them having from 4 to 6 categorization
>>>> kinds. Provide tables necessary to handle voltage scaling on this SoC.
>>>>
>>>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>>>> ---
>>>>    arch/arm/boot/dts/qcom-apq8064.dtsi | 1017 +++++++++++++++++++++++++++
>>>>    1 file changed, 1017 insertions(+)
>>>>
>>>> diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
>>>> index 4ef13f3d702b..f35853b59544 100644
>>>> --- a/arch/arm/boot/dts/qcom-apq8064.dtsi
>>>> +++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
>>>> @@ -49,6 +49,9 @@ CPU0: cpu@0 {
>>>>    			clocks = <&kraitcc KRAIT_CPU_0>;
>>>>    			clock-names = "cpu";
>>>>    			clock-latency = <100000>;
>>>> +			vdd-mem-supply = <&pm8921_l24>;
>>>> +			vdd-dig-supply = <&pm8921_s3>;
>>>> +			vdd-core-supply = <&saw0_vreg>;
>>>>    			interconnects = <&kraitcc MASTER_KRAIT_L2 &kraitcc SLAVE_KRAIT_L2>;
>>>>    			operating-points-v2 = <&cpu_opp_table>;
>>>>    			#cooling-cells = <2>;
>>>> @@ -66,6 +69,9 @@ CPU1: cpu@1 {
>>>>    			clocks = <&kraitcc KRAIT_CPU_1>;
>>>>    			clock-names = "cpu";
>>>>    			clock-latency = <100000>;
>>>> +			vdd-mem-supply = <&pm8921_l24>;
>>>> +			vdd-dig-supply = <&pm8921_s3>;
>>>> +			vdd-core-supply = <&saw1_vreg>;
>>>>    			interconnects = <&kraitcc MASTER_KRAIT_L2 &kraitcc SLAVE_KRAIT_L2>;
>>>>    			operating-points-v2 = <&cpu_opp_table>;
>>>>    			#cooling-cells = <2>;
>>>> @@ -83,6 +89,9 @@ CPU2: cpu@2 {
>>>>    			clocks = <&kraitcc KRAIT_CPU_2>;
>>>>    			clock-names = "cpu";
>>>>    			clock-latency = <100000>;
>>>> +			vdd-mem-supply = <&pm8921_l24>;
>>>> +			vdd-dig-supply = <&pm8921_s3>;
>>>> +			vdd-core-supply = <&saw2_vreg>;
>>>>    			interconnects = <&kraitcc MASTER_KRAIT_L2 &kraitcc SLAVE_KRAIT_L2>;
>>>>    			operating-points-v2 = <&cpu_opp_table>;
>>>>    			#cooling-cells = <2>;
>>>> @@ -100,6 +109,9 @@ CPU3: cpu@3 {
>>>>    			clocks = <&kraitcc KRAIT_CPU_3>;
>>>>    			clock-names = "cpu";
>>>>    			clock-latency = <100000>;
>>>> +			vdd-mem-supply = <&pm8921_l24>;
>>>> +			vdd-dig-supply = <&pm8921_s3>;
>>>> +			vdd-core-supply = <&saw3_vreg>;
>>>>    			interconnects = <&kraitcc MASTER_KRAIT_L2 &kraitcc SLAVE_KRAIT_L2>;
>>>>    			operating-points-v2 = <&cpu_opp_table>;
>>>>    			#cooling-cells = <2>;
>>>> @@ -132,6 +144,81 @@ cpu_opp_table: opp-table-cpu {
>>>>    		opp-384000000 {
>>>>    			opp-hz = /bits/ 64 <384000000>;
>>>>    			opp-peak-kBps = <384000>;
>>>> +			opp-microvolt-speed0-pvs0 = <1050000 1050000 1150000>,
>>>> +						    <950000 950000 1150000>,
>>>> +						    <950000 950000 975000>;
>>>

[skipped the OPP voltage vs bw ordering]

>>
>>>
>>> The alternative that I've already argued for on IRC in #linux-msm a
>>> couple of days ago would be to give the L2 cache (here: "interconnect")
>>> an own OPP table where it can describe its voltage requirements,
>>> independent from the CPU. That way the icc_set_bw() would be guaranteed
>>> to apply the correct voltage before adjusting the L2 cache clock. It
>>> looks like the "l2_level" voltages for vdd_dig and vdd_mem are not
>>> speedbin/PVS-specific [2] so this would also significantly reduce the DT
>>> size, since you wouldn't need to repeat the same vdd_dig/vdd_mem
>>> voltages for all of them.
>>
>> Yes. I fact our discussion triggered me to do this patchset.
>>
>> So, another option would be to have something like the following snippet. Do
>> you know if we are allowed to squish additional data into the L2 cache DT
>> node?
>>
> 
> I suspect no one has tried this before, so only the DT maintainers could
> answer this. I would say that it just follows the existing design of
> clocks/-supply/OPPs on the CPU nodes. vdd-mem-supply isn't a property of
> the CPU, it's a property of the L2 cache so it actually fits better there. >
> I think the more controversial questions might be:
> 
>    - Is a L2 cache really an "interconnect"? I suppose one could argue it
>      connects multiple CPU cores to a cluster (similar how a CCI connects
>      multiple clusters to a system).

Yes. This was my reasoning for CBF clock as well as for this L2 clock. 
The separate L2 cache device is also an interconnect from my POV. It 
connects all CPU cores and we have to vote on its frequency.

>    - What would bind to the l2-cache node? A separate driver? Does that
>      work if it sits below the /cpus node?

In the worst case we'd have to populate that manually. E.g. from the 
qcom-cpufreq-nvmem.c

-- 
With best wishes
Dmitry

