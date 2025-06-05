Return-Path: <linux-pm+bounces-28162-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58E3EACF546
	for <lists+linux-pm@lfdr.de>; Thu,  5 Jun 2025 19:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A84151882C7D
	for <lists+linux-pm@lfdr.de>; Thu,  5 Jun 2025 17:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E49713D521;
	Thu,  5 Jun 2025 17:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jF25dsnV"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4E91DFF8;
	Thu,  5 Jun 2025 17:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749144047; cv=none; b=QdZoZIqfh6iLPj5h5+mJA+Ii2jARQotxq0k20Te/R40rQPfavwFUZ4oHk1sXVDo5YdGaFw/+ukgNE6hP/HYOlM/yX3//x9mFaL8ZqBiPbwRSPi6ThqFUh9E520uvjG67ktMbF5fHhQJEqY/uI+WhGARwNWlue34hyBfW03/UvVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749144047; c=relaxed/simple;
	bh=XwGdHtoqujZip3vIIlT8VmeTxwgZkDqjj9/lpv9bS6s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kTpUQkhOuqWEQfhjRKTf2JHDr06AL54dY5tBQVFAHJqLsgr5YTTgIg6h2WArBXKxg6sGrbH+SbdA8J+DOcLuU4VZAiK3TqJTwb0DWEsWCcn3JK+oAFnfVEso399EJ85LWlLA9FyZ2ZRWdvMX5rfGsvhadUmOqlZMy6hEFzm1YE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jF25dsnV; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749144045; x=1780680045;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=XwGdHtoqujZip3vIIlT8VmeTxwgZkDqjj9/lpv9bS6s=;
  b=jF25dsnVNmEvUT9WaDArrH7D3xFzHzN91YINop1icZo78uNHyejh0Q41
   fuiNJagje/YXbCC8/dVZHum3CV2lUVh7HJJqk34JGvAxlVpcGmNzA+Pus
   EkOu5bf8MpEd9ila+UfpaAWeP45wa+BX/+RlM0Pz6A1kSBBPg8kvaAZhh
   Cd12h9KlEZdBImCQ4zD0y6xp/cQLgLwp75V9bExmL9qmCevv4IGHFzeUX
   24uVzhVOyDyP8DuZiW45XxdwLlZNT+5l6VXG+Tn+Oqwig4WM5Gjia+TCx
   QFFkcJ9XV/osZ5bGKIIqaDee4S7V50cuI9Bh6Z13kXzikHZjeYH09pEKI
   g==;
X-CSE-ConnectionGUID: lhxwz3qqQB2RB6seJeixiQ==
X-CSE-MsgGUID: KZXTNB+wTCCjB/n/UaYGMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11455"; a="68833796"
X-IronPort-AV: E=Sophos;i="6.16,212,1744095600"; 
   d="scan'208";a="68833796"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2025 10:20:45 -0700
X-CSE-ConnectionGUID: 9iz7uCNLQiuXpVKhsFkmnQ==
X-CSE-MsgGUID: D1ezj7lbSnikjO92mkTmZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,212,1744095600"; 
   d="scan'208";a="150458051"
Received: from spandruv-desk1.amr.corp.intel.com ([10.124.222.36])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2025 10:20:44 -0700
Message-ID: <63d616ac8bb1dbac9eebf10953886a5ce3274940.camel@linux.intel.com>
Subject: Re: [PATCH 2/2] thermal: intel: int340x: Allow temperature override
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: "Zhang, Rui" <rui.zhang@intel.com>, "lukasz.luba@arm.com"
	 <lukasz.luba@arm.com>, "rafael@kernel.org" <rafael@kernel.org>, 
 "daniel.lezcano@linaro.org"
	 <daniel.lezcano@linaro.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, 
 "linux-kernel@vger.kernel.org"
	 <linux-kernel@vger.kernel.org>
Date: Thu, 05 Jun 2025 10:20:43 -0700
In-Reply-To: <545fae8be782943a92d9df1c4a3ff90b7a865c76.camel@intel.com>
References: <20250604203518.2330533-1-srinivas.pandruvada@linux.intel.com>
		 <20250604203518.2330533-2-srinivas.pandruvada@linux.intel.com>
	 <545fae8be782943a92d9df1c4a3ff90b7a865c76.camel@intel.com>
