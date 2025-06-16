Return-Path: <linux-pm+bounces-28855-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90BFCADB91A
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 20:50:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92F5D3A5DF3
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 18:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F467289E0F;
	Mon, 16 Jun 2025 18:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="HXgtuKYU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85CE288C9B
	for <linux-pm@vger.kernel.org>; Mon, 16 Jun 2025 18:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750099850; cv=none; b=kdjjeO6+rkr2tCgsyrhfCkSgzzqEQ1/uJD7L8Twwg6RAJZ2F+2B2+27FGPF6yvMchqhluRMgXYvdH9s7sy+jCkXlG14riMEYyo/n4iZSKzXCsFneubPzpAq8bCVb+t7jcBN7ME4Fi3WmUy20PoPeIE3N/94wOBTLpMwcdc6wJeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750099850; c=relaxed/simple;
	bh=0j/zmiRTNVg7EOV9uK1BI3IIyRKsfZk1bKAGOLuyWQQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=ZlYtcI3GtEF86Ng/47VEbLXOfTHXXawBYy0MRXSTyn7JT0GikwxWf8olO5gQ0C7ObSeiiZI7K0AofYNurHF4Wqch1eduJ7VrEyCNjHDPkzGm6OxI7OW2f+iDeUwnAJfka37rDmkkLG01W5jsiH6D+lIVTCxruVTjts21DcSFFNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=HXgtuKYU; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250616185045euoutp01dbcae20d5026a7580ca6873aa0f80ff5~Jmolz88Fp0324303243euoutp018
	for <linux-pm@vger.kernel.org>; Mon, 16 Jun 2025 18:50:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250616185045euoutp01dbcae20d5026a7580ca6873aa0f80ff5~Jmolz88Fp0324303243euoutp018
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1750099845;
	bh=RpP2wDPoANn6hbq6/IU7H6R4ymwfkUd1lBtxRssgpxg=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=HXgtuKYUh8YOQyQo91vA+qT4El3cb+jVPyP21y2ZTw42FifSSk8p2Duc4xvwAuyE+
	 K1bHEQ+MjXyRTuM+mUFJt5q7AUR5lq1rzfclPDjZlNux/bNkGGmkf0bBXIsOKd0Wnv
	 pvUpmbMiiOYc9Khw/cK57CgCrGso0q81WWVlcCVE=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250616185043eucas1p19d2115087823eac1a2fa36fdb6c7cfca~Jmokc0_PY2023320233eucas1p1A;
	Mon, 16 Jun 2025 18:50:43 +0000 (GMT)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250616185042eusmtip251ec7824b4cba255d6ebe61eb60deb26~JmojYMGUT3160031600eusmtip2J;
	Mon, 16 Jun 2025 18:50:42 +0000 (GMT)
Message-ID: <6176cae6-012e-4dc7-9445-058478bfe758@samsung.com>
Date: Mon, 16 Jun 2025 20:50:42 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/8] drm/imagination: Use pwrseq for TH1520 GPU power
 management
To: Bartosz Golaszewski <brgl@bgdev.pl>, Matt Coster
	<matt.coster@imgtec.com>, Frank Binns <frank.binns@imgtec.com>
Cc: Drew Fustini <drew@pdp7.com>, Guo Ren <guoren@kernel.org>, Fu Wei
	<wefu@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Philipp Zabel
	<p.zabel@pengutronix.de>, Frank Binns <frank.binns@imgtec.com>, Matt Coster
	<matt.coster@imgtec.com>, Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>, Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>, Ulf Hansson <ulf.hansson@linaro.org>, Marek
	Szyprowski <m.szyprowski@samsung.com>, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Language: en-US
From: Michal Wilczynski <m.wilczynski@samsung.com>
In-Reply-To: <CAMRc=MfdBd6HBwM4F1TcjDvwbOJ03kxgRk4hJQ8HFK7Wz2XBAg@mail.gmail.com>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250616185043eucas1p19d2115087823eac1a2fa36fdb6c7cfca
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250614180911eucas1p16c9fb4a8160253c253f623bec2529f70
X-EPHeader: CA
X-CMS-RootMailID: 20250614180911eucas1p16c9fb4a8160253c253f623bec2529f70
References: <CGME20250614180911eucas1p16c9fb4a8160253c253f623bec2529f70@eucas1p1.samsung.com>
	<20250614-apr_14_for_sending-v4-0-8e3945c819cd@samsung.com>
	<20250614-apr_14_for_sending-v4-4-8e3945c819cd@samsung.com>
	<CAMRc=MfdBd6HBwM4F1TcjDvwbOJ03kxgRk4hJQ8HFK7Wz2XBAg@mail.gmail.com>



