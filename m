Return-Path: <linux-pm+bounces-12464-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A0B8957033
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2024 18:27:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2DA1B256EF
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2024 16:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD87616D4EA;
	Mon, 19 Aug 2024 16:26:25 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12B747F46;
	Mon, 19 Aug 2024 16:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724084785; cv=none; b=bKhg638EqTHDZyBpdWElkZTVotiKtCn9bqoyzm2HlIs0NgNiTFIk+UcLxkTRqYSnLsb7D9K3iJXOTuCvTFUhyHHjWWhisbwVE6RTfQHPl2dGSL5DNYTjgqGcqkLdxivxBKwCVxCjNERGSDS1XizRPHIY7kkrLePYxUh/+4n84QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724084785; c=relaxed/simple;
	bh=E51owF6n8E5s96puXzh0Rq2eQjda9wHs2nr1INL2hdI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ocZznpZT02gF4r7qljYuA6y3x5tT3BhiBffHokJopYkGtL2DkVx2a3tM15jWzKQRqDOsnIsVzDjnJsu0Fg5/DMRJcZZ/T8EpFwxvtWydVd/YXQFGjOiuAQuLjNCXM2cJkOLkpXNGV5dThDvyZl6g4jLpvCZZr79IGttdWWA1yUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WndFC5njvz6K5mr;
	Tue, 20 Aug 2024 00:23:27 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 609F8140A46;
	Tue, 20 Aug 2024 00:26:21 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 19 Aug
 2024 17:26:20 +0100
Date: Mon, 19 Aug 2024 17:26:19 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC: Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Anup Patel
	<anup@brainfault.org>, Paul Walmsley <paul.walmsley@sifive.com>, "Palmer
 Dabbelt" <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
	<linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH 4/4] cpuidle: dt_idle_genpd: Simplify with scoped for
 each OF child loop
Message-ID: <20240819172619.0000670a@Huawei.com>
In-Reply-To: <20240816150931.142208-4-krzysztof.kozlowski@linaro.org>
References: <20240816150931.142208-1-krzysztof.kozlowski@linaro.org>
	<20240816150931.142208-4-krzysztof.kozlowski@linaro.org>
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
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 16 Aug 2024 17:09:31 +0200
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> Use scoped for_each_child_of_node_scoped() when iterating over device
> nodes to make code a bit simpler.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
LGTM
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

