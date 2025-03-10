Return-Path: <linux-pm+bounces-23749-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCDEEA590EF
	for <lists+linux-pm@lfdr.de>; Mon, 10 Mar 2025 11:20:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78BAB7A16AE
	for <lists+linux-pm@lfdr.de>; Mon, 10 Mar 2025 10:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8851225A59;
	Mon, 10 Mar 2025 10:19:55 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7045F21D5A0;
	Mon, 10 Mar 2025 10:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741601995; cv=none; b=W3q5fkanF1jg6maLzrGu8vRW5+yYKQmc4+Izp/qekEF081MI1U+QxsS7OGfTxzi4Tvfx36LjT+VhhT9sKb4OX7dtP5tAvWdp18jlumH2yYZeojjI2q5PKMPmxGRoZNop+R2rokD1wbS0BB5IaZNy4Hbr7ONCVj2VWd1zPY0+FM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741601995; c=relaxed/simple;
	bh=100GLxY3vbQfixL5KlFRnqxcfqt31VUMXg8446EaDyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C+gjCMQSY6G/yK9f5n22GQdhqC5epjgufLw0uC2U/80kWAcztXCpdVzr4B9z12Q0NWC/8MPpUfy3QggaTHvMymuZWtYShE7rPPwve59fevqqtyHBezEURg3/06E3f0MpAuWJFtNBsA6glPr/Ycef6h09+Sd15f2vIL5MIGi+ae8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5103C153B;
	Mon, 10 Mar 2025 03:20:05 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0A2573F673;
	Mon, 10 Mar 2025 03:19:50 -0700 (PDT)
Date: Mon, 10 Mar 2025 10:19:48 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Jacky Bai <ping.bai@nxp.com>
Cc: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <ilia.lin@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>, <tiny.windzz@gmail.com>,
	<wens@csie.org>, <jernej.skrabec@gmail.com>, <samuel@sholland.org>,
	<matthias.bgg@gmail.com>, <angelogioacchino.delregno@collabora.com>,
	<linux-pm@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-sunxi@lists.linux.dev>, <linux-mediatek@lists.infradead.org>,
	<imx@lists.linux.dev>
Subject: Re: [PATCH] cpufreq: Init cpufreq only for present CPUs
Message-ID: <Z868xB3_3NhMsa7R@bogus>
References: <20250310071640.3140435-1-ping.bai@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310071640.3140435-1-ping.bai@nxp.com>

On Mon, Mar 10, 2025 at 03:16:40PM +0800, Jacky Bai wrote:
> for_each_possible_cpu() is currently used to initialize cpufreq
> in below cpufreq drivers:
>   drivers/cpufreq/cpufreq-dt.c
>   drivers/cpufreq/mediatek-cpufreq-hw.c
>   drivers/cpufreq/mediatek-cpufreq.c
>   drivers/cpufreq/qcom-cpufreq-nvmem.c
>   drivers/cpufreq/sun50i-cpufreq-nvmem.c
>

Again how did you just narrow down to the list above ? Is that just a
random pick ? As I suggested with corresponding cpuidle changes, please
look into the details in side the for_each_possible_cpu() loop and then
decide if it applies or not.

For me, it applied to the below files as well at the least.

drivers/cpufreq/mvebu-cpufreq.c
drivers/cpufreq/qcom-cpufreq-hw.c
drivers/cpufreq/scmi-cpufreq.c
drivers/cpufreq/scpi-cpufreq.c
drivers/cpufreq/virtual-cpufreq.c

Please check everything thoroughly as I just looked at these briefly.

--
Regards,
Sudeep

