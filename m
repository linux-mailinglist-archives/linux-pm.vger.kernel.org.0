Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C64E78B9C3
	for <lists+linux-pm@lfdr.de>; Mon, 28 Aug 2023 22:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbjH1UvT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Aug 2023 16:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbjH1UvF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Aug 2023 16:51:05 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D6A210E;
        Mon, 28 Aug 2023 13:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=1VGN/7kaT0gr2v5iLutL5Ek3yl9HftUWq6xZh8Ol+A8=; b=dRPFd5R5dVR+XM6pQ80caayH0S
        ZATYz4D36SUQTvDeGGScSp0homXaxxyKUjcrn/kx+nkgY3RrawnvbdCgIyiwlysAb9gmlb7DTVqfP
        xbB8+RJL5Q7VQQfmfxPV6mp1MEjgaXIWIFgMLwFtVYCrc8/VS2yHThj5V//V26t13upeTMD69ichj
        zW/Gf9sySlZ7hr7FFOiFXRdrV55K91jWAZmzaoDO7FBRLr7oalfAAMxkvep7Kst8Z+6GZMjWzdJEo
        E55/bntNwunvlhc6C0ZwJujgNllxdmXbR8hKLcOUsWe9mxISNTpNVY7E0Yy8+uMLVY4RlOfa32Kqz
        rIP/CM8A==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qajCI-00AGCg-14;
        Mon, 28 Aug 2023 20:50:54 +0000
Message-ID: <f510eafd-7561-89d2-5d5c-ae98901c2250@infradead.org>
Date:   Mon, 28 Aug 2023 13:50:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 1/5] soc: loongson: loongson_pm2: add dependency for INPUT
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
        loongson-kernel@lists.loongnix.cn, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, Xuerui Wang <kernel@xen0n.name>,
        loongarch@lists.linux.dev
References: <cover.1693218539.git.zhoubinbin@loongson.cn>
 <08447374271c7df6d1543abce69195f1ae09f59c.1693218539.git.zhoubinbin@loongson.cn>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <08447374271c7df6d1543abce69195f1ae09f59c.1693218539.git.zhoubinbin@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi--

On 8/28/23 05:38, Binbin Zhou wrote:
> Since commit 67694c076bd7 ("soc: loongson2_pm: add power management
> support"), the Loongson-2K PM driver was added, but it didn't update the
> Kconfig entry for the INPUT dependency, leading to build errors, so
> update the Kconfig entry to depend on INPUT.
> 
> /opt/crosstool/gcc-13.2.0-nolibc/loongarch64-linux/bin/loongarch64-linux-ld: drivers/soc/loongson/loongson2_pm.o: in function `loongson2_power_button_init':
> /work/lnx/next/linux-next-20230825/LOONG64/../drivers/soc/loongson/loongson2_pm.c:101:(.text+0x350): undefined reference to `input_allocate_device'
> /opt/crosstool/gcc-13.2.0-nolibc/loongarch64-linux/bin/loongarch64-linux-ld: /work/lnx/next/linux-next-20230825/LOONG64/../drivers/soc/loongson/loongson2_pm.c:109:(.text+0x3dc): undefined reference to `input_set_capability'
> /opt/crosstool/gcc-13.2.0-nolibc/loongarch64-linux/bin/loongarch64-linux-ld: /work/lnx/next/linux-next-20230825/LOONG64/../drivers/soc/loongson/loongson2_pm.c:111:(.text+0x3e4): undefined reference to `input_register_device'
> /opt/crosstool/gcc-13.2.0-nolibc/loongarch64-linux/bin/loongarch64-linux-ld: /work/lnx/next/linux-next-20230825/LOONG64/../drivers/soc/loongson/loongson2_pm.c:125:(.text+0x3fc): undefined reference to `input_free_device'
> /opt/crosstool/gcc-13.2.0-nolibc/loongarch64-linux/bin/loongarch64-linux-ld: drivers/soc/loongson/loongson2_pm.o: in function `input_report_key':
> /work/lnx/next/linux-next-20230825/LOONG64/../include/linux/input.h:425:(.text+0x58c): undefined reference to `input_event'
> /opt/crosstool/gcc-13.2.0-nolibc/loongarch64-linux/bin/loongarch64-linux-ld: drivers/soc/loongson/loongson2_pm.o: in function `input_sync':
> /work/lnx/next/linux-next-20230825/LOONG64/../include/linux/input.h:450:(.text+0x5a0): undefined reference to `input_event'
> /opt/crosstool/gcc-13.2.0-nolibc/loongarch64-linux/bin/loongarch64-linux-ld: drivers/soc/loongson/loongson2_pm.o: in function `input_report_key':
> /work/lnx/next/linux-next-20230825/LOONG64/../include/linux/input.h:425:(.text+0x5b4): undefined reference to `input_event'
> /opt/crosstool/gcc-13.2.0-nolibc/loongarch64-linux/bin/loongarch64-linux-ld: drivers/soc/loongson/loongson2_pm.o: in function `input_sync':
> /work/lnx/next/linux-next-20230825/LOONG64/../include/linux/input.h:450:(.text+0x5c8): undefined reference to `input_event'
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> ---
>  drivers/soc/loongson/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/soc/loongson/Kconfig b/drivers/soc/loongson/Kconfig
> index 314e13bb3e01..1b57af1e5529 100644
> --- a/drivers/soc/loongson/Kconfig
> +++ b/drivers/soc/loongson/Kconfig
> @@ -20,6 +20,7 @@ config LOONGSON2_GUTS
>  config LOONGSON2_PM
>  	bool "Loongson-2 SoC Power Management Controller Driver"
>  	depends on LOONGARCH && OF
> +	depends on INPUT

In the failing .config file, CONFIG_INPUT=m.
This bool kconfig item is still set/enabled after this patch and the build still fails.

You could use
	depends on INPUT=y

if that is appropriate. I dunno.

>  	help
>  	  The Loongson-2's power management controller was ACPI, supports ACPI
>  	  S2Idle (Suspend To Idle), ACPI S3 (Suspend To RAM), ACPI S4 (Suspend To

-- 
~Randy
