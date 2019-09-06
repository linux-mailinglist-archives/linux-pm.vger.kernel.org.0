Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49874AC27B
	for <lists+linux-pm@lfdr.de>; Sat,  7 Sep 2019 00:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404880AbfIFWYZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Sep 2019 18:24:25 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:35337 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404877AbfIFWYZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Sep 2019 18:24:25 -0400
Received: by mail-qk1-f195.google.com with SMTP id d26so7342805qkk.2
        for <linux-pm@vger.kernel.org>; Fri, 06 Sep 2019 15:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=NiVBanLevjq3SumitKHtlZU5/wGycLhsTsLa2SLZ6QM=;
        b=kBOUcmWco+MXQZsTTaWPR1+tfSH8An+2xaIR2F1x9XArXt8eFneua6EPVJi4gTDmQw
         Qq+0tp3SYJO8+HkDuwr04erj1r7kdbtg/CCONPmc+ZVsc7IPATzrGr9c2EdDq5kMM76S
         Wg+H5vCDeqJ2FnxAXzyeYCs9mmVtywz1BYWcRF/rPCrnNftOn7OxzMRK+U/kBYYi0Sem
         uWTU0tz3pvIdGz1d82hKApPNPIXm9EHyqiSza/6mB1h7ydm451x6H43UAwSFq+/NKBoL
         sEIttwFGiZvtGAhNG9f4LH+o1sUvoT38DYO+KVjXoWrshe07rGcnXRBJuKVShko72tk/
         HXZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=NiVBanLevjq3SumitKHtlZU5/wGycLhsTsLa2SLZ6QM=;
        b=ZQ+IjqU19AnKf6vLmHBgvxCb5CzwpkdWfxftT/oy4grI3WSVjoc35lFjj4tXgM679U
         OdL+KogFOiYrY+S+k30DA3mXruOD9ufIHeBA1qx1opNMh6fWCDSBtPL7dxV0vgqP1OAS
         /w1XhZh9z7IITJZ4iYKpmeYJi6pCVUgTdnRa7VJEOGtNZdil+FF1JfDrywV5O0dT3Up1
         eMp5+ppNxzuJhfRYy4IymnPVlJ82OLvSWNWZ2uo8Y4k9V+gjGipZOnWNLnVvQt6/S8Ci
         bu8Erq6Z047ytuhOD4S58z4Aq5sUi5wPwOzYQYTv849pLuROneIHDrLVO6FNQZun3Ar3
         n9lQ==
X-Gm-Message-State: APjAAAV3CEbolAjRxpQOywfXA52UWIvlLcAWXjQ1vxKmPwJXPfWYKFh+
        4GCuBJfirfknFc5yIp8KeBwB6Q==
X-Google-Smtp-Source: APXvYqwG21tyXzmYmGqI4rcHaPmnIgnCWQBTkyveqD/LHQoBZDMEOkMFNSF3Ze8xrjDYCjMSEpO1Kw==
X-Received: by 2002:a37:a503:: with SMTP id o3mr11298194qke.115.1567808663718;
        Fri, 06 Sep 2019 15:24:23 -0700 (PDT)
