Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4F9C290A
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2019 23:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727977AbfI3Vor (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Sep 2019 17:44:47 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:59397 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727884AbfI3Voq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 Sep 2019 17:44:46 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190930214443epoutp01380deb74746ff7915642b764a7fd72e9~JVW-C0IGn3009530095epoutp01M
        for <linux-pm@vger.kernel.org>; Mon, 30 Sep 2019 21:44:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190930214443epoutp01380deb74746ff7915642b764a7fd72e9~JVW-C0IGn3009530095epoutp01M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1569879883;
        bh=b9nZrOmKxmSWIgeNh3jrts145USyklOFOsEaZoA8/zo=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=BjVUhblPYDxUUAK7kuW0mnuBTRHwdBQCUbyT35MbwBHM01dGqvA1aaMaXlswsuIs4
         xDH/M5mo0l5wRDClwosYDc1aVKLSCSWwU1r5WRVPJ4qF0fYoT3jf+bHK8cMqbFvv48
         5MxPl5aMDKVZJhsQox5dop0Nj+0rrX7KlnGc60DE=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20190930214442epcas1p48a9f744d0c7a635187eb54e2216928c8~JVW_UBnrr2835628356epcas1p4K;
        Mon, 30 Sep 2019 21:44:42 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.157]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 46hwsg6TYzzMqYll; Mon, 30 Sep
        2019 21:44:39 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        28.8C.04144.747729D5; Tue,  1 Oct 2019 06:44:39 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20190930214439epcas1p31178fc2bb145f9ede83b3b353ba20c62~JVW7LcM711500215002epcas1p3b;
        Mon, 30 Sep 2019 21:44:39 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190930214439epsmtrp1b457b3f32e48fe7f64f5789113645373~JVW7KmrCw1298412984epsmtrp1M;
        Mon, 30 Sep 2019 21:44:39 +0000 (GMT)
X-AuditID: b6c32a35-2dfff70000001030-22-5d9277476417
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        06.09.04081.747729D5; Tue,  1 Oct 2019 06:44:39 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190930214439epsmtip283fbf69c7bcf2b6e800fad47e10e95d4~JVW66RoqI0915309153epsmtip2Z;
        Mon, 30 Sep 2019 21:44:39 +0000 (GMT)
