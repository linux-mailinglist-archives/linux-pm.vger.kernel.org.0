Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78D7D376305
	for <lists+linux-pm@lfdr.de>; Fri,  7 May 2021 11:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236802AbhEGJrt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 7 May 2021 05:47:49 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:28712 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234506AbhEGJrs (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 7 May 2021 05:47:48 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1620380809; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=NDnAzeydRGMYjrqIWykUo4zSO+l0CqzR1v62gJWLZJQ=;
 b=S/Urf+IWg8wimpOvG6jLPPHq+WCFGKNJ5JaYDRczFezoAlWVMhLHRMkI6Y2DFDiTKuOBZ0O+
 UCHRdQxCO823p32s4kB89aszCAmrOSX3KGb9DiD4n8TYKtKeEqYU4BwJfKjtMnsjA3VBq4T2
 Anv++Prc8BDlLUFt0x0PrSmYa1M=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 60950c5455b14811b4ef0400 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 07 May 2021 09:45:56
 GMT
Sender: skakit=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 03C67C43147; Fri,  7 May 2021 09:45:56 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: skakit)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 48001C4338A;
        Fri,  7 May 2021 09:45:55 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 07 May 2021 15:15:55 +0530
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
In-Reply-To: <a190e414c53af3ea094548f5011c3a04@codeaurora.org>
References: <1617881469-31965-1-git-send-email-skakit@codeaurora.org>
 <1617881469-31965-4-git-send-email-skakit@codeaurora.org>
 <20210408130001.k3qbq3vvwkiyykzv@earth.universe>
 <0cb9b3503000ac7206f4a3ef5fd16c17@codeaurora.org>
 <322cbdbb022fec3f43c1cbe13c532dd3@codeaurora.org>
 <20210427083721.heavcdadeb4ajkk2@earth.universe>
 <a190e414c53af3ea094548f5011c3a04@codeaurora.org>
Message-ID: <be3573974d76d7e464048b34854416ad@codeaurora.org>
X-Sender: skakit@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,
[...]
>>> > > > +
>>> > > > +required:
>>> > > > +  - compatible
>>> > > > +  - reg
>>> > > > +
>>> > > > +additionalProperties: true
>>> > >
>>> > > Instead of allowing arbitrary properties, only valid modes
>>> > > should be allowed. So drop additionalProperties and do this
>>> > > instead:
>>> > >
>>> > > allOf:
>>> > >   - $ref: reboot-mode.yaml#
>>> > >
>>> > > unevaluatedProperties: false
>>> > >
>>> >
>>> > Okay.
>>> 
>>> I am not able to use 'allOf' to refer reboot-mode.yaml as some of the
>>> properties do not match with reboot-mode.yaml properties. Can we use 
>>> oneOf
>>> like below?
>>> 
>>> oneOf:
>>>   - $ref: "reboot-mode.yaml#"
>>>   - $ref: "../../input/qcom,pm8941-pwrkey.yaml#"
>> 
>> That does not make sense.
>> 
>> The reference to reboot-mode.yaml is needed because it adds valid
>> mode properties, so that you can set unevaluatedProperties to false.
>> You need it at the root of the PON binding. They are not added to
>> the required list, so it's fine if not all of them are used. Also
>> there can (and usually is) more than one mode, so using oneOf is not
>> ok.
>> 
> 
> Okay, but I am getting errors like below during make dtbs_check.
> 
> kernel/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-ganges-kirin.dt.yaml:
> pon@800: 'compatible', 'pwrkey', 'reg' do not match any of the
> regexes: '^mode-.*$', 'pinctrl-[0-9]+'
> 

Seems like I have to make 'additionalProperties' as true in 
reboot-mode.yaml
I have checked other yaml binding docs where allOf is used, and they 
have 'additionalProperties' as true in the file which is being referred. 
Please let me know if this is not correct way to do it.

> As suggested I have added
> 
> allOf:
>  - $ref: reboot-mode.yaml#
> 
> at the root of binding and also added unevaluatedProperties: false
> 
>> Last but not least the pwrkey reference is needed to describe
>> specific nodes (resin, pwrkey) and should not appear at the root
>> of the PON binding.
>> 
>>> Also, If I drop additionalProperties I am getting below error.
>>> 
>>> kernel/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml:
>>> 'additionalProperties' is a required property
>> 
>> You need to add 'unevaluatedProperties: false'. It is basically
>> the same as 'additionalProperties: false', but also accepts
>> properties from the referenced bindings.
>> 
>> Thanks,
>> 
>> -- Sebastian

Thanks,
Satya Priya
