Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00D7472195
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jul 2019 23:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392108AbfGWVe3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Jul 2019 17:34:29 -0400
Received: from mout.gmx.net ([212.227.15.18]:56799 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731019AbfGWVe3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 23 Jul 2019 17:34:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1563917650;
        bh=qgUZqMvf9CDgIeP64ai2WtrFeE/F4JInROCU4QA90us=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Jq8Vzi93QsM0GOvk8S6IRQWD8YncdKgxoyQKOPJysWeKwghvIqEUDfJlEE/k2mCLN
         vlo3j9sM41UrgCryrL1bKbNRL+g2Qsudv1ZbWtXgUDi5HY5VlLkE3Terx5YY1U/Zjk
         4u53L15HcmbCNb0mHASCROmOPEJUyYnLZGlUVrQE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.1.162] ([37.4.249.115]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LuP5z-1iW8rV0G6p-011n66; Tue, 23
 Jul 2019 23:34:10 +0200
Subject: Re: [PATCH v4 7/7] arm64: defconfig: enable cpufreq support for RPi3
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        stefan.wahren@i2se.com, linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, f.fainelli@gmail.com,
        Catalin Marinas <catalin.marinas@arm.com>, ptesarik@suse.com,
        sboyd@kernel.org, viresh.kumar@linaro.org, mturquette@baylibre.com,
        linux-pm@vger.kernel.org, rjw@rjwysocki.net,
        Will Deacon <will.deacon@arm.com>, eric@anholt.net,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        mbrugger@suse.de, ssuloev@orpaltech.com
References: <20190612182500.4097-1-nsaenzjulienne@suse.de>
 <20190612182500.4097-8-nsaenzjulienne@suse.de>
From:   Stefan Wahren <wahrenst@gmx.net>
Message-ID: <98a6dccd-b834-3596-cc4a-e97ebc9b01cb@gmx.net>
Date:   Tue, 23 Jul 2019 23:34:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190612182500.4097-8-nsaenzjulienne@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:N3LqJoGUpptYNWRuJlS5DD9eWKeIqYHeFd/EMl9rCmCiDKtzLpx
 //855m3bntUOdB0/cZOBDSX4i4ubIEVPPWa+qMQGV2jRUPAZ2Gi2j7ja9rSqfVQbdA52r41
 YUPsgu3fQ5FFvUhzp8d/LqGMOv2i+VtAnWyoDsiC40arjmmFwW/SmyZJYnu0jxKI0hUghrq
 YU7RDm7dg3Hk/VTcCwvMA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:3DbHgGNVAlY=:3Fr6YLvCxR1vG+tDZUofNV
 Zvz0ywwaj1vMIeNiio2oorANWuTQGi/LnrwlYKLD8l+2b7jv49lU+pYOtf/hcOhH66bXzLoG8
 KczZSzN8EwNrUqyyZJWtpzip3Ct+q+WHLQ6hRnbcBDaq2c8TLprDFC0yGNWrBooTJ38NAKEVD
 hPsTk6DmMIVzVW+ZvxiO1E4PKiZwHDCGbenZjvKMJLLFZd9AfWs5NvBn0LgmEbHRJST3moXyS
 KBMFAeDh7fNhopRfPI6ha1bGYhH/wydlgEHyHoB2bObAFuw98m66eWT+HgeP6au2eLvH0JRgM
 3HoL8twG+thkckIFHvigdWmZnt6u6Hv/ZfLGeIg8RC3qPkqfsFQu69mzfcFcfRnfg8xmc5DPj
 QO+8CIU/BiAYZ/3e6slmOEUcuU+9VG896hiDpgDQhN6iaUkPPhR/QiSKI2KUQG32bdb9ugWPV
 zk2N+CKqPkQEpawLV1RpfVATMRgMrh26lYnB45cWH/x+Wq9YkuzgwpNCYzMqkgT8CYn/Gchrl
 1LpKDBRPhZMXaEJDcjpLhA8I4721UA1mgbHMk5CC4sLWSRtRfUxoqZ6xtTW2lpHw99fjl/ix5
 wPSQFMJt1SbNJXqDaIOqSL8d9b+q11vKNTpgQHBh78dg/fUapfZPBxJFydogyNJAlZ6nFsaXg
 /KxBCkVF8LU2a2hbP3jWHVnlzp2uQAjiVNPJFqL7ZHIxUciPKCHdX89M7EtNc5CMB4/Yo+tL0
 gpsw0X0fC7Z/mJAIRoqsMkcgc2xgxBpd4dHKZEi1PYhHUcsy3tSNQCZllxHC1XHWYJ/d9w9bS
 u94G3LkEDfjS8c3WTU3bpuQLEk3K/61iU4n6UFC4yxm6fikboMUf4F0OAAm7KZ+b0tLSROmbJ
 g6dggzlaqucuBOM+dXzjAaFJnnQxWQLgJYugxMnOCI6iFTfV8qJUddHkcyewjk6Eu0VrD6mhI
 re2qXMNEhvSwsHj7twmxwKivHO8RleJZ03E5CLe9WlZy87D9oGLHi5vWbrk/i2RJ7FWcOJEby
 lpMlR6xU6hrE7+ckmzaLdzVaHk+2fyoYg5QSUKKTm62XYwIJpyEtFSDmFEu7KN08m7W8vgMTx
 sjCdFNQnalq4uw=
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Am 12.06.19 um 20:24 schrieb Nicolas Saenz Julienne:
> This enables both the new firmware clock driver and cpufreq driver
> available for the RPi3 family of boards.
>
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Acked-by: Stefan Wahren <stefan.wahren@i2se.com>
> ---
>
> Changes since v2:
>   - Build both drivers as modules
>
>  arch/arm64/configs/defconfig | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 5a8e853833cf..5e322e61b101 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -83,6 +83,7 @@ CONFIG_ACPI_CPPC_CPUFREQ=m
>  CONFIG_ARM_ARMADA_37XX_CPUFREQ=y
>  CONFIG_ARM_SCPI_CPUFREQ=y
>  CONFIG_ARM_IMX_CPUFREQ_DT=m
> +CONFIG_ARM_RASPBERRYPI_CPUFREQ=m
>  CONFIG_ARM_TEGRA186_CPUFREQ=y
>  CONFIG_ARM_SCPI_PROTOCOL=y
>  CONFIG_RASPBERRYPI_FIRMWARE=y
> @@ -653,6 +654,7 @@ CONFIG_COMMON_CLK_CS2000_CP=y
>  CONFIG_COMMON_CLK_S2MPS11=y
>  CONFIG_CLK_QORIQ=y
>  CONFIG_COMMON_CLK_PWM=y
> +CONFIG_CLK_RASPBERRYPI=m
>  CONFIG_CLK_IMX8MM=y
>  CONFIG_CLK_IMX8MQ=y
>  CONFIG_CLK_IMX8QXP=y

Applied to bcm2835-defconfig-64-next

Thanks

