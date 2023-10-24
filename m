Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 092257D471D
	for <lists+linux-pm@lfdr.de>; Tue, 24 Oct 2023 07:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232463AbjJXFy6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Oct 2023 01:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232458AbjJXFy5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 Oct 2023 01:54:57 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E13C69D
        for <linux-pm@vger.kernel.org>; Mon, 23 Oct 2023 22:54:54 -0700 (PDT)
Received: from [192.168.1.129] ([37.4.248.43]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1Mf0uq-1rRjEW2tmk-00gUtt; Tue, 24 Oct 2023 07:54:18 +0200
Message-ID: <b6392022-b74c-4b8b-8153-2b77d637139f@i2se.com>
Date:   Tue, 24 Oct 2023 07:54:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] pmdomain: bcm: bcm2835-power: check if the ASB
 register is equal to enable
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
References: <20231023233545.529519-2-mcanal@igalia.com>
Content-Language: en-US
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <20231023233545.529519-2-mcanal@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:LjC6OzfMlIr1Kr8UFMOJAW4UFFrOZq3ug9PhATQIzaRvYk7vSSH
 be/Ws8sBnbQZD1Si9xLVbsEX4yz8xVMMyIkzktutnmPAkX71iHd7cMmVhQr5aXpIEcSNQRG
 J0c9ukByMLgju4GbLvKI49BueUqdAnn3P2FmsXv1fxOB/Ila1T7Y65BsFVI9Im7kbHH6Lx9
 AexIn6zRWYOzyPx6VzncQ==
UI-OutboundReport: notjunk:1;M01:P0:TZ7QRsqc3Bc=;gkbzaoKfSW379KyPrSxh823FWjp
 oreS7m5T6hcF2gCy+Beny25muHZ9z7KOTFqxIssrV0txnItiYHc0KylTtgB29w9UTbkHOe6IZ
 Tb1Qy/QeWhBTM1Is7Gz+hhoHjZUugtC08niJkHXfC1eQhlownW/LL7RJLPJ0vN5EfljPu8muo
 myPaCJr/UrAo54yMmIm2OC/Zpou797vPlUJ4YDncrslVNqm5trc+AG9mvJq+bByRRYn6LhZFd
 dTxRD0AmNv5ZFOwuEAABPjcxPgFzBdCUqFXM0O1ZdcAOjKyXhS2Lawi0uFn/Mjtgjke37TPVb
 pOjJs6mGqunznwZuMnfGud4F4Pk97sv4yPGzIzKKNTHGreUUhZPPfxOWw3jzslfOJJfjXvMm9
 GIhujM6Lc6LifEbfIZfVKRPb/3vE6R7dCBNmGHHwV9y0iuQnZzoAckmOegy+618RfGsAzQRb4
 wWMeq9EEXy4DF2O0GQ37BN/EN0w8rlXg/1sAQ2p0GgJVxdcF5DJeTjjuFQ0p11zk1eNId0UCB
 5hBILd7sIS5reKVJpYTSbcZTOmkR4CUdSMQ2CZiU59KDMdOuSSu7ig1/BnLOfrdE5zTLzXkRw
 lYhKjWwjd/f22bOoLHrArhOM3s6YCBrOy6OQwD2fAjJG3OT65uzxscmHI6P3zrw1rUifu87b+
 S8fiUvhZ5C0d2Fftx2fhP7U6SHDocIKVtudhTCnZ4IlUMsuVrLpz40yEG8ZyW+UxaH3oN3BlN
 lv/x4HgQtDlQDmOyg2ENVZ1z+jD9jj+FwDEgdWKrDLqfSyGVzrAOuHIWj43FbbAWIjtpSN3Qh
 Z68DN9d+xRdi77CKGi+Y7PjPucW1KCbKo0ZU95Aohn7Jd1yg/2QqSa7Bn0DdApFvNos+cJQP9
 gr7VbzT4QLpEZfA==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Maíra,

Am 24.10.23 um 01:35 schrieb Maíra Canal:
> The commit c494a447c14e ("soc: bcm: bcm2835-power: Refactor ASB control")
> refactored the ASB control by using a general function to handle both
> the enable and disable. But this patch introduced a subtle regression:
> we need to check if !!(readl(base + reg) & ASB_ACK) == enable, not just
> check if (readl(base + reg) & ASB_ACK) == true.
> 
> Currently, this is causing an invalid register state in V3D when
> unloading and loading the driver, because `bcm2835_asb_disable()` will
> return -ETIMEDOUT and `bcm2835_asb_power_off()` will fail to disable the
> ASB slave for V3D.
> 
> Fixes: c494a447c14e ("soc: bcm: bcm2835-power: Refactor ASB control")
> Signed-off-by: Maíra Canal <mcanal@igalia.com>
> ---

could you please resubmit with a proper changelog (including the 
Reviewed-bys) of this patch?

Reviewed-by: Stefan Wahren <stefan.wahren@i2se.com>

Thanks

>   drivers/pmdomain/bcm/bcm2835-power.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pmdomain/bcm/bcm2835-power.c b/drivers/pmdomain/bcm/bcm2835-power.c
> index 1a179d4e011c..d2f0233cb620 100644
> --- a/drivers/pmdomain/bcm/bcm2835-power.c
> +++ b/drivers/pmdomain/bcm/bcm2835-power.c
> @@ -175,7 +175,7 @@ static int bcm2835_asb_control(struct bcm2835_power *power, u32 reg, bool enable
>   	}
>   	writel(PM_PASSWORD | val, base + reg);
> 
> -	while (readl(base + reg) & ASB_ACK) {
> +	while (!!(readl(base + reg) & ASB_ACK) == enable) {
>   		cpu_relax();
>   		if (ktime_get_ns() - start >= 1000)
>   			return -ETIMEDOUT;
> --
> 2.41.0
> 
