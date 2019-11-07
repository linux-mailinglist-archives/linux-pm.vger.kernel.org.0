Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17B6EF3AC3
	for <lists+linux-pm@lfdr.de>; Thu,  7 Nov 2019 22:53:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725940AbfKGVxD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 Nov 2019 16:53:03 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41708 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbfKGVxD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 Nov 2019 16:53:03 -0500
Received: by mail-pg1-f194.google.com with SMTP id h4so2808068pgv.8
        for <linux-pm@vger.kernel.org>; Thu, 07 Nov 2019 13:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=o0ume9X7I6N76DsAN7wkv6uhtYAHw2lFawaiRsAlXeE=;
        b=UQi/e0xSKJZk+h6N6SInwLTOvaB+klR3whs7t8mKIGUnRvZArtjpC8RSo7uemHTEog
         L7zp8gMgTWzsA/X9pPfA+qCR50U4LkP+g2RyYmgUgSW/qxRkehVnykpfUOh5AGPhvH7H
         PsIniA+uvxRVU0+/UYuNtTeOIXRNCSG24XEso8YUu/tpHoU1XKAsMFzqukmasIa6IVFr
         YFxWMda1IcuXCy9c+7TIug4zFQwkSjBNRO5aTb9psVbmQYjDGZo9tzMD1NlDYZt67JtS
         M9IBmOsbaT4vOb4APRiL1xK61NK3SCGuVT7FuBJ+EpBCsCb7bY+B7Qcuvai7de9A4Rfh
         wepQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=o0ume9X7I6N76DsAN7wkv6uhtYAHw2lFawaiRsAlXeE=;
        b=Jnj05MmQiTuUMlv+pLFYqJC2x6cIpW78vM3dODs3QmwVVZQ00jABNUSch8a73XxMb9
         VrgeSsyKy8BQPsVcr2raj45hkn/+FqZDxzH8qkL7CpNs16kpTfFjsL9Bs/sZuVa5GALb
         LSbAOTWeL/aOofggOyZ9MJOXQN2chBXgZxELh1USe2f29KO2ogiM4QSowMWSAOa/b4Tv
         afCLlFChnj/xjapvvwOMWoErJnILL2ICyIoF+3vSFVtbEKqAS18FmD39BsgSHtP7pjpn
         mp4smnWRAIYerpXJwCWoHRNz5N8LSw/2N1JR+sNvYhZsVP8ZvIf9DiGKZy7IxwnyaCSK
         ZTbw==
X-Gm-Message-State: APjAAAVzz9HeR/A2p3v1+FiRI7uuDQbfc76zp377+V1nJFaVCCdzwes3
        s8vkwBlKdEJBYAfTTs3g207TXA==
X-Google-Smtp-Source: APXvYqz4ytu4dwGEBbaA+ANgDsfu16kcduxM5Ii57ZM/xvTSeqnvyTcX1+5FWYiHFkLiQRzwoRqo1A==
X-Received: by 2002:a62:ab17:: with SMTP id p23mr7036931pff.116.1573163580868;
        Thu, 07 Nov 2019 13:53:00 -0800 (PST)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id w2sm3463961pgm.18.2019.11.07.13.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 13:53:00 -0800 (PST)
Date:   Thu, 07 Nov 2019 13:53:00 -0800 (PST)
X-Google-Original-Date: Thu, 07 Nov 2019 13:51:19 PST (-0800)
Subject:     Re: [PATCH 2/2] power: reset: add a QEMU RISC-V virt machine poweroff driver
In-Reply-To: <20191107212408.11857-3-hch@lst.de>
CC:     sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Christoph Hellwig <hch@lst.de>
Message-ID: <mhng-b62f1a62-8264-4e99-bc31-66fb59855bf8@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 07 Nov 2019 13:24:08 PST (-0800), Christoph Hellwig wrote:
> Add a trivial poweroff driver for the qemu-virt test device that
> allows an oderly shutdown of the VM.
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

Reviewed-by: Palmer Dabbelt <palmer@dabbelt.com>
