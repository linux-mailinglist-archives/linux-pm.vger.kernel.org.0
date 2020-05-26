Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 563591E27F6
	for <lists+linux-pm@lfdr.de>; Tue, 26 May 2020 19:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728523AbgEZRIq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 May 2020 13:08:46 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:53339 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728546AbgEZRIo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 May 2020 13:08:44 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1590512922; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=E/TUuzUpjVlMjRqaJlVv+mTsnkBZEql2N8QaKUXAGtk=; b=e8gccUiPCEjm5ua9uSxGG7C1hRvfNmZ4Iwfn9drNYpV5WW/OSwiMzpBFaIhtQamHQ6rPUhrQ
 buzYU4k7vbA9yn2dE+LcQupNKDRcvXNVFSnFdRE6U7Klu7fCGEJPyQI5uRnUVCytSdX66cRh
 3KAevM9lJ8dSTWOcUj0G8hQ2u+4=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 5ecd4d09809d904967469b2e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 26 May 2020 17:08:25
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 49A03C433C6; Tue, 26 May 2020 17:08:25 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from [10.79.43.230] (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BCC43C433C9;
        Tue, 26 May 2020 17:08:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BCC43C433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
Subject: Re: [PATCH v8 09/10] dt-bindings: interconnect: Add interconnect-tags
 bindings
To:     Saravana Kannan <saravanak@google.com>,
        Georgi Djakov <georgi.djakov@linaro.org>
Cc:     Rob Herring <robh@kernel.org>, Viresh Kumar <vireshk@kernel.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Evan Green <evgreen@chromium.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
References: <20200512125327.1868-1-georgi.djakov@linaro.org>
 <20200512125327.1868-10-georgi.djakov@linaro.org>
 <20200519185836.GA469006@bogus>
 <CAGETcx8+NZYT863ySLf6XvgLBm8PM_4euue2=zbDscgmDFh+7g@mail.gmail.com>
 <3a392629be195fa6bebca18309efffab@codeaurora.org>
 <CAGETcx9a=9pMonfyoNGqkkfaDwJ+=U6OqK1op5UYM2zQbktsXQ@mail.gmail.com>
From:   Sibi Sankar <sibis@codeaurora.org>
Message-ID: <7eed4379-618c-46b6-3b3e-2e4c0334bf2e@codeaurora.org>
Date:   Tue, 26 May 2020 22:38:09 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAGETcx9a=9pMonfyoNGqkkfaDwJ+=U6OqK1op5UYM2zQbktsXQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 5/21/20 12:43 AM, Saravana Kannan wrote:
> On Wed, May 20, 2020 at 11:51 AM Sibi Sankar <sibis@codeaurora.org> wrote:
>>
>> On 2020-05-20 01:27, Saravana Kannan wrote:
>>> On Tue, May 19, 2020 at 11:58 AM Rob Herring <robh@kernel.org> wrote:
>>>>
>>>> On Tue, May 12, 2020 at 03:53:26PM +0300, Georgi Djakov wrote:
>>>>> From: Sibi Sankar <sibis@codeaurora.org>
>>>>>
>>>>> Add interconnect-tags bindings to enable passing of optional
>>>>> tag information to the interconnect framework.
>>>>>
>>>>> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
>>>>> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
>>>>> ---
>>>>> v8:
>>>>> * New patch, picked from here:
>>>>>    https://lore.kernel.org/r/20200504202243.5476-10-sibis@codeaurora.org
>>>>>
>>>>>   .../devicetree/bindings/interconnect/interconnect.txt        | 5 +++++
>>>>>   1 file changed, 5 insertions(+)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/interconnect/interconnect.txt b/Documentation/devicetree/bindings/interconnect/interconnect.txt
>>>>> index 6f5d23a605b7..c1a226a934e5 100644
>>>>> --- a/Documentation/devicetree/bindings/interconnect/interconnect.txt
>>>>> +++ b/Documentation/devicetree/bindings/interconnect/interconnect.txt
>>>>> @@ -55,6 +55,11 @@ interconnect-names : List of interconnect path name strings sorted in the same
>>>>>                         * dma-mem: Path from the device to the main memory of
>>>>>                                    the system
>>>>>
>>>>> +interconnect-tags : List of interconnect path tags sorted in the same order as the
>>>>> +                 interconnects property. Consumers can append a specific tag to
>>>>> +                 the path and pass this information to the interconnect framework
>>>>> +                 to do aggregation based on the attached tag.
>>>>
>>>> Why isn't this information in the 'interconnect' arg cells?
>>>>
>>>> We have 'interconnect-names' because strings don't mix with cells. An
>>>> expanding list of 'interconnect-.*' is not a good pattern IMO.
>>
>> Rob,
>> Currently the interconnect paths
>> assume a default tag and only few
>> icc paths require tags that differ
>> from the default ones. Encoding the
>> tags in the interconnect arg cells
>> would force all paths to specify
>> the tags. I guess that's okay.
> 
> I think that's the right thing. Those cells are meant to be "args" to
> the provider.

diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi 
b/arch/arm64/boot/dts/qcom/sc7180.dtsi

index ea4764f06a901..b34f024d4ab63 100644

--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi

+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi

@@ -132,9 +132,8 @@ &LITTLE_CPU_SLEEP_1

                         capacity-dmips-mhz = <1024>;

                         dynamic-power-coefficient = <100>;

                         operating-points-v2 = <&cpu0_opp_table>;

-                       interconnects = <&gem_noc MASTER_APPSS_PROC 
&mc_virt SLAVE_EBI1>,

+                       interconnects = <&gem_noc MASTER_APPSS_PROC 3 
&mc_virt SLAVE_EBI1 3>,

                                         <&osm_l3 MASTER_OSM_L3_APPS 
&osm_l3 SLAVE_OSM_L3>;

                         next-level-cache = <&L2_0>;

                         #cooling-cells = <2>;

                         qcom,freq-domain = <&cpufreq_hw 0>;



....

                 mc_virt: interconnect@1638000 {

                         compatible = "qcom,sc7180-mc-virt";

                         reg = <0 0x01638000 0 0x1000>;

-                       #interconnect-cells = <1>;

+                       #interconnect-cells = <2>;

                         qcom,bcm-voters = <&apps_bcm_voter>;

                 };

....



@@ -2216,14 +2208,14 @@ system-cache-controller@9200000 {

                 gem_noc: interconnect@9680000 {

                         compatible = "qcom,sc7180-gem-noc";

                         reg = <0 0x09680000 0 0x3e200>;

-                       #interconnect-cells = <1>;

+                       #interconnect-cells = <2>;

                         qcom,bcm-voters = <&apps_bcm_voter>;

                 };

....



diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c

index 294e9c58565bb..6a7a785bd90b9 100644

--- a/drivers/interconnect/core.c

+++ b/drivers/interconnect/core.c

@@ -340,7 +340,7 @@ static struct icc_node 
*of_icc_get_from_provider(struct of_phandle_args *spec)

         struct icc_node *node = ERR_PTR(-EPROBE_DEFER);

         struct icc_provider *provider;



-       if (!spec || spec->args_count != 1)

+       if (!spec || spec->args_count < 1)

                 return ERR_PTR(-EINVAL);



         mutex_lock(&icc_lock);

@@ -469,6 +469,9 @@ struct icc_path *of_icc_get_by_index(struct device 
*dev, int idx)

                 return ERR_PTR(-ENOMEM);

         }



+       if (src_args.args_count == 2)

+               icc_set_tag(path, src_args.args[1]);

diff: https://paste.ubuntu.com/p/sRRYhxQjsV/

Saravana/Georgi,
A few concerns here, I feel tag info as the second arg to the provider
may not be true for all socs. Does introducing soc specific of_icc_get
functions make sense?

> 
>>>
>>> Also, is there an example for interconnect-tags that I missed? Is it a
>>> list of strings, numbers, etc?
>>
>> Saravana,
>> https://patchwork.kernel.org/patch/11527589/
>> ^^ is an example of interconnect-tag useage.
> 
> If we actually merge interconnect-tags, I think the doc should be
> updated. Instead of having to grep around.
> 
> -Saravana
> 

-- 
Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc, is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
