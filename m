Return-Path: <linux-pm+bounces-12619-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E4D95993B
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2024 13:13:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 272BD282B15
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2024 11:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4ADB2034CB;
	Wed, 21 Aug 2024 09:44:12 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F802034BA;
	Wed, 21 Aug 2024 09:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724233452; cv=none; b=fRo01+A+Fu2jAdBDYHSgmme8f0X7m/giDeGfc8Y1JNjONxOZzTu5ZUbxXgHHn2nT4luOuTW/qPqWJ4TXPMrEticFhGZEQzu9+gakwgc9Tv0AxPnlTp/WC0a/BsH6OdIK7tA7dnd7jHZCt7CxQKZ7GedSQxAlStF2+u2LlUJRWlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724233452; c=relaxed/simple;
	bh=Zka2nUbhX8rAlsL9boNe6OWXAy8Hqq9Riz4Gon1WzIQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=EsGSdk0HnyQSxYJMg2u9y0YyHF7aylX0GxtUTiuQZKiO46j1y0h5wlxRPxJ+OhaMpjZ8fNhzXb755xV3rffVLzIWdNfDsGDlVRMd/zVO2wwlT6FcuI1LBpM78rYijXb6/kBqnHRrEAqOcpW7NsBGrv95aL6QanHVt5TmhlRGZ9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WphHS5Srwz2Cn70;
	Wed, 21 Aug 2024 17:44:04 +0800 (CST)
Received: from kwepemm600004.china.huawei.com (unknown [7.193.23.242])
	by mail.maildlp.com (Postfix) with ESMTPS id 067781400CA;
	Wed, 21 Aug 2024 17:44:07 +0800 (CST)
Received: from [10.67.121.59] (10.67.121.59) by kwepemm600004.china.huawei.com
 (7.193.23.242) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 21 Aug
 2024 17:44:06 +0800
Message-ID: <8744a789-0424-0cc6-7cb1-b7c9b17f56cc@huawei.com>
Date: Wed, 21 Aug 2024 17:44:05 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v3 02/14] thermal: core: Rearrange checks in
 thermal_bind_cdev_to_trip()
To: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki"
	<rjw@rjwysocki.net>
CC: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
	Zhang Rui <rui.zhang@intel.com>, Linux PM <linux-pm@vger.kernel.org>
References: <2205737.irdbgypaU6@rjwysocki.net>
 <3324214.44csPzL39Z@rjwysocki.net>
 <68ed6185-a602-c0fc-721e-b5d68fea83f8@huawei.com>
 <66bb19a0-00ba-40a5-91ef-73368659b30a@linaro.org>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <66bb19a0-00ba-40a5-91ef-73368659b30a@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600004.china.huawei.com (7.193.23.242)


在 2024/8/21 17:28, Daniel Lezcano 写道:
> On 21/08/2024 10:49, lihuisong (C) wrote:
>
> [ ... ]
>
>>> -    list_for_each_entry(pos2, &thermal_cdev_list, node) {
>>> -        if (pos2 == cdev)
>>> -            break;
>>> -    }
>>> +    lockdep_assert_held(&thermal_list_lock);
>>> -    if (tz != pos1 || cdev != pos2)
>>> +    if (list_empty(&tz->node) || list_empty(&cdev->node))
>> The old verification is ensure that tz and cdev already add to 
>> thermal_tz_list and thermal_cdev_list，respectively.
>> Namely, tz and cdev are definitely registered and intialized.
>> The check is ok for all untizalized thermal_zone_device and cooling 
>> device.
>> But the new verification doesn't seem to do that.
>
> If the tz or the cdev are registered then their "->node" is not empty 
> because they are linked with the thermal_list and cdev_list
>
> So either way is browsing the lists to find the tz/cdev or just check 
> "->node" is not empty. The latter the faster.
Assume that tz/cdev isn't intiazlized and registered to thermal_tz_list 
or thermal_cdev_list. And then directly call this interface.
>
> Did I misunderstood your comment ?
>
> [ ... ]
>

