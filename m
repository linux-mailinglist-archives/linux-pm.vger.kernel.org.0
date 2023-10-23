Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ADB07D3EC8
	for <lists+linux-pm@lfdr.de>; Mon, 23 Oct 2023 20:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbjJWSPQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Oct 2023 14:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbjJWSPP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 23 Oct 2023 14:15:15 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD51E4
        for <linux-pm@vger.kernel.org>; Mon, 23 Oct 2023 11:15:11 -0700 (PDT)
Received: from [192.168.1.129] ([37.4.248.43]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MDN3O-1qkVrU1Ym6-00AYVi; Mon, 23 Oct 2023 20:14:30 +0200
Message-ID: <78770d2a-85c2-4347-a637-6781a5c44638@i2se.com>
Date:   Mon, 23 Oct 2023 20:14:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pmdomain: bcm: bcm2835-power: check if the ASB register
 is equal to enable
Content-Language: en-US
To:     =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Nick Alcock <nick.alcock@oracle.com>,
        Peter Robinson <pbrobinson@gmail.com>,
        Lee Jones <lee@kernel.org>, Melissa Wen <mwen@igalia.com>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-pm@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, kernel-dev@igalia.com
References: <20231023145004.284826-2-mcanal@igalia.com>
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <20231023145004.284826-2-mcanal@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:arguXahn3x6gk3rOa9foOfU5B+ujOEPvQC0Flazs77xJTZ7c7yV
 f4lsgD9BkdSRMfi5t2kNSAI5Qg1DZMShZ4GZ6tJW/VN/n+DuAU8YrFMTHRPHOYTHKCv6I8M
 P0AyjKf5tsabLK31X16YaGCjmoYf8aw98SDzZyfQvtmNI8sDfqzkBmXazc82u2z2CU7hBFK
 gbczhe/T8r4kKSWHCGnmg==
UI-OutboundReport: notjunk:1;M01:P0:6Z4N37En7AA=;sHlKdwbRNaxeNsGByCCCGFz5VjT
 dhQl+qSdwPU+r3r+PH4aoK0sYxnhT+Q4v7fN+V17OkUSMsAd8pxO41Rfk9T5z6mXkOwgOxWOS
 XX4s5urbQXkk7N9SDvOMBNpysuNdhzDoRSiylbJJf/dK5mgrhJ5zDv4hk/E+7gaFX6JTNu5Tc
 Rge8cvkOZ6sD9BzUj4AIrFUHOY27vQYp2wUkO9927/1NIHft2o1dzhYXVUzdG1abKGgAmNFVo
 +DL/DyE0eKdfnG7DPUZo3Uj5TU4GhdqdW0M+nrjwC0ICbiswFvjs7IM+yB9gM/hkhnTBfa5Iv
 PM9d/NrSu+AMVjlObP4kay26XIYE+/ezhevtNoEbzTCtuwXWEhBw8JQE8q1q1lHpcjPUtLPwD
 7gmFoMbKT2gl0dUTcwr9oKePO5NSRN4nkKlcxKVja+PV8iqquAQKOxgtz1YIKyVKNDM2fJPJI
 AdINl9+xFMfgyaGewOOlRrghrmxZsuE4NGEUFFtuw4f0/jrcoCXm2TnfvCTC1k2V1rP9pUdzx
 kPcIf9L1NBh+yCuKg/Di3GqFYfIP++U1IM0s0IID94/4bxLoMocIwE9Z0quxyi+jNzL4Qczxb
 nbeovJ2FtBPfFv5mXyc2RVnWF0zOCzwITa8hpDgKFn2RO1wtnnW71UdckgU5nGRKu7HJr5oFg
 Dxs0NaSVg0Slzq8NsWGM6ovOIMXq03mVZ98uVRAAMqt/fX5OrU8ah7+I9oSVZY/znQVp001Tu
 OHHJpCIAoHQQ4HR0EAXbNXzv9/+G0cS9CfApFzcLGXYSBxCi29NSgC0x6CeFvt61TnH8ogEIh
 g/5VE4phEzDjmVoNAbi95uFyOen2BNXtGXgZ1XmkKh/BF+g3ckSJm7p9JkrlYj9ZKR2B928XW
 YV1gxKu/ijlAfQg==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Maíra,

Am 23.10.23 um 16:49 schrieb Maíra Canal:
> The commit c494a447c14e ("soc: bcm: bcm2835-power: Refactor ASB control")
> refactored the ASB control by using a general function to handle both
> the enable and disable. But this patch introduced a subtle regression:
> we need to check if (readl(base + reg) & ASB_ACK) == enable, not just
> check if (readl(base + reg) & ASB_ACK) == true.

thanks for finding this regression

> 
> Currently, this is causing an invalid register state in V3D when
> unloading and loading the driver, because `bcm2835_asb_disable()` will
> return -ETIMEDOUT and `bcm2835_asb_power_off()` will fail to disable the
> ASB slave for V3D.
> 
> Fixes: c494a447c14e ("soc: bcm: bcm2835-power: Refactor ASB control")
> Signed-off-by: Maíra Canal <mcanal@igalia.com>
> ---
>   drivers/pmdomain/bcm/bcm2835-power.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pmdomain/bcm/bcm2835-power.c b/drivers/pmdomain/bcm/bcm2835-power.c
> index 1a179d4e011c..2d3636bc277e 100644
> --- a/drivers/pmdomain/bcm/bcm2835-power.c
> +++ b/drivers/pmdomain/bcm/bcm2835-power.c
> @@ -175,7 +175,7 @@ static int bcm2835_asb_control(struct bcm2835_power *power, u32 reg, bool enable
>   	}
>   	writel(PM_PASSWORD | val, base + reg);
> 
> -	while (readl(base + reg) & ASB_ACK) {
> +	while ((readl(base + reg) & ASB_ACK) == enable) {

but shouldn't it be:

while (!!(readl(base + reg) & ASB_ACK) == enable) ?

>   		cpu_relax();
>   		if (ktime_get_ns() - start >= 1000)
>   			return -ETIMEDOUT;
> --
> 2.41.0
> 
