Return-Path: <linux-pm+bounces-19346-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE149F3C3C
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2024 22:09:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE3F31635B5
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2024 21:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398DB1E32A0;
	Mon, 16 Dec 2024 21:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mLlr6U8x"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC66161302;
	Mon, 16 Dec 2024 21:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734382856; cv=none; b=hqh3DLT77pv/1/OP7KLBNvMC3YgV8CcY9KFvoFeTTcJidocu0pTF6+53cUJra7XmCjrBWugs5x8ie+rP4hiPaVAAtwcP8r7qTBeSSJTYMHMlgQXmK7o5EdunUsxlUk4e3wmCX/EaNI8FrKb/cUfH8E3Bm8gD54QProkHBq6f6+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734382856; c=relaxed/simple;
	bh=IkgwABEpTX6k+xX+6ZtF199C0d7wI+RvcURG1CDjL1w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AjuminE2p4X2XUhXuv5XOgwRigmWBwlx5zmQxYrmcv8+crhBv8l7t4WSFpoO85YQRnjS+vC6W3CHV0AzMjP+fMDiAI2egnf/asYTEIqqYyxvQpfYVsVWpTBsE5HVEf8O0X4QMosVHcvxRXG0r7RM7nSJEs7/a96xuBhaEHGaLmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mLlr6U8x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42164C4CED0;
	Mon, 16 Dec 2024 21:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734382855;
	bh=IkgwABEpTX6k+xX+6ZtF199C0d7wI+RvcURG1CDjL1w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mLlr6U8xt33FMi7TfvrIdNyeOFqv+gXDKTDXfHLcdELpkXeADQfvhonQaMTWh9t7F
	 fto+kTp/dLvxgBcRw0hcjosX4Dpap14dcK9KuEfAMmTA29ckbus4Aqx2e565VE8PrZ
	 ChoNdoUWohpUX0T/zLrPOxo0gi2kLIqJoUUv79dB8c8tLqAmii04prpznD03nit/MQ
	 svVSv9dZo/r9jovlVtbKpfvGAp9UUJZlLPEvhEGZq9mDNiiJ3zHUSxslic63vnT0Rb
	 UoVOahb5bgdut8TCqfH++OPNb1fHgTQAoXvAQMuf2Z0DLutRguFGTyh3goWmhTR/eH
	 Get8/PfUsamvw==
Message-ID: <5381389c-80bb-4c8d-9708-abc1aa9857ee@kernel.org>
Date: Mon, 16 Dec 2024 14:00:54 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] cpupower: fix TSC MHz calculation
To: He Rongguang <herongguang@linux.alibaba.com>, trenn@suse.com,
 shuah@kernel.org, jwyatt@redhat.com, jkacur@redhat.com, wyes.karny@amd.com
Cc: linux-kernel@vger.kernel.org, shannon.zhao@linux.alibaba.com,
 linux-pm@vger.kernel.org
References: <6084e3c9-921b-4450-97bd-51ec44c52c04@linux.alibaba.com>
Content-Language: en-US
From: Shuah <shuah@kernel.org>
In-Reply-To: <6084e3c9-921b-4450-97bd-51ec44c52c04@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/11/24 19:14, He Rongguang wrote:
> Commit 'cpupower: Make TSC read per CPU for Mperf monitor' (c2adb1877b7)
> changes TSC counter reads per cpu, but left time diff global (from start
> of all cpus to end of all cpus), thus diff(time) is too large for a
> cpu's tsc counting, resulting in far less than acutal TSC_Mhz and thus
> `cpupower monitor` showing far less than actual cpu realtime frequency.
> 
> /proc/cpuinfo shows frequency:
> cat /proc/cpuinfo | egrep -e 'processor' -e 'MHz'
> ...
> processor : 171
> cpu MHz   : 4108.498
> ...
> 
> before fix (System 100% busy):
>      | Mperf              || Idle_Stats
>   CPU| C0   | Cx   | Freq  || POLL | C1   | C2
>   171|  0.77| 99.23|  2279||  0.00|  0.00|  0.00
> 
> after fix (System 100% busy):
>      | Mperf              || Idle_Stats
>   CPU| C0   | Cx   | Freq  || POLL | C1   | C2
>   171|  0.46| 99.54|  4095||  0.00|  0.00|  0.00
> 
> Fixes: c2adb1877b76 ("cpupower: Make TSC read per CPU for Mperf monitor")
> Signed-off-by: He Rongguang <herongguang@linux.alibaba.com>
> ---

Applied to
https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux.git/log/?h=cpupower
to be included in my next pull request to Rafael.

thanks,
-- Shuah

