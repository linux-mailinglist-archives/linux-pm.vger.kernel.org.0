Return-Path: <linux-pm+bounces-12612-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D33F9959873
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2024 12:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F39FB22D70
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2024 10:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0871A1E3010;
	Wed, 21 Aug 2024 09:10:05 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E1B1E3004;
	Wed, 21 Aug 2024 09:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724231404; cv=none; b=sp8+xYf0eECR4pncaOUUCiY2FrWDl/CfFdCPY//72e89oYCMNVz+brvK7xF/mWeL/sMK+FeC3r6ZCs2ZAs9cPQu8zufSf/8Q+aMswht6bCK0d/gfuSFtfR4KlPcD7tgbU4bcBK6bn/V5vPq3dLkyTuqsIVEapeBxeyuPptJ/YSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724231404; c=relaxed/simple;
	bh=tMdWpVrBjVPtmk60JzPtlhHBQAasHU5Jbcb1VMuYEDs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=EaPORkdS5gTmfJM0Yc01I/HkZiXsFcD9RvFwQ+W5O1Zlb/ddvEaHIHKuJblSB4Z94RA1AGUhrVI2dM0oMHIz/Atnhro2blxZY5wqcjg0ikn7xvgQxc9pja36E+FuOYMbNdQ7Id88qDqUIz3xACZYrbb0JBvg4umj9J5ggAwYGrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WpgX432V4z2Cllw;
	Wed, 21 Aug 2024 17:09:56 +0800 (CST)
Received: from kwepemm600004.china.huawei.com (unknown [7.193.23.242])
	by mail.maildlp.com (Postfix) with ESMTPS id 9F3121400CA;
	Wed, 21 Aug 2024 17:09:58 +0800 (CST)
Received: from [10.67.121.59] (10.67.121.59) by kwepemm600004.china.huawei.com
 (7.193.23.242) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 21 Aug
 2024 17:09:58 +0800
Message-ID: <916f784f-e6e2-c742-6948-5f2db688ba44@huawei.com>
Date: Wed, 21 Aug 2024 17:09:57 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v3 06/14] thermal: core: Introduce .should_bind() thermal
 zone callback
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM
	<linux-pm@vger.kernel.org>
CC: LKML <linux-kernel@vger.kernel.org>, Daniel Lezcano
	<daniel.lezcano@linaro.org>, Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui
	<rui.zhang@intel.com>
References: <2205737.irdbgypaU6@rjwysocki.net>
 <9334403.CDJkKcVGEf@rjwysocki.net>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <9334403.CDJkKcVGEf@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600004.china.huawei.com (7.193.23.242)


在 2024/8/20 0:00, Rafael J. Wysocki 写道:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> The current design of the code binding cooling devices to trip points in
> thermal zones is convoluted and hard to follow.
>
> Namely, a driver that registers a thermal zone can provide .bind()
> and .unbind() operations for it, which are required to call either
> thermal_bind_cdev_to_trip() and thermal_unbind_cdev_from_trip(),
> respectively, or thermal_zone_bind_cooling_device() and
> thermal_zone_unbind_cooling_device(), respectively, for every relevant
> trip point and the given cooling device.  Moreover, if .bind() is
> provided and .unbind() is not, the cleanup necessary during the removal
> of a thermal zone or a cooling device may not be carried out.
>
> In other words, the core relies on the thermal zone owners to do the
> right thing, which is error prone and far from obvious, even though all
> of that is not really necessary.  Specifically, if the core could ask
> the thermal zone owner, through a special thermal zone callback, whether
> or not a given cooling device should be bound to a given trip point in
> the given thermal zone, it might as well carry out all of the binding
> and unbinding by itself.  In particular, the unbinding can be done
> automatically without involving the thermal zone owner at all because
> all of the thermal instances associated with a thermal zone or cooling
> device going away must be deleted regardless.
>
> Accordingly, introduce a new thermal zone operation, .should_bind(),
> that can be invoked by the thermal core for a given thermal zone,
> trip point and cooling device combination in order to check whether
> or not the cooling device should be bound to the trip point at hand.
> It takes an additional cooling_spec argument allowing the thermal
> zone owner to specify the highest and lowest cooling states of the
> cooling device and its weight for the given trip point binding.
>
> Make the thermal core use this operation, if present, in the absence of
> .bind() and .unbind().  Note that .should_bind() will be called under
> the thermal zone lock.
>
> No intentional functional impact.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
all thermal zone is linked to thermal_tz_list and cooling devices is 
linked to thermal_cdev_list.
But if one cooling device should bind to a trip in thermal zone is 
determined by thermal driver.
Introducing should_bind() looks good to me.
Acked-by: Huisong Li <lihuisong@huawei.com>
>
>
>
>
> .

