Return-Path: <linux-pm+bounces-39363-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CD46CCB05A8
	for <lists+linux-pm@lfdr.de>; Tue, 09 Dec 2025 16:04:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 68F1A304C2A8
	for <lists+linux-pm@lfdr.de>; Tue,  9 Dec 2025 15:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3532FF171;
	Tue,  9 Dec 2025 15:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sewn7ldr"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82AE61E8332
	for <linux-pm@vger.kernel.org>; Tue,  9 Dec 2025 15:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765292673; cv=none; b=F5g8RPvSrI7PHW1P6Raa3PAqXfVI1qIHKO6OjRoucZaX3bEN9xyKn28zllRhrIHy9zH48+YnPo+yLh40nYJvoU4mukvBsbR3DyhnE8EVNrTtcmZKnuV9zJbft80IlpD1OknWf/O3Pw4JpesPZqSRgiAUrJbYxjIaCjUowUcZ7kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765292673; c=relaxed/simple;
	bh=Na/pC0kVeCH56IKvI8lxJhknz8vSWeGqlxbZOiq0FaE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PT7SET4IEInpwn7ZDHEgZu2+B20tEMOnxRiRniRPQvXBXRPNpeapJPMb0WlltxsMEis+MAkWv4AP+2Z7Z53C9xzuy92/V+v4PZmbY0C8Cu0+RbUloji7IIsdi0O5YfXjMK2CR6K+epa+AJJPidP6Y3DsEUgrPEv5o/k62G+91ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sewn7ldr; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7c32c6eb79dso339815b3a.1
        for <linux-pm@vger.kernel.org>; Tue, 09 Dec 2025 07:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765292671; x=1765897471; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PfnacZa7lQk1UkoU+10PADVx4NiV/d9RSz8Lvu845xI=;
        b=Sewn7ldrGXOa4w4Z3eYzhD3GGO0ByqSM9DzTr7OqCMKaBc9tytLj6w7ZaUW1yZrl1d
         1dZIcNXdVwfOYTeM+XkS7IJnHriBDuez06NAQFBzSDGtMJb3QhRQhU8x5jzQjeW7pWF0
         8LLRwLL9F6OzrsOEU5pmcmJHtrtm5VfVuTrEDZEYvl3rhbR0VtjzkRcxCh9A/wtnzWI1
         fGNMmtqJT17bTw0p0m/thY8mETzjDaSu5kKpgOG/nW1uctsDReyyNAKwDHR54elpqeWZ
         dNlU76R446DKZxKvJttjW8Diwq40tZU8Ju3BkD2rDbd3Jnal176uQmxK9RmJu5SPpCSo
         H8ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765292671; x=1765897471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PfnacZa7lQk1UkoU+10PADVx4NiV/d9RSz8Lvu845xI=;
        b=BeUuEBzGTLrxVoZwqT3Ox/yJgH7D+gU2Z7NcUHZnh3mEKiSXA+4WJmIyXusPO9PeC4
         LUSJ/gz59wPfR7ZOO5CmofewennqefNQ3NFAYXtSuqM4IqetLggz5HqI4xnKBf7ix8xP
         29yp0fs4LiecDMp6zGEJ59wr7DvENwPonZplvucc1sYqVy/ADEcX1012VnKpuUDy+Oxg
         8LozyhXup+HkzaUZxtHWLSi0yVcg9q/38aPryGMH4O2yTvbsc6Ud/EnJ+Q9jNmz1CbzO
         M5Sq5CxHYYeeBt30SgQL/bSV4Zatc1uzKH8fUbubMoAnCL5Rfx+Vp4vTkdqQG2rM9exj
         otHg==
X-Forwarded-Encrypted: i=1; AJvYcCX6QJGqlJG+Xgunf8o1/55oOGGlkapp+j6fTkJguqSPmLw1+uz2ghLGLKttLAeTMesA2o6gtBa12A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwsDdoYxEmVN+ysaSUcLh8ak+8EgkhCS1hZMxRVVscAdybnPlfX
	mlT7MEQOpFdzKRI940kRQ3DYhbnh6+XAumTcg7NJ6snf4kdKjULrhoL8
X-Gm-Gg: ASbGncs8fN4wBqOqbl0AVId3yTLq3mJOAncnA1Wb2LOMZPugMLrQaKpgzV2A8AzXrwt
	J6TyTCZecsBm26bDRld7HoD4X0XLPgpRRCC5/vyTVyG61tTUD/vBfu/Bqag9HWJ0OsHFosC2JR+
	FfSqrShOeU1OOcNqYq9rMNOeZMO+Y3P8+tvns4o9oqbsoqt6BtWHdnQKYJdIROSykvUdWv9ShuY
	3xca+ow4z3mJlIYe5sAPxUY3n6WpMrCMlroofeRahAXk97OIxWPxQPjKu8hvI9IZkR8a24TAHTd
	8KMQ74Um94vu9R/A0egSibQM5qYI4feGPOX3abEFUGzEKOjC0uS4n44GSarU/0FTlPJF8F26AaR
	4BpKKmVMon6xZ+Ow4RcqZNCqTFXq2d/cRcNy9u9xN29jpwjZWPsDFvHzxGDfWpKaSXbgFzoo+sV
	3oLRyyv17YN6vMjKJbaVY=
