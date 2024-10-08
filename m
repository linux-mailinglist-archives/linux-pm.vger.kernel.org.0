Return-Path: <linux-pm+bounces-15326-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD616994985
	for <lists+linux-pm@lfdr.de>; Tue,  8 Oct 2024 14:24:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A44728640A
	for <lists+linux-pm@lfdr.de>; Tue,  8 Oct 2024 12:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA061DEFF6;
	Tue,  8 Oct 2024 12:23:32 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BC91DE89D;
	Tue,  8 Oct 2024 12:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728390212; cv=none; b=hagTrs2zNQ3bUpgp6RhZXJEjf4oLwLOQ1FDK/He968TZR+nkhnaMxbAr3uFjH7S39yQ6/g/6kJYEbqe/GGZeWFCPyRdxrlsD7eUFnbS+2aR3IiWI5Fm72f+ajDhbmiBmP4p9Py+YkFFPyJifylhvFd3/eySyqlRegzc4VotRmSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728390212; c=relaxed/simple;
	bh=SCF5MKEq16SFnbVDi08n3eyf7GGCyNqr4vBbOqEWMcw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M3274GtWGFaUBKXR0/Kc9jR/Vxk9QMod9no1jxQ7klpy7ehylfD6T8PBS2H7HfLxCwx/4nWiYVZhT31moAIDu2QDPnumavO94Vm35AdfIEGiBiGTa0rANhEgzvgVyClMP5Iba+guqVtL1ODie7SAtlkMD4WeomAzfYJHW3iw40E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XNFSH4knhz6L77W;
	Tue,  8 Oct 2024 20:19:11 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 6D17A140517;
	Tue,  8 Oct 2024 20:23:29 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 8 Oct
 2024 14:23:28 +0200
Date: Tue, 8 Oct 2024 13:23:27 +0100
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
Subject: Re: [PATCH v3 4/6] thermal: qcom-spmi-adc-tm5: Simplify with scoped
 for each OF child loop
Message-ID: <20241008132327.00007777@Huawei.com>
In-Reply-To: <20241008-b4-cleanup-h-of-node-put-thermal-v3-4-825122398f71@linaro.org>
References: <20241008-b4-cleanup-h-of-node-put-thermal-v3-0-825122398f71@linaro.org>
	<20241008-b4-cleanup-h-of-node-put-thermal-v3-4-825122398f71@linaro.org>
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

On Tue, 08 Oct 2024 11:00:04 +0200
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> Use scoped for_each_available_child_of_node_scoped() when iterating over
> device nodes to make code a bit simpler.
> 
> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

