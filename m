Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46E6C2346DA
	for <lists+linux-pm@lfdr.de>; Fri, 31 Jul 2020 15:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbgGaN2t (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 31 Jul 2020 09:28:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:38172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727851AbgGaN2t (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 31 Jul 2020 09:28:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D517B22B3F;
        Fri, 31 Jul 2020 13:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596202128;
        bh=l7D6zlkmr4zMBr2PK4nmtQfto6+WhjExk/dpj0+RAj4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B3KNYczDqWxyXinafo8RrHvVe4oi2alKnZPYcHHgAETLVfoyXGkSLwDYF/Xy5W9OR
         zEUaCYnR02D0fgvCGHjZnKY7gERG7luAi8ztxYaf96ZZPO55OFRQB+iax71ZkH7p3L
         HabjYjWWb9fbcFU/HtIKDGZhWLr8cSO9GC6lyI8M=
Date:   Fri, 31 Jul 2020 15:28:35 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dongdong Yang <contribute.kernel@gmail.com>
Cc:     rjw@rjwysocki.net, viresh.kumar@linaro.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-pm@vger.kernel.org, yangdongdong@xiaomi.com,
        tanggeliang@xiaomi.com, taojun@xiaomi.com, huangqiwu@xiaomi.com,
        rocking@linux.alibaba.com, fengwei@xiaomi.com,
        zhangguoquan@xiaomi.com, gulinghua@xiaomi.com, duhui@xiaomi.com
Subject: Re: [PATCH v2] sched: Provide USF for the portable equipment.
Message-ID: <20200731132835.GC1712190@kroah.com>
References: <cover.1596196060.git.yangdongdong@xiaomi.com>
 <e992fea6ad249694e615640862a28346936f8844.1596196062.git.yangdongdong@xiaomi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e992fea6ad249694e615640862a28346936f8844.1596196062.git.yangdongdong@xiaomi.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jul 31, 2020 at 08:46:30PM +0800, Dongdong Yang wrote:
> +static ssize_t store_sched_usf_up_l0_r(struct kobject *kobj,
> +				       struct kobj_attribute *attr,
> +				       const char *buf, size_t count)
> +{
> +	int val = 0;
> +	int ret;
> +
> +	ret = kstrtoint(buf, 0, &val);
> +	if (ret) {
> +		pr_err(USF_TAG "set state fail ret=%d\n", ret);
> +		return ret;
> +	}
> +
> +	if ((val >= 0) && (val <= BOOST_MAX_V)) {
> +		usf_vdev.sysctl_sched_usf_up_l0 = val;
> +		usf_vdev.usf_up_l0 = LEVEL_TOP -
> +				DIV_ROUND_UP(val, BOOST_MAX_V / 2);
> +	} else {
> +		pr_err(USF_TAG "%d should fall into [%d %d]",
> +		       val, 0, BOOST_MAX_V);
> +	}
> +	if ((usf_vdev.sysctl_sched_usf_up_l0 == 0) &&
> +	    (usf_vdev.sysctl_sched_usf_down == 0))
> +		static_branch_disable(&adjust_task_pred_set);
> +	else
> +		static_branch_enable(&adjust_task_pred_set);
> +
> +	return count;
> +}
> +
> +static ssize_t store_sched_usf_down_r(struct kobject *kobj,
> +				      struct kobj_attribute *attr,
> +				      const char *buf, size_t count)
> +{
> +	int val = 0;
> +	int ret;
> +
> +	ret = kstrtoint(buf, 0, &val);
> +	if (ret) {
> +		pr_err(USF_TAG "set state fail ret=%d\n", ret);
> +		return ret;
> +	}
> +
> +	if ((val >= BOOST_MIN_V) && (val <= 0)) {
> +		usf_vdev.sysctl_sched_usf_down = val;
> +		usf_vdev.usf_down = DIV_ROUND_UP(-val, -BOOST_MIN_V / 2);
> +	} else {
> +		pr_err(USF_TAG "%d should fall into [%d %d]",
> +		       val, BOOST_MIN_V, 0);
> +	}
> +	if ((usf_vdev.sysctl_sched_usf_up_l0 == 0) &&
> +	    (usf_vdev.sysctl_sched_usf_down == 0))
> +		static_branch_disable(&adjust_task_pred_set);
> +	else
> +		static_branch_enable(&adjust_task_pred_set);
> +
> +	return count;
> +}
> +
> +static ssize_t store_sched_usf_non_ux_r(struct kobject *kobj,
> +					struct kobj_attribute *attr,
> +					const char *buf, size_t count)
> +{
> +	int val = 0;
> +	int ret;
> +
> +	ret = kstrtoint(buf, 0, &val);
> +	if (ret) {
> +		pr_err(USF_TAG "set state fail ret=%d\n", ret);
> +		return ret;
> +	}
> +
> +	if ((val >= BOOST_MIN_V) && (val <= 0)) {
> +		usf_vdev.sysctl_sched_usf_non_ux = val;
> +		usf_vdev.usf_non_ux = DIV_ROUND_UP(-val, -BOOST_MIN_V / 2);
> +	} else {
> +		pr_err(USF_TAG "%d should fall into [%d %d]",
> +		       val, BOOST_MIN_V, 0);
> +	}
> +	if (usf_vdev.sysctl_sched_usf_non_ux == 0)
> +		static_branch_disable(&adjust_task_pred_set);
> +	else
> +		static_branch_enable(&adjust_task_pred_set);
> +
> +	return count;
> +}
> +
> +#define usf_attr_rw(_name)						\
> +static struct kobj_attribute _name =					\
> +__ATTR(_name, 0664, show_##_name, store_##_name)

You have a lot of sysfs files here, but no documentation for them at
all, why not?

> +
> +#define usf_show_node(_name, _value)					\
> +static ssize_t show_##_name						\
> +(struct kobject *kobj, struct kobj_attribute *attr,  char *buf)		\
> +{									\
> +	unsigned int len = 0;						\
> +	unsigned int max_len = 8;					\
> +	len +=								\
> +	    snprintf(buf + len, max_len - len, "%d",			\
> +		     usf_vdev.sysctl_##_value);				\
> +	return len;							\
> +}
> +
> +usf_show_node(sched_usf_up_l0_r, sched_usf_up_l0);
> +usf_show_node(sched_usf_down_r, sched_usf_down);
> +usf_show_node(sched_usf_non_ux_r, sched_usf_non_ux);
> +
> +usf_attr_rw(sched_usf_up_l0_r);
> +usf_attr_rw(sched_usf_down_r);
> +usf_attr_rw(sched_usf_non_ux_r);
> +
> +static struct attribute *sched_attrs[] = {
> +	&sched_usf_up_l0_r.attr,
> +	&sched_usf_down_r.attr,
> +	&sched_usf_non_ux_r.attr,
> +	NULL,
> +};
> +
> +static struct attribute_group sched_attr_group = {
> +	.attrs = sched_attrs,
> +};
> +
> +static int usf_dbg_get(void *data, u64 *val)
> +{
> +	*val = (u64)usf_vdev.enable_debug;
> +
> +	return 0;
> +}
> +
> +static int usf_dbg_set(void *data, u64 val)
> +{
> +	usf_vdev.enable_debug = !!val;
> +	return 0;
> +}
> +
> +DEFINE_SIMPLE_ATTRIBUTE(usf_dbg_fops, usf_dbg_get,
> +			usf_dbg_set, "%llu\n");
> +
> +static int __init intera_monitor_init(void)
> +{
> +	int res = -1;
> +	struct attribute_group *attr_group;
> +
> +	res = fb_register_client(&usf_lcd_nb);
> +	if (res < 0) {
> +		pr_err("Failed to register usf_lcd_nb!\n");
> +		return res;
> +	}
> +
> +	/*
> +	 * create a sched_usf in cpu_subsys:
> +	 * /sys/devices/system/cpu/sched_usf/...
> +	 */
> +	attr_group = &sched_attr_group;
> +	usf_vdev.kobj = kobject_create_and_add("sched_usf",
> +					       &cpu_subsys.dev_root->kobj);
> +

Huh?  Why put this there?

And by making a "raw" kobject, you just kept userspace from seeing this
information entirely :(

Use a 'struct device' as you are a driver, do not use a raw kobject.

thanks,

greg k-h
