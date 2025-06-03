Return-Path: <linux-pm+bounces-28057-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E45ACCDC5
	for <lists+linux-pm@lfdr.de>; Tue,  3 Jun 2025 21:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6AF1E7A82C2
	for <lists+linux-pm@lfdr.de>; Tue,  3 Jun 2025 19:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDE6C21ABCB;
	Tue,  3 Jun 2025 19:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="a6ipd+Kk"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23FB158535
	for <linux-pm@vger.kernel.org>; Tue,  3 Jun 2025 19:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748979808; cv=none; b=EEfVoifWVSIp7ba9BxfOb4JONXiA7gLbOvwr9vKpEYmDq4tO6ajI8Uy9UBEuwcP60r3himJprJ3AkRBcKELUelhuN7x3kqEhEfhwuHCNsUlcl1FZyTLDCImggZ2DKMcDJprc0x4k8F1kkHybCNariLLgniOT6jeyB0fF/tWqQXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748979808; c=relaxed/simple;
	bh=gkdI4yr7dwLY77f5SZrsuIBIUXF5xfXzVHdtpcpA81c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=mRu/MSvWya7tJ99SBXriCyF20jRPa6FbszvSwnrP+HfcxuXs3ach7bAXeWr056GShmz8Je5L5By0FiEcL+ebs87c2Om2cOxt3MwfpK6NVsFsVjmruEyoErASHbAizK9xR3ApGoWTadzpXzVzILU8SH3yj42fgSkqZuQ3vMWZuD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=a6ipd+Kk; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250603194324euoutp01622596a2c84971177fd942854e5fd88a~Fn9260JnV1156211562euoutp01T
	for <linux-pm@vger.kernel.org>; Tue,  3 Jun 2025 19:43:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250603194324euoutp01622596a2c84971177fd942854e5fd88a~Fn9260JnV1156211562euoutp01T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1748979805;
	bh=k6PWReahnB4o9xhLZy2nP1dUtfgYd6gAWiwYwq7Ovuw=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=a6ipd+KkaWCh8aBmWiW+7pgcUf854hEQ9yzuMjoP7rJmL2Yq9VI/dlSbJI9dF4zDf
	 yXo0e5LVc5vvAHPo55PViuqvuPqhMvHa31+nyAtRlEChsyby6scllpGLQXlXeMhT3n
	 2SIQa3dfz/Oq8TmndYMGWGd4spEhVP1nDJqshBTs=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250603194324eucas1p2752406c355cfbd93e1acf8ccb30d9f55~Fn92HrNH50957009570eucas1p2i;
	Tue,  3 Jun 2025 19:43:24 +0000 (GMT)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250603194322eusmtip2c13b4dfea6d39b7a619c012500cf58f9~Fn91EU57e2231322313eusmtip2B;
	Tue,  3 Jun 2025 19:43:22 +0000 (GMT)
Message-ID: <d42a8c49-7ad2-49ef-bd9c-1e3d9981b58e@samsung.com>
Date: Tue, 3 Jun 2025 21:43:22 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/8] drm/imagination: Use pwrseq for TH1520 GPU power
 management
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Drew Fustini <drew@pdp7.com>, Guo Ren <guoren@kernel.org>, Fu Wei
	<wefu@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Bartosz
	Golaszewski <brgl@bgdev.pl>, Philipp Zabel <p.zabel@pengutronix.de>, Frank
	Binns <frank.binns@imgtec.com>, Matt Coster <matt.coster@imgtec.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
	<mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
	<airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Paul Walmsley
	<paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Ulf Hansson
	<ulf.hansson@linaro.org>, Marek Szyprowski <m.szyprowski@samsung.com>,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Content-Language: en-US
From: Michal Wilczynski <m.wilczynski@samsung.com>
In-Reply-To: <20250603-whispering-jaybird-of-thunder-f87867@kuoka>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20250603194324eucas1p2752406c355cfbd93e1acf8ccb30d9f55
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250529222405eucas1p18ed1254bf1b2d78468734656fec537e1
X-EPHeader: CA
X-CMS-RootMailID: 20250529222405eucas1p18ed1254bf1b2d78468734656fec537e1
References: <20250530-apr_14_for_sending-v3-0-83d5744d997c@samsung.com>
	<CGME20250529222405eucas1p18ed1254bf1b2d78468734656fec537e1@eucas1p1.samsung.com>
	<20250530-apr_14_for_sending-v3-3-83d5744d997c@samsung.com>
	<20250603-whispering-jaybird-of-thunder-f87867@kuoka>



