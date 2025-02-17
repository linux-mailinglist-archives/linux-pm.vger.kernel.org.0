Return-Path: <linux-pm+bounces-22263-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B814A38E09
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 22:32:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4ABCF188EBEF
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 21:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B13CE1A5BBC;
	Mon, 17 Feb 2025 21:32:13 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC631A3BD8;
	Mon, 17 Feb 2025 21:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739827933; cv=none; b=IawZGRfCl6pF/lLEhXZHVyu3NG390qGF+1km7hKGGMQw5HzSph6L1NDy5joZ9vntgIWGTZ7uG/Y/xbhfKQjilryiaEDoqSVlA7rUi53S3G0/8GhdSn/MCSZ/rj3t8kuU9jVftzdylBehZOCuIztvuHZ+hB+HEJaAO5GcXP0PIVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739827933; c=relaxed/simple;
	bh=EDHIzeefqwYVg8Oi79jPCHdArng8mIR7FnuBUpEPGiM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Leyp47vmzjrQHimCXw1eWhGov9jDz4f/JSazgtYsjIEWbgVnRIP//LZnloOs8YDkq8rJ9pNSYqai3ERuXNOc08Lbz6KnVYjQ+4kj9Uca0UztXtJwXuGqBdJi1gwmowgf42qQfLJ0/b7FmUePwP5UdqJQRwz2daCxhFFEWIP9Ing=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3BC0C4CED1;
	Mon, 17 Feb 2025 21:32:08 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org,
	ionela.voinescu@arm.com,
	sudeep.holla@arm.com,
	will@kernel.org,
	rafael@kernel.org,
	viresh.kumar@linaro.org,
	Beata Michalska <beata.michalska@arm.com>
Cc: sumitg@nvidia.com,
	yang@os.amperecomputing.com,
	vanshikonda@os.amperecomputing.com,
	lihuisong@huawei.com,
	zhanjie9@hisilicon.com,
	ptsm@linux.microsoft.com,
	Jonathan Corbet <corbet@lwn.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Phil Auld <pauld@redhat.com>,
	x86@kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v10 0/4] Add support for AArch64 AMUv1-based average freq
Date: Mon, 17 Feb 2025 21:32:06 +0000
Message-Id: <173982791748.4020779.2848639862581042284.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250131162439.3843071-1-beata.michalska@arm.com>
References: <20250131162439.3843071-1-beata.michalska@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 31 Jan 2025 16:24:35 +0000, Beata Michalska wrote:
> This series adds support for obtaining an average CPU frequency based on
> a hardware provided feedback. The average frequency is being exposed via
> dedicated yet optional cpufreq sysfs attribute - cpuinfo_avg_freq.
> The architecture specific bits are being provided for AArch64, caching on
> existing implementation for FIE and AMUv1 support: the frequency scale
> factor, updated on each sched tick, serving as a base for retrieving
> the frequency for a given CPU, representing an average frequency
> reported between the ticks.
> 
> [...]

Applied to arm64 (for-next/amuv1-avg-freq), thanks!

[1/4] cpufreq: Allow arch_freq_get_on_cpu to return an error
      https://git.kernel.org/arm64/c/38e480d4fcac
[2/4] cpufreq: Introduce an optional cpuinfo_avg_freq sysfs entry
      https://git.kernel.org/arm64/c/fbb4a4759b54
[3/4] arm64: Provide an AMU-based version of arch_freq_get_on_cpu
      https://git.kernel.org/arm64/c/dd871ac1237f
[4/4] arm64: Update AMU-based freq scale factor on entering idle
      https://git.kernel.org/arm64/c/96b335620c59

-- 
Catalin


