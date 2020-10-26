Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D21D92985D1
	for <lists+linux-pm@lfdr.de>; Mon, 26 Oct 2020 04:07:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1420847AbgJZDGm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 25 Oct 2020 23:06:42 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:14859 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389741AbgJZDGl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 25 Oct 2020 23:06:41 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20201026030635epoutp02f6b2b68bbbfd1eb6fe44ae18500164ef~Ba_oqjstk2915329153epoutp020
        for <linux-pm@vger.kernel.org>; Mon, 26 Oct 2020 03:06:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20201026030635epoutp02f6b2b68bbbfd1eb6fe44ae18500164ef~Ba_oqjstk2915329153epoutp020
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1603681595;
        bh=wshxurGjF4X118ZbuS6qWV5Ory9u21tA8EzJswY6c68=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=E29IzhaFjKI2EoNYzUuL28jCGP4vgDnUay945/Xza7wJLcA6l1JsUCjirKbZBExnQ
         s0UYJTAELFqJOCLWfyZcizhpjWa7PSqTrZFLepvnwEgN0hEFjAbL5+/stopmEzQvcC
         7PQ0VpqzdbJpRipTIFpVCdUyCfN7Y5voxZKNjvnM=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20201026030634epcas1p2ae6b4f34b798e61229536d71f06f1024~Ba_n50p0C2543625436epcas1p2b;
        Mon, 26 Oct 2020 03:06:34 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.155]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4CKKVd0NB5zMqYkX; Mon, 26 Oct
        2020 03:06:33 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        46.C0.09543.83D369F5; Mon, 26 Oct 2020 12:06:32 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20201026030632epcas1p1a69153f0e0dc68396dc55956181478f9~Ba_lpZ6Sz2198521985epcas1p1Q;
        Mon, 26 Oct 2020 03:06:32 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20201026030632epsmtrp2e8b46e412780524c82533be26517ab00~Ba_lovkWb0067800678epsmtrp2f;
        Mon, 26 Oct 2020 03:06:32 +0000 (GMT)
X-AuditID: b6c32a35-35dff70000002547-14-5f963d383ac5
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        FA.07.08745.83D369F5; Mon, 26 Oct 2020 12:06:32 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20201026030632epsmtip2a51aef72e5220768e043d0799a309a8c~Ba_lYwxlA2421824218epsmtip2P;
        Mon, 26 Oct 2020 03:06:32 +0000 (GMT)
