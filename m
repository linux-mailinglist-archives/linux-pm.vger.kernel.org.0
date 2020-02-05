Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F55415307F
	for <lists+linux-pm@lfdr.de>; Wed,  5 Feb 2020 13:23:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbgBEMXN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 5 Feb 2020 07:23:13 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:45894 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727043AbgBEMXM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 5 Feb 2020 07:23:12 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1580905392; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=uMCCQYZszq+bmmu00qnksmPsuxhQeLZVhG8wCPSsiv4=; b=tZO4pir53aN/fGFLOwpUTNRkRMsXSyi0FY55VAhSBaVa8tHKCEzM19qNV4cF2+SL+HK2W+rO
 GiBTPt2ycqQ/03iJpOjMez80nasZHsCUQeLSUkD0l992ftEZ0WN7QKqvnbvZcRUK8E2uZrH9
 Fp7O2YRu2k98uk0GElEaZ9dr96g=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e3ab3ad.7f81a21f6dc0-smtp-out-n02;
 Wed, 05 Feb 2020 12:23:09 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 11713C447A3; Wed,  5 Feb 2020 12:23:09 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from [10.206.13.37] (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mkshah)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3B304C433CB;
        Wed,  5 Feb 2020 12:23:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3B304C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=mkshah@codeaurora.org
Subject: Re: [PATCH v3 5/7] drivers: firmware: psci: Add hierarchical domain
 idle states converter
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     swboyd@chromium.org, agross@kernel.org, david.brown@linaro.org,
        Lorenzo.Pieralisi@arm.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, bjorn.andersson@linaro.org,
        evgreen@chromium.org, dianders@chromium.org, rnayak@codeaurora.org,
        ilina@codeaurora.org, lsrao@codeaurora.org, ulf.hansson@linaro.org,
        rjw@rjwysocki.net
References: <1580736940-6985-1-git-send-email-mkshah@codeaurora.org>
 <1580736940-6985-6-git-send-email-mkshah@codeaurora.org>
 <20200203170832.GA38466@bogus>
 <0d7f7ade-3a1e-5428-d851-f1a886f58712@codeaurora.org>
 <20200204152132.GA44858@bogus>
From:   Maulik Shah <mkshah@codeaurora.org>
Message-ID: <6ff7c82d-4204-a339-4070-0154ab4515f1@codeaurora.org>
Date:   Wed, 5 Feb 2020 17:53:00 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200204152132.GA44858@bogus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 2/4/2020 8:51 PM, Sudeep Holla wrote:
> On Tue, Feb 04, 2020 at 10:22:42AM +0530, Maulik Shah wrote:
>> On 2/3/2020 10:38 PM, Sudeep Holla wrote:
>>> On Mon, Feb 03, 2020 at 07:05:38PM +0530, Maulik Shah wrote:
>>>> From: Ulf Hansson <ulf.hansson@linaro.org>
>>>>
>>>> If the hierarchical CPU topology is used, but the OS initiated mode isn't
>>>> supported, we need to rely solely on the regular cpuidle framework to
>>>> manage the idle state selection, rather than using genpd and its
>>>> governor.
>>>>
>>>> For this reason, introduce a new PSCI DT helper function,
>>>> psci_dt_pm_domains_parse_states(), which parses and converts the
>>>> hierarchically described domain idle states from DT, into regular flattened
>>>> cpuidle states. The converted states are added to the existing cpuidle
>>>> driver's array of idle states, which make them available for cpuidle.
>>>>
>>> And what's the main motivation for this if OSI is not supported in the
>>> firmware ?
>> Hi Sudeep,
>>
>> Main motivation is to do last-man activities before the CPU cluster can
>> enter a deep idle state.
>>
> Details on those last-man activities will help the discussion. Basically
> I am wondering what they are and why they need to done in OSPM ?

Hi Sudeep,

there are cases like,

Last cpu going to deepest idle mode need to lower various resoruce 
requirements (for eg DDR freq).

This is done by calling rpmh_flush which send SLEEP values for various 
shared resources.

>>>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>>>> [applied to new path, resolved conflicts]
>>>> Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
>>>> ---
>>>>    drivers/cpuidle/cpuidle-psci-domain.c | 137 +++++++++++++++++++++++++++++-----
>>>>    drivers/cpuidle/cpuidle-psci.c        |  41 +++++-----
>>>>    drivers/cpuidle/cpuidle-psci.h        |  11 +++
>>>>    3 files changed, 153 insertions(+), 36 deletions(-)
>>>>
>>>> diff --git a/drivers/cpuidle/cpuidle-psci-domain.c b/drivers/cpuidle/cpuidle-psci-domain.c
>>>> index 423f03b..3c417f7 100644
>>>> --- a/drivers/cpuidle/cpuidle-psci-domain.c
>>>> +++ b/drivers/cpuidle/cpuidle-psci-domain.c
>>>> @@ -26,13 +26,17 @@ struct psci_pd_provider {
>>>>    };
>>>>
>>>>    static LIST_HEAD(psci_pd_providers);
>>>> -static bool osi_mode_enabled __initdata;
>>>> +static bool osi_mode_enabled;
>>>>
>>>>    static int psci_pd_power_off(struct generic_pm_domain *pd)
>>>>    {
>>>>    	struct genpd_power_state *state = &pd->states[pd->state_idx];
>>>>    	u32 *pd_state;
>>>>
>>>> +	/* If we have failed to enable OSI mode, then abort power off. */
>>>> +	if ((psci_has_osi_support()) && !osi_mode_enabled)
>>>> +		return -EBUSY;
>>>> +
>>> Why is this needed ? IIUC we don't create genpd domains if OSI is not
>>> enabled.
>> we do create genpd domains, for cpu domains, we just abort power off here
>> since idle states are converted into regular flattened mode.
>>
> OK, IIRC the OSI patches from Ulf didn't add the genpd or rather removed
> them in case of any failure to enable OSI. Has that been changed ? If so,
> why ?
>
>> however genpd poweroff will be used by parent domain (rsc in this case)
>> which is kept in hireachy in DTSI with cluster domain to do last man
>> activities.
>>
> I am bit confused here. Either we do OSI or PC and what you are describing
> sounds like a mix-n-match to me and I am totally against it.

we still do PC based on sc7180. there is no OSI.

can you please check v4 series, i have cleaned this change by remove 
converter part.

Thanks,

Maulik

>
> --
> Regards,
> Sudeep

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