Received: from [192.168.1.169] (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.gmail.com with ESMTPSA id z123sm3508455qke.96.2019.09.06.15.24.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Sep 2019 15:24:21 -0700 (PDT)
Subject: Re: [PATCH 1/4] PM/Domains: Add support for retrieving genpd
 performance states information
To:     Ulf Hansson <ulf.hansson@linaro.org>
References: <1565398727-23090-1-git-send-email-thara.gopinath@linaro.org>
 <1565398727-23090-2-git-send-email-thara.gopinath@linaro.org>
 <CAPDyKFrcK+Jub0gAeevrscoGaHA+PRGmVHZHxB2T6_3Fqm=ceA@mail.gmail.com>
Cc:     qualcomm-lt@lists.linaro.org, Linux PM <linux-pm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <5D72DC94.6040508@linaro.org>
Date:   Fri, 6 Sep 2019 18:24:20 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <CAPDyKFrcK+Jub0gAeevrscoGaHA+PRGmVHZHxB2T6_3Fqm=ceA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 08/22/2019 11:03 AM, Ulf Hansson wrote:
> On Sat, 10 Aug 2019 at 02:58, Thara Gopinath <thara.gopinath@linaro.org> wrote:
>>
>> Add two new APIs in the genpd framework,
>> dev_pm_genpd_get_performance_state to return the current performance
>> state of a power domain and dev_pm_genpd_performance_state_count to
>> return the total number of performance states supported by a
>> power domain. Since the genpd framework does not maintain
>> a count of number of performance states supported by a power domain,
>> introduce a new callback(.get_performance_state_count) that can be used
>> to retrieve this information from power domain drivers.
> 
> I think some brief background to *why* this is useful needs to be
> squeezed into the changelog. Or at least state that following changes
> makes use of it, somehow.
> 
>>
>> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
>> ---
>>  drivers/base/power/domain.c | 38 ++++++++++++++++++++++++++++++++++++++
>>  include/linux/pm_domain.h   | 18 ++++++++++++++++++
>>  2 files changed, 56 insertions(+)
>>
>> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
>> index b063bc4..17e0375 100644
>> --- a/drivers/base/power/domain.c
>> +++ b/drivers/base/power/domain.c
>> @@ -413,6 +413,44 @@ int dev_pm_genpd_set_performance_state(struct device *dev, unsigned int state)
>>  }
>>  EXPORT_SYMBOL_GPL(dev_pm_genpd_set_performance_state);
>>
>> +int dev_pm_genpd_get_performance_state(struct device *dev,
>> +                                      unsigned int *state)
>> +{
>> +       struct generic_pm_domain *genpd;
>> +
>> +       genpd = dev_to_genpd(dev);
> 
> We need to verify that the there is a genpd attached before doing this
> cast. Let me post a patch in a day or so, it will give you a helper
> function that covers this.
> 
>> +       if (IS_ERR(genpd))
>> +               return -ENODEV;
>> +
>> +       genpd_lock(genpd);
>> +       *state = genpd->performance_state;
> 
> Why not return the state, rather than assigning an out-parameter?
> 
>> +       genpd_unlock(genpd);
>> +
>> +       return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(dev_pm_genpd_get_performance_state);
>> +
>> +int dev_pm_genpd_performance_state_count(struct device *dev,
>> +                                        unsigned int *count)
>> +{
>> +       struct generic_pm_domain *genpd;
>> +       int ret;
>> +
>> +       genpd = dev_to_genpd(dev);
>> +       if (IS_ERR(genpd))
>> +               return -ENODEV;
>> +
>> +       if (unlikely(!genpd->get_performance_state_count))
>> +               return -EINVAL;
>> +
>> +       genpd_lock(genpd);
>> +       ret = genpd->get_performance_state_count(genpd, count);
> 
> Why not having the callback to return the state, rather than using an
> out-parameter?
Hi Ulf,
I just realized that returning the state instead of using a parameter
will prevent me from access under lock. Is that okay ?

Regards
Thara
> 
>> +       genpd_unlock(genpd);
>> +
>> +       return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(dev_pm_genpd_performance_state_count);
>> +
>>  static int _genpd_power_on(struct generic_pm_domain *genpd, bool timed)
>>  {
>>         unsigned int state_idx = genpd->state_idx;
>> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
>> index 91d9bf4..0e5f502 100644
>> --- a/include/linux/pm_domain.h
>> +++ b/include/linux/pm_domain.h
>> @@ -117,6 +117,8 @@ struct generic_pm_domain {
>>                                                  struct dev_pm_opp *opp);
>>         int (*set_performance_state)(struct generic_pm_domain *genpd,
>>                                      unsigned int state);
>> +       int (*get_performance_state_count)(struct generic_pm_domain *genpd,
>> +                                          unsigned int *count);
>>         struct gpd_dev_ops dev_ops;
>>         s64 max_off_time_ns;    /* Maximum allowed "suspended" time. */
>>         bool max_off_time_changed;
>> @@ -204,6 +206,10 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
>>                   struct dev_power_governor *gov, bool is_off);
>>  int pm_genpd_remove(struct generic_pm_domain *genpd);
>>  int dev_pm_genpd_set_performance_state(struct device *dev, unsigned int state);
>> +int dev_pm_genpd_get_performance_state(struct device *dev,
>> +                                      unsigned int *state);
>> +int dev_pm_genpd_performance_state_count(struct device *dev,
>> +                                        unsigned int *count);
>>
>>  extern struct dev_power_governor simple_qos_governor;
>>  extern struct dev_power_governor pm_domain_always_on_gov;
>> @@ -251,6 +257,18 @@ static inline int dev_pm_genpd_set_performance_state(struct device *dev,
>>         return -ENOTSUPP;
>>  }
>>
>> +static inline int dev_pm_genpd_get_performance_state(struct device *dev,
>> +                                                    unsigned int *state);
>> +{
>> +       return -ENOTSUPP;
>> +}
>> +
>> +static inline int dev_pm_genpd_performance_state_count(struct device *dev,
>> +                                                      unsigned int *count);
>> +{
>> +       return -ENOTSUPP;
>> +}
>> +
>>  #define simple_qos_governor            (*(struct dev_power_governor *)(NULL))
>>  #define pm_domain_always_on_gov                (*(struct dev_power_governor *)(NULL))
>>  #endif
>> --
>> 2.1.4
>>
> 
> Kind regards
> Uffe
> 


-- 
Regards
Thara
