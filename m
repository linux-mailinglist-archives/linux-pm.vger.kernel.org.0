Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3D981933B8
	for <lists+linux-pm@lfdr.de>; Wed, 25 Mar 2020 23:25:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727374AbgCYWZj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Mar 2020 18:25:39 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:12856 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727358AbgCYWZj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Mar 2020 18:25:39 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200325222535epoutp02d78d245b4d3bb93fb73319df1aab4777~-rGMyWEkS0231902319epoutp02Z
        for <linux-pm@vger.kernel.org>; Wed, 25 Mar 2020 22:25:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200325222535epoutp02d78d245b4d3bb93fb73319df1aab4777~-rGMyWEkS0231902319epoutp02Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1585175135;
        bh=9wq2wZa21opTQIEIbtz6cMxVkcxQ7EqnavTSS59fUyI=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=rQYeXEKAySa7ig4sBPGii7DcNPa1a9KLnzFfSPw1z0/Sq0lEiIOrRVVmI08pzi9aG
         m1L+3PLaryDdjjDA0nU1buuYieD9OADll8xoHk44mzVYsZzk2gGZ6mPW/0rMjtTJgr
         pqPchMUtFAKpQV6w675mRVzf2LQ4zedLKCnzkk3E=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200325222535epcas1p258023413124dfc9e3f5620bd60ae5d32~-rGMJK77h1248512485epcas1p2w;
        Wed, 25 Mar 2020 22:25:35 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.156]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 48njP90qxvzMqYkY; Wed, 25 Mar
        2020 22:25:33 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        1F.76.04140.D5ADB7E5; Thu, 26 Mar 2020 07:25:33 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20200325222532epcas1p3524ecbc4a79ae9b758dd3ae0de6450b4~-rGJyU4mC1200412004epcas1p3_;
        Wed, 25 Mar 2020 22:25:32 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200325222532epsmtrp28eb7f93807a355173c458addd8d83fd1~-rGJxpwxC1869718697epsmtrp2Q;
        Wed, 25 Mar 2020 22:25:32 +0000 (GMT)
X-AuditID: b6c32a36-fbbff7000000102c-fd-5e7bda5dfbd6
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        5C.82.04024.C5ADB7E5; Thu, 26 Mar 2020 07:25:32 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200325222532epsmtip232e63301a26acb9ad61d71bc9bad8cc5~-rGJh_9T_3039830398epsmtip2g;
        Wed, 25 Mar 2020 22:25:32 +0000 (GMT)
Subject: Re: [RFC] PM / devfreq: add busfreq governor
To:     Martin Kepplinger <martin.kepplinger@puri.sm>, linux-imx@nxp.com,
        leonard.crestez@nxp.com, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com