X-Google-Smtp-Source: AGHT+IH6fU4r16kU8MAxX63Y2MbZhh1Vkb7M4IyVPwitFIhNynOKo+wM4p1RzfclauryAhGCHkY8BA==
X-Received: by 2002:a05:6a00:240f:b0:7ba:13f4:a992 with SMTP id d2e1a72fcca58-7e8c68c6d04mr6571572b3a.5.1765292670382;
        Tue, 09 Dec 2025 07:04:30 -0800 (PST)
Received: from ArchLinux ([240e:47e:2e50:e3f:8b77:7554:2025:6aac])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7e2a0a008e2sm16396684b3a.28.2025.12.09.07.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Dec 2025 07:04:29 -0800 (PST)
From: rmxpzlb <rmxpzlb@gmail.com>
To: sebastian.reichel@collabora.com
Cc: heiko@sntech.de,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	rmxpzlb@gmail.com,
	ulf.hansson@linaro.org
Subject: Re: [PATCH] pmdomain:rockchip: Fix init genpd as GENPD_STATE_ON before regulator ready
Date: Tue,  9 Dec 2025 23:04:21 +0800
Message-ID: <20251209150421.2229-1-rmxpzlb@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <nokcp3ky37sdonx2kaqnmtr2pdqwoifrtpam7tqqygldl32tec@y2p3tcnd3bxa>
References: <nokcp3ky37sdonx2kaqnmtr2pdqwoifrtpam7tqqygldl32tec@y2p3tcnd3bxa>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

>Hi,
>> On Fri, Dec 05, 2025 at 02:47:39PM +0800, Frank Zhang wrote:
>> RK3588_PD_NPU initialize as GENPD_STATE_ON before regulator ready.
>> rknn_iommu initlized success and suspend RK3588_PD_NPU. When rocket
>> driver register, it will resume rknn_iommu.
>> 
>> If regulator is still not ready at this point, rknn_iommu resume fail,
>> pm runtime status will be error: -EPROBE_DEFER.
>> 
>> This patch check regulator when pmdomain init, if regulator is not ready
>> or not enabled, power off pmdomain. Consumer device can power on it's
>> pmdomain after regulator ready
>> 
>> Signed-off-by: Frank Zhang <rmxpzlb@gmail.com>
>> ---
>>  drivers/pmdomain/rockchip/pm-domains.c | 14 ++++++++++++++
>>  1 file changed, 14 insertions(+)
>> 
>> diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/rockchip/pm-domains.c
>> index 1955c6d453e4..bc69f5d840e6 100644
>> --- a/drivers/pmdomain/rockchip/pm-domains.c
>> +++ b/drivers/pmdomain/rockchip/pm-domains.c
>> @@ -659,6 +659,11 @@ static int rockchip_pd_power(struct rockchip_pm_domain *pd, bool power_on)
>>  	return ret;
>>  }
>>  
>> +static bool rockchip_pd_regulator_is_enabled(struct rockchip_pm_domain *pd)
>> +{
>> +	return IS_ERR_OR_NULL(pd->supply) ? false : regulator_is_enabled(pd->supply);
>> +}
>> +
>>  static int rockchip_pd_regulator_disable(struct rockchip_pm_domain *pd)
>>  {
>>  	return IS_ERR_OR_NULL(pd->supply) ? 0 : regulator_disable(pd->supply);
>> @@ -861,6 +866,15 @@ static int rockchip_pm_add_one_domain(struct rockchip_pmu *pmu,
>>  		pd->genpd.name = pd->info->name;
>>  	else
>>  		pd->genpd.name = kbasename(node->full_name);
>> +
>> +	if (pd->info->need_regulator) {
>> +		if (IS_ERR_OR_NULL(pd->supply))
>> +			pd->supply = devm_of_regulator_get(pmu->dev, pd->node, "domain");
>> +
>> +		if (!rockchip_pd_regulator_is_enabled(pd))
>> +			rockchip_pd_power(pd, false);
>> +	}
>
>It is extremly unlikely, that you will be able to get the regulator
>at driver probe time. The typical regulator for NPU or GPU is
>connected via SPI or I2C, which will only be available after the
>power domain driver has been probed. So I suppose this could be
>simplified as:
>
>--------------------------------------------
>/*
> * power domain's needing a regulator should default to off, since
> * the regulator state is unknown at probe time. Also the regulator
> * state cannot be checked, since that usually requires IP needing
> * (a different) power domain.
> */
>if (pd->info->need_regulator)
>    rockchip_pd_power(pd, false);
>--------------------------------------------
>
>I think the proper fix would be to add support for registering the
>regulator needing power-domain's delayed and then enforce requesting
>the regulator at probe time. That's not trivial to implement, though.
>
>Greetings,
>
>-- Sebastian
>
>> +
>>  	pd->genpd.power_off = rockchip_pd_power_off;
>>  	pd->genpd.power_on = rockchip_pd_power_on;
>>  	pd->genpd.attach_dev = rockchip_pd_attach_dev;

Thanks for your comment. This simplification is OK for me.
I will test and send new patch.

