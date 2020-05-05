Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8DDA1C4EE8
	for <lists+linux-pm@lfdr.de>; Tue,  5 May 2020 09:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728388AbgEEHSC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 May 2020 03:18:02 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:20234 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726551AbgEEHSC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 May 2020 03:18:02 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588663081; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=Ucvka1OSqO/XtIecNYyEKI9KAFnWzP85SPhN34KKW5c=;
 b=aAoktXQoW22OErP5CgXXSmMx3kKdL+Fqbwh6tThk73ma9yhNlNyNmzSn9sfo+fkKeqFaC0VR
 XlYatAIIUy+nPEvyQ2bID7TE/VJOdnIiyjXvMU63VUPitsYRSOYBtYSQTFcIrSQLLpLPAjQu
 2qMeAQunxKavYUbSFnKF5lOv/7A=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb11316.7fbb89257420-smtp-out-n04;
 Tue, 05 May 2020 07:17:42 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4336DC433BA; Tue,  5 May 2020 07:17:42 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 28A4DC433D2;
        Tue,  5 May 2020 07:17:41 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 05 May 2020 12:47:41 +0530
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
        lukasz.luba@arm.com, sudeep.holla@arm.com,
        linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH v4 10/12] OPP: Add support for setting interconnect-tags
In-Reply-To: <20200505045639.i4nnplwaxlkful4o@vireshk-i7>
References: <20200504202243.5476-1-sibis@codeaurora.org>
 <20200504202243.5476-11-sibis@codeaurora.org>
 <20200505045639.i4nnplwaxlkful4o@vireshk-i7>
Message-ID: <9310f586ca2084539353efdbca0d9c7d@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2020-05-05 10:26, Viresh Kumar wrote:
> On 05-05-20, 01:52, Sibi Sankar wrote:
>> Add support for setting tags on icc paths associated with
>> the opp_table.
>> 
>> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
>> ---
>>  drivers/opp/of.c | 25 +++++++++++++++++++------
>>  1 file changed, 19 insertions(+), 6 deletions(-)
> 
> Maybe this should be part of Georgi's series ?

yes, I've requested for the
same in my cover-letter.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
