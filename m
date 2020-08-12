Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1926B242DCD
	for <lists+linux-pm@lfdr.de>; Wed, 12 Aug 2020 19:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726013AbgHLRDB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 Aug 2020 13:03:01 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:12723 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726150AbgHLRDA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 12 Aug 2020 13:03:00 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597251779; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=vmit0zvJ/+aQMlekx6GyOUAp2W179eJeRhhRLjR5tzE=;
 b=iMr6FDqVg21RkXUjVm1mMgbvEHWTcLOoDk+h0rR07mk9f0bTqTMyvJ4KSknVhaFwIleoe3NG
 8TVlgNJ6A5xBZ4C8emnR8jZskJHtT394CTbbqAzI4nD+o/PwbzQ5kZxTetBmPagz124xSNgi
 nNs6/vzs3OQ93LqUrScDSUfneZQ=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 5f3420c1f2b697637a23c939 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 12 Aug 2020 17:02:57
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 010A8C433A0; Wed, 12 Aug 2020 17:02:55 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 03288C433C9;
        Wed, 12 Aug 2020 17:02:54 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 12 Aug 2020 22:32:54 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Andy Gross <agross@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Doug Anderson <dianders@chromium.org>,
        linux-kernel-owner@vger.kernel.org,
        Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH 1/2] PM / Domains: Add GENPD_FLAG_SUSPEND_ON flag
In-Reply-To: <CAPDyKFqNMEtHwcJFxYQP5H1Yjrsr1T3UUZoXes69EthSjAYs2A@mail.gmail.com>
References: <20200811190252.10559-1-sibis@codeaurora.org>
 <CAPDyKFqNMEtHwcJFxYQP5H1Yjrsr1T3UUZoXes69EthSjAYs2A@mail.gmail.com>
Message-ID: <1ba3e4d703dd0a52547d63fa014451eb@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Uffe,
Thanks for taking time to review the
series!

On 2020-08-12 15:15, Ulf Hansson wrote:
> On Tue, 11 Aug 2020 at 21:03, Sibi Sankar <sibis@codeaurora.org> wrote:
>> 
>> This is for power domains which needs to stay powered on for suspend
>> but can be powered on/off as part of runtime PM. This flag is aimed at
>> power domains coupled to remote processors which enter suspend states
>> independent to that of the application processor. Such power domains
>> are turned off only on remote processor crash/shutdown.
> 
> As Kevin also requested, please elaborate more on the use case.
> 
> Why exactly must the PM domain stay powered on during system suspend?
> Is there a wakeup configured that needs to be managed - or is there a
> co-processor/FW behaviour that needs to be obeyed to?

Yes this is a co-processor behavior that
needs to be obeyed. Specifically application
processor notifies the Always on Subsystem
(AOSS) that a particular co-processor is up
using the power domains exposed by AOSS QMP
driver. AOSS uses this information to wait
for the co-processors to suspend before
starting its sleep sequence. The application
processor powers off these power domains only
if the co-processor has crashed or powered
off.

> 
> Kind regards
> Uffe
> 
>> 
>> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
>> ---
>>  drivers/base/power/domain.c | 3 ++-
>>  include/linux/pm_domain.h   | 5 +++++
>>  2 files changed, 7 insertions(+), 1 deletion(-)
>> 
>> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
>> index 2cb5e04cf86cd..ba78ac4a450d4 100644
>> --- a/drivers/base/power/domain.c
>> +++ b/drivers/base/power/domain.c
>> @@ -129,6 +129,7 @@ static const struct genpd_lock_ops genpd_spin_ops 
>> = {
>>  #define genpd_is_active_wakeup(genpd)  (genpd->flags & 
>> GENPD_FLAG_ACTIVE_WAKEUP)
>>  #define genpd_is_cpu_domain(genpd)     (genpd->flags & 
>> GENPD_FLAG_CPU_DOMAIN)
>>  #define genpd_is_rpm_always_on(genpd)  (genpd->flags & 
>> GENPD_FLAG_RPM_ALWAYS_ON)
>> +#define genpd_is_suspend_on(genpd)     (genpd->flags & 
>> GENPD_FLAG_SUSPEND_ON)
>> 
>>  static inline bool irq_safe_dev_in_no_sleep_domain(struct device 
>> *dev,
>>                 const struct generic_pm_domain *genpd)
>> @@ -949,7 +950,7 @@ static void genpd_sync_power_off(struct 
>> generic_pm_domain *genpd, bool use_lock,
>>  {
>>         struct gpd_link *link;
>> 
>> -       if (!genpd_status_on(genpd) || genpd_is_always_on(genpd))
>> +       if (!genpd_status_on(genpd) || genpd_is_always_on(genpd) || 
>> genpd_is_suspend_on(genpd))
>>                 return;
>> 
>>         if (genpd->suspended_count != genpd->device_count
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
>> + *                             otherwise.
>>   */
>>  #define GENPD_FLAG_PM_CLK       (1U << 0)
>>  #define GENPD_FLAG_IRQ_SAFE     (1U << 1)
>> @@ -62,6 +66,7 @@
>>  #define GENPD_FLAG_ACTIVE_WAKEUP (1U << 3)
>>  #define GENPD_FLAG_CPU_DOMAIN   (1U << 4)
>>  #define GENPD_FLAG_RPM_ALWAYS_ON (1U << 5)
>> +#define GENPD_FLAG_SUSPEND_ON   (1U << 6)
>> 
>>  enum gpd_status {
>>         GPD_STATE_ACTIVE = 0,   /* PM domain is active */
>> --
>> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
>> Forum,
>> a Linux Foundation Collaborative Project
>> 

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
