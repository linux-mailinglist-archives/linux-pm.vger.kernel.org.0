Return-Path: <linux-pm+bounces-37750-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 34CB4C47E5A
	for <lists+linux-pm@lfdr.de>; Mon, 10 Nov 2025 17:21:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8B3FD4F1B1A
	for <lists+linux-pm@lfdr.de>; Mon, 10 Nov 2025 16:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E91279918;
	Mon, 10 Nov 2025 16:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nI2bQjqY"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B1926FA77;
	Mon, 10 Nov 2025 16:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762791087; cv=none; b=GFhTQlUaD7KSi2C53CVDHZ72RuXXH/T+yBJ9m+1JMOhDELl71K6Hm9qgQoiplUq9YHbhEpE2DuegpfyjFTAU+Nkq7yhGeK4RWR2N+SQhFAcDyKaPUi00l0Xb7LbyEJ0vftY31y+mmQZ8jQCN53+JOeUJJsLZVAdnJoBAZ7I/Ffk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762791087; c=relaxed/simple;
	bh=KmpOICxoGbog03HrT+73C14r5/ttDHWLADzMXpIzHEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ei00LEE8I5NIHknR8fKsC9zE74Du6y7AEuJple1ub9Ij3VwZ6WwXLnzbMcX/ZJLDGgoakVBTA6ECTvW+yfguTYFbPRJjjNi7oyFShoOWc0Lc8+tMocgEU900A4iKi15lZrMm5PP4ElLLrETF7cYBqLe3Bj68vUfOsdmq86voYBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nI2bQjqY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0C8AC113D0;
	Mon, 10 Nov 2025 16:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762791087;
	bh=KmpOICxoGbog03HrT+73C14r5/ttDHWLADzMXpIzHEI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nI2bQjqYTL36NWtatW8+wvLmtWv8gRbVpOP0oQOrTDXss61hhWO/148mMGpx1u3Po
	 O0jIy3mEqPFqgXEz7e+w+qRmcUL6vFzgjke+FLKv7HGEPKVLUIazZbou2/8Rf4WIqw
	 BicYEJ+Aa6LO06fejAkSRt3B2DsZAhyXdIRtK5YkRrdxGPL9cRoq291ROyqJU4wsYv
	 9BCDaxN15BkuRoG2AmJPEPd7wB7uPx+S7+fMLe9THw7dvWuhafHytwxYQ2nYd9fv0n
	 31UJ1gVjfbzVu37QJc+cxQkT5hiOmUhJIrF0Xba2EedDNsaVe1tB/cgIkyRxiZMF2P
	 VF7e62Eqljnig==
Date: Mon, 10 Nov 2025 10:15:32 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
	Sudeep Holla <sudeep.holla@arm.com>, Souvik Chakravarty <Souvik.Chakravarty@arm.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Andy Yan <andy.yan@rock-chips.com>, Mark Rutland <mark.rutland@arm.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Konrad Dybcio <konradybcio@kernel.org>, cros-qcom-dts-watchers@chromium.org, 
	Vinod Koul <vkoul@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Moritz Fischer <moritz.fischer@ettus.com>, John Stultz <john.stultz@linaro.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>, 
	Stephen Boyd <swboyd@chromium.org>, Andre Draszik <andre.draszik@linaro.org>, 
	Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, Elliot Berman <quic_eberman@quicinc.com>, 
	Xin Liu <xin.liu@oss.qualcomm.com>, Srinivas Kandagatla <srini@kernel.org>
Subject: Re: [PATCH v17 05/12] power: reset: reboot-mode: Expose sysfs for
 registered reboot_modes
Message-ID: <qhlxxfsyc42xemerhi36myvil3bf45isgmpugkuqzsvgcc3ifn@njrtwuooij2q>
References: <20251109-arm-psci-system_reset2-vendor-reboots-v17-0-46e085bca4cc@oss.qualcomm.com>
 <20251109-arm-psci-system_reset2-vendor-reboots-v17-5-46e085bca4cc@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251109-arm-psci-system_reset2-vendor-reboots-v17-5-46e085bca4cc@oss.qualcomm.com>

