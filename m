Return-Path: <linux-pm+bounces-22825-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B17D0A4280E
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2025 17:38:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 862CB3A25C2
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2025 16:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D80262D05;
	Mon, 24 Feb 2025 16:37:41 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351A7261570;
	Mon, 24 Feb 2025 16:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740415061; cv=none; b=njn3dlvk/0oTAOQRARgKBuIM10mjEVgLQFTeq7hIIIgupgJplhqt20wZGWH+HtUL6aRgWGPBhXBkIYsaWAtkF3puwgAOsUVd83kMY2yRDS9xGop1cTE+AtPezIlYoNlCheQLNHAdR7W83hDs96AmJYYmR6KCFaeab1IHYZhsUDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740415061; c=relaxed/simple;
	bh=0PtG8eXLtUyqjvaTmcAs9ZW3ZNaNeW/CVYKMDmAlBsI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WylrdAih4B53hyyQ1IOWHp5cL3g4mIu3oK51jQV5iOD8sc5UyDBCmX2XrCc/NKlfvNc0ZEBIaz/cJ49LxyZR4A2g0FFVhEiq5yVHZPiNt8JT5xSl4x2Bn3qKpkMv5047xDWvBw/f0C9K6l9aWwAA8XMKWz5lz4jWh5GmRsuyliM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9F1FA152B;
	Mon, 24 Feb 2025 08:37:54 -0800 (PST)
Received: from [10.57.65.109] (unknown [10.57.65.109])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4559D3F6A8;
	Mon, 24 Feb 2025 08:37:36 -0800 (PST)
Message-ID: <4fe7f680-2189-48b1-b115-abcf1b9084e7@arm.com>
Date: Mon, 24 Feb 2025 16:37:37 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal/debugfs: replace kzalloc() with kcalloc() in
 thermal_debug_tz_add()
To: Ethan Carter Edwards <ethan@ethancedwards.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Markus Elfring <Markus.Elfring@web.de>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20250222-thermal_kcalloc-v1-1-9f7a747fbed7@ethancedwards.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20250222-thermal_kcalloc-v1-1-9f7a747fbed7@ethancedwards.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/22/25 20:02, Ethan Carter Edwards wrote:
> We are trying to get rid of all multiplications from allocation
> functions to prevent integer overflows[1]. Here the multiplication is
> obviously safe, but using kcalloc() is more appropriate and improves
> readability. This patch has no effect on runtime behavior.
> 
> Link: https://github.com/KSPP/linux/issues/162 [1]
> Link: https://www.kernel.org/doc/html/next/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments
> 


IMO there is no need for such links in the patch header.
The explanation is enough. Just drop those two links
and should be good.

Thanks for the patch!

Regards,
Lukasz

