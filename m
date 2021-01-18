Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 465A62FA883
	for <lists+linux-pm@lfdr.de>; Mon, 18 Jan 2021 19:17:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406563AbhARSQC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Jan 2021 13:16:02 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:49819 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2407455AbhARSPm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Jan 2021 13:15:42 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 5ED9C5C019E;
        Mon, 18 Jan 2021 13:14:34 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 18 Jan 2021 13:14:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=cIp0hypZuyD95Ek3a+fBXpD1r5Z
        WafZF1r/4Hh8s7qM=; b=e9l8/MixLc6AmcSVCIu3ArZg3QDUrmkdhov1mfhhnxK
        fsJXuh++gzBbLYTMbYkN+dDMRyUzKHUhqddYmLkqfqqdFvtay74N2JiRn76tdGGo
        jc1NLEM0gIbwNGL0ShMfD2WDFXO0HqDutD83Wjs2AjpwT0nj/EeNNMIw/LE6pRkl
        S0Yia93YsL833zlV3sB+fueQYXh9zF6ofTsjXWLweIQ89qGpD/V9Tc6Qyq7VxhG4
        FLQqaes+ya58eQLx6RZ6JifIr3hRXYtzj/veQAfarOSxoCzJz9k1HHSHBwvM5NS9
        lc2A7phiNX5QmtTBdN+Rzu+2EShxfIDT8rGB7AkaTLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=cIp0hy
        pZuyD95Ek3a+fBXpD1r5ZWafZF1r/4Hh8s7qM=; b=EP7Zh7j1Ezz2zBkjTKDH3R
        AFwZ/2dXwn3TLXaLjc/jJKxDPLl+xZiQGr5fabqNmxRdFM0tfHIa3nSgg5blQMm1
        KhEXlbGwKu24XK1jfVwbMR5Vd7mHuvG4RM1oxcnlBv9M2AA4PUaaUhfaFC8OsL+w
        E+Uq0G0M9CQOFilZz9jZW6i8S7UNMTwHUr8OQ/NJRc5zdLYCLGN33CeDla+3I5VJ
        oZGK403zsvk6PdhCVN2s33YuHLq8cA8MQUPZSMTxKOImbpB9fT5hVj1Fkj0pPwYG
        hjz6mqcYjBp8Se/+jqJuK8oWQLkHiPFZTiekXarnK5GSr2izZoEkOzH5XJwNaD6g
        ==
X-ME-Sender: <xms:CdAFYIJIst0cAXhjulwH-zC0i7OCJN20oUHcBZYxXkUYLqeRhjZlUA>
    <xme:CdAFYILH223sCSNMNvRkYVk26TAqCHAAkE_eoKVKTzC7XLdZsOu0AajnDxs2bkUtx
    Fql7BjRUyodzg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrtdekgdduudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeevueehje
    fgfffgiedvudekvdektdelleelgefhleejieeugeegveeuuddukedvteenucfkphepkeef
    rdekiedrjeegrdeigeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:CdAFYIsWC9u0a9__B-pddrTbFbhDUgjHaEQqczD3TqgheN5xPhHzew>
    <xmx:CdAFYFbnANE2KBp5s00WAEiuUWYrEa-0Z16b221iXZ2YB6KRxlusIg>
    <xmx:CdAFYPaHxeAP0aaJSug6SbmI0tgCIZJXPJC1vU4n_D12YvfZm60btQ>
    <xmx:CtAFYLFb_6P9bLD6LCb8d7qaK7SYVbuXi2FQWIP7oIp_10PRTdD_DA>
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        by mail.messagingengine.com (Postfix) with ESMTPA id 95C99240068;
        Mon, 18 Jan 2021 13:14:33 -0500 (EST)
Date:   Mon, 18 Jan 2021 19:14:32 +0100
From:   Greg KH <greg@kroah.com>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        cw00.choi@samsung.com, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com
Subject: Re: [PATCH] PM / devfreq: Add sysfs attributes to simple_ondemand
 governor
