Return-Path: <linux-pm+bounces-12542-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F769580DD
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 10:27:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D95D284C64
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 08:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FD53189F5A;
	Tue, 20 Aug 2024 08:27:29 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED6C1B813;
	Tue, 20 Aug 2024 08:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724142449; cv=none; b=jU2V4JUVX5MQBFRIoWrMpHx59QzA7DYR8dNkKQ5hNzOqW6H2oJ9txVGFB0xksFhulWScWwNxfptjBkRekBF1PYCExWRHC9N2/apoSlX4AfGeBie39bhp5py+L7PI1MzfcBvbPEp2l946MmfL82OXpwMw/O/ORieQEk4Gtz3gbqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724142449; c=relaxed/simple;
	bh=DV9KMTsYabqmk2LNViG+DGz2QP3doDwplH0uUYXlNoU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=D0139CwdNY7iDVdxY97XLSD9A5DquWpDrtnQk8Cx3k40uxbjHNaZIqsewI6h2MazoQfE4QON11KKdmwAAJ8FyRPewUGg7VLlSHAd4u6wrfGV9PJOkWLYAAlB18d7dMmFCEKh6OIEhD4UAk+GW4+CV3iyas+8pYYovIzb55li4ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Wp2Wd5MkWz1S8LQ;
	Tue, 20 Aug 2024 16:22:21 +0800 (CST)
Received: from kwepemm600004.china.huawei.com (unknown [7.193.23.242])
	by mail.maildlp.com (Postfix) with ESMTPS id A7F591A0188;
	Tue, 20 Aug 2024 16:27:21 +0800 (CST)
Received: from [10.67.121.59] (10.67.121.59) by kwepemm600004.china.huawei.com
 (7.193.23.242) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 20 Aug
 2024 16:27:21 +0800
Message-ID: <6bf771b0-d57d-5a8c-ec36-6f8a041695d9@huawei.com>
Date: Tue, 20 Aug 2024 16:27:20 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v3 05/14] thermal: core: Move thermal zone locking out of
 bind/unbind functions
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM
	<linux-pm@vger.kernel.org>
CC: LKML <linux-kernel@vger.kernel.org>, Daniel Lezcano
	<daniel.lezcano@linaro.org>, Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui
	<rui.zhang@intel.com>
References: <2205737.irdbgypaU6@rjwysocki.net>
 <3837835.kQq0lBPeGt@rjwysocki.net>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <3837835.kQq0lBPeGt@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600004.china.huawei.com (7.193.23.242)


在 2024/8/19 23:58, Rafael J. Wysocki 写道:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Since thermal_bind_cdev_to_trip() and thermal_unbind_cdev_from_trip()
> acquire the thermal zone lock, the locking rules for their callers get
> complicated.  In particular, the thermal zone lock cannot be acquired
> in any code path leading to one of these functions even though it might
> be useful to do so.
>
> To address this, remove the thermal zone locking from both these
> functions, add lockdep assertions for the thermal zone lock to both
> of them and make their callers acquire the thermal zone lock instead.
>
> No intentional functional impact.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>
> v2 -> v3: Rebase after dropping patches [04-05/17] from the series
>
> v1 -> v2: No changes
>
> ---
>   drivers/acpi/thermal.c         |    2 +-
>   drivers/thermal/thermal_core.c |   30 ++++++++++++++++++++++--------
>   2 files changed, 23 insertions(+), 9 deletions(-)
>
> Index: linux-pm/drivers/thermal/thermal_core.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_core.c
> +++ linux-pm/drivers/thermal/thermal_core.c
> @@ -785,6 +785,7 @@ int thermal_bind_cdev_to_trip(struct the
>   	int result;
>   
<snip>
>   
> Index: linux-pm/drivers/acpi/thermal.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/thermal.c
> +++ linux-pm/drivers/acpi/thermal.c
> @@ -609,7 +609,7 @@ static int acpi_thermal_bind_unbind_cdev
>   		.thermal = thermal, .cdev = cdev, .bind = bind
>   	};
>   
> -	return for_each_thermal_trip(thermal, bind_unbind_cdev_cb, &bd);
> +	return thermal_zone_for_each_trip(thermal, bind_unbind_cdev_cb, &bd);
If so, it seems that the for_each_thermal_trip() can be removed or no 
need to export.
>   }
>   
>   static int
>
>
>
>
>
> .

