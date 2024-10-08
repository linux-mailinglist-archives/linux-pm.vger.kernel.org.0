Return-Path: <linux-pm+bounces-15325-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F3DD994963
	for <lists+linux-pm@lfdr.de>; Tue,  8 Oct 2024 14:23:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 143321F23C53
	for <lists+linux-pm@lfdr.de>; Tue,  8 Oct 2024 12:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 317EA1DED43;
	Tue,  8 Oct 2024 12:22:09 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F291DEFE6;
	Tue,  8 Oct 2024 12:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728390129; cv=none; b=RuYW/D5Y93asvdBrrxLZufAO5PFBqMa7VruV7+K+pgALQ8VhT18HsfUfelv+jQ0SVMz+u+xrsu3UfQ5Yc93EnyXEnc5mTt5KbiZzQhPzhsWYwphjc6yjayqzXykZTBGQIP1S2shTf7DaANLKakS6AcMVqlPP/bEg262E9498Xxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728390129; c=relaxed/simple;
	bh=+kJ9fXDK/6WJEeAzWsbpG+CnS97D8U/z3i52apM6/Qk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dgPsAembGXlz7Oz38LOKlcKsVYrsJ5gCwzFmcLvp+SZFjeJNDdQafTYt8tcyTPIgE9QM7nJjkA7MptZntczmpO3iPJJGp3YUgVTVeX5ukq5vGUD2zkJrdB18E/DaZKTuHz07wNYzEKrQP7B83w59Hx/AbXzIieCFfHP6vswV+3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XNFWJ30y7z6K5rY;
	Tue,  8 Oct 2024 20:21:48 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 49386140D1D;
	Tue,  8 Oct 2024 20:22:03 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 8 Oct
 2024 14:21:58 +0200
Date: Tue, 8 Oct 2024 13:21:57 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano
	<daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, Lukasz Luba
	<lukasz.luba@arm.com>, Amit Kucheria <amitk@kernel.org>, Thara Gopinath
	<thara.gopinath@gmail.com>, Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>, Vasily Khoruzhick
	<anarsoul@gmail.com>, Yangtao Li <tiny.windzz@gmail.com>, Chen-Yu Tsai
	<wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland
	<samuel@sholland.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-sunxi@lists.linux.dev>, Chen-Yu Tsai <wenst@chromium.org>
Subject: Re: [PATCH v3 3/6] thermal: of: Use scoped device node handling to
 simplify of_thermal_zone_find()
Message-ID: <20241008132157.00006789@Huawei.com>
In-Reply-To: <20241008-b4-cleanup-h-of-node-put-thermal-v3-3-825122398f71@linaro.org>
References: <20241008-b4-cleanup-h-of-node-put-thermal-v3-0-825122398f71@linaro.org>
	<20241008-b4-cleanup-h-of-node-put-thermal-v3-3-825122398f71@linaro.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 08 Oct 2024 11:00:03 +0200
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> Obtain the device node reference with scoped/cleanup.h to reduce error
> handling and make the code a bit simpler.
> 
> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Ah. I was wondering why you didn't do this in patch 1.
Sensible to split though I'd have put it as patch 2 for the lazy reviewer
to spot more easily ;)

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

