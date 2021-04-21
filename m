Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA9E36655E
	for <lists+linux-pm@lfdr.de>; Wed, 21 Apr 2021 08:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236066AbhDUGYP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Apr 2021 02:24:15 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:46392 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236019AbhDUGYP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Apr 2021 02:24:15 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1618986223; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=joVt7EiJpq5MpkTsFfA7/raYnftwlEGm8PrYlH6jj2I=;
 b=Bq1DPb8hCVYlGYXd8oOcmbugKRkTuAHR4moDQ42w7fYLVZTEq+0XXmWFYIjT3fKa9tJ3wL0Q
 MWdhDnCRbmfsXmcQKG2Ydp0SFDdoRSNw97OwbCAvULvpNMzceKV9WV4aUphOYishmH0czRe5
 xtQB2j2Dgp5LTZSs9XdCa4LUKmg=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 607fc4db215b831afb7a20d9 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 21 Apr 2021 06:23:23
 GMT
Sender: skakit=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C9C07C4338A; Wed, 21 Apr 2021 06:23:23 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: skakit)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 73638C433D3;
        Wed, 21 Apr 2021 06:23:21 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 21 Apr 2021 11:53:21 +0530
From:   skakit@codeaurora.org
To:     Rob Herring <robh@kernel.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        David Collins <collinsd@codeaurora.org>, kgunda@codeaurora.org,
        Vinod Koul <vkoul@kernel.org>,
        Courtney Cavin <courtney.cavin@sonymobile.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH V2 4/4] dt-bindings: input: pm8941-pwrkey: Convert pm8941
 power key binding to yaml
In-Reply-To: <20210409185044.GA3946207@robh.at.kernel.org>
References: <1617881469-31965-1-git-send-email-skakit@codeaurora.org>
 <1617881469-31965-5-git-send-email-skakit@codeaurora.org>
 <20210409185044.GA3946207@robh.at.kernel.org>
Message-ID: <68095bad57e336c70b622c5b8d5870b1@codeaurora.org>
X-Sender: skakit@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rob,

On 2021-04-10 00:20, Rob Herring wrote:
> On Thu, Apr 08, 2021 at 05:01:09PM +0530, satya priya wrote:
>> Convert qcom pm8941 power key binding from .txt to .yaml format.
>> 
>> Signed-off-by: satya priya <skakit@codeaurora.org>
[...]
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - qcom,pm8941-pwrkey
>> +      - qcom,pm8941-resin
>> +      - qcom,pmk8350-pwrkey
>> +      - qcom,pmk8350-resin
>> +
>> +  interrupts:
> 
> How many?
> 

ok, will add maxItems.

>> +    description: |
>> +          Key change interrupt; The format of the specifier is
>> +          defined by the binding document describing the node's
>> +          interrupt parent.
> 
> The 2nd sentence is every 'interrupts' property. Drop.
> 

Will remove the description.

>> +
>> +  debounce:
>> +    description: |
>> +          Time in microseconds that key must be pressed or
>> +          released for state change interrupt to trigger.
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +
>> +  bias-pull-up:
>> +    description: |
>> +           Presence of this property indicates that the KPDPWR_N
>> +           pin should be configured for pull up.
>> +    $ref: /schemas/types.yaml#/definitions/flag
>> +
>> +  linux,code:
>> +    description: |
>> +           The input key-code associated with the power key.
>> +           Use the linux event codes defined in
>> +           include/dt-bindings/input/linux-event-codes.h
>> +           When property is omitted KEY_POWER is assumed.
>> +    $ref: "input.yaml#"
> 
> You've just defined that 'linux,code' is a node with properties defined
> in input.yaml. Need to move this up to the top level.
> 

allOf:
   $ref: "input.yaml#"
That means I should add like this at the beginning? please correct me if 
wrong.

>> +
>> +required:
>> +  - compatible
>> +  - interrupts
>> +
>> +additionalProperties: false
[...]

Thanks,
Satya Priya
