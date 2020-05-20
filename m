Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F4AE1DB052
	for <lists+linux-pm@lfdr.de>; Wed, 20 May 2020 12:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbgETKhM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 May 2020 06:37:12 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42242 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbgETKhM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 May 2020 06:37:12 -0400
Received: by mail-ot1-f66.google.com with SMTP id z3so2032660otp.9;
        Wed, 20 May 2020 03:37:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ASonDY+95FDMvdOqz32QoR73PCQHkHwqQypKyt3/bUg=;
        b=BpBpi6fSGZvuvozYgvzG0Gz82yTPNiwHcT1UOAn++ZM0RRk9PZuWUogHvY44ClAT0c
         oLbfXYuG08miJlCgmtVQJljjR/xnqlyxpJDsOQ0URB3pIHrWkDwRdb7KV8EkZB7IBmig
         OKmsKavI9QGFK89MtSjTJTXx3vPrCXf1yzx1TXE83hSS7msyQHYfWEX+tsPU6gOGOfhz
         zVi24MjSW1cMI4TyRCDakLo5XgYsbINzIOGI208upXdRltkagpkOEH0JZfwYTAje478t
         GPM6NxnAh7AA9TTIxAt+YWXZ53tVP6oOtfu4QXIzQ1tMgf35V9enlKoHGf/MMd586plp
         nmZg==
X-Gm-Message-State: AOAM532mLx7dckhQB9qtn0zgmfoH0txqLngUdzKhyjd0Jo697NBQ3g1V
        MmVirUUHjoClw9hP3k2WQxfKUVDWtKmZ+7MLO+j8FQ==
X-Google-Smtp-Source: ABdhPJxXsufqRfsn8f7DdgrN2DBEOfH/qeFjz5PQh3uG73UqCy4IWc4dkzco8x6WEZbwndUpu/3ez3HRP6WO3LqRzkw=
X-Received: by 2002:a9d:3d05:: with SMTP id a5mr2701651otc.262.1589971031340;
 Wed, 20 May 2020 03:37:11 -0700 (PDT)
MIME-Version: 1.0
References: <1589888489-13828-1-git-send-email-wangxiongfeng2@huawei.com>
 <1589888489-13828-2-git-send-email-wangxiongfeng2@huawei.com> <20200520045911.amww3nm3e7cezcbf@vireshk-i7>
In-Reply-To: <20200520045911.amww3nm3e7cezcbf@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 20 May 2020 12:36:59 +0200
Message-ID: <CAJZ5v0gooW-qN0s03rU9ksxsNvxU4ZSZgXGSGaEcg-s16TnvUw@mail.gmail.com>
Subject: Re: [RFC PATCH v3 1/2] cpufreq: change '.set_boost' to act on only
 one policy
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Thanu.Rangarajan@arm.com, Sudeep Holla <Sudeep.Holla@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        John Garry <john.garry@huawei.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, May 20, 2020 at 6:59 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 19-05-20, 19:41, Xiongfeng Wang wrote:
> > Macro 'for_each_active_policy()' is defined internally. To avoid some
> > cpufreq driver needing this macro to iterate over all the policies in
> > '.set_boost' callback, we redefine '.set_boost' to act on only one
> > policy and pass the policy as an argument.
> > 'cpufreq_boost_trigger_state()' iterate over all the policies to set
> > boost for the system. This is preparation for adding SW BOOST support
> > for CPPC.
> >
> > Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
> > ---
> >  drivers/cpufreq/acpi-cpufreq.c |  4 ++--
> >  drivers/cpufreq/cpufreq.c      | 53 +++++++++++++++++++++---------------------
> >  include/linux/cpufreq.h        |  2 +-
> >  3 files changed, 30 insertions(+), 29 deletions(-)
> >
> > diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
> > index 289e8ce..b0a9eb5 100644
> > --- a/drivers/cpufreq/acpi-cpufreq.c
> > +++ b/drivers/cpufreq/acpi-cpufreq.c
> > @@ -126,7 +126,7 @@ static void boost_set_msr_each(void *p_en)
> >       boost_set_msr(enable);
> >  }
> >
> > -static int set_boost(int val)
> > +static int set_boost(struct cpufreq_policy *policy, int val)
> >  {
> >       get_online_cpus();
> >       on_each_cpu(boost_set_msr_each, (void *)(long)val, 1);
>
> I think (Rafael can confirm), that you need to update this as well. You don't
> need to run for each cpu now, but for each CPU in the policy.

Right, the caller will iterate over policies.

Accordingly, the CPU hotplug locking needs to go to the caller too.