Message-ID: <YAXQCK7dmHrSq29b@kroah.com>
References: <20210115170530.22603-1-lukasz.luba@arm.com>
 <YAXCnMsUy3n+asfm@kroah.com>
 <43729797-2d3c-be12-ce72-bfe5bca54fa0@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43729797-2d3c-be12-ce72-bfe5bca54fa0@arm.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jan 18, 2021 at 05:56:06PM +0000, Lukasz Luba wrote:
> 
> 
> On 1/18/21 5:17 PM, Greg KH wrote:
> > On Fri, Jan 15, 2021 at 05:05:30PM +0000, Lukasz Luba wrote:
> > > The simple_ondemand devfreq governor is used by quite a few devices, like
> > > GPUs, DSPs, memory controllers, etc. It implements algorithm which tries
> > > to predict the device frequency based on past statistics. There are two
> > > tunables for the algorithm: 'upthreshold' and 'downdifferential'. These
> > > tunables change the behavior of the decision, e.g. how fast to increase
> > > the frequency or how rapidly limit the frequency. These values might be
> > > different based on the application which is currently running, e.g.
> > > different behavior is needed for a game than for web browsing or clean
> > > desktop. The patch exports these two tunables so they can be adjusted
> > > based on current need. There is also a check with the allowed ranges
> > > to make sure the values are correct and safe.
> > > 
> > > Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> > > ---
> > >   drivers/devfreq/governor_simpleondemand.c | 135 ++++++++++++++++++++++
> > >   1 file changed, 135 insertions(+)
> > > 
> > > diff --git a/drivers/devfreq/governor_simpleondemand.c b/drivers/devfreq/governor_simpleondemand.c
> > > index d57b82a2b570..4b3c182e0a49 100644
> > > --- a/drivers/devfreq/governor_simpleondemand.c
> > > +++ b/drivers/devfreq/governor_simpleondemand.c
> > > @@ -15,6 +15,7 @@
> > >   /* Default constants for DevFreq-Simple-Ondemand (DFSO) */
> > >   #define DFSO_UPTHRESHOLD	(90)
> > >   #define DFSO_DOWNDIFFERENCTIAL	(5)
> > > +#define DFSO_MAX_VALUE		(100)
> > >   static int devfreq_simple_ondemand_func(struct devfreq *df,
> > >   					unsigned long *freq)
> > >   {
> > > @@ -84,15 +85,149 @@ static int devfreq_simple_ondemand_func(struct devfreq *df,
> > >   	return 0;
> > >   }
> > > +static ssize_t upthreshold_show(struct device *dev,
> > > +				struct device_attribute *attr, char *buf)
> > > +{
> > > +	struct devfreq_simple_ondemand_data *data;
> > > +	struct devfreq *df = to_devfreq(dev);
> > > +
> > > +	if (!df->data)
> > > +		return -EINVAL;
> > > +
> > > +	data = df->data;
> > > +
> > > +	return sprintf(buf, "%d\n", data->upthreshold);
> > 
> > sysfs_emit()?
> > 
> > Also, you forgot the Documentation/ABI/ updates for new sysfs files :(
> 
> True, I will remember next time.
> 
> > 
> > 
> > > +}
> > > +
> > > +static ssize_t upthreshold_store(struct device *dev,
> > > +				 struct device_attribute *attr,
> > > +				 const char *buf, size_t count)
> > > +{
> > > +	struct devfreq_simple_ondemand_data *data;
> > > +	struct devfreq *df = to_devfreq(dev);
> > > +	unsigned int value;
> > > +	int ret;
> > > +
> > > +	if (!df->data)
> > > +		return -EINVAL;
> > > +
> > > +	data = df->data;
> > > +
> > > +	ret = kstrtouint(buf, 10, &value);
> > > +	if (ret < 0)
> > > +		return -EINVAL;
> > > +
> > > +	mutex_lock(&df->lock);
> > > +
> > > +	if (value > DFSO_MAX_VALUE || value <= data->downdifferential) {
> > > +		mutex_unlock(&df->lock);
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	data->upthreshold = value;
> > > +	mutex_unlock(&df->lock);
> > > +
> > > +	return count;
> > > +}
> > > +static DEVICE_ATTR_RW(upthreshold);
> > > +
> > > +static ssize_t downdifferential_show(struct device *dev,
> > > +				     struct device_attribute *attr, char *buf)
> > > +{
> > > +	struct devfreq_simple_ondemand_data *data;
> > > +	struct devfreq *df = to_devfreq(dev);
> > > +
> > > +	if (!df->data)
> > > +		return -EINVAL;
> > > +
> > > +	data = df->data;
> > > +
> > > +	return sprintf(buf, "%d\n", data->downdifferential);
> > > +}
> > > +
> > > +static ssize_t downdifferential_store(struct device *dev,
> > > +				      struct device_attribute *attr,
> > > +				      const char *buf, size_t count)
> > > +{
> > > +	struct devfreq_simple_ondemand_data *data;
> > > +	struct devfreq *df = to_devfreq(dev);
> > > +	unsigned int value;
> > > +	int ret;
> > > +
> > > +	if (!df->data)
> > > +		return -EINVAL;
> > > +
> > > +	data = df->data;
> > > +
> > > +	ret = kstrtouint(buf, 10, &value);
> > > +	if (ret < 0)
> > > +		return -EINVAL;
> > > +
> > > +	mutex_lock(&df->lock);
> > > +
> > > +	if (value > DFSO_MAX_VALUE || value >= data->upthreshold) {
> > > +		mutex_unlock(&df->lock);
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	data->downdifferential = value;
> > > +	mutex_unlock(&df->lock);
> > > +
> > > +	return count;
> > > +}
> > > +static DEVICE_ATTR_RW(downdifferential);
> > > +
> > > +static void devfreq_simple_ondemand_sysfs_setup(struct devfreq *df)
> > > +{
> > > +	struct devfreq_simple_ondemand_data *data;
> > > +	int ret;
> > > +
> > > +	if (!df->data) {
> > > +		/* The memory will be freed automatically */
> > > +		df->data = devm_kzalloc(&df->dev,
> > > +				sizeof(struct devfreq_simple_ondemand_data),
> > > +				GFP_KERNEL);
> > > +		if (!df->data) {
> > > +			dev_warn(&df->dev, "Unable to allocate memory");
> > > +			return;
> > > +		}
> > > +	}
> > > +
> > > +	data = df->data;
> > > +
> > > +	/* After new allocation setup default values, since they are used */
> > > +	if (!data->upthreshold)
> > > +		data->upthreshold = DFSO_UPTHRESHOLD;
> > > +
> > > +	if (!data->downdifferential)
> > > +		data->downdifferential = DFSO_DOWNDIFFERENCTIAL;
> > > +
> > > +	ret = sysfs_create_file(&df->dev.kobj, &dev_attr_upthreshold.attr);
> > > +	if (ret < 0)
> > > +		dev_warn(&df->dev, "Unable to create 'upthreshold' attr\n");
> > > +
> > > +	ret = sysfs_create_file(&df->dev.kobj, &dev_attr_downdifferential.attr);
> > > +	if (ret < 0)
> > > +		dev_warn(&df->dev, "Unable to create 'downdifferential' attr\n");
> > 
> > You just raced with userspace and lost :(
> > 
> > Please use the default sysfs groups so that it all works properly.
> > 
> > Huge hint, when calling sysfs_* from a driver, that usually means you
> > are doing something wrong.
> 
> I should have used kobject_init_and_add() and the default devfreq
> sysfs group as a parent.

No, never use "raw" kobjects in the sys/devices/ tree, that is a sure
way to ensure that userspace will never be notified or see your
attributes.

thanks,

greg k-h
