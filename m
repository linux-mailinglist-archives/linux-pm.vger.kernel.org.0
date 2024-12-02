Return-Path: <linux-pm+bounces-18311-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B1789DF8E0
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2024 03:22:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58937281642
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2024 02:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4F8D1BC49;
	Mon,  2 Dec 2024 02:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="gnfta1Ki"
X-Original-To: linux-pm@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BC079FE;
	Mon,  2 Dec 2024 02:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733106116; cv=none; b=kcdeqmOrT42PPC1AoYTTpPf0lvLlMLViu3QW7x6D1+nFJjzbNXIFamK+GezzPlebyZFHb7mo2pgxulQgvWq/1n1HcTfKdEgYgZPbyKUQ5xWI2+aqHac8XacBrnIrK3MDxyNExpB5xOT+3IcIHS5a73QEHnY/Y3eTUNeK2d8jPq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733106116; c=relaxed/simple;
	bh=LR0MmGaRtUyrW50ifGMGbbMQL6LbaPM2IKqZahuD1aA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=NQFoHOm4kv0h/hWvvGfHsAHHZXgoIElrvpge48iU1itm8t0fVBCTrgS1iBC0+XgC22FbT8/q7o0uKojHxGxdqqgltwuiUgvMKXSYt7YuIKM7omrkYPcjXurQvSnvj0V+9uk4NpEQ7LqR5REQcD6phUflkr0fnBeKIpgzLQ8Ncqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=gnfta1Ki; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1733106105; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=QtIqNJ3JYv7DvU3OG6akLfuFJ3Hoy+0UAqYR7csBzHk=;
	b=gnfta1KiZ4OtCNKufSDQQ5xavjb/RESpEsx5GFmlgSCXFaAc916ExnZLV7ZeFhH9lGRIdmPckUa+OWcvKjXe1EOjeT6C2L0y7EWC6goI+NZo7D918ZgwgwPRWTXGZ3F8gQt+ggW7qTBdVNIbAp0qmA1CRHGfHCOPJ+7jq9A/GHI=
Received: from 30.221.99.85(mailfrom:herongguang@linux.alibaba.com fp:SMTPD_---0WKbbs3a_1733106103 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 02 Dec 2024 10:21:44 +0800
Message-ID: <db5b93c6-9cb3-497d-bc9d-4a7d309125b2@linux.alibaba.com>
Date: Mon, 2 Dec 2024 10:21:44 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpupower: fix TSC MHz calculation for Mperf monitor
From: He Rongguang <herongguang@linux.alibaba.com>
To: trenn@suse.com, shuah@kernel.org, jwyatt@redhat.com, jkacur@redhat.com,
 wyes.karny@amd.com
Cc: linux-kernel@vger.kernel.org, shannon.zhao@linux.alibaba.com,
 linux-pm@vger.kernel.org
References: <269b8bb2-85b5-4cc9-9354-a1270f2eed35@linux.alibaba.com>
In-Reply-To: <269b8bb2-85b5-4cc9-9354-a1270f2eed35@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

在 2024/11/28 17:50, He Rongguang 写道:
> Commit 'cpupower: Make TSC read per CPU for Mperf monitor' (c2adb1877b7)
> changes TSC counter reads to per cpu, but left time diff global (from
> start of all cpus to end of all cpus), thus diff(time) is too large for
> a cpu's tsc counting, resulting in far less than acutal TSC_Mhz and thus
> `cpupower monitor` showing far less than actual cpu realtime frequency.
> 
Ok, wyes.karny seems not in AMD anymore, Maintainers please review this
patch, thanks.

Delivery has failed to these recipients or groups:

wyes.karny@amd.com
The email address you entered couldn't be found. Please check the
recipient's email address and try to resend the message. If the problem
continues, please contact your email admin.

