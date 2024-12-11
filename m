Return-Path: <linux-pm+bounces-18982-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 620C49EC34C
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2024 04:27:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 305C018834E4
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2024 03:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BDE120C496;
	Wed, 11 Dec 2024 03:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="dXfiSrWq"
X-Original-To: linux-pm@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD86F9E6;
	Wed, 11 Dec 2024 03:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733887656; cv=none; b=SINcrSd3vopOUQiostiaG6UNd96PBrHZUrdDEgCqax58h8GBuLX0Zbs6qb8cn8eEArbxGMsfoHgauU2syJfRy+47pMyXoyZWHyvOoAs6uQxQmbOG6Y299DDDLznUf8tVhxAuQfkhBNkEndthxEWs0wKKpL+7Gp572YiXL0LAE6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733887656; c=relaxed/simple;
	bh=oGIxq/iI1wo851xpx2ELhPZvEQBtBsTQWKCbZPaS/GE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XwkpyCX2AnBQeDaqV/GqbBsrTZ8Mnd0a6aoXJzkn1zdYSB0mOU2qfyCZ0UdKRw3j0NtxavQ1y1K8c5mFMPTT2jidmtfaKVA5wZwLzKoDR3hryWzHYWFXs5f3tW1riqG8RFcikxvY0Y+g5pbQXM0xgpM5BkxRWJizzRNPaXPAqVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=dXfiSrWq; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1733887645; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=de+rcCjnDfrt3AiRrV5ZVb4VpCQXlSQK7WzvWfzrnqg=;
	b=dXfiSrWqK4NnWPe9x3J+JnGGG6KJJxD2YjU4XlcVj2Te9U6WoJ7aePeH7qx9JFEPXhVsQ8XrWbMlLOUnGpRZ3YBrOvXaoma/hENGZfPFbrpAUORsdZUyTM3WWvVen/g3+jaR3r2I6p3g4ZV6twF6QvQ8zhfO8NyS5CtNDvBeSj0=
Received: from 30.221.97.190(mailfrom:herongguang@linux.alibaba.com fp:SMTPD_---0WLGp5-G_1733887324 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 11 Dec 2024 11:22:06 +0800
Message-ID: <8508d3be-e069-440c-a1f7-7da7785753e7@linux.alibaba.com>
Date: Wed, 11 Dec 2024 11:22:05 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpupower: fix TSC MHz calculation for Mperf monitor
To: Shuah Khan <skhan@linuxfoundation.org>, trenn@suse.com, shuah@kernel.org,
 jwyatt@redhat.com, jkacur@redhat.com, wyes.karny@amd.com
Cc: linux-kernel@vger.kernel.org, shannon.zhao@linux.alibaba.com,
 linux-pm@vger.kernel.org
References: <269b8bb2-85b5-4cc9-9354-a1270f2eed35@linux.alibaba.com>
 <e5b0996d-be80-47a9-af28-ee9776638ab7@linuxfoundation.org>
From: He Rongguang <herongguang@linux.alibaba.com>
In-Reply-To: <e5b0996d-be80-47a9-af28-ee9776638ab7@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

在 2024/12/10 8:43, Shuah Khan 写道:
>> ---
> 
> This patch has several warnings and seems to corrupt. Can you
> look into this and send v2?
> 
> scripts/checkpatch.pl will show you the problems.
> 
> thanks,
> -- Shuah
Ok, sent a v2, thanks.