Cc:     linux-pm@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <f84228bc-9d37-acad-1784-0312f89afecb@samsung.com>
Date:   Thu, 26 Mar 2020 07:34:32 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20200325152224.6613-1-martin.kepplinger@puri.sm>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRju286OR2t1PKa+jS7ziIKmueOazUoJkpIMGwT9KHIe9LCJu7Ez
        reUPTbNSM7po1Eq7e1nQRZe3Ek3FEipKk0IZSBlJF6OslCJr2zHy3/M+7/O+D8/3vYSYOo/L
        iByTjbOaWAONB2AtvVGK2L0jBRmKsk5M/aT4o5+6wf1Foi7/2ShWT1X2IfXgWIOfevRgA74J
        T70z2SZKfd02glKPu5wodapppQbbnbtRz7HZnFXOmbLM2TkmXRKdtlO7WatKUDCxTKJ6HS03
        sUYuiU7ZrondkmPwmNPyfNaQ56E0LM/TcckbreY8GyfXm3lbEs1Zsg2WRMsanjXyeSbdmiyz
        cT2jUMSrPMLMXP37M7cwy5P0/S9aI4tQc3I58ieAXAsPWorxchRAUGQbgsrSakwoviKofVYq
        FoofCGqGB/F/IwNlN+ZUnQgqSk6LhOIzgmvDH8ReVRCpghJnr2/xUrIKwdnpDszbEJPL4dfE
        FZ8IJ6Oha+KVb+0SMgyGZ96gckQQUjIZ3DUaL42REVDvvCjx4mByFwy0HEJeLCUDYeDcuG+l
        v0c+fb0fF9aHwsj4RZGAV0Hrpwu+CEC+w+HP6Fs/IUIKzA4fEgk4CN4/dM3xMpia7JyLWQCN
        A324MHwUgavrmURoKKHrujcy4XGIglsdcQIdBu2/apBgvBgmvx+TeCVASuHoYUqQhMPQmHvO
        dhlcPVKGn0C0Y14cx7wIjnkRHP/NLiHMiUI4C2/UcTxjiZ//203Id5jRCW3oytPtPYgkEL1I
        ejuxIIOSsPm83diDgBDTS6XN3P4MSprN2g9wVrPWmmfg+B6k8rz2SbEsOMvsOXOTTcuo4pVK
        pXotk6BiGDpUWv3SkEGROtbG5XKchbP+mxMR/rIitBCcfefsj0+Hp6QE1krXbcMdoysKuyXW
        Tb/Tcz8aqa5qUaQupq40Yjpt0nWK/0bdHjqRc9NSO1SR2V7fsa+kafXWlst3NTH5jzo+FBQv
        xyqzqjaPT9R1F9JRC+Qhxh3uwXq9qdK9bLG++fme+xVnrt7bhvdXURviZLPpoX0zUXYa4/Us
        Ey228uxfbRnoAa4DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplkeLIzCtJLcpLzFFi42LZdlhJXjfmVnWcQdMXRYuzTW/YLVbc/chq
        0fVrJbPF594jjBaXHqxgt7jduILNgc1j47sdTB6Pdtxi9OjbsorR4/MmuQCWKC6blNSczLLU
        In27BK6MV9PWsxSc9au4sl2tgXGzXRcjJ4eEgInEyc7VLF2MXBxCArsZJc4uamKHSEhKTLt4
        lLmLkQPIFpY4fLgYouYto8S1h2dZQGqEBUwlmlcdZgNJiAhMYZTYdmcJM0iCWUBG4veLRcwQ
        HRMZJR5svcsGkmAT0JLY/+IGmM0voChx9cdjRpANvAJ2EnfnBoCEWQRUJZavms8KYosKhEns
        XPKYCcTmFRCUODnzCdhiTqDy70uPsUHsUpf4M+8S1F5xiVtP5jNB2PIS29/OYZ7AKDwLSfss
        JC2zkLTMQtKygJFlFaNkakFxbnpusWGBYV5quV5xYm5xaV66XnJ+7iZGcORoae5gvLwk/hCj
        AAejEg/vBsvqOCHWxLLiytxDjBIczEoivJtTK+KEeFMSK6tSi/Lji0pzUosPMUpzsCiJ8z7N
        OxYpJJCeWJKanZpakFoEk2Xi4JRqYCxUENgg9Gz7moXrvWcy+F1XeF8u8EX8V5v3urL5K2Z+
        kTu/XOhO+LcsqwOrt15cKvX89onAODmz6HfK++MMX5nGC7W4Zb85qL1cb2eic7Pbwn2T433e
        vVi7LvvZ8qf3G496/ZU76RNenHy8NTqPTYn9SXV921y/Nl6F4+5qv+WPXjx3vkXvmq4SS3FG
        oqEWc1FxIgBq59X6mAIAAA==
X-CMS-MailID: 20200325222532epcas1p3524ecbc4a79ae9b758dd3ae0de6450b4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200325152302epcas1p3ba57cfef70d9d8b8dff6d9e2bb09b321
References: <CGME20200325152302epcas1p3ba57cfef70d9d8b8dff6d9e2bb09b321@epcas1p3.samsung.com>
        <20200325152224.6613-1-martin.kepplinger@puri.sm>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Martin,

