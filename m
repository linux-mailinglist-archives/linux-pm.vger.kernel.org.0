Return-Path: <linux-pm+bounces-12611-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 449A795985E
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2024 12:51:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 778551C20805
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2024 10:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA951C2DAF;
	Wed, 21 Aug 2024 09:02:38 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A89D1A7AEE;
	Wed, 21 Aug 2024 09:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724230958; cv=none; b=pi12j2if3fofGLxFm4IacKnTnh431ma70ISubipiak4CRYsyojgn1/ZTLn2Vz1RPaLwII3jTD5pBu+HaPLTVTYnvzWnQjEhBiLEEjFaGfH2qxqN2yf/ArL/l/r2g/BaYIKj6+JxjqmCkavIY3tVq6t+YIEyoKaW1JwfMA/q78bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724230958; c=relaxed/simple;
	bh=FrYcorIHvoa4md3aogbTMt4d91LhPHFeYqxcGHX59iI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=mYe25FRweTy3UoXO24f0S741ursRPKzSftveBJSUC8+EMV9MktpYAciMgxYqdH87wqxl15I6zJ9OARknsnmve/6R1hkNfDuSoGan0U5FkjtEsSSovcXceyYPumz2U7huqsIOZ9Vz+6gNrKmHnsP+ZBegSZcGhm8cIZaVXDqrQAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WpgG74ldhz20lxd;
	Wed, 21 Aug 2024 16:57:51 +0800 (CST)
Received: from kwepemm600004.china.huawei.com (unknown [7.193.23.242])
	by mail.maildlp.com (Postfix) with ESMTPS id 3CC151400CA;
	Wed, 21 Aug 2024 17:02:33 +0800 (CST)
Received: from [10.67.121.59] (10.67.121.59) by kwepemm600004.china.huawei.com
 (7.193.23.242) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 21 Aug
 2024 17:02:32 +0800
Message-ID: <93639d68-e396-a782-410c-f7827dbd54f5@huawei.com>
Date: Wed, 21 Aug 2024 17:02:31 +0800
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
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM
	<linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Daniel
 Lezcano <daniel.lezcano@linaro.org>, Lukasz Luba <lukasz.luba@arm.com>, Zhang
 Rui <rui.zhang@intel.com>
References: <2205737.irdbgypaU6@rjwysocki.net>
 <3837835.kQq0lBPeGt@rjwysocki.net>
 <6bf771b0-d57d-5a8c-ec36-6f8a041695d9@huawei.com>
 <CAJZ5v0i_Z43bLWsa9gg_SZFBURi1XrZn4Cnxurm8KCawAWqtUA@mail.gmail.com>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <CAJZ5v0i_Z43bLWsa9gg_SZFBURi1XrZn4Cnxurm8KCawAWqtUA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600004.china.huawei.com (7.193.23.242)


在 2024/8/20 18:27, Rafael J. Wysocki 写道:
> On Tue, Aug 20, 2024 at 10:27 AM lihuisong (C) <lihuisong@huawei.com> wrote:
>>
>> 在 2024/8/19 23:58, Rafael J. Wysocki 写道:
>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>
>>> Since thermal_bind_cdev_to_trip() and thermal_unbind_cdev_from_trip()
>>> acquire the thermal zone lock, the locking rules for their callers get
>>> complicated.  In particular, the thermal zone lock cannot be acquired
>>> in any code path leading to one of these functions even though it might
>>> be useful to do so.
>>>
>>> To address this, remove the thermal zone locking from both these
>>> functions, add lockdep assertions for the thermal zone lock to both
>>> of them and make their callers acquire the thermal zone lock instead.
>>>
>>> No intentional functional impact.
>>>
>>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>> ---
>>>
>>> v2 -> v3: Rebase after dropping patches [04-05/17] from the series
>>>
>>> v1 -> v2: No changes
>>>
>>> ---
>>>    drivers/acpi/thermal.c         |    2 +-
>>>    drivers/thermal/thermal_core.c |   30 ++++++++++++++++++++++--------
>>>    2 files changed, 23 insertions(+), 9 deletions(-)
>>>
>>> Index: linux-pm/drivers/thermal/thermal_core.c
>>> ===================================================================
>>> --- linux-pm.orig/drivers/thermal/thermal_core.c
>>> +++ linux-pm/drivers/thermal/thermal_core.c
>>> @@ -785,6 +785,7 @@ int thermal_bind_cdev_to_trip(struct the
>>>        int result;
>>>
>> <snip>
>>> Index: linux-pm/drivers/acpi/thermal.c
>>> ===================================================================
>>> --- linux-pm.orig/drivers/acpi/thermal.c
>>> +++ linux-pm/drivers/acpi/thermal.c
>>> @@ -609,7 +609,7 @@ static int acpi_thermal_bind_unbind_cdev
>>>                .thermal = thermal, .cdev = cdev, .bind = bind
>>>        };
>>>
>>> -     return for_each_thermal_trip(thermal, bind_unbind_cdev_cb, &bd);
>>> +     return thermal_zone_for_each_trip(thermal, bind_unbind_cdev_cb, &bd);
>> If so, it seems that the for_each_thermal_trip() can be removed or no
>> need to export.
> I beg to differ:
>
> $ git grep for_each_thermal_trip | head -1
> drivers/net/wireless/intel/iwlwifi/mvm/tt.c:
> for_each_thermal_trip(mvm->tz_device.tzone, iwl_trip_temp_cb, &twd);
Can we modify it for tt.c?
It doesn't seem to keep two interfaces. I'm a little confused for that.
> .

