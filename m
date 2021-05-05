Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3322A37348D
	for <lists+linux-pm@lfdr.de>; Wed,  5 May 2021 07:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbhEEFJo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 5 May 2021 01:09:44 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:19274 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231494AbhEEFJo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 5 May 2021 01:09:44 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1620191328; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=ufbzClt2siENd3mar5OZbcbZXJ2ZidipGfMDOw2kcCA=;
 b=NhIsXpCFN5ct3MHk4Xydgkx+yT55Y7HRQz3YTGS5+DNC0MRvdfyQtGMs/g4yCOOQzIPiOF4q
 JnP7khUupqvqZbE8m4IXYgKyrDRTxRPILp+Y23URu8r+NRBHG21YcMLaTdz0Zl73B+g+G2Ex
 zZhJc/uVmc/onBv4zt/0Y3NG59Q=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 6092286087ce1fbb565dfe82 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 05 May 2021 05:08:48
 GMT
Sender: skakit=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 66DECC433F1; Wed,  5 May 2021 05:08:47 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: skakit)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 689EDC4338A;
        Wed,  5 May 2021 05:08:46 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 05 May 2021 10:38:46 +0530
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
In-Reply-To: <20210427083721.heavcdadeb4ajkk2@earth.universe>
References: <1617881469-31965-1-git-send-email-skakit@codeaurora.org>
 <1617881469-31965-4-git-send-email-skakit@codeaurora.org>
 <20210408130001.k3qbq3vvwkiyykzv@earth.universe>
 <0cb9b3503000ac7206f4a3ef5fd16c17@codeaurora.org>
 <322cbdbb022fec3f43c1cbe13c532dd3@codeaurora.org>
 <20210427083721.heavcdadeb4ajkk2@earth.universe>
Message-ID: <a190e414c53af3ea094548f5011c3a04@codeaurora.org>
X-Sender: skakit@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2021-04-27 14:07, Sebastian Reichel wrote:
> Hi,
> 
> On Tue, Apr 27, 2021 at 11:45:44AM +0530, skakit@codeaurora.org wrote:
>> Hi Sebastian,
>> 
>> On 2021-04-09 13:48, skakit@codeaurora.org wrote:
>> > Hi Sebastian,
>> >
>> > On 2021-04-08 18:30, Sebastian Reichel wrote:
>> > > Hi,
>> > >
>> > > On Thu, Apr 08, 2021 at 05:01:08PM +0530, satya priya wrote:
>> > > > Convert qcom PON binding from .txt to .yaml format.
>> > > >
>> > > > Signed-off-by: satya priya <skakit@codeaurora.org>
>> > > > ---
>> > >
>> > > Thanks for doing this.
>> > >
>> > > > Changes in V2:
>> > > >  - As per Rob's comments, converted the main PON binding and
>> > > > added in V2.
>> > > >
>> [...]
>> > > > +  reg:
>> > > > +    description: Specifies the physical address of the pon register
>> > >
>> > > That description is obvious and pointless. Instead add
>> > >
>> > > maxItems: 1
>> > >
>> >
>> > Okay.
>> >
>> > > > +  pwrkey:
>> > > > +    type: object
>> > > > +    $ref: "../../input/qcom,pm8941-pwrkey.yaml#"
>> > > > +
>> > > > +  resin:
>> > > > +    type: object
>> > > > +    $ref: "../../input/qcom,pm8941-pwrkey.yaml#"
>> > > > +
>> > > > +required:
>> > > > +  - compatible
>> > > > +  - reg
>> > > > +
>> > > > +additionalProperties: true
>> > >
>> > > Instead of allowing arbitrary properties, only valid modes
>> > > should be allowed. So drop additionalProperties and do this
>> > > instead:
>> > >
>> > > allOf:
>> > >   - $ref: reboot-mode.yaml#
>> > >
>> > > unevaluatedProperties: false
>> > >
>> >
>> > Okay.
>> 
>> I am not able to use 'allOf' to refer reboot-mode.yaml as some of the
>> properties do not match with reboot-mode.yaml properties. Can we use 
>> oneOf
>> like below?
>> 
>> oneOf:
>>   - $ref: "reboot-mode.yaml#"
>>   - $ref: "../../input/qcom,pm8941-pwrkey.yaml#"
> 
> That does not make sense.
> 
> The reference to reboot-mode.yaml is needed because it adds valid
> mode properties, so that you can set unevaluatedProperties to false.
> You need it at the root of the PON binding. They are not added to
> the required list, so it's fine if not all of them are used. Also
> there can (and usually is) more than one mode, so using oneOf is not
> ok.
> 

Okay, but I am getting errors like below during make dtbs_check.

kernel/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-ganges-kirin.dt.yaml: 
pon@800: 'compatible', 'pwrkey', 'reg' do not match any of the regexes: 
'^mode-.*$', 'pinctrl-[0-9]+'

As suggested I have added

allOf:
  - $ref: reboot-mode.yaml#

at the root of binding and also added unevaluatedProperties: false

> Last but not least the pwrkey reference is needed to describe
> specific nodes (resin, pwrkey) and should not appear at the root
> of the PON binding.
> 
>> Also, If I drop additionalProperties I am getting below error.
>> 
>> kernel/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml:
>> 'additionalProperties' is a required property
> 
> You need to add 'unevaluatedProperties: false'. It is basically
> the same as 'additionalProperties: false', but also accepts
> properties from the referenced bindings.
> 
> Thanks,
> 
> -- Sebastian