Autocrypt: addr=srinivas.pandruvada@linux.intel.com; prefer-encrypt=mutual;
 keydata=mQGNBGYHNAsBDAC7tv5u9cIsSDvdgBBEDG0/a/nTaC1GXOx5MFNEDL0LWia2p8Asl7igx
 YrB68fyfPNLSIgtCmps0EbRUkPtoN5/HTbAEZeJUTL8Xdoe6sTywf8/6/DMheEUzprE4Qyjt0HheW
 y1JGvdOA0f1lkxCnPXeiiDY4FUqQHr3U6X4FPqfrfGlrMmGvntpKzOTutlQl8eSAprtgZ+zm0Jiwq
 NSiSBOt2SlbkGu9bBYx7mTsrGv+x7x4Ca6/BO9o5dIvwJOcfK/cXC/yxEkr1ajbIUYZFEzQyZQXrT
 GUGn8j3/cXQgVvMYxrh3pGCq9Q0Q6PAwQYhm97ipXa86GcTpP5B2ip9xclPtDW99sihiL8euTWRfS
 TUsEI+1YzCyz5DU32w3WiXr3ITicaMV090tMg9phIZsjfFbnR8hY03n0kRNWWFXi/ch2MsZCCqXIB
 oY/SruNH9Y6mnFKW8HSH762C7On8GXBYJzH6giLGeSsbvis2ZmV/r+LmswwZ6ACcOKLlvvIukAEQE
 AAbQ5U3Jpbml2YXMgUGFuZHJ1dmFkYSA8c3Jpbml2YXMucGFuZHJ1dmFkYUBsaW51eC5pbnRlbC5j
 b20+iQHRBBMBCAA7FiEEdki2SeUi0wlk2xcjOqtdDMJyisMFAmYHNAsCGwMFCwkIBwICIgIGFQoJC
 AsCBBYCAwECHgcCF4AACgkQOqtdDMJyisMobAv+LLYUSKNuWhRN3wS7WocRPCi3tWeBml+qivCwyv
 oZbmE2LcxYFnkcj6YNoS4N1CHJCr7vwefWTzoKTTDYqz3Ma0D0SbR1p/dH0nDgN34y41HpIHf0tx0
 UxGMgOWJAInq3A7/mNkoLQQ3D5siG39X3bh9Ecg0LhMpYwP/AYsd8X1ypCWgo8SE0J/6XX/HXop2a
 ivimve15VklMhyuu2dNWDIyF2cWz6urHV4jmxT/wUGBdq5j87vrJhLXeosueRjGJb8/xzl34iYv08
 wOB0fP+Ox5m0t9N5yZCbcaQug3hSlgp9hittYRgIK4GwZtNO11bOzeCEMk+xFYUoa5V8JWK9/vxrx
 NZEn58vMJ/nxoJzkb++iV7KBtsqErbs5iDwFln/TRJAQDYrtHJKLLFB9BGUDuaBOmFummR70Rbo55
 J9fvUHc2O70qteKOt5A0zv7G8uUdIaaUHrT+VOS7o+MrbPQcSk+bl81L2R7TfWViCmKQ60sD3M90Y
 oOfCQxricddC
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-06-05 at 02:18 +0000, Zhang, Rui wrote:
> On Wed, 2025-06-04 at 13:35 -0700, Srinivas Pandruvada wrote:
> > Add debugfs interface to override hardware provide temperature.
> > This
> > interface can be used primarily for debug. Alternatively this can
> > be also used to use hardware control loops to manage temperature
> > for
> > virtual sensors. Virtual sensors are soft sensors created by
> > kernel/
> > user space aggregating other sensors.
> >=20
> > There are three attributes to override the maximum three instances
> > of
> > platform temperature control.
> > /sys/kernel/debug/plaftform_temperature_control/
> > =E2=94=9C=E2=94=80=E2=94=80 temperature_0
> > =E2=94=9C=E2=94=80=E2=94=80 temperature_1
> > =E2=94=94=E2=94=80=E2=94=80 temperature_2
> >=20
> > These are write only attributes requires admin privilege. Any value
> > greater than 0, will override the temperature. A value of 0 will
> > stop overriding the temperature.
> >=20
> > Signed-off-by: Srinivas Pandruvada
> > <srinivas.pandruvada@linux.intel.com>
> > ---
> > =C2=A0.../platform_temperature_control.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 64
> > +++++++++++++++++++
> > =C2=A01 file changed, 64 insertions(+)
> >=20
> > diff --git
> > a/drivers/thermal/intel/int340x_thermal/platform_temperature_contro
> > l.c
> > b/drivers/thermal/intel/int340x_thermal/platform_temperature_contro
> > l.c
> > index 6cd05783a52d..5dcfd2cc9082 100644
> > ---
> > a/drivers/thermal/intel/int340x_thermal/platform_temperature_contro
> > l.c
> > +++
> > b/drivers/thermal/intel/int340x_thermal/platform_temperature_contro
> > l.c
> > @@ -38,6 +38,7 @@
> > =C2=A0
> > =C2=A0#include <linux/kernel.h>
> > =C2=A0#include <linux/module.h>
> > +#include <linux/debugfs.h>
> > =C2=A0#include <linux/pci.h>
> > =C2=A0#include "processor_thermal_device.h"
> > =C2=A0
> > @@ -53,6 +54,7 @@ struct mmio_reg {
> > =C2=A0
> > =C2=A0struct ptc_data {
> > =C2=A0	u32 offset;
> > +	struct pci_dev *pdev;
> > =C2=A0	struct attribute_group ptc_attr_group;
> > =C2=A0	struct attribute *ptc_attrs[PTC_MAX_ATTRS];
> > =C2=A0	struct device_attribute temperature_target_attr;
> > @@ -222,6 +224,63 @@ static int ptc_create_groups(struct pci_dev
> > *pdev,
> > int instance, struct ptc_data
> > =C2=A0}
> > =C2=A0
> > =C2=A0static struct ptc_data ptc_instance[PTC_MAX_INSTANCES];
> > +static struct dentry *ptc_debugfs;
> > +
> > +#define PTC_TEMP_OVERRIDE_ENABLE_INDEX	4
> > +#define PTC_TEMP_OVERRIDE_INDEX		5
> > +
> > +static ssize_t ptc_temperature_write(struct file *file, const char
> > __user *data,
> > +				=C2=A0=C2=A0=C2=A0=C2=A0 size_t count, loff_t *ppos)
> > +{
> > +	struct ptc_data *ptc_instance =3D file->private_data;
> > +	struct pci_dev *pdev =3D ptc_instance->pdev;
> > +	char buf[32];
> > +	ssize_t len;
> > +	u32 value;
> > +
> > +	len =3D min(count, sizeof(buf) - 1);
> > +	if (copy_from_user(buf, data, len))
> > +		return -EFAULT;
> > +
> > +	buf[len] =3D '\0';
> > +	if (kstrtouint(buf, 0, &value))
> > +		return -EINVAL;
> > +
> > +	if (ptc_mmio_regs[PTC_TEMP_OVERRIDE_INDEX].units)
> > +		value /=3D
> > ptc_mmio_regs[PTC_TEMP_OVERRIDE_INDEX].units;
> > +
> > +	if (value > ptc_mmio_regs[PTC_TEMP_OVERRIDE_INDEX].mask)
> > +		return -EINVAL;
> > +
> > +	if (!value) {
> > +		ptc_mmio_write(pdev, ptc_instance->offset,
> > PTC_TEMP_OVERRIDE_ENABLE_INDEX, 0);
> > +	} else {
> > +		ptc_mmio_write(pdev, ptc_instance->offset,
> > PTC_TEMP_OVERRIDE_INDEX, value);
> > +		ptc_mmio_write(pdev, ptc_instance->offset,
> > PTC_TEMP_OVERRIDE_ENABLE_INDEX, 1);
> > +	}
> > +
> > +	return count;
> > +}
> > +
> > +static const struct file_operations ptc_fops =3D {
> > +	.open =3D simple_open,
> > +	.write =3D ptc_temperature_write,
> > +	.llseek =3D generic_file_llseek,
> > +};
> > +
> > +static void ptc_create_debugfs(void)
> > +{
> > +	ptc_debugfs =3D
> > debugfs_create_dir("plaftform_temperature_control", NULL);
>=20
> s/platform/plaftform
>=20
correct.

> And same in the changelog.
>=20
> > +
> > +	debugfs_create_file("temperature_0",=C2=A0 0200, ptc_debugfs,=C2=A0
> > &ptc_instance[0], &ptc_fops);
> > +	debugfs_create_file("temperature_1",=C2=A0 0200, ptc_debugfs,=C2=A0
> > &ptc_instance[1], &ptc_fops);
> > +	debugfs_create_file("temperature_2",=C2=A0 0200, ptc_debugfs,=C2=A0
> > &ptc_instance[2], &ptc_fops);
> > +}
> > +
> > +static void ptc_delete_debugfs(void)
> > +{
> > +	debugfs_remove_recursive(ptc_debugfs);
> > +}
> > =C2=A0
> > =C2=A0int proc_thermal_ptc_add(struct pci_dev *pdev, struct
> > proc_thermal_device *proc_priv)
> > =C2=A0{
> > @@ -230,10 +289,13 @@ int proc_thermal_ptc_add(struct pci_dev
> > *pdev,
> > struct proc_thermal_device *proc_
> > =C2=A0
> > =C2=A0		for (i =3D 0; i < PTC_MAX_INSTANCES; i++) {
> > =C2=A0			ptc_instance[i].offset =3D ptc_offsets[i];
> > +			ptc_instance[i].pdev =3D pdev;
> > =C2=A0			ptc_create_groups(pdev, i,
> > &ptc_instance[i]);
> > =C2=A0		}
> > =C2=A0	}
> > =C2=A0
> > +	ptc_create_debugfs();
> > +
>=20
> should we create the debugfs only when PROC_THERMAL_FEATURE_PTC is
> set?

This function is only called when
 if (feature_mask & PROC_THERMAL_FEATURE_PTC) {
}


>=20
> > =C2=A0	return 0;
> > =C2=A0}
> > =C2=A0EXPORT_SYMBOL_GPL(proc_thermal_ptc_add);
> > @@ -248,6 +310,8 @@ void proc_thermal_ptc_remove(struct pci_dev
> > *pdev)
> > =C2=A0		for (i =3D 0; i < PTC_MAX_INSTANCES; i++)
> > =C2=A0			sysfs_remove_group(&pdev->dev.kobj,
> > &ptc_instance[i].ptc_attr_group);
> > =C2=A0	}
> > +
> > +	ptc_delete_debugfs();
>=20
> ditto.
Same as above.

Thanks,
Srinivas

>=20
> thanks,
> rui