Subject: Re: [PATCH v2] PM / devfreq: Remove redundant governor_name from
 struct devfreq
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     chanwoo@kernel.org, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <98da4fe9-5b3b-1bb7-a35d-1083a8032f1e@samsung.com>
Date:   Mon, 26 Oct 2020 12:20:21 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20201023103215.24647-1-cw00.choi@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkk+LIzCtJLcpLzFFi42LZdlhTX9fCdlq8wYvF1hYTb1xhsTjb9Ibd
        4vKuOWwWn3uPMFrcblzB5sDqsWlVJ5tH35ZVjB6fN8kFMEdl22SkJqakFimk5iXnp2Tmpdsq
        eQfHO8ebmhkY6hpaWpgrKeQl5qbaKrn4BOi6ZeYArVRSKEvMKQUKBSQWFyvp29kU5ZeWpCpk
        5BeX2CqlFqTkFFgW6BUn5haX5qXrJefnWhkaGBiZAhUmZGdc2buAseCEYcWUKVsZGxhnanQx
        cnJICJhILH3+nr2LkYtDSGAHo8Tl9b9ZQRJCAp8YJX7drIJIfGaUOHKvkamLkQOs48KsJIj4
        LkaJlqXtTBDOe0aJOVs/sIN0CwtESTQcXghmiwhYSZz+38EMYjMLeEssfruaEcRmE9CS2P/i
        BhuIzS+gKHH1x2OwOK+AncT+74/ArmARUJVYdvkOC4gtKhAmcXJbC1SNoMTJmU9YQA7iFLCW
        2Li1FGK8uMStJ/OZIGx5ie1v5zBDfPmXXWJHUy2E7SLx5VYTK4QtLPHq+BZ2CFtK4vO7vWwQ
        drXEypNH2ED+khDoYJTYsv8CVIOxxP6lk8EBwSygKbF+lz5EWFFi5++5jBB7+STefe1hhYQV
        r0RHmxBEibLE5Qd3mSBsSYnF7Z1sExiVZiF5ZhaSD2Yh+WAWwrIFjCyrGMVSC4pz01OLDQsM
        kaN6EyM4LWqZ7mCc+PaD3iFGJg7GQ4wSHMxKIrxzZKbGC/GmJFZWpRblxxeV5qQWH2I0BQbv
        RGYp0eR8YGLOK4k3NDUyNja2MDE0MzU0VBLn/aPdES8kkJ5YkpqdmlqQWgTTx8TBKdXAdKN9
        d1z6l5/HG0T0S2s8NTK7hX2rXV8ZaIvmWXEoakuufPvB/9dxdf14EUvx3/E6msp6Fn8zDZdH
        LfeasVzZfZmk6lx1bYnjDPHrb5u7/dn1xqh4gqBkn0kT17vEKZej5s3okP/l1OljHhbi4TDl
        s/myZv6uW24+dXN3Wy3vi9Ou3L376+eTR+o2pBY0nprBti3UmC29y2VxYkj1r3Uq5xW/y23Q
        qn/xM66Tzd1AUK8qniHG+MGmJZNnWp/745vbYbuZedsGu/O9rqpeARP+Lrk28cJNmQ8vdl+8
        ez4qVXDiwwiH3COhTQcMCv4LOyr+O2T4d/uRHbnHjnBMZVwSY55UduLgoz/bP24o2q2nxFKc
        kWioxVxUnAgAIWr2whQEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLLMWRmVeSWpSXmKPExsWy7bCSvK6F7bR4g9vXxC0m3rjCYnG26Q27
        xeVdc9gsPvceYbS43biCzYHVY9OqTjaPvi2rGD0+b5ILYI7isklJzcksSy3St0vgyriydwFj
        wQnDiilTtjI2MM7U6GLk4JAQMJG4MCupi5GLQ0hgB6PEkbPzGLsYOYHikhLTLh5lhqgRljh8
        uBii5i2jxKYte9lAaoQFoiQaDi9kB7FFBKwkTv/vYAaxmQW8JRa/Xc0I0dDHKPHz/E8mkASb
        gJbE/hc3wJr5BRQlrv54DLaMV8BOYv/3R6wgNouAqsSyy3dYQGxRgTCJnUseM0HUCEqcnPmE
        BeQgTgFriY1bSyF2qUv8mXcJaq+4xK0n85kgbHmJ7W/nME9gFJ6FpHsWkpZZSFpmIWlZwMiy
        ilEytaA4Nz232LDAKC+1XK84Mbe4NC9dLzk/dxMjOEa0tHYw7ln1Qe8QIxMH4yFGCQ5mJRHe
        OTJT44V4UxIrq1KL8uOLSnNSiw8xSnOwKInzfp21ME5IID2xJDU7NbUgtQgmy8TBKdXApJFw
        va23x0Dc/9T61XqSO63PpEo8OMaU+fYeQ8DZ3n9HyluDOjK0N/p48kbKcb76bP5gavO0/3ql
        q0z3Jelea36Q6Vn95lGxR9SNFRZOa781iz3ad3f7rD8X9j3xW5hc1Xrogvb1Eh2VA3Mlde0O
        f7jpP29J043Tc/N2RupvjC6Jm6f9qGdvW5Pt1+kbfOqN7sr48RrlaBxYYXJw67SH5t/y2kru
        cpe7yyj8/PTcRphZVFbKf1Hxq+df7B/KSyanH+bR2Kc1+b2G6KtL6y+eXZfxSvcng/5quSCF
        j++OdXHNM5nHKRSy905b9mufVb8DPn8UZNo+2SMtpevOgvNOomfm8v3w59cpmSO/XrHxjhJL
        cUaioRZzUXEiANEFi5gAAwAA
