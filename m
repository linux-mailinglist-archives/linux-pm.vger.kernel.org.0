Return-Path: <linux-pm+bounces-39931-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E1712CDD970
	for <lists+linux-pm@lfdr.de>; Thu, 25 Dec 2025 10:33:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 65F4B3015177
	for <lists+linux-pm@lfdr.de>; Thu, 25 Dec 2025 09:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A89C279DC3;
	Thu, 25 Dec 2025 09:33:47 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BFE923EAB6;
	Thu, 25 Dec 2025 09:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766655227; cv=none; b=b4EFt+dVpy2NDt3L2SNaYxOTAQaaI1EtSXGz4slRspIoDt0CJTxDhKakRP3zlGT29t4p1SDgMpzn8WtnRy1c/us5gXllb/giBFd8IKIaidru1PHC3g958Y7mzHMNe/m970ucqJkjb4i+05HoSP2qdFwXQnmwNNaltHwrg3aGxRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766655227; c=relaxed/simple;
	bh=w1xapEhESvrRXoIIo2QFizy4DiFHNCF+imb/w+yvE0I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g/e6M7dyldwDd/RSMbFdmCVP9ODIwNyyjBTGIt2v23cOf1W0qFOq2URW4vNKyI0gnae18jfPMptyhy+mr7JyoL4qwBV+ZWJoOOjfki65/lkAJr2uimO6aBUMWT3Z6Rqw0cEUlEkGjZJMl4NAFAWO1bVWiMifVfJXOQvXXT/59mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: c8f91a62e17411f0a38c85956e01ac42-20251225
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:61cee32f-9124-4909-8761-4e06d1000f00,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:19a89b60e5c5e2880c988ccd0e7200f1,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|898,TC:nil,Content:0|15|
	52,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0
	,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: c8f91a62e17411f0a38c85956e01ac42-20251225
X-User: luriwen@kylinos.cn
Received: from [10.42.13.61] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <luriwen@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 562864616; Thu, 25 Dec 2025 17:33:35 +0800
Message-ID: <227b6cdc-2abb-47d4-8a92-ff4fad2f2d9e@kylinos.cn>
Date: Thu, 25 Dec 2025 17:33:32 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] Re: [PATCH v3] PM: suspend: Make pm_test delay
 interruptible by wakeup events
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: pavel@kernel.org, lenb@kernel.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, xiongxin <xiongxin@kylinos.cn>,
 regressions@lists.linux.dev
References: <20251113012638.1362013-1-luriwen@kylinos.cn>
 <CAJZ5v0hwhVO6J2nS2-byU0+Lm8QbzdBzv4-X4eLNNUpTg+41Kg@mail.gmail.com>
 <aUsAk0k1N9hw8IkY@venus>
 <CAJZ5v0jha1VEHGfqYfu1G9WCwPEM=kDa-_c1LqchnkxAWbCBiw@mail.gmail.com>
Content-Language: en-US
From: luriwen <luriwen@kylinos.cn>
In-Reply-To: <CAJZ5v0jha1VEHGfqYfu1G9WCwPEM=kDa-_c1LqchnkxAWbCBiw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

