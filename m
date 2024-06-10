Return-Path: <linux-pm+bounces-8865-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF038902082
	for <lists+linux-pm@lfdr.de>; Mon, 10 Jun 2024 13:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45ABB2846E2
	for <lists+linux-pm@lfdr.de>; Mon, 10 Jun 2024 11:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C61CB7D414;
	Mon, 10 Jun 2024 11:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=norik.com header.i=@norik.com header.b="hhcPhmlB"
X-Original-To: linux-pm@vger.kernel.org
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2C47E0E8;
	Mon, 10 Jun 2024 11:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.19.9.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718019571; cv=none; b=lk+2hajQAUN7s1HNEhqWUGYx2LxYtBcnf7fx1mGEHlQ/o/o08VViCNgPh3O080T9E1jn8aROVUrp4nU2UsFyUgzqsBl0JhqGlTjZTy/3BPbdL9+cMzgb8SpuFTlcJnT0Y31k2faD2Fwu0aN8XWUTj1QBBaitJmFIXKCYap7D9YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718019571; c=relaxed/simple;
	bh=OiP6Bx2iI8AAJBotZLPsERecn+WuQKicWwj+JsxImZ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P7mqwRrccKNZciA/etNX7V7y14DdEoxkMsPxhka5xjjtbxsp7OFlKQU/JEoNGEgvmOpb67lkf6iGxUxkbYQcleXTOH1Zwl9BOKklCNe20XOcY/uNke1tEFW8UgyfrjkaYIdHvE5w345U9BN7s9YIwV4kyQaA7HdOOHupjloZY6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com; spf=pass smtp.mailfrom=norik.com; dkim=pass (2048-bit key) header.d=norik.com header.i=@norik.com header.b=hhcPhmlB; arc=none smtp.client-ip=46.19.9.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=norik.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=yXg8ExlqjWnKLMYOlLaWW7wX0EdTDT1fjpBKYh1NfqU=; b=hhcPhmlB99XIy0K+waoY6iousa
	vtZgnYLiwy+GQKn/AaUVP1W7SYmLZZbVOaW4HUUPGGfS8QL7GOxyH2m79nut+BpXcMmHGe04j568J
	97irjGfNlp7qdK2pjwFpijZBuqzO/5pwMVh9IlFtFZLDv//MsJ/0zX1JR7qSnGWJLEjgyAURZsbba
	G3Hp7xLQ/vP9zInEvljPhW3/EdOArL7CorWEOA/uYNkjYzTWElrFl2iv/PWTNxkcHwrtV4cZ2yk1l
	3LGmZXUNnxsl4oI1+GtTm0Z5i7enLUWSo3LZss0GLayjGpY7CQUGvVSLk5hcJIw7ZKo1BANYzSrkv
	0AU56lxQ==;
Received: from 89-212-21-243.static.t-2.net ([89.212.21.243]:42114 helo=[192.168.69.116])
	by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <primoz.fiser@norik.com>)
	id 1sGdMv-00Bzgp-24;
	Mon, 10 Jun 2024 13:39:21 +0200
Message-ID: <00ec4120-19ca-4b20-85d0-754c05bdc669@norik.com>
Date: Mon, 10 Jun 2024 13:39:20 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] OPP: ti: Use devm_pm_opp_set_config_regulators
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
 Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, upstream@lists.phytec.de
References: <20240606113334.396693-1-primoz.fiser@norik.com>
 <20240606113334.396693-2-primoz.fiser@norik.com>
 <20240610042250.xccda2pr277v6asf@vireshk-i7>
From: Primoz Fiser <primoz.fiser@norik.com>
Content-Language: en-US
Organization: Norik systems d.o.o.
In-Reply-To: <20240610042250.xccda2pr277v6asf@vireshk-i7>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel.siel.si
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cpanel.siel.si: authenticated_id: primoz.fiser@norik.com
X-Authenticated-Sender: cpanel.siel.si: primoz.fiser@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Hi Viresh,

On 10. 06. 24 06:22, Viresh Kumar wrote:
> Hi Primoz,
> 
> Thanks for your changes, they look exactly as we discussed earlier, but .. 
> 
> On 06-06-24, 13:33, Primoz Fiser wrote:
>> Function ti_opp_supply_probe() since commit 6baee034cb55 ("OPP: ti:
>> Migrate to dev_pm_opp_set_config_regulators()") returns wrong values
>> when all goes well and hence driver probing eventually fails.
>>
>> Switch to using devm_pm_opp_set_config_regulators() function that
>> correctly handles return values and doesn't require us to handle
>> returned tokens.
>>
>> Fixes: 6baee034cb55 ("OPP: ti: Migrate to dev_pm_opp_set_config_regulators()")
>> Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>
>> ---
>>  drivers/opp/ti-opp-supply.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/opp/ti-opp-supply.c b/drivers/opp/ti-opp-supply.c
>> index e3b97cd1fbbf..8a4bcc5fb9dc 100644
>> --- a/drivers/opp/ti-opp-supply.c
>> +++ b/drivers/opp/ti-opp-supply.c
>> @@ -392,7 +392,7 @@ static int ti_opp_supply_probe(struct platform_device *pdev)
>>  			return ret;
>>  	}
>>  
>> -	ret = dev_pm_opp_set_config_regulators(cpu_dev, ti_opp_config_regulators);
>> +	ret = devm_pm_opp_set_config_regulators(cpu_dev, ti_opp_config_regulators);
>>  	if (ret < 0)
>>  		_free_optimized_voltages(dev, &opp_data);
> 
> -- I made a mistake.

