Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26942243E43
	for <lists+linux-pm@lfdr.de>; Thu, 13 Aug 2020 19:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbgHMR0r (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Aug 2020 13:26:47 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:17047 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726427AbgHMR0q (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Aug 2020 13:26:46 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597339604; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=oi6P8fKsHQ4rH2DcZ8NplCdAFudKxyEMedgiGuidvB4=;
 b=n0y2X5Hwq1y/ZWLpnBtFSEIE/01gurdj4UtaNUG5Ox/ptAbls4R5hECFR4iCY89XR/8oGHFB
 2BoHsMB8msL/EOK6t5AadD3ku0/t7BKKZBs2NXbMSYdFCvg5phpOYMcd4Ahnj9Qacc67YGKE
 uXr6zfTsi80U7Ljed5AOCBFTcw4=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 5f3577be2f4952907dd24814 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 13 Aug 2020 17:26:22
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B2C91C4339C; Thu, 13 Aug 2020 17:26:21 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A15FDC433CA;
        Thu, 13 Aug 2020 17:26:20 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 13 Aug 2020 22:56:20 +0530
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
In-Reply-To: <CAPDyKFrH9WTg4O5L+e1AijNvsagLYZ9QVTeoD0x0SQgYd3hkBg@mail.gmail.com>
References: <20200811190252.10559-1-sibis@codeaurora.org>
 <CAPDyKFqNMEtHwcJFxYQP5H1Yjrsr1T3UUZoXes69EthSjAYs2A@mail.gmail.com>
 <1ba3e4d703dd0a52547d63fa014451eb@codeaurora.org>
 <CAPDyKFrH9WTg4O5L+e1AijNvsagLYZ9QVTeoD0x0SQgYd3hkBg@mail.gmail.com>
Message-ID: <1ca666c336ebee569a429e729d5ae547@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2020-08-13 18:04, Ulf Hansson wrote:
> On Wed, 12 Aug 2020 at 19:03, Sibi Sankar <sibis@codeaurora.org> wrote:
>> 
>> Uffe,
>> Thanks for taking time to review the
>> series!
>> 
>> On 2020-08-12 15:15, Ulf Hansson wrote:
>> > On Tue, 11 Aug 2020 at 21:03, Sibi Sankar <sibis@codeaurora.org> wrote:
>> >>
>> >> This is for power domains which needs to stay powered on for suspend
>> >> but can be powered on/off as part of runtime PM. This flag is aimed at
>> >> power domains coupled to remote processors which enter suspend states
>> >> independent to that of the application processor. Such power domains
>> >> are turned off only on remote processor crash/shutdown.
>> >
>> > As Kevin also requested, please elaborate more on the use case.
>> >
>> > Why exactly must the PM domain stay powered on during system suspend?
>> > Is there a wakeup configured that needs to be managed - or is there a
>> > co-processor/FW behaviour that needs to be obeyed to?
>> 
>> Yes this is a co-processor behavior that
>> needs to be obeyed. Specifically application
>> processor notifies the Always on Subsystem
>> (AOSS) that a particular co-processor is up
>> using the power domains exposed by AOSS QMP
>> driver. AOSS uses this information to wait
>> for the co-processors to suspend before
>> starting its sleep sequence. The application
>> processor powers off these power domains only
>> if the co-processor has crashed or powered
>> off.
> 
> Thanks for clarifying!
> 
> Although, can you please elaborate a bit more on the actual use case?
> What are the typical co-processor and what drivers are involved in
> managing it?

The co-processors using the power domains
exposed by qcom_aoss driver are modem,
audio dsp, compute dsp managed using
qcom_q6v5_mss and qcom_q6v5_pas driver.

> 
> As you may know, runtime PM becomes disabled during system suspend of
> a device. Which means, if the driver tries to power off the
> coprocessor (via calling pm_runtime_put() for example), somewhere in
> the system suspend phase of the corresponding device, its attached PM
> domain stays powered on when managed by genpd.

The drivers aren't really expected
do anything during suspend/resume
pretty much because the co-processors
enter low-power modes independent to
that of the application processor. On
co-processor crash the remoteproc core
does a pm_stay_awake followed by a
pm_relax after crash recovery.

> 
> Then in the suspend_noirq phase, genpd tries to power off the PM
> domain, unless there are wakeups to consider.
> 
> Taking the above into account, wouldn't that mean that you potentially
> may end up keeping the PM domain powered on, even if it actually can
> be powered off in the suspend_noirq phase by genpd?
> 
> Kind regards
> Uffe
> 
>> >
>> >>
>> >> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
>> >> ---
>> >>  drivers/base/power/domain.c | 3 ++-
>> >>  include/linux/pm_domain.h   | 5 +++++
>> >>  2 files changed, 7 insertions(+), 1 deletion(-)
>> >>
>> >> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
>> >> index 2cb5e04cf86cd..ba78ac4a450d4 100644
>> >> --- a/drivers/base/power/domain.c
>> >> +++ b/drivers/base/power/domain.c
>> >> @@ -129,6 +129,7 @@ static const struct genpd_lock_ops genpd_spin_ops
>> >> = {
>> >>  #define genpd_is_active_wakeup(genpd)  (genpd->flags &
>> >> GENPD_FLAG_ACTIVE_WAKEUP)
>> >>  #define genpd_is_cpu_domain(genpd)     (genpd->flags &
>> >> GENPD_FLAG_CPU_DOMAIN)
>> >>  #define genpd_is_rpm_always_on(genpd)  (genpd->flags &
>> >> GENPD_FLAG_RPM_ALWAYS_ON)
>> >> +#define genpd_is_suspend_on(genpd)     (genpd->flags &
>> >> GENPD_FLAG_SUSPEND_ON)
>> >>
>> >>  static inline bool irq_safe_dev_in_no_sleep_domain(struct device
>> >> *dev,
>> >>                 const struct generic_pm_domain *genpd)
>> >> @@ -949,7 +950,7 @@ static void genpd_sync_power_off(struct
>> >> generic_pm_domain *genpd, bool use_lock,
>> >>  {
>> >>         struct gpd_link *link;
>> >>
>> >> -       if (!genpd_status_on(genpd) || genpd_is_always_on(genpd))
>> >> +       if (!genpd_status_on(genpd) || genpd_is_always_on(genpd) ||
>> >> genpd_is_suspend_on(genpd))
>> >>                 return;
>> >>
>> >>         if (genpd->suspended_count != genpd->device_count
>> >> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
>> >> index ee11502a575b0..3002a2d68936a 100644
>> >> --- a/include/linux/pm_domain.h
>> >> +++ b/include/linux/pm_domain.h
>> >> @@ -55,6 +55,10 @@
>> >>   *
>> >>   * GENPD_FLAG_RPM_ALWAYS_ON:   Instructs genpd to always keep the PM
>> >> domain
>> >>   *                             powered on except for system suspend.
>> >> + *
>> >> + * GENPD_FLAG_SUSPEND_ON:      Instructs genpd to keep the PM domain
>> >> powered
>> >> + *                             on during suspend and runtime PM
>> >> controlled
>> >> + *                             otherwise.
>> >>   */
>> >>  #define GENPD_FLAG_PM_CLK       (1U << 0)
>> >>  #define GENPD_FLAG_IRQ_SAFE     (1U << 1)
>> >> @@ -62,6 +66,7 @@
>> >>  #define GENPD_FLAG_ACTIVE_WAKEUP (1U << 3)
>> >>  #define GENPD_FLAG_CPU_DOMAIN   (1U << 4)
>> >>  #define GENPD_FLAG_RPM_ALWAYS_ON (1U << 5)
>> >> +#define GENPD_FLAG_SUSPEND_ON   (1U << 6)
>> >>
>> >>  enum gpd_status {
>> >>         GPD_STATE_ACTIVE = 0,   /* PM domain is active */
>> >> --
>> >> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
>> >> Forum,
>> >> a Linux Foundation Collaborative Project
>> >>
>> 
>> --
>> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
>> a Linux Foundation Collaborative Project.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
