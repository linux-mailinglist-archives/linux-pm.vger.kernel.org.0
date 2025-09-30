Return-Path: <linux-pm+bounces-35574-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 526C4BAB258
	for <lists+linux-pm@lfdr.de>; Tue, 30 Sep 2025 05:23:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8B4E3BA227
	for <lists+linux-pm@lfdr.de>; Tue, 30 Sep 2025 03:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFBE12264CD;
	Tue, 30 Sep 2025 03:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Fwu5AsG9"
X-Original-To: linux-pm@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166A52940D;
	Tue, 30 Sep 2025 03:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759202615; cv=none; b=VLafGFFqImaSr6amCOen6nKC1JpD9bl00gQwaPImx7ySl9QYF32eH4Rp+4F8bEYGp9pmCY/PkxtrrCq9dCZEJ5XbcSIaFR9dammvefF9qPieiWGUGzgxh6lBCJZgcq6cSdv6JjbMpbgnQGs1hhVqByoGJpvi1VWOO9JthYX+k8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759202615; c=relaxed/simple;
	bh=eJh7zhLV5x7Mxn5GEAWbeJPUNyyO3U9W8Qlr8GufUhk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MfOEArYB7J20FBMmPNhwx7ikvxv0YjSwew4YkOedw7jGurUdP2lNDQu4uiG6v0edqt0g/m7tlYk1rC1kv0+Q2zqP8YDu0osxGK7HHfaHIpOjUBhJqU2m1PueOJfeaV+3ddX1UuTImiRADExKiI2f5q9eu9bFLpPe8FcGPPCewVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Fwu5AsG9; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1759202608; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=rrg8tK/c3UsFS3eLKyUv3jp0wQnj3xFNgYt0DA+mTfU=;
	b=Fwu5AsG9VwkiDzm/68F6vwNOmggWT5wO729QcqriJJ819apDMcoYXTNGxQzj19tGU5BdWoWu/JdhZG1wOXsAsM5niYmluJNGfVcCA+T4rIZ+03AADWfxQwnB+NTrZSwKTrTBhlSiSXpx/DVJVmVjDtZGLEOUlFC9fcVcWEjvJ3c=
Received: from 30.74.144.121(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Wp9xPwB_1759202607 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 30 Sep 2025 11:23:27 +0800
Message-ID: <52756d02-8bb2-42b6-b311-db9c28473623@linux.alibaba.com>
Date: Tue, 30 Sep 2025 11:23:26 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] power: reset: sc27xx: Use
 devm_register_sys_off_handler
To: =?UTF-8?Q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>,
 Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Orson Zhai <orsonzhai@gmail.com>,
 Chunyan Zhang <zhang.lyra@gmail.com>, Lee Jones <lee@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250926-sc2730-reboot-v1-0-62ebfd3d31bb@abscue.de>
 <20250926-sc2730-reboot-v1-3-62ebfd3d31bb@abscue.de>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20250926-sc2730-reboot-v1-3-62ebfd3d31bb@abscue.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/9/27 00:23, Otto Pflüger wrote:
> Use the new device life-cycle managed register function to remove the
> need for global variables in the driver.
> 
> Signed-off-by: Otto Pflüger <otto.pflueger@abscue.de>
> ---

LGTM. Thanks.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

>   drivers/power/reset/sc27xx-poweroff.c | 24 +++++++++++++++++-------
>   1 file changed, 17 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/power/reset/sc27xx-poweroff.c b/drivers/power/reset/sc27xx-poweroff.c
> index 90287c31992c4889f9241e82a21a1949ecca7702..20eb9f32cb2b99adeb16502172adf9d6257cd05f 100644
> --- a/drivers/power/reset/sc27xx-poweroff.c
> +++ b/drivers/power/reset/sc27xx-poweroff.c
> @@ -9,6 +9,7 @@
>   #include <linux/module.h>
>   #include <linux/platform_device.h>
>   #include <linux/pm.h>
> +#include <linux/reboot.h>
>   #include <linux/regmap.h>
>   #include <linux/syscore_ops.h>
>   
> @@ -17,8 +18,6 @@
>   #define SC27XX_SLP_CTRL		0xdf0
>   #define SC27XX_LDO_XTL_EN	BIT(3)
>   
> -static struct regmap *regmap;
> -
>   /*
>    * On Spreadtrum platform, we need power off system through external SC27xx
>    * series PMICs, and it is one similar SPI bus mapped by regmap to access PMIC,
> @@ -44,26 +43,37 @@ static struct syscore_ops poweroff_syscore_ops = {
>   	.shutdown = sc27xx_poweroff_shutdown,
>   };
>   
> -static void sc27xx_poweroff_do_poweroff(void)
> +static int sc27xx_poweroff_do_poweroff(struct sys_off_data *off_data)
>   {
> +	struct regmap *regmap = off_data->cb_data;
> +
>   	/* Disable the external subsys connection's power firstly */
>   	regmap_write(regmap, SC27XX_SLP_CTRL, SC27XX_LDO_XTL_EN);
>   
>   	regmap_write(regmap, SC27XX_PWR_PD_HW, SC27XX_PWR_OFF_EN);
> +
> +	mdelay(1000);
> +
> +	pr_emerg("Unable to poweroff system\n");
> +
> +	return NOTIFY_DONE;
>   }
>   
>   static int sc27xx_poweroff_probe(struct platform_device *pdev)
>   {
> -	if (regmap)
> -		return -EINVAL;
> +	struct regmap *regmap;
>   
>   	regmap = dev_get_regmap(pdev->dev.parent, NULL);
>   	if (!regmap)
>   		return -ENODEV;
>   
> -	pm_power_off = sc27xx_poweroff_do_poweroff;
>   	register_syscore_ops(&poweroff_syscore_ops);
> -	return 0;
> +
> +	return devm_register_sys_off_handler(&pdev->dev,
> +					     SYS_OFF_MODE_POWER_OFF,
> +					     SYS_OFF_PRIO_DEFAULT,
> +					     sc27xx_poweroff_do_poweroff,
> +					     regmap);
>   }
>   
>   static struct platform_driver sc27xx_poweroff_driver = {
> 


