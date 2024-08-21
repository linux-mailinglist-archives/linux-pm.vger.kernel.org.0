Return-Path: <linux-pm+bounces-12636-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F172959AF9
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2024 13:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BB6E282233
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2024 11:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0EFE1A4AB8;
	Wed, 21 Aug 2024 11:48:08 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743EB189907;
	Wed, 21 Aug 2024 11:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724240888; cv=none; b=iTCscWvhDLnzYzqm392Se46DarUnIlGP7E+Cd5Uq02TME1BKvPhPDU8L5b3OKWQ45eHOhAvT4yiJL1acnuE/uclt75i48vTmC9YqTGLmXdYi9hJ5ziyUQF8y37UmyPxyyk/BfXs+0FIHPKxv7jh4+HCm4vuR/waDCUTaF/M11oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724240888; c=relaxed/simple;
	bh=5UJza2ct5uFviMUue2skQT9c6gKWFscFOlvH1a6cUCo=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KE5PSZPuV+sW3ddNKOPeNIalsjZY0J3dFrOM8NmT3ZbSMPQOWfUbV9qrT1gYZA4Xlk/hJIL/kL8r7+0fYwOMkP0539R39nZHkBLdhqP44UPb90waRW+sf6FSgQuJcFzrD08FOETXebpwLTpfpVjSUSwN7Q5mKgobycjVDI5es6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Wpkyx6hvRz6J7nH;
	Wed, 21 Aug 2024 19:44:57 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id C2AA1140119;
	Wed, 21 Aug 2024 19:48:03 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 21 Aug
 2024 12:48:03 +0100
Date: Wed, 21 Aug 2024 12:48:02 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC: Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Anup Patel
	<anup@brainfault.org>, Paul Walmsley <paul.walmsley@sifive.com>, "Palmer
 Dabbelt" <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
	<linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH 2/4] cpuidle: riscv-sbi: Use scoped device node handling
 to simplify error paths
Message-ID: <20240821124802.00000c35@Huawei.com>
In-Reply-To: <e006aa3d-3ec1-415f-a8d2-8aee6847a698@linaro.org>
References: <20240816150931.142208-1-krzysztof.kozlowski@linaro.org>
	<20240816150931.142208-2-krzysztof.kozlowski@linaro.org>
	<20240819171313.00004677@Huawei.com>
	<20240819171954.0000600d@Huawei.com>
	<e006aa3d-3ec1-415f-a8d2-8aee6847a698@linaro.org>
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
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 20 Aug 2024 11:36:32 +0200
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 19/08/2024 18:19, Jonathan Cameron wrote:
> > On Mon, 19 Aug 2024 17:13:13 +0100
> > Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
> >   
> >> On Fri, 16 Aug 2024 17:09:29 +0200
> >> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> >>  
> >>> Obtain the device node reference with scoped/cleanup.h to reduce error
> >>> handling and make the code a bit simpler.
> >>>
> >>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>    
> >> The original code looks suspect. See below.  
> > 
> > Whilst here...  Why not do similar for state_node to avoid
> > the delayed return check.
> > Existing code
> > 	{
> > 		state_node = of_get_cpu_state_node(cpu_node, i - 1);
> > 		if (!state_node)
> > 			break;  
> 
> I don't see how __free() helps here. You can return regardless of __free().
> 
> > 
> > 		ret = sbi_dt_parse_state_node(state_node, &states[i]);
> > 		of_node_put(state_node);  
> 
> ... and this code is quite easy to read: you get reference and
> immediately release it.
> 
> > 
> > 		if (ret)
> > 			//another bug here on holding cpu_node btw.
> > 			return ret;
> > 		pr_debug("sbi-state %#x index %d\n", states[i], i);
> > 	}
> > //I think only path to this is is early break above.
> > 	if (i != state_count) {
> > 		ret = -ENODEV;
> > 		goto fail;
> > 	}
> > Can be something like
> > 
> > 	{
> > 		struct device_node *state_node __free(device_node) =
> > 			= of_get-cpu_State_nod(cpu_node, i - 1);
> > 	
> > 		if (!state_node)
> > 			return -ENODEV;
> > 
> > 		ret = sbi_dt_parse_state_node(state_node, &states[i]);
> > 		if (ret)
> > 			return ret;
> > 
> > 		pr_debug("sbi-state %#x index %d\n", states[i], i);
> > 	}
> > 		  
> 
> Maybe I miss something, but I do not see how the __free() simplifies
> here anything.

Personal preference.  To my eyes, it does, but indeed not a huge
advantage.

Jonathan

> 
> Best regards,
> Krzysztof
> 