X-CMS-MailID: 20201026030632epcas1p1a69153f0e0dc68396dc55956181478f9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20201023101830epcas1p446aee869d0211a62f68cdf616b6203ed
References: <CGME20201023101830epcas1p446aee869d0211a62f68cdf616b6203ed@epcas1p4.samsung.com>
        <20201023103215.24647-1-cw00.choi@samsung.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10/23/20 7:32 PM, Chanwoo Choi wrote:
> The devfreq structure instance contains the governor_name and a governor
> instance. When need to show the governor name, better to use the name
> of devfreq_governor structure. So, governor_name variable in struct devfreq
> is a redundant and unneeded variable. Remove the redundant governor_name
> of struct devfreq and then use the name of devfreq_governor instance.
> 
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
> Changes from v1:
> - Rebase it on "[PATCH v5 0/2] PM / devfreq: Add governor feature and attribute flag"
> 
>  drivers/devfreq/devfreq.c  | 18 +++++++-----------
>  drivers/devfreq/governor.h |  2 ++
>  include/linux/devfreq.h    |  4 ----
>  3 files changed, 9 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index f6c55cf498ed..74f71588ace5 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -811,7 +811,6 @@ struct devfreq *devfreq_add_device(struct device *dev,
>  	devfreq->dev.release = devfreq_dev_release;
>  	INIT_LIST_HEAD(&devfreq->node);
>  	devfreq->profile = profile;
> -	strscpy(devfreq->governor_name, governor_name, DEVFREQ_NAME_LEN);
>  	devfreq->previous_freq = profile->initial_freq;
>  	devfreq->last_status.current_frequency = profile->initial_freq;
>  	devfreq->data = data;
> @@ -907,7 +906,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
>  
>  	mutex_lock(&devfreq_list_lock);
>  
> -	governor = try_then_request_governor(devfreq->governor_name);
> +	governor = try_then_request_governor(governor_name);
>  	if (IS_ERR(governor)) {
>  		dev_err(dev, "%s: Unable to find governor for the device\n",
>  			__func__);
> @@ -1250,7 +1249,7 @@ int devfreq_add_governor(struct devfreq_governor *governor)
>  		int ret = 0;
>  		struct device *dev = devfreq->dev.parent;
>  
> -		if (!strncmp(devfreq->governor_name, governor->name,
> +		if (!strncmp(devfreq->governor->name, governor->name,
>  			     DEVFREQ_NAME_LEN)) {
>  			/* The following should never occur */
>  			if (devfreq->governor) {
> @@ -1312,7 +1311,7 @@ int devfreq_remove_governor(struct devfreq_governor *governor)
>  		int ret;
>  		struct device *dev = devfreq->dev.parent;
>  
> -		if (!strncmp(devfreq->governor_name, governor->name,
> +		if (!strncmp(devfreq->governor->name, governor->name,
>  			     DEVFREQ_NAME_LEN)) {
>  			/* we should have a devfreq governor! */
>  			if (!devfreq->governor) {
> @@ -1407,7 +1406,6 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
>  	 */
>  	prev_governor = df->governor;
>  	df->governor = governor;
> -	strncpy(df->governor_name, governor->name, DEVFREQ_NAME_LEN);
>  	ret = df->governor->event_handler(df, DEVFREQ_GOV_START, NULL);
>  	if (ret) {
>  		dev_warn(dev, "%s: Governor %s not started(%d)\n",
> @@ -1415,13 +1413,11 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
>  
>  		/* Restore previous governor */
>  		df->governor = prev_governor;
> -		strncpy(df->governor_name, prev_governor->name,
> -			DEVFREQ_NAME_LEN);
>  		ret = df->governor->event_handler(df, DEVFREQ_GOV_START, NULL);
>  		if (ret) {
>  			dev_err(dev,
>  				"%s: reverting to Governor %s failed (%d)\n",
> -				__func__, df->governor_name, ret);
> +				__func__, prev_governor->name, ret);
>  			df->governor = NULL;
>  			goto out;
>  		}
> @@ -1457,7 +1453,7 @@ static ssize_t available_governors_show(struct device *d,
>  	 */
>  	if (IS_SUPPORTED_FLAG(df->governor->flags, IMMUTABLE)) {
>  		count = scnprintf(&buf[count], DEVFREQ_NAME_LEN,
> -				  "%s ", df->governor_name);
> +				  "%s ", df->governor->name);
>  	/*
>  	 * The devfreq device shows the registered governor except for
>  	 * immutable governors such as passive governor .
> @@ -1900,7 +1896,7 @@ static int devfreq_summary_show(struct seq_file *s, void *data)
>  
>  	list_for_each_entry_reverse(devfreq, &devfreq_list, node) {
>  #if IS_ENABLED(CONFIG_DEVFREQ_GOV_PASSIVE)
> -		if (!strncmp(devfreq->governor_name, DEVFREQ_GOV_PASSIVE,
> +		if (!strncmp(devfreq->governor->name, DEVFREQ_GOV_PASSIVE,
>  							DEVFREQ_NAME_LEN)) {
>  			struct devfreq_passive_data *data = devfreq->data;
>  
> @@ -1926,7 +1922,7 @@ static int devfreq_summary_show(struct seq_file *s, void *data)
>  			"%-30s %-30s %-15s %-10s %10d %12ld %12ld %12ld\n",
>  			dev_name(&devfreq->dev),
>  			p_devfreq ? dev_name(&p_devfreq->dev) : "null",
> -			devfreq->governor_name,
> +			devfreq->governor->name,
>  			polling_ms ? timer_name[timer] : "null",
>  			polling_ms,
>  			cur_freq,
> diff --git a/drivers/devfreq/governor.h b/drivers/devfreq/governor.h
> index df413b851bb2..2a52f97b542d 100644
> --- a/drivers/devfreq/governor.h
> +++ b/drivers/devfreq/governor.h
> @@ -13,6 +13,8 @@
>  
>  #include <linux/devfreq.h>
>  
> +#define DEVFREQ_NAME_LEN			16
> +
>  #define to_devfreq(DEV)	container_of((DEV), struct devfreq, dev)
>  
>  /* Devfreq events */
> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
> index 2f4a74efa6be..82156721f459 100644
> --- a/include/linux/devfreq.h
> +++ b/include/linux/devfreq.h
> @@ -15,8 +15,6 @@
>  #include <linux/pm_opp.h>
>  #include <linux/pm_qos.h>
>  
> -#define DEVFREQ_NAME_LEN 16
> -
>  /* DEVFREQ governor name */
>  #define DEVFREQ_GOV_SIMPLE_ONDEMAND	"simple_ondemand"
>  #define DEVFREQ_GOV_PERFORMANCE		"performance"
> @@ -139,7 +137,6 @@ struct devfreq_stats {
>   *		using devfreq.
>   * @profile:	device-specific devfreq profile
>   * @governor:	method how to choose frequency based on the usage.
> - * @governor_name:	devfreq governor name for use with this devfreq
>   * @nb:		notifier block used to notify devfreq object that it should
>   *		reevaluate operable frequencies. Devfreq users may use
>   *		devfreq.nb to the corresponding register notifier call chain.
> @@ -176,7 +173,6 @@ struct devfreq {
>  	struct device dev;
>  	struct devfreq_dev_profile *profile;
>  	const struct devfreq_governor *governor;
> -	char governor_name[DEVFREQ_NAME_LEN];
>  	struct notifier_block nb;
>  	struct delayed_work work;
>  
> 

Applied it.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
