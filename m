Return-Path: <linux-pm+bounces-19804-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D8059FD9D0
	for <lists+linux-pm@lfdr.de>; Sat, 28 Dec 2024 11:11:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 085347A0350
	for <lists+linux-pm@lfdr.de>; Sat, 28 Dec 2024 10:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D695413C9B3;
	Sat, 28 Dec 2024 10:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="XCIDTksV"
X-Original-To: linux-pm@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B209113AD20;
	Sat, 28 Dec 2024 10:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735380659; cv=none; b=THvlI8jed3rmdxwUxS0uGX7Ob0GhQEsX8593cRdkImVrUXMw8CJYvA/hbDfJpiBFysge7+IQwX8DL+ErB9Jl7Y1i1ImrqiEmCvPCD5QcO1+nyLPNFLQLXGX+y5NATDJqXzW8wjlKCnJ+vfIg0ZuKTSW+BI7/gRGzU9tqesBtSC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735380659; c=relaxed/simple;
	bh=cyir3PDjbDyY/XEtYE4HL0kr33wE/zbWb1X3coKhFnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NzREzKGg6Mez0AaILqyRTbE9oJM6UabTd1RD5Civ7myBoVrDctJLO/GSd8sC7W/HGZpSOf0/kA4HclvGufT8HDJYhsQ9tvTcddcStgD1NEEpqAMdRbdAGNNjEMoOCwdW6hKxWD06ishJWsFKdZd8+qk7X+bRxAjk5pDA/0Xd1Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=XCIDTksV; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4D9191BF203;
	Sat, 28 Dec 2024 10:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1735380648;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ncWYXnUi6mk+o8Emqu4x+YEeix+m7qnAVflQKfWOvnU=;
	b=XCIDTksVVP4MKIPW77YWhn5eQnvC48fM7XT38sMO4GL+S2x3Df1Ewj/szBh5xIFIqsA2Z5
	ZilzcEnS0ob4kPcYJWo88q53OLtd7SamktyTld8/ykS5ad9aHtO7ShlIBUvjk+nBt0QW5J
	myFBF+iN4oCB0jXlbMsfqtkMizt/w77iQVe9W7M9LtSxoo6OTA5KHxrcgkphpt8L5CByY1
	xg+gw54EfF9RaAE9czfc7Nlyb3vjZjVSG0fNA9q0UQtOtz8AnyO7G5irHp4pYROlBGSfmn
	c0RlJWVwKaPGic630SqefQTeKf9SJuvfmVmrN1Vmevo6n6oweZ6GjhiunOcb6w==
Date: Sat, 28 Dec 2024 11:10:46 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org, linux-rtc@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-riscv@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 00/12] pm: Introduce devm_pm_set_wake_irq
Message-ID: <20241228101046e64adfb2@mail.local>
References: <20241228-wake_irq-v1-0-09cfca77cd47@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241228-wake_irq-v1-0-09cfca77cd47@nxp.com>
X-GND-Sasl: alexandre.belloni@bootlin.com

On 28/12/2024 09:14:36+0800, Peng Fan (OSS) wrote:
> This was a retry to address [1][2], to let common code handle
> dev_pm_clear_wake_irq. Then no need to call dev_pm_clear_wake_irq
> in each driver.remove() hook and error handling path.
> 
> In this patchset, I include input and rtc patches to show the usage
> to avoid that introducing an API without users. There are still
> other places using dev_pm_clear_wake_irq. If this patchset is
> good for you, I could start to clean up other drivers such as mmc and
> etc.
> 
> [1] https://lore.kernel.org/all/20241111092131.1693319-1-peng.fan@oss.nxp.com/
> [2] https://lore.kernel.org/all/ZymxvLMkkktRoCXZ@google.com/

It seems your patchset depends on devm_device_init_wakeup which did not
make it yet.

> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
> Peng Fan (12):
>       PM: sleep: wakeirq: Introduce device-managed variant of dev_pm_set_wake_irq
>       input: keyboard: ep93xx_keypad: Use devm_pm_set_wake_irq
>       input: keyboard: omap4_keypad: Use devm_pm_set_wake_irq
>       input: misc: nxp-bbnsm-pwrkey: Use resource managed API to simplify code
>       input: touchscreen: ti_am335x_tsc: Use resource managed API to simplify code
>       rtc: stm32: Use resource managed API to simplify code
>       rtc: nxp-bbnsm: Use resource managed API to simplify code
>       rtc: ds1343: Use devm_pm_set_wake_irq
>       rtc: pm8xxx: Use devm_pm_set_wake_irq
>       rtc: ab8500: Use resource managed API to simplify code
>       rtc: mpfs: Use devm_pm_set_wake_irq
>       rtc: pl031: Use resource managed API to simplify code
> 
>  drivers/base/power/wakeirq.c              | 25 ++++++++++++++++++
>  drivers/input/keyboard/ep93xx_keypad.c    |  8 +-----
>  drivers/input/keyboard/omap4-keypad.c     |  8 +-----
>  drivers/input/misc/nxp-bbnsm-pwrkey.c     | 15 ++++-------
>  drivers/input/touchscreen/ti_am335x_tsc.c | 43 ++++++++++---------------------
>  drivers/rtc/rtc-ab8500.c                  | 11 ++------
>  drivers/rtc/rtc-ds1343.c                  |  8 +-----
>  drivers/rtc/rtc-mpfs.c                    |  8 +-----
>  drivers/rtc/rtc-nxp-bbnsm.c               | 29 +++++++--------------
>  drivers/rtc/rtc-pl031.c                   |  6 ++---
>  drivers/rtc/rtc-pm8xxx.c                  | 12 +--------
>  drivers/rtc/rtc-stm32.c                   | 10 ++-----
>  include/linux/pm_wakeirq.h                |  6 +++++
>  13 files changed, 70 insertions(+), 119 deletions(-)
> ---
> base-commit: 8155b4ef3466f0e289e8fcc9e6e62f3f4dceeac2
> change-id: 20241227-wake_irq-b68d604dd902
> 
> Best regards,
> -- 
> Peng Fan <peng.fan@nxp.com>
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