On Sun, Nov 09, 2025 at 08:07:18PM +0530, Shivendra Pratap wrote:
> Currently, there is no standardized mechanism for userspace to
> discover which reboot-modes are supported on a given platform.
> This limitation forces tools and scripts to rely on hardcoded
> assumptions about the supported reboot-modes.
> 
> Create a class 'reboot-mode' and a device under it to expose a
> sysfs interface to show the available reboot mode arguments to
> userspace. Use the driver_name field of the struct
> reboot_mode_driver to create the device. For device-based
> drivers, configure the device driver name as driver_name.
> 
> This results in the creation of:
>   /sys/class/reboot-mode/<driver>/reboot_modes
> 
> This read-only sysfs file will exposes the list of supported
> reboot modes arguments provided by the driver, enabling userspace
> to query the list of arguments.
> 

I like this addition, and your commit message reasoning about this
addition. But, while touching upon the same subject, you've made this
series add two separate things.

So now this part can't be merged unless there's agreement on the PSCI
SYSTEM_RESET2, and the PSCI SYSTEM_RESET2 can't be merged unless this
sysfs interface is agreed upon.

Unless I'm missing some clear dependency here, it would have been better
to keep these two topics in separate series, and drive them to
conclusion independently.

> Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
> ---
>  drivers/power/reset/reboot-mode.c | 62 ++++++++++++++++++++++++++++++++++++++-
>  include/linux/reboot-mode.h       |  2 ++
>  2 files changed, 63 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/power/reset/reboot-mode.c b/drivers/power/reset/reboot-mode.c
> index 873ac45cd7659b214b7c21958f580ca381e0a63d..582aa7f8ed7fa485c5a67877558c9b15d3600ef4 100644
> --- a/drivers/power/reset/reboot-mode.c
> +++ b/drivers/power/reset/reboot-mode.c
> @@ -6,6 +6,7 @@
>  #define pr_fmt(fmt)	"reboot-mode: " fmt
>  
>  #include <linux/device.h>
> +#include <linux/err.h>
>  #include <linux/init.h>
>  #include <linux/kernel.h>
>  #include <linux/list.h>
> @@ -23,6 +24,8 @@ struct mode_info {
>  	struct list_head list;
>  };
>  
> +static struct class *rb_class;

Why not "static const struct class reboot_mode_class" and then a
class_register() call? Why do you need the class dynamically allocated
on the heap?

> +
>  static u64 get_reboot_mode_magic(struct reboot_mode_driver *reboot, const char *cmd)
>  {
>  	const char *normal = "normal";
> @@ -65,6 +68,51 @@ static int reboot_mode_notify(struct notifier_block *this,
>  	return NOTIFY_DONE;
>  }
>  
> +static ssize_t reboot_modes_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	struct reboot_mode_driver *reboot;
> +	struct mode_info *info;
> +	ssize_t size = 0;
> +
> +	reboot = (struct reboot_mode_driver *)dev_get_drvdata(dev);
> +	if (!reboot)
> +		return -ENODATA;
> +
> +	list_for_each_entry(info, &reboot->head, list)
> +		size += sysfs_emit_at(buf, size, "%s ", info->mode);
> +
> +	if (size) {
> +		size += sysfs_emit_at(buf, size - 1, "\n");
> +		return size;
> +	}
> +
> +	return -ENODATA;
> +}
> +static DEVICE_ATTR_RO(reboot_modes);
> +
> +static int create_reboot_mode_device(struct reboot_mode_driver *reboot)

Note how (almost) all other function names in this file start with
a "reboot_mode_" prefix.

