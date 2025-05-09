Return-Path: <linux-pm+bounces-26950-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C4FEAB15E4
	for <lists+linux-pm@lfdr.de>; Fri,  9 May 2025 15:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EB061C27705
	for <lists+linux-pm@lfdr.de>; Fri,  9 May 2025 13:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C67532918D2;
	Fri,  9 May 2025 13:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HiuA12Ai"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD3828F536;
	Fri,  9 May 2025 13:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746798671; cv=none; b=HRT/riJS+yzTd1vteNikJo2ZtaicP3jtKUuhw/06t0VjhwbzZMwW2YapkaCFtPUI9ihr78PBSOcJ1iOJ2Rlj5hDx/U1b+xqIddDBn1q3IR8KgGzC7gaCFA7DC9ncW6QDSL+ZcdSs1vkfyNEpnmydnaEwsCufoTNxnGVeabw3KU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746798671; c=relaxed/simple;
	bh=VgPTylq0l40HvC0SmQuYOboDkxs5/RvsS4NVsAHmlbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CbLl40GMgf0+62F40rQVgaXPYx4sbWznltCdSrU9BvR51VaxTYYVPTfLdOE41ZbOnHFDAvIrdxshDbPFY5+MIvTRJRuL4BqZw1Yc5Nf1sGvuHhpoDh6C9C8+6Xqkwj6v7aBNQIsSy22cFaFsg4PxLjuVmVLUVMPg6TVrC7RLFA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HiuA12Ai; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45D08C4CEE4;
	Fri,  9 May 2025 13:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746798671;
	bh=VgPTylq0l40HvC0SmQuYOboDkxs5/RvsS4NVsAHmlbA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HiuA12AisEGvDGbdihCtzq8htDNElKlMVU6uzp4EThl7i4CBLAdokKnzsNW5zE3It
	 +8/aalc/Z95GtrZr0cvHssAx2S8H1ibaDOdTKZ3SD+bWv+F9oBqF95DpRSgluqUf/r
	 qnnhSYeC1siLpGX2ByHIy/T8RjW780NCivwgNmjpeI2HT7fPvm7aenS3E5rZAAhlEk
	 hFK/XCcZRJdTkGsp61brQrJJFDjMCIkmomWOVihlhYQs3RdQdmZ/E3wkjY1v9g4aGx
	 xzm0Lr/VMlGu/oBZYvCiYupOrvAV25EWhJGqKSW1hHWOFnV6/YNQJFvdxiQ5sKbM7k
	 HXeogIEHV/hPw==
Date: Fri, 9 May 2025 14:51:04 +0100
From: Lee Jones <lee@kernel.org>
To: sven@svenpeter.dev
Cc: Janne Grunau <j@jannau.net>, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Neal Gompa <neal@gompa.dev>, Hector Martin <marcan@marcan.st>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sebastian Reichel <sre@kernel.org>, Marc Zyngier <maz@kernel.org>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 4/9] mfd: Add Apple Silicon System Management
 Controller
Message-ID: <20250509135104.GC2492385@google.com>
References: <20250503-smc-6-15-v4-0-500b9b6546fc@svenpeter.dev>
 <20250503-smc-6-15-v4-4-500b9b6546fc@svenpeter.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250503-smc-6-15-v4-4-500b9b6546fc@svenpeter.dev>

On Sat, 03 May 2025, Sven Peter via B4 Relay wrote:

> From: Sven Peter <sven@svenpeter.dev>
> 
> The System Management Controller (SMC) on Apple Silicon machines is a
> piece of hardware that exposes various functionalities such as
> temperature sensors, voltage/power meters, shutdown/reboot handling,
> GPIOs and more.
> 
> Communication happens via a shared mailbox using the RTKit protocol
> which is also used for other co-processors. The SMC protocol then allows
> reading and writing many different keys which implement the various
> features. The MFD core device handles this protocol and exposes it
> to the sub-devices.
> 
> Some of the sub-devices are potentially also useful on pre-M1 Apple
> machines and support for SMCs on these machines can be added at a later
> time.
> 
> Co-developed-by: Hector Martin <marcan@marcan.st>
> Signed-off-by: Hector Martin <marcan@marcan.st>
> Signed-off-by: Sven Peter <sven@svenpeter.dev>
> ---
>  MAINTAINERS                |   2 +
>  drivers/mfd/Kconfig        |  15 ++
>  drivers/mfd/Makefile       |   1 +
>  drivers/mfd/macsmc.c       | 657 +++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/macsmc.h | 337 +++++++++++++++++++++++
>  5 files changed, 1012 insertions(+)

Looks generally okay.  Much better than the previous attempts.

If the exported API gets much larger, it'd be better suited to
drivers/platform or perhaps co-located with the rtkit in drivers/soc,
whilst leaving the resource handling and child driver registration here.

Most of what I see here are stylistic issues, so bear with me.

> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2c16b2fc3fec76104967530f487123485af1e777..831df43892a64c95e00c24d77b8aa2a6ec87e074 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2300,6 +2300,7 @@ F:	drivers/input/touchscreen/apple_z2.c
>  F:	drivers/iommu/apple-dart.c
>  F:	drivers/iommu/io-pgtable-dart.c
>  F:	drivers/irqchip/irq-apple-aic.c
> +F:	drivers/mfd/macsmc.c
>  F:	drivers/nvme/host/apple.c
>  F:	drivers/nvmem/apple-efuses.c
>  F:	drivers/nvmem/apple-spmi-nvmem.c
> @@ -2312,6 +2313,7 @@ F:	drivers/video/backlight/apple_dwi_bl.c
>  F:	drivers/watchdog/apple_wdt.c
>  F:	include/dt-bindings/interrupt-controller/apple-aic.h
>  F:	include/dt-bindings/pinctrl/apple.h
> +F:	include/linux/mfd/macsmc.h
>  F:	include/linux/soc/apple/*
>  
>  ARM/ARTPEC MACHINE SUPPORT
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 22b93631003943c393d9fe704748bc23f1905397..da56fc4f05b7b7e0a521fcd97bee087424ec4d5b 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -285,6 +285,21 @@ config MFD_CS42L43_SDW
>  	  Select this to support the Cirrus Logic CS42L43 PC CODEC with
>  	  headphone and class D speaker drivers over SoundWire.
>  
> +config MFD_MACSMC
> +	tristate "Apple Silicon System Management Controller (SMC)"
> +	select MFD_CORE
> +	help
> +	  The System Management Controller (SMC) on Apple Silicon machines is a
> +	  piece of hardware that exposes various functionalities such as
> +	  temperature sensors, voltage/power meters, shutdown/reboot handling,
> +	  GPIOs and more.
> +
> +	  Communication happens via a shared mailbox using the RTKit protocol
> +	  which is also used for other co-processors. The SMC protocol then
> +	  allows reading and writing many different keys which implement the
> +	  various features. The MFD core device handles this protocol and
> +	  exposes it to the sub-devices.

MFD doesn't usually like this much knowledge of the communication
mechanism.  We usually rely on; I2C, SPI, USB, etc APIs for that.
However, given the unusualness of this device and the submission
history, I'm willing to slacken that off a bit.

>  config MFD_MADERA
>  	tristate "Cirrus Logic Madera codecs"
>  	select MFD_CORE
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index 948cbdf42a18b22a826f0b17fb8d5796a7ec8ba6..e9e2403d961a631d9d63a274e0e4f6457ae9e0f2 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -21,6 +21,7 @@ obj-$(CONFIG_MFD_CS42L43_SDW)	+= cs42l43-sdw.o
>  obj-$(CONFIG_MFD_ENE_KB3930)	+= ene-kb3930.o
>  obj-$(CONFIG_MFD_EXYNOS_LPASS)	+= exynos-lpass.o
>  obj-$(CONFIG_MFD_GATEWORKS_GSC)	+= gateworks-gsc.o
> +obj-$(CONFIG_MFD_MACSMC)	+= macsmc.o
>  
>  obj-$(CONFIG_MFD_TI_LP873X)	+= lp873x.o
>  obj-$(CONFIG_MFD_TI_LP87565)	+= lp87565.o
> diff --git a/drivers/mfd/macsmc.c b/drivers/mfd/macsmc.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..59c2851b70f70a221434287cc99ef870a96f3659
> --- /dev/null
> +++ b/drivers/mfd/macsmc.c
> @@ -0,0 +1,657 @@
> +// SPDX-License-Identifier: GPL-2.0-only OR MIT
> +/*
> + * Apple SMC (System Management Controller) MFD driver
> + *
> + * Copyright The Asahi Linux Contributors
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/io.h>
> +#include <linux/ioport.h>
> +#include <linux/math.h>
> +#include <linux/mfd/core.h>
> +#include <linux/mfd/macsmc.h>
> +#include <linux/notifier.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <linux/soc/apple/rtkit.h>
> +#include <linux/unaligned.h>
> +
> +#define SMC_ENDPOINT			0x20
> +
> +/* We don't actually know the true size here but this seem reasonable */
> +#define SMC_SHMEM_SIZE			0x1000
> +#define SMC_MAX_SIZE			255
> +
> +#define SMC_MSG_READ_KEY		0x10
> +#define SMC_MSG_WRITE_KEY		0x11
> +#define SMC_MSG_GET_KEY_BY_INDEX	0x12
> +#define SMC_MSG_GET_KEY_INFO		0x13
> +#define SMC_MSG_INITIALIZE		0x17
> +#define SMC_MSG_NOTIFICATION		0x18
> +#define SMC_MSG_RW_KEY			0x20
> +
> +#define SMC_DATA			GENMASK_ULL(63, 32)
> +#define SMC_WSIZE			GENMASK_ULL(31, 24)
> +#define SMC_SIZE			GENMASK_ULL(23, 16)
> +#define SMC_ID				GENMASK_ULL(15, 12)
> +#define SMC_MSG				GENMASK_ULL(7, 0)
> +#define SMC_RESULT			SMC_MSG
> +
> +#define SMC_RECV_TIMEOUT		500
> +
> +static const struct mfd_cell apple_smc_devs[] = {
> +	MFD_CELL_OF("macsmc-gpio", NULL, NULL, 0, 0, "apple,smc-gpio"),
> +	MFD_CELL_OF("macsmc-reboot", NULL, NULL, 0, 0, "apple,smc-reboot"),

Are there more devices coming?

> +};
> +
> +static int apple_smc_cmd_locked(struct apple_smc *smc, u64 cmd, u64 arg,
> +				  u64 size, u64 wsize, u32 *ret_data)
> +{
> +	int ret;
> +	u64 msg;
> +	u8 result;
> +
> +	lockdep_assert_held(&smc->mutex);
> +
> +	if (!smc->alive)
> +		return -EIO;
> +	if (smc->atomic_mode)
> +		return -EIO;
> +
> +	reinit_completion(&smc->cmd_done);
> +
> +	smc->msg_id = (smc->msg_id + 1) & 0xf;
> +	msg = (FIELD_PREP(SMC_MSG, cmd) |
> +	       FIELD_PREP(SMC_SIZE, size) |
> +	       FIELD_PREP(SMC_WSIZE, wsize) |
> +	       FIELD_PREP(SMC_ID, smc->msg_id) |
> +	       FIELD_PREP(SMC_DATA, arg));
> +
> +	ret = apple_rtkit_send_message(smc->rtk, SMC_ENDPOINT, msg, NULL, false);
> +	if (ret < 0) {
> +		dev_err(smc->dev, "Failed to send command\n");
> +		return ret;
> +	}
> +
> +	do {
> +		if (wait_for_completion_timeout(&smc->cmd_done,
> +						msecs_to_jiffies(SMC_RECV_TIMEOUT)) == 0) {
> +			dev_err(smc->dev, "Command timed out (%llx)", msg);
> +			return -ETIMEDOUT;
> +		}
> +		if (FIELD_GET(SMC_ID, smc->cmd_ret) == smc->msg_id)
> +			break;
> +		dev_err(smc->dev, "Command sequence mismatch (expected %d, got %d)\n",
> +			smc->msg_id, (unsigned int)FIELD_GET(SMC_ID, smc->cmd_ret));
> +	} while (1);
> +
> +	result = FIELD_GET(SMC_RESULT, smc->cmd_ret);
> +	if (result != 0)
> +		return -result;
> +
> +	if (ret_data)
> +		*ret_data = FIELD_GET(SMC_DATA, smc->cmd_ret);
> +
> +	return FIELD_GET(SMC_SIZE, smc->cmd_ret);
> +}
> +
> +static int apple_smc_cmd(struct apple_smc *smc, u64 cmd, u64 arg,
> +			 u64 size, u64 wsize, u32 *ret_data)
> +{
> +	guard(mutex)(&smc->mutex);
> +
> +	return apple_smc_cmd_locked(smc, cmd, arg, size, wsize, ret_data);
> +}
> +
> +static int apple_smc_rw_locked(struct apple_smc *smc, smc_key key,
> +				const void *wbuf, size_t wsize,
> +				void *rbuf, size_t rsize)
> +{
> +	int ret;
> +	u64 cmd;
> +	u64 smc_size, smc_wsize;
> +	u32 rdata;
> +
> +	lockdep_assert_held(&smc->mutex);
> +
> +	dev_dbg(smc->dev, "SMC key: %p4ch, wsize: %zu, rsize: %zu\n", &key, wsize, rsize);
> +
> +	if (rsize > SMC_MAX_SIZE)
> +		return -EINVAL;
> +	if (wsize > SMC_MAX_SIZE)
> +		return -EINVAL;
> +
> +	if (rsize && wsize) {
> +		cmd = SMC_MSG_RW_KEY;
> +		memcpy_toio(smc->shmem.iomem, wbuf, wsize);
> +		smc_size = rsize;
> +		smc_wsize = wsize;
> +	} else if (wsize && !rsize) {
> +		cmd = SMC_MSG_WRITE_KEY;
> +		memcpy_toio(smc->shmem.iomem, wbuf, wsize);
> +		/*
> +		 * Setting size to the length we want to write and wsize to 0
> +		 * looks silly but that's how the SMC protocol works ¯\_(ツ)_/¯
> +		 */
> +		smc_size = wsize;
> +		smc_wsize = 0;
> +	} else if (!wsize && rsize) {
> +		cmd = SMC_MSG_READ_KEY;
> +		smc_size = rsize;
> +		smc_wsize = 0;
> +	} else {
> +		return -EINVAL;
> +	}
> +
> +	ret = apple_smc_cmd_locked(smc, cmd, key, smc_size, smc_wsize, &rdata);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (rsize) {
> +		/*
> +		 * Small data <= 4 bytes is returned as part of the reply
> +		 * message which is sent over the mailbox FIFO. Everything
> +		 * bigger has to be copied from SRAM which is mapped as
> +		 * Device memory.
> +		 */
> +		if (rsize <= 4)
> +			memcpy(rbuf, &rdata, rsize);
> +		else
> +			memcpy_fromio(rbuf, smc->shmem.iomem, rsize);
> +	}
> +
> +	return ret;
> +}
> +
> +int apple_smc_read(struct apple_smc *smc, smc_key key, void *buf, size_t size)
> +{
> +	guard(mutex)(&smc->mutex);
> +
> +	return apple_smc_rw_locked(smc, key, NULL, 0, buf, size);
> +}
> +EXPORT_SYMBOL(apple_smc_read);
> +
> +int apple_smc_write(struct apple_smc *smc, smc_key key, void *buf, size_t size)
> +{
> +	guard(mutex)(&smc->mutex);
> +
> +	return apple_smc_rw_locked(smc, key, buf, size, NULL, 0);
> +}
> +EXPORT_SYMBOL(apple_smc_write);
> +
> +int apple_smc_rw(struct apple_smc *smc, smc_key key, void *wbuf, size_t wsize,
> +	void *rbuf, size_t rsize)
> +{
> +	guard(mutex)(&smc->mutex);
> +
> +	return apple_smc_rw_locked(smc, key, wbuf, wsize, rbuf, rsize);
> +}
> +EXPORT_SYMBOL(apple_smc_rw);
> +
> +int apple_smc_get_key_by_index(struct apple_smc *smc, int index, smc_key *key)
> +{
> +	int ret;
> +
> +	ret = apple_smc_cmd(smc, SMC_MSG_GET_KEY_BY_INDEX, index, 0, 0, key);
> +
> +	*key = swab32(*key);
> +	return ret;
> +}
> +EXPORT_SYMBOL(apple_smc_get_key_by_index);
> +
> +int apple_smc_get_key_info(struct apple_smc *smc, smc_key key, struct apple_smc_key_info *info)
> +{
> +	u8 key_info[6];
> +	int ret;
> +
> +	ret = apple_smc_cmd(smc, SMC_MSG_GET_KEY_INFO, key, 0, 0, NULL);
> +	if (ret >= 0 && info) {
> +		memcpy_fromio(key_info, smc->shmem.iomem, sizeof(key_info));
> +		info->size = key_info[0];
> +		info->type_code = get_unaligned_be32(&key_info[1]);
> +		info->flags = key_info[5];
> +	}
> +	return ret;
> +}
> +EXPORT_SYMBOL(apple_smc_get_key_info);
> +
> +int apple_smc_find_first_key_index(struct apple_smc *smc, smc_key key)
> +{
> +	int start, count;
> +
> +	/* return early if the key is out of bounds */

I'll only say this once, but it applies throughout.

Please start comments with an uppercase char.

> +	if (key <= smc->first_key)
> +		return 0;
> +	if (key > smc->last_key)
> +		return smc->key_count;
> +
> +	/* binary search to find index of first SMC key bigger or equal to key */
> +	start = 0;
> +	count = smc->key_count;
> +	while (count > 1) {
> +		int ret;
> +		smc_key pkey;
> +		int pivot = start + ((count - 1) >> 1);
> +
> +		ret = apple_smc_get_key_by_index(smc, pivot, &pkey);
> +		if (ret < 0)
> +			return ret;
> +
> +		if (pkey == key)
> +			return pivot;
> +
> +		pivot++;
> +
> +		if (pkey < key) {
> +			count -= pivot - start;
> +			start = pivot;
> +		} else {
> +			count = pivot - start;
> +		}
> +	}
> +
> +	return start;
> +}
> +EXPORT_SYMBOL(apple_smc_find_first_key_index);
> +
> +int apple_smc_read_f32_scaled(struct apple_smc *smc, smc_key key, int *p, int scale)
> +{
> +	u32 fval;
> +	u64 val;
> +	int ret, exp;
> +
> +	/* pretend the 4 bytes returned by SMC are a 32bit unsigned integer */
> +	ret = apple_smc_read_u32(smc, key, &fval);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* extract exponent and fraction from the IEEE 754 32bit float */

This seems like it's to technical / generic to live in a lowly device
driver.  Is this specific to this device?  If it's generic math stuff,
shouldn't it live somewhere more generic in the form of helpers?

> +	val = ((u64)((fval & GENMASK(22, 0)) | BIT(23)));
> +	exp = ((fval >> 23) & 0xff) - 127 - 23;
> +
> +	/* move fraction to target scale */
> +	if (scale < 0) {
> +		val <<= 32;
> +		exp -= 32;
> +		val /= -scale;
> +	} else {
> +		val *= scale;
> +	}
> +
> +	/* apply exponent if possible and fall back to 0 / U64_MAX on overflow */
> +	if (exp > 63)
> +		val = U64_MAX;
> +	else if (exp < -63)
> +		val = 0;
> +	else if (exp < 0)
> +		val >>= -exp;
> +	else if (exp != 0 && (val & ~((1UL << (64 - exp)) - 1))) /* overflow */
> +		val = U64_MAX;
> +	else
> +		val <<= exp;
> +
> +	/* handle IEEE 754 32bit float sign bit and catch possible overflows */
> +	if (fval & BIT(31)) {
> +		if (val > (-(s64)INT_MIN))
> +			*p = INT_MIN;
> +		else
> +			*p = -val;
> +	} else {
> +		if (val > INT_MAX)
> +			*p = INT_MAX;
> +		else
> +			*p = val;
> +	}
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL(apple_smc_read_f32_scaled);
> +
> +int apple_smc_read_ioft_scaled(struct apple_smc *smc, smc_key key, u64 *p,
> +			       int scale)

Unwrap everything less than 100-chars please.

> +{
> +	u64 val;
> +	int ret;
> +
> +	ret = apple_smc_read_u64(smc, key, &val);
> +	if (ret < 0)
> +		return ret;
> +
> +	/*
> +	 * The value val is represented in 48.16 fixed-point format, where
> +	 * the upper 48 bits represent the integer part and the lower 16 bits
> +	 * represent the fractional part. Dividing by 1 << 16 extracts the
> +	 * integer part by discarding the fractional portion.
> +	 * To scale the value as requested mult_frac is used to multiply val
> +	 * by the scaling factor while dividing by 1 << 16 in a single step.
> +	 */
> +	*p = mult_frac(val, scale, (1<<16));
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(apple_smc_read_ioft_scaled);
> +
> +int apple_smc_enter_atomic(struct apple_smc *smc)
> +{
> +	guard(mutex)(&smc->mutex);
> +
> +	/*
> +	 * Disable notifications since this is called before shutdown and no
> +	 * notification handler will be able to handle the notification
> +	 * using atomic operations only. Also ignore any failure here
> +	 * because we're about to shut down or reboot anyway.
> +	 * We can't use apple_smc_write_flag here since that would try to lock
> +	 * smc->mutex again.
> +	 */
> +	const u8 flag = 0;
> +
> +	apple_smc_rw_locked(smc, SMC_KEY(NTAP), &flag, sizeof(flag), NULL, 0);
> +
> +	smc->atomic_mode = true;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(apple_smc_enter_atomic);
> +
> +int apple_smc_write_atomic(struct apple_smc *smc, smc_key key, void *buf, size_t size)
> +{
> +	guard(spinlock_irqsave)(&smc->lock);
> +	int ret;
> +	u64 msg;
> +	u8 result;
> +
> +	if (size > SMC_MAX_SIZE || size == 0)
> +		return -EINVAL;
> +
> +	if (!smc->alive)
> +		return -EIO;
> +	if (!smc->atomic_mode)
> +		return -EIO;
> +
> +	memcpy_toio(smc->shmem.iomem, buf, size);
> +	smc->msg_id = (smc->msg_id + 1) & 0xf;
> +	msg = (FIELD_PREP(SMC_MSG, SMC_MSG_WRITE_KEY) |
> +	       FIELD_PREP(SMC_SIZE, size) |
> +	       FIELD_PREP(SMC_ID, smc->msg_id) |
> +	       FIELD_PREP(SMC_DATA, key));
> +	smc->atomic_pending = true;
> +
> +	ret = apple_rtkit_send_message(smc->rtk, SMC_ENDPOINT, msg, NULL, true);
> +	if (ret < 0) {
> +		dev_err(smc->dev, "Failed to send command (%d)\n", ret);
> +		return ret;
> +	}
> +
> +	while (smc->atomic_pending) {
> +		ret = apple_rtkit_poll(smc->rtk);
> +		if (ret < 0) {
> +			dev_err(smc->dev, "RTKit poll failed (%llx)", msg);
> +			return ret;
> +		}
> +		udelay(100);
> +	}
> +
> +	if (FIELD_GET(SMC_ID, smc->cmd_ret) != smc->msg_id) {
> +		dev_err(smc->dev, "Command sequence mismatch (expected %d, got %d)\n",
> +			smc->msg_id, (unsigned int)FIELD_GET(SMC_ID, smc->cmd_ret));
> +		return -EIO;
> +	}
> +
> +	result = FIELD_GET(SMC_RESULT, smc->cmd_ret);
> +	if (result != 0)
> +		return -result;
> +
> +	return FIELD_GET(SMC_SIZE, smc->cmd_ret);
> +}
> +EXPORT_SYMBOL(apple_smc_write_atomic);
> +
> +static void apple_smc_rtkit_crashed(void *cookie, const void *bfr, size_t bfr_len)
> +{
> +	struct apple_smc *smc = cookie;
> +
> +	dev_err(smc->dev, "SMC crashed! Your system will reboot in a few seconds...\n");
> +	smc->alive = false;
> +}
> +
> +static int apple_smc_rtkit_shmem_setup(void *cookie, struct apple_rtkit_shmem *bfr)
> +{
> +	struct apple_smc *smc = cookie;
> +	struct resource res = {

I don't get this at all.  Is this left over from a previous version?
Why do you need to store these values in a resource struct that never
gets used?

> +		.start = bfr->iova,
> +		.end = bfr->iova + bfr->size - 1,
> +		.name = "rtkit_map",
> +		.flags = smc->sram->flags,
> +	};
> +
> +	if (!bfr->iova) {
> +		dev_err(smc->dev, "RTKit wants a RAM buffer\n");
> +		return -EIO;
> +	}
> +
> +	if (res.end < res.start || !resource_contains(smc->sram, &res)) {
> +		dev_err(smc->dev,
> +			"RTKit buffer request outside SRAM region: %pR", &res);
> +		return -EFAULT;
> +	}
> +
> +	bfr->iomem = smc->sram_base + (res.start - smc->sram->start);
> +	bfr->is_mapped = true;
> +
> +	return 0;
> +}
> +
> +static void apple_smc_rtkit_shmem_destroy(void *cookie, struct apple_rtkit_shmem *bfr)
> +{
> +	// no-op
> +}

Looks like .destroy() is checked before being called.

You can remove this.

> +static bool apple_smc_rtkit_recv_early(void *cookie, u8 endpoint, u64 message)
> +{
> +	struct apple_smc *smc = cookie;
> +
> +	if (endpoint != SMC_ENDPOINT) {
> +		dev_err(smc->dev, "Received message for unknown endpoint 0x%x\n", endpoint);
> +		return false;
> +	}
> +
> +	if (!smc->initialized) {
> +		int ret;
> +
> +		smc->shmem.iova = message;
> +		smc->shmem.size = SMC_SHMEM_SIZE;
> +		ret = apple_smc_rtkit_shmem_setup(smc, &smc->shmem);
> +		if (ret < 0)
> +			dev_err(smc->dev, "Failed to initialize shared memory\n");

We shouldn't submit an error then carry on.

If this is not catastrophic, it should be a warn().

> +		else
> +			smc->alive = true;
> +		smc->initialized = true;
> +		complete(&smc->init_done);
> +	} else if (FIELD_GET(SMC_MSG, message) == SMC_MSG_NOTIFICATION) {
> +		/* Handle these in the RTKit worker thread */
> +		return false;
> +	} else {
> +		smc->cmd_ret = message;
> +		if (smc->atomic_pending)
> +			smc->atomic_pending = false;
> +		else
> +			complete(&smc->cmd_done);
> +	}
> +
> +	return true;
> +}
> +
> +static void apple_smc_rtkit_recv(void *cookie, u8 endpoint, u64 message)
> +{
> +	struct apple_smc *smc = cookie;
> +	uint32_t event;
> +
> +	if (endpoint != SMC_ENDPOINT) {
> +		dev_err(smc->dev, "Received message for unknown endpoint 0x%x\n", endpoint);
> +		return;

This error is not being propagated?

If there are no repercussions, this too should be a warn(), or better
still, pass the error back and do something about it.

> +	}
> +
> +	if (FIELD_GET(SMC_MSG, message) != SMC_MSG_NOTIFICATION) {
> +		dev_err(smc->dev, "Received unknown message from worker: 0x%llx\n", message);
> +		return;
> +	}
> +
> +	event = FIELD_GET(SMC_DATA, message);
> +	dev_dbg(smc->dev, "Event: 0x%08x\n", event);

How useful are these debug messages post-development?

> +	blocking_notifier_call_chain(&smc->event_handlers, event, NULL);
> +}
> +
> +static const struct apple_rtkit_ops apple_smc_rtkit_ops = {
> +	.crashed = apple_smc_rtkit_crashed,
> +	.recv_message = apple_smc_rtkit_recv,
> +	.recv_message_early = apple_smc_rtkit_recv_early,
> +	.shmem_setup = apple_smc_rtkit_shmem_setup,
> +	.shmem_destroy = apple_smc_rtkit_shmem_destroy,
> +};
> +
> +static int apple_smc_platform_probe(struct platform_device *pdev)

Drop the platform part.

> +{
> +	int ret;
> +	u32 count;
> +	struct apple_smc *smc;
> +	struct device *dev = &pdev->dev;

Reverse these please.

Largest / longest at the top - "reverse Christmas-tree".

> +	smc = devm_kzalloc(dev, sizeof(*smc), GFP_KERNEL);
> +	if (!smc)
> +		return -ENOMEM;
> +
> +	smc->dev = &pdev->dev;
> +	smc->sram = platform_get_resource_byname(pdev, IORESOURCE_MEM, "sram");
> +	if (!smc->sram)
> +		return dev_err_probe(dev, EIO,
> +				     "No SRAM region");
> +
> +	smc->sram_base = devm_ioremap_resource(dev, smc->sram);
> +	if (IS_ERR(smc->sram_base))
> +		return dev_err_probe(dev, PTR_ERR(smc->sram_base),
> +				     "Failed to map SRAM region");

All of the above usually gets condensed into:

	devm_platform_ioremap_resource_byname()

> +	smc->rtk =
> +		devm_apple_rtkit_init(dev, smc, NULL, 0, &apple_smc_rtkit_ops);
> +	if (IS_ERR(smc->rtk))
> +		return dev_err_probe(dev, PTR_ERR(smc->rtk),
> +				     "Failed to initialize RTKit");
> +
> +	ret = apple_rtkit_wake(smc->rtk);
> +	if (ret != 0)

Just (ret) will do - throughout.

> +		return dev_err_probe(dev, ret,
> +				     "Failed to wake up SMC");
> +
> +	ret = apple_rtkit_start_ep(smc->rtk, SMC_ENDPOINT);
> +	if (ret != 0) {
> +		ret = dev_err_probe(dev, ret,
> +				     "Failed to start SMC endpoint");
> +		goto cleanup;
> +	}
> +
> +	init_completion(&smc->init_done);
> +	init_completion(&smc->cmd_done);
> +
> +	ret = apple_rtkit_send_message(smc->rtk, SMC_ENDPOINT,
> +				       FIELD_PREP(SMC_MSG, SMC_MSG_INITIALIZE), NULL, false);
> +	if (ret < 0) {
> +		ret = dev_err_probe(dev, ret, "Failed to send init message");
> +		goto cleanup;
> +	}
> +
> +	if (wait_for_completion_timeout(&smc->init_done,
> +					msecs_to_jiffies(SMC_RECV_TIMEOUT)) == 0) {
> +		ret = -ETIMEDOUT;
> +		dev_err(dev, "Timed out initializing SMC");
> +		goto cleanup;
> +	}
> +
> +	if (!smc->alive) {
> +		ret = -EIO;
> +		goto cleanup;
> +	}
> +
> +	dev_set_drvdata(&pdev->dev, smc);
> +	BLOCKING_INIT_NOTIFIER_HEAD(&smc->event_handlers);
> +
> +	ret = apple_smc_read_u32(smc, SMC_KEY(#KEY), &count);
> +	if (ret) {
> +		ret = dev_err_probe(smc->dev, ret, "Failed to get key count");
> +		goto cleanup;
> +	}
> +	smc->key_count = be32_to_cpu(count);
> +
> +	ret = apple_smc_get_key_by_index(smc, 0, &smc->first_key);
> +	if (ret) {
> +		ret = dev_err_probe(smc->dev, ret, "Failed to get first key");
> +		goto cleanup;
> +	}
> +
> +	ret = apple_smc_get_key_by_index(smc, smc->key_count - 1, &smc->last_key);
> +	if (ret) {
> +		ret = dev_err_probe(smc->dev, ret, "Failed to get last key");
> +		goto cleanup;
> +	}
> +
> +	/* Enable notifications */
> +	apple_smc_write_flag(smc, SMC_KEY(NTAP), true);
> +
> +	dev_info(smc->dev, "Initialized (%d keys %p4ch ... %p4ch)\n",
> +		 smc->key_count, &smc->first_key, &smc->last_key);
> +
> +	ret = mfd_add_devices(smc->dev, -1,

devm_*?

PLATFORM_DEVID_NONE

> +			      apple_smc_devs, ARRAY_SIZE(apple_smc_devs),
> +			      NULL, 0, NULL);
> +	if (ret) {
> +		ret = dev_err_probe(smc->dev, ret, "Subdevice initialization failed");

"Failed to register sub-devices"

> +		goto cleanup;
> +	}
> +
> +	return 0;
> +
> +cleanup:
> +	/* Try to shut down RTKit, if it's not completely wedged */
> +	if (apple_rtkit_is_running(smc->rtk))
> +		apple_rtkit_quiesce(smc->rtk);
> +
> +	return ret;
> +}
> +
> +static void apple_smc_platform_remove(struct platform_device *pdev)
> +{
> +	struct apple_smc *smc = platform_get_drvdata(pdev);
> +
> +	mfd_remove_devices(smc->dev);
> +
> +	/* Disable notifications */
> +	apple_smc_write_flag(smc, SMC_KEY(NTAP), false);
> +
> +	/* Shut down SMC firmware */
> +	if (apple_rtkit_is_running(smc->rtk))
> +		apple_rtkit_quiesce(smc->rtk);
> +}
> +
> +static const struct of_device_id apple_smc_of_match[] = {
> +	{ .compatible = "apple,smc" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, apple_smc_of_match);
> +
> +static struct platform_driver apple_smc_driver = {
> +	.driver = {
> +		.name = "mfd-macsmc",
> +		.owner = THIS_MODULE,

This is handed by the core, you can remove it.

> +		.of_match_table = apple_smc_of_match,
> +	},
> +	.probe = apple_smc_platform_probe,
> +	.remove = apple_smc_platform_remove,
> +};
> +module_platform_driver(apple_smc_driver);
> +
> +MODULE_AUTHOR("Hector Martin <marcan@marcan.st>");
> +MODULE_AUTHOR("Sven Peter <sven@svenpeter.dev>");
> +MODULE_LICENSE("Dual MIT/GPL");
> +MODULE_DESCRIPTION("Apple SMC driver");
> diff --git a/include/linux/mfd/macsmc.h b/include/linux/mfd/macsmc.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..0b24b8e44dcb4564b50e6d2145f23f23321139c1
> --- /dev/null
> +++ b/include/linux/mfd/macsmc.h
> @@ -0,0 +1,337 @@
> +/* SPDX-License-Identifier: GPL-2.0-only OR MIT */
> +/*
> + * Apple SMC (System Management Controller) core definitions
> + *
> + * Copyright (C) The Asahi Linux Contributors
> + */
> +
> +#ifndef _LINUX_MFD_MACSMC_H
> +#define _LINUX_MFD_MACSMC_H
> +
> +#include <linux/soc/apple/rtkit.h>
> +
> +/**
> + * typedef smc_key - Alias for u32 to be used for SMC keys
> + *
> + * SMC keys are 32bit integers containing packed ASCII characters in natural
> + * integer order, i.e. 0xAABBCCDD, which represent the FourCC ABCD.
> + * The SMC driver is designed with this assumption and ensures the right
> + * endianness is used when these are stored to memory and sent to or received
> + * from the actual SMC firmware (which can be done in either shared memory or
> + * as 64bit mailbox message on Apple Silicon).
> + * Internally, SMC stores these keys in a table sorted lexicographically and
> + * allows resolving an index into this table to the corresponding SMC key.
> + * Thus, storing keys as u32 is very convenient as it allows to e.g. use
> + * normal comparison operators which directly map to the natural order used
> + * by SMC firmware.
> + *
> + * This simple type alias is introduced to allow easy recognition of SMC key
> + * variables and arguments.
> + */
> +typedef u32 smc_key;
> +
> +/**
> + * SMC_KEY - Convert FourCC SMC keys in source code to smc_key
> + *
> + * This macro can be used to easily define FourCC SMC keys in source code
> + * and convert these to u32 / smc_key, e.g. SMC_KEY(NTAP) will expand to
> + * 0x4e544150.
> + */
> +#define SMC_KEY(s) (smc_key)(_SMC_KEY(#s))
> +#define _SMC_KEY(s) (((s)[0] << 24) | ((s)[1] << 16) | ((s)[2] << 8) | (s)[3])
> +
> +#define APPLE_SMC_READABLE BIT(7)
> +#define APPLE_SMC_WRITABLE BIT(6)
> +#define APPLE_SMC_FUNCTION BIT(4)
> +
> +/**
> + * struct apple_smc_key_info - information for a SMC key as returned by SMC
> + * @size: size of the buffer associated with this key
> + * @type_code: FourCC code indicating the type for this key.
> + *             Known types:
> + *              ch8*: ASCII string
> + *              flag: boolean, 1 or 0
> + *              flt: 32-bit single-precision IEEE 754 float
> + *              hex: binary data
> + *              ioft: 64bit unsigned fixed-point intger (48.16)
> + *              si8, ui8, si16, ui16, si32, ui32, si64, ui64: signed/unsigned 8-/16-/32-/64-bit integer
> + * @flags: bitfield encoding flags (APPLE_SMC_{READABLE,WRITABLE,FUNCTION})
> + */
> +struct apple_smc_key_info {
> +	u8 size;
> +	u32 type_code;
> +	u8 flags;
> +};
> +
> +/**
> + * struct apple_smc
> + * @dev: underlying device struct for the physical backend device
> + * @key_count: number of available SMC keys
> + * @first_key: first valid SMC key
> + * @last_key: last valid SMC key
> + * @event_handlers: notifier call chain for events received from SMC
> + * @rtk: pointer to Apple RTKit instance
> + * @init_done: completion for initialization
> + * @initialized: flag indicating if SMC is initialized
> + * @alive: flag indicating if SMC is alive
> + * @sram: pointer to SRAM resource
> + * @sram_base: SRAM base address
> + * @shmem: RTKit shared memory structure for SRAM
> + * @msg_id: current message id for commands, will be incremented for each command
> + * @atomic_mode: flag set when atomic mode is entered
> + * @atomic_pending: flag indicating pending atomic command
> + * @cmd_done: completion for command execution in non-atomic mode
> + * @cmd_ret: return value from SMC for last command
> + * @mutex: mutex for non-atomic mode
> + * @lock: spinlock for atomic mode
> + */

Make sure you enable W=1 when compiling and fix any fallout.

> +struct apple_smc {
> +	struct device *dev;
> +
> +	u32 key_count;
> +	smc_key first_key;
> +	smc_key last_key;
> +
> +	struct blocking_notifier_head event_handlers;
> +
> +	struct apple_rtkit *rtk;
> +
> +	struct completion init_done;
> +	bool initialized;
> +	bool alive;
> +
> +	struct resource *sram;
> +	void __iomem *sram_base;
> +	struct apple_rtkit_shmem shmem;
> +
> +	unsigned int msg_id;
> +
> +	bool atomic_mode;
> +	bool atomic_pending;
> +	struct completion cmd_done;
> +	u64 cmd_ret;
> +
> +	struct mutex mutex;
> +	spinlock_t lock;
> +};
> +
> +/**
> + * apple_smc_read - read size bytes from given SMC key into buf
> + * @smc: pointer to apple_smc struct
> + * @key: smc_key to be read
> + * @buf: buffer into which size bytes of data will be read from SMC
> + * @size: number of bytes to be read into buf
> + *
> + * Return: Zero on success, negative errno on error
> + */
> +int apple_smc_read(struct apple_smc *smc, smc_key key, void *buf, size_t size);
> +
> +/**
> + * apple_smc_write - write size bytes into given SMC key from buf
> + * @smc: pointer to apple_smc struct
> + * @key: smc_key data will be written to
> + * @buf: buffer from which size bytes of data will be written to SMC
> + * @size: number of bytes to be written
> + *
> + * Return: Zero on success, negative errno on error
> + */
> +int apple_smc_write(struct apple_smc *smc, smc_key key, void *buf, size_t size);
> +
> +/**
> + * apple_smc_enter_atomic - enter atomic mode to be able to use apple_smc_write_atomic
> + * @smc: pointer to apple_smc struct
> + *
> + * This function switches the SMC backend to atomic mode which allows the
> + * use of apple_smc_write_atomic while disabling *all* other functions.
> + * This is only used for shutdown/reboot which requires writing to a SMC
> + * key from atomic context.
> + *
> + * Return: Zero on success, negative errno on error
> + */
> +int apple_smc_enter_atomic(struct apple_smc *smc);
> +
> +/**
> + * apple_smc_write_atomic - write size bytes into given SMC key from buf without sleeping
> + * @smc: pointer to apple_smc struct
> + * @key: smc_key data will be written to
> + * @buf: buffer from which size bytes of data will be written to SMC
> + * @size: number of bytes to be written
> + *
> + * Note that this function will fail if apple_smc_enter_atomic hasn't been
> + * called before.
> + *
> + * Return: Zero on success, negative errno on error
> + */
> +int apple_smc_write_atomic(struct apple_smc *smc, smc_key key, void *buf, size_t size);
> +
> +/**
> + * apple_smc_rw - write and then read using the given SMC key
> + * @smc: pointer to apple_smc struct
> + * @key: smc_key data will be written to
> + * @wbuf: buffer from which size bytes of data will be written to SMC
> + * @wsize: number of bytes to be written
> + * @rbuf: buffer to which size bytes of data will be read from SMC
> + * @rsize: number of bytes to be read
> + *
> + * Return: Zero on success, negative errno on error
> + */
> +int apple_smc_rw(struct apple_smc *smc, smc_key key, void *wbuf, size_t wsize,
> +		 void *rbuf, size_t rsize);
> +
> +/**
> + * apple_smc_get_key_by_index - given an index return the corresponding SMC key
> + * @smc: pointer to apple_smc struct
> + * @index: index to be resolved
> + * @key: buffer for SMC key to be returned
> + *
> + * Return: Zero on success, negative errno on error
> + */
> +int apple_smc_get_key_by_index(struct apple_smc *smc, int index, smc_key *key);
> +
> +/**
> + * apple_smc_get_key_info - get key information from SMC
> + * @smc: pointer to apple_smc struct
> + * @key: key to acquire information for
> + * @info: pointer to struct apple_smc_key_info which will be filled
> + *
> + * Return: Zero on success, negative errno on error
> + */
> +int apple_smc_get_key_info(struct apple_smc *smc, smc_key key, struct apple_smc_key_info *info);
> +
> +/**
> + * apple_smc_find_first_key_index - find index of first SMC key bigger or equal to key
> + * @smc: pointer to apple_smc struct
> + * @key: smc_key to be found
> + *
> + * SMC keys are represented using either FourCC (which is stored as
> + * uint32_t / smc_key in this driver) or an index into the table of available
> + * keys which is sorted lexicographically.
> + * This function takes a FourCC key and uses binary search to find the
> + * index of the first SMC key that is lexicographically equal or bigger than the
> + * given input.
> + * This is required for e.g. the GPIO driver: GPIO keys start with gP
> + * and the driver has to find the first such key (by calling this function with
> + * key = SMC_KEY(gP00)) to be able to enumerate and register all available GPIOs
> + * at probe time.
> + *
> + * Return: Index of the first smc key that's bigger or equal to the given key.
> + *
> + * If the key is smaller than the first available key zero will be returned.
> + * If the key is bigger than the last available key smc->key_count (i.e. an out
> + * of bounds key) will be returned.
> + */
> +int apple_smc_find_first_key_index(struct apple_smc *smc, smc_key key);
> +
> +/**
> + * apple_smc_key_exists - check if the given SMC key exists
> + * @smc: pointer to apple_smc struct
> + * @key: smc_key to be checked
> + */
> +static inline bool apple_smc_key_exists(struct apple_smc *smc, smc_key key)
> +{
> +	return apple_smc_get_key_info(smc, key, NULL) >= 0;
> +}
> +
> +#define APPLE_SMC_TYPE_OPS(type) \
> +	static inline int apple_smc_read_##type(struct apple_smc *smc, smc_key key, type *p) \
> +	{ \
> +		int ret = apple_smc_read(smc, key, p, sizeof(*p)); \
> +		return (ret < 0) ? ret : ((ret != sizeof(*p)) ? -EINVAL : 0); \
> +	} \
> +	static inline int apple_smc_write_##type(struct apple_smc *smc, smc_key key, type p) \
> +	{ \
> +		return apple_smc_write(smc, key, &p, sizeof(p)); \
> +	} \
> +	static inline int apple_smc_write_##type##_atomic(struct apple_smc *smc, smc_key key, type p) \
> +	{ \
> +		return apple_smc_write_atomic(smc, key, &p, sizeof(p)); \
> +	} \
> +	static inline int apple_smc_rw_##type(struct apple_smc *smc, smc_key key, \
> +					      type w, type *r) \
> +	{ \
> +		int ret = apple_smc_rw(smc, key, &w, sizeof(w), r, sizeof(*r)); \
> +		return (ret < 0) ? ret : ((ret != sizeof(*r)) ? -EINVAL : 0); \
> +	}
> +
> +APPLE_SMC_TYPE_OPS(u64)
> +APPLE_SMC_TYPE_OPS(u32)
> +APPLE_SMC_TYPE_OPS(u16)
> +APPLE_SMC_TYPE_OPS(u8)
> +APPLE_SMC_TYPE_OPS(s64)
> +APPLE_SMC_TYPE_OPS(s32)
> +APPLE_SMC_TYPE_OPS(s16)
> +APPLE_SMC_TYPE_OPS(s8)
> +
> +static inline int apple_smc_read_flag(struct apple_smc *smc, smc_key key, bool *flag)
> +{
> +	u8 val;
> +	int ret = apple_smc_read_u8(smc, key, &val);
> +
> +	if (ret < 0)
> +		return ret;
> +
> +	*flag = val ? true : false;
> +	return ret;
> +}
> +
> +static inline int apple_smc_write_flag(struct apple_smc *smc, smc_key key, bool state)
> +{
> +	return apple_smc_write_u8(smc, key, state ? 1 : 0);
> +}
> +
> +static inline int apple_smc_write_flag_atomic(struct apple_smc *smc, smc_key key, bool state)
> +{
> +	return apple_smc_write_u8_atomic(smc, key, state ? 1 : 0);
> +}
> +
> +/**
> + * apple_smc_read_f32_scaled - read a float value from SMC and scale to a regular integer
> + * @smc: pointer to apple_smc struct
> + * @key: key to be read
> + * @p: pointer to integer that will be overwritten with the read value
> + * @scale: target scale
> + *
> + * Read a float value from the given SMC key and scale it to the given order
> + * of magnitude. If the value is smaller than the given scale zero will be
> + * used. If the value overflows an integer at the given scale p will be set to
> + * U64_MAX.
> + *
> + * This is useful for e.g. reading power consumption, which is reported by SMC
> + * in Watt (W) as a floating point number, and scale it to uW like so:
> + *
> + *     apple_smc_read_f32_scaled(smc, SMC_KEY(PSTR), &power_uW, 1000000);
> + *
> + * At that scale, noise starts to dominate the power measurements anyway and
> + * there's no reason to deal with floats.
> + *
> + * Return: Zero on success, negative errno on error
> + */
> +int apple_smc_read_f32_scaled(struct apple_smc *smc, smc_key key, int *p, int scale);
> +
> +/**
> + * apple_smc_read_ioft_scaled - read a 48.16 fixed point from SMC and scale to a regular integer
> + * @smc: pointer to apple_smc struct
> + * @key: key to be read
> + * @p: pointer to integer that will be overwritten with the read value
> + * @scale: target scale
> + *
> + * Read a 48.16 fixed point value from the given SMC key and scale it to the
> + * given order of magnitude. If the value is smaller than the given scale zero
> + * will be used. If the value overflows an integer at the given scale p will be
> + * set to U64_MAX.
> + *
> + * This is useful for e.g. reading temperature, which is reported by SMC in
> + * degrees as a 48.16 fixed point number, and scale it to milli-degrees Celsius
> + * like so:
> + *
> + *     apple_smc_read_ioft_scaled(smc, SMC_KEY(TR0Z), &temperature_mC, 1000);
> + *
> + * Reporting temperature with more precision runs into measurements errors and
> + * isn't very useful such that using a simple integer instead of fixed point
> + * numbers is reasonable.
> + *
> + * Return: Zero on success, negative errno on error
> + */
> +int apple_smc_read_ioft_scaled(struct apple_smc *smc, smc_key key, u64 *p, int scale);
> +
> +#endif
> 
> -- 
> 2.34.1
> 
> 

-- 
Lee Jones [李琼斯]

