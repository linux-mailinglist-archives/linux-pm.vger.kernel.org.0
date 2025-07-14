Return-Path: <linux-pm+bounces-30783-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB41B03CE7
	for <lists+linux-pm@lfdr.de>; Mon, 14 Jul 2025 13:07:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6124A3AD51B
	for <lists+linux-pm@lfdr.de>; Mon, 14 Jul 2025 11:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93867245031;
	Mon, 14 Jul 2025 11:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="YUsSXX4X"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA0C23A9BB
	for <linux-pm@vger.kernel.org>; Mon, 14 Jul 2025 11:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752491262; cv=none; b=c8v3OpMtDhH026PnMXWq3ht9pUazv8g0/k0tCZ8zdnOIBxFsR8MUz4bEIIFqd4Bt/vk/ZuxzSGCIT773UdPfOvepDQFbw/E1MvpYZWFW9J22DCb/rEgHWBeyELeyrIvpCzHQFO0WsHnD0/QYTmmxp7phCmVVvuRrAw+U2KvdRD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752491262; c=relaxed/simple;
	bh=PuiFWBC57YuWDCIy/nrsIgmRYL6D5cjT2AqU6mr1Dbw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:In-Reply-To:
	 Content-Type:References; b=CxSEVJ7TheOZKXExeiBEliyDBlRJOT+AGsFf6RzMxdZO/dz55rfgWat/NskojuU6FTSFMirPVdF6DhXeneAnuW6L6nzjtv9K3Kd4ehQ7ZYl5PzbafswzPhQIVCih+amIupMlMrf/22E2BhJ7caCTI0aI9q4sIsyCmQO/SFLEBjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=YUsSXX4X; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250714110732euoutp010b9fcebbde84574086ec4829473bd164~SGYJelKDC1918019180euoutp01f
	for <linux-pm@vger.kernel.org>; Mon, 14 Jul 2025 11:07:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250714110732euoutp010b9fcebbde84574086ec4829473bd164~SGYJelKDC1918019180euoutp01f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1752491252;
	bh=+cH1AagOLxRaP9OS6I3NvlMV9oNEy792Og/AFphHVSY=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=YUsSXX4X1+KjPXjsXVONyLaXQwyN7k7TEJ0nSJb9/pastTcDa8yhUvxywTSIR+1MB
	 YtPzGs1xdcEdtWezuN0UBqH553GlvNUXRIrAX/SGWevx8EHoFZKQ044N/ShMWf9pTW
	 0IqaplYHTNcqWq3jxrf94tPNYM68OKMXNhykKl4Y=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250714110732eucas1p1c0c47358492d6b115b74c0d702bd4a1c~SGYI6A4zX1349413494eucas1p1l;
	Mon, 14 Jul 2025 11:07:32 +0000 (GMT)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250714110730eusmtip1d440d37697b95bbfc6a074f6ce94fe19~SGYH0S8mA3118931189eusmtip1h;
	Mon, 14 Jul 2025 11:07:30 +0000 (GMT)
Message-ID: <1245a8c2-ca23-4faa-bceb-3354e92aca2c@samsung.com>
Date: Mon, 14 Jul 2025 13:07:30 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/5] drm/imagination: Use pwrseq for TH1520 GPU power
 management
From: Michal Wilczynski <m.wilczynski@samsung.com>
To: Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>, Philipp Zabel
	<p.zabel@pengutronix.de>, Frank Binns <frank.binns@imgtec.com>, Matt Coster
	<matt.coster@imgtec.com>, Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>, Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>, Ulf Hansson <ulf.hansson@linaro.org>, Marek
	Szyprowski <m.szyprowski@samsung.com>, Drew Fustini <fustini@kernel.org>
Cc: linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	dri-devel@lists.freedesktop.org, Bartosz Golaszewski
	<bartosz.golaszewski@linaro.org>
Content-Language: en-US
In-Reply-To: <fa235fa1-d5ad-44b7-bf52-068ea41fc9ea@samsung.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20250714110732eucas1p1c0c47358492d6b115b74c0d702bd4a1c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250626093356eucas1p1adfcd565173d939f82e15252189c316f
X-EPHeader: CA
X-CMS-RootMailID: 20250626093356eucas1p1adfcd565173d939f82e15252189c316f
References: <20250626-apr_14_for_sending-v7-0-6593722e0217@samsung.com>
	<CGME20250626093356eucas1p1adfcd565173d939f82e15252189c316f@eucas1p1.samsung.com>
	<20250626-apr_14_for_sending-v7-1-6593722e0217@samsung.com>
	<fa235fa1-d5ad-44b7-bf52-068ea41fc9ea@samsung.com>



On 7/3/25 12:21, Michal Wilczynski wrote:
> 
> 
> On 6/26/25 11:33, Michal Wilczynski wrote:
>> Update the Imagination PVR DRM driver to leverage the pwrseq framework
>> for managing the complex power sequence of the GPU on the T-HEAD TH1520
>> SoC.
>>
>> To cleanly separate platform specific logic from the generic driver,
>> this patch introduces a `pwr_power_sequence_ops` struct containing
>> function pointers for power_on and power_off operations. This allows for
>> different power management strategies to be selected at probe time based
>> on the device's compatible string.
>>
>> A `pvr_device_data` struct, associated with each compatible in the
>> of_device_id table, points to the appropriate ops table (manual or
>> pwrseq).
>>
>> At probe time, the driver inspects the assigned ops struct. If the
>> pwrseq variant is detected, the driver calls
>> devm_pwrseq_get("gpu-power"), deferring probe if the sequencer is not
>> yet available. Otherwise, it falls back to the existing manual clock and
>> reset handling. The runtime PM callbacks now call the appropriate
>> functions via the ops table.
>>
>> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
>> Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
>> ---
>>  drivers/gpu/drm/imagination/pvr_device.c |  36 +++++++-
>>  drivers/gpu/drm/imagination/pvr_device.h |  17 ++++
>>  drivers/gpu/drm/imagination/pvr_drv.c    |  27 +++++-
>>  drivers/gpu/drm/imagination/pvr_power.c  | 139 ++++++++++++++++++++++---------
>>  drivers/gpu/drm/imagination/pvr_power.h  |  13 +++
>>  5 files changed, 185 insertions(+), 47 deletions(-)
>>
> 
> Hi,
> 
> I'm checking in on the status of my pwrseq patch above. Is this on track
> for the next merge window?
> 
> Please let me know if there's anything else needed from my end to help
> get it ready.
> 
> Best regards,


Hi Matt,

I was very happy to see the recent "pvr: various enablement changes" get
merged in Mesa [1]. Congratulations to the team on that progress.

I just wanted to check in and see if you have any more requests for this
series ?

[1] - https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/33998

Best regards,
-- 
Michal Wilczynski <m.wilczynski@samsung.com>

