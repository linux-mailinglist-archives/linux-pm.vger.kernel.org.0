Return-Path: <linux-pm+bounces-8383-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 835728D3A9C
	for <lists+linux-pm@lfdr.de>; Wed, 29 May 2024 17:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD5D2B215ED
	for <lists+linux-pm@lfdr.de>; Wed, 29 May 2024 15:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2B4717F396;
	Wed, 29 May 2024 15:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cIOkx0zj"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948C01591EC;
	Wed, 29 May 2024 15:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716996026; cv=none; b=qBBTfQGAPo6nJi+RRPI69RXo+rjHBxDvJBV34joRnYL5GpwejjNe5YRU6wL3DrI7PWx6M64Sx00gHrNOIlvXjktHU9aJ1EjuC9oeE0IuLF0/ELzOeAoYuGc4Pb1oag0J1HEIpK/KT2CC1LrFGWKSVRTOfkJmn3OeR6y/g6QzNP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716996026; c=relaxed/simple;
	bh=C2x1quIrNKnjYamrmtk2MUqmEOEijoRNCRKlZSPgR7k=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=GmjPruOe27bmhTaX11DsLQzOIuVuysn+TuxxCGpSbfCSUeSXt+v1Ad0oj39XNxJMILsOFTFbNuN6jiZ6F2+JTegaflqgyY8CHEuUYcZS6+XYxpOO9Q7AHQZUpJmBINq3W9KqtIhKecRRFAEXWeBKTOOc2K+U8slGRHfrigQhSvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cIOkx0zj; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716996025; x=1748532025;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=C2x1quIrNKnjYamrmtk2MUqmEOEijoRNCRKlZSPgR7k=;
  b=cIOkx0zjtBb6jlQYSKPFnBv25WuREqvjreOhCJZhWYiDZYbtFs64Pnvi
   8YnWeWA/ZCsXYaeCzalZsggLfzBF561+MG6tLCygKn1ZIVaH0IJu0dFJS
   jYEin7q1lJJOcH4wPyEiT5rFG76vG+tDmv6uriVXPLsIcr+P4ElJYDvbZ
   aE1AwLZRXilUa84W3e11BWx9W/WzLOWjcKQ7Dq76taudkNo1OeYOCkDRw
   I25ttXDde64QQc8j6okj1q9KjNkRP8R3zIS46rgZyEMCiQYfWBZmDRNY9
   8VrSgwjjMz8Ajw+/87t0c+HSZYJqYfNEdlVtN3RsS3Dm/akMLt+09i84a
   Q==;
X-CSE-ConnectionGUID: PqzgdMZ1SCqcBny6FYt1zw==
X-CSE-MsgGUID: EyrdBhZXQ+q57/wgJppa0g==
X-IronPort-AV: E=McAfee;i="6600,9927,11087"; a="13638460"
X-IronPort-AV: E=Sophos;i="6.08,198,1712646000"; 
   d="scan'208";a="13638460"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 08:20:23 -0700
X-CSE-ConnectionGUID: 8sep0zYdQ1Spg3KDcOqqgQ==
X-CSE-MsgGUID: hSBA5+nwQk6YPB5PRPmFlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,198,1712646000"; 
   d="scan'208";a="36015343"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.149])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 08:20:18 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 29 May 2024 18:20:15 +0300 (EEST)
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
    Krzysztof Kozlowski <krzk+dt@kernel.org>, 
    Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
    Hans de Goede <hdegoede@redhat.com>, 
    Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
    Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Konrad Dybcio <konrad.dybcio@linaro.org>, linux-pm@vger.kernel.org, 
    devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    platform-driver-x86@vger.kernel.org, linux-usb@vger.kernel.org, 
    linux-arm-msm@vger.kernel.org, Nikita Travkin <nikita@trvn.ru>
Subject: Re: [PATCH v4 3/6] usb: typec: ucsi: add Lenovo Yoga C630 glue
 driver
In-Reply-To: <20240528-yoga-ec-driver-v4-3-4fa8dfaae7b6@linaro.org>
Message-ID: <ce6cbe69-f1de-1224-2a6e-3c7b07203d84@linux.intel.com>
References: <20240528-yoga-ec-driver-v4-0-4fa8dfaae7b6@linaro.org> <20240528-yoga-ec-driver-v4-3-4fa8dfaae7b6@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 28 May 2024, Dmitry Baryshkov wrote:

