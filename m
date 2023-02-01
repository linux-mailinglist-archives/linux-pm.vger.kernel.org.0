Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 362B868658A
	for <lists+linux-pm@lfdr.de>; Wed,  1 Feb 2023 12:46:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbjBALqc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Feb 2023 06:46:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbjBALqc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Feb 2023 06:46:32 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5638B530FD
        for <linux-pm@vger.kernel.org>; Wed,  1 Feb 2023 03:46:28 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id d14so17031212wrr.9
        for <linux-pm@vger.kernel.org>; Wed, 01 Feb 2023 03:46:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/oez8AUAftX1zJ0SA+UvNi7X27OzDC/qlpA3BbcU7l0=;
        b=Cdn+s0ZE6QVu4mi+Ioq2kDUpND2AT6VZIpijAz89k2wX9cHp5G+LbQqWU+DiL1vf8k
         o4lpBAquerK3vfIu1VuTov4Kc21afSZkD9SCq9IMomSk9Ky1b2sv3LT1X0D/iSSyxPoM
         am1MIdgMKfOAfD0RNwkHcmfjiRJ92p7N9IollD3vCoASRSTm7Ablz8/K7X0Pjyg9Fvfa
         qXpvt5UEg6UbgcaTXDq2BlnM3XvtrptXSAYTggUED5DxT2P7RZyA07Xg9BDlM2J7G6NT
         sSeUzXkz1LbYeXIPK9espZGOhyfkoYZfDOQJW8F9E5HfhnWQsFr+ifm6Zcd/YH4HGnLM
         /+oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/oez8AUAftX1zJ0SA+UvNi7X27OzDC/qlpA3BbcU7l0=;
        b=L6eatUr/CpQyDjOJ6trB9oYVCNniKZ2M0FHkm4WEXhGJ/D6r6tSkkVW0QcV+m7/TG6
         be+wrKA4EKBF+4iPfxk73aIv7nL8l3JGy2WMDUfMdC50U71jVgrCNgy5wu6bCwh6Mfqw
         95zmRDPar3+WLfDk+dFo0/dcCgY95j0iyROs+GREkkwCaJF3iWU/dGCcZmIIDxG1gj8i
         IJp5IZmbSKn1KSDifUiyPxZzNOR1yNJgoBMrw3MwS3HyIoyfvHLadiiB+4IBpV7v0k/B
         0L5IlF+aieuCzKhvjPwqADc+2arDR4RYnsaeBtEeZ+6BMXCeBxNqe9ldZea0Yh6fwsfL
         Ptig==
X-Gm-Message-State: AO0yUKWDeGcRtKSgxUpTdKWr+IgwnfV+SJmXkh/I5N2yqrTa7Chjafuh
        LGFq32UQlW/EBsiCi1eKNUeJCw==
X-Google-Smtp-Source: AK7set8S6wL8+KxPQDIovLNftJR31PT8NwmtUAnAWXTN7UmhNXqTDH+yUHKWTSmGb+Wp4n5lJLs5mQ==
X-Received: by 2002:a5d:4352:0:b0:2be:12a8:9f75 with SMTP id u18-20020a5d4352000000b002be12a89f75mr1770411wrr.55.1675251986695;
        Wed, 01 Feb 2023 03:46:26 -0800 (PST)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id q3-20020adff503000000b002bfae1398bbsm17665550wro.42.2023.02.01.03.46.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Feb 2023 03:46:26 -0800 (PST)
Message-ID: <71ba0d05-6183-95ef-9e45-cc3dd512475f@linaro.org>
Date:   Wed, 1 Feb 2023 11:46:25 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 2/2] PM / devfreq: qcom: Introduce CCI devfreq driver
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jun Nie <jun.nie@linaro.org>, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, cw00.choi@samsung.com
Cc:     bryan.odonoghue@linaro.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
References: <20230201080227.473547-1-jun.nie@linaro.org>
 <20230201080227.473547-2-jun.nie@linaro.org>
 <515f4e9e-2804-e03a-26f5-f2d3ac331109@linaro.org>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <515f4e9e-2804-e03a-26f5-f2d3ac331109@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 01/02/2023 11:32, Dmitry Baryshkov wrote:
> On 01/02/2023 10:02, Jun Nie wrote:
>> Cache Coherent Interconnect (CCI) is used by some Qualcomm SoCs. This
>> driver is introduced so that its freqency can be adjusted. And regulator
>> associated with opp table can be also adjusted accordingly which is
>> shared with cpu cluster.
>>
>> Signed-off-by: Jun Nie <jun.nie@linaro.org>
>> ---
>>   drivers/devfreq/Kconfig    |   9 +++
>>   drivers/devfreq/Makefile   |   1 +
>>   drivers/devfreq/qcom-cci.c | 162 +++++++++++++++++++++++++++++++++++++
>>   3 files changed, 172 insertions(+)
>>   create mode 100644 drivers/devfreq/qcom-cci.c
> 
> Could you please describe in some additional details what are you trying 
> to achieve? Should the CCI frequency be scaled manually or does it 
> follow the cluster frequency? Do clusters vote on the CCI frequency?
> 
> I'm inclined to ask if it is possible to shift this to the cpufreq OPP 
> tables?
> 

