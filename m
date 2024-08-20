Return-Path: <linux-pm+bounces-12539-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA471958068
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 09:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E7A91F222A0
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 07:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0DA7189B81;
	Tue, 20 Aug 2024 07:59:30 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC0E18E34F;
	Tue, 20 Aug 2024 07:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724140770; cv=none; b=nuH4r7Ne4nw5h+3N9vdnY30Xcd2316oTp7CjQWqOzfR+BWsqtb4nWzvdKG7/yEHaq9soUsE6cGJXQj2FLuTIVWAouDpichTHNyGGp7hPQROY3FNG6nSZoABLJVvN6jZF3BG50b9CwcwboD0HVjMEl9gR5VSLnuBULc70j5TGbOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724140770; c=relaxed/simple;
	bh=U488BWMaAzODhiyts3CzQHGRTP9j4MQwA1+jXqle1gg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WGepQ2ETzhI5qBmq7azagN6kP2JQrOiy4ujAN794P6FYYLl24r6DpIhY0GTf2NXWIwhMNhNzEcVrPMm6LKFxCxsknwnPnEeXepT2DhHxVCGH++O3/DiHGjTRuvSZXYV59bczoc0AgYewpwlt7A4hVq/5QXkMXk46Fwm3wBlQja8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Wp1yq6g0szfbfQ;
	Tue, 20 Aug 2024 15:57:23 +0800 (CST)
Received: from kwepemm600004.china.huawei.com (unknown [7.193.23.242])
	by mail.maildlp.com (Postfix) with ESMTPS id EC695180101;
	Tue, 20 Aug 2024 15:59:23 +0800 (CST)
Received: from [10.67.121.59] (10.67.121.59) by kwepemm600004.china.huawei.com
 (7.193.23.242) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 20 Aug
 2024 15:59:23 +0800
Message-ID: <ad98fdf8-bc03-a5ed-c868-8073c9aa4df5@huawei.com>
Date: Tue, 20 Aug 2024 15:59:22 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v3 04/14] thermal: sysfs: Use the dev argument in
 instance-related show/store
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM
	<linux-pm@vger.kernel.org>
CC: LKML <linux-kernel@vger.kernel.org>, Daniel Lezcano
	<daniel.lezcano@linaro.org>, Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui
	<rui.zhang@intel.com>
References: <2205737.irdbgypaU6@rjwysocki.net>
 <1987669.PYKUYFuaPT@rjwysocki.net>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <1987669.PYKUYFuaPT@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600004.china.huawei.com (7.193.23.242)


在 2024/8/19 23:56, Rafael J. Wysocki 写道:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Two sysfs show/store functions for attributes representing thermal
> instances, trip_point_show() and weight_store(), retrieve the thermal
> zone pointer from the instance object at hand, but they may also get
> it from their dev argument, which is more consistent with what the
> other thermal sysfs functions do, so make them do so.
>
> No intentional functional impact.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>
> v1 -> v3: No changes (previously [06/17])
>
> ---
>   drivers/thermal/thermal_sysfs.c |   15 +++++++--------
>   1 file changed, 7 insertions(+), 8 deletions(-)
Using to_thermal_zone() and to_cooling_device() in sysfs looks good to me.
Acked-by: Huisong Li <lihuisong@huawei.com>

