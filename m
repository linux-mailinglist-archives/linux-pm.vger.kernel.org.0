Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76A7E423BE7
	for <lists+linux-pm@lfdr.de>; Wed,  6 Oct 2021 13:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238154AbhJFLFA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 Oct 2021 07:05:00 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:62814 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238149AbhJFLE4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 Oct 2021 07:04:56 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20211006110303euoutp018ee19ba2ee8173071b674175cb2f0b04~rbCIR8d9t1524915249euoutp01O
        for <linux-pm@vger.kernel.org>; Wed,  6 Oct 2021 11:03:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20211006110303euoutp018ee19ba2ee8173071b674175cb2f0b04~rbCIR8d9t1524915249euoutp01O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1633518183;
        bh=EWZNSjyeAkhWrjK/CcU8YLFBLbrxKulztH4LZsJE5Xg=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=AiFW/x7fjkI0Rfa54t04RsFm5sffc2LHlExWKlu3otdckRjPsQozR9/wBcZpnp/D4
         Ew7b8ZyuRXPG7c7QGQbX+KCHxrnAaGqPhAPS6bHElQxs7Rt4Nk6RRjZw/ZXYcQFInP
         yBb4gCwu7Iq4Yu/USPkWaduTpgy+FymhTxz7Yk5Q=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20211006110303eucas1p14d620b8c3998fa78cdfe5873c3b42de7~rbCH8nRC72803628036eucas1p1Y;
        Wed,  6 Oct 2021 11:03:03 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id F0.C5.42068.7628D516; Wed,  6
        Oct 2021 12:03:03 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20211006110301eucas1p18bc37b15f562b2ffb13195ff3196b3d0~rbCG5JV6E2804528045eucas1p1e;
        Wed,  6 Oct 2021 11:03:01 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20211006110301eusmtrp119846c22fd117a60bed28d263a457c6b~rbCG3onNL1857418574eusmtrp1a;
        Wed,  6 Oct 2021 11:03:01 +0000 (GMT)
X-AuditID: cbfec7f4-c71ff7000002a454-cc-615d82673473
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id F5.47.20981.5628D516; Wed,  6
        Oct 2021 12:03:01 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20211006110300eusmtip26b9dcb7ea6ae38f85fe06832fb0373a9~rbCFvru_y1272512725eusmtip2E;
        Wed,  6 Oct 2021 11:03:00 +0000 (GMT)
