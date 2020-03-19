Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BFE918B1D9
	for <lists+linux-pm@lfdr.de>; Thu, 19 Mar 2020 11:57:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbgCSK5R (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Mar 2020 06:57:17 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:55514 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727002AbgCSK5R (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Mar 2020 06:57:17 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1584615437; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=USCY7tIkJjVPsdtXWG2SypaDeqfF1YJU6a6I4ETYJgU=;
 b=YEyUh5WEeepTF9kg44FU3B0wW6ic22ZS4qWnAJDzFhr/VeeO1TwUf2xUJHHjSlbC0H8yTBOV
 9fVdz/AVYRvbCmGcg0LiFUYTJZUjSWyn50mFs5NMfp87aCEYdbacrEglxXviI8wpcLvIfcuR
 F0c8/tHjWJx+j1nC1Lic/bnu5NU=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e73500b.7f03fa77da78-smtp-out-n03;
 Thu, 19 Mar 2020 10:57:15 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 18619C4478C; Thu, 19 Mar 2020 10:57:14 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2F549C433D2;
        Thu, 19 Mar 2020 10:57:13 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 19 Mar 2020 16:27:13 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>, sboyd@kernel.org,
        georgi.djakov@linaro.org, saravanak@google.com, nm@ti.com,
        bjorn.andersson@linaro.org, agross@kernel.org,
        david.brown@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        rjw@rjwysocki.net, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dianders@chromium.org, mka@chromium.org,
        vincent.guittot@linaro.org, amit.kucheria@linaro.org,
        ulf.hansson@linaro.org, linux-kernel-owner@vger.kernel.org
Subject: Re: [RFC v3 00/10] DDR/L3 Scaling support on SDM845 and SC7180 SoCs
In-Reply-To: <20200319102411.oivesngrk7gy7vtw@vireshk-i7>
References: <20200127200350.24465-1-sibis@codeaurora.org>
 <19cf027ba87ade1b895ea90ac0fedbe2@codeaurora.org>
 <20200318034243.o2metmggzuah6cqw@vireshk-i7>
 <f6a7930a-4eaa-6982-88c6-b50773bee9d8@codeaurora.org>
 <ea4265f3f4b5a439d70d3c80bcc77b7f@codeaurora.org>
 <20200319102411.oivesngrk7gy7vtw@vireshk-i7>
Message-ID: <e2cab5f55b9d26849e45d3df951ad7b9@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2020-03-19 15:54, Viresh Kumar wrote:
> On 19-03-20, 15:41, Sibi Sankar wrote:
>> Viresh,
>> Saravana's example does show a device
>> with multiple opp tables but doesn't
>> need multiple opp table support to
>> land though (since it works fine with
>> the current implementation). I am more
>> interested  in understanding your/
>> Stephen's/Saravana's stance on adding
>> multiple opp-table support. Personally
>> I feel its inevitable, since multiple
>> qc drivers using interconnect opp-tables,
>> routinely need vote on multiple paths in
>> a non-trivial manner.
> 
> The OPP core doesn't support multiple OPP tables for a device and I
> don't understand how it will. And so I have been waiting for a reply.

This series tries to add minimal support
for multiple opp-tables per device and
can be tested on db845c/sdm845mtp/sc7180.
Debugfs still needs to be fixed though and
fixing it did feel non-trivial (I can get
to it if we reach a consensus). Perhaps we
can fork out icc oppp-tables from regular
opp-tables and allow only multiple instances
of icc opp-tables per device(though Rob
didn't like the bindings associated with it)
that way all the current users wont be
affected but from what I've tested the
series shouldn't cause any regression.

> 
>> >
>> > Could you please post a link to the discussion that you are referring to
>> > here?
>> > I looked at a few links posted in the cover letter as dependencies and
>> > it seems
>> > like the discussions are pending for *months* and not weeks but I
>> > might have looked
>> > at the wrong ones.
>> 
>> https://lore.kernel.org/lkml/20200114103448.odnvqawnqb3twst5@vireshk-i7/
>> 
>> Rajendra,
>> Viresh is referring to ^^ one
> 
> Right, thanks.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
