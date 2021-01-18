Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A77272F99FB
	for <lists+linux-pm@lfdr.de>; Mon, 18 Jan 2021 07:35:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732534AbhARGev (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Jan 2021 01:34:51 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:42046 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732531AbhARGel (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Jan 2021 01:34:41 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20210118063355epoutp04fdf2bd63383b82c5d801b0979a10e977~bP-osYLsA2250222502epoutp04Z
        for <linux-pm@vger.kernel.org>; Mon, 18 Jan 2021 06:33:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20210118063355epoutp04fdf2bd63383b82c5d801b0979a10e977~bP-osYLsA2250222502epoutp04Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1610951635;
        bh=hQHgH71GUMRIFwLl2ZCUbd6ufxok+cvZxVmobsYCrbg=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=myiCAREeKebqXWoE7kWMFR+MUlfsUBhEdceR9zOnt6v8Hnt/kF1Mj544ruZFBr5bc
         5ccSgUM186KGFbgo19a1xZs+iouq07TuFp11kTBO/QOvlJeASYgI1dKWPi+0w06WVD
         Ci5YqC8uIu73dpRNWyhHF9kz0dIBk/zRSw9ID0/0=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20210118063355epcas1p4045124b3f0d3fa6cbb6dd32eba28bf11~bP-oUXg-R3004230042epcas1p4y;
        Mon, 18 Jan 2021 06:33:55 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.152]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4DK2745nl5z4x9Pt; Mon, 18 Jan
        2021 06:33:52 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        19.D3.02418.CCB25006; Mon, 18 Jan 2021 15:33:48 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20210118063348epcas1p1249bd98a42dea3105b36a83fac55f4b6~bP-h_Ik7A2903229032epcas1p1D;
        Mon, 18 Jan 2021 06:33:48 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210118063348epsmtrp2d45ca5837ad84021d8d23ed8309ae720~bP-h9agGZ2706427064epsmtrp2O;
        Mon, 18 Jan 2021 06:33:48 +0000 (GMT)
X-AuditID: b6c32a35-c23ff70000010972-73-60052bccf70f
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        25.CB.13470.CCB25006; Mon, 18 Jan 2021 15:33:48 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210118063347epsmtip189a4cd44993c357c18e45358f6ca495a~bP-hvHPL20191501915epsmtip1f;
        Mon, 18 Jan 2021 06:33:47 +0000 (GMT)
Subject: Re: [PATCH] PM / devfreq: Add sysfs attributes to simple_ondemand
 governor
To:     Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     myungjoo.ham@samsung.com, kyungmin.park@samsung.com
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <e09da2a0-f4cc-d93e-07a5-3551004fed83@samsung.com>
Date:   Mon, 18 Jan 2021 15:49:20 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20210115170530.22603-1-lukasz.luba@arm.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkk+LIzCtJLcpLzFFi42LZdlhTT/eMNmuCwZRPhhZnm96wW1zeNYfN
        4nPvEUaLhU0t7Ba3G1ewObB6rJm3htGjb8sqRo/Pm+QCmKOybTJSE1NSixRS85LzUzLz0m2V
        vIPjneNNzQwMdQ0tLcyVFPISc1NtlVx8AnTdMnOAVioplCXmlAKFAhKLi5X07WyK8ktLUhUy
        8otLbJVSC1JyCiwL9IoTc4tL89L1kvNzrQwNDIxMgQoTsjO2fFjCUnBYr2L/l8PMDYwbVbsY
        OTkkBEwkWu+sZO5i5OIQEtjBKDHn4VEmkISQwCdGifUnYiDsb4wSO9+FwTSsPfOdCaJhL6PE
        p4Y2doii94wSN8/WgtjCAqEShz51sYLYIgLxEgsPfQCrYRYwl/i79ywLiM0moCWx/8UNNhCb
        X0BR4uqPx4wgNq+AncSxXS+BLuLgYBFQlZjRXgISFhUIkzi5rQWqRFDi5MwnYGM4BSwl/j7/
        ywQxXlzi1pP5ULa8xPa3c8AekxD4yy4xY+s+JogHXCS+7b7NCmELS7w6voUdwpaS+PxuLxuE
        XS2x8uQRNojmDkaJLfsvQDUYS+xfOpkJ5DhmAU2J9bv0IcKKEjt/z2WEWMwn8e5rDytIiYQA
        r0RHmxBEibLE5Qd3oU6QlFjc3sk2gVFpFpJ3ZiF5YRaSF2YhLFvAyLKKUSy1oDg3PbXYsMAQ
        Oao3MYLTopbpDsaJbz/oHWJk4mA8xCjBwawkwlu6jilBiDclsbIqtSg/vqg0J7X4EKMpMHwn
        MkuJJucDE3NeSbyhqZGxsbGFiaGZqaGhkjhvksGDeCGB9MSS1OzU1ILUIpg+Jg5OqQamtKKl
        3vNnnNpu/W9Hz+8t2lqP5CcZ/zBl+DzDU+91/f9FxUeTdTPyPhzecnb25b18Kl8nnNklmnDr
        rmMFb+DO+3s7K2tjIn/6CZpM9l0vdoYtdtv+gj9hEwtUQ3o0/+Sp6RrsqWp8sj9xlWTO7ju8
        3icev57zOldT4MT+q4dOJOkriP1PCVPZL/xfJjiuv+rgttkVto7dbM4c6se6mMz/J/Jdvx61
        v7InY/e2FybGIQe6s6ziPSxr8rdPZvP8p9x2+L2bbZPB0ZzJd5sKRcNNN658zxdkxJfbP3HV
        nEc8l55qiU7kXjH7vphegV97VLoqv12rVI6IssRf+eR2j0rl5zY1jjeuR3huLZR8ZqjEUpyR
        aKjFXFScCABMr7L1FAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLLMWRmVeSWpSXmKPExsWy7bCSnO4ZbdYEg2832SzONr1ht7i8aw6b
        xefeI4wWC5ta2C1uN65gc2D1WDNvDaNH35ZVjB6fN8kFMEdx2aSk5mSWpRbp2yVwZWz5sISl
        4LBexf4vh5kbGDeqdjFyckgImEisPfOdqYuRi0NIYDejxMpvX1khEpIS0y4eZe5i5ACyhSUO
        Hy4GCQsJvGWU6NkiDWILC4RKHPrUBVYuIhAvMeHBdXYQm1nAXOLv3rMsEDN7GCXWtjQygiTY
        BLQk9r+4wQZi8wsoSlz98RgszitgJ3Fs10uwXSwCqhIz2ktAwqICYRI7lzxmgigRlDg58wkL
        iM0pYCnx9/lfJohd6hJ/5l1ihrDFJW49mQ8Vl5fY/nYO8wRG4VlI2mchaZmFpGUWkpYFjCyr
        GCVTC4pz03OLDQsM81LL9YoTc4tL89L1kvNzNzGCY0RLcwfj9lUf9A4xMnEwHmKU4GBWEuEt
        XceUIMSbklhZlVqUH19UmpNafIhRmoNFSZz3QtfJeCGB9MSS1OzU1ILUIpgsEwenVAPT2dJo
        1v63CZc/1p6KSQo0ne+grv63uHXvv3Tvi4oRe1udfGfZdIVMneV8I07pz71PEXH80/hqPs9/
        pLP90UM2h9gDf46FBC1miDs7N+1CRN/bSb9naf7Vf7hhvZHubMXG0+HPMpP2T+QsOjCjPsAr
        4Uz+h4QphZdez0/dWbrzeWNefsSHedUlJd79B5vNH2+Jv8h01+HnPMtA0fU7mC0qRGxDVnof
        dNdgzK4+qrzwxV3HxRvjmicbbWf858razJOY+X3HkqC//Us7r92JK1/I+6frqOCNvvK5hRKM
        Hht6XsvdFdcPymF+NG2zo83CpVdDdXgP31mdJXe+rrTfW+Pww7X6Gx6kH1mwb4rQV657SizF
        GYmGWsxFxYkATLyD2gADAAA=
X-CMS-MailID: 20210118063348epcas1p1249bd98a42dea3105b36a83fac55f4b6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210115170541epcas1p1b7bc36fb5a4f1b907da5771ca0c37891
References: <CGME20210115170541epcas1p1b7bc36fb5a4f1b907da5771ca0c37891@epcas1p1.samsung.com>
        <20210115170530.22603-1-lukasz.luba@arm.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Lukasz,

I has been developed[1] the sysfs attributes for upthreshold and downdifferential.
But, I has not yet posted it[1]. I'll post my approach with some changes.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git/commit/?h=devfreq-testing&id=e7c59dfb4afebe0c96de54516e9be23d76d96492

On 1/16/21 2:05 AM, Lukasz Luba wrote:
> The simple_ondemand devfreq governor is used by quite a few devices, like
> GPUs, DSPs, memory controllers, etc. It implements algorithm which tries
> to predict the device frequency based on past statistics. There are two
> tunables for the algorithm: 'upthreshold' and 'downdifferential'. These
> tunables change the behavior of the decision, e.g. how fast to increase
> the frequency or how rapidly limit the frequency. These values might be
> different based on the application which is currently running, e.g.
> different behavior is needed for a game than for web browsing or clean
> desktop. The patch exports these two tunables so they can be adjusted
> based on current need. There is also a check with the allowed ranges
> to make sure the values are correct and safe.
> 
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  drivers/devfreq/governor_simpleondemand.c | 135 ++++++++++++++++++++++
>  1 file changed, 135 insertions(+)
> 
> diff --git a/drivers/devfreq/governor_simpleondemand.c b/drivers/devfreq/governor_simpleondemand.c
> index d57b82a2b570..4b3c182e0a49 100644
> --- a/drivers/devfreq/governor_simpleondemand.c
> +++ b/drivers/devfreq/governor_simpleondemand.c
> @@ -15,6 +15,7 @@
>  /* Default constants for DevFreq-Simple-Ondemand (DFSO) */
>  #define DFSO_UPTHRESHOLD	(90)
>  #define DFSO_DOWNDIFFERENCTIAL	(5)
> +#define DFSO_MAX_VALUE		(100)
>  static int devfreq_simple_ondemand_func(struct devfreq *df,
>  					unsigned long *freq)
>  {
> @@ -84,15 +85,149 @@ static int devfreq_simple_ondemand_func(struct devfreq *df,
>  	return 0;
>  }
>  
> +static ssize_t upthreshold_show(struct device *dev,
> +				struct device_attribute *attr, char *buf)
> +{
> +	struct devfreq_simple_ondemand_data *data;
> +	struct devfreq *df = to_devfreq(dev);
> +
> +	if (!df->data)
> +		return -EINVAL;
> +
> +	data = df->data;
> +
> +	return sprintf(buf, "%d\n", data->upthreshold);
> +}
> +
> +static ssize_t upthreshold_store(struct device *dev,
> +				 struct device_attribute *attr,
> +				 const char *buf, size_t count)
> +{
> +	struct devfreq_simple_ondemand_data *data;
> +	struct devfreq *df = to_devfreq(dev);
> +	unsigned int value;
> +	int ret;
> +
> +	if (!df->data)
> +		return -EINVAL;
> +
> +	data = df->data;
> +
> +	ret = kstrtouint(buf, 10, &value);
> +	if (ret < 0)
> +		return -EINVAL;
> +
> +	mutex_lock(&df->lock);
> +
> +	if (value > DFSO_MAX_VALUE || value <= data->downdifferential) {
> +		mutex_unlock(&df->lock);
> +		return -EINVAL;
> +	}
> +
> +	data->upthreshold = value;
> +	mutex_unlock(&df->lock);
> +
> +	return count;
> +}
> +static DEVICE_ATTR_RW(upthreshold);
> +
> +static ssize_t downdifferential_show(struct device *dev,
> +				     struct device_attribute *attr, char *buf)
> +{
> +	struct devfreq_simple_ondemand_data *data;
> +	struct devfreq *df = to_devfreq(dev);
> +
> +	if (!df->data)
> +		return -EINVAL;
> +
> +	data = df->data;
> +
> +	return sprintf(buf, "%d\n", data->downdifferential);
> +}
> +
> +static ssize_t downdifferential_store(struct device *dev,
> +				      struct device_attribute *attr,
> +				      const char *buf, size_t count)
> +{
> +	struct devfreq_simple_ondemand_data *data;
> +	struct devfreq *df = to_devfreq(dev);
> +	unsigned int value;
> +	int ret;
> +
> +	if (!df->data)
> +		return -EINVAL;
> +
> +	data = df->data;
> +
> +	ret = kstrtouint(buf, 10, &value);
> +	if (ret < 0)
> +		return -EINVAL;
> +
> +	mutex_lock(&df->lock);
> +
> +	if (value > DFSO_MAX_VALUE || value >= data->upthreshold) {
> +		mutex_unlock(&df->lock);
> +		return -EINVAL;
> +	}
> +
> +	data->downdifferential = value;
> +	mutex_unlock(&df->lock);
> +
> +	return count;
> +}
> +static DEVICE_ATTR_RW(downdifferential);
> +
> +static void devfreq_simple_ondemand_sysfs_setup(struct devfreq *df)
> +{
> +	struct devfreq_simple_ondemand_data *data;
> +	int ret;
> +
> +	if (!df->data) {
> +		/* The memory will be freed automatically */
> +		df->data = devm_kzalloc(&df->dev,
> +				sizeof(struct devfreq_simple_ondemand_data),
> +				GFP_KERNEL);
> +		if (!df->data) {
> +			dev_warn(&df->dev, "Unable to allocate memory");
> +			return;
> +		}
> +	}
> +
> +	data = df->data;
> +
> +	/* After new allocation setup default values, since they are used */
> +	if (!data->upthreshold)
> +		data->upthreshold = DFSO_UPTHRESHOLD;
> +
> +	if (!data->downdifferential)
> +		data->downdifferential = DFSO_DOWNDIFFERENCTIAL;
> +
> +	ret = sysfs_create_file(&df->dev.kobj, &dev_attr_upthreshold.attr);
> +	if (ret < 0)
> +		dev_warn(&df->dev, "Unable to create 'upthreshold' attr\n");
> +
> +	ret = sysfs_create_file(&df->dev.kobj, &dev_attr_downdifferential.attr);
> +	if (ret < 0)
> +		dev_warn(&df->dev, "Unable to create 'downdifferential' attr\n");
> +}
> +
> +static void devfreq_simple_ondemand_sysfs_remove(struct devfreq *df)
> +{
> +	sysfs_remove_file(&df->dev.kobj, &dev_attr_upthreshold.attr);
> +	sysfs_remove_file(&df->dev.kobj, &dev_attr_downdifferential.attr);
> +}
> +
>  static int devfreq_simple_ondemand_handler(struct devfreq *devfreq,
>  				unsigned int event, void *data)
>  {
>  	switch (event) {
>  	case DEVFREQ_GOV_START:
>  		devfreq_monitor_start(devfreq);
> +		devfreq_simple_ondemand_sysfs_setup(devfreq);
>  		break;
>  
>  	case DEVFREQ_GOV_STOP:
> +		devfreq_simple_ondemand_sysfs_remove(devfreq);
>  		devfreq_monitor_stop(devfreq);
>  		break;
>  
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