Might not be so easy to just append CCI opps to the cluster frequency opps

                 cci_cache: qcom,cci {
                         compatible = "qcom,msm8939-cci";
                         clock-names = "devfreq_clk";
                         clocks = <&apcs2>;
                         governor = "cpufreq";
                         operating-points-v2 = <&cci_opp_table>;
                         power-domains = <&cpr>;
                         power-domain-names = "cpr";
                         nvmem-cells = <&cpr_efuse_speedbin_pvs>;
                         nvmem-cell-names = "cpr_efuse_speedbin_pvs";
                 };

                 devfreq-cpufreq {
                         cci-cpufreq {
                                 target-dev = <&cci_cache>;
                                 cpu-to-dev-map-0 =
                                         <  200000  200000000 >,
                                         <  345600  200000000 >,
                                         <  400000  200000000 >,
                                         <  533330  297600000 >,
                                         <  800000  297600000 >,
                                         <  960000  297600000 >,
                                         < 1113600  297000000 >,
                                         < 1344000  595200000 >,
                                         < 1459200  595200000 >,
                                         < 1497600  595200000 >,
                                         < 1651200  595200000 >;
                                 cpu-to-dev-map-4 =
                                         <  200000 200000000 >,
                                         <  249600 200000000 >,
                                         <  499200 297600000 >,
                                         <  800000 297600000 >,
                                         <  998400 595200000 >,
                                         < 1113600 595200000 >;
                         };
                 };

         cci_opp_table: cci-opp-table {
                 compatible = "operating-points-v2";

                 opp-200000000 {
                         opp-hz = /bits/ 64 <200000000>;
                         opp-supported-hw = <0x3f>;
                         required-opps = <&cpr_opp3>;
                 };

                 opp-297600000 {
                         opp-hz = /bits/ 64 <297600000>;
                         opp-supported-hw = <0x3f>;
                         required-opps = <&cpr_opp12>;
                 };

                 opp-400000000-cpr14 {
                         opp-hz = /bits/ 64 <400000000>;
                         opp-supported-hw = <0x1>;
                         required-opps = <&cpr_opp14>;
                 };

                 opp-400000000-cpr15 {
                         opp-hz = /bits/ 64 <400000000>;
                         opp-supported-hw = <0x3e>;
                         required-opps = <&cpr_opp15>;
                 };

                 opp-595200000 {
                         opp-hz = /bits/ 64 <595200000>;
                         opp-supported-hw = <0x3f>;
                         required-opps = <&cpr_opp17>;
                 };
         };


         cpr_opp_table: cpr-opp-table {
                 compatible = "operating-points-v2-qcom-level";

                 cpr_opp1: opp1 {
                         opp-hz = /bits/ 64 <200000000>;
                         opp-level = <1>;
                         qcom,opp-fuse-level = <1>;
                 };
                 cpr_opp2: opp2 {
                         opp-hz = /bits/ 64 <345600000>;
                         opp-level = <2>;
                         qcom,opp-fuse-level = <1>;
                 };
                 cpr_opp3: opp3 {
                         opp-hz = /bits/ 64 <400000000>;
                         opp-level = <3>;
                         qcom,opp-fuse-level = <1>;
                 };
                 cpr_opp4: opp4 {
                         opp-hz = /bits/ 64 <422400000>;
                         opp-level = <4>;
                         qcom,opp-fuse-level = <2>;
                 };
                 cpr_opp5: opp5 {
                         opp-hz = /bits/ 64 <499200000>;
                         opp-level = <5>;
                         qcom,opp-fuse-level = <2>;
                 };
                 cpr_opp6: opp6 {
                         opp-hz = /bits/ 64 <533330000>;
                         opp-level = <6>;
                         qcom,opp-fuse-level = <2>;
                 };
                 cpr_opp7: opp7 {
                         opp-hz = /bits/ 64 <652800000>;
                         opp-level = <7>;
                         qcom,opp-fuse-level = <2>;
                 };
                 cpr_opp8: opp8 {
                         opp-hz = /bits/ 64 <729600000>;
                         opp-level = <8>;
                         qcom,opp-fuse-level = <2>;
                 };
                 cpr_opp9: opp9 {
                         opp-hz = /bits/ 64 <800000000>;
                         opp-level = <9>;
                         qcom,opp-fuse-level = <2>;
                 };
                 cpr_opp10: opp10 {
                         opp-hz = /bits/ 64 <806400000>;
                         opp-level = <10>;
                         qcom,opp-fuse-level = <2>;
                 };
                 cpr_opp11: opp11 {
                         opp-hz = /bits/ 64 <883200000>;
                         opp-level = <11>;
                         qcom,opp-fuse-level = <2>;
                 };
                 cpr_opp12: opp12 {
                         opp-hz = /bits/ 64 <960000000>;
                         opp-level = <12>;
                         qcom,opp-fuse-level = <2>;
                 };
         };

---
bod
