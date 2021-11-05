Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF10446188
	for <lists+linux-pm@lfdr.de>; Fri,  5 Nov 2021 10:46:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbhKEJtE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Nov 2021 05:49:04 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:15109 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232760AbhKEJtD (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 5 Nov 2021 05:49:03 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1636105584; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=R+UMD8HkfHT9XgKs6EYLYkwkLi3PZwCEgoFSlEbrpcM=;
 b=c9EUrHH7vdJGk1/Zuam0eZAyuWlab72djJtNZSlsBm0f3lAouxYyLXNOKfue3IHHFuVF1JJW
 4Vg/tRRyZjZgFhbmNpWF38f5IEhPweo7wz9zpqY7zSSeP+NvAdZRcmEWau+2cICSpvh9sOsp
 ABaWQ4jjS3PGJVvlNhU0ZjzQuBQ=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 6184fd6b4d8c23a9d2d10605 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 05 Nov 2021 09:46:19
 GMT
Sender: manafm=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 0DE73C43460; Fri,  5 Nov 2021 09:46:19 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: manafm)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6C35AC4338F;
        Fri,  5 Nov 2021 09:46:18 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 05 Nov 2021 15:16:18 +0530
From:   manafm@codeaurora.org
To:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: thermal: Reset previous low and high trip during
 thermal zone init
In-Reply-To: <1635883240-24293-1-git-send-email-manafm@codeaurora.org>
References: <1635883240-24293-1-git-send-email-manafm@codeaurora.org>
Message-ID: <85d1774df789ec8d528c9b3ea8afef38@codeaurora.org>
X-Sender: manafm@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Gentle reminder.

On 2021-11-03 01:30, Manaf Meethalavalappu Pallikunhi wrote:
> During the suspend is in process, thermal_zone_device_update bails out
> thermal zone re-evaluation for any sensor trip violation without
> setting next valid trip to that sensor. It assumes during resume
> it will re-evaluate same thermal zone and update trip. But when it is
> in suspend temperature goes down and on resume path while updating
> thermal zone if temperature is less than previously violated trip,
> thermal zone set trip function evaluates the same previous high and
> previous low trip as new high and low trip. Since there is no change
> in high/low trip, it bails out from thermal zone set trip API without
> setting any trip. It leads to a case where sensor high trip or low
> trip is disabled forever even though thermal zone has a valid high
> or low trip.
> 
> During thermal zone device init, reset thermal zone previous high
> and low trip. It resolves above mentioned scenario.
> 
> Signed-off-by: Manaf Meethalavalappu Pallikunhi <manafm@codeaurora.org>
> ---
>  drivers/thermal/thermal_core.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/thermal/thermal_core.c 
> b/drivers/thermal/thermal_core.c
> index 21db445..2b7a0b4 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -477,6 +477,8 @@ static void thermal_zone_device_init(struct
> thermal_zone_device *tz)
>  {
>  	struct thermal_instance *pos;
>  	tz->temperature = THERMAL_TEMP_INVALID;
> +	tz->prev_low_trip = -INT_MAX;
> +	tz->prev_high_trip = INT_MAX;
>  	list_for_each_entry(pos, &tz->thermal_instances, tz_node)
>  		pos->initialized = false;
>  }
