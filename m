Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD41036BF2B
	for <lists+linux-pm@lfdr.de>; Tue, 27 Apr 2021 08:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbhD0GQc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Apr 2021 02:16:32 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:25069 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbhD0GQb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Apr 2021 02:16:31 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1619504148; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=iIaFHsC2q3y5q2pnS4HpSRkWmVmG0nqVEnAYVg4o9xA=;
 b=wHBg71tzSKjgcdeaU8V09OpwSTeQxaNjacvq85Q4n+/iz9nLeCE6upnB0qyCQ23/IGt2l7dm
 m3n9xh1yppbMfXx7QQ/znR0dF6Nj2G3dTFRJ9OjLI4i6dyWnFdoEmK1AwsaCmihNX+Llid/A
 Tb2y5aSjaWQsA6AJ9NlE/MarRlU=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 6087ac122cc44d3aea15661e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 27 Apr 2021 06:15:46
 GMT
Sender: skakit=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id BFFD8C4323A; Tue, 27 Apr 2021 06:15:45 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: skakit)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id F2B30C433F1;
        Tue, 27 Apr 2021 06:15:44 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 27 Apr 2021 11:45:44 +0530
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
In-Reply-To: <0cb9b3503000ac7206f4a3ef5fd16c17@codeaurora.org>
References: <1617881469-31965-1-git-send-email-skakit@codeaurora.org>
 <1617881469-31965-4-git-send-email-skakit@codeaurora.org>
 <20210408130001.k3qbq3vvwkiyykzv@earth.universe>
 <0cb9b3503000ac7206f4a3ef5fd16c17@codeaurora.org>
Message-ID: <322cbdbb022fec3f43c1cbe13c532dd3@codeaurora.org>
X-Sender: skakit@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Sebastian,

On 2021-04-09 13:48, skakit@codeaurora.org wrote:
> Hi Sebastian,
> 
> On 2021-04-08 18:30, Sebastian Reichel wrote:
>> Hi,
>> 
>> On Thu, Apr 08, 2021 at 05:01:08PM +0530, satya priya wrote:
>>> Convert qcom PON binding from .txt to .yaml format.
>>> 
>>> Signed-off-by: satya priya <skakit@codeaurora.org>
>>> ---
>> 
>> Thanks for doing this.
>> 
>>> Changes in V2:
>>>  - As per Rob's comments, converted the main PON binding and added in 
>>> V2.
>>> 
[...]
>>> +  reg:
>>> +    description: Specifies the physical address of the pon register
>> 
>> That description is obvious and pointless. Instead add
>> 
>> maxItems: 1
>> 
> 
> Okay.
> 
>>> +  pwrkey:
>>> +    type: object
>>> +    $ref: "../../input/qcom,pm8941-pwrkey.yaml#"
>>> +
>>> +  resin:
>>> +    type: object
>>> +    $ref: "../../input/qcom,pm8941-pwrkey.yaml#"
>>> +
>>> +required:
>>> +  - compatible
>>> +  - reg
>>> +
>>> +additionalProperties: true
>> 
>> Instead of allowing arbitrary properties, only valid modes
>> should be allowed. So drop additionalProperties and do this
>> instead:
>> 
>> allOf:
>>   - $ref: reboot-mode.yaml#
>> 
>> unevaluatedProperties: false
>> 
> 
> Okay.
> 

I am not able to use 'allOf' to refer reboot-mode.yaml as some of the 
properties do not match with reboot-mode.yaml properties. Can we use 
oneOf like below?

oneOf:
   - $ref: "reboot-mode.yaml#"
   - $ref: "../../input/qcom,pm8941-pwrkey.yaml#"

Also, If I drop additionalProperties I am getting below error.

kernel/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml: 
'additionalProperties' is a required property

Thanks,
Satya Priya
