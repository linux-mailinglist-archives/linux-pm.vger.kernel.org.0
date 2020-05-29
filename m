Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 768431E75BF
	for <lists+linux-pm@lfdr.de>; Fri, 29 May 2020 08:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725959AbgE2GCI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 29 May 2020 02:02:08 -0400
Received: from mga06.intel.com ([134.134.136.31]:49573 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725562AbgE2GCH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 29 May 2020 02:02:07 -0400
IronPort-SDR: xYIC046JdiyNZxMiJoCvril7C1pAdJ+C4B9GXyqD1H3w8p/Y4sqj3e6RTEHsq6vV7EwV6/7XDl
 gp038syOPWWg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2020 23:02:07 -0700
IronPort-SDR: 0UJwj7a7wT/VqnN+yimcj1Qsbmsjv20XByvlxEFiKso7kYVrAe1DRSCdb9BevFS/rq75UU7aqY
 VUq3T7mjEc+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,447,1583222400"; 
   d="scan'208";a="346165792"
Received: from zhouchao-mobl1.ccr.corp.intel.com ([10.255.31.99])
  by orsmga001.jf.intel.com with ESMTP; 28 May 2020 23:02:05 -0700
Message-ID: <e9232e0b18ecdd3c09401a4dac8b7c1fa513276a.camel@intel.com>
Subject: Re: [PATCH V2 1/3] thermal/int340x_thermal: Export GDDV
From:   Zhang Rui <rui.zhang@intel.com>
To:     "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>,
        "matthewgarrett@google.com" <matthewgarrett@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "Aram, Nisha" <nisha.aram@intel.com>,
        "mjg59@google.com" <mjg59@google.com>
Date:   Fri, 29 May 2020 14:02:04 +0800
In-Reply-To: <fe5119b46d975e4699ced2d9ed12a25f8ae5d1cd.camel@intel.com>
References: <20200414020953.255364-1-matthewgarrett@google.com>
         <4c00e15c8d5e34a723896f132989edd581c6995e.camel@intel.com>
         <fe5119b46d975e4699ced2d9ed12a25f8ae5d1cd.camel@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 2020-05-29 at 00:00 -0600, Pandruvada, Srinivas wrote:
> On Mon, 2020-05-18 at 23:18 +0000, Pandruvada, Srinivas wrote:
> > On Mon, 2020-04-13 at 19:09 -0700, Matthew Garrett wrote:
> > > From: Matthew Garrett <mjg59@google.com>
> > > 
> > > Implementing DPTF properly requires making use of firmware-
> > > provided
> > > information associated with the INT3400 device. Calling GDDV
> > > provides
> > > a
> > > buffer of information which userland can then interpret to
> > > determine
> > > appropriate DPTF policy.
> > > 
> > > Signed-off-by: Matthew Garrett <mjg59@google.com>
> > 
> > Tested-by: Pandruvada, Srinivas <
> > srinivas.pandruvada@linux.intel.com>
> 
> Can we take this series for 5.8?

They are in testing branch and has just passed the build test, will
queue them for 5.8.

thanks,
rui
> 
> Thanks,
> Srinivas
> 
> > 
> > > ---
> > >  .../intel/int340x_thermal/int3400_thermal.c   | 60
> > > +++++++++++++++++++
> > >  1 file changed, 60 insertions(+)
> > > 
> > > diff --git
> > > a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> > > b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> > > index ceef89c956bd4..00a7732724cd0 100644
> > > --- a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> > > +++ b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> > > @@ -52,6 +52,25 @@ struct int3400_thermal_priv {
> > >  	u8 uuid_bitmap;
> > >  	int rel_misc_dev_res;
> > >  	int current_uuid_index;
> > > +	char *data_vault;
> > > +};
> > > +
> > > +static ssize_t data_vault_read(struct file *file, struct kobject
> > > *kobj,
> > > +	     struct bin_attribute *attr, char *buf, loff_t off, size_t
> > > count)
> > > +{
> > > +	memcpy(buf, attr->private + off, count);
> > > +	return count;
> > > +}
> > > +
> > > +static BIN_ATTR_RO(data_vault, 0);
> > > +
> > > +static struct bin_attribute *data_attributes[] = {
> > > +	&bin_attr_data_vault,
> > > +	NULL,
> > > +};
> > > +
> > > +static const struct attribute_group data_attribute_group = {
> > > +	.bin_attrs = data_attributes,
> > >  };
> > >  
> > >  static ssize_t available_uuids_show(struct device *dev,
> > > @@ -278,6 +297,32 @@ static struct thermal_zone_params
> > > int3400_thermal_params = {
> > >  	.no_hwmon = true,
> > >  };
> > >  
> > > +static void int3400_setup_gddv(struct int3400_thermal_priv
> > > *priv)
> > > +{
> > > +	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
> > > +	union acpi_object *obj;
> > > +	acpi_status status;
> > > +
> > > +	status = acpi_evaluate_object(priv->adev->handle, "GDDV", NULL,
> > > +				      &buffer);
> > > +	if (ACPI_FAILURE(status) || !buffer.length)
> > > +		return;
> > > +
> > > +	obj = buffer.pointer;
> > > +	if (obj->type != ACPI_TYPE_PACKAGE || obj->package.count != 1
> > > +	    || obj->package.elements[0].type != ACPI_TYPE_BUFFER) {
> > > +		kfree(buffer.pointer);
> > > +		return;
> > > +	}
> > > +
> > > +	priv->data_vault = kmemdup(obj-
> > > > package.elements[0].buffer.pointer,
> > > 
> > > +				   obj-
> > > > package.elements[0].buffer.length,
> > > 
> > > +				   GFP_KERNEL);
> > > +	bin_attr_data_vault.private = priv->data_vault;
> > > +	bin_attr_data_vault.size = obj-
> > > > package.elements[0].buffer.length;
> > > 
> > > +	kfree(buffer.pointer);
> > > +}
> > > +
> > >  static int int3400_thermal_probe(struct platform_device *pdev)
> > >  {
> > >  	struct acpi_device *adev = ACPI_COMPANION(&pdev->dev);
> > > @@ -309,6 +354,8 @@ static int int3400_thermal_probe(struct
> > > platform_device *pdev)
> > >  
> > >  	platform_set_drvdata(pdev, priv);
> > >  
> > > +	int3400_setup_gddv(priv);
> > > +
> > >  	int3400_thermal_ops.get_mode = int3400_thermal_get_mode;
> > >  	int3400_thermal_ops.set_mode = int3400_thermal_set_mode;
> > >  
> > > @@ -327,6 +374,13 @@ static int int3400_thermal_probe(struct
> > > platform_device *pdev)
> > >  	if (result)
> > >  		goto free_rel_misc;
> > >  
> > > +	if (priv->data_vault) {
> > > +		result = sysfs_create_group(&pdev->dev.kobj,
> > > +					    &data_attribute_group);
> > > +		if (result)
> > > +			goto free_uuid;
> > > +	}
> > > +
> > >  	result = acpi_install_notify_handler(
> > >  			priv->adev->handle, ACPI_DEVICE_NOTIFY,
> > > int3400_notify,
> > >  			(void *)priv);
> > > @@ -336,6 +390,9 @@ static int int3400_thermal_probe(struct
> > > platform_device *pdev)
> > >  	return 0;
> > >  
> > >  free_sysfs:
> > > +	if (priv->data_vault)
> > > +		sysfs_remove_group(&pdev->dev.kobj,
> > > &data_attribute_group);
> > > +free_uuid:
> > >  	sysfs_remove_group(&pdev->dev.kobj, &uuid_attribute_group);
> > >  free_rel_misc:
> > >  	if (!priv->rel_misc_dev_res)
> > > @@ -360,8 +417,11 @@ static int int3400_thermal_remove(struct
> > > platform_device *pdev)
> > >  	if (!priv->rel_misc_dev_res)
> > >  		acpi_thermal_rel_misc_device_remove(priv->adev-
> > > > handle);
> > > 
> > >  
> > > +	if (priv->data_vault)
> > > +		sysfs_remove_group(&pdev->dev.kobj,
> > > &data_attribute_group);
> > >  	sysfs_remove_group(&pdev->dev.kobj, &uuid_attribute_group);
> > >  	thermal_zone_device_unregister(priv->thermal);
> > > +	kfree(priv->data_vault);
> > >  	kfree(priv->trts);
> > >  	kfree(priv->arts);
> > >  	kfree(priv);

