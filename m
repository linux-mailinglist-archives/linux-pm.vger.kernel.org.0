Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7322246E9C
	for <lists+linux-pm@lfdr.de>; Mon, 17 Aug 2020 19:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389014AbgHQRdt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 17 Aug 2020 13:33:49 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:58782 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389021AbgHQQuW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 Aug 2020 12:50:22 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597683021; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=GhyGcHtsJNSaWRlw4MXPmZ9Q7h5P+6kgTtX8VYoSKpY=;
 b=oG2E2fsPlOwWTfzzRyTRsU3HoA04Fk1ZdbyUSouafeqrGdiWxZphQ0Pu5GT39oUnC+LnwFzl
 BkJYXD/6Wqs+frqWc8morJVqkhTPUXkQ2QO2VQpOkgbiJ4z6ETz6iixXRqgdnmldRzxoMWNk
 V1yJ9yAYMYrt5ZPnWUmkAckQ3hU=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 5f3ab512f2b697637a950741 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 17 Aug 2020 16:49:22
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9E919C433AF; Mon, 17 Aug 2020 16:49:21 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2A69FC43391;
        Mon, 17 Aug 2020 16:49:20 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 17 Aug 2020 22:19:20 +0530
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
        Kevin Hilman <khilman@kernel.org>,
        linux-arm-msm-owner@vger.kernel.org
Subject: Re: [PATCH 1/2] PM / Domains: Add GENPD_FLAG_SUSPEND_ON flag
In-Reply-To: <CAPDyKFrqxRrWSX5VaMy4DSjFNaMikKBYsZy5NiPMJvUybYttsw@mail.gmail.com>
References: <20200811190252.10559-1-sibis@codeaurora.org>
 <CAPDyKFqNMEtHwcJFxYQP5H1Yjrsr1T3UUZoXes69EthSjAYs2A@mail.gmail.com>
 <1ba3e4d703dd0a52547d63fa014451eb@codeaurora.org>
 <CAPDyKFrH9WTg4O5L+e1AijNvsagLYZ9QVTeoD0x0SQgYd3hkBg@mail.gmail.com>
 <1ca666c336ebee569a429e729d5ae547@codeaurora.org>
 <CAPDyKFrqxRrWSX5VaMy4DSjFNaMikKBYsZy5NiPMJvUybYttsw@mail.gmail.com>
Message-ID: <33169e221707a2456397e478b275cfa9@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2020-08-17 14:14, Ulf Hansson wrote:
> On Thu, 13 Aug 2020 at 19:26, Sibi Sankar <sibis@codeaurora.org> wrote:
>> 
>> On 2020-08-13 18:04, Ulf Hansson wrote:
>> > On Wed, 12 Aug 2020 at 19:03, Sibi Sankar <sibis@codeaurora.org> wrote:
>> >>
>> >> Uffe,
>> >> Thanks for taking time to review the
>> >> series!
>> >>
>> >> On 2020-08-12 15:15, Ulf Hansson wrote:
>> >> > On Tue, 11 Aug 2020 at 21:03, Sibi Sankar <sibis@codeaurora.org> wrote:
>> >> >>
>> >> >> This is for power domains which needs to stay powered on for suspend
>> >> >> but can be powered on/off as part of runtime PM. This flag is aimed at
>> >> >> power domains coupled to remote processors which enter suspend states
>> >> >> independent to that of the application processor. Such power domains
>> >> >> are turned off only on remote processor crash/shutdown.
>> >> >
>> >> > As Kevin also requested, please elaborate more on the use case.
>> >> >
>> >> > Why exactly must the PM domain stay powered on during system suspend?
>> >> > Is there a wakeup configured that needs to be managed - or is there a
>> >> > co-processor/FW behaviour that needs to be obeyed to?
>> >>
>> >> Yes this is a co-processor behavior that
>> >> needs to be obeyed. Specifically application
>> >> processor notifies the Always on Subsystem
>> >> (AOSS) that a particular co-processor is up
>> >> using the power domains exposed by AOSS QMP
>> >> driver. AOSS uses this information to wait
>> >> for the co-processors to suspend before
>> >> starting its sleep sequence. The application
>> >> processor powers off these power domains only
>> >> if the co-processor has crashed or powered
>> >> off.
>> >
>> > Thanks for clarifying!
>> >
>> > Although, can you please elaborate a bit more on the actual use case?
>> > What are the typical co-processor and what drivers are involved in
>> > managing it?
>> 
>> The co-processors using the power domains
>> exposed by qcom_aoss driver are modem,
>> audio dsp, compute dsp managed using
>> qcom_q6v5_mss and qcom_q6v5_pas driver.
>> 
>> >
>> > As you may know, runtime PM becomes disabled during system suspend of
>> > a device. Which means, if the driver tries to power off the
>> > coprocessor (via calling pm_runtime_put() for example), somewhere in
>> > the system suspend phase of the corresponding device, its attached PM
>> > domain stays powered on when managed by genpd.
>> 
>> The drivers aren't really expected
>> do anything during suspend/resume
>> pretty much because the co-processors
>> enter low-power modes independent to
>> that of the application processor. On
>> co-processor crash the remoteproc core
>> does a pm_stay_awake followed by a
>> pm_relax after crash recovery.
> 
> Okay, thanks again for clarifying. You have convinced me about the
> need for a new flag to cope with these use cases.
> 
> Would you mind updating the commit message with some of the
> information you just provided?
> 
> Additionally, to make it clear that the flag should be used to keep
> the PM domain powered on during system suspend, but only if it's
> already powered on - please rename the flag to GENPD_FLAG_NO_SUSPEND,
> and update the corresponding description of it in the header file.

Thanks, naming it ^^ makes more sense :)

https://lore.kernel.org/lkml/340a7aafcf0301ff3158a4e211992041@codeaurora.org/

Also we wouldn't want to power on
runtime suspended power domains with
the NO_SUSPEND flag set, on resume as
explained ^^. Do you agree with that
as well?

> 
> [...]
> 
> Kind regards
> Uffe

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
