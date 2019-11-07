Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86C32F25CB
	for <lists+linux-pm@lfdr.de>; Thu,  7 Nov 2019 04:06:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733032AbfKGDGL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 Nov 2019 22:06:11 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45068 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733026AbfKGDGK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 Nov 2019 22:06:10 -0500
Received: by mail-pf1-f196.google.com with SMTP id z4so1209470pfn.12
        for <linux-pm@vger.kernel.org>; Wed, 06 Nov 2019 19:06:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eosUJ654Yi0yJK3kskuYbXOckPSyPCl8py+bvd6dC9k=;
        b=WYho+V5MnsCE3Jh2PHNTDmRJjvvgThtgxE2qpRLAxqOVEUDgq81Udr+FmB/tICUlKY
         0sJRWPrLRQS5xZVyQop3oMLxooVvpuOoWzELRHhQgV4TZM5bwcvApc2Tjb9I3tFnaacQ
         WQd0K7kUBIzpstNbXUEd20jMKI57R7A5ixzQE7uy2Ev6M4RQjNOzGJ/NnHuI6WuA5tUn
         F5gHEJkWQwvfo9YsA4hK0Qo71MGiwZZ44TGlCxDGR2sVBKALKcAezI8ShAu54YBmy2Ta
         eAWRLvgBFhYboooZfRi5vO0m1qpOZ9rjEOBxVvbWXZY2j7dhAt4xPjNOZjHpnXhpUJe0
         pKTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eosUJ654Yi0yJK3kskuYbXOckPSyPCl8py+bvd6dC9k=;
        b=pcYA4HbHY9jUcF3g4bQ46D9zVUwL3Ab6qQa3yBOq1CiY90oF5XPI4nKScqrCXEs+QQ
         +6im8zu3Bi20Vtmz4jkoUWyCfe302BGpCDtKglGmnSW1Q3rY8C0qC2iEA0LNj/iS9JMg
         qGUuh8Vv2xw0MsGf62MmxAsxtewtCQvsw++HQivILhXifAyyzZMvZgYm+sIE8Vycrgk3
         XJjLZcPBjxBXGI3+JI4Cwira9jQ12miM+4sCAYj6z/cZv50ZycTkLFM0e/rtzjbxCO3l
         0Tf7YksdRnzto42NCS25+LKPVdVGI5NBw4Y0VSb2++6j8ljaBdxV5CZNRdLZvc6foB3X
         FddQ==
X-Gm-Message-State: APjAAAV/rG5k2MPs+wxcYbSoNnBl58zv1ii7NgVIOzEY0S86EwLqiIAQ
        GrGDmCJXYOHDfo5dtOQptBtHoA==
X-Google-Smtp-Source: APXvYqzY/p1YfDXXVCSku2q+6GrY2DGQUTSrgEIcG71PMoWS+PaSzz59AbvzjIKlgC3rG/RjQapH9A==
X-Received: by 2002:a63:6e82:: with SMTP id j124mr1594015pgc.115.1573095968351;
        Wed, 06 Nov 2019 19:06:08 -0800 (PST)
Received: from localhost ([122.171.110.253])
        by smtp.gmail.com with ESMTPSA id q20sm393882pff.134.2019.11.06.19.06.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Nov 2019 19:06:07 -0800 (PST)
Date:   Thu, 7 Nov 2019 08:36:01 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Shen Kai <shenkai8@huawei.com>
Cc:     rjw@rjwysocki.net, rafael@kernel.org, hushiyuan@huawei.com,
        linfeilong@huawei.com, linux-pm@vger.kernel.org
Subject: Re: [PATCH]cpufreq: add NULL check to the store method of cpufreq
Message-ID: <20191107030601.xqe2tpcprkg7epul@vireshk-i7>
References: <20191107023442.q5xg6ltu2uzbjrp2@vireshk-i7>
 <1573095182-22008-1-git-send-email-shenkai8@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1573095182-22008-1-git-send-email-shenkai8@huawei.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 07-11-19, 02:53, Shen Kai wrote:
> From: Kai Shen <shenkai8@huawei.com>
> 
> Add NULL check in the store function here to avoid NULL callback invoking.
> Though some interfaces of cpufreq are set as read-only, user can still get 
> write permission using chmod which can lead to a kernel crash.
> 
> The following operations can lead to a kernel crash.
> 
> chmod +w /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq
> echo 1 >  /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq
> 
> This bug was found on linux 4.19
> 
> Signed-off-by: Kai Shen <shenkai8@huawei.com>
> Reported-by: Feilong Lin <linfeilong@huawei.com>
> Reviewed-by: Feilong Lin <linfeilong@huawei.com>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cpufreq.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index bffc11b..4ccaa96 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -947,6 +947,9 @@ static ssize_t store(struct kobject *kobj, struct attribute *attr,
>  	struct freq_attr *fattr = to_attr(attr);
>  	ssize_t ret = -EINVAL;
>  
> +	if (!fattr->store)
> +		return -EPERM;
> +

And this should be -EIO, I found that after looking at all the
instances of struct kobj_type in the kernel :(

Also there is another change you need to make.

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index dd1628192310..4bfaafde9083 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -933,6 +933,9 @@ static ssize_t show(struct kobject *kobj, struct attribute *attr, char *buf)
        struct freq_attr *fattr = to_attr(attr);
        ssize_t ret;
 
+       if (!fattr->show)
+               return -EIO;
+
        down_read(&policy->rwsem);
        ret = fattr->show(policy, buf);
        up_read(&policy->rwsem);

as there is a write-only attribute (reset) in cpufreq stats.

-- 
viresh
