Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B15AF3B76
	for <lists+linux-pm@lfdr.de>; Thu,  7 Nov 2019 23:33:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbfKGWdl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 Nov 2019 17:33:41 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34254 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbfKGWdl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 Nov 2019 17:33:41 -0500
Received: by mail-pg1-f194.google.com with SMTP id e4so2897328pgs.1
        for <linux-pm@vger.kernel.org>; Thu, 07 Nov 2019 14:33:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=KtzwCyDT19z1S/QbvOzECaMFt412YXqfydQ1RzuBLkg=;
        b=U1TcGbh9Ac/ENu5Rs+S9Agdi2VU7eIlxTXaNEWHmbHgzonebCmn+P91pgkmYMo4AvA
         KvDE50sI21hLyf0NdqS8XP9yHH1BhqQ2fZR5iY397Q4kVY7nQmYRwMbVpGpNbCb3N2Kg
         h0OerXAyIOBLaGmYEG57kEVwH1JCMIiZyFgQBe7WXtpshynim83LFQAVfhJGDREKeQqC
         GGJ51elHoA/8bVLu2Gulh8B/4McXfSnDIyltuXj+oY9ys1sDPzQJ2zW9IfYi4kesF7kE
         I8SyH1bZc2yz8syd87Dk2DuTkcJ10+JhKNd0xhdrK/Fhrv3cb11Ws+otR8grfzkFYTh/
         qTlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=KtzwCyDT19z1S/QbvOzECaMFt412YXqfydQ1RzuBLkg=;
        b=Tvhgi2aOBhNABRZn7Bmjl/jpKcPg/mLNK1lboGcdkTag1GY9M3p4IxSoyXdRmD4gJd
         qh+Myqw/PYZPgOYEUnW+IXLn+4JntaIRIKPNDqAOBqsWuIyq3VEPbgzzY8x2qXDwMR6X
         iJZYe3geE9L9sgbnAg4KB51mn3GfoWgVKI2H1pyyCfx9sgMH+LmB/1nNkh6x5K+OZkSj
         LW1zad6bTU32D2LzvLv4t2bHlhDGLd/7hudgfPldWTLJeOA0q2L35tQQah5/aEQoRhja
         GZBlmdeRvL97jw0ooCqnZ4oXLzvuNUcjS5gOItcFKNrrGgmT/teB2sSCv4rpKAo49aju
         T+OQ==
X-Gm-Message-State: APjAAAVCatUsXQu3kV0cFcXc1giGYo7MWoaS4nwmthylbD8qqJW3rwbZ
        pX/zCBq3S34mazIuGUTuggsv2du4ecQ=
X-Google-Smtp-Source: APXvYqxZKvUYQHZ7SvkUplmFNtYCYPosc9srD1F4orE7a2p2nPUegMn1rtKpokaCUl5aBcuZ3LlyXg==
X-Received: by 2002:a62:e105:: with SMTP id q5mr7413683pfh.105.1573166019175;
        Thu, 07 Nov 2019 14:33:39 -0800 (PST)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id y36sm3313037pgk.66.2019.11.07.14.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 14:33:38 -0800 (PST)
Date:   Thu, 7 Nov 2019 14:33:37 -0800 (PST)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Christoph Hellwig <hch@lst.de>
cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH 2/2] power: reset: add a QEMU RISC-V virt machine poweroff
 driver
In-Reply-To: <20191107212408.11857-3-hch@lst.de>
Message-ID: <alpine.DEB.2.21.9999.1911071432110.8918@viisi.sifive.com>
References: <20191107212408.11857-1-hch@lst.de> <20191107212408.11857-3-hch@lst.de>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 7 Nov 2019, Christoph Hellwig wrote:

> Add a trivial poweroff driver for the qemu-virt test device that
> allows an oderly shutdown of the VM.

"orderly"

> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/riscv/configs/defconfig                  |  2 +
>  drivers/power/reset/Kconfig                   |  8 ++++
>  drivers/power/reset/Makefile                  |  1 +
>  .../power/reset/qemu-riscv-virt-poweroff.c    | 47 +++++++++++++++++++
>  4 files changed, 58 insertions(+)
>  create mode 100644 drivers/power/reset/qemu-riscv-virt-poweroff.c
> 
> diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
> index 420a0dbef386..47da87725b5e 100644
> --- a/arch/riscv/configs/defconfig
> +++ b/arch/riscv/configs/defconfig
> @@ -63,6 +63,8 @@ CONFIG_HW_RANDOM_VIRTIO=y
>  CONFIG_SPI=y
>  CONFIG_SPI_SIFIVE=y
>  # CONFIG_PTP_1588_CLOCK is not set
> +CONFIG_POWER_RESET=y
> +CONFIG_QEMU_RISCV_VIRT_POWEROFF=y
>  CONFIG_DRM=y
>  CONFIG_DRM_RADEON=y
>  CONFIG_DRM_VIRTIO_GPU=y
> diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
> index a564237278ff..56cb18520850 100644
> --- a/drivers/power/reset/Kconfig
> +++ b/drivers/power/reset/Kconfig
> @@ -256,5 +256,13 @@ config NVMEM_REBOOT_MODE
>  	  then the bootloader can read it and take different
>  	  action according to the mode.
>  
> +config QEMU_RISCV_VIRT_POWEROFF
> +	tristate "QEMU RISC-V virt machine poweroff driver"
> +	depends on OF
> +	depends on RISCV || COMPILE_TEST
> +	help
> +	  Say y here to allow RISC-V Qemu VMs to be shut down by
> +	  the kernel.

Same comments here and below as 

https://lore.kernel.org/linux-riscv/mhng-0dedc685-73d2-4e7f-b608-69385a6e7a99@palmer-si-x1c4/T/#t

there's nothing that should be RISC-V specific here.

> +
>  endif
>  
> diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
> index 85da3198e4e0..b3094016b634 100644
> --- a/drivers/power/reset/Makefile
> +++ b/drivers/power/reset/Makefile
> @@ -30,3 +30,4 @@ obj-$(CONFIG_REBOOT_MODE) += reboot-mode.o
>  obj-$(CONFIG_SYSCON_REBOOT_MODE) += syscon-reboot-mode.o
>  obj-$(CONFIG_POWER_RESET_SC27XX) += sc27xx-poweroff.o
>  obj-$(CONFIG_NVMEM_REBOOT_MODE) += nvmem-reboot-mode.o
> +obj-$(CONFIG_QEMU_RISCV_VIRT_POWEROFF) += qemu-riscv-virt-poweroff.o
> diff --git a/drivers/power/reset/qemu-riscv-virt-poweroff.c b/drivers/power/reset/qemu-riscv-virt-poweroff.c
> new file mode 100644
> index 000000000000..5b9a12dd853b
> --- /dev/null
> +++ b/drivers/power/reset/qemu-riscv-virt-poweroff.c
> @@ -0,0 +1,47 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2019 Christoph Hellwig.
> + */
> +
> +#include <linux/reboot.h>
> +#include <linux/init.h>
> +#include <linux/io.h>
> +#include <linux/platform_device.h>
> +#include <linux/of_address.h>
> +#include <linux/module.h>
> +
> +#define VIRT_TEST_FINISHER_PASS         0x5555
> +
> +static u16 __iomem *test_addr;
> +
> +static void qemu_virt_power_off(void)
> +{
> +	writew(VIRT_TEST_FINISHER_PASS, test_addr);
> +}
> +
> +static int sifive_test_probe(struct platform_device *pdev)
> +{
> +	/* there can only be a single instance */
> +	if (WARN_ON_ONCE(test_addr))
> +		return -EINVAL;
> +
> +	test_addr = of_iomap(pdev->dev.of_node, 0);
> +	if (!test_addr)
> +		return -EINVAL;
> +	pm_power_off = qemu_virt_power_off;
> +	return 0;
> +}
> +
> +static const struct of_device_id sifive_test_of_match[] = {
> +	{ .compatible = "sifive,test0", },
> +	{},
> +};
> +
> +static struct platform_driver sifive_test_driver = {
> +	.probe			= sifive_test_probe,
> +	.driver = {
> +		.name		= "sifive_test",
> +		.of_match_table = sifive_test_of_match,
> +	},
> +};
> +module_platform_driver(sifive_test_driver);
> -- 
> 2.20.1
> 
> 


- Paul
