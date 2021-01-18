Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80E962FA749
	for <lists+linux-pm@lfdr.de>; Mon, 18 Jan 2021 18:19:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406934AbhARRSn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Jan 2021 12:18:43 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:36833 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2406908AbhARRS2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Jan 2021 12:18:28 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 04CAE5C00CF;
        Mon, 18 Jan 2021 12:17:19 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 18 Jan 2021 12:17:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=I7PuudX5NIkn1LEPg0h00j6g658
        gCi7iltCAsy0R/yA=; b=hJIZXbAriNodKHjDtQPLj8rq+1CoCTD1QIccwMcBAvF
        8HKmbnj4hy8uIMgmJiz1mg0pZ0+A2KdzxOEE1sk4ZhTtaRh/M8bntEVzYPXjgEYP
        ah+7x8id2SvcP9GDDlGqpbyG1trlgy0FkZixu5Fj0DvLyQxqHx3pFRLXepCiyW3F
        SuW7TuUSMl/NCdk2XTXw1BHfniu5MOrO125SWq/jawL6L56twcNnwq8Dl+AHeb0h
        kFZfjKcrtREkATLNFspCbjSLb86smuXk81mrwti6zOv4Zwu0OUF7GqPpElpV+XGt
        kAg0UWFvLLgmXwJOMF3R5uTtRGf5ARY3nKtNiM9Hh0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=I7Puud
        X5NIkn1LEPg0h00j6g658gCi7iltCAsy0R/yA=; b=TTjLIuuEvZrR23XX2mjt/M
        JJ3W6HkCpU0h+3FAIwpE0k6XoTxOCovXMjgWD92nMmljGcmuSbOtqP/aiWa1W+9q
        Cfoqs4eWZWhU0/PKxSclWMi3ywXyBueGPGoPfqWfcRrihf+CeU5qa/ymcrAwuc6S
        lNIealO8aqT9TYA/wT0VDcFrO/uAjxpt62+gVPtk/DlRyzAA6zsNXKai+bL+UT6N
        E3dBmRXuTUSO3z4vKmFaqpdVnFSsiU0BJP/skdqBDXXjzI80C5Q1Iz5dPyI3eAm/
        3Iif6Tq2G7Fap8oS2oiG7c3YhRGnWSHBG8ASFzB+EowApeTxoQf3+p5+3qnkqX+g
        ==
X-ME-Sender: <xms:nsIFYKLypyqkBiJr7aOdv5U3LXO-QrfBIrt8hZwt_-f4zH7Qr-HHdg>
    <xme:nsIFYCL3zX6LlMSXw7rYRodAK7_xP9w1oCKBY7PVa4yILNAKO2jPM-oY0ttjmm16h
    xBroJjgPMl5ig>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrtdekgddutddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeevueehje
    fgfffgiedvudekvdektdelleelgefhleejieeugeegveeuuddukedvteenucfkphepkeef
    rdekiedrjeegrdeigeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:nsIFYKsdc1BF0ke5ibyy_GvVOGXnNBkGsU-26K1rmb_aktGcQcSzdw>
    <xmx:nsIFYPavMpYBh8ANL2RrissKzGIyIMVCekLcTUIHOgu4GAmYyRYDxg>
    <xmx:nsIFYBa0t0TYVqbZ4UDzMVWimAwJbNH-Zy7VRV62eZu7lA92bLUwFA>
    <xmx:nsIFYFF5DBSkwxD9BkcW4yo4sktWefnJ-KYXqsP1Pkq9y6bonE9loQ>
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        by mail.messagingengine.com (Postfix) with ESMTPA id 4525B1080057;
        Mon, 18 Jan 2021 12:17:17 -0500 (EST)
Date:   Mon, 18 Jan 2021 18:17:16 +0100
From:   Greg KH <greg@kroah.com>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        cw00.choi@samsung.com, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com
Subject: Re: [PATCH] PM / devfreq: Add sysfs attributes to simple_ondemand
 governor
Message-ID: <YAXCnMsUy3n+asfm@kroah.com>
References: <20210115170530.22603-1-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210115170530.22603-1-lukasz.luba@arm.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jan 15, 2021 at 05:05:30PM +0000, Lukasz Luba wrote:
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

sysfs_emit()?

Also, you forgot the Documentation/ABI/ updates for new sysfs files :(


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

You just raced with userspace and lost :(

Please use the default sysfs groups so that it all works properly.

Huge hint, when calling sysfs_* from a driver, that usually means you
are doing something wrong.

thanks,

greg k-h
