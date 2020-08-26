Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3D125375D
	for <lists+linux-pm@lfdr.de>; Wed, 26 Aug 2020 20:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbgHZSj2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 26 Aug 2020 14:39:28 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:51118 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726794AbgHZSj1 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 26 Aug 2020 14:39:27 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1598467166; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: References: Cc: To:
 Subject: From: Sender; bh=q+XvvfuKUIwhEAgsca/TePOG2B1+EPWz6HL4VPktJps=;
 b=T8E4InEQoubjHATLjMTvXw1xI3jze9V5Z1lsH8CuuA42EcsPd8Np/TP8VzLvSnOQrAXLuPlb
 tqQJ7jDXzskEfsf+CJzOZ7gk3Wlp/HyALmgKf+66A9C25CvOYYBPy/JUOaTCNSNOeLDXFF8R
 8GXUdwVFALM0zaSwgrBou/EBglg=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 5f46ac5137ae730e33e75cc3 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 26 Aug 2020 18:39:13
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4CE93C43391; Wed, 26 Aug 2020 18:39:12 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=2.0 tests=ALL_TRUSTED,NICE_REPLY_A,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.0
Received: from [192.168.1.134] (unknown [172.98.141.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: eberman)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id ACF60C433CA;
        Wed, 26 Aug 2020 18:39:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org ACF60C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=eberman@codeaurora.org
From:   Elliot Berman <eberman@codeaurora.org>
Subject: Re: [RESEND PATCH v1 2/4] dt-bindings: power: reset: Add alternate
 reboot mode format
To:     Rob Herring <robh@kernel.org>, ebiggers@google.com,
        samitolvanen@google.com
Cc:     Sebastian Reichel <sre@kernel.org>,
        Andy Yan <andy.yan@rock-chips.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Trilok Soni <tsoni@codeaurora.org>,
        Prasad Sodagudi <psodagud@codeaurora.org>
References: <1597776856-12014-1-git-send-email-eberman@codeaurora.org>
 <1597776856-12014-3-git-send-email-eberman@codeaurora.org>
 <20200825212521.GA1346433@bogus>
Message-ID: <a77491b3-3917-8380-cf94-a4e3ccbbf22c@codeaurora.org>
Date:   Wed, 26 Aug 2020 14:39:08 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.1.1
MIME-Version: 1.0
In-Reply-To: <20200825212521.GA1346433@bogus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 8/25/2020 5:25 PM, Rob Herring wrote:
> On Tue, Aug 18, 2020 at 11:54:14AM -0700, Elliot Berman wrote:
>> Current reboot-mode device tree schema does not support reboot commands
>> with spaces in them [1]. Add an optional new node "reboot-mode-names"
>> and "reboot-mode-magic" which add an array of strings and u32s,
>> respectively which would permit any string in this framework.
> 
> Kind of a weak justification. The intent was for the names to be a key,
> not a multi word description which your example seems to be. Is
> "dm-verity device corrupted" something Android has already standardized
> on?

+Eric/Sami to comment further

I wonder if you're thinking it's better to change the kernel_restart in 
dm-verity-target.c?

Alternatively, I could respin so that spaces in the reboot cmd is 
replaced with "-" in reboot_mode_notify(). This way, there is no need to 
change dm-verity driver or change devicetree schema. i.e.:

@@ -44,9 +44,13 @@ static int reboot_mode_notify(struct notifier_block 
*this,
  {
         struct reboot_mode_driver *reboot;
         unsigned int magic;
+       char *reboot_cmd;
+
+       reboot_cmd = kstrdup(cmd, GFP_KERNEL);
+       strreplace(reboot_cmd, ' ', '-');

         reboot = container_of(this, struct reboot_mode_driver, 
reboot_notifier);
-       magic = get_reboot_mode_magic(reboot, cmd);
+       magic = get_reboot_mode_magic(reboot, reboot_cmd);
         if (magic)
                 reboot->write(reboot, magic);

> 
>>
>> [1]:
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/md/dm-verity-target.c?h=v5.5#n255
>>
>> Signed-off-by: Elliot Berman <eberman@codeaurora.org>
>> ---
>>   .../devicetree/bindings/power/reset/reboot-mode.yaml    | 17 +++++++++++++++++
>>   1 file changed, 17 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/power/reset/reboot-mode.yaml b/Documentation/devicetree/bindings/power/reset/reboot-mode.yaml
>> index a6c9102..4ea6b33 100644
>> --- a/Documentation/devicetree/bindings/power/reset/reboot-mode.yaml
>> +++ b/Documentation/devicetree/bindings/power/reset/reboot-mode.yaml
>> @@ -19,6 +19,9 @@ description: |
>>     the bootloader what to do when the system reboots, and should be named
>>     as mode-xxx = <magic> (xxx is mode name, magic should be a non-zero value).
>>   
>> +  reboot-mode-magic and reboot-mode-names may be used in addition/instead of
>> +  mode-xxx style.
> 
> It should be either/or in my opinion, not both.

OK, I can fix in the next patch.

> 
>> +
>>     For example, modes common Android platform are:
>>       - normal: Normal reboot mode, system reboot with command "reboot".
>>       - recovery: Android Recovery mode, it is a mode to format the device or update a new image.
>> @@ -32,6 +35,14 @@ properties:
>>         description: |
>>           Default value to set on a reboot if no command was provided.
>>   
>> +  reboot-mode-names:
>> +    $ref: /schemas/types.yaml#/definitions/string-array
>> +    description: List of reboot commands, paired with reboot-mode-magic by index
>> +
>> +  reboot-mode-magic:
> 
> 'reboot-modes' would align with normal patterns.

Ditto

> 
>> +    $ref: /schemas/types.yaml#/definitions/uint32-array
>> +    description: List of reboot magic, paired with reboot-mode-names by index
>> +
>>   patternProperties:
>>     "^mode-.*$":
>>       $ref: /schemas/types.yaml#/definitions/uint32
>> @@ -44,4 +55,10 @@ examples:
>>         mode-bootloader = <2>;
>>         mode-loader = <3>;
>>       };
>> +
>> +  - |
>> +    reboot-mode {
>> +      reboot-mode-names = "normal", "bootloader", "dm-verity device corrupted";
>> +      reboot-mode-magic = <0x0>, <0x1>, <0xf>;
>> +    };
>>   ...
>> -- 
>> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
>> a Linux Foundation Collaborative Project
>>
