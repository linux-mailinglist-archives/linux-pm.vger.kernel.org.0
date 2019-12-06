Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E810114AD3
	for <lists+linux-pm@lfdr.de>; Fri,  6 Dec 2019 03:13:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbfLFCNc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Dec 2019 21:13:32 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:30030 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbfLFCNb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Dec 2019 21:13:31 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20191206021328epoutp02941add31fb06834082c90ccd20dc4b41~dpmeHDcv80510405104epoutp025
        for <linux-pm@vger.kernel.org>; Fri,  6 Dec 2019 02:13:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20191206021328epoutp02941add31fb06834082c90ccd20dc4b41~dpmeHDcv80510405104epoutp025
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1575598408;
        bh=67vB34bM5klXDYYckC0Xc5qLbQ4S34ZNoRafFoL/Ruk=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=d/tK16sJ8dlHn1d5AVPq9ucc5A0tJZLGZSmCTzUSLWvGFeacNU5T/PqDmNc5GnB2f
         2Mv2uzkYu7aRRouic5+ag0dRzbFQSlYLQXV5ZE08NQ950uFOt9S26mYAPrsKnW2XQL
         rSlHO+D8Np0L652kAUAp3GSeMrI3vD2zTPfRb1HQ=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191206021327epcas1p14aad0c4711c382466ff1edc74f2de746~dpmdq3gJY0425704257epcas1p1K;
        Fri,  6 Dec 2019 02:13:27 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.153]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 47TbjK4D9YzMqYkk; Fri,  6 Dec
        2019 02:13:25 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        D6.2E.48019.549B9ED5; Fri,  6 Dec 2019 11:13:25 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20191206021324epcas1p2e991144c2be80da75787d55665d515ea~dpmbDK0Lj0277302773epcas1p2h;
        Fri,  6 Dec 2019 02:13:24 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191206021324epsmtrp2e51827c8ff3fc8830724ef668d27066a~dpmbCW7611219112191epsmtrp2U;
        Fri,  6 Dec 2019 02:13:24 +0000 (GMT)
X-AuditID: b6c32a38-257ff7000001bb93-86-5de9b945fe61
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E0.3C.10238.449B9ED5; Fri,  6 Dec 2019 11:13:24 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191206021324epsmtip14241f2853e01bee2eb74c09ba88caa6c~dpmawioMO2204422044epsmtip1C;
        Fri,  6 Dec 2019 02:13:24 +0000 (GMT)
Subject: Re: [PATCH v4] PM / devfreq: add clearing transitions stats
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     rafael.j.wysocki@intel.com, myungjoo.ham@samsung.com,
        b.zolnierkie@samsung.com, gregkh@linuxfoundation.org,
        krzk@kernel.org, kyungmin.park@samsung.com,
        m.szyprowski@samsung.com, mchehab@kernel.org, cpgs@samsung.com,
        Kamil Konieczny <k.konieczny@samsung.com>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <fba062e6-6b49-afcb-70db-c0967989f60c@samsung.com>
