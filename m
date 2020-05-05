Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1D271C4EF3
	for <lists+linux-pm@lfdr.de>; Tue,  5 May 2020 09:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727973AbgEEHUH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 May 2020 03:20:07 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:23353 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726065AbgEEHUF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 May 2020 03:20:05 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588663205; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=uJwzx6pIPPCofwLtZDB4TDrhcslzQR2DeFg2pp9P5pI=;
 b=gj4ZWfx4plbtNj0+UN9uomtR24lrdm8oFsrQNOxZ1zrMZSK3vtsCgIva8y1Dbf2aO3Pt/Gz3
 Ubc/nvcqpa5Iiq/1z8Mp9Y8CuHOSp69TQHkF7TKqLXTi5FImXb4T03XSJzx15Fg8+capYS/G
 5RFGxDdwMNDvKsbQT3lZy8FJ4tk=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb1139d.7f331717f0a0-smtp-out-n05;
 Tue, 05 May 2020 07:19:57 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 0258AC4478C; Tue,  5 May 2020 07:19:55 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 53D46C433D2;
        Tue,  5 May 2020 07:19:55 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 05 May 2020 12:49:55 +0530
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
Subject: Re: [PATCH v4 06/12] cpufreq: qcom: Update the bandwidth levels on
 frequency change
In-Reply-To: <20200505045012.zfx2e6chqo5f3e4n@vireshk-i7>
References: <20200504202243.5476-1-sibis@codeaurora.org>
 <20200504202243.5476-7-sibis@codeaurora.org>
 <20200505045012.zfx2e6chqo5f3e4n@vireshk-i7>
Message-ID: <8fc5b72c9af6fd6a707a280cfc678677@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2020-05-05 10:20, Viresh Kumar wrote:
> On 05-05-20, 01:52, Sibi Sankar wrote:
>> Add support to parse optional OPP table attached to the cpu node when
>> the OPP bandwidth values are populated. This allows for scaling of
>> DDR/L3 bandwidth levels with frequency change.
>> 
>> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> 
> What about using opp_set_rate instead ?

I can't use opp_set_rate since
the cpu dev does not have a
clock associated with it and the
scaling is done through writing
on perf state register.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
