Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 910693890E
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jun 2019 13:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727953AbfFGLaZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Fri, 7 Jun 2019 07:30:25 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:36725 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727452AbfFGLaZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 7 Jun 2019 07:30:25 -0400
Received: from [192.168.1.162] ([37.4.249.160]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1N6t3Z-1gTxBM1J79-018GgF; Fri, 07 Jun 2019 13:30:03 +0200
Subject: Re: [PATCH v2 6/7] ARM: defconfig: enable cpufreq driver for RPi
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Eric Anholt <eric@anholt.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com
Cc:     mbrugger@suse.de, viresh.kumar@linaro.org, rjw@rjwysocki.net,
        sboyd@kernel.org, ptesarik@suse.com,
        linux-rpi-kernel@lists.infradead.org, ssuloev@orpaltech.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mturquette@baylibre.com, linux-pm@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org
References: <20190606142255.29454-1-nsaenzjulienne@suse.de>
 <20190606142255.29454-7-nsaenzjulienne@suse.de>
From:   Stefan Wahren <stefan.wahren@i2se.com>
Openpgp: preference=signencrypt
Autocrypt: addr=stefan.wahren@i2se.com; keydata=
 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 AQ==
Message-ID: <8ff4f038-fb3a-ef51-1355-d58cfa04a854@i2se.com>
Date:   Fri, 7 Jun 2019 13:30:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190606142255.29454-7-nsaenzjulienne@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
X-Provags-ID: V03:K1:3pfVuDbmLQoriadhhwENnSU0mpn11AoPfoJm3WhVw31iVTKjCZY
 qGh2sjuL2Mvy6NGFykP1+97lgUazLo8Sk2i7Kn2JDT6hQjdM7yZbrlHsIzx79blrSGLdoc1
 miXWjficWf/Pg728bNXPxWiFHJfJXB0XjBVvlPDty+MtJS1fSTkCdH5BvY0ttn+PvFcDJlm
 2Tcy2xit8O+m5V2vxkDdQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:glFVvL54ntc=:4AbPGEUJVlMysghFvq0krR
 2uc4KeesnwaDDko6s2iof2zbpneuK9edDYQKqtLf+FktQGz5BA1nZFzJXKEXaVoBuLVliWVIp
 xxxQEUhGq2jFkzhCT9VdbNPaGoXq6kWGugIwQZ2EmNzFxK9+qne77L2vuUnyu9jAr6S37o4yC
 +NmCXUFEvSocN/iX54h08OeGIwqkzN2ATmU8OezTEPAkgNWREZbJ/EvZUMJa+w8PQFMiUZ/WU
 bhH7dp7w+zXodKkKc+dp/LGS161T7tFVMsVn/JJtHstTnd4zriGNJVAjxpgNsLTNTzycERuEC
 7UREwsTfhpX6H4nn3Pa9H3kmbnEeqzZW52/V0IKUHNWTEI5MfMvmTNnWac7u9Q2JzEEVaHgyx
 FUk+0FrlKECxhzqqpU6FtmMGCQupIz+V98RYNR+OYCgnUgEf72Uqt4Uha6UgKeHMi2hqRAoaj
 DQogCVcm3k3ifJL9QerUOk4kM7SgwlFS+1ZF2Iy7N9KRvvB+N08hRjhHTimeocRGU9Kr2Kde2
 YExm9tU0X4a5PU2rE7necfo3EDe1wstcPhIEraxS7jKBPDI5WCXKP7yLIZvFQABcQYMiyNG/E
 JOEMvSf4QMDYSFqK8Wy0vfL9naERoV5xDCyCYjige2uVvoXJGdRJwdZi+1XrtsELMVHDhcr2z
 iYVXtnN2Na8TIAJOtWOsrql/x0cOq8zmeIP1FW1KLEIft6RV+s0DG8nCzLYjcu+RypWPqbmdl
 WT9efrg8jtfLy58ODdZR9dxfPziXLgYFOhfC41OO3Ki0VoFa6r1W+IMTuAM=
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Nicolas,

Am 06.06.19 um 16:22 schrieb Nicolas Saenz Julienne:
> This enables on both multi_v7_defconfig and bcm2835_defconfig the new
> firmware based clock and cpufreq drivers for the Raspberry Pi platform.
>
> In the case of bcm2835_defconfig, as the cpufreq subsystem was disabled,
> the subsystem configuration was copied from multi_v7_defconfig (default
> governor, statistics, etc...).
sorry i didn't made any suggestions for this.
>
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> ---
>  arch/arm/configs/bcm2835_defconfig  | 9 +++++++++
>  arch/arm/configs/multi_v7_defconfig | 2 ++
>  2 files changed, 11 insertions(+)
>
> diff --git a/arch/arm/configs/bcm2835_defconfig b/arch/arm/configs/bcm2835_defconfig
> index dcf7610cfe55..3fd90bfd5fec 100644
> --- a/arch/arm/configs/bcm2835_defconfig
> +++ b/arch/arm/configs/bcm2835_defconfig
> @@ -37,6 +37,14 @@ CONFIG_CMA=y
>  CONFIG_SECCOMP=y
>  CONFIG_KEXEC=y
>  CONFIG_CRASH_DUMP=y
> +CONFIG_CPU_FREQ=y
> +CONFIG_CPU_FREQ_STAT=y
> +CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
From my understanding ondemand isn't the best fit for Raspberry Pi. I
would prefer conservative because of the delays through the mailbox
interface but it's not a really strong opinion.
> +CONFIG_CPU_FREQ_GOV_POWERSAVE=m
> +CONFIG_CPU_FREQ_GOV_USERSPACE=m
> +CONFIG_CPU_FREQ_GOV_CONSERVATIVE=m

Please make them builtin in this case.

After that you can have make Acked-by for this patch.

> +CONFIG_CPUFREQ_DT=y
> +CONFIG_ARM_RASPBERRYPI_CPUFREQ=y
>  CONFIG_VFP=y
>  # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
>  # CONFIG_SUSPEND is not set
> @@ -132,6 +140,7 @@ CONFIG_DMA_BCM2835=y
>  CONFIG_STAGING=y
>  CONFIG_SND_BCM2835=m
>  CONFIG_VIDEO_BCM2835=m
> +CONFIG_CLK_RASPBERRYPI=y
>  CONFIG_MAILBOX=y
>  CONFIG_BCM2835_MBOX=y
>  # CONFIG_IOMMU_SUPPORT is not set
> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
> index 6b748f214eae..0fd60a83f768 100644
> --- a/arch/arm/configs/multi_v7_defconfig
> +++ b/arch/arm/configs/multi_v7_defconfig
> @@ -102,6 +102,7 @@ CONFIG_CPU_FREQ_GOV_CONSERVATIVE=m
>  CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y
>  CONFIG_CPUFREQ_DT=y
>  CONFIG_ARM_IMX6Q_CPUFREQ=y
> +CONFIG_ARM_RASPBERRYPI_CPUFREQ=y
>  CONFIG_QORIQ_CPUFREQ=y
>  CONFIG_CPU_IDLE=y
>  CONFIG_ARM_CPUIDLE=y
> @@ -899,6 +900,7 @@ CONFIG_STAGING_BOARD=y
>  CONFIG_COMMON_CLK_MAX77686=y
>  CONFIG_COMMON_CLK_RK808=m
>  CONFIG_COMMON_CLK_S2MPS11=m
> +CONFIG_CLK_RASPBERRYPI=y
>  CONFIG_COMMON_CLK_QCOM=y
>  CONFIG_QCOM_CLK_RPM=y
>  CONFIG_APQ_MMCC_8084=y