> The Lenovo Yoga C630 WOS laptop provides implements UCSI interface in
> the onboard EC. Add glue driver to interface the platform's UCSI
> implementation.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/usb/typec/ucsi/Kconfig          |   9 ++
>  drivers/usb/typec/ucsi/Makefile         |   1 +
>  drivers/usb/typec/ucsi/ucsi_yoga_c630.c | 189 ++++++++++++++++++++++++++++++++
>  3 files changed, 199 insertions(+)
> 
> diff --git a/drivers/usb/typec/ucsi/Kconfig b/drivers/usb/typec/ucsi/Kconfig
> index bdcb1764cfae..680e1b87b152 100644
> --- a/drivers/usb/typec/ucsi/Kconfig
> +++ b/drivers/usb/typec/ucsi/Kconfig
> @@ -69,4 +69,13 @@ config UCSI_PMIC_GLINK
>  	  To compile the driver as a module, choose M here: the module will be
>  	  called ucsi_glink.
>  
> +config UCSI_LENOVO_YOGA_C630
> +	tristate "UCSI Interface Driver for Lenovo Yoga C630"
> +	depends on EC_LENOVO_YOGA_C630
> +	help
> +	  This driver enables UCSI support on the Lenovo Yoga C630 laptop.
> +
> +	  To compile the driver as a module, choose M here: the module will be
> +	  called ucsi_yoga_c630.
> +
>  endif
> diff --git a/drivers/usb/typec/ucsi/Makefile b/drivers/usb/typec/ucsi/Makefile
> index b4679f94696b..aed41d23887b 100644
> --- a/drivers/usb/typec/ucsi/Makefile
> +++ b/drivers/usb/typec/ucsi/Makefile
> @@ -21,3 +21,4 @@ obj-$(CONFIG_UCSI_ACPI)			+= ucsi_acpi.o
>  obj-$(CONFIG_UCSI_CCG)			+= ucsi_ccg.o
>  obj-$(CONFIG_UCSI_STM32G0)		+= ucsi_stm32g0.o
>  obj-$(CONFIG_UCSI_PMIC_GLINK)		+= ucsi_glink.o
> +obj-$(CONFIG_UCSI_LENOVO_YOGA_C630)	+= ucsi_yoga_c630.o
> diff --git a/drivers/usb/typec/ucsi/ucsi_yoga_c630.c b/drivers/usb/typec/ucsi/ucsi_yoga_c630.c
> new file mode 100644
> index 000000000000..ca1ab5c81b87
> --- /dev/null
> +++ b/drivers/usb/typec/ucsi/ucsi_yoga_c630.c
> @@ -0,0 +1,189 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2022-2024, Linaro Ltd
> + * Authors:
> + *    Bjorn Andersson
> + *    Dmitry Baryshkov
> + */
> +#include <linux/auxiliary_bus.h>
> +#include <linux/module.h>
> +#include <linux/platform_data/lenovo-yoga-c630.h>
> +
> +#include "ucsi.h"
> +
> +struct yoga_c630_ucsi {
> +	struct yoga_c630_ec *ec;
> +	struct ucsi *ucsi;
> +	struct notifier_block nb;
> +	struct completion complete;

Add includes for what you used here.

> +	unsigned long flags;
> +#define UCSI_C630_COMMAND_PENDING	0
> +#define UCSI_C630_ACK_PENDING		1
> +	u16 version;
> +};
> +
> +static  int yoga_c630_ucsi_read(struct ucsi *ucsi, unsigned int offset,

extra space

> +				void *val, size_t val_len)
> +{
> +	struct yoga_c630_ucsi *uec = ucsi_get_drvdata(ucsi);

Missing include for ucsi_get_drvdata

> +	u8 buf[YOGA_C630_UCSI_READ_SIZE];
> +	int ret;
> +
> +	ret = yoga_c630_ec_ucsi_read(uec->ec, buf);
> +	if (ret)
> +		return ret;
> +
> +	if (offset == UCSI_VERSION) {
> +		memcpy(val, &uec->version, min(val_len, sizeof(uec->version)));
> +		return 0;
> +	}
> +
> +	if (offset == UCSI_CCI)
> +		memcpy(val, buf,
> +		       min(val_len, YOGA_C630_UCSI_CCI_SIZE));

Fits to one line.

> +	else if (offset == UCSI_MESSAGE_IN)
> +		memcpy(val, buf + YOGA_C630_UCSI_CCI_SIZE,
> +		       min(val_len, YOGA_C630_UCSI_DATA_SIZE));
> +	else
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static  int yoga_c630_ucsi_async_write(struct ucsi *ucsi, unsigned int offset,

extra space, there seems to be more of them below but I won't mark them.

> +				       const void *val, size_t val_len)
> +{
> +	struct yoga_c630_ucsi *uec = ucsi_get_drvdata(ucsi);
> +
> +	if (offset != UCSI_CONTROL ||
> +	    val_len != YOGA_C630_UCSI_WRITE_SIZE)
> +		return -EINVAL;
> +
> +	return yoga_c630_ec_ucsi_write(uec->ec, val);
> +}
> +
> +static  int yoga_c630_ucsi_sync_write(struct ucsi *ucsi, unsigned int offset,
> +				      const void *val, size_t val_len)
> +{
> +	struct yoga_c630_ucsi *uec = ucsi_get_drvdata(ucsi);
> +	bool ack = UCSI_COMMAND(*(u64 *)val) == UCSI_ACK_CC_CI;
> +	int ret;
> +
> +	if (ack)
> +		set_bit(UCSI_C630_ACK_PENDING, &uec->flags);
> +	else
> +		set_bit(UCSI_C630_COMMAND_PENDING, &uec->flags);

Include for set_bit()

> +	reinit_completion(&uec->complete);
> +
> +	ret = yoga_c630_ucsi_async_write(ucsi, offset, val, val_len);
> +	if (ret)
> +		goto out_clear_bit;
> +
> +	if (!wait_for_completion_timeout(&uec->complete, 5 * HZ))
> +		ret = -ETIMEDOUT;
> +
> +out_clear_bit:
> +	if (ack)
> +		clear_bit(UCSI_C630_ACK_PENDING, &uec->flags);
> +	else
> +		clear_bit(UCSI_C630_COMMAND_PENDING, &uec->flags);
> +
> +	return ret;
> +}
> +
> +const struct ucsi_operations yoga_c630_ucsi_ops = {

Include for ucsi_operations.

> +	.read = yoga_c630_ucsi_read,
> +	.sync_write = yoga_c630_ucsi_sync_write,
> +	.async_write = yoga_c630_ucsi_async_write,
> +};
> +
> +static int yoga_c630_ucsi_notify(struct notifier_block *nb,
> +				 unsigned long action, void *data)
> +{
> +	struct yoga_c630_ucsi *uec = container_of(nb, struct yoga_c630_ucsi, nb);

Include for container_of

-- 
 i.


