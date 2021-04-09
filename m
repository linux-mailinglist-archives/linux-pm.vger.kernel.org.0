Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 805E9359786
	for <lists+linux-pm@lfdr.de>; Fri,  9 Apr 2021 10:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbhDIITO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Apr 2021 04:19:14 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:30116 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229545AbhDIITO (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 9 Apr 2021 04:19:14 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1617956342; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=UM9uhxnzJhVi5iLX05PsBl0YNEH1zzB5iVkmTJT1W5c=;
 b=D5eZU60b9L9N14NpAb//VIUBoiENpQh5lXCh/fMpaDPSSIqWAeUTXTGEpZKHk8lAblOSqfwh
 A8wjKNS3UN+pWgVHv9BItveszLxsueCJsYP1abVDMy79hU86XDFpJlylz51K5YBaf9vtRAhi
 ZbEH9uSI8BqCtmaKybSZCjMzT40=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 60700df38807bcde1df43cb7 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 09 Apr 2021 08:18:59
 GMT
Sender: skakit=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id CF88CC43463; Fri,  9 Apr 2021 08:18:59 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: skakit)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 81100C433CA;
        Fri,  9 Apr 2021 08:18:58 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 09 Apr 2021 13:48:58 +0530
From:   skakit@codeaurora.org
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        David Collins <collinsd@codeaurora.org>, kgunda@codeaurora.org,
        Vinod Koul <vkoul@kernel.org>,
        Courtney Cavin <courtney.cavin@sonymobile.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH V2 3/4] dt-bindings: power: reset: qcom-pon: Convert qcom
 PON binding to yaml
In-Reply-To: <20210408130001.k3qbq3vvwkiyykzv@earth.universe>
References: <1617881469-31965-1-git-send-email-skakit@codeaurora.org>
 <1617881469-31965-4-git-send-email-skakit@codeaurora.org>
 <20210408130001.k3qbq3vvwkiyykzv@earth.universe>
Message-ID: <0cb9b3503000ac7206f4a3ef5fd16c17@codeaurora.org>
X-Sender: skakit@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Sebastian,

On 2021-04-08 18:30, Sebastian Reichel wrote:
> Hi,
> 
> On Thu, Apr 08, 2021 at 05:01:08PM +0530, satya priya wrote:
>> Convert qcom PON binding from .txt to .yaml format.
>> 
>> Signed-off-by: satya priya <skakit@codeaurora.org>
>> ---
> 
> Thanks for doing this.
> 
>> Changes in V2:
>>  - As per Rob's comments, converted the main PON binding and added in 
>> V2.
>> 
>>  .../devicetree/bindings/power/reset/qcom,pon.txt   | 49 
>> ----------------------
>>  .../devicetree/bindings/power/reset/qcom,pon.yaml  | 41 
>> ++++++++++++++++++
>>  2 files changed, 41 insertions(+), 49 deletions(-)
>>  delete mode 100644 
>> Documentation/devicetree/bindings/power/reset/qcom,pon.txt
>>  create mode 100644 
>> Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
>> 
>> diff --git 
>> a/Documentation/devicetree/bindings/power/reset/qcom,pon.txt 
>> b/Documentation/devicetree/bindings/power/reset/qcom,pon.txt
>> deleted file mode 100644
>> index 0c0dc3a..0000000
>> --- a/Documentation/devicetree/bindings/power/reset/qcom,pon.txt
>> +++ /dev/null
>> @@ -1,49 +0,0 @@
>> -Qualcomm PON Device
>> -
>> -The Power On device for Qualcomm PM8xxx is MFD supporting pwrkey
>> -and resin along with the Android reboot-mode.
>> -
>> -This DT node has pwrkey and resin as sub nodes.
>> -
>> -Required Properties:
>> --compatible: Must be one of:
>> -	"qcom,pm8916-pon"
>> -	"qcom,pms405-pon"
>> -	"qcom,pm8998-pon"
>> -
>> --reg: Specifies the physical address of the pon register
>> -
>> -Optional subnode:
>> --pwrkey: Specifies the subnode pwrkey and should follow the
>> - qcom,pm8941-pwrkey.txt description.
>> --resin: Specifies the subnode resin and should follow the
>> - qcom,pm8xxx-pwrkey.txt description.
>> -
>> -The rest of the properties should follow the generic reboot-mode 
>> description
>> -found in reboot-mode.txt
>> -
>> -Example:
>> -
>> -	pon@800 {
>> -		compatible = "qcom,pm8916-pon";
>> -
>> -		reg = <0x800>;
>> -		mode-bootloader = <0x2>;
>> -		mode-recovery = <0x1>;
>> -
>> -		pwrkey {
>> -			compatible = "qcom,pm8941-pwrkey";
>> -			interrupts = <0x0 0x8 0 IRQ_TYPE_EDGE_BOTH>;
>> -			debounce = <15625>;
>> -			bias-pull-up;
>> -			linux,code = <KEY_POWER>;
>> -		};
>> -
>> -		resin {
>> -			compatible = "qcom,pm8941-resin";
>> -			interrupts = <0x0 0x8 1 IRQ_TYPE_EDGE_BOTH>;
>> -			debounce = <15625>;
>> -			bias-pull-up;
>> -			linux,code = <KEY_VOLUMEDOWN>;
>> -		};
>> -	};
>> diff --git 
>> a/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml 
>> b/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
>> new file mode 100644
>> index 0000000..40eea5f1
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
>> @@ -0,0 +1,41 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/power/reset/qcom,pon.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Qualcomm PON Device
>> +
>> +maintainers:
>> +  - Vinod Koul <vkoul@kernel.org>
>> +
>> +description: |
>> +  The Power On device for Qualcomm PM8xxx is MFD supporting pwrkey
>> +  and resin along with the Android reboot-mode.
>> +
>> +  This DT node has pwrkey and resin as sub nodes.
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - qcom,pm8916-pon
>> +      - qcom,pms405-pon
>> +      - qcom,pm8998-pon
>> +
>> +  reg:
>> +    description: Specifies the physical address of the pon register
> 
> That description is obvious and pointless. Instead add
> 
> maxItems: 1
> 

Okay.

>> +  pwrkey:
>> +    type: object
>> +    $ref: "../../input/qcom,pm8941-pwrkey.yaml#"
>> +
>> +  resin:
>> +    type: object
>> +    $ref: "../../input/qcom,pm8941-pwrkey.yaml#"
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +
>> +additionalProperties: true
> 
> Instead of allowing arbitrary properties, only valid modes
> should be allowed. So drop additionalProperties and do this
> instead:
> 
> allOf:
>   - $ref: reboot-mode.yaml#
> 
> unevaluatedProperties: false
> 

Okay.

>> +...
> 
> Please do not drop the example :)
> 

As per my understanding on Rob's comments [1] I have added one complete 
example in qcom,pm8941-pwrkey.yaml (see patch 4/4) and dropped it here.

[1] https://lore.kernel.org/patchwork/patch/1390062/#1588027

> -- Sebastian

Thanks,
Satya Priya
