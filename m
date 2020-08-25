Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CACC8251D55
	for <lists+linux-pm@lfdr.de>; Tue, 25 Aug 2020 18:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgHYQiI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Aug 2020 12:38:08 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:52125 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725805AbgHYQiI (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 25 Aug 2020 12:38:08 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1598373486; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=/lwIoJgA3N5kyPnMGSl5QZyU7eZUloRHW8mD2xzFjXQ=;
 b=cnFpRk51D3c3cQwppAdhisetI0oVddV0c1btCYcGC+tiWLkWC688EJc5vmlhrc6lRvl+8eJB
 jh/hqjH5rvTcoYYKDRUGvY5Qvv6ZBGlectLah+6Ko9tr0b8DpAus8ljZauR32RTPtNkvmAc8
 J44vvDdxKeeGgeJfv6HUMALsKgA=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 5f453e55f558dbf2802aa87f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 25 Aug 2020 16:37:41
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9456BC43395; Tue, 25 Aug 2020 16:37:40 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 70C32C433C6;
        Tue, 25 Aug 2020 16:37:39 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 25 Aug 2020 22:07:39 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>, khilman@kernel.org,
        ulf.hansson@linaro.org, rjw@rjwysocki.net, agross@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, gregkh@linuxfoundation.org, pavel@ucw.cz,
        len.brown@intel.com, rnayak@codeaurora.org, dianders@chromium.org,
        mka@chromium.org, linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH v2 1/2] PM / Domains: Add GENPD_FLAG_NO_SUSPEND/RESUME
 flags
In-Reply-To: <159834001729.334488.11862381163144726708@swboyd.mtv.corp.google.com>
References: <20200821204921.32536-1-sibis@codeaurora.org>
 <159804608868.334488.2486130699850456264@swboyd.mtv.corp.google.com>
 <20200824164212.GA3715@yoga>
 <159834001729.334488.11862381163144726708@swboyd.mtv.corp.google.com>
Message-ID: <c79fa653edb13ee88e5d4708675cd64f@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2020-08-25 12:50, Stephen Boyd wrote:
> Quoting Bjorn Andersson (2020-08-24 09:42:12)
>> On Fri 21 Aug 14:41 PDT 2020, Stephen Boyd wrote:
>> 
>> > Quoting Sibi Sankar (2020-08-21 13:49:20)
>> > > Add GENPD_FLAG_NO_SUSPEND/RESUME flags to instruct genpd to keep the
>> > > status of the PM domain unaltered during suspend/resume respectively.
>> > > The flags are aimed at power domains coupled to co-processors which
>> > > enter low-power modes independent to that of the application processor.
>> > >
>> > > Specifically the flags are to be used by the power domains exposed
>> > > by the AOSS QMP driver linked to modem, adsp, cdsp remoteprocs. These
>> > > power domains are used to notify the Always on Subsystem (AOSS) that
>> > > a particular co-processor is up. AOSS uses this information to wait
>> > > for the co-processors to suspend before starting its sleep sequence.
>> > > The application processor powers off these power domains only if the
>> > > co-processor has crashed or powered off and remains unaltered during
>> > > system suspend/resume.
>> >
>> > Why are these power domains instead of some QMP message sent during
>> > remote proc power up?
>> 
>> The understanding I gained as I researched this, was that with this
>> property enabled resources related to the particular subsystem will be
>> kept enabled when the apss enters some power save mode. So my
>> interpretation was that it does "keep something powered".
> 
> It looks like it tells AOSS that the processor is booted and to start
> considering these processors in the SoC wide system suspend sequence.
> Otherwise I guess the RPMh buckets associated with these remoteprocs
> don't count in the aggregation and sleep/wake sequences that AOSS runs
> through when putting the SoC into low power mode. I'm not sure it
> actually "keeps something powered" so much as it lets something be
> powered off. Sibi?

That is just a part of equation i.e
AOSS doesn't enter sleep until the
remote processors enter RPMh assisted
sleep. This also implies that if the
respective remote processor has to come
out of low power states it will need
to wait for AOSS to come out of sleep.
So clearly remote processors are dependent
on certain resources to be enabled by
the AOSS but the resources may not be
restricted to just corners.

> 
> Another question, why can't the processors tell AOSS themselves about
> their boot state? I guess because they may crash or be powered down and
> then AOSS wouldn't know? Fair enough I guess, but I don't think this is
> mentioned anywhere.
> 
>> 
>> > If this has been discussed before feel free to
>> > disregard and please link to prior mailing list discussions.
>> >
>> 
>> There where some discussions related to the "QDSS clk" in that series,
>> but I don't remember getting any feedback on modelling these things as
>> power-domains.
>> 
>> > I find it odd that this is modeled as a power domain instead of some
>> > Qualcomm specific message that the remoteproc driver sends to AOSS. Is
>> > there some sort of benefit the driver gets from using the power domain
>> > APIs for this vs. using a custom API?
>> 
>> We need to send "up" and "down" notifications and this needs to happen
>> at the same time as other standard resources are enabled/disabled.
>> 
>> Further more, at the time the all resources handled by the downstream
>> driver was either power-domains (per above understanding) or clocks, 
>> so
>> it made sense to me not to spin up a custom API.
>> 
> 
> So the benefit is not spinning up a custom API? I'm not Ulf, but it
> looks like this is hard to rationalize about as a power domain. It
> doesn't have any benefit to model it this way besides to make it
> possible to turn on with other power domains.
> 
> This modem remoteproc drivers isn't SoC agnostic anyway, it relies on
> SMEM APIs, so standing up another small qmp_remoteproc_booted() and
> qmp_remoteproc_shutdown() API would avoid adding a genpd flag here that
> probably will never be used outside of this corner-case. There is also
> some get/put EPROBE_DEFER sort of logic to implement, but otherwise it
> would be possible to do this outside of power domains, and that seems
> better given that this isn't really a power domain to start with.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
