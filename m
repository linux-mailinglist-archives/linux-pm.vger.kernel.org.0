Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87211242CE9
	for <lists+linux-pm@lfdr.de>; Wed, 12 Aug 2020 18:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbgHLQNL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 Aug 2020 12:13:11 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:44376 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726658AbgHLQNL (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 12 Aug 2020 12:13:11 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597248790; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=VfMixFtX/OTlr/zRJajyB7g4shFSBIZI0I68qcvTqMQ=;
 b=oC38/lHQsSk8ZL/Qf9VzCgvKboTCJMUAru4SR4HGecFhgS79HcbkKZEmKVkKONvF4+mccnCe
 vYa6AaW5fGT9QWsTQ75M2BZaB16gDh5dpxbtCbSLJNJvmdkhC7fM/V/HsJWSdstf6mcavisf
 +iIY7MpDzrYbPLaMDsfMTG5dtJg=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 5f34150d46ed9966744cf830 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 12 Aug 2020 16:13:01
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B8738C433AF; Wed, 12 Aug 2020 16:13:00 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AF06EC433C9;
        Wed, 12 Aug 2020 16:12:59 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 12 Aug 2020 21:42:59 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     bjorn.andersson@linaro.org, ulf.hansson@linaro.org,
        rjw@rjwysocki.net, agross@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        gregkh@linuxfoundation.org, pavel@ucw.cz, len.brown@intel.com,
        rnayak@codeaurora.org, dianders@chromium.org, khilman@kernel.org,
        linux-arm-msm-owner@vger.kernel.org
Subject: Re: [PATCH 1/2] PM / Domains: Add GENPD_FLAG_SUSPEND_ON flag
In-Reply-To: <7heeoc3edk.fsf@baylibre.com>
References: <20200811190252.10559-1-sibis@codeaurora.org>
 <7heeoc3edk.fsf@baylibre.com>
Message-ID: <340a7aafcf0301ff3158a4e211992041@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Kevin,
Thanks for taking time to review the
series!

On 2020-08-12 05:49, Kevin Hilman wrote:
> Sibi Sankar <sibis@codeaurora.org> writes:
> 
>> This is for power domains which needs to stay powered on for suspend
>> but can be powered on/off as part of runtime PM. This flag is aimed at
>> power domains coupled to remote processors which enter suspend states
>> independent to that of the application processor. Such power domains
>> are turned off only on remote processor crash/shutdown.
>> 
>> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> 
> Seems like a useful use-case, but i think there should be a bit more
> description/documentation about what is the expected/desired behavior
> during system suspsend when a power-domain with this flag is already
> runtime-PM suspended.  Similarily, on system resume, what is the
> expected/desired behavior?

SUSPEND_ON flag is only aimed at
keeping power domains powered on
across suspend (only if its already
powered on). Also if the power domain
is runtime-PM suspended we wouldn't
want to power it on during resume.

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 0a5afca250d03..547c091618008 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1003,7 +1003,7 @@ static void genpd_sync_power_on(struct 
generic_pm_domain *genpd, bool use_lock,
  {
         struct gpd_link *link;

-       if (genpd_status_on(genpd))
+       if (genpd_status_on(genpd) || genpd_is_suspend_on(genpd))
                 return;

I'll add the ^^ diff in the next
re-spin to prevent power on of
a runtime-PM suspended power
domain.

> 
> Kevin

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
