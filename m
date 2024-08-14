Return-Path: <linux-pm+bounces-12236-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB9DA95244F
	for <lists+linux-pm@lfdr.de>; Wed, 14 Aug 2024 22:55:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79A5C1F28B4F
	for <lists+linux-pm@lfdr.de>; Wed, 14 Aug 2024 20:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A76E11C688D;
	Wed, 14 Aug 2024 20:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="ok7bByok"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199511BE877;
	Wed, 14 Aug 2024 20:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723668923; cv=none; b=j8FwZk/sknrd98SYFGUKSZYkP0VgtLENfEKA6985s7yc+PIeQZK3fvSg4WY+kXTtPrJHphHxVOXtM69J5PttTtxtpv54DXtx+4uzQ4AYLyfHExHcOBpFyWhdRZdGQS67AAEln2ALaSr9cXFKxOfse4a+M/62KfYbXb/Iap/qFr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723668923; c=relaxed/simple;
	bh=/Bv3p20GFDeAsBwUDKWPWVBBysKvn9baZiikL++ChNU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iNlZ7iwJdQBvMAxYLdLMawR+m/VMYQI1ppvT2gnToKBMgAWsY2fW7bVaQTMDQD7CUhqCSqcnlHXp5+G5EVmcnMTU0SR2dmd49QwnvL+7bpMT8v0sa/9XqmyNNBMwVRX7J6HEu2pOGU8/ZXAoMpM3ytHGHTUFAxfs6t1qcdTETyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=ok7bByok; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1723668884; x=1724273684; i=wahrenst@gmx.net;
	bh=A5HpoTDVSE1dS0ZLEhv9UsGr/Pgabg63vssx9s0dUQw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ok7bByokyabDbFVZUEgsh0wGkoXK6ueGCm5xIT0Bcx9qdv3e2BZ2eEoO4zbFdDZQ
	 tOyuPYGt8pQefrH8RbqRBAnLqDrYYaZhJqs23LY67Ilep0AtD/x4wJjeWrdO/RUTz
	 ORbp3KWZs89EWreIjVi7s4czEDr0iPEBF9ZH2atYua1zU6FcFJByNrxvubjykqyBP
	 ayzsfWgR+3u5cVhLQhJvsmvmNmnytSW021EhA2S+0EQpNXqw1xs/GmQB8KO6K834c
	 fVxreev0YQBh0nQo7mnmQgWcqXG/bzSXKVCP4pMPFqRsbGziBfRlNu84WcZZWR1la
	 Un+W0bFpOtwXdadr7g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.127] ([37.4.248.43]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N4hvb-1sDMPs47zb-010U3p; Wed, 14
 Aug 2024 22:54:44 +0200
Message-ID: <462f908d-7df5-4e8f-a15f-53e66459d488@gmx.net>
Date: Wed, 14 Aug 2024 22:54:41 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 15/16] serial: 8250_bcm2835aux: add PM suspend/resume
 support
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui
 <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
 Maxime Ripard <mripard@kernel.org>, Jassi Brar <jassisinghbrar@gmail.com>,
 =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Jiri Slaby <jirislaby@kernel.org>, Minas Harutyunyan <hminas@synopsys.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Lukas Wunner <lukas@wunner.de>,
 Artur Petrosyan <Arthur.Petrosyan@synopsys.com>,
 Peter Robinson <pbrobinson@gmail.com>, dri-devel@lists.freedesktop.org,
 bcm-kernel-feedback-list@broadcom.com, linux-pm@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kernel-list@raspberrypi.com
