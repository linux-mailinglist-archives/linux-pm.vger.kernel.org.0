Return-Path: <linux-pm+bounces-28792-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55104ADAAD9
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 10:33:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C884F3B69A0
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 08:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D3F26F453;
	Mon, 16 Jun 2025 08:29:12 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA8526D4E2
	for <linux-pm@vger.kernel.org>; Mon, 16 Jun 2025 08:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750062552; cv=none; b=mFZb7uMVmJ6KFOttw/NAgx/YVfx826OoSP57V+QglMyMCrUewREMTnadSfRlRi/aT1sxvU7gggowLzmzlYwa1IMdesFTHECRCNChtPbIDpq5wkRfFJcGwZw5IdZ134MK4mgwACdqgUptLupV5VIJg+BNLSglwpNNqseB1iW0tlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750062552; c=relaxed/simple;
	bh=1PMz8bkacmDieyQ2PK7BoUMlRWZRK1/PAiIqyKlvhRk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TmwHk6JktB6WVCwFWqbwnReYAYwaUTqfRckWpufvWZaDOQNzjBNqU+JV5CDKEl0EMLQBayhevKlRKKzk6w4egqoGa0jMA4Ey7nKH2RWTVIYURyPUWDXvRBiUfP5Lf40y9Gvyg9vOZE1r0UVeX78cOErG0qZUh4ypS2WHxow+9FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bLNQQ2ztvz6L5Gh;
	Mon, 16 Jun 2025 16:26:54 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 25CD01404A9;
	Mon, 16 Jun 2025 16:29:01 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 16 Jun
 2025 10:29:00 +0200
Date: Mon, 16 Jun 2025 09:29:00 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Jie Zhan <zhanjie9@hisilicon.com>, <linuxarm@huawei.com>
CC: <cw00.choi@samsung.com>, <myungjoo.ham@samsung.com>,
	<kyungmin.park@samsung.com>, <linux-pm@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <jonathan.cameron@huawei.com>,
	<alireza.sanaee@huawei.com>, <zhenglifeng1@huawei.com>,
	<lihuisong@huawei.com>, <yubowen8@huawei.com>, <liwei728@huawei.com>,
	<prime.zeng@hisilicon.com>
Subject: Re: [PATCH v4 1/2] PM / devfreq: Allow devfreq driver to add custom
 sysfs ABIs
Message-ID: <20250616092822.00002233@huawei.com>
In-Reply-To: <20250530081722.280776-2-zhanjie9@hisilicon.com>
References: <20250530081722.280776-1-zhanjie9@hisilicon.com>
	<20250530081722.280776-2-zhanjie9@hisilicon.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 30 May 2025 16:17:21 +0800
Jie Zhan <zhanjie9@hisilicon.com> wrote:

> Extend the devfreq_dev_profile to allow drivers optionally create
> device-specific sysfs ABIs together with other common devfreq ABIs under
> the devfreq device path.
> 
> Signed-off-by: Jie Zhan <zhanjie9@hisilicon.com>
Seems like a good addition to me.
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