Date:   Fri, 6 Dec 2019 11:19:38 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20191206021813.7193-1-cw00.choi@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02TWUwTURSGuW1nqaEwFNBrHxQGH4QE6FiqA6HGRJS6PBCNPmiaMoGhELql
        U4hKSEBR3CMxKjSgJogiLlBENgtFwBhiAAki7sGAkbqgUkUUTOx0MPL2zTn/f87978zgYrkL
        VeA5ZjtrMzNGEl0iae6Jjo/d1ObRKVvukLSzvB6hPd3R9KHqepS+PF2O0IODDRjdf/ATRg+3
        V6K091QvoG/1vsboq43zIvplcS1Kj9d+xjYEaqtdHpG2se4YqnVX3cS0p5vqgNbbuCIN2ZOb
        nM0ymawtgjVnWDJzzAYNuW2nfqNevVZJxVKJ9DoywsyYWA2Zsj0tdnOO0Xc8MiKfMeb5SmkM
        x5Hx65Ntljw7G5Ft4ewakrVmGq2J1jiOMXF5ZkNchsWURCmVa9Q+YXpudu15L2KdWb7vo+Ml
        KALF4ceBFIdEAuy69wA9DpbgcqIVwMPN1QjfkBPTAM71qYXGDIBtQ99E/xzvXGdFQqMDwPqH
        xZjw8AXAkYFqwKtCiRR4sbQS4zmMSIKTpR/8LCZOiOCVryjPKBED3ZPP/BxMRMKR2XGfF8dl
        xHrofO5fJiFWwc4n035JOLEb9jWX+MfLiBDYVzEh4VnqG//07mMgjF8GX0xcEgm8ErZ8rhTz
        Z4PERQwWvSpDhAQp8FOXRyxwKPzwsAkTWAG9Ux2owAXwel8vKpiPAtjkfrxgVkF3DR8f922I
        hvXt8UI5ErbNVQGBZbDIObeQNwhO/TiJ8HK+fvSIXJBEweGx16IzIMqxKI5jUQTHogiO/8su
        A0kdWMpaOZOB5ShrwuKX3Qj8X24M3QpcA9u7AYEDMlBW7p3UyREmn9tv6gYQF5NhMkOQRyeX
        ZTL7D7A2i96WZ2S5bqD23XaZWBGeYfH9B2a7nlKvUalUdAK1Vk1R5DIZPjukkxMGxs7msqyV
        tf3ziXCpoggEuDsVDWHOn8UnY89U/C54cy11g7JEkxiUemTCo390DneO6w54By+UhTyPH04f
        7a/6czt4d4VblXr6RZLqbcCjG/dVW3Ln2/NnC2lXEvJraMsYW9g5trpmV2nZhGZHVIr0dlrP
        roDvbSXNMVuDzrqyAkeXEtL31+cuROpqMrLSFXtJCZfNUDFiG8f8BVXneErPAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBIsWRmVeSWpSXmKPExsWy7bCSnK7LzpexBp3HTSw2zljPavHykKZF
        8+L1bBYLPs1gtTh/fgO7xdmmN+wWl3fNYbP43HuE0WLtkbvsFss2/WGyuN24gs3i8Yq37A48
        Hov3vGTy2LSqk81j/9w17B59W1YxenzeJBfAGsVlk5Kak1mWWqRvl8CVsWLaZ9aCb5IVr2fd
        ZmxgbBTtYuTkkBAwkXi6ZzJTFyMXh5DAbkaJ5ld/WCESkhLTLh5l7mLkALKFJQ4fLoaoecso
        8fTYJUaQGmEBF4l57XPYQWwRASuJF+2v2EGKmAW6mSRuztgBNfUAo8SuM5uZQarYBLQk9r+4
        wQZi8wsoSlz98ZgRZAOvgJ3ExptMIGEWARWJfVc+gZWICoRJ7FzyGCzOKyAocXLmExYQmxNo
        2bWtF8COYBZQl/gz7xIzhC0ucevJfCYIW15i+9s5zBMYhWchaZ+FpGUWkpZZSFoWMLKsYpRM
        LSjOTc8tNiwwzEst1ytOzC0uzUvXS87P3cQIjj8tzR2Ml5fEH2IU4GBU4uGd8flFrBBrYllx
        Ze4hRgkOZiUR3nS+l7FCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeZ/mHYsUEkhPLEnNTk0tSC2C
        yTJxcEo1MOpszXPd9uNp5JQr21ovXJj3fY6lWMPxmU7P7SYueuXPmDhBskb5X4Io/zym1kxe
        eQ2FpR8fVEx2CJ6gOCHoRsKMcqHn96VlLb7t2/7u0RqhuwHbO3JfZMw613DnxoSgnSwbCq9J
        z2u9LnbcbaXetGU9zqb3lrcbzDikv+6v8mT9Ch0Pi9N7PvgpsRRnJBpqMRcVJwIAMKm+ersC
        AAA=