Subject: Re: [PATCH v8 1/5] cpuidle: qcom_spm: Detach state machine from
 main SPM handling
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        bjorn.andersson@linaro.org
Cc:     agross@kernel.org, daniel.lezcano@linaro.org, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, phone-devel@vger.kernel.org,
        konrad.dybcio@somainline.org, marijn.suijten@somainline.org,
        martin.botka@somainline.org, jeffrey.l.hugo@gmail.com,
        jami.kettunen@somainline.org,
        ~postmarketos/upstreaming@lists.sr.ht, devicetree@vger.kernel.org,
        stephan@gerhold.net, robh@kernel.org, bartosz.dudziak@snejp.pl
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <86e3e09f-a8d7-3dff-3fc6-ddd7d30c5d78@samsung.com>
Date:   Wed, 6 Oct 2021 13:02:59 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0)
        Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210729155609.608159-2-angelogioacchino.delregno@somainline.org>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJKsWRmVeSWpSXmKPExsWy7djP87rpTbGJBou7WSzOPf7NYjHzZCuT
        xdytGhan979jsZj3WdZi/pFzrBYtu7vYLNqWf2O22H+nld1i4v6z7BaXd81hs/jce4TR4vJG
        fosta1ewWSz4Y2dx5vQlVov/e3awW9yYa2Kx+ftfRgdhj7YF9h47Z91l99i0qpPN4861PWwe
        /++sZffYcrWdxaNtq6NH51lGj8+b5AI4o7hsUlJzMstSi/TtErgypk3/xl7Qe4CxYu/ja0wN
        jM9mMXYxcnJICJhIHD1yjqmLkYtDSGAFo0TTt1MsEM4XRonfr29DZT4zSmzceJCti5EDrOXZ
        QyGI+HJGifnLO1khnI+MEnsurQKbKywQI/GiZR+YLSKQLrH1Zw/YWGaBW8wSE9bvAEuwCRhK
        dL3tYgOxeQXsJHbs2MUEYrMIqEjMnv2FGcQWFUiWmPa3iRmiRlDi5MwnLCA2p4C/xKn1z8Bs
        ZgF5ie1v5zBD2OISt57MBztbQuAcp8TLq5OYIT51kXjy8w07hC0s8er4FihbRuL0ZIjrJASa
        GSUenlvLDuH0MEpcbpoBDSdriTvnfoEDgFlAU2L9Ln2IsKPEjZ0d7JBw4ZO48VYQ4gg+iUnb
        pjNDhHklOtqEIKrVJGYdXwe39uCFS8wTGJVmIXltFpJ3ZiF5ZxbC3gWMLKsYxVNLi3PTU4uN
        8lLL9YoTc4tL89L1kvNzNzECU+Ppf8e/7GBc/uqj3iFGJg7GQ4wSHMxKIrz59rGJQrwpiZVV
        qUX58UWlOanFhxilOViUxHmTtqyJFxJITyxJzU5NLUgtgskycXBKNTB13BLLePp895QeG8nN
        TxIqZgjf8n3FOkv38rKaLt31bTz2s4qmblDptZ8/9erOmZ2/3/149y8+TC+tdYN7vvx1G3u5
        wxWZ5zQTWkM9Wx3rDDWedoZYXLcXEXl4bdXM1MK/uexyu66zWT72+2J50T7ueGJ3NHNF2fol
        N7c8esW6cK6eTOrVe/1x31QsJ4Sty0p+EbHGrMfI7q6R+dqk3K/SjNoTr6t2XeBT0686vfHj
        CY6p5VPSuYwvs+8xMl2rwxd+2V95ylnXtosxT3Pc+29NXRnbM+WzxCV3dq7eMzxu/0trNR+v
        sNBbzNhoZRvxJyQ1sTb1V2FtzVE1ucqJM7T+vubd5dviG/H59XHVhUosxRmJhlrMRcWJACzt
        /0/8AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNIsWRmVeSWpSXmKPExsVy+t/xe7qpTbGJBt1H9S3OPf7NYjHzZCuT
        xdytGhan979jsZj3WdZi/pFzrBYtu7vYLNqWf2O22H+nld1i4v6z7BaXd81hs/jce4TR4vJG
        fosta1ewWSz4Y2dx5vQlVov/e3awW9yYa2Kx+ftfRgdhj7YF9h47Z91l99i0qpPN4861PWwe
        /++sZffYcrWdxaNtq6NH51lGj8+b5AI4o/RsivJLS1IVMvKLS2yVog0tjPQMLS30jEws9QyN
        zWOtjEyV9O1sUlJzMstSi/TtEvQypk3/xl7Qe4CxYu/ja0wNjM9mMXYxcnBICJhIPHso1MXI
        xSEksJRR4trEmexdjJxAcRmJk9MaWCFsYYk/17rYIIreM0psmz0BrEhYIEbi4bR5jCC2iEC6
        xKQbB8CKmAVuMUvsedbPCNExmVHi4C+QDCcHm4ChRNfbLjCbV8BOYseOXUwgNouAisTs2V+Y
        QWxRgWSJt6+/M0HUCEqcnPmEBcTmFPCXOLX+GZjNLGAmMW/zQ2YIW15i+9s5ULa4xK0n85km
        MArNQtI+C0nLLCQts5C0LGBkWcUoklpanJueW2ykV5yYW1yal66XnJ+7iRGYCrYd+7llB+PK
        Vx/1DjEycTAeYpTgYFYS4c23j00U4k1JrKxKLcqPLyrNSS0+xGgK9M9EZinR5HxgMsoriTc0
        MzA1NDGzNDC1NDNWEuc1ObImXkggPbEkNTs1tSC1CKaPiYNTqoFp51Zh3pbCIOc5K/4deHZv
        Yp2f2MVJnbZFl7ILLi8I7zB48M2mrNv0ErNadejZtft82kwD3prbxjNYMjV88Oo5skXs2473
        dX+mSVTPe/FkUbaRTnbrOpfHX5oXBjzz3h8llKqcff5qoKnpW/V5YZO0Dr8R9mfR7OdznrJI
        5lLN7tVOq+8qCTE5RaY1reR/J9B9v1xrZmFWDI9ngP0UGQGPWxvWLj6cE1/NcnzT3QUzKk5Z
        bqp9eD3Mt1zEvJ/r1CuO0i//83dEWVtx37u6VuKaxDTeiT9aPbaUCD/btfmAuFq26a3jrAlv
        upvnSFuUZ50s17g8xVP9AMPCoJ3pOyqt+mNvcu76u+tNmE2n+BwlluKMREMt5qLiRAAO0wy8
        jgMAAA==
X-CMS-MailID: 20211006110301eucas1p18bc37b15f562b2ffb13195ff3196b3d0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20211006110301eucas1p18bc37b15f562b2ffb13195ff3196b3d0
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20211006110301eucas1p18bc37b15f562b2ffb13195ff3196b3d0
References: <20210729155609.608159-1-angelogioacchino.delregno@somainline.org>
        <20210729155609.608159-2-angelogioacchino.delregno@somainline.org>
        <CGME20211006110301eucas1p18bc37b15f562b2ffb13195ff3196b3d0@eucas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 29.07.2021 17:56, AngeloGioacchino Del Regno wrote:
> In commit a871be6b8eee ("cpuidle: Convert Qualcomm SPM driver to a generic
> CPUidle driver") the SPM driver has been converted to a
> generic CPUidle driver: that was mainly made to simplify the
> driver and that was a great accomplishment;
> Though, at that time, this driver was only applicable to ARM 32-bit SoCs,
> lacking logic about the handling of newer generation SAW.
>
> In preparation for the enablement of SPM features on AArch64/ARM64,
> split the cpuidle-qcom-spm driver in two: the CPUIdle related
> state machine (currently used only on ARM SoCs) stays there, while
> the SPM communication handling lands back in soc/qcom/spm.c and
> also making sure to not discard the simplifications that were
> introduced in the aforementioned commit.
>
> Since now the "two drivers" are split, the SCM dependency in the
> main SPM handling is gone and for this reason it was also possible
> to move the SPM initialization early: this will also make sure that
> whenever the SAW CPUIdle driver is getting initialized, the SPM
> driver will be ready to do the job.
>
> Please note that the anticipation of the SPM initialization was
> also done to optimize the boot times on platforms that have their
> CPU/L2 idle states managed by other means (such as PSCI), while
> needing SAW initialization for other purposes, like AVS control.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> Reviewed-by: Stephan Gerhold <stephan@gerhold.net>
> Tested-by: Stephan Gerhold <stephan@gerhold.net>

This patch landed recently in linux-next as commit 60f3692b5f0b 
("cpuidle: qcom_spm: Detach state machine from main SPM handling"). It 
looks that it was not tested on non-qcom boards, because it 
unconditionally registers 'qcom-spm-cpuidle' on all boards, what is a 
bit annoying, especially when kernel is compiled from multi_v7_defconfig:

root@target:~# uname -a
Linux target 5.15.0-rc4-next-20211006 #3971 SMP Wed Oct 6 12:59:45 CEST 
2021 armv7l GNU/Linux
root@target:~# strings /proc/device-tree/compatible
hardkernel,odroid-xu4
samsung,exynos5800
samsung,exynos5
root@target:~# cat /sys/kernel/debug/devices_deferred
qcom-spm-cpuidle
root@target:~#

qcom_spm_cpuidle_init() in drivers/cpuidle/cpuidle-qcom-spm.c should exit early if running on non-compatible board to be really multi-arch friendly.

> ---
>   drivers/cpuidle/Kconfig.arm        |   1 +
>   drivers/cpuidle/cpuidle-qcom-spm.c | 318 ++++++-----------------------
>   drivers/soc/qcom/Kconfig           |   9 +
>   drivers/soc/qcom/Makefile          |   1 +
>   drivers/soc/qcom/spm.c             | 212 +++++++++++++++++++
>   include/soc/qcom/spm.h             |  41 ++++
>   6 files changed, 332 insertions(+), 250 deletions(-)
>   create mode 100644 drivers/soc/qcom/spm.c
>   create mode 100644 include/soc/qcom/spm.h
>
> diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.arm
> index 334f83e56120..8a02213c8391 100644
> --- a/drivers/cpuidle/Kconfig.arm
> +++ b/drivers/cpuidle/Kconfig.arm
> @@ -112,6 +112,7 @@ config ARM_QCOM_SPM_CPUIDLE
>   	select CPU_IDLE_MULTIPLE_DRIVERS
>   	select DT_IDLE_STATES
>   	select QCOM_SCM
> +	select QCOM_SPM
>   	help
>   	  Select this to enable cpuidle for Qualcomm processors.
>   	  The Subsystem Power Manager (SPM) controls low power modes for the
> diff --git a/drivers/cpuidle/cpuidle-qcom-spm.c b/drivers/cpuidle/cpuidle-qcom-spm.c
> index c0e7971da2da..01e77913a414 100644
> --- a/drivers/cpuidle/cpuidle-qcom-spm.c
> +++ b/drivers/cpuidle/cpuidle-qcom-spm.c
> @@ -18,158 +18,18 @@
>   #include <linux/cpuidle.h>
>   #include <linux/cpu_pm.h>
>   #include <linux/qcom_scm.h>
> +#include <soc/qcom/spm.h>
>   
>   #include <asm/proc-fns.h>
>   #include <asm/suspend.h>
>   
>   #include "dt_idle_states.h"
>   
> -#define MAX_PMIC_DATA		2
> -#define MAX_SEQ_DATA		64
> -#define SPM_CTL_INDEX		0x7f
> -#define SPM_CTL_INDEX_SHIFT	4
> -#define SPM_CTL_EN		BIT(0)
> -
> -enum pm_sleep_mode {
> -	PM_SLEEP_MODE_STBY,
> -	PM_SLEEP_MODE_RET,
> -	PM_SLEEP_MODE_SPC,
> -	PM_SLEEP_MODE_PC,
> -	PM_SLEEP_MODE_NR,
> -};
> -
> -enum spm_reg {
> -	SPM_REG_CFG,
> -	SPM_REG_SPM_CTL,
> -	SPM_REG_DLY,
> -	SPM_REG_PMIC_DLY,
> -	SPM_REG_PMIC_DATA_0,
> -	SPM_REG_PMIC_DATA_1,
> -	SPM_REG_VCTL,
> -	SPM_REG_SEQ_ENTRY,
> -	SPM_REG_SPM_STS,
> -	SPM_REG_PMIC_STS,
> -	SPM_REG_NR,
> -};
> -
> -struct spm_reg_data {
> -	const u8 *reg_offset;
> -	u32 spm_cfg;
> -	u32 spm_dly;
> -	u32 pmic_dly;
> -	u32 pmic_data[MAX_PMIC_DATA];
> -	u8 seq[MAX_SEQ_DATA];
> -	u8 start_index[PM_SLEEP_MODE_NR];
> -};
> -
> -struct spm_driver_data {
> +struct cpuidle_qcom_spm_data {
>   	struct cpuidle_driver cpuidle_driver;
> -	void __iomem *reg_base;
> -	const struct spm_reg_data *reg_data;
> -};
> -
> -static const u8 spm_reg_offset_v2_1[SPM_REG_NR] = {
> -	[SPM_REG_CFG]		= 0x08,
> -	[SPM_REG_SPM_CTL]	= 0x30,
> -	[SPM_REG_DLY]		= 0x34,
> -	[SPM_REG_SEQ_ENTRY]	= 0x80,
> -};
> -
> -/* SPM register data for 8974, 8084 */
> -static const struct spm_reg_data spm_reg_8974_8084_cpu  = {
> -	.reg_offset = spm_reg_offset_v2_1,
> -	.spm_cfg = 0x1,
> -	.spm_dly = 0x3C102800,
> -	.seq = { 0x03, 0x0B, 0x0F, 0x00, 0x20, 0x80, 0x10, 0xE8, 0x5B, 0x03,
> -		0x3B, 0xE8, 0x5B, 0x82, 0x10, 0x0B, 0x30, 0x06, 0x26, 0x30,
> -		0x0F },
> -	.start_index[PM_SLEEP_MODE_STBY] = 0,
> -	.start_index[PM_SLEEP_MODE_SPC] = 3,
> +	struct spm_driver_data *spm;
>   };
>   
> -/* SPM register data for 8226 */
> -static const struct spm_reg_data spm_reg_8226_cpu  = {
> -	.reg_offset = spm_reg_offset_v2_1,
> -	.spm_cfg = 0x0,
> -	.spm_dly = 0x3C102800,
> -	.seq = { 0x60, 0x03, 0x60, 0x0B, 0x0F, 0x20, 0x10, 0x80, 0x30, 0x90,
> -		0x5B, 0x60, 0x03, 0x60, 0x3B, 0x76, 0x76, 0x0B, 0x94, 0x5B,
> -		0x80, 0x10, 0x26, 0x30, 0x0F },
> -	.start_index[PM_SLEEP_MODE_STBY] = 0,
> -	.start_index[PM_SLEEP_MODE_SPC] = 5,
> -};
> -
> -static const u8 spm_reg_offset_v1_1[SPM_REG_NR] = {
> -	[SPM_REG_CFG]		= 0x08,
> -	[SPM_REG_SPM_CTL]	= 0x20,
> -	[SPM_REG_PMIC_DLY]	= 0x24,
> -	[SPM_REG_PMIC_DATA_0]	= 0x28,
> -	[SPM_REG_PMIC_DATA_1]	= 0x2C,
> -	[SPM_REG_SEQ_ENTRY]	= 0x80,
> -};
> -
> -/* SPM register data for 8064 */
> -static const struct spm_reg_data spm_reg_8064_cpu = {
> -	.reg_offset = spm_reg_offset_v1_1,
> -	.spm_cfg = 0x1F,
> -	.pmic_dly = 0x02020004,
> -	.pmic_data[0] = 0x0084009C,
> -	.pmic_data[1] = 0x00A4001C,
> -	.seq = { 0x03, 0x0F, 0x00, 0x24, 0x54, 0x10, 0x09, 0x03, 0x01,
> -		0x10, 0x54, 0x30, 0x0C, 0x24, 0x30, 0x0F },
> -	.start_index[PM_SLEEP_MODE_STBY] = 0,
> -	.start_index[PM_SLEEP_MODE_SPC] = 2,
> -};
> -
> -static inline void spm_register_write(struct spm_driver_data *drv,
> -					enum spm_reg reg, u32 val)
> -{
> -	if (drv->reg_data->reg_offset[reg])
> -		writel_relaxed(val, drv->reg_base +
> -				drv->reg_data->reg_offset[reg]);
> -}
> -
> -/* Ensure a guaranteed write, before return */
> -static inline void spm_register_write_sync(struct spm_driver_data *drv,
> -					enum spm_reg reg, u32 val)
> -{
> -	u32 ret;
> -
> -	if (!drv->reg_data->reg_offset[reg])
> -		return;
> -
> -	do {
> -		writel_relaxed(val, drv->reg_base +
> -				drv->reg_data->reg_offset[reg]);
> -		ret = readl_relaxed(drv->reg_base +
> -				drv->reg_data->reg_offset[reg]);
> -		if (ret == val)
> -			break;
> -		cpu_relax();
> -	} while (1);
> -}
> -
> -static inline u32 spm_register_read(struct spm_driver_data *drv,
> -					enum spm_reg reg)
> -{
> -	return readl_relaxed(drv->reg_base + drv->reg_data->reg_offset[reg]);
> -}
> -
> -static void spm_set_low_power_mode(struct spm_driver_data *drv,
> -					enum pm_sleep_mode mode)
> -{
> -	u32 start_index;
> -	u32 ctl_val;
> -
> -	start_index = drv->reg_data->start_index[mode];
> -
> -	ctl_val = spm_register_read(drv, SPM_REG_SPM_CTL);
> -	ctl_val &= ~(SPM_CTL_INDEX << SPM_CTL_INDEX_SHIFT);
> -	ctl_val |= start_index << SPM_CTL_INDEX_SHIFT;
> -	ctl_val |= SPM_CTL_EN;
> -	spm_register_write_sync(drv, SPM_REG_SPM_CTL, ctl_val);
> -}
> -
>   static int qcom_pm_collapse(unsigned long int unused)
>   {
>   	qcom_scm_cpu_power_down(QCOM_SCM_CPU_PWR_DOWN_L2_ON);
> @@ -201,10 +61,10 @@ static int qcom_cpu_spc(struct spm_driver_data *drv)
>   static int spm_enter_idle_state(struct cpuidle_device *dev,
>   				struct cpuidle_driver *drv, int idx)
>   {
> -	struct spm_driver_data *data = container_of(drv, struct spm_driver_data,
> -						    cpuidle_driver);
> +	struct cpuidle_qcom_spm_data *data = container_of(drv, struct cpuidle_qcom_spm_data,
> +							  cpuidle_driver);
>   
> -	return CPU_PM_CPU_IDLE_ENTER_PARAM(qcom_cpu_spc, idx, data);
> +	return CPU_PM_CPU_IDLE_ENTER_PARAM(qcom_cpu_spc, idx, data->spm);
>   }
>   
>   static struct cpuidle_driver qcom_spm_idle_driver = {
> @@ -225,134 +85,92 @@ static const struct of_device_id qcom_idle_state_match[] = {
>   	{ },
>   };
>   
> -static int spm_cpuidle_init(struct cpuidle_driver *drv, int cpu)
> +static int spm_cpuidle_register(struct device *cpuidle_dev, int cpu)
>   {
> +	struct platform_device *pdev = NULL;
> +	struct device_node *cpu_node, *saw_node;
> +	struct cpuidle_qcom_spm_data *data = NULL;
>   	int ret;
>   
> -	memcpy(drv, &qcom_spm_idle_driver, sizeof(*drv));
> -	drv->cpumask = (struct cpumask *)cpumask_of(cpu);
> +	cpu_node = of_cpu_device_node_get(cpu);
> +	if (!cpu_node)
> +		return -ENODEV;
>   
> -	/* Parse idle states from device tree */
> -	ret = dt_init_idle_driver(drv, qcom_idle_state_match, 1);
> -	if (ret <= 0)
> -		return ret ? : -ENODEV;
> +	saw_node = of_parse_phandle(cpu_node, "qcom,saw", 0);
> +	if (!saw_node)
> +		return -ENODEV;
>   
> -	/* We have atleast one power down mode */
> -	return qcom_scm_set_warm_boot_addr(cpu_resume_arm, drv->cpumask);
> -}
> +	pdev = of_find_device_by_node(saw_node);
> +	of_node_put(saw_node);
> +	of_node_put(cpu_node);
> +	if (!pdev)
> +		return -ENODEV;
>   
> -static struct spm_driver_data *spm_get_drv(struct platform_device *pdev,
> -		int *spm_cpu)
> -{
> -	struct spm_driver_data *drv = NULL;
> -	struct device_node *cpu_node, *saw_node;
> -	int cpu;
> -	bool found = 0;
> +	data = devm_kzalloc(cpuidle_dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
>   
> -	for_each_possible_cpu(cpu) {
> -		cpu_node = of_cpu_device_node_get(cpu);
> -		if (!cpu_node)
> -			continue;
> -		saw_node = of_parse_phandle(cpu_node, "qcom,saw", 0);
> -		found = (saw_node == pdev->dev.of_node);
> -		of_node_put(saw_node);
> -		of_node_put(cpu_node);
> -		if (found)
> -			break;
> -	}
> +	data->spm = dev_get_drvdata(&pdev->dev);
> +	if (!data->spm)
> +		return -EINVAL;
>   
> -	if (found) {
> -		drv = devm_kzalloc(&pdev->dev, sizeof(*drv), GFP_KERNEL);
> -		if (drv)
> -			*spm_cpu = cpu;
> -	}
> +	data->cpuidle_driver = qcom_spm_idle_driver;
> +	data->cpuidle_driver.cpumask = (struct cpumask *)cpumask_of(cpu);
>   
> -	return drv;
> -}
> +	ret = dt_init_idle_driver(&data->cpuidle_driver,
> +				  qcom_idle_state_match, 1);
> +	if (ret <= 0)
> +		return ret ? : -ENODEV;
>   
> -static const struct of_device_id spm_match_table[] = {
> -	{ .compatible = "qcom,msm8226-saw2-v2.1-cpu",
> -	  .data = &spm_reg_8226_cpu },
> -	{ .compatible = "qcom,msm8974-saw2-v2.1-cpu",
> -	  .data = &spm_reg_8974_8084_cpu },
> -	{ .compatible = "qcom,apq8084-saw2-v2.1-cpu",
> -	  .data = &spm_reg_8974_8084_cpu },
> -	{ .compatible = "qcom,apq8064-saw2-v1.1-cpu",
> -	  .data = &spm_reg_8064_cpu },
> -	{ },
> -};
> +	ret = qcom_scm_set_warm_boot_addr(cpu_resume_arm, cpumask_of(cpu));
> +	if (ret)
> +		return ret;
> +
> +	return cpuidle_register(&data->cpuidle_driver, NULL);
> +}
>   
> -static int spm_dev_probe(struct platform_device *pdev)
> +static int spm_cpuidle_drv_probe(struct platform_device *pdev)
>   {
> -	struct spm_driver_data *drv;
> -	struct resource *res;
> -	const struct of_device_id *match_id;
> -	void __iomem *addr;
>   	int cpu, ret;
>   
>   	if (!qcom_scm_is_available())
>   		return -EPROBE_DEFER;
>   
> -	drv = spm_get_drv(pdev, &cpu);
> -	if (!drv)
> -		return -EINVAL;
> -	platform_set_drvdata(pdev, drv);
> +	for_each_possible_cpu(cpu) {
> +		ret = spm_cpuidle_register(&pdev->dev, cpu);
> +		if (ret && ret != -ENODEV) {
> +			dev_err(&pdev->dev,
> +				"Cannot register for CPU%d: %d\n", cpu, ret);
> +		}
> +	}
>   
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	drv->reg_base = devm_ioremap_resource(&pdev->dev, res);
> -	if (IS_ERR(drv->reg_base))
> -		return PTR_ERR(drv->reg_base);
> +	return 0;
> +}
>   
> -	match_id = of_match_node(spm_match_table, pdev->dev.of_node);
> -	if (!match_id)
> -		return -ENODEV;
> +static struct platform_driver spm_cpuidle_driver = {
> +	.probe = spm_cpuidle_drv_probe,
> +	.driver = {
> +		.name = "qcom-spm-cpuidle",
> +		.suppress_bind_attrs = true,
> +	},
> +};
>   
> -	drv->reg_data = match_id->data;
> +static int __init qcom_spm_cpuidle_init(void)
> +{
> +	struct platform_device *pdev;
> +	int ret;
>   
> -	ret = spm_cpuidle_init(&drv->cpuidle_driver, cpu);
> +	ret = platform_driver_register(&spm_cpuidle_driver);
>   	if (ret)
>   		return ret;
>   
> -	/* Write the SPM sequences first.. */
> -	addr = drv->reg_base + drv->reg_data->reg_offset[SPM_REG_SEQ_ENTRY];
> -	__iowrite32_copy(addr, drv->reg_data->seq,
> -			ARRAY_SIZE(drv->reg_data->seq) / 4);
> -
> -	/*
> -	 * ..and then the control registers.
> -	 * On some SoC if the control registers are written first and if the
> -	 * CPU was held in reset, the reset signal could trigger the SPM state
> -	 * machine, before the sequences are completely written.
> -	 */
> -	spm_register_write(drv, SPM_REG_CFG, drv->reg_data->spm_cfg);
> -	spm_register_write(drv, SPM_REG_DLY, drv->reg_data->spm_dly);
> -	spm_register_write(drv, SPM_REG_PMIC_DLY, drv->reg_data->pmic_dly);
> -	spm_register_write(drv, SPM_REG_PMIC_DATA_0,
> -				drv->reg_data->pmic_data[0]);
> -	spm_register_write(drv, SPM_REG_PMIC_DATA_1,
> -				drv->reg_data->pmic_data[1]);
> -
> -	/* Set up Standby as the default low power mode */
> -	spm_set_low_power_mode(drv, PM_SLEEP_MODE_STBY);
> -
> -	return cpuidle_register(&drv->cpuidle_driver, NULL);
> -}
> -
> -static int spm_dev_remove(struct platform_device *pdev)
> -{
> -	struct spm_driver_data *drv = platform_get_drvdata(pdev);
> +	pdev = platform_device_register_simple("qcom-spm-cpuidle",
> +					       -1, NULL, 0);
> +	if (IS_ERR(pdev)) {
> +		platform_driver_unregister(&spm_cpuidle_driver);
> +		return PTR_ERR(pdev);
> +	}
>   
> -	cpuidle_unregister(&drv->cpuidle_driver);
>   	return 0;
>   }
> -
> -static struct platform_driver spm_driver = {
> -	.probe = spm_dev_probe,
> -	.remove = spm_dev_remove,
> -	.driver = {
> -		.name = "saw",
> -		.of_match_table = spm_match_table,
> -	},
> -};
> -
> -builtin_platform_driver(spm_driver);
> +device_initcall(qcom_spm_cpuidle_init);
> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
> index 79b568f82a1c..fe3c486ae32d 100644
> --- a/drivers/soc/qcom/Kconfig
> +++ b/drivers/soc/qcom/Kconfig
> @@ -190,6 +190,15 @@ config QCOM_SOCINFO
>   	 Say yes here to support the Qualcomm socinfo driver, providing
>   	 information about the SoC to user space.
>   
> +config QCOM_SPM
> +	tristate "Qualcomm Subsystem Power Manager (SPM)"
> +	depends on ARCH_QCOM
> +	select QCOM_SCM
> +	help
> +	  Enable the support for the Qualcomm Subsystem Power Manager, used
> +	  to manage cores, L2 low power modes and to configure the internal
> +	  Adaptive Voltage Scaler parameters, where supported.
> +
>   config QCOM_WCNSS_CTRL
>   	tristate "Qualcomm WCNSS control driver"
>   	depends on ARCH_QCOM || COMPILE_TEST
> diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
> index ad675a6593d0..24514c722832 100644
> --- a/drivers/soc/qcom/Makefile
> +++ b/drivers/soc/qcom/Makefile
> @@ -20,6 +20,7 @@ obj-$(CONFIG_QCOM_SMEM_STATE) += smem_state.o
>   obj-$(CONFIG_QCOM_SMP2P)	+= smp2p.o
>   obj-$(CONFIG_QCOM_SMSM)	+= smsm.o
>   obj-$(CONFIG_QCOM_SOCINFO)	+= socinfo.o
> +obj-$(CONFIG_QCOM_SPM)		+= spm.o
>   obj-$(CONFIG_QCOM_WCNSS_CTRL) += wcnss_ctrl.o
>   obj-$(CONFIG_QCOM_APR) += apr.o
>   obj-$(CONFIG_QCOM_LLCC) += llcc-qcom.o
> diff --git a/drivers/soc/qcom/spm.c b/drivers/soc/qcom/spm.c
> new file mode 100644
> index 000000000000..d5ba0b5488fc
> --- /dev/null
> +++ b/drivers/soc/qcom/spm.c
> @@ -0,0 +1,212 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2011-2014, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2014,2015, Linaro Ltd.
> + *
> + * SAW power controller driver
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/io.h>
> +#include <linux/slab.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_device.h>
> +#include <linux/err.h>
> +#include <linux/platform_device.h>
> +#include <soc/qcom/spm.h>
> +
> +#define SPM_CTL_INDEX		0x7f
> +#define SPM_CTL_INDEX_SHIFT	4
> +#define SPM_CTL_EN		BIT(0)
> +
> +enum spm_reg {
> +	SPM_REG_CFG,
> +	SPM_REG_SPM_CTL,
> +	SPM_REG_DLY,
> +	SPM_REG_PMIC_DLY,
> +	SPM_REG_PMIC_DATA_0,
> +	SPM_REG_PMIC_DATA_1,
> +	SPM_REG_VCTL,
> +	SPM_REG_SEQ_ENTRY,
> +	SPM_REG_SPM_STS,
> +	SPM_REG_PMIC_STS,
> +	SPM_REG_NR,
> +};
> +
> +static const u8 spm_reg_offset_v2_1[SPM_REG_NR] = {
> +	[SPM_REG_CFG]		= 0x08,
> +	[SPM_REG_SPM_CTL]	= 0x30,
> +	[SPM_REG_DLY]		= 0x34,
> +	[SPM_REG_SEQ_ENTRY]	= 0x80,
> +};
> +
> +/* SPM register data for 8974, 8084 */
> +static const struct spm_reg_data spm_reg_8974_8084_cpu  = {
> +	.reg_offset = spm_reg_offset_v2_1,
> +	.spm_cfg = 0x1,
> +	.spm_dly = 0x3C102800,
> +	.seq = { 0x03, 0x0B, 0x0F, 0x00, 0x20, 0x80, 0x10, 0xE8, 0x5B, 0x03,
> +		0x3B, 0xE8, 0x5B, 0x82, 0x10, 0x0B, 0x30, 0x06, 0x26, 0x30,
> +		0x0F },
> +	.start_index[PM_SLEEP_MODE_STBY] = 0,
> +	.start_index[PM_SLEEP_MODE_SPC] = 3,
> +};
> +
> +/* SPM register data for 8226 */
> +static const struct spm_reg_data spm_reg_8226_cpu  = {
> +	.reg_offset = spm_reg_offset_v2_1,
> +	.spm_cfg = 0x0,
> +	.spm_dly = 0x3C102800,
> +	.seq = { 0x60, 0x03, 0x60, 0x0B, 0x0F, 0x20, 0x10, 0x80, 0x30, 0x90,
> +		0x5B, 0x60, 0x03, 0x60, 0x3B, 0x76, 0x76, 0x0B, 0x94, 0x5B,
> +		0x80, 0x10, 0x26, 0x30, 0x0F },
> +	.start_index[PM_SLEEP_MODE_STBY] = 0,
> +	.start_index[PM_SLEEP_MODE_SPC] = 5,
> +};
> +
> +static const u8 spm_reg_offset_v1_1[SPM_REG_NR] = {
> +	[SPM_REG_CFG]		= 0x08,
> +	[SPM_REG_SPM_CTL]	= 0x20,
> +	[SPM_REG_PMIC_DLY]	= 0x24,
> +	[SPM_REG_PMIC_DATA_0]	= 0x28,
> +	[SPM_REG_PMIC_DATA_1]	= 0x2C,
> +	[SPM_REG_SEQ_ENTRY]	= 0x80,
> +};
> +
> +/* SPM register data for 8064 */
> +static const struct spm_reg_data spm_reg_8064_cpu = {
> +	.reg_offset = spm_reg_offset_v1_1,
> +	.spm_cfg = 0x1F,
> +	.pmic_dly = 0x02020004,
> +	.pmic_data[0] = 0x0084009C,
> +	.pmic_data[1] = 0x00A4001C,
> +	.seq = { 0x03, 0x0F, 0x00, 0x24, 0x54, 0x10, 0x09, 0x03, 0x01,
> +		0x10, 0x54, 0x30, 0x0C, 0x24, 0x30, 0x0F },
> +	.start_index[PM_SLEEP_MODE_STBY] = 0,
> +	.start_index[PM_SLEEP_MODE_SPC] = 2,
> +};
> +
> +static inline void spm_register_write(struct spm_driver_data *drv,
> +					enum spm_reg reg, u32 val)
> +{
> +	if (drv->reg_data->reg_offset[reg])
> +		writel_relaxed(val, drv->reg_base +
> +				drv->reg_data->reg_offset[reg]);
> +}
> +
> +/* Ensure a guaranteed write, before return */
> +static inline void spm_register_write_sync(struct spm_driver_data *drv,
> +					enum spm_reg reg, u32 val)
> +{
> +	u32 ret;
> +
> +	if (!drv->reg_data->reg_offset[reg])
> +		return;
> +
> +	do {
> +		writel_relaxed(val, drv->reg_base +
> +				drv->reg_data->reg_offset[reg]);
> +		ret = readl_relaxed(drv->reg_base +
> +				drv->reg_data->reg_offset[reg]);
> +		if (ret == val)
> +			break;
> +		cpu_relax();
> +	} while (1);
> +}
> +
> +static inline u32 spm_register_read(struct spm_driver_data *drv,
> +				    enum spm_reg reg)
> +{
> +	return readl_relaxed(drv->reg_base + drv->reg_data->reg_offset[reg]);
> +}
> +
> +void spm_set_low_power_mode(struct spm_driver_data *drv,
> +			    enum pm_sleep_mode mode)
> +{
> +	u32 start_index;
> +	u32 ctl_val;
> +
> +	start_index = drv->reg_data->start_index[mode];
> +
> +	ctl_val = spm_register_read(drv, SPM_REG_SPM_CTL);
> +	ctl_val &= ~(SPM_CTL_INDEX << SPM_CTL_INDEX_SHIFT);
> +	ctl_val |= start_index << SPM_CTL_INDEX_SHIFT;
> +	ctl_val |= SPM_CTL_EN;
> +	spm_register_write_sync(drv, SPM_REG_SPM_CTL, ctl_val);
> +}
> +
> +static const struct of_device_id spm_match_table[] = {
> +	{ .compatible = "qcom,msm8226-saw2-v2.1-cpu",
> +	  .data = &spm_reg_8226_cpu },
> +	{ .compatible = "qcom,msm8974-saw2-v2.1-cpu",
> +	  .data = &spm_reg_8974_8084_cpu },
> +	{ .compatible = "qcom,apq8084-saw2-v2.1-cpu",
> +	  .data = &spm_reg_8974_8084_cpu },
> +	{ .compatible = "qcom,apq8064-saw2-v1.1-cpu",
> +	  .data = &spm_reg_8064_cpu },
> +	{ },
> +};
> +
> +static int spm_dev_probe(struct platform_device *pdev)
> +{
> +	const struct of_device_id *match_id;
> +	struct spm_driver_data *drv;
> +	struct resource *res;
> +	void __iomem *addr;
> +
> +	drv = devm_kzalloc(&pdev->dev, sizeof(*drv), GFP_KERNEL);
> +	if (!drv)
> +		return -ENOMEM;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	drv->reg_base = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(drv->reg_base))
> +		return PTR_ERR(drv->reg_base);
> +
> +	match_id = of_match_node(spm_match_table, pdev->dev.of_node);
> +	if (!match_id)
> +		return -ENODEV;
> +
> +	drv->reg_data = match_id->data;
> +	platform_set_drvdata(pdev, drv);
> +
> +	/* Write the SPM sequences first.. */
> +	addr = drv->reg_base + drv->reg_data->reg_offset[SPM_REG_SEQ_ENTRY];
> +	__iowrite32_copy(addr, drv->reg_data->seq,
> +			ARRAY_SIZE(drv->reg_data->seq) / 4);
> +
> +	/*
> +	 * ..and then the control registers.
> +	 * On some SoC if the control registers are written first and if the
> +	 * CPU was held in reset, the reset signal could trigger the SPM state
> +	 * machine, before the sequences are completely written.
> +	 */
> +	spm_register_write(drv, SPM_REG_CFG, drv->reg_data->spm_cfg);
> +	spm_register_write(drv, SPM_REG_DLY, drv->reg_data->spm_dly);
> +	spm_register_write(drv, SPM_REG_PMIC_DLY, drv->reg_data->pmic_dly);
> +	spm_register_write(drv, SPM_REG_PMIC_DATA_0,
> +				drv->reg_data->pmic_data[0]);
> +	spm_register_write(drv, SPM_REG_PMIC_DATA_1,
> +				drv->reg_data->pmic_data[1]);
> +
> +	/* Set up Standby as the default low power mode */
> +	spm_set_low_power_mode(drv, PM_SLEEP_MODE_STBY);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver spm_driver = {
> +	.probe = spm_dev_probe,
> +	.driver = {
> +		.name = "qcom_spm",
> +		.of_match_table = spm_match_table,
> +	},
> +};
> +
> +static int __init qcom_spm_init(void)
> +{
> +	return platform_driver_register(&spm_driver);
> +}
> +arch_initcall(qcom_spm_init);
> diff --git a/include/soc/qcom/spm.h b/include/soc/qcom/spm.h
> new file mode 100644
> index 000000000000..4c7e5ac2583d
> --- /dev/null
> +++ b/include/soc/qcom/spm.h
> @@ -0,0 +1,41 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2011-2014, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2014,2015, Linaro Ltd.
> + */
> +
> +#ifndef __SPM_H__
> +#define __SPM_H__
> +
> +#include <linux/cpuidle.h>
> +
> +#define MAX_PMIC_DATA		2
> +#define MAX_SEQ_DATA		64
> +
> +enum pm_sleep_mode {
> +	PM_SLEEP_MODE_STBY,
> +	PM_SLEEP_MODE_RET,
> +	PM_SLEEP_MODE_SPC,
> +	PM_SLEEP_MODE_PC,
> +	PM_SLEEP_MODE_NR,
> +};
> +
> +struct spm_reg_data {
> +	const u8 *reg_offset;
> +	u32 spm_cfg;
> +	u32 spm_dly;
> +	u32 pmic_dly;
> +	u32 pmic_data[MAX_PMIC_DATA];
> +	u8 seq[MAX_SEQ_DATA];
> +	u8 start_index[PM_SLEEP_MODE_NR];
> +};
> +
> +struct spm_driver_data {
> +	void __iomem *reg_base;
> +	const struct spm_reg_data *reg_data;
> +};
> +
> +void spm_set_low_power_mode(struct spm_driver_data *drv,
> +			    enum pm_sleep_mode mode);
> +
> +#endif /* __SPM_H__ */

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