Subject: Re: [PATCH 8/8] PM / devfreq: Move opp notifier registration to
 core
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>
Cc:     =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Abel Vesa <abel.vesa@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <efdec5cf-c434-0b53-93c2-d39d5f264fae@samsung.com>
Date:   Tue, 1 Oct 2019 06:49:27 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <974c2bd6d6e622e47c85af65a200b4079d25002b.1568764439.git.leonard.crestez@nxp.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKJsWRmVeSWpSXmKPExsWy7bCmnq57+aRYg6ePjSwOHdvKbvH19ClG
        i2WXjjJaTN+7ic3i/PkN7BZnm96wW6y4+5HVYtPja6wWn3uPMFrcblzBZrH63EE2i65Df9ks
        Nn71cOD1eH+jld1jwaZSj02rOtk87lzbw+axeUm9x8Z3O5g8Dr7bw+TRt2UVo8fnTXIBnFHZ
        NhmpiSmpRQqpecn5KZl56bZK3sHxzvGmZgaGuoaWFuZKCnmJuam2Si4+AbpumTlAVysplCXm
        lAKFAhKLi5X07WyK8ktLUhUy8otLbJVSC1JyCiwL9IoTc4tL89L1kvNzrQwNDIxMgQoTsjOW
        LbrGXtDsUrFj1z7WBsZl5l2MnBwSAiYS266eZOpi5OIQEtjBKPH7/Td2COcTo8S/N9PZIJxv
        jBJHL81ng2l5f+QnM0RiL6PEn1WLoVreM0psXjeFGaRKWMBf4ueHnWDtIgLNjBJbT7xlAkkw
        C0xhlth/NxvEZhPQktj/4gbYWH4BRYmrPx4zdjFycPAK2Emsa+QACbMIqEj0/HrLDmKLCkRI
        fHpwmBXE5hUQlDg58wkLiM0pECexZu5VRojx4hK3nsyHWiUv0bx1NtilEgL72CUO7ZnDDvGC
        i8STxj4mCFtY4tXxLVBxKYmX/W1QdrXEypNH2CCaOxgltuy/wAqRMJbYv3QyE8ihzAKaEut3
        6UOEFSV2/p4LdQSfxLuvPawgJRICvBIdbUIQJcoSlx/chVorKbG4vZNtAqPSLCTvzELywiwk
        L8xCWLaAkWUVo1hqQXFuemqxYYEhcnRvYgQnaS3THYxTzvkcYhTgYFTi4dVQmRQrxJpYVlyZ
        e4hRgoNZSYRXnGFCrBBvSmJlVWpRfnxRaU5q8SFGU2BoT2SWEk3OB2aQvJJ4Q1MjY2NjCxND
        M1NDQyVxXo/0hlghgfTEktTs1NSC1CKYPiYOTqkGxhjxu0Zt+7g+nLgYdX0hc/F73oVRomcv
        GNmuWF/fcnJ52tOV3q/nOd62390ulZWkVq+ROVPuvvxUpkW3Sw0P7tdsf/huc7fzysSU/ozk
        6bM+dfvnO/PELFn56MrZuTNmzZYs/jJ5ygWDhBe+ryZxiys2BSkL1rRWhvzU57loNs/dL+en
        6o8/gUosxRmJhlrMRcWJANKKxrvoAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAIsWRmVeSWpSXmKPExsWy7bCSvK57+aRYg7U/hSwOHdvKbvH19ClG
        i2WXjjJaTN+7ic3i/PkN7BZnm96wW6y4+5HVYtPja6wWn3uPMFrcblzBZrH63EE2i65Df9ks
        Nn71cOD1eH+jld1jwaZSj02rOtk87lzbw+axeUm9x8Z3O5g8Dr7bw+TRt2UVo8fnTXIBnFFc
        NimpOZllqUX6dglcGcsWXWMvaHap2LFrH2sD4zLzLkZODgkBE4n3R34ydzFycQgJ7GaUWPP/
        FQtEQlJi2sWjQAkOIFtY4vDhYoiat4wSM6+3s4HUCAv4SrRdOsYEkhARaGWUuHP6BxuIwyww
        hVni3bWrUGMfMUrsudnBDNLCJqAlsf/FDbB2fgFFias/HjOCrOAVsJNY18gBEmYRUJHo+fWW
        HcQWFYiQOLxjFiOIzSsgKHFy5hOw6zgF4iTWzL0KFmcWUJf4M+8SM4QtLnHryXwmCFteonnr
        bOYJjMKzkLTPQtIyC0nLLCQtCxhZVjFKphYU56bnFhsWGOallusVJ+YWl+al6yXn525iBMer
        luYOxstL4g8xCnAwKvHwTng5MVaINbGsuDL3EKMEB7OSCK84w4RYId6UxMqq1KL8+KLSnNTi
        Q4zSHCxK4rxP845FCgmkJ5akZqemFqQWwWSZODilGhj5Doe1Gs2sVO/hmJh1MMhiQYlnxY2A
        SVYZJ+0D3jEaKfwxuJkmuM0k7ec/Bad5N/gYD5o9WbFh/5Z7j1+8Mn6glsOVE13uXFC9csqC
        PMEovpeb7dTqjzUkRTA2bwvhUfbkZRF3u3RGoufhftcrZR2PN+55lKv2/Z8fS1LheeNvR6aW
        u/w9WKPEUpyRaKjFXFScCAC/vU5n0wIAAA==
X-CMS-MailID: 20190930214439epcas1p31178fc2bb145f9ede83b3b353ba20c62
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190918001840epcas5p4a5194b71b19dac73873794b3cefd8cb6
References: <cover.1568764439.git.leonard.crestez@nxp.com>
        <CGME20190918001840epcas5p4a5194b71b19dac73873794b3cefd8cb6@epcas5p4.samsung.com>
        <974c2bd6d6e622e47c85af65a200b4079d25002b.1568764439.git.leonard.crestez@nxp.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19. 9. 18. 오전 9:18, Leonard Crestez wrote:
