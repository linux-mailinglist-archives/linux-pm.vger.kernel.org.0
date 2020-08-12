Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C33D242A72
	for <lists+linux-pm@lfdr.de>; Wed, 12 Aug 2020 15:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbgHLNge (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 Aug 2020 09:36:34 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:46769 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727788AbgHLNge (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 12 Aug 2020 09:36:34 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597239393; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=EqmfoHwHYf9z8PU4YayuKnZvoScvaXacGH6oCTRqhOg=;
 b=W4Hk9s21Z8rNHaZGOfQEYW6xTsnA+N/+HOzpoRJZS3Gz5PWSRw42+XKFYBzIXEMpBa6gOrfB
 Sf2Sd8O+1vdvWv7TNVUzLfXwMxJbieBFfZced7NzpWec0r7mMpRN/M+KTNfIKj4KO9boiTF+
 4yFZZZ0v2M7/QI0nOK51U5x5xWw=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 5f33f05c247ccc308c1f0f07 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 12 Aug 2020 13:36:28
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 88453C433CA; Wed, 12 Aug 2020 13:36:27 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B3641C433C6;
        Wed, 12 Aug 2020 13:36:26 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 12 Aug 2020 19:06:26 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     bjorn.andersson@linaro.org, rjw@rjwysocki.net,
        ulf.hansson@linaro.org, agross@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, gregkh@linuxfoundation.org, pavel@ucw.cz,
        len.brown@intel.com, rnayak@codeaurora.org, dianders@chromium.org,
        khilman@kernel.org
Subject: Re: [PATCH 1/2] PM / Domains: Add GENPD_FLAG_SUSPEND_ON flag
In-Reply-To: <159718192589.1360974.15808376172581486987@swboyd.mtv.corp.google.com>
References: <20200811190252.10559-1-sibis@codeaurora.org>
 <159718192589.1360974.15808376172581486987@swboyd.mtv.corp.google.com>
Message-ID: <4f87d7dfbee7553f3ea7a1a6e12b3fa7@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hey Stephen,
Thanks for taking time to review the
series!

On 2020-08-12 03:08, Stephen Boyd wrote:
> Quoting Sibi Sankar (2020-08-11 12:02:51)
>> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
>> index ee11502a575b0..3002a2d68936a 100644
>> --- a/include/linux/pm_domain.h
>> +++ b/include/linux/pm_domain.h
>> @@ -55,6 +55,10 @@
>>   *
>>   * GENPD_FLAG_RPM_ALWAYS_ON:   Instructs genpd to always keep the PM 
>> domain
>>   *                             powered on except for system suspend.
>> + *
>> + * GENPD_FLAG_SUSPEND_ON:      Instructs genpd to keep the PM domain 
>> powered
>> + *                             on during suspend and runtime PM 
>> controlled
> 
> Maybe, "powered on across system suspend (if it is already powered on)"
> to match the hunk above that talks about system suspend for
> GENPD_FLAG_RPM_ALWAYS_ON. Otherwise someone may think that this powers
> on the genpd during suspend or powers it on during runtime suspend.

Sure, I'll add ^^ in the next re-spin.

> 
>> + *                             otherwise.
>>   */
>>  #define GENPD_FLAG_PM_CLK       (1U << 0)
>>  #define GENPD_FLAG_IRQ_SAFE     (1U << 1)

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