References: <20240728114200.75559-1-wahrenst@gmx.net>
 <20240728130029.78279-1-wahrenst@gmx.net>
 <20240728130029.78279-7-wahrenst@gmx.net>
 <CAPDyKFoJh3j8xSeXZ9o031YZLTCDYVA+dgvURuwozjDpU_aauA@mail.gmail.com>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <CAPDyKFoJh3j8xSeXZ9o031YZLTCDYVA+dgvURuwozjDpU_aauA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:GWkQ30JTD9xmzJR7P4IsreC0adykqs3k0ETwX0XotEfmlCrcnxI
 MGUBUkwDz8LCP6J8AjbtMm1Q/awqSTaNghR5KlrGCLJ2cLgJckBX5SF/J004XIGbOkJXbCV
 hUq7yrgoPZXrAWPvUEi9kpO+Bp12Bpgu078Px16rIC0/Uy8eHBcSrVY3EGbCv+X9W3F1wVu
 ew5PZASbz/KKWNcS+ULwA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Ctmz0U7Ph4o=;MmV7zzrqdjpwjCOlu26xVqoag1l
 2KVavzjNJ1nyY/nMexXJ1AbcetoBu1FSftP3vcDGtbAU+6OxleJKDu+1CA/OqpIUdjkAGsKoV
 k7aE5a0+u/hTjKvDHawn/rjeJDsYimqH+cyQKL9qxOuel4qYdxwt3XlzztMEh0/O2wjzMp2aX
 x0HDJFZEpjFM7rA98cqnLtGZYn2msoB39UV1fNxxm97sQpLD/0qDcUfJIk0SDtLdsYKUTrVgA
 fLKp5qJElomV+IF+GuKgyPnyVr3cOnoeyfkVGMm3D1ibw11xaa4BRoVcVgBuXG4V59dUuifcE
 jzoaUVh/e1/v0UAOu6iuE/3ioKIpXoCnTfqamSCSQP4WFIAyXa+JBw+XGTqd2mKZ4zCMv/Qs+
 eQaEZVVMzy2hH47E9PUFD9ewETkgVF0tcEe70yp96oskVhzqz13wM5M3JvtAI7Q925PRnLScY
 Uo3w62VnTSv97OJ6i0cubQQY2NgxZQRXOEdF/LpquY2C6teJaCkTmrBc9ELxNeCvIu38uGL1c
 C4Z6jBlREOw6W7VCF6FQ1rf+IVXwGIaihYhycvSuMyC5eZq/B+poTpkTMH8Y2Bx6sEUh4r+ys
 HS0PXH8rvfdry0srvpTXhqqHJngQXRbFhtTJw//TbKz4K7JvnrQqI5UEQuAra4FOhDg5/BFw8
 SVbTaDA0ZQY8Yvib3o+iiayn9UieV9+lbEOUlJDKOLU2ar8RIzdeU0FDn1r0FeNsNGdUPIvtz
 eGehCQ9SKTSGLPB/4vLKiCAckoOxK05jfF9U0VuRINmifesSCnzA9pcyv9uU+WURbAPKYCgly
 aWpDC4Spt1dimDdYp2DLVABg==

Am 14.08.24 um 14:18 schrieb Ulf Hansson:
> On Sun, 28 Jul 2024 at 15:07, Stefan Wahren <wahrenst@gmx.net> wrote:
>> This adds suspend/resume support for the 8250_bcm2835aux
>> driver to provide power management support on attached
>> devices.
>>
>> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
>> ---
>>   drivers/tty/serial/8250/8250_bcm2835aux.c | 37 +++++++++++++++++++++++
>>   1 file changed, 37 insertions(+)
>>
>> diff --git a/drivers/tty/serial/8250/8250_bcm2835aux.c b/drivers/tty/serial/8250/8250_bcm2835aux.c
>> index 121a5ce86050..36e2bb34d82b 100644
>> --- a/drivers/tty/serial/8250/8250_bcm2835aux.c
>> +++ b/drivers/tty/serial/8250/8250_bcm2835aux.c
>> @@ -13,6 +13,7 @@
>>    */
>>
>>   #include <linux/clk.h>
>> +#include <linux/console.h>
>>   #include <linux/io.h>
>>   #include <linux/module.h>
>>   #include <linux/of.h>
>> @@ -213,11 +214,47 @@ static const struct acpi_device_id bcm2835aux_serial_acpi_match[] = {
>>   };
>>   MODULE_DEVICE_TABLE(acpi, bcm2835aux_serial_acpi_match);
>>
>> +static int bcm2835aux_suspend(struct device *dev)
>> +{
>> +       struct bcm2835aux_data *data = dev_get_drvdata(dev);
>> +       struct uart_8250_port *up = serial8250_get_port(data->line);
>> +
>> +       serial8250_suspend_port(data->line);
>> +
>> +       if (device_may_wakeup(dev))
>> +               return 0;
>> +
>> +       if (uart_console(&up->port) && !console_suspend_enabled)
>> +               return 0;
>> +
>> +       clk_disable_unprepare(data->clk);
>> +       return 0;
>> +}
>> +
>> +static int bcm2835aux_resume(struct device *dev)
>> +{
>> +       struct bcm2835aux_data *data = dev_get_drvdata(dev);
>> +       int ret;
>> +
>> +       ret = clk_prepare_enable(data->clk);
> Doesn't this create clk prepare/enable - unprepare/disable imbalance
> problem when the uart is configured for system wakeup?
Thanks, i will send a follow-up

Regards
>
>> +       if (ret)
>> +               return ret;
>> +
>> +       serial8250_resume_port(data->line);
>> +
>> +       return 0;
>> +}
>> +
>> +static const struct dev_pm_ops bcm2835aux_dev_pm_ops = {
>> +       SYSTEM_SLEEP_PM_OPS(bcm2835aux_suspend, bcm2835aux_resume)
>> +};
>> +
>>   static struct platform_driver bcm2835aux_serial_driver = {
>>          .driver = {
>>                  .name = "bcm2835-aux-uart",
>>                  .of_match_table = bcm2835aux_serial_match,
>>                  .acpi_match_table = bcm2835aux_serial_acpi_match,
>> +               .pm = pm_ptr(&bcm2835aux_dev_pm_ops),
>>          },
>>          .probe  = bcm2835aux_serial_probe,
>>          .remove_new = bcm2835aux_serial_remove,
>> --
>> 2.34.1
>>
> Kind regards
> Uffe
>


