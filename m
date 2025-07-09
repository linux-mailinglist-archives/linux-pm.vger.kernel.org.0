Return-Path: <linux-pm+bounces-30490-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D770AFEE03
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jul 2025 17:48:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3D5E1C419B2
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jul 2025 15:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965A32E9720;
	Wed,  9 Jul 2025 15:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lfgKfkIS"
X-Original-To: linux-pm@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76FB2E92C6;
	Wed,  9 Jul 2025 15:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752076080; cv=none; b=GqrmjbMZR5sUIyKxPcglAJDEqp48DpakDKmeBkIpA6TRJLhBGBwIhwOxsiOpFk37MeVPEelHviJxo8kcMr88d2afPgff4bPPbICiEMTl3ZuU7pLvaogOJbEvw6F2mUZHi4ZRiqHFCo/P+0GDKay/jRkON7QKuQlRAlwnI9oK2EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752076080; c=relaxed/simple;
	bh=SOheTdsRFKozeT9Fp2mcGWDzaSdmePACoK8QhwFtSik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pyrrFscxZLEkc1QpFTSw0+0P+s3saQWABukVIndKiU9+qzG++Nlrc0yjxFhOQyObB9AfvD1d6sU7GVx7Yg8NxY4HJz/KTFVbcCqmUa043pGPRmb10bGIECon0yUkqE5pykvTuX8WUCMcyD8YTt3x3koTsCGpGGfSz7JWVBbdGOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lfgKfkIS; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=Ks2OjtLyTmyTH0uiJf+Wx9c4m1e3G4yvXwX2JOxKTn0=; b=lfgKfkISo1BG4DBxjL6yDIGKUN
	WNWbUSFg3ukA6KIC9DR7hg1cy2zM5iK8LW9f7DGpreu/u6Rz2PU7m6zoURZ7t8A/YFarYuoYfkzVA
	izANtTATbD5a5FaCp/jSl7pca5nBRRqH0sXLnaN30spveEcr1zFhnmidRxwrZNejWdoYFXcJm+qp5
	2NgVydLM5IVw9uWFI+y09MsYGXokEusbRqHBUIoIrqzTk6DEGbvQaEB2X1d8fBJTaw4z5yOgNnLux
	6nHNKYs5tnwu5NzUN5K8Vei6A7ZwhKZ5MLElhwNC1B2l214FoNH6/4lWOfq8cDrxLDhbj0JC7Ycyr
	1ofov0Zg==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZX1V-00000004fEx-3k3o;
	Wed, 09 Jul 2025 15:47:54 +0000
Message-ID: <47d5f907-f2a9-4a4a-91b3-0cf6ea997678@infradead.org>
Date: Wed, 9 Jul 2025 08:47:48 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] PM: add kernel parameter to disable asynchronous
 suspend/resume
To: Tudor Ambarus <tudor.ambarus@linaro.org>, Jonathan Corbet
 <corbet@lwn.net>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Pavel Machek <pavel@kernel.org>, Len Brown <len.brown@intel.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, peter.griffin@linaro.org,
 andre.draszik@linaro.org, willmcvicker@google.com, kernel-team@android.com
References: <20250709-pm-async-off-v3-1-cb69a6fc8d04@linaro.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250709-pm-async-off-v3-1-cb69a6fc8d04@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/9/25 5:31 AM, Tudor Ambarus wrote:
> On some platforms, device dependencies are not properly represented by
> device links, which can cause issues when asynchronous power management
> is enabled. While it is possible to disable this via sysfs, doing so
> at runtime can race with the first system suspend event.
> 
> This patch introduces a kernel command-line parameter, "pm_async", which
> can be set to "off" to globally disable asynchronous suspend and resume
> operations from early boot. It effectively provides a way to set the
> initial value of the existing pm_async sysfs knob at boot time. This
> offers a robust method to fall back to synchronous (sequential) operation,
> which can stabilize platforms with problematic dependencies and also
> serve as a useful debugging tool.
> 
> The default behavior remains unchanged (asynchronous enabled). To disable
> it, boot the kernel with the "pm_async=off" parameter.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---
> Dealing with the pixel6 downstream drivers to cope with the changes from
> https://lore.kernel.org/linux-pm/10629535.nUPlyArG6x@rjwysocki.net/.
> 
> Similar to what people already reported it seems pixel6 lacks proper
> device links dependencies downstream causing i2c and spi client drivers
> to fail to suspend. Add kernel param to disable async suspend/resume.
> ---
> Changes in v3:
> - update documentation with "pm_async=" and "Format: off" (Randy)
> - reword documentation to make it clear "on" isn't a selectable option
>   for pm_async because it's the default behavior.
> - Link to v2: https://lore.kernel.org/r/20250708-pm-async-off-v2-1-7fada54f01c0@linaro.org
> 
> Changes in v2:
> - update the documentation and the commit message to describe that the
>   "pm_async" kernel parameter provides a way to change the initial value
>   of the existing /sys/power/pm_async sysfs knob.
> - Link to v1: https://lore.kernel.org/r/20250708-pm-async-off-v1-1-1b200cc03d9c@linaro.org
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 12 ++++++++++++
>  kernel/power/main.c                             |  9 +++++++++
>  2 files changed, 21 insertions(+)
> 

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.
-- 
~Randy

