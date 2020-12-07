Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C48B92D18C7
	for <lists+linux-pm@lfdr.de>; Mon,  7 Dec 2020 19:55:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbgLGSxL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Dec 2020 13:53:11 -0500
Received: from m43-15.mailgun.net ([69.72.43.15]:14861 "EHLO
        m43-15.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbgLGSxL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Dec 2020 13:53:11 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1607367166; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=pHUWFHyylj2tSQF2E2ZynRPPGPx4mvb8MQe0e6mkGKg=;
 b=wBcYwEgMw2+FMHdFSQ9/JJO5UmeT/tiUKdN2SDeDHIXsS6dg6qfU0enNH+dnDOFPb5Z95kkd
 bgbYU18tCXkfiqDnCSGgfHok10gcMIsW1psLaPLP3lz31Aftwxh74ekJ9zZl/Itgb9pjD4Bq
 M44UiKD/NAn8+DvgWzj9CY2rpsM=
X-Mailgun-Sending-Ip: 69.72.43.15
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n10.prod.us-east-1.postgun.com with SMTP id
 5fce79ddb50fb3818af6b658 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 07 Dec 2020 18:52:13
 GMT
Sender: manafm=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3FD05C433CA; Mon,  7 Dec 2020 18:52:13 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: manafm)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 49CFDC433C6;
        Mon,  7 Dec 2020 18:52:12 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 08 Dec 2020 00:22:12 +0530
From:   manafm@codeaurora.org
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Ram Chandrasekar <rkumbako@codeaurora.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: thermal: Add NULL pointer check before using
 cooling device stats
In-Reply-To: <55cd5e44-f34e-26a3-fad7-20100d429d1d@linaro.org>
References: <1607108991-31948-1-git-send-email-manafm@codeaurora.org>
 <55cd5e44-f34e-26a3-fad7-20100d429d1d@linaro.org>
Message-ID: <6cbc296beb4dd28214ab009cfc10e7f9@codeaurora.org>
X-Sender: manafm@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2020-12-05 16:42, Daniel Lezcano wrote:
> On 04/12/2020 20:09, Manaf Meethalavalappu Pallikunhi wrote:
>> There is a possible chance that some cooling device stats buffer
>> allocation fails due to very high cooling device max state value.
>> Later cooling device update or cooling stats sysfs will try to
>> access stats data for the same cooling device. It will lead to
>> NULL pointer dereference issue.
>> 
>> Add a NULL pointer check before accessing thermal cooling device
>> stats data. It fixes the following bug
>> 
>> [ 26.812833] Unable to handle kernel NULL pointer dereference at 
>> virtual address 0000000000000004
>> [ 27.122960] Call trace:
>> [ 27.122963] do_raw_spin_lock+0x18/0xe8
>> [ 27.122966] _raw_spin_lock+0x24/0x30
>> [ 27.128157] thermal_cooling_device_stats_update+0x24/0x98
>> [ 27.128162] cur_state_store+0x88/0xb8
>> [ 27.128166] dev_attr_store+0x40/0x58
>> [ 27.128169] sysfs_kf_write+0x50/0x68
>> [ 27.133358] kernfs_fop_write+0x12c/0x1c8
>> [ 27.133362] __vfs_write+0x54/0x160
>> [ 27.152297] vfs_write+0xcc/0x188
>> [ 27.157132] ksys_write+0x78/0x108
>> [ 27.162050] ksys_write+0xf8/0x108
>> [ 27.166968] __arm_smccc_hvc+0x158/0x4b0
>> [ 27.166973] __arm_smccc_hvc+0x9c/0x4b0
>> [ 27.186005] el0_svc+0x8/0xc
>> 
>> Signed-off-by: Manaf Meethalavalappu Pallikunhi 
>> <manafm@codeaurora.org>
> 
> The only place where it can crash is when the
> thermal_cooling_device_stats_update() function is called.
> 
> The other places in show*/store* in the stats directory are 
> inaccessible
> as the sysfs entry is not showed up due to the
> thermal_cooling_device_stats_setup() failing.
> 
> It would have been nice if the thermal_cooling_device_stats_update() 
> was
> not called at all but I don't see how we can do that without static 
> keys
> which is overkill for a degraded mode.
> 
> I guess having the kzallocation warning in the console output is enough
> to warn the user the system is working without the stats for the 
> cooling
> device. That should not prevent the system functioning.
> 
> Can you resend with the check in thermal_cooling_device_stats_update() 
> only?
> 
> Thanks
> 
>   -- Daniel
Thanks for your review, I double checked it, yes, no need to add NULL 
check in stats sysfs show*/store* functions.
I will update this in V2

Thanks
Manaf
> 
> 
>> ---
>>  drivers/thermal/thermal_sysfs.c | 18 +++++++++++++++++-
>>  1 file changed, 17 insertions(+), 1 deletion(-)
>> 
>> diff --git a/drivers/thermal/thermal_sysfs.c 
>> b/drivers/thermal/thermal_sysfs.c
>> index 473449b..a5e4855 100644
>> --- a/drivers/thermal/thermal_sysfs.c
>> +++ b/drivers/thermal/thermal_sysfs.c
>> @@ -827,6 +827,9 @@ void thermal_cooling_device_stats_update(struct 
>> thermal_cooling_device *cdev,
>>  {
>>  	struct cooling_dev_stats *stats = cdev->stats;
>> 
>> +	if (!stats)
>> +		return;
>> +
>>  	spin_lock(&stats->lock);
>> 
>>  	if (stats->state == new_state)
>> @@ -848,6 +851,9 @@ static ssize_t total_trans_show(struct device 
>> *dev,
>>  	struct cooling_dev_stats *stats = cdev->stats;
>>  	int ret;
>> 
>> +	if (!stats)
>> +		return -ENODEV;
>> +
>>  	spin_lock(&stats->lock);
>>  	ret = sprintf(buf, "%u\n", stats->total_trans);
>>  	spin_unlock(&stats->lock);
>> @@ -864,6 +870,9 @@ time_in_state_ms_show(struct device *dev, struct 
>> device_attribute *attr,
>>  	ssize_t len = 0;
>>  	int i;
>> 
>> +	if (!stats)
>> +		return -ENODEV;
>> +
>>  	spin_lock(&stats->lock);
>>  	update_time_in_state(stats);
>> 
>> @@ -882,8 +891,12 @@ reset_store(struct device *dev, struct 
>> device_attribute *attr, const char *buf,
>>  {
>>  	struct thermal_cooling_device *cdev = to_cooling_device(dev);
>>  	struct cooling_dev_stats *stats = cdev->stats;
>> -	int i, states = stats->max_states;
>> +	int i, states;
>> +
>> +	if (!stats)
>> +		return -ENODEV;
>> 
>> +	states = stats->max_states;
>>  	spin_lock(&stats->lock);
>> 
>>  	stats->total_trans = 0;
>> @@ -907,6 +920,9 @@ static ssize_t trans_table_show(struct device 
>> *dev,
>>  	ssize_t len = 0;
>>  	int i, j;
>> 
>> +	if (!stats)
>> +		return -ENODEV;
>> +
>>  	len += snprintf(buf + len, PAGE_SIZE - len, " From  :    To\n");
>>  	len += snprintf(buf + len, PAGE_SIZE - len, "       : ");
>>  	for (i = 0; i < stats->max_states; i++) {
>> 