在 2025/12/24 19:44, Rafael J. Wysocki 写道:
> On Tue, Dec 23, 2025 at 10:09 PM Sebastian Reichel
> <sebastian.reichel@collabora.com> wrote:
>> Hi,
>>
>> On Fri, Nov 14, 2025 at 05:11:16PM +0100, Rafael J. Wysocki wrote:
>>> On Thu, Nov 13, 2025 at 2:26 AM Riwen Lu <luriwen@kylinos.cn> wrote:
>>>> Modify the suspend_test() function to make the test delay can be
>>>> interrupted by wakeup events.
>>>>
>>>> This improves the responsiveness of the system during suspend testing
>>>> when wakeup events occur, allowing the suspend process to proceed
>>>> without waiting for the full test delay to complete when wakeup events
>>>> are detected.
>>>>
>>>> Additionally, using msleep() instead of mdelay() avoids potential soft
>>>> lockup "CPU stuck" issues when long test delays are configured.
>>>>
>>>> Co-developed-by: xiongxin <xiongxin@kylinos.cn>
>>>> Signed-off-by: xiongxin <xiongxin@kylinos.cn>
>>>> Signed-off-by: Riwen Lu <luriwen@kylinos.cn>
>>>> ---
>>>>   kernel/power/suspend.c | 6 +++++-
>>>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
>>>> index b4ca17c2fecf..1c2f777da367 100644
>>>> --- a/kernel/power/suspend.c
>>>> +++ b/kernel/power/suspend.c
>>>> @@ -344,10 +344,14 @@ MODULE_PARM_DESC(pm_test_delay,
>>>>   static int suspend_test(int level)
>>>>   {
>>>>   #ifdef CONFIG_PM_DEBUG
>>>> +       int i;
>>>> +
>>>>          if (pm_test_level == level) {
>>>>                  pr_info("suspend debug: Waiting for %d second(s).\n",
>>>>                                  pm_test_delay);
>>>> -               mdelay(pm_test_delay * 1000);
>>>> +               for (i = 0; i < pm_test_delay && !pm_wakeup_pending(); i++)
>>>> +                       msleep(1000);
>>>> +
>>>>                  return 1;
>>>>          }
>>>>   #endif /* !CONFIG_PM_DEBUG */
>>>> --
>>> Applied as 6.19 material, thanks!
>> This is now upstream as a10ad1b10402 ("PM: suspend: Make pm_test delay interruptible by wakeup events").
>> When doing the following PM debugging test on ROCK 4D on v6.19-rc2
>>
>> echo N > /sys/module/printk/parameters/console_suspend
>> echo 1 > /sys/power/pm_print_times
>> echo 1 > /sys/power/pm_debug_messages
>> echo core > /sys/power/pm_test
>> echo mem > /sys/power/state
>>
>> I see the following error triggered reliably, which did not happen on 6.18
>> and no longer appears after reverting this patch:
>>
>> [   49.647656] ------------[ cut here ]------------
>> [   49.647656] WARNING: kernel/time/timekeeping.c:821 at ktime_get+0xb8/0xd8, CPU#0: swapper/0/0
>> [   49.647656] Modules linked in: sha256 cfg80211 binfmt_misc fuse ipv6 snd_soc_hdmi_codec rk805_pwrkey rockchip_saradc dwmac_rk stmmac_platform rtc_hym8563 snd_soc_es8328_i2c phy_rockchip_usbdp rockchipdrm stmmac snd_soc_es8328 dw_hdmi_qp industrialio_triggered_buffer analogix_dp typec phy_rockchip_samsung_hdptx kfifo_buf dw_dp rockchip_thermal dw_mipi_dsi spi_rockchip_sfc phy_rockchip_naneng_combphy pcs_xpcs panfrost drm_shmem_helper gpu_sched snd_soc_rockchip_sai snd_soc_simple_card drm_dp_aux_bus dw_hdmi snd_soc_simple_card_utils rfkill_gpio rfkill snd_soc_core drm_display_helper snd_compress cec drm_client_lib drm_dma_helper display_connector snd_pcm_dmaengine drm_kms_helper snd_pcm drm snd_timer snd backlight soundcore adc_keys
>> [   49.647656] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.19.0-rc2-g7211b2cf9c08 #1 PREEMPT
>> [   49.647656] Hardware name: Radxa ROCK 4D (DT)
>> [   49.647656] pstate: 800000c5 (Nzcv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>> [   49.647656] pc : ktime_get+0xb8/0xd8
>> [   49.647656] lr : tick_nohz_idle_enter+0x50/0x90
>> [   49.647656] sp : ffffc1a17b573d50
>> [   49.647656] x29: ffffc1a17b573d50 x28: 00000000fdf57ec0 x27: ffffc1a17b57b260
>> [   49.647656] x26: ffffc1a17b57e000 x25: 0000000000000000 x24: 00000000000000ea
>> [   49.647656] x23: ffffc1a17a470000 x22: ffffc1a17b57ad00 x21: ffff3e6282a25000
>> [   49.647656] x20: ffff0003fdead5d8 x19: ffffc1a17b4885d8 x18: 000000000000000a
>> [   49.647656] x17: ffff3e6282a25000 x16: ffff800080000000 x15: 00700ea231d1d404
>> [   49.647656] x14: 0000000000000396 x13: 0000000000000001 x12: 0000000000000001
>> [   49.647656] x11: 00000000000000c0 x10: 0000000000000aa0 x9 : ffffc1a17b573d00
>> [   49.647656] x8 : ffffc1a17b586680 x7 : 0000000000000000 x6 : 0000000000000000
>> [   49.647656] x5 : 0000000000000004 x4 : ffffc1a17b57eb68 x3 : 0000000000000000
>> [   49.647656] x2 : ffffc1a17b48ec40 x1 : 0000000000000000 x0 : 0000000000000001
>> [   49.647656] Call trace:
>> [   49.647656]  ktime_get+0xb8/0xd8 (P)
>> [   49.647656]  tick_nohz_idle_enter+0x50/0x90
>> [   49.647656]  do_idle+0x38/0x260
>> [   49.647656]  cpu_startup_entry+0x38/0x40
>> [   49.647656]  rest_init+0xd8/0xe0
>> [   49.647656]  console_on_rootfs+0x0/0x6c
>> [   49.647656]  __primary_switched+0x88/0x90
>> [   49.647656] ---[ end trace 0000000000000000 ]---
> msleep() is not suitable for the "core" level testing.
>
> Change msleep() in suspend_test() back to mdelay() and the backtrace
> should go away.
>
> I'll send a patch for that later this week unless someone beats me to it.

Maybe usingmdelay() only forTEST_CORE while keepingmsleep() for other 
test levels ?