> An opp notifier can be registered by devfreq in order to respond to OPPs
> being enabled or disabled at runtime (for example by thermal). This is
> currently handled explicitly by drivers.
> 
> Move notifier handling to devfreq_add_device because this shouldn't be
> hardware-specific.
> 
> Handling this inside the core also takes less code.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> ---
>  drivers/devfreq/devfreq.c    | 84 +++---------------------------------
>  drivers/devfreq/exynos-bus.c |  7 ---
>  drivers/devfreq/rk3399_dmc.c |  6 ---
>  include/linux/devfreq.h      |  8 ----
>  4 files changed, 6 insertions(+), 99 deletions(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 7977bad93949..b9177430ae8f 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -663,10 +663,11 @@ static void devfreq_dev_release(struct device *dev)
>  
>  	mutex_lock(&devfreq_list_lock);
>  	list_del(&devfreq->node);
>  	mutex_unlock(&devfreq_list_lock);
>  
> +	dev_pm_opp_unregister_notifier(devfreq->dev.parent, &devfreq->nb);
>  	dev_pm_qos_remove_notifier(devfreq->dev.parent, &devfreq->nb_max,
>  			DEV_PM_QOS_MAX_FREQUENCY);
>  	dev_pm_qos_remove_notifier(devfreq->dev.parent, &devfreq->nb_min,
>  			DEV_PM_QOS_MIN_FREQUENCY);
>  
> @@ -728,11 +729,10 @@ struct devfreq *devfreq_add_device(struct device *dev,
>  	devfreq->profile = profile;
>  	strncpy(devfreq->governor_name, governor_name, DEVFREQ_NAME_LEN);
>  	devfreq->previous_freq = profile->initial_freq;
>  	devfreq->last_status.current_frequency = profile->initial_freq;
>  	devfreq->data = data;
> -	devfreq->nb.notifier_call = devfreq_notifier_call;
>  
>  	if (!devfreq->profile->max_state && !devfreq->profile->freq_table) {
>  		err = set_freq_table(devfreq);
>  		if (err < 0)
>  			goto err_dev;
> @@ -810,10 +810,15 @@ struct devfreq *devfreq_add_device(struct device *dev,
>  	err = dev_pm_qos_add_notifier(devfreq->dev.parent, &devfreq->nb_max,
>  				      DEV_PM_QOS_MAX_FREQUENCY);
>  	if (err)
>  		goto err_devfreq;
>  
> +	devfreq->nb.notifier_call = devfreq_notifier_call;
> +	err = dev_pm_opp_register_notifier(devfreq->dev.parent, &devfreq->nb);
> +	if (err)
> +		goto err_devfreq;
> +
>  	mutex_lock(&devfreq_list_lock);
>  
>  	governor = try_then_request_governor(devfreq->governor_name);
>  	if (IS_ERR(governor)) {
>  		dev_err(dev, "%s: Unable to find governor for the device\n",
> @@ -1624,87 +1629,10 @@ struct dev_pm_opp *devfreq_recommended_opp(struct device *dev,
>  
>  	return opp;
>  }
>  EXPORT_SYMBOL(devfreq_recommended_opp);
>  
> -/**
> - * devfreq_register_opp_notifier() - Helper function to get devfreq notified
> - *				     for any changes in the OPP availability
> - *				     changes
> - * @dev:	The devfreq user device. (parent of devfreq)
> - * @devfreq:	The devfreq object.
> - */
> -int devfreq_register_opp_notifier(struct device *dev, struct devfreq *devfreq)
> -{
> -	return dev_pm_opp_register_notifier(dev, &devfreq->nb);
> -}
> -EXPORT_SYMBOL(devfreq_register_opp_notifier);
> -
> -/**
> - * devfreq_unregister_opp_notifier() - Helper function to stop getting devfreq
> - *				       notified for any changes in the OPP
> - *				       availability changes anymore.
> - * @dev:	The devfreq user device. (parent of devfreq)
> - * @devfreq:	The devfreq object.
> - *
> - * At exit() callback of devfreq_dev_profile, this must be included if
> - * devfreq_recommended_opp is used.
> - */
> -int devfreq_unregister_opp_notifier(struct device *dev, struct devfreq *devfreq)
> -{
> -	return dev_pm_opp_unregister_notifier(dev, &devfreq->nb);
> -}
> -EXPORT_SYMBOL(devfreq_unregister_opp_notifier);
> -
> -static void devm_devfreq_opp_release(struct device *dev, void *res)
> -{
> -	devfreq_unregister_opp_notifier(dev, *(struct devfreq **)res);
> -}
> -
> -/**
> - * devm_devfreq_register_opp_notifier() - Resource-managed
> - *					  devfreq_register_opp_notifier()
> - * @dev:	The devfreq user device. (parent of devfreq)
> - * @devfreq:	The devfreq object.
> - */
> -int devm_devfreq_register_opp_notifier(struct device *dev,
> -				       struct devfreq *devfreq)
> -{
> -	struct devfreq **ptr;
> -	int ret;
> -
> -	ptr = devres_alloc(devm_devfreq_opp_release, sizeof(*ptr), GFP_KERNEL);
> -	if (!ptr)
> -		return -ENOMEM;
> -
> -	ret = devfreq_register_opp_notifier(dev, devfreq);
> -	if (ret) {
> -		devres_free(ptr);
> -		return ret;
> -	}
> -
> -	*ptr = devfreq;
> -	devres_add(dev, ptr);
> -
> -	return 0;
> -}
> -EXPORT_SYMBOL(devm_devfreq_register_opp_notifier);
> -
> -/**
> - * devm_devfreq_unregister_opp_notifier() - Resource-managed
> - *					    devfreq_unregister_opp_notifier()
> - * @dev:	The devfreq user device. (parent of devfreq)
> - * @devfreq:	The devfreq object.
> - */
> -void devm_devfreq_unregister_opp_notifier(struct device *dev,
> -					 struct devfreq *devfreq)
> -{
> -	WARN_ON(devres_release(dev, devm_devfreq_opp_release,
> -			       devm_devfreq_dev_match, devfreq));
> -}
> -EXPORT_SYMBOL(devm_devfreq_unregister_opp_notifier);
> -
>  /**
>   * devfreq_register_notifier() - Register a driver with devfreq
>   * @devfreq:	The devfreq object.
>   * @nb:		The notifier block to register.
>   * @list:	DEVFREQ_TRANSITION_NOTIFIER.
> diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
> index c832673273a2..29f422469960 100644
> --- a/drivers/devfreq/exynos-bus.c
> +++ b/drivers/devfreq/exynos-bus.c
> @@ -356,17 +356,10 @@ static int exynos_bus_probe(struct platform_device *pdev)
>  		dev_err(dev, "failed to add devfreq device\n");
>  		ret = PTR_ERR(bus->devfreq);
>  		goto err;
>  	}
>  
> -	/* Register opp_notifier to catch the change of OPP  */
> -	ret = devm_devfreq_register_opp_notifier(dev, bus->devfreq);
> -	if (ret < 0) {
> -		dev_err(dev, "failed to register opp notifier\n");
> -		goto err;
> -	}
> -
>  	/*
>  	 * Enable devfreq-event to get raw data which is used to determine
>  	 * current bus load.
>  	 */
>  	ret = exynos_bus_enable_edev(bus);
> diff --git a/drivers/devfreq/rk3399_dmc.c b/drivers/devfreq/rk3399_dmc.c
> index 2e65d7279d79..f660d2031e8a 100644
> --- a/drivers/devfreq/rk3399_dmc.c
> +++ b/drivers/devfreq/rk3399_dmc.c
> @@ -454,12 +454,10 @@ static int rk3399_dmcfreq_probe(struct platform_device *pdev)
>  	if (IS_ERR(data->devfreq)) {
>  		ret = PTR_ERR(data->devfreq);
>  		goto err_free_opp;
>  	}
>  
> -	devm_devfreq_register_opp_notifier(dev, data->devfreq);
> -
>  	data->dev = dev;
>  	platform_set_drvdata(pdev, data);
>  
>  	return 0;
>  
> @@ -470,14 +468,10 @@ static int rk3399_dmcfreq_probe(struct platform_device *pdev)
>  
>  static int rk3399_dmcfreq_remove(struct platform_device *pdev)
>  {
>  	struct rk3399_dmcfreq *dmcfreq = dev_get_drvdata(&pdev->dev);
>  
> -	/*
> -	 * Before remove the opp table we need to unregister the opp notifier.
> -	 */
> -	devm_devfreq_unregister_opp_notifier(dmcfreq->dev, dmcfreq->devfreq);
>  	dev_pm_opp_of_remove_table(dmcfreq->dev);
>  
>  	return 0;
>  }
>  
> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
> index 4b5cc80abbe3..bf6ebfbc1e8a 100644
> --- a/include/linux/devfreq.h
> +++ b/include/linux/devfreq.h
> @@ -220,18 +220,10 @@ extern void devfreq_resume(void);
>  extern int update_devfreq(struct devfreq *devfreq);
>  
>  /* Helper functions for devfreq user device driver with OPP. */
>  extern struct dev_pm_opp *devfreq_recommended_opp(struct device *dev,
>  					   unsigned long *freq, u32 flags);
> -extern int devfreq_register_opp_notifier(struct device *dev,
> -					 struct devfreq *devfreq);
> -extern int devfreq_unregister_opp_notifier(struct device *dev,
> -					   struct devfreq *devfreq);
> -extern int devm_devfreq_register_opp_notifier(struct device *dev,
> -					      struct devfreq *devfreq);
> -extern void devm_devfreq_unregister_opp_notifier(struct device *dev,
> -						struct devfreq *devfreq);
>  extern int devfreq_register_notifier(struct devfreq *devfreq,
>  					struct notifier_block *nb,
>  					unsigned int list);
>  extern int devfreq_unregister_notifier(struct devfreq *devfreq,
>  					struct notifier_block *nb,
> 

It looks good to me.
But, this patch don't remove the inline functions in devfreq.h.
- devfreq_register_opp_notifier
- devfreq_unregister_opp_notifier
- devm_devfreq_register_opp_notifier
- devm_devfreq_unregister_opp_notifier

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