:(

> 
> The driver gets probed with a platform device, while
> devm_pm_opp_set_config_regulators() works with cpu device. And so the
> issue related to module insertion/removal/insertion will still be
> there :(.
> 
> Did you try that though ?

I didn't because of:

config ARM_TI_CPUFREQ

        bool "Texas Instruments CPUFreq support"


is a built-in driver.

Anyway, I guess one could trigger this also with:

$ cd /sys/devices/platform/ocp/4a003b20.opp-supply/driver
$ echo 4a003b20.opp-supply > unbind
$ echo 4a003b20.opp-supply > bind

[  164.231781] ------------[ cut here ]------------
[  164.236450] WARNING: CPU: 1 PID: 230 at drivers/opp/core.c:2474
dev_pm_opp_set_config+0x384/0x634
[  164.245422] Modules linked in: sha256_generic libsha256 sha256_arm
cfg80211 uas usb_storage xhci_plat_hcd xhci_hcd usbcore dwc3 roles
udc_core pru_rproc irq_pruss_intc usb_common rpmsg_ctrl rpmsg_char etnaviv
 ti_vpe ti_vip snd_soc_simple_card gpu_sched ti_sc bq27xxx_battery_hdq
bq27xxx_battery snd_soc_simple_card_utils pvrsrvkm(O) snd_soc_omap_hdmi
ahci_dwc ti_csc libahci_platform v4l2_mem2mem ti_vpdma libahci omap_
aes_driver videobuf2_dma_contig libaes videobuf2_memops videobuf2_v4l2
c_can_platform pruss libata videobuf2_common c_can omap_wdt
phy_omap_usb2 can_dev omap_hdq dwc3_omap omap_des
snd_soc_tlv320aic3x_i2c snd_so
c_tlv320aic3x libdes rtc_omap wire at24 omap_crypto palmas_pwrbutton
extcon_palmas rtc_palmas omap_sham crypto_engine omap_remoteproc
virtio_rpmsg_bus rpmsg_ns sch_fq_codel cryptodev(O) cmemk(O)
[  164.318298] CPU: 1 PID: 230 Comm: sh Tainted: G           O
6.1.80-bsp-yocto-ampliphy-am57x-kirkstone #1
[  164.328369] Hardware name: Generic DRA74X (Flattened Device Tree)
[  164.334472]  unwind_backtrace from show_stack+0x10/0x14
[  164.339752]  show_stack from dump_stack_lvl+0x40/0x4c
[  164.344818]  dump_stack_lvl from __warn+0x94/0xc0
[  164.349578]  __warn from warn_slowpath_fmt+0x1a4/0x1ac
[  164.354736]  warn_slowpath_fmt from dev_pm_opp_set_config+0x384/0x634
[  164.361236]  dev_pm_opp_set_config from devm_pm_opp_set_config+0xc/0x44
[  164.367889]  devm_pm_opp_set_config from ti_opp_supply_probe+0x1c8/0x2f4
[  164.374633]  ti_opp_supply_probe from platform_probe+0x5c/0xbc
[  164.380493]  platform_probe from really_probe+0xc8/0x2ec
[  164.385833]  really_probe from __driver_probe_device+0x88/0x1a0
[  164.391815]  __driver_probe_device from device_driver_attach+0x40/0x98
[  164.398376]  device_driver_attach from bind_store+0x80/0xec
[  164.403991]  bind_store from kernfs_fop_write_iter+0x10c/0x1cc
[  164.409851]  kernfs_fop_write_iter from vfs_write+0x2a0/0x3c8
[  164.415649]  vfs_write from ksys_write+0x5c/0xd4
[  164.420288]  ksys_write from ret_fast_syscall+0x0/0x4c
[  164.425445] Exception stack(0xf2359fa8 to 0xf2359ff0)
[  164.430511] 9fa0:                   00000014 00539568 00000001
00539568 00000014 00000000
[  164.438751] 9fc0: 00000014 00539568 b6f5c5a0 00000004 00000014
0050cc08 00000000 00000000
[  164.446960] 9fe0: 00000004 bed839d8 b6e80827 b6e01ae6
[  164.452056] ---[ end trace 0000000000000000 ]---
[  164.456726] ti_opp_supply: probe of 4a003b20.opp-supply failed with
error -16
-sh: echo: write error: Device or resource busy

so the error comes from drivers/opp/core.c block:

	/* This should be called before OPPs are initialized */
	if (WARN_ON(!list_empty(&opp_table->opp_list))) {
		ret = -EBUSY;
		goto err;
	}


> 
> The only way to get this solved is probably by introducing a remove()
> method, which clears the OPP config and stores the token returned by
> dev_pm_opp_set_config_regulators().
> 

I did some additional experiments today by adding .remove_new callback
and calling dev_pm_opp_clear_config() in it.

However I still get the same error as above.

Unforunatelly, I cannot test on latest master since it doesn't boot yet
on my board (still using linux-ti 6.1).

Shall we store token and not call dev_pm_opp_set_config_regulators() in
probe() if token has been already aquired once?

BR,
Primoz

