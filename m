Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7571C1C4EDE
	for <lists+linux-pm@lfdr.de>; Tue,  5 May 2020 09:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726065AbgEEHQr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 May 2020 03:16:47 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:63690 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726345AbgEEHQr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 May 2020 03:16:47 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588663006; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=+hiu61cB2T9Qrb3MnzM4syIITrDat9oYwrkInKhiIqo=;
 b=HOToYRpeRirIzysXNNf4uzf7f6KRi/SUGPvCeioeaT5uHxuFAgDEfOfNu6hF41grw3bQVoCi
 Y1RnNZC4MiFh5qDuUAE9A+hc5tMZX7cq7kUc3cuyL7ylikFARXMQnmkiTUgRhWjGcHfguHrl
 IM06QS46/i9UKVt3J/oAXV0+GeM=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb112dc.7f1f2e286308-smtp-out-n04;
 Tue, 05 May 2020 07:16:44 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 48F79C432C2; Tue,  5 May 2020 07:16:44 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 933C6C433CB;
        Tue,  5 May 2020 07:16:43 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 05 May 2020 12:46:43 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     sboyd@kernel.org, georgi.djakov@linaro.org,
        bjorn.andersson@linaro.org, saravanak@google.com, mka@chromium.org,
        nm@ti.com, agross@kernel.org, david.brown@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, rjw@rjwysocki.net,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        dianders@chromium.org, vincent.guittot@linaro.org,
        amit.kucheria@linaro.org, ulf.hansson@linaro.org,
        lukasz.luba@arm.com, sudeep.holla@arm.com
Subject: Re: [PATCH v4 04/12] OPP: Add and export helper to update voltage
In-Reply-To: <20200505044552.3dejhryk6fhypolm@vireshk-i7>
References: <20200504202243.5476-1-sibis@codeaurora.org>
 <20200504202243.5476-5-sibis@codeaurora.org>
 <20200505044552.3dejhryk6fhypolm@vireshk-i7>
Message-ID: <63dcc39c47d2354950351e0b8fc0ed83@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hey Viresh,
Thanks for taking time to review
the series.

On 2020-05-05 10:15, Viresh Kumar wrote:
> On 05-05-20, 01:52, Sibi Sankar wrote:
>> Add and export 'dev_pm_opp_update_voltage' to update the voltage of an
>> opp for a given frequency. This will be useful to update the opps with
>> voltages read back from firmware.
>> 
>> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> 
> Have a look at dev_pm_opp_adjust_voltage().

Thanks for the pointer, ^^ should
work just as well. Will drop this
patch on the next re-spin.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
