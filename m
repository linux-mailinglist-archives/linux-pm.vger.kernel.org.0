Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B61C67B8F5
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2019 07:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728822AbfGaFFx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 31 Jul 2019 01:05:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:49454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728819AbfGaFFx (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 31 Jul 2019 01:05:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 876212067D;
        Wed, 31 Jul 2019 05:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564549552;
        bh=yhXihtzLTh3cZ4DbCQLn/gpfxVbg3F2Z/64dfQ4emZI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MKFGBMHTHEVfWcInQ1CNjdKFcCN/CYWnkB6Adfqyxuz/KNl45uy7XiLCQDLkm3/Hy
         S9Fze0QKyNNcx8WjEjeHRRyiEllyOed/UwWQN/HYSkiLdeo5yjG9X535vINv9VK2n7
         3n3kOahytbd713vbUTUnnxoVg9WBe3XE5FozQsek=
Date:   Wed, 31 Jul 2019 07:05:49 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kalesh Singh <kaleshsingh@google.com>
Cc:     rjw@rjwysocki.net, trong@google.com, trong@android.com,
        sspatil@google.com, hridya@google.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH] PM/sleep: Expose suspend stats in sysfs
Message-ID: <20190731050549.GA20809@kroah.com>
References: <20190730225228.126044-1-kaleshsingh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190730225228.126044-1-kaleshsingh@google.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jul 30, 2019 at 03:52:28PM -0700, Kalesh Singh wrote:
> +#define suspend_attr(_name)						\
> +static ssize_t _name##_show(struct kobject *kobj,			\
> +		struct kobj_attribute *attr, char *buf)			\
> +{									\
> +	int index;							\
> +	enum suspend_stat_step step;					\
> +	char *last_failed_stat = NULL;					\
> +									\
> +	if (strcmp(attr->attr.name, "last_failed_dev") == 0) {		\
> +		index = suspend_stats._name + REC_FAILED_NUM - 1;	\
> +		index %= REC_FAILED_NUM;				\
> +		last_failed_stat = suspend_stats.failed_devs[index];	\
> +		return sprintf(buf, "%s\n", last_failed_stat);		\
> +	} else if (strcmp(attr->attr.name, "last_failed_step") == 0) {	\
> +		index = suspend_stats._name + REC_FAILED_NUM - 1;	\
> +		index %= REC_FAILED_NUM;				\
> +		step = suspend_stats.failed_steps[index];		\
> +		last_failed_stat = suspend_step_name(step);		\
> +		return sprintf(buf, "%s\n", last_failed_stat);		\
> +	} else if (strcmp(attr->attr.name, "last_failed_errno") == 0) {	\
> +		index = suspend_stats._name + REC_FAILED_NUM - 1;	\
> +		index %= REC_FAILED_NUM;				\
> +		return sprintf(buf, "%d\n", suspend_stats.errno[index]);\
> +	}								\

For these 3 "special" ones, just have your own show function, no need to
cram it into this macro, making a bunch of unused code be generated all
the time.

thanks,

greg k-h
