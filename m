Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F20742B99F3
	for <lists+linux-pm@lfdr.de>; Thu, 19 Nov 2020 18:52:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729730AbgKSRqo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Nov 2020 12:46:44 -0500
Received: from z5.mailgun.us ([104.130.96.5]:17855 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729344AbgKSRqo (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 19 Nov 2020 12:46:44 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1605808004; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=Rbk83JLyKBowqtyi3Q2SenfF02fWJYKIxfSgAfJdQos=; b=YCvra0UO7TZvRCYqJjkUhS60kyl4iJlhVt20DQQcrEJm674+Ua65aa8VIPIDJVs1Mxxy8M+s
 gEsz71hHlQnEOHsJMediKFsoM16MXWEU/j9mBlaKW1/9bZ4Knm+XZq4Z7JWnuvK3MbFm8vcP
 88SIBu/0y/3D0ocdXY8RbIqJ6Rc=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 5fb6af837f0cfa6a16e37591 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 19 Nov 2020 17:46:43
 GMT
Sender: ilina=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 30969C43461; Thu, 19 Nov 2020 17:46:43 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: ilina)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4A729C433C6;
        Thu, 19 Nov 2020 17:46:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4A729C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=ilina@codeaurora.org
Date:   Thu, 19 Nov 2020 10:46:41 -0700
From:   Lina Iyer <ilina@codeaurora.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH v5 2/2] PM / Domains: use device's next wakeup to
 determine domain idle state
Message-ID: <X7avgbb2AWvgwm7G@codeaurora.org>
References: <20201106164811.3698-1-ilina@codeaurora.org>
 <20201106164811.3698-3-ilina@codeaurora.org>
 <CAPDyKFrv-3USmNLR3gjgaTEuTrWuYZjs3qCtnjxSOWqrxv5qsA@mail.gmail.com>
 <X6l/OcHG37HzgFL8@codeaurora.org>
 <CAPDyKFr8fdbMM1nsx-RZcMVtveJUP3p38z=HkL1T2C=QgM3gkQ@mail.gmail.com>
 <X6wRBLmvzztNai4y@codeaurora.org>
 <CAPDyKFr9gpH9Kh9=W4D7DRG8OuqBvkaWHvk8i47SToES=338cA@mail.gmail.com>
 <X7KhcItlnS+uuqK2@codeaurora.org>
 <CAPDyKFpKookuX2ynBfy44kyfZq48JPaUrEHevetsyoc83=UnsA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAPDyKFpKookuX2ynBfy44kyfZq48JPaUrEHevetsyoc83=UnsA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Nov 19 2020 at 02:57 -0700, Ulf Hansson wrote:
>On Mon, 16 Nov 2020 at 16:57, Lina Iyer <ilina@codeaurora.org> wrote:
>>
>> On Fri, Nov 13 2020 at 03:34 -0700, Ulf Hansson wrote:
>> >On Wed, 11 Nov 2020 at 17:51, Lina Iyer <ilina@codeaurora.org> wrote:
>> >>
>> >> On Tue, Nov 10 2020 at 03:02 -0700, Ulf Hansson wrote:
>> >> >On Mon, 9 Nov 2020 at 18:41, Lina Iyer <ilina@codeaurora.org> wrote:
>> >> >>
>> >> >> On Mon, Nov 09 2020 at 08:27 -0700, Ulf Hansson wrote:
>> >> >> >On Fri, 6 Nov 2020 at 17:48, Lina Iyer <ilina@codeaurora.org> wrote:
>> [...]
>>
>> >> >> >For example, there's no point doing the above, if the domain doesn't
>> >> >> >specify residency values for its idle states.
>> >> >> >
>> >> >> We would still need to ensure that the next wakeup is after the
>> >> >> power_off_latency, if specified.
>> >> >
>> >> >Good point! Although, I would rather avoid adding the overhead, unless
>> >> >the residency is specified. Do you see a problem with this approach?
>> >> >
>> >> Hmmm, no strong objections. However, we still need to run through the
>> >> states to make sure the residency is not set and have a variable track
>> >> that.
>> >
>> >Right.
>> >
>> >The important part is that we can do that once and not for every call
>> >to the governor.
>> >
>> >> The devices wouldn't know that and would still continue to set the
>> >> next wakeup, unless we find a way to let them know we are not using this
>> >> feature for the domain.
>> >
>> >Right.
>> >
>> >To allow the driver to know, we could respond with an error code from
>> >the new dev_pm_genpd_set_performance_state() API (from patch1), in
>> >case the genpd+governor doesn't support it.
>> >
>> It would an unnecessary work everytime a next wakeup is being set to
>> iterate through the available states and figure out if the residency has
>> been set or not. We could probably hold that result in a variable when
>> we setup the genpd states. Expect the next_wake to be set from a
>> critical path or an interrupt handler, so we have to be quick.
>
>Yes, that's the idea I had in mind.
>
>Maybe it's not feasible, let's see. However, for sure I am looking at
>decreasing overhead, not to increase. :-)
>
Wondering what do you think about a genpd flag for this purpose? The
flag may be set when the genpd is initialized with idle states that have
residency specified. In the governor, we could skip this path
completely, if the flag is not set.

--Lina

>>
>> >Would that be okay? Otherwise we will have to add a separate genpd
>> >API, asking explicitly if the "next wakeup" feature is supported.
>> >
>> Would like to avoid that as much as possible.
>
>Okay, good.
>
>Kind regards
>Uffe
