Return-Path: <linux-pm+bounces-1090-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40461811265
	for <lists+linux-pm@lfdr.de>; Wed, 13 Dec 2023 14:03:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 720781C2085F
	for <lists+linux-pm@lfdr.de>; Wed, 13 Dec 2023 13:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F5D2C1BF;
	Wed, 13 Dec 2023 13:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="kxoqNvMc"
X-Original-To: linux-pm@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B7319AD;
	Wed, 13 Dec 2023 05:02:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1702472578; x=1734008578;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=haSX0tbr6yXtmrKq5D0/IHoQGGhGGvZ70eGFTY33y5k=;
  b=kxoqNvMcQtqZOmnYxs3Eo20L9K6pB6avZJ/QcpfL9RA35qioy7vBLcNN
   fAHJt425iH1zIWjEr3YmcR24Ax1niq0pwBnEyuYMmLi0oiMzZtWpRbf1V
   N4r/Xq4igjMGD8ggmSMTQ7F/H7dHEJWAOSIV/I3wf8PeG4/jomtOP7d9G
   AlHnP4hPpYRSHvTg+uQSDIgArgsOA3lPR57wibypdVZvxV0YdePlcGWH/
   cMaJ6beKn64gGQgDgeifPQnT5tm9s+3046wk260ncV+RJCnqSO5y8LAyG
   zdWbC7UO5h8FUDqd+S3T/I2DFuwGDs+IeeTcfmxakaJ1TGNQIoRbBtyk+
   g==;
X-CSE-ConnectionGUID: 05LR7F6bQ9qnL0D+1qr56w==
X-CSE-MsgGUID: 7bg/nqvNSM6QxELaojNYqg==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.04,272,1695711600"; 
   d="scan'208";a="243933255"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Dec 2023 06:02:56 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 13 Dec 2023 06:02:16 -0700
Received: from [10.171.248.29] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 13 Dec 2023 06:02:13 -0700
Message-ID: <d9b7c682-97f7-4a09-a534-9954865cfc29@microchip.com>
Date: Wed, 13 Dec 2023 14:01:30 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] power: reset: at91: mark at91_wakeup_status non-__init
Content-Language: en-US, fr-FR
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Nathan
 Chancellor <nathan@kernel.org>, Sebastian Reichel <sre@kernel.org>
CC: Arnd Bergmann <arnd@kernel.org>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Arnd Bergmann <arnd@arndb.de>, Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>, Yangtao Li <frank.li@vivo.com>,
	<linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <llvm@lists.linux.dev>
References: <20231212214658.213510-1-arnd@kernel.org>
 <20231212215002.GA3300655@dev-arch.thelio-3990X>
 <20231213072521.z7a37uayjide7ui4@pengutronix.de>
From: Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <20231213072521.z7a37uayjide7ui4@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit

On 13/12/2023 at 08:25, Uwe Kleine-König wrote:
> On Tue, Dec 12, 2023 at 02:50:02PM -0700, Nathan Chancellor wrote:
>> On Tue, Dec 12, 2023 at 10:46:49PM +0100, Arnd Bergmann wrote:
>>> From: Arnd Bergmann<arnd@arndb.de>
>>>
>>> Two copies of the at91_wakeup_status() function are called by the
>>> respective probe() callbacks and are marked __init, but the probe
>>> functions are no longer annotated that way. This works with gcc because
>>> the functions always get inlined, but clang keeps them separate, which
>>> can lead to executing freed memory:
>>>
>>> WARNING: modpost: vmlinux: section mismatch in reference: at91_poweroff_probe+0x80 (section: .text) -> at91_wakeup_status (section: .init.text)
>>> WARNING: modpost: vmlinux: section mismatch in reference: at91_shdwc_probe+0xcc (section: .text) -> at91_wakeup_status (section: .init.text)
>>>
>>> Drop the incorrect annotation on these.
>>>
>>> Fixes: 099806de68b7 ("power: reset: at91-poweroff: Stop using module_platform_driver_probe()")
>>> Fixes: dde74a5de817 ("power: reset: at91-sama5d2_shdwc: Stop using module_platform_driver_probe()")
>>> Signed-off-by: Arnd Bergmann<arnd@arndb.de>
>> Thanks, I sent the same change three weeks ago at this point:
>>
>> https://lore.kernel.org/20231120-fix-at91-modpost-warnings-v1-1-813671933863@kernel.org/
>>
>> Your commit message is a little better than mine and I don't really care
>> which one goes in but it would be good if this could get cleared up
>> soon...
>>
>> Reviewed-by: Nathan Chancellor<nathan@kernel.org>
> I don't care either. Given the change is identical (Nathan's submission
> even has "index 126e774e210c..93eece027865 100644" which exactly matches
> Arnd's patch), I'll forward my Reviewed-by: tag to here:
> 
> Reviewed-by: Uwe Kleine-König<u.kleine-koenig@pengutronix.de>

Likewise:
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Use whichever is preferred.
Regards,
   Nicolas

