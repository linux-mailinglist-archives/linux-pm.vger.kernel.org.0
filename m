Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72F9A25BB74
	for <lists+linux-pm@lfdr.de>; Thu,  3 Sep 2020 09:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbgICHNp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 3 Sep 2020 03:13:45 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:16152 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726054AbgICHNo (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 3 Sep 2020 03:13:44 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1599117223; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=4z34Z3fn8MgWcmuiduYWqSNTgBUNPiswOSFypKcoKAo=;
 b=rG41yKIjNj9veZxjdrK8ryteNWXNNDsmZGOy52+LdG8yHq9Uq8PZmLXetnixVCVCXBvWudTu
 /IFxLYxbt0YVfW18z/dKYWySa+9o+B7QAN+psw/gCwcwV+kiqeZNtpU1XqXfEuVwc2bibGW4
 bhx+pI9kdD2m69PpjT6yN2QRFXg=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 5f5097999bdf68cc036d7acf (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 03 Sep 2020 07:13:29
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 11D5DC433C9; Thu,  3 Sep 2020 07:13:29 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 19B63C433C6;
        Thu,  3 Sep 2020 07:13:27 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 03 Sep 2020 12:43:27 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     ansuelsmth@gmail.com, vincent.guittot@linaro.org,
        saravanak@google.com, 'Sudeep Holla' <sudeep.holla@arm.com>,
        "'Rafael J. Wysocki'" <rjw@rjwysocki.net>,
        'Rob Herring' <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: R: [RFC PATCH v3 0/2] Add Krait Cache Scaling support
In-Reply-To: <20200903065314.y3ynhwydahaeg6o6@vireshk-i7>
References: <20200821140026.19643-1-ansuelsmth@gmail.com>
 <20200824104053.kpjpwzl2iw3lpg2m@vireshk-i7>
 <b339e01f9d1e955137120daa06d26228@codeaurora.org>
 <039d01d67f6a$188700d0$49950270$@gmail.com>
 <20200903065314.y3ynhwydahaeg6o6@vireshk-i7>
Message-ID: <6dc62d231c776b2cdfdc36cfe36e4140@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2020-09-03 12:23, Viresh Kumar wrote:
> On 31-08-20, 09:41, ansuelsmth@gmail.com wrote:
>> On 31-08-20, Sibi wrote:
>> > On 2020-08-24 16:10, Viresh Kumar wrote:
>> > > +Vincent/Saravana/Sibi
>> > >
>> > > On 21-08-20, 16:00, Ansuel Smith wrote:
>> > >> This adds Krait Cache scaling support using the cpufreq notifier.
>> > >> I have some doubt about where this should be actually placed (clk or
>> > >> cpufreq)?
>> > >> Also the original idea was to create a dedicated cpufreq driver (like
>> > >> it's done in
>> > >> the codeaurora qcom repo) by copying the cpufreq-dt driver and adding
>> > >> the cache
>> > >> scaling logic but i still don't know what is better. Have a very
>> > >> similar driver or
>> > >> add a dedicated driver only for the cache using the cpufreq notifier
>> > >> and do the
>> > >> scale on every freq transition.
>> > >> Thanks to everyone who will review or answer these questions.
>> > >
>> > > Saravana was doing something with devfreq to solve such issues if I
>> > > wasn't mistaken.
>> > >
>> > > Sibi ?
>> >
>> > IIRC the final plan was to create a devfreq device
>> > and devfreq-cpufreq based governor to scale them, this
>> > way one can switch to a different governor if required.
>> 
>> So in this case I should convert this patch to a devfreq driver-
> 
> I think this should happen nevertheless. You are doing DVFS for a
> device which isn't a CPU and devfreq looks to be the right place of
> doing so.
> 
>> Isn't overkill to use a governor for such a task?
>> (3 range based on the cpufreq?)
> 
> I am not sure about the governor part here, maybe it won't be required
> ?

Yeah I don't see it being needed in ^^
case as well. I just mentioned them as
an advantage in case you wanted to switch
to a different governor in the future.

https://lore.kernel.org/lkml/d0bc8877-6d41-f54e-1c4c-2fadbb9dcd0b@samsung.com/

A devfreq governor tracking cpufreq was
generally accepted but using a cpufreq
notifier to achieve that was discouraged.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
