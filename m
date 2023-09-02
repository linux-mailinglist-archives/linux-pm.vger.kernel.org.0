Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76EDA79088F
	for <lists+linux-pm@lfdr.de>; Sat,  2 Sep 2023 17:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233651AbjIBPoG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 2 Sep 2023 11:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231886AbjIBPoF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 2 Sep 2023 11:44:05 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59342CFE;
        Sat,  2 Sep 2023 08:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=OI7BJO+ZJALq3UZuaDfs583qm49QoWB+dj6di5RNwhA=; b=pSoXvhBWh3kByyoYDq+FsjDoxa
        Oj4rVzzPvRuSqDbQnFNAd8ndXdFAAkdDjTlK1RN0R+n5yl9devylYzqRTW6ucQe6y6ViqdbE//fTb
        XncJKZbxLDpXos9/i4g2r7J/H3PLDlahphziBGaX9sJDkNunop1GbRcft0mlQ0QJlB+JoQYGGyaeV
        dSCQG6EBjXB1GKNC8/qkbWxtaxAKCH4fVz+CKDMLDEpgDi58V3UWWCEEMLsSQxP1zfD5s2rXyJ3Dq
        looCVp1sqngcHTIuiUGanqeNBGXSNc0k8zrjnlXJRJkvraU5rylVt45mbQSvQ1Dfodva3A7dkwWF5
        VW6CzKNg==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qcSmq-001ZBJ-1a;
        Sat, 02 Sep 2023 15:43:48 +0000
Message-ID: <885eab85-2c11-cf20-9187-55cd647fbe9f@infradead.org>
Date:   Sat, 2 Sep 2023 08:43:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v3 1/5] soc: loongson: loongson2_pm: Add dependency for
 INPUT
Content-Language: en-US
To:     Binbin Zhou <zhoubinbin@loongson.cn>,
        Binbin Zhou <zhoubb.aaron@gmail.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Yinbo Zhu <zhuyinbo@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        loongson-kernel@lists.loongnix.cn, soc@kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev
References: <cover.1693623752.git.zhoubinbin@loongson.cn>
 <16a37f6ad3cc9417b6638c2cd532d88c79468eb1.1693623752.git.zhoubinbin@loongson.cn>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <16a37f6ad3cc9417b6638c2cd532d88c79468eb1.1693623752.git.zhoubinbin@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 9/2/23 01:47, Binbin Zhou wrote:
> Since commit 67694c076bd7 ("soc: loongson2_pm: add power management
> support"), the Loongson-2K PM driver was added, but it didn't update the
> Kconfig entry for the INPUT dependency, leading to build errors:
> 
> /opt/crosstool/gcc-13.2.0-nolibc/loongarch64-linux/bin/loongarch64-linux-ld:
> drivers/soc/loongson/loongson2_pm.o: in function `loongson2_power_button_init':
> /work/lnx/next/linux-next-20230825/LOONG64/../drivers/soc/loongson/loongson2_pm.c:101:(.text+0x350): undefined reference to `input_allocate_device'
> /opt/crosstool/gcc-13.2.0-nolibc/loongarch64-linux/bin/loongarch64-linux-ld:
> /work/lnx/next/linux-next-20230825/LOONG64/../drivers/soc/loongson/loongson2_pm.c:109:(.text+0x3dc): undefined reference to `input_set_capability'
> /opt/crosstool/gcc-13.2.0-nolibc/loongarch64-linux/bin/loongarch64-linux-ld:
> /work/lnx/next/linux-next-20230825/LOONG64/../drivers/soc/loongson/loongson2_pm.c:111:(.text+0x3e4): undefined reference to `input_register_device'
> /opt/crosstool/gcc-13.2.0-nolibc/loongarch64-linux/bin/loongarch64-linux-ld:
> /work/lnx/next/linux-next-20230825/LOONG64/../drivers/soc/loongson/loongson2_pm.c:125:(.text+0x3fc): undefined reference to `input_free_device'
> /opt/crosstool/gcc-13.2.0-nolibc/loongarch64-linux/bin/loongarch64-linux-ld: drivers/soc/loongson/loongson2_pm.o: in function `input_report_key':
> /work/lnx/next/linux-next-20230825/LOONG64/../include/linux/input.h:425:(.text+0x58c): undefined reference to `input_event'
> 
> Also, since this driver can only be built-in, it fails to link when the
> INPUT is in a loadable module, so we should update the Kconfig entry to
> depend on INPUT=y.
> 
> Fixes: 67694c076bd7 ("soc: loongson2_pm: add power management support")
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  drivers/soc/loongson/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/soc/loongson/Kconfig b/drivers/soc/loongson/Kconfig
> index 314e13bb3e01..368344943a93 100644
> --- a/drivers/soc/loongson/Kconfig
> +++ b/drivers/soc/loongson/Kconfig
> @@ -20,6 +20,7 @@ config LOONGSON2_GUTS
>  config LOONGSON2_PM
>  	bool "Loongson-2 SoC Power Management Controller Driver"
>  	depends on LOONGARCH && OF
> +	depends on INPUT=y
>  	help
>  	  The Loongson-2's power management controller was ACPI, supports ACPI
>  	  S2Idle (Suspend To Idle), ACPI S3 (Suspend To RAM), ACPI S4 (Suspend To

-- 
~Randy
