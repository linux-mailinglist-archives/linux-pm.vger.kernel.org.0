Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44E6D2739F7
	for <lists+linux-pm@lfdr.de>; Tue, 22 Sep 2020 06:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728637AbgIVE4p (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Sep 2020 00:56:45 -0400
Received: from z5.mailgun.us ([104.130.96.5]:10288 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726533AbgIVE4o (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 22 Sep 2020 00:56:44 -0400
X-Greylist: delayed 300 seconds by postgrey-1.27 at vger.kernel.org; Tue, 22 Sep 2020 00:56:44 EDT
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1600750604; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=UMXvr4d2w3U0Xub2etDKsO5ANOh5QYekekonWK9KY7g=;
 b=P+kPmDO0OfDGcXnp0BH0S/DOWFgOvx79+n/46n1JRnCKEZVv6hb9yi6qUVWwGMKqzF847V9G
 mK9yquhyEg76fdSjNC5EVBWa3Z1R5cAlk59gJLYM9kG9RfS/e7n1wZb/bjxrNWre14jziFrP
 D3ylk6G2++lbWPLgnQ5vi070WjM=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 5f6982e00915d30357497c5d (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 22 Sep 2020 04:51:44
 GMT
Sender: sibis=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 947E4C433CB; Tue, 22 Sep 2020 04:51:43 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8F683C433C8;
        Tue, 22 Sep 2020 04:51:41 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 22 Sep 2020 10:21:41 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     Stephen Boyd <swboyd@chromium.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Andy Gross <agross@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        "Nayak, Rajendra" <rnayak@codeaurora.org>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH v2 1/2] PM / Domains: Add GENPD_FLAG_NO_SUSPEND/RESUME
 flags
In-Reply-To: <160071818317.4188128.15658877054019388462@swboyd.mtv.corp.google.com>
References: <20200821204921.32536-1-sibis@codeaurora.org>
 <CAJZ5v0gdMroJY0d9n2+_P2uhBNw1xp5yn=jhxdejDLq0WmkPTA@mail.gmail.com>
 <160071818317.4188128.15658877054019388462@swboyd.mtv.corp.google.com>
Message-ID: <14eb0558c8ff820280bb7354cfe33326@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2020-09-22 01:26, Stephen Boyd wrote:
> Quoting Rafael J. Wysocki (2020-09-21 09:18:17)
>> On Fri, Aug 21, 2020 at 10:49 PM Sibi Sankar <sibis@codeaurora.org> 
>> wrote:
>> >
>> > Add GENPD_FLAG_NO_SUSPEND/RESUME flags to instruct genpd to keep the
>> > status of the PM domain unaltered during suspend/resume respectively.
>> > The flags are aimed at power domains coupled to co-processors which
>> > enter low-power modes independent to that of the application processor.
>> >
>> > Specifically the flags are to be used by the power domains exposed
>> > by the AOSS QMP driver linked to modem, adsp, cdsp remoteprocs. These
>> > power domains are used to notify the Always on Subsystem (AOSS) that
>> > a particular co-processor is up. AOSS uses this information to wait
>> > for the co-processors to suspend before starting its sleep sequence.
>> > The application processor powers off these power domains only if the
>> > co-processor has crashed or powered off and remains unaltered during
>> > system suspend/resume.
>> >
>> > Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
>> 
>> Applied with the Ulf's R-by along with the [2/2] as 5.10 material, 
>> thanks!
>> 
> 
> There was a bunch of discussion on this patch series and I thought the
> consensus was to not apply these patches and instead implement a custom
> qcom specific API that does this instead.

https://lore.kernel.org/lkml/20200913034603.GV3715@yoga/

The power domains which were targeted
to use the flags will be replaced by
custom qcom specific API. So let's not
pick up the patch series.


-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
