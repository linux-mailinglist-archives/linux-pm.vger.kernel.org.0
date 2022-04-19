Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7392E506741
	for <lists+linux-pm@lfdr.de>; Tue, 19 Apr 2022 10:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350181AbiDSI5K (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Apr 2022 04:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350225AbiDSI5J (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Apr 2022 04:57:09 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CAE922BCB
        for <linux-pm@vger.kernel.org>; Tue, 19 Apr 2022 01:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1650358458; x=1681894458;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=pv/7Q7nL6KN7jxhzukMmU3oPNjrurxeyXkp5tO2FfaA=;
  b=THgR6sI1X1/6r+ydUaHWXBDwrhoUhHRUSCjQBNY0RuEbWRdXhjpqJBvs
   QIshXju/7Zt0Pn0dw8Oz3BD7Y9W5MgpEnheokQyg7R8FvBF+PYwKChkTp
   DH96c8Q79hfz4z0LTY7Ah0T+oHEHJ6s/AmpXcN89b332vS1LOyY8DRL3I
   8=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 19 Apr 2022 01:54:17 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 01:54:17 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 19 Apr 2022 01:54:16 -0700
Received: from [10.216.21.31] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 19 Apr
 2022 01:54:11 -0700
Message-ID: <bdd78be6-4e6e-f941-52a3-53d1c483cd15@quicinc.com>
Date:   Tue, 19 Apr 2022 14:24:08 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 1/2] PM: runtime: Allow to call __pm_runtime_set_status()
 from atomic context
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        <linux-pm@vger.kernel.org>
CC:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Stephen Boyd" <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <linux-arm-kernel@lists.infradead.org>
References: <20220401141124.27272-1-ulf.hansson@linaro.org>
 <20220401141124.27272-2-ulf.hansson@linaro.org>
From:   "Maulik Shah (mkshah)" <quic_mkshah@quicinc.com>
In-Reply-To: <20220401141124.27272-2-ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 4/1/2022 7:41 PM, Ulf Hansson wrote:
> The only two users of __pm_runtime_set_status() are pm_runtime_set_active()
> and pm_runtime_set_suspended(). These are widely used and should be called
> from non-atomic context to work as expected. However, it would be
> convenient to allow them be called from atomic context too, as shown from a
> subsequent change, so let's add support for this.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Tested-by: Maulik Shah <quic_mkshah@quicinc.com>

Thanks,
Maulik
> ---
>   drivers/base/power/runtime.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> index d4059e6ffeae..91d757914686 100644
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -1210,12 +1210,13 @@ int __pm_runtime_set_status(struct device *dev, unsigned int status)
>   {
>   	struct device *parent = dev->parent;
>   	bool notify_parent = false;
> +	unsigned long flags;
>   	int error = 0;
>   
>   	if (status != RPM_ACTIVE && status != RPM_SUSPENDED)
>   		return -EINVAL;
>   
> -	spin_lock_irq(&dev->power.lock);
> +	spin_lock_irqsave(&dev->power.lock, flags);
>   
>   	/*
>   	 * Prevent PM-runtime from being enabled for the device or return an
> @@ -1226,7 +1227,7 @@ int __pm_runtime_set_status(struct device *dev, unsigned int status)
>   	else
>   		error = -EAGAIN;
>   
> -	spin_unlock_irq(&dev->power.lock);
> +	spin_unlock_irqrestore(&dev->power.lock, flags);
>   
>   	if (error)
>   		return error;
> @@ -1247,7 +1248,7 @@ int __pm_runtime_set_status(struct device *dev, unsigned int status)
>   		device_links_read_unlock(idx);
>   	}
>   
> -	spin_lock_irq(&dev->power.lock);
> +	spin_lock_irqsave(&dev->power.lock, flags);
>   
>   	if (dev->power.runtime_status == status || !parent)
>   		goto out_set;
> @@ -1288,7 +1289,7 @@ int __pm_runtime_set_status(struct device *dev, unsigned int status)
>   		dev->power.runtime_error = 0;
>   
>    out:
> -	spin_unlock_irq(&dev->power.lock);
> +	spin_unlock_irqrestore(&dev->power.lock, flags);
>   
>   	if (notify_parent)
>   		pm_request_idle(parent);