On 3/26/20 12:22 AM, Martin Kepplinger wrote:
> A devfreq governor to be used by drivers to request ("get") a frequency
> setting they need. Currently only "HIGH" (performance) is available.
> 
> ATTENTION: This is a first draft to serve merely as a basis for discussions!
> ONLY USE FOR TESTING!
> ---
> 
> I wanted to get early feedback on an idea that AFAIK is not yet available
> in the kernel (but something similar via "busfreq" in NXP's tree):
> 
> Let drivers request high (dram) frequencies at runtime if they know they need
> them. In our case the display stack on imx8mq would be the first user,
> looking like so: #include <linux/devfreq.h> and:
> 
> 	--- a/drivers/gpu/drm/bridge/nwl-dsi.c
> 	+++ b/drivers/gpu/drm/bridge/nwl-dsi.c
> 	@@ -1116,6 +1117,9 @@ static int imx8mq_dsi_poweron(struct nwl_dsi *dsi)
> 			ret = reset_control_deassert(dsi->rstc);
> 	 
> 	+       devfreq_busfreq_request(DEVFREQ_BUSFREQ_HIGH);

It seems that the nwl-dsi.c requires the minimum frequency to DRAM driver
in order to guarantee the at least performance.

The devfreq framework already support this feature via PM QoS.
You can refer to following the merged patches[1][2]

[1] 05d7ae15cfb1 ("PM / devfreq: Add PM QoS support")
[2] 27dbc542f651 ("PM / devfreq: Use PM QoS for sysfs min/max_freq")


> 	+
> 		return ret;
> 	@@ -1125,6 +1129,10 @@ static int imx8mq_dsi_poweroff(struct nwl_dsi *dsi)
> 		if (dsi->rstc)
> 			ret = reset_control_assert(dsi->rstc);
> 	+
> 	+       devfreq_busfreq_release(DEVFREQ_BUSFREQ_HIGH);

ditto.

> 	+
> 		return ret;
> 
> 
> Could be called in pm_runtime() calls too.
> 
> _If_ the idea of such or a similar governor is viable, there are at least
> some problems with this implemenation still:
> 
> * The governor saves its data as a global variable (which I don't yet like)
>   but the driver (user) API becomes minimal.
> 
> * the name: In order to add to the devfreq/busfreq confusion, I named the
>   devfreq governor "busfreq" -.-
>   I just wanted to grab NXPs' attention because they do something similar
>   in their tree.
> 
> * ATM we switch between "performace" and "powersave, which is
>   not bad at all, but still limited in case a driver would really only
>   need a medium frequecy for a device to work. doable?
> 
> * I doubt locking is done correctly and the code is overall of bad quality
>   still. Again, It's a first idea.
> 
> I'm glad about any thought or feedback,
> 
> thanks,
>                                    martin
> 
> 
> 
> 
>  drivers/devfreq/Kconfig            |   5 +
>  drivers/devfreq/Makefile           |   1 +
>  drivers/devfreq/governor_busfreq.c | 172 +++++++++++++++++++++++++++++
>  include/linux/devfreq.h            |  22 ++++
>  4 files changed, 200 insertions(+)
>  create mode 100644 drivers/devfreq/governor_busfreq.c
> 
> diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
> index fc2ea336ef4b..3575cbdcd29e 100644
> --- a/drivers/devfreq/Kconfig
> +++ b/drivers/devfreq/Kconfig
> @@ -74,6 +74,11 @@ config DEVFREQ_GOV_PASSIVE
>  	  through sysfs entries. The passive governor recommends that
>  	  devfreq device uses the OPP table to get the frequency/voltage.
>  
> +config DEVFREQ_GOV_BUSFREQ
> +	tristate "Busfreq"
> +	help
> +	  Sets the frequency that compatible drivers request it to set.
> +
>  comment "DEVFREQ Drivers"
>  
>  config ARM_EXYNOS_BUS_DEVFREQ
> diff --git a/drivers/devfreq/Makefile b/drivers/devfreq/Makefile
> index 61d0edee16f7..657b0b6d92c4 100644
> --- a/drivers/devfreq/Makefile
> +++ b/drivers/devfreq/Makefile
> @@ -6,6 +6,7 @@ obj-$(CONFIG_DEVFREQ_GOV_PERFORMANCE)	+= governor_performance.o
>  obj-$(CONFIG_DEVFREQ_GOV_POWERSAVE)	+= governor_powersave.o
>  obj-$(CONFIG_DEVFREQ_GOV_USERSPACE)	+= governor_userspace.o
>  obj-$(CONFIG_DEVFREQ_GOV_PASSIVE)	+= governor_passive.o
> +obj-$(CONFIG_DEVFREQ_GOV_BUSFREQ)	+= governor_busfreq.o

governor_busfreq.c seems that change the clock rate according to
the user requirement. On that, governor_busfreq only uses
two frequencies level like the high and low frequencies.

I think that it is possible to be implemented by using following combination:
- NXP DRM devfreq driver with userspace governor + PMQoS on nwl-dsi.c

IMO, instead of governor_busfreq.c, better to add the NXP's DRM devfreq driver.

>  
>  # DEVFREQ Drivers
>  obj-$(CONFIG_ARM_EXYNOS_BUS_DEVFREQ)	+= exynos-bus.o
> diff --git a/drivers/devfreq/governor_busfreq.c b/drivers/devfreq/governor_busfreq.c
> new file mode 100644
> index 000000000000..e12d64e9a09b
> --- /dev/null
> +++ b/drivers/devfreq/governor_busfreq.c
> @@ -0,0 +1,172 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + *  linux/drivers/devfreq/governor_busfreq.c
> + *
> + *  Copyright (C) 2020 Purism SPC
> + */
> +
> +#include <linux/slab.h>
> +#include <linux/device.h>
> +#include <linux/devfreq.h>
> +#include <linux/pm.h>
> +#include <linux/mutex.h>
> +#include <linux/module.h>
> +#include "governor.h"
> +
> +struct busfreq_data {
> +	unsigned long user_frequency;
> +	bool valid;
> +	struct devfreq *df;
> +	unsigned int high_count;
> +};
> +
> +static struct busfreq_data *bfdata = NULL;
> +
> +static int devfreq_busfreq_func(struct devfreq *df, unsigned long *freq)
> +{
> +	if (bfdata->valid)
> +		*freq = bfdata->user_frequency;
> +	else
> +		*freq = df->previous_freq; /* No user freq specified yet */
> +
> +	return 0;
> +}
> +
> +int devfreq_busfreq_request(unsigned long freq)
> +{
> +	struct devfreq *devfreq;
> +	int err = 0;
> +
> +	if (!bfdata) {
> +		pr_info("%s: governor not available\n", __func__);
> +		return -ENODEV;
> +	}
> +
> +	if (freq != DEVFREQ_BUSFREQ_HIGH) {
> +		pr_err("%s: undefined frequency\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	if (freq == DEVFREQ_BUSFREQ_HIGH)
> +		bfdata->high_count++;
> +
> +	devfreq = bfdata->df;
> +
> +	mutex_lock(&devfreq->lock);
> +
> +	bfdata->user_frequency = freq;
> +	bfdata->valid = true;
> +	err = update_devfreq(devfreq); /* calls our get_target_freq */
> +	if (err)
> +		dev_err(&devfreq->dev, "update_devfreq failed: %d\n", err);
> +
> +	mutex_unlock(&devfreq->lock);
> +
> +	return err;
> +}
> +EXPORT_SYMBOL(devfreq_busfreq_request);
> +
> +void devfreq_busfreq_release(unsigned long freq)
> +{
> +	struct devfreq *devfreq;
> +	int err = 0;
> +
> +	if (!bfdata) {
> +		pr_info("%s: governor not available\n", __func__);
> +		return;
> +	}
> +
> +	if (freq != DEVFREQ_BUSFREQ_HIGH) {
> +		pr_err("%s: undefined frequency\n", __func__);
> +		return;
> +	}
> +
> +	if (freq == DEVFREQ_BUSFREQ_HIGH && bfdata->high_count > 0)
> +		bfdata->high_count--;
> +
> +	if (bfdata->high_count)
> +		return;
> +
> +	devfreq = bfdata->df;
> +
> +	mutex_lock(&devfreq->lock);
> +
> +	bfdata->user_frequency = DEVFREQ_BUSFREQ_LOW;
> +	bfdata->valid = true;
> +	err = update_devfreq(devfreq); /* calls our get_target_freq */
> +	if (err)
> +		dev_err(&devfreq->dev, "update_devfreq failed: %d\n", err);
> +
> +	mutex_unlock(&devfreq->lock);
> +}
> +EXPORT_SYMBOL(devfreq_busfreq_release);
> +
> +static int busfreq_init(struct devfreq *devfreq)
> +{
> +	int err = 0;
> +
> +	bfdata = kzalloc(sizeof(struct busfreq_data),
> +		      GFP_KERNEL);
> +	if (!bfdata) {
> +		err = -ENOMEM;
> +		goto out;
> +	}
> +	bfdata->valid = false;
> +	devfreq->data = bfdata;
> +	bfdata->df = devfreq;
> +
> +out:
> +	return err;
> +}
> +
> +static void busfreq_exit(struct devfreq *devfreq)
> +{
> +	if (bfdata)
> +		kfree(bfdata);
> +
> +	devfreq->data = NULL;
> +}
> +
> +static int devfreq_busfreq_handler(struct devfreq *devfreq,
> +				   unsigned int event, void *data)
> +{
> +	int ret = 0;
> +
> +	switch (event) {
> +	case DEVFREQ_GOV_START:
> +		ret = busfreq_init(devfreq);
> +		break;
> +	case DEVFREQ_GOV_STOP:
> +		busfreq_exit(devfreq);
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +static struct devfreq_governor devfreq_busfreq = {
> +	.name = "busfreq",
> +	.get_target_freq = devfreq_busfreq_func,
> +	.event_handler = devfreq_busfreq_handler,
> +};
> +
> +static int __init devfreq_busfreq_init(void)
> +{
> +	return devfreq_add_governor(&devfreq_busfreq);
> +}
> +subsys_initcall(devfreq_busfreq_init);
> +
> +static void __exit devfreq_busfreq_exit(void)
> +{
> +	int ret;
> +
> +	ret = devfreq_remove_governor(&devfreq_busfreq);
> +	if (ret)
> +		pr_err("%s: failed remove governor %d\n", __func__, ret);
> +
> +	return;
> +}
> +module_exit(devfreq_busfreq_exit);
> +MODULE_LICENSE("GPL");
> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
> index 678391c1bb0f..df1bf6928d87 100644
> --- a/include/linux/devfreq.h
> +++ b/include/linux/devfreq.h
> @@ -23,6 +23,7 @@
>  #define DEVFREQ_GOV_POWERSAVE		"powersave"
>  #define DEVFREQ_GOV_USERSPACE		"userspace"
>  #define DEVFREQ_GOV_PASSIVE		"passive"
> +#define DEVFREQ_GOV_BUSFREQ		"busfreq"
>  
>  /* DEVFREQ notifier interface */
>  #define DEVFREQ_TRANSITION_NOTIFIER	(0)
> @@ -310,6 +311,27 @@ struct devfreq_passive_data {
>  };
>  #endif
>  
> +/*
> + * "powersave" by default
> + * giving drivers the option to require "performance"
> + */
> +#define DEVFREQ_BUSFREQ_HIGH			ULONG_MAX
> +#define DEVFREQ_BUSFREQ_LOW			0
> +#if IS_ENABLED(CONFIG_DEVFREQ_GOV_BUSFREQ)
> +extern int devfreq_busfreq_request(unsigned long freq);
> +extern void devfreq_busfreq_release(unsigned long freq);
> +#else
> +static inline int devfreq_busfreq_request(unsigned long freq)
> +{
> +	return -ENOSYS;
> +}
> +
> +static inline void devfreq_busfreq_release(unsigned long freq)
> +{
> +	return;
> +}
> +#endif
> +
>  #else /* !CONFIG_PM_DEVFREQ */
>  static inline struct devfreq *devfreq_add_device(struct device *dev,
>  					  struct devfreq_dev_profile *profile,
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
