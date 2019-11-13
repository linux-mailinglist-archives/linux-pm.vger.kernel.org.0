Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5AA3FBB8A
	for <lists+linux-pm@lfdr.de>; Wed, 13 Nov 2019 23:24:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbfKMWX7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 Nov 2019 17:23:59 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:62523 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbfKMWX7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Nov 2019 17:23:59 -0500
Received: from 79.184.253.153.ipv4.supernova.orange.pl (79.184.253.153) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.292)
 id 059605e9863d4f9b; Wed, 13 Nov 2019 23:23:57 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Artur =?utf-8?B?xZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>,
        linux-pm@vger.kernel.org, linux-imx@nxp.com
Subject: Re: [PATCH 2/3] PM: QoS: Export _freq_qos_apply
Date:   Wed, 13 Nov 2019 23:23:56 +0100
Message-ID: <2045347.p7qcj6nqyX@kreacher>
In-Reply-To: <27d83f2bb2aaa4e69d480622727ba7f4497dbe2a.1572025364.git.leonard.crestez@nxp.com>
References: <cover.1572025364.git.leonard.crestez@nxp.com> <27d83f2bb2aaa4e69d480622727ba7f4497dbe2a.1572025364.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Friday, October 25, 2019 8:00:48 PM CET Leonard Crestez wrote:
> This is exported only for dev_pm_qos to use in order to implement
> per-device freq constraints.
> 
> Export with a leading underscore because this is an implementation
> detail, it's not meant to be used by drivers making QoS requests.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> ---
>  include/linux/pm_qos.h |  2 ++
>  kernel/power/qos.c     | 11 ++++++-----
>  2 files changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/pm_qos.h b/include/linux/pm_qos.h
> index 9105f47f5195..e90dae0b8de9 100644
> --- a/include/linux/pm_qos.h
> +++ b/include/linux/pm_qos.h
> @@ -291,10 +291,12 @@ s32 freq_qos_read_value(struct freq_constraints *qos,
>  int freq_qos_add_request(struct freq_constraints *qos,
>  			 struct freq_qos_request *req,
>  			 enum freq_qos_req_type type, s32 value);
>  int freq_qos_update_request(struct freq_qos_request *req, s32 new_value);
>  int freq_qos_remove_request(struct freq_qos_request *req);
> +int _freq_qos_apply(struct freq_qos_request *req,
> +		    enum pm_qos_req_action action, s32 value);
>  
>  int freq_qos_add_notifier(struct freq_constraints *qos,
>  			  enum freq_qos_req_type type,
>  			  struct notifier_block *notifier);
>  int freq_qos_remove_notifier(struct freq_constraints *qos,
> diff --git a/kernel/power/qos.c b/kernel/power/qos.c
> index 04e83fdfbe80..ea38ae86bd66 100644
> --- a/kernel/power/qos.c
> +++ b/kernel/power/qos.c
> @@ -708,16 +708,16 @@ s32 freq_qos_read_value(struct freq_constraints *qos,
>  
>  	return ret;
>  }
>  
>  /**
> - * freq_qos_apply - Add/modify/remove frequency QoS request.
> + * _freq_qos_apply - Add/modify/remove frequency QoS request.
>   * @req: Constraint request to apply.
>   * @action: Action to perform (add/update/remove).
>   * @value: Value to assign to the QoS request.
>   */
> -static int freq_qos_apply(struct freq_qos_request *req,
> +int _freq_qos_apply(struct freq_qos_request *req,
>  			  enum pm_qos_req_action action, s32 value)
>  {
>  	int ret;
>  
>  	switch(req->type) {
> @@ -733,10 +733,11 @@ static int freq_qos_apply(struct freq_qos_request *req,
>  		ret = -EINVAL;
>  	}
>  
>  	return ret;
>  }
> +EXPORT_SYMBOL_GPL(_freq_qos_apply);

The devuce PM QoS code is not modular, so this is not necessary.

And so I wouldn't change the name of the function, just make it non-static
and add its header to pm_qos.h.

>  
>  /**
>   * freq_qos_add_request - Insert new frequency QoS request into a given list.
>   * @qos: Constraints to update.
>   * @req: Preallocated request object.
> @@ -763,11 +764,11 @@ int freq_qos_add_request(struct freq_constraints *qos,
>  		 "%s() called for active request\n", __func__))
>  		return -EINVAL;
>  
>  	req->qos = qos;
>  	req->type = type;
> -	ret = freq_qos_apply(req, PM_QOS_ADD_REQ, value);
> +	ret = _freq_qos_apply(req, PM_QOS_ADD_REQ, value);
>  	if (ret < 0) {
>  		req->qos = NULL;
>  		req->type = 0;
>  	}
>  
> @@ -796,11 +797,11 @@ int freq_qos_update_request(struct freq_qos_request *req, s32 new_value)
>  		return -EINVAL;
>  
>  	if (req->pnode.prio == new_value)
>  		return 0;
>  
> -	return freq_qos_apply(req, PM_QOS_UPDATE_REQ, new_value);
> +	return _freq_qos_apply(req, PM_QOS_UPDATE_REQ, new_value);
>  }
>  EXPORT_SYMBOL_GPL(freq_qos_update_request);
>  
>  /**
>   * freq_qos_remove_request - Remove frequency QoS request from its list.
> @@ -819,11 +820,11 @@ int freq_qos_remove_request(struct freq_qos_request *req)
>  
>  	if (WARN(!freq_qos_request_active(req),
>  		 "%s() called for unknown object\n", __func__))
>  		return -EINVAL;
>  
> -	return freq_qos_apply(req, PM_QOS_REMOVE_REQ, PM_QOS_DEFAULT_VALUE);
> +	return _freq_qos_apply(req, PM_QOS_REMOVE_REQ, PM_QOS_DEFAULT_VALUE);
>  }
>  EXPORT_SYMBOL_GPL(freq_qos_remove_request);
>  
>  /**
>   * freq_qos_add_notifier - Add frequency QoS change notifier.
> 