On 6/3/25 15:28, Krzysztof Kozlowski wrote:
> On Fri, May 30, 2025 at 12:23:50AM GMT, Michal Wilczynski wrote:
>> Update the Imagination PVR DRM driver to leverage the pwrseq framework
>> for managing the power sequence of the GPU on the T-HEAD TH1520 SoC.
>>
>> In pvr_device_init(), the driver now attempts to get a handle to the
>> "gpu-power" sequencer target using devm_pwrseq_get(). If successful,
>> the responsibility for powering on and off the GPU's core clocks and
>> resets is delegated to the power sequencer. Consequently, the GPU
>> driver conditionally skips acquiring the GPU reset line if the pwrseq
>> handle is obtained, as the sequencer's match function will acquire it.
>> Clock handles are still acquired by the GPU driver for other purposes
>> like devfreq.
>>
>> The runtime PM callbacks, pvr_power_device_resume() and
>> pvr_power_device_suspend(), are modified to call pwrseq_power_on() and
>> pwrseq_power_off() respectively when the sequencer is present.  If no
>> sequencer is found, the driver falls back to its existing manual clock
>> and reset management. A helper function,
>> pvr_power_off_sequence_manual(), is introduced to encapsulate the manual
>> power-down logic.
>>
>> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
>> ---
>>  drivers/gpu/drm/imagination/Kconfig      |  1 +
>>  drivers/gpu/drm/imagination/pvr_device.c | 33 +++++++++++--
>>  drivers/gpu/drm/imagination/pvr_device.h |  6 +++
>>  drivers/gpu/drm/imagination/pvr_power.c  | 82 +++++++++++++++++++++-----------
>>  4 files changed, 89 insertions(+), 33 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/imagination/Kconfig b/drivers/gpu/drm/imagination/Kconfig
>> index 3bfa2ac212dccb73c53bdc2bc259bcba636e7cfc..737ace77c4f1247c687cc1fde2f139fc2e118c50 100644
>> --- a/drivers/gpu/drm/imagination/Kconfig
>> +++ b/drivers/gpu/drm/imagination/Kconfig
>> @@ -11,6 +11,7 @@ config DRM_POWERVR
>>  	select DRM_SCHED
>>  	select DRM_GPUVM
>>  	select FW_LOADER
>> +  select POWER_SEQUENCING
> 
> Messed indent.
> 
>>  	help
>>  	  Choose this option if you have a system that has an Imagination
>>  	  Technologies PowerVR (Series 6 or later) or IMG GPU.
>> diff --git a/drivers/gpu/drm/imagination/pvr_device.c b/drivers/gpu/drm/imagination/pvr_device.c
>> index 8b9ba4983c4cb5bc40342fcafc4259078bc70547..19d48bbc828cf2b8dbead602e90ff88780152124 100644
>> --- a/drivers/gpu/drm/imagination/pvr_device.c
>> +++ b/drivers/gpu/drm/imagination/pvr_device.c
>> @@ -25,6 +25,7 @@
>>  #include <linux/interrupt.h>
>>  #include <linux/platform_device.h>
>>  #include <linux/pm_runtime.h>
>> +#include <linux/pwrseq/consumer.h>
>>  #include <linux/reset.h>
>>  #include <linux/slab.h>
>>  #include <linux/stddef.h>
>> @@ -631,10 +632,34 @@ pvr_device_init(struct pvr_device *pvr_dev)
>>  	if (err)
>>  		return err;
>>  
>> -	/* Get the reset line for the GPU */
>> -	err = pvr_device_reset_init(pvr_dev);
>> -	if (err)
>> -		return err;
>> +	/*
>> +	 * Try to get a power sequencer. If successful, it will handle clocks
>> +	 * and resets. Otherwise, we fall back to managing them ourselves.
>> +	 */
>> +	pvr_dev->pwrseq = devm_pwrseq_get(dev, "gpu-power");
>> +	if (IS_ERR(pvr_dev->pwrseq)) {
>> +		int pwrseq_err = PTR_ERR(pvr_dev->pwrseq);
>> +
>> +		/*
>> +		 * If the error is -EPROBE_DEFER, it's because the
>> +		 * optional sequencer provider is not present
>> +		 * and it's safe to fall back on manual power-up.
> 
> It is safe but why it is desirable? The rule is rather to defer the
> probe, assuming this is probe path.

Yeah this is probe path.

The GPU node will depend on the AON node, which will be the sole
provider for the 'gpu-power' sequencer (based on the discussion in patch
1).

Therefore, if the AON/pwrseq driver has already completed its probe, and
devm_pwrseq_get() in the GPU driver subsequently returns -EPROBE_DEFER
(because pwrseq_get found 'no match' on the bus for 'gpu-power'), the
interpretation is that the AON driver did not register this optional
sequencer. Since AON is the only anticipated source, it implies the
sequencer won't become available later from its designated provider.
This specific scenario is when we intend to fall back to manual power
management, which pvr driver is capable of, it just doesn't work for the
TH1520 SoC, as it has a custom requirements implemented by the pwrseq
driver.

> 
> Best regards,
> Krzysztof
> 
> 

Best regards,
-- 
Michal Wilczynski <m.wilczynski@samsung.com>

