Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB83166F5F
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2020 06:57:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbgBUF5z (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 21 Feb 2020 00:57:55 -0500
Received: from mail27.static.mailgun.info ([104.130.122.27]:40400 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726331AbgBUF5y (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Feb 2020 00:57:54 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1582264674; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=X2NaiNYDwEsquSBg7TBO8wBDxqN+iwNUppUwtZAbcmI=; b=czmmyRWkjD1pCtUFa7SYS3Z30CDJNpfdFjDIPq9wt6lOpvd292ev0+EGB5orQHY2nHwO+pZx
 f6IOn8mH0y6iU4soTlFQEjHIUHOxrxrpeQoM4dOwSnId0sh9oBbE0yAmjTfM8i3xL4j6PqRy
 nznKzq8fkKNxYLi7Rh/a1lRfCYw=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e4f715a.7fc39fd95f80-smtp-out-n03;
 Fri, 21 Feb 2020 05:57:46 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E25F3C4479F; Fri, 21 Feb 2020 05:57:45 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from [10.206.13.37] (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mkshah)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 19B54C43383;
        Fri, 21 Feb 2020 05:57:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 19B54C43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=mkshah@codeaurora.org
Subject: Re: [PATCH 1/2] dt-bindings: Introduce soc sleep stats bindings for
 Qualcomm SoCs
To:     Stephen Boyd <swboyd@chromium.org>, andy.gross@linaro.org,
        david.brown@linaro.org, linux-arm-msm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        bjorn.andersson@linaro.org, evgreen@chromium.org,
        dianders@chromium.org, rnayak@codeaurora.org, ilina@codeaurora.org,
        lsrao@codeaurora.org, devicetree@vger.kernel.org,
        Mahesh Sivasubramanian <msivasub@codeaurora.org>
References: <20190808061228.16573-1-mkshah@codeaurora.org>
 <20190808061228.16573-2-mkshah@codeaurora.org>
 <5d4c4bb6.1c69fb81.db640.7518@mx.google.com>
From:   Maulik Shah <mkshah@codeaurora.org>
Message-ID: <9b106bc1-572a-a277-c88b-d6960b3cec35@codeaurora.org>
Date:   Fri, 21 Feb 2020 11:27:38 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <5d4c4bb6.1c69fb81.db640.7518@mx.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 8/8/2019 9:50 PM, Stephen Boyd wrote:
> Quoting Maulik Shah (2019-08-07 23:12:27)
>> Add device binding documentation for Qualcomm Technology Inc's (QTI)
>> SoC sleep stats driver. The driver is used for displaying SoC sleep
>> statistic maintained by Always On Processor or Resource Power Manager.
>>
>> Cc: devicetree@vger.kernel.org
>> Signed-off-by: Mahesh Sivasubramanian <msivasub@codeaurora.org>
>> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
>> Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
> Your SoB chain is odd. The author is Mahesh? Otherwise, use the
> Co-Developed-by tag.
corrected in v2.
>> ---
>>   .../bindings/soc/qcom/soc-sleep-stats.txt     | 36 +++++++++++++++++++
>>   1 file changed, 36 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/soc/qcom/soc-sleep-stats.txt
>>
>> diff --git a/Documentation/devicetree/bindings/soc/qcom/soc-sleep-stats.txt b/Documentation/devicetree/bindings/soc/qcom/soc-sleep-stats.txt
>> new file mode 100644
>> index 000000000000..ee40687ded34
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/soc/qcom/soc-sleep-stats.txt
>> @@ -0,0 +1,36 @@
>> +* SoC Sleep Stats
>> +
>> +Always On Processor/Resource Power Manager maintains statistics of the SoC
>> +sleep modes involving lowering or powering down of the backbone rails - Cx
> What is a 'backbone' rail?
done.
>
>> +and Mx and the oscillator clock, XO.
> Drop the comma? XO is the oscillator clock.
done.
>
>> +
>> +Statistics includes SoC sleep mode type, number of times low power mode were
>> +entered, time of last entry, time of last exit and accumulated sleep duration.
>> +SoC Sleep Stats driver provides sysfs interface to display this information.
> Can this document be YAML? Then it can be validated.
converted to YAML in v2.
>
>> +
>> +PROPERTIES
>> +
>> +- compatible:
>> +       Usage: required
>> +       Value type: <string>
>> +       Definition: Should be "qcom,rpmh-sleep-stats" or "qcom,rpm-sleep-stats".
>> +
>> +- reg:
>> +       Usage: required
>> +       Value type: <prop-encoded-array>
>> +       Definition: The base address on the Always On Processor or Resource Power
>> +                   Manager from where the stats are read.
>> +
>> +EXAMPLE 1:
>> +
>> +       rpmh_sleep_stats: soc-sleep-stats@c3f0000 {
>> +               compatible = "qcom,rpmh-sleep-stats";
>> +               reg = <0 0xc3f0000 0 0x400>;
> Is this memory region in DDR? Or some specific IMEM location? I wonder
> if it would be better to just have a pointer from the RPM node to this
> memory region and then populate some stats if so.
Not a DDR.
>
>> +       };
>> +

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