On 6/16/25 11:40, Bartosz Golaszewski wrote:
> On Sat, Jun 14, 2025 at 8:09 PM Michal Wilczynski
> <m.wilczynski@samsung.com> wrote:
>>
>> Update the Imagination PVR DRM driver to leverage the pwrseq framework
>> for managing the power sequence of the GPU on the T-HEAD TH1520 SoC.
>>
>> To cleanly handle the TH1520's specific power requirements in the
>> generic driver, this patch implements the "driver match data" pattern. A
>> has_pwrseq flag in a new pvr_soc_data struct is now associated with
>> thead,th1520-gpu compatible string in the of_device_id table.
>>
>> At probe time, the driver checks this flag. If true, it calls
>> devm_pwrseq_get("gpu-power"), requiring a valid sequencer and deferring
>> probe on failure. In this mode, all power and reset control is delegated
>> to the pwrseq provider. If the flag is false, the driver skips this
>> logic and falls back to its standard manual power management. Clock
>> handles are still acquired directly by this driver in both cases for
>> other purposes like devfreq.
>>
>> The runtime PM callbacks, pvr_power_device_resume() and
>> pvr_power_device_suspend(), are modified to call pwrseq_power_on() and
>> pwrseq_power_off() respectively when the sequencer is present.  A helper
>> function, pvr_power_off_sequence_manual(), is introduced to encapsulate
>> the manual power-down logic.
>>
>> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
>> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
>> ---
> 
> [snip]
> 
>>
>> +static int pvr_power_off_sequence_manual(struct pvr_device *pvr_dev)
>> +{
>> +       int err;
>> +
>> +       err = reset_control_assert(pvr_dev->reset);
>> +
>> +       clk_disable_unprepare(pvr_dev->mem_clk);
>> +       clk_disable_unprepare(pvr_dev->sys_clk);
>> +       clk_disable_unprepare(pvr_dev->core_clk);
>> +
>> +       return err;
>> +}
>> +
>>  int
>>  pvr_power_device_suspend(struct device *dev)
>>  {
>> @@ -252,11 +266,10 @@ pvr_power_device_suspend(struct device *dev)
>>                         goto err_drm_dev_exit;
>>         }
>>
>> -       clk_disable_unprepare(pvr_dev->mem_clk);
>> -       clk_disable_unprepare(pvr_dev->sys_clk);
>> -       clk_disable_unprepare(pvr_dev->core_clk);
>> -
>> -       err = reset_control_assert(pvr_dev->reset);
>> +       if (pvr_dev->pwrseq)
>> +               err = pwrseq_power_off(pvr_dev->pwrseq);
>> +       else
>> +               err = pvr_power_off_sequence_manual(pvr_dev);
>>
>>  err_drm_dev_exit:
>>         drm_dev_exit(idx);
>> @@ -276,44 +289,55 @@ pvr_power_device_resume(struct device *dev)
>>         if (!drm_dev_enter(drm_dev, &idx))
>>                 return -EIO;
>>
>> -       err = clk_prepare_enable(pvr_dev->core_clk);
>> -       if (err)
>> -               goto err_drm_dev_exit;
>> +       if (pvr_dev->pwrseq) {
>> +               err = pwrseq_power_on(pvr_dev->pwrseq);
>> +               if (err)
>> +                       goto err_drm_dev_exit;
>> +       } else {
>> +               err = clk_prepare_enable(pvr_dev->core_clk);
>> +               if (err)
>> +                       goto err_drm_dev_exit;
>>
>> -       err = clk_prepare_enable(pvr_dev->sys_clk);
>> -       if (err)
>> -               goto err_core_clk_disable;
>> +               err = clk_prepare_enable(pvr_dev->sys_clk);
>> +               if (err)
>> +                       goto err_core_clk_disable;
>>
>> -       err = clk_prepare_enable(pvr_dev->mem_clk);
>> -       if (err)
>> -               goto err_sys_clk_disable;
>> +               err = clk_prepare_enable(pvr_dev->mem_clk);
>> +               if (err)
>> +                       goto err_sys_clk_disable;
>>
> 
> In order to decrease the number of if-elses, would it make sense to
> put the "manual" and "pwrseq" operations into their own separate
> functions and then store addresses of these functions in the device
> match data struct as function pointers (instead of the has_pwrseq
> flag)? This way we'd just call them directly.

Hi Bartosz,

Thanks for the suggestion. That sounds good. I can rework the patch to
use function pointers instead of the flag. 

Matt, as the maintainer of this code, do you have a preference on this?
Let me know what you think.

> 
> Bart
> 

Best regards,
-- 
Michal Wilczynski <m.wilczynski@samsung.com>

