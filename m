Return-Path: <linux-pm+bounces-23338-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 194F9A4CE3C
	for <lists+linux-pm@lfdr.de>; Mon,  3 Mar 2025 23:25:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43AEE173A15
	for <lists+linux-pm@lfdr.de>; Mon,  3 Mar 2025 22:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B932356DC;
	Mon,  3 Mar 2025 22:24:45 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEBE11EF082;
	Mon,  3 Mar 2025 22:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741040685; cv=none; b=CyKinLxQPAlsxgIYmgOQb+c19+hrURwxtfx1jHMdIzZ1I/iGAwhKprxO0PHOgu4o2sd+i3ixWh3MdByxTdSCtxPJ0FyiTpaxdyLtpQz1bHBhANCVLEqXSWifS9lLeRuFLjdqK7r7stZ7FjqfoKzDRBu52FRqpKyRzQPLKUbPE5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741040685; c=relaxed/simple;
	bh=ed3v7D8g5+zZxn49ZWB9w7aSJdszoLWmToOe3eQ8y98=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UBLH/YZ3L7iEbWq0CFHCzLe6tLl42IXiD0yZhEcP1wZbt1aXB5yQUPCzvZKDlVLbbkg/i4toqM2NCEoYrEG7kdWJwXc23DuM7uTdGmMIM2BorywLSHkabfd5IeffOwm48TwoEcHMks67mGNJhHCqYATbxtalSeu6eRZBxgIG8eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BEBA71063;
	Mon,  3 Mar 2025 14:24:55 -0800 (PST)
Received: from [10.57.76.116] (unknown [10.57.76.116])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 37C453F673;
	Mon,  3 Mar 2025 14:24:40 -0800 (PST)
Message-ID: <f18607ca-30dc-43de-be77-fec69968aeec@arm.com>
Date: Mon, 3 Mar 2025 22:24:36 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpuidle: psd: add power sleep demotion prevention for
 fast I/O devices
To: Colin Ian King <colin.king@intel.com>, Jens Axboe <axboe@kernel.dk>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, linux-block@vger.kernel.org,
 linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
References: <33882f284ac6e6d1ec766ca4bb2f3b88@intel.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <33882f284ac6e6d1ec766ca4bb2f3b88@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/3/25 16:43, Colin Ian King wrote:
> Modern processors can drop into deep sleep states relatively quickly
> to save power. However, coming out of deep sleep states takes a small
> amount of time and this is detrimental to performance for I/O devices
> such as fast PCIe NVME drives when servicing a completed I/O
> transactions.
> 
> Testing with fio with read/write RAID0 PCIe NVME devices on various
> modern SMP based systems (such as 96 thead Granite Rapids Xeon 6741P)
> has shown that on 85-90% of read/write transactions issued on a CPU
> are completed by the same CPU, so it makes some sense to prevent the
> CPU from dropping into a deep sleep state to help reduce I/O handling
> latency.

For the platform you tested on that may be true, but even if we constrain
ourselves to pci-nvme there's a variety of queue/irq mappings where
this doesn't hold I'm afraid.

> 
> This commit introduces a simple, lightweight and fast power sleep
> demotion mechanism that provides the block layer a way to inform the
> menu governor to prevent a CPU from going into a deep sleep when an
> I/O operation is requested. While it is true that some I/Os may not

s/requested/completed is the full truth, isn't it?

> be serviced on the same CPU that issued the I/O request and hence
> is not 100% perfect the mechanism does work well in the vast majority
> of I/O operations and there is very small overhead with the sleep
> demotion prevention.
> 
> Test results on a 96 thread Xeon 6741P with a 6 way RAID0 PCIe NVME md
> array using fio 3.35 performing random read and read-write test on a
> 512GB file with 8 concurrent I/O jobs. Tested with the NHM_C1_AUTO_DEMOTE
> bit set in MSR_PKG_CST_CONFIG_CONTROL set in the BIOS.
> 
> Test case: random reads, results based on geometic mean of results from
> 5 test runs:
>            Bandwidth         IO-ops   Latency   Bandwidth
>            read (bytes/sec)  per sec    (ns)    % Std.Deviation
> Baseline:  21365755610	     20377     390105   1.86%
> Patched:   25950107558       24748     322905   0.16%

What is the baseline?
Do you mind trying with Rafael's recently posted series?
Given the IOPS I'd expect good results from that alone already.
https://lore.kernel.org/lkml/1916668.tdWV9SEqCh@rjwysocki.net/

(Happy to see teo as comparison too, which you don't modify).

> 
> Read rate improvement of ~21%.
> 
> Test case: random read+writes, results based on geometic mean of results
> from 5 test runs:
> 
>            Bandwidth         IO-ops   Latency   Bandwidth
>            read (bytes/sec)  per sec    (ns)    % Std.Deviation
> Baseline:   9937848224        9477     550094   1.04%
> Patched:   10502592508       10016     509315   1.85%
> 
> Read rate improvement of ~5.7%
> 
>            Bandwidth         IO-ops   Latency   Bandwidth
>            write (bytes/sec) per sec    (ns)    % Std.Deviation
> Baseline:   9945197656        9484     288933   1.02%
> Patched:   10517268400       10030     287026   1.85%
> 
> Write rate improvement of ~5.7%
> 
> For kernel builds, where all CPUs are fully loaded no perfomance
> improvement or regressions were observed based on the results of
> 5 kernel build test runs.
> 
> By default, CPU power sleep demotion blocking is set to run
> for 3 ms on I/O requests, but this can be modified using the
> new sysfs interface:
> 
>   /sys/devices/system/cpu/cpuidle/psd_cpu_lat_timeout_ms

rounding up a jiffie sure is a heavy price to pay then.

> 
> setting this to zero will disabled the mechanism.
> 
> Signed-off-by: Colin Ian King <colin.king@intel.com>
> ---
>  block/blk-mq.c                   |   2 +
>  drivers/cpuidle/Kconfig          |  10 +++
>  drivers/cpuidle/Makefile         |   1 +
>  drivers/cpuidle/governors/menu.c |   4 +
>  drivers/cpuidle/psd.c            | 123 +++++++++++++++++++++++++++++++
>  include/linux/cpuidle_psd.h      |  32 ++++++++
>  6 files changed, 172 insertions(+)
>  create mode 100644 drivers/cpuidle/psd.c
>  create mode 100644 include/linux/cpuidle_psd.h
> 

