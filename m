Return-Path: <linux-pm+bounces-20900-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C49CA1AC0E
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2025 22:45:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 170BA3A7582
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2025 21:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FDE21C3F34;
	Thu, 23 Jan 2025 21:45:57 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3B671B21AD;
	Thu, 23 Jan 2025 21:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737668757; cv=none; b=npv8fczEFc2K3vohOssqjpfyONbPsM5LS9ldSaejN3A9P4WJMAMchlRFdtsMS3on1qWjv0tZepWTsuinfn8RzeRKq6ihrt+a8XPT5HnW8U5XA6HvsR2SqYfqYsc/CPY4vDgGGSlZ6J//7eDqiyD0/L+ippX6nICoOR0SN9EUVwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737668757; c=relaxed/simple;
	bh=+VmVPz29tFeLCPrHEmzx7B3FsPgm8Wr9KQehrvv6Ss4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ku2n7biEcgnRGQTCL9UzZZsUIm8f1uTFV1TmOLh/2LSZCx+6r1FxQzqa6KNVt0XuRXhN4XprfjHA9imhrrGir6hh9Ah2OlgaPPZaYaWyfBugj6vzvSzglatIaZk4wDn/ZuK1FPc+LtYsRr0rqjX/V3VZpfcERNIwyh3EeV41EfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 49BD41063;
	Thu, 23 Jan 2025 13:46:23 -0800 (PST)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BD5163F66E;
	Thu, 23 Jan 2025 13:45:51 -0800 (PST)
Date: Thu, 23 Jan 2025 22:45:12 +0100
From: Beata Michalska <beata.michalska@arm.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org, ionela.voinescu@arm.com,
	sudeep.holla@arm.com, will@kernel.org, catalin.marinas@arm.com,
	rafael@kernel.org, sumitg@nvidia.com, yang@os.amperecomputing.com,
	vanshikonda@os.amperecomputing.com, lihuisong@huawei.com,
	zhanjie9@hisilicon.com
Subject: Re: [PATCH v9 1/5] cpufreq: Allow arch_freq_get_on_cpu to return an
 error
Message-ID: <Z5K4aDaZIbhRCbOP@arm.com>
References: <20250121084435.2839280-1-beata.michalska@arm.com>
 <20250121084435.2839280-2-beata.michalska@arm.com>
 <20250121104706.2gcegucb6hcuksrd@vireshk-i7>
 <Z4-52JUmR7A-7NJP@arm.com>
 <20250122061250.kxdpkkvce4g5nar2@vireshk-i7>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250122061250.kxdpkkvce4g5nar2@vireshk-i7>

On Wed, Jan 22, 2025 at 11:42:50AM +0530, Viresh Kumar wrote:
> On 21-01-25, 16:14, Beata Michalska wrote:
> > Theoretically speaking - it should, though what would 0 actually
> > represent then ?
> 
> 0 won't be a failure, that's clear, since errors are represented
> differently now. I am not sure what 0 frequency would mean and it can
> be left as an architecture specific value, which is a corner case I am
> not sure will ever occur.
That would mean we are opting for presenting '0' value (whatever that means)
instead of trying alternative ways of getting 'current' frequency ?
This is still the scaling_cur_freq.

---
BR
Beata
> 
> -- 
> viresh

