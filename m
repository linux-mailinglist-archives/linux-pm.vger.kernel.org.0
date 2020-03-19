Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0DD18B0F5
	for <lists+linux-pm@lfdr.de>; Thu, 19 Mar 2020 11:11:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbgCSKL0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Mar 2020 06:11:26 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:10909 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725768AbgCSKL0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Mar 2020 06:11:26 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1584612685; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=M1HzhVB6T9UZUN6Oig36KI7SQdXHk/1MM2NC6JmVWog=;
 b=YrHOULcD/Q4lswZjbvoK+GxOzq/d64CaG4mkcAlVyHMpQ68jdd2il12Bs5nMrypOa+JtROPJ
 Rm/xVHU8kpqCBMOYYunA4zQ9WiZVkMdedCKtT4/pEOJMJIEK8Z4pIubvJ/oiiTMa5Ts5fFhS
 N7fwnDjOjDd+NE6/OxFlqvzSkX4=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e734544.7f13f5a2f8f0-smtp-out-n05;
 Thu, 19 Mar 2020 10:11:16 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6BBB9C4478F; Thu, 19 Mar 2020 10:11:16 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AA8B3C433D2;
        Thu, 19 Mar 2020 10:11:15 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 19 Mar 2020 15:41:15 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, sboyd@kernel.org,
        georgi.djakov@linaro.org, saravanak@google.com, nm@ti.com,
        bjorn.andersson@linaro.org, agross@kernel.org,
        david.brown@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        rjw@rjwysocki.net, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dianders@chromium.org, mka@chromium.org,
        vincent.guittot@linaro.org, amit.kucheria@linaro.org,
        ulf.hansson@linaro.org, linux-kernel-owner@vger.kernel.org
Subject: Re: [RFC v3 00/10] DDR/L3 Scaling support on SDM845 and SC7180 SoCs
In-Reply-To: <f6a7930a-4eaa-6982-88c6-b50773bee9d8@codeaurora.org>
References: <20200127200350.24465-1-sibis@codeaurora.org>
 <19cf027ba87ade1b895ea90ac0fedbe2@codeaurora.org>
 <20200318034243.o2metmggzuah6cqw@vireshk-i7>
 <f6a7930a-4eaa-6982-88c6-b50773bee9d8@codeaurora.org>
Message-ID: <ea4265f3f4b5a439d70d3c80bcc77b7f@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2020-03-19 15:12, Rajendra Nayak wrote:
> On 3/18/2020 9:12 AM, Viresh Kumar wrote:
>> On 18-03-20, 02:13, Sibi Sankar wrote:
>>> On 2020-01-28 01:33, Sibi Sankar wrote:
>>>> This RFC series aims to extend cpu based scaling support to L3/DDR 
>>>> on
>>>> SDM845 and SC7180 SoCs.
>>>> 
>>> 
>>> Hey Viresh/Saravana,
>>> 
>>> Ping! Can you take a stab at reviewing
>>> the series, it has been on the list for
>>> a while now.
>> 
>> I believe this depends on Saravana's series on which I have raised
>> some doubts few weeks back ? I am still waiting for them to get
>> clarified by him.

Viresh,
Saravana's example does show a device
with multiple opp tables but doesn't
need multiple opp table support to
land though (since it works fine with
the current implementation). I am more
interested  in understanding your/
Stephen's/Saravana's stance on adding
multiple opp-table support. Personally
I feel its inevitable, since multiple
qc drivers using interconnect opp-tables,
routinely need vote on multiple paths in
a non-trivial manner.

> 
> Could you please post a link to the discussion that you are referring 
> to here?
> I looked at a few links posted in the cover letter as dependencies and 
> it seems
> like the discussions are pending for *months* and not weeks but I
> might have looked
> at the wrong ones.

https://lore.kernel.org/lkml/20200114103448.odnvqawnqb3twst5@vireshk-i7/

Rajendra,
Viresh is referring to ^^ one

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