> +{
> +	int ret = 0;

First use is an assignment, no need for you to zero-initialize it here.

> +
> +	if (!rb_class) {
> +		rb_class = class_create("reboot-mode");
> +		if (IS_ERR(rb_class))
> +			return PTR_ERR(rb_class);
> +	}
> +
> +	reboot->reboot_dev = device_create(rb_class, NULL, 0, (void *)reboot, reboot->driver_name);

Every struct reboot_mode_driver is going to end up having one of these,
so why not incorporate it into the reboot_mode_driver in the first
place. It avoids the extra heap allocation, and you can use
container_of() instead of drv_data to find your reboot_mode_driver in
the reboot_modes_show() above.


Just:
  reboot->reboot_dev.class = &reboot_mode_class;
  dev_set_name(&reboot->reboot_dev, reboot->driver_name);
  ret = device_register(&reboot->reboot_dev);

> +	if (IS_ERR(reboot->reboot_dev))
> +		return PTR_ERR(reboot->reboot_dev);
> +
> +	ret = device_create_file(reboot->reboot_dev, &dev_attr_reboot_modes);

Manually creating sysfs attributes is both error prone and racy, so if
you can you should avoid it.

Here you have the opportunity to just statically assign
reboot_mode_class->dev_groups to an ATTRIBUTE_GROUP() with your
attribute and it will all be handled for you.

> +	if (ret) {
> +		device_unregister(reboot->reboot_dev);
> +		return ret;
> +	}
> +
> +	return ret;
> +}
> +
>  /**
>   * reboot_mode_register - register a reboot mode driver
>   * @reboot: reboot mode driver
> @@ -83,13 +131,17 @@ int reboot_mode_register(struct reboot_mode_driver *reboot, struct fwnode_handle
>  	u32 magic_arg2;
>  	int ret;
>  
> -	if (!fwnode)
> +	if (!fwnode || !reboot->driver_name)
>  		return -EINVAL;
>  
>  	np = to_of_node(fwnode);
>  	if (!np)
>  		return -EINVAL;
>  
> +	ret = create_reboot_mode_device(reboot);
> +	if (ret)
> +		return ret;
> +
>  	INIT_LIST_HEAD(&reboot->head);
>  
>  	for_each_property_of_node(np, prop) {
> @@ -142,6 +194,8 @@ int reboot_mode_register(struct reboot_mode_driver *reboot, struct fwnode_handle
>  		kfree(info);
>  	}
>  
> +	device_remove_file(reboot->reboot_dev, &dev_attr_reboot_modes);
> +	device_unregister(reboot->reboot_dev);
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(reboot_mode_register);
> @@ -155,6 +209,9 @@ int reboot_mode_unregister(struct reboot_mode_driver *reboot)
>  	struct mode_info *info;
>  	struct mode_info *next;
>  
> +	if (!reboot->reboot_dev)
> +		return -EINVAL;
> +
>  	unregister_reboot_notifier(&reboot->reboot_notifier);
>  
>  	list_for_each_entry_safe(info, next, &reboot->head, list) {
> @@ -163,6 +220,8 @@ int reboot_mode_unregister(struct reboot_mode_driver *reboot)
>  		kfree(info);
>  	}
>  
> +	device_remove_file(reboot->reboot_dev, &dev_attr_reboot_modes);
> +	device_unregister(reboot->reboot_dev);
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(reboot_mode_unregister);
> @@ -192,6 +251,7 @@ int devm_reboot_mode_register(struct device *dev,
>  	if (!dr)
>  		return -ENOMEM;
>  
> +	reboot->driver_name = reboot->dev->driver->name;

It seems unlikely that we will have multiple instances of the same
driver influencing the actual reboot mode, but we could very well have
multiple instances of the same driver calling
devm_reboot_mode_register(). E.g. on a board two PMICs, both with PON
blocks (but only one considered as the source for boot mode).

In that case you will end up trying to create multiple devices with the
name "qcom-pon", presumably that will fail and per your error handling
you have now disabled the reboot-mechanism for all but the first pon
instance that was registered.

It also creates some asymmetry between devm_reboot_mode_register() and
reboot_mode_register(), in that the one API the client driver decides
the name, in other it's hard coded to the driver name (and if the client
did specify a name - which they should if they use the non-devm one- it
will be overwritten).



On that note, I would argue that aborting the registration of
reboot-modes, just because we failed to create the convenient "debug"
interface, doesn't make sense. I think it would be better to just
continue even when create_reboot_mode_device() returns an error.

>  	rc = reboot_mode_register(reboot, of_fwnode_handle(reboot->dev->of_node));
>  	if (rc) {
>  		devres_free(dr);
> diff --git a/include/linux/reboot-mode.h b/include/linux/reboot-mode.h
> index e0d3e8a54050a76f26846f456120b4c7e371d284..81c149edf40fbcf0d3427c2e12eb415199cb153b 100644
> --- a/include/linux/reboot-mode.h
> +++ b/include/linux/reboot-mode.h
> @@ -7,6 +7,8 @@
>  
>  struct reboot_mode_driver {
>  	struct device *dev;
> +	struct device *reboot_dev;

As suggested above:

struct device reboot_dev;

Regards,
Bjorn

> +	const char *driver_name;
>  	struct list_head head;
>  	int (*write)(struct reboot_mode_driver *reboot, u64 magic);
>  	struct notifier_block reboot_notifier;
> 
> -- 
> 2.34.1
> 

