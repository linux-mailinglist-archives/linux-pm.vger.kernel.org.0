Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3801F2579
	for <lists+linux-pm@lfdr.de>; Thu,  7 Nov 2019 03:34:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728589AbfKGCeq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 Nov 2019 21:34:46 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45189 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727924AbfKGCeq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 Nov 2019 21:34:46 -0500
Received: by mail-pf1-f194.google.com with SMTP id z4so1131499pfn.12
        for <linux-pm@vger.kernel.org>; Wed, 06 Nov 2019 18:34:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CwdFiEKwadDG8v8xoQDuMWfEZ8t4q4eyXWL0NRTG4os=;
        b=AC/CqWgT9hTMzW9X5jOu8xfeCMtqMGQxMjdmv+MMyQfeZO0hLQEAMyqf+uGCXGNGij
         K0u00NCWjzU8WXSxwJU6+aLnAFadxq2fNy/Wo1zI1ajPjc+HmwJ46XvCDqbuU1ASggDN
         p7u3U9HNQ3G975P/aOd9Xm4g5oJFcCfZ8NIVSVkyGNCkpCusBLt2Sui7LwS9HoVeD0+Y
         Nt7W1Ervpxw8i8jKiDqzOIincDSln7QtYSE4s28IcZLzSeF26P43ea1iWZMDHoqukcAC
         jFn8DmsMXpSjkDZLfjq+EPv/idjrtMq/tk7xgyQGsNaR9AfZWt3FASYDmhXSTQ/9D4SR
         syZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CwdFiEKwadDG8v8xoQDuMWfEZ8t4q4eyXWL0NRTG4os=;
        b=jhj2SBaRj7bY1javUgJgnePDwHT9HWfY67JZl7eJ/UwjDd8m11V+/h86BkYbXYQJMU
         N4yQT0E3NjTzul8TsPsRCTHAmylG61lnK2ab66npYvEZulftyAUagse0SLNzM7zCrE0a
         hi5wWpVgaQmYYwwtTR2SyQKkgi8dckU+VJEStwQzwb+FrfKoPo4tAxBjE8hAcgDxyeXB
         ObWOzzJ7fY7+Q/o9CELI8K/TIv4DIOHFs4eQkfYpIIPfNDas6Gz4JqbPsjWRzyh/9aD6
         Z+xD1k20NjXd64ELWqpRXysTaumMes+pK/Phi5HMVXaqbNfuSQFsEcYgYRB+xXDyYjbY
         EJZg==
X-Gm-Message-State: APjAAAV0NK78mXcGzKSGV9ZisuCNTOyXkJ0Cjku5+xnUbaHIvNK5Vvdt
        VyCnt8tVQk7GkIOFUUoGUl86UaJt2lA=
X-Google-Smtp-Source: APXvYqz+SQN5Xup5cfL/9K3fBR6+4giDIXhds8ddUS5xeVJ5MULK/XcnoXw0iiW7j0fdHHGgq2Zn8Q==
X-Received: by 2002:aa7:9787:: with SMTP id o7mr851167pfp.120.1573094085528;
        Wed, 06 Nov 2019 18:34:45 -0800 (PST)
Received: from localhost ([122.171.110.253])
        by smtp.gmail.com with ESMTPSA id a66sm346290pfb.166.2019.11.06.18.34.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Nov 2019 18:34:44 -0800 (PST)
Date:   Thu, 7 Nov 2019 08:04:42 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Shen Kai <shenkai8@huawei.com>
Cc:     rjw@rjwysocki.net, rafael@kernel.org, hushiyuan@huawei.com,
        linfeilong@huawei.com, linux-pm@vger.kernel.org
Subject: Re: [PATCH]cpufreq: add NULL check to the store method of cpufreq
Message-ID: <20191107023442.q5xg6ltu2uzbjrp2@vireshk-i7>
References: <CAJZ5v0h5t2Hv60Y77HaM6DgTS3-m2moNu3DOX4zp8S4YgpS_ag@mail.gmail.com>
 <1573091585-8628-1-git-send-email-shenkai8@huawei.com>
 <20191107023223.p2ihcfpm3zy6iwoc@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191107023223.p2ihcfpm3zy6iwoc@vireshk-i7>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 07-11-19, 08:02, Viresh Kumar wrote:
> On 07-11-19, 01:53, Shen Kai wrote:
> > From: Kai Shen <shenkai8@huawei.com>
> > 
> > Add NULL check in the store function here to avoid NULL callback invoking.
> > Though some interfaces of cpufreq are set as read-only, user can still get 
> > write permission using chmod which can lead to a kernel crash.
> > 
> > The following operations can lead to a kernel crash.
> > 
> > chmod +w /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq
> > echo 1 >  /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq
> > 
> > This bug was found on linux 4.19
> > 
> > Signed-off-by: Kai Shen <shenkai8@huawei.com>
> > Reported-by: Feilong Lin <linfeilong@huawei.com>
> > Reviewed-by: Feilong Lin <linfeilong@huawei.com>
> > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> >  drivers/cpufreq/cpufreq.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > index bffc11b..4ccaa96 100644
> > --- a/drivers/cpufreq/cpufreq.c
> > +++ b/drivers/cpufreq/cpufreq.c
> > @@ -947,6 +947,9 @@ static ssize_t store(struct kobject *kobj, struct attribute *attr,
> >  	struct freq_attr *fattr = to_attr(attr);
> >  	ssize_t ret = -EINVAL;
> >  
> > +	if (!fattr->store)
> > +		return ret;
> 
> The return error shouldn't be -EINVAL here, maybe ENOPERM or ENOENT ?

s/ENOPERM/EPERM/

-- 
viresh
