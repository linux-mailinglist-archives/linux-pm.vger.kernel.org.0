Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DAA38812EB
	for <lists+linux-pm@lfdr.de>; Mon,  5 Aug 2019 09:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbfHEHRi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 5 Aug 2019 03:17:38 -0400
Received: from hel-mailgw-01.vaisala.com ([193.143.230.17]:22329 "EHLO
        hel-mailgw-01.vaisala.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbfHEHRh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 5 Aug 2019 03:17:37 -0400
X-Greylist: delayed 429 seconds by postgrey-1.27 at vger.kernel.org; Mon, 05 Aug 2019 03:17:36 EDT
IronPort-SDR: AiVsvu83aTiditj6bcGQPuocqOVRL70JlYuCuYjJ858UNGxtou3LY7zkkGMN8jnPOOAeJThQjU
 YIRW2/bmY8XRUFu0dAeeHEG1MRG3i6Pa9zjINUVMJ6d/4u5FJHCjE5mZsvJVoLeLUnvm6Ck4Z2
 QhAM/NtQjsn2B8BT1G7FUaEXtLkTOcbl3Ntz/Mt7w5tu6rBe1BOHanV+KJUtU6VXmbddeO9aph
 jH7yXWOuZ0/Dl8HuGebBIO/upipgxj19ZEuGUxvEx95irLWsXAMKL+0s3J/o2rV8Ipir4rBiSo
 uLo=
X-IronPort-AV: E=Sophos;i="5.64,349,1559509200"; 
   d="scan'208";a="227589749"
Subject: Re: [PATCH] power: reset: nvmem-reboot-mode: add CONFIG_OF dependency
To:     Arnd Bergmann <arnd@arndb.de>, Sebastian Reichel <sre@kernel.org>
Cc:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190708125247.3769080-1-arnd@arndb.de>
From:   Nandor Han <nandor.han@vaisala.com>
Message-ID: <6aa562a3-effe-12c2-25d8-47ecf583d724@vaisala.com>
Date:   Mon, 5 Aug 2019 10:10:14 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190708125247.3769080-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 05 Aug 2019 07:10:20.0701 (UTC) FILETIME=[D7CE8CD0:01D54B5C]
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 7/8/19 3:52 PM, Arnd Bergmann wrote:
> Without CONFIG_OF, we get a build failure in the reboot-mode
> implementation:
> 
> drivers/power/reset/reboot-mode.c: In function 'reboot_mode_register':
> drivers/power/reset/reboot-mode.c:72:2: error: implicit declaration of function 'for_each_property_of_node'; did you mean 'for_each_child_of_node'? [-Werror=implicit-function-declaration]
>    for_each_property_of_node(np, prop) {
> 
> Add a Kconfig dependency like we have for the other users of
> CONFIG_REBOOT_MODE.
> 
> Fixes: 7a78a7f7695b ("power: reset: nvmem-reboot-mode: use NVMEM as reboot mode write interface")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   drivers/power/reset/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
> index 8dfb105db391..a564237278ff 100644
> --- a/drivers/power/reset/Kconfig
> +++ b/drivers/power/reset/Kconfig
> @@ -248,6 +248,7 @@ config POWER_RESET_SC27XX
>   
>   config NVMEM_REBOOT_MODE
>   	tristate "Generic NVMEM reboot mode driver"
> +	depends on OF
>   	select REBOOT_MODE
>   	help
>   	  Say y here will enable reboot mode driver. This will
> 

Wouldn't this be more appropriate to add the "depends on OF" to "config 
REBOOT_MODE" section, since this is an error to `reboot-mode.c` unit?

Nandor
