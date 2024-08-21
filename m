Return-Path: <linux-pm+bounces-12616-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98FDB9598E3
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2024 13:02:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB8151C2179C
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2024 11:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B3F1B81C5;
	Wed, 21 Aug 2024 09:33:19 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12C91F3742;
	Wed, 21 Aug 2024 09:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724232799; cv=none; b=HrRWavmG+iazJyTY48+w5wmHz51nNUxUznoJzbh/HncMfdIZj4jHvprmwMxXRlxAt4HO2Ruz3KWmmYAtNEseptLnfbvF8pyJMLF5zmJlGxWnGYd8zs0nYl3/JXzc6G+ox6ktkT+MYa2WOEo7nXfZKfmjwkVs+u3DEERYpeL7hSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724232799; c=relaxed/simple;
	bh=C3A4sXBxwuZMz9ivnOvAuOhjteIos9dOFCaEJK4n5KY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UkB4r4gsyl6ThC91o/s3AFO/xvuXmjZPakZbzjOyNHqdVdtBctf6Eq/R8a43mUrDK7DP/G2Kt2xrlJRS5+pmW3bjtrv3Uc3IdspHeXPaGz7rcGvGp9amO8QWXPn0ZNsle0zanwLN2rH89NU4DYcUoRsi1P+ie9gaVeu8Cn6D5Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Wph0d64g5zhY2T;
	Wed, 21 Aug 2024 17:31:13 +0800 (CST)
Received: from kwepemm600004.china.huawei.com (unknown [7.193.23.242])
	by mail.maildlp.com (Postfix) with ESMTPS id 608461401E0;
	Wed, 21 Aug 2024 17:33:14 +0800 (CST)
Received: from [10.67.121.59] (10.67.121.59) by kwepemm600004.china.huawei.com
 (7.193.23.242) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 21 Aug
 2024 17:33:13 +0800
Message-ID: <5b64b856-fc21-6142-e3ff-0faa5098982e@huawei.com>
Date: Wed, 21 Aug 2024 17:33:13 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v3 13/14] thermal: core: Drop unused bind/unbind functions
 and callbacks
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC: LKML <linux-kernel@vger.kernel.org>, Daniel Lezcano
	<daniel.lezcano@linaro.org>, Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui
	<rui.zhang@intel.com>, Linux PM <linux-pm@vger.kernel.org>
References: <2205737.irdbgypaU6@rjwysocki.net>
 <4251116.1IzOArtZ34@rjwysocki.net>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <4251116.1IzOArtZ34@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600004.china.huawei.com (7.193.23.242)


在 2024/8/20 0:31, Rafael J. Wysocki 写道:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> There are no more callers of thermal_zone_bind_cooling_device() and
> thermal_zone_unbind_cooling_device(), so drop them along with all of
> the corresponding headers, code and documentation.
>
> Moreover, because the .bind() and .unbind() thermal zone callbacks would
> only be used when the above functions, respectively, were called, drop
> them as well along with all of the code related to them.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
lgtm,
Acked-by: Huisong Li <lihuisong@huawei.com>
>
>
>
>
> .

