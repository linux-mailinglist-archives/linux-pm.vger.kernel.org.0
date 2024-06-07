Return-Path: <linux-pm+bounces-8749-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 242138FFE7D
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jun 2024 10:57:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D5591C22A8B
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jun 2024 08:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 943CD15B12A;
	Fri,  7 Jun 2024 08:57:16 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9815C15AAC2;
	Fri,  7 Jun 2024 08:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717750636; cv=none; b=MGLYk4mfMkie+Nwb6gE3HVo8Hgtw1HyJoCcdEWhwHGMwGc2VwGCpNuv68pWgBLkEaMNK41rVSmUdJpSwkkMS4zuzud664nJuGO1DTafzae+yt+KvA8rU09FtXrlcz7p+81GwnU0yo6q6MxSVMGnYHBforFCdoHTGFTFoMqkehbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717750636; c=relaxed/simple;
	bh=fWf8dL9zgX4/tY0MKEO40QNhd6iKATLd5H6NU7pTBcw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FzVLAHsLlpKeAjfTzmYVPxHlB3paZ6MSLvd1g605MarBdZ1i2vZ/r/GJSTNdFAeY5CvvTTd6EodOptv6EVULguH75tDUcrYp56Sl9YHZU7SQiMmyL22617+yTSYfYE0vcLrIv/vmFQU8TOWyS3FJyxJ5y1DgcjHEjnDfZO+3CvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 08DC92F4;
	Fri,  7 Jun 2024 01:57:38 -0700 (PDT)
Received: from [192.168.2.88] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D6F013F762;
	Fri,  7 Jun 2024 01:57:11 -0700 (PDT)
Message-ID: <96eb4e13-e1c7-4c64-a4bf-0d2b5610d390@arm.com>
Date: Fri, 7 Jun 2024 10:57:10 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] cpuidle: teo: Remove recent intercepts metric
To: Christian Loehle <christian.loehle@arm.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, rafael@kernel.org
Cc: vincent.guittot@linaro.org, qyousef@layalina.io, peterz@infradead.org,
 daniel.lezcano@linaro.org, anna-maria@linutronix.de,
 kajetan.puchalski@arm.com, lukasz.luba@arm.com
References: <20240606090050.327614-1-christian.loehle@arm.com>
 <20240606090050.327614-6-christian.loehle@arm.com>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Language: en-US
In-Reply-To: <20240606090050.327614-6-christian.loehle@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/06/2024 11:00, Christian Loehle wrote:
> The logic for recent intercepts didn't work, there is an underflow
> that can be observed during boot already, which teo usually doesn't
> recover from, making the entire logic pointless.

Is this related to:

https://lkml.kernel.org/r/0ce2d536-1125-4df8-9a5b-0d5e389cd8af@arm.com ?

In this case, a link here would be helpful to get the story.

> Furthermore the recent intercepts also were never reset, thus not
> actually being very 'recent'.
> 
> If it turns out to be necessary to focus more heavily on resets, the
> intercepts metric also could be adjusted to decay more quickly.
> 
> Fixes: 77577558f25d ("cpuidle: teo: Rework most recent idle duration values treatment")
> Signed-off-by: Christian Loehle <christian.loehle@arm.com>

[...]


