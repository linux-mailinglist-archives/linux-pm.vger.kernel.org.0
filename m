Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBF14398691
	for <lists+linux-pm@lfdr.de>; Wed,  2 Jun 2021 12:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232641AbhFBKdh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Jun 2021 06:33:37 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:18517 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232599AbhFBKdg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Jun 2021 06:33:36 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1622629914; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=dDtT9RKDST8Kb7cX/QWo/KyCGcfZAqjbXnH9sp+GoxM=;
 b=sQRy+Px0PhUp7jdVLV7AFo0hSSKrXlzyLJWT3KGPnFuOJ7j0CG5oH3MwDxgBmYlgBwhiYjCS
 f+hTfOsjUOML0JTeRUFvkMzBxM2SvumGjwOb+l8KFAvTbj9IDIOF0Ci6Ikdq4wzqiqb4CqeQ
 0RaYjYOeuUGWqAZFz5OYP1jDWpE=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 60b75e17e27c0cc77f24f3a9 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 02 Jun 2021 10:31:51
 GMT
Sender: skakit=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 83569C43148; Wed,  2 Jun 2021 10:31:50 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: skakit)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E114DC43144;
        Wed,  2 Jun 2021 10:31:47 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 02 Jun 2021 16:01:47 +0530
From:   skakit@codeaurora.org
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Rob Herring <robh@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        kgunda@codeaurora.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Courtney Cavin <courtney.cavin@sonymobile.com>,
        Vinod Koul <vkoul@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        David Collins <collinsd@codeaurora.org>,
        Andy Yan <andy.yan@rock-chips.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, Andy Gross <agross@kernel.org>
Subject: Re: [PATCH V3 4/5] dt-bindings: input: pm8941-pwrkey: Convert pm8941
 power key binding to yaml
In-Reply-To: <YLcLCmxNOYqj0SN3@google.com>
References: <1620630064-16354-1-git-send-email-skakit@codeaurora.org>
 <1620630064-16354-5-git-send-email-skakit@codeaurora.org>
 <1620655299.793818.41438.nullmailer@robh.at.kernel.org>
 <20210510162445.GA230005@robh.at.kernel.org>
 <c4e286ae6bd621a9d84184d5d014d060@codeaurora.org>
 <YLcLCmxNOYqj0SN3@google.com>
Message-ID: <a308dc5984d80709311a095b8435752f@codeaurora.org>
X-Sender: skakit@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2021-06-02 10:07, Dmitry Torokhov wrote:
> On Wed, May 12, 2021 at 10:17:43AM +0530, skakit@codeaurora.org wrote:
>> On 2021-05-10 21:54, Rob Herring wrote:
>> > On Mon, May 10, 2021 at 09:01:39AM -0500, Rob Herring wrote:
>> > > On Mon, 10 May 2021 12:31:03 +0530, satya priya wrote:
>> > > > Convert qcom pm8941 power key binding from .txt to .yaml format.
>> > > >
>> > > > Signed-off-by: satya priya <skakit@codeaurora.org>
>> > > > ---
>> > > > Changes in V2:
>> > > >  - Fixed bot errors, took reference from input.yaml for "linux,code"
>> > > >  - Added one complete example for powerkey and resin, and referenced it
>> > > >    in main PON binding.
>> > > >  - Moved this patch to the end of the series.
>> > > >
>> > > > Changes in V3:
>> > > >  - Moved this patch before PON binding patch.
>> > > >  - As per Rob's comments, added allOf at the beginning of binding.
>> > > >    Added maxItems for interrupts.
>> > > >  - Added 'unevaluatedProperties' instead of 'additionalProperties' as
>> > > >    we are using allOf.
>> > > >
>> > > >  .../bindings/input/qcom,pm8941-pwrkey.txt          | 55 --------------
>> > > >  .../bindings/input/qcom,pm8941-pwrkey.yaml         | 87 ++++++++++++++++++++++
>> > > >  2 files changed, 87 insertions(+), 55 deletions(-)
>> > > >  delete mode 100644 Documentation/devicetree/bindings/input/qcom,pm8941-pwrkey.txt
>> > > >  create mode 100644 Documentation/devicetree/bindings/input/qcom,pm8941-pwrkey.yaml
>> > > >
>> > >
>> > > My bot found errors running 'make DT_CHECKER_FLAGS=-m
>> > > dt_binding_check'
>> > > on your patch (DT_CHECKER_FLAGS is new in v5.13):
>> > >
>> > > yamllint warnings/errors:
>> > >
>> > > dtschema/dtc warnings/errors:
>> > > Documentation/devicetree/bindings/input/qcom,pm8941-pwrkey.example.dt.yaml:0:0:
>> > > /example-0/spmi@c440000/pmic@0/pon_hlos@1300: failed to match any
>> > > schema with compatible: ['qcom,pm8998-pon']
>> >
>> > You have the same example in patch 5, so drop the example here. That
>> > will fix this circular dependency.
>> 
>> Earlier I have dropped example from qcom-pon.yaml. Now, I will add the
>> example there and drop here.
> 
> It sounds to me you want to combine patches 4 and 5 since they depend 
> on
> each other.
> 

No, the idea was to have one complete example, instead of bits. So, 
initially I have removed the example part from qcom-pon.yaml and added 
full example here, but it was causing a circular dependency issue. Rob 
suggested to move it back to qcom-pon.yaml to fix issue.

I have posted V4 making that change.
https://lore.kernel.org/patchwork/patch/1425638/

Thanks,
Satya Priya

> Thanks.
