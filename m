Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6CA2ABFC1
	for <lists+linux-pm@lfdr.de>; Mon,  9 Nov 2020 16:24:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730460AbgKIPYQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Nov 2020 10:24:16 -0500
Received: from m42-4.mailgun.net ([69.72.42.4]:16615 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727077AbgKIPYQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 9 Nov 2020 10:24:16 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1604935455; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=//3S/p03gKLapJeXofze2wyHnRwtOgTnPZKQELKIjjk=; b=HuqGSDk8If1WRuhYn4AgH/W2h12uM4Jrwz9x5/XG4lwwnsRFu32qknDoja2r2l5IIz3nxn6/
 TjL9aEkWF3j2O2FjX5Ty/qMCAJak7IsRGWfIvdIcIOQCFWZNEXZPkSrPJl9Y9lDSINVA5QIO
 1AhEWplqe5O1vYNkbVY+Qjuy0u4=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 5fa95f1b61a7f890a660fa38 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 09 Nov 2020 15:24:11
 GMT
Sender: ilina=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B8DC1C433F0; Mon,  9 Nov 2020 15:24:11 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: ilina)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 98A09C433C6;
        Mon,  9 Nov 2020 15:24:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 98A09C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=ilina@codeaurora.org
Date:   Mon, 9 Nov 2020 08:24:09 -0700
From:   Lina Iyer <ilina@codeaurora.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH] PM / Domains: replace -ENOTSUPP with -EOPNOTSUPP
Message-ID: <X6lfGVD2rJGF85+c@codeaurora.org>
References: <20201106164903.3906-1-ilina@codeaurora.org>
 <CAPDyKFqvoAjNVJ6e8r3+tDKkq49h6tev6MPoQ1fHZu9FoOU6Nw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAPDyKFqvoAjNVJ6e8r3+tDKkq49h6tev6MPoQ1fHZu9FoOU6Nw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Nov 09 2020 at 04:40 -0700, Ulf Hansson wrote:
>On Fri, 6 Nov 2020 at 17:49, Lina Iyer <ilina@codeaurora.org> wrote:
>>
>> While submitting a patch to add next_wakeup, checkpatch reported this -
>>
>> WARNING: ENOTSUPP is not a SUSV4 error code, prefer EOPNOTSUPP
>> +       return -ENOTSUPP;
>>
>> Address the above warning in other functions in pm_domain.h.
>>
>> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
>
>I assume you have looked at callers of these functions too, to make
>sure they don't explicitly look at -ENOTSUPP?
>
Yes, the first level callers at least. Most of them seem to return from
probe calls etc. Is there a nice way to make sure the second level
functions and the callers of those are not using -ENOTSUPP return from
these functions.

>Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
>
Thanks.

-- Lina

>Kind regards
>Uffe
>
>> ---
>>  include/linux/pm_domain.h | 14 +++++++-------
>>  1 file changed, 7 insertions(+), 7 deletions(-)
>>
>> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
>> index 49982cd58bfd..e390388e6c17 100644
>> --- a/include/linux/pm_domain.h
>> +++ b/include/linux/pm_domain.h
>> @@ -259,24 +259,24 @@ static inline int pm_genpd_init(struct generic_pm_domain *genpd,
>>  }
>>  static inline int pm_genpd_remove(struct generic_pm_domain *genpd)
>>  {
>> -       return -ENOTSUPP;
>> +       return -EOPNOTSUPP;
>>  }
>>
>>  static inline int dev_pm_genpd_set_performance_state(struct device *dev,
>>                                                      unsigned int state)
>>  {
>> -       return -ENOTSUPP;
>> +       return -EOPNOTSUPP;
>>  }
>>
>>  static inline int dev_pm_genpd_add_notifier(struct device *dev,
>>                                             struct notifier_block *nb)
>>  {
>> -       return -ENOTSUPP;
>> +       return -EOPNOTSUPP;
>>  }
>>
>>  static inline int dev_pm_genpd_remove_notifier(struct device *dev)
>>  {
>> -       return -ENOTSUPP;
>> +       return -EOPNOTSUPP;
>>  }
>>
>>  static inline int dev_pm_genpd_set_next_wakeup(struct device *dev, ktime_t next)
>> @@ -334,13 +334,13 @@ struct device *genpd_dev_pm_attach_by_name(struct device *dev,
>>  static inline int of_genpd_add_provider_simple(struct device_node *np,
>>                                         struct generic_pm_domain *genpd)
>>  {
>> -       return -ENOTSUPP;
>> +       return -EOPNOTSUPP;
>>  }
>>
>>  static inline int of_genpd_add_provider_onecell(struct device_node *np,
>>                                         struct genpd_onecell_data *data)
>>  {
>> -       return -ENOTSUPP;
>> +       return -EOPNOTSUPP;
>>  }
>>
>>  static inline void of_genpd_del_provider(struct device_node *np) {}
>> @@ -396,7 +396,7 @@ static inline struct device *genpd_dev_pm_attach_by_name(struct device *dev,
>>  static inline
>>  struct generic_pm_domain *of_genpd_remove_last(struct device_node *np)
>>  {
>> -       return ERR_PTR(-ENOTSUPP);
>> +       return ERR_PTR(-EOPNOTSUPP);
>>  }
>>  #endif /* CONFIG_PM_GENERIC_DOMAINS_OF */
>>
>> --
>> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
>> a Linux Foundation Collaborative Project
>>