X-CMS-MailID: 20191206021324epcas1p2e991144c2be80da75787d55665d515ea
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
X-CPGSPASS: Y
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191206021208epcas1p1d7b3bb434108f38b0ef83b1c7d7a5d79
References: <20191205145527.26117-1-k.konieczny@samsung.com>
        <CGME20191206021208epcas1p1d7b3bb434108f38b0ef83b1c7d7a5d79@epcas1p1.samsung.com>
        <20191206021813.7193-1-cw00.choi@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12/6/19 11:18 AM, Chanwoo Choi wrote:
> From: Kamil Konieczny <k.konieczny@samsung.com>
> 
> Add clearing transition table and time in states devfreq statistics
> by writing 0 (zero) to trans_stat file in devfreq sysfs. An example use
> is like following:
> 
> echo 0 > /sys/class/devfreq/devfreqX/trans_stat
> 
> Signed-off-by: Kamil Konieczny <k.konieczny@samsung.com>
> [cw00.choi: Edit return value if entering the wrong value for reset
>  and use arrary3_size() to get the size of 3-dimensional array]
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
>  Documentation/ABI/testing/sysfs-class-devfreq | 11 ++++---
>  drivers/devfreq/devfreq.c                     | 29 ++++++++++++++++++-
>  2 files changed, 35 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-devfreq b/Documentation/ABI/testing/sysfs-class-devfreq
> index 75897e2fde43..9758eb85ade3 100644
> --- a/Documentation/ABI/testing/sysfs-class-devfreq
> +++ b/Documentation/ABI/testing/sysfs-class-devfreq
> @@ -55,12 +55,15 @@ What:		/sys/class/devfreq/.../trans_stat
>  Date:		October 2012
>  Contact:	MyungJoo Ham <myungjoo.ham@samsung.com>
>  Description:
> -		This ABI shows the statistics of devfreq behavior on a
> -		specific device. It shows the time spent in each state and
> -		the number of transitions between states.
> +		This ABI shows or clears the statistics of devfreq behavior
> +		on a specific device. It shows the time spent in each state
> +		and the number of transitions between states.
>  		In order to activate this ABI, the devfreq target device
>  		driver should provide the list of available frequencies
> -		with its profile.
> +		with its profile. If need to reset the statistics of devfreq
> +		behavior on a specific device, enter 0(zero) to 'trans_stat'
> +		as following:
> +			echo 0 > /sys/class/devfreq/.../trans_stat
>  
>  What:		/sys/class/devfreq/.../userspace/set_freq
>  Date:		September 2011
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index abecadeb3dc2..df31f430051d 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -1478,7 +1478,34 @@ static ssize_t trans_stat_show(struct device *dev,
>  					devfreq->total_trans);
>  	return len;
>  }
> -static DEVICE_ATTR_RO(trans_stat);
> +
> +static ssize_t trans_stat_store(struct device *dev,
> +				struct device_attribute *attr,
> +				const char *buf, size_t count)
> +{
> +	struct devfreq *df = to_devfreq(dev);
> +	int err, value;
> +
> +	if (df->profile->max_state == 0)
> +		return count;
> +
> +	err = kstrtoint(buf, 10, &value);
> +	if (err || value != 0)
> +		return -EINVAL;
> +
> +	mutex_lock(&df->lock);
> +	memset(df->time_in_state, 0, (df->profile->max_state *
> +					sizeof(*df->time_in_state)));
> +	memset(df->trans_table, 0, array3_size(sizeof(unsigned int),
> +					df->profile->max_state,
> +					df->profile->max_state));
> +	df->total_trans = 0;
> +	df->last_stat_updated = get_jiffies_64();
> +	mutex_unlock(&df->lock);
> +
> +	return count;
> +}
> +static DEVICE_ATTR_RW(trans_stat);
>  
>  static struct attribute *devfreq_attrs[] = {
>  	&dev_attr_name.attr,
> 

Applied it. Thanks.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
