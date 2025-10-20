Return-Path: <linux-pm+bounces-36484-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 226F6BF2922
	for <lists+linux-pm@lfdr.de>; Mon, 20 Oct 2025 18:59:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F398E4F4788
	for <lists+linux-pm@lfdr.de>; Mon, 20 Oct 2025 16:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B77F92638BF;
	Mon, 20 Oct 2025 16:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="UPpU2Koj"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B7C32F75C
	for <linux-pm@vger.kernel.org>; Mon, 20 Oct 2025 16:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760979545; cv=none; b=idPCchh+KDDGYeaqsanEcrs2wMxu2eCoTwRHR9pA0p9e5rjW+3ynu1n8eOtvYPimnRKv+e92fT04T++gF8oTqQTA264lSsxOdKvTGfNZpJSJgjdIZ2wie56PukzeKsSSYwuFV5HCS3lwd9P5KwMXn9DvR6TUSMwwN/5ZJwplh/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760979545; c=relaxed/simple;
	bh=W5/9cUzx8mFHXlSOOHPt6EnGaX6UaZbSSHaXNYekbmY=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=i78aNNu1VjsPtBSX8XBkH264WJl1SDEKr+tQYRcyu079+bP2Sl3XQf5sXGInuOFPzqufyhXAqmBQy9iaq/GY30eZgcgjAjYMPSvAx6p7O0k2qqsOhYb0tUBUgljjLMhmMU1SVTJnFtHOWwpha/r7GfAXIXP7947f5ezPxs61tAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=UPpU2Koj; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1760979541;
	bh=W5/9cUzx8mFHXlSOOHPt6EnGaX6UaZbSSHaXNYekbmY=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=UPpU2KojtgdPswvKeqbXUJWEA8dZPbeKenypejVEvLXGY1j71w2XRF7PyflnAiqMG
	 PwssshWeSmAHUUhSLhC4wTOfmWpUfALFnsRNne3N90gQrPf0YVkq5n2H+/MJNj0yhL
	 dLzN9Mq37uAnW20xhCQvmJeH8MVUHPQQmZbOlOFi+cRksBvL73JqC+KNPQSO6oNvsC
	 8tStCFgnXvpvCCMZnMLBiP1KNrEyq7LhjsNjr1rP8Me8qlP3SLASx1YD6IvDVchF7C
	 NslDB18KiMXZPmnR6IwtcZhTZhR23o3NANvg2dcCZw5DlLqOc5nQ8nkNX19uFO++N3
	 /xTPmDIRRkOAg==
Received: from [192.168.200.105] (unknown [182.181.201.194])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id CD9A917E1278;
	Mon, 20 Oct 2025 18:58:55 +0200 (CEST)
Message-ID: <c93821d6-2e59-481a-8119-1c00a3fdcd5e@collabora.com>
Date: Mon, 20 Oct 2025 21:58:51 +0500
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: usama.anjum@collabora.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-pm@vger.kernel.org
Subject: Re: [RFC 1/3] PM: Mark device as suspended if it failed to resume
To: "Mario Limonciello (AMD)" <superm1@kernel.org>,
 mario.limonciello@amd.com, airlied@gmail.com, alexander.deucher@amd.com,
 christian.koenig@amd.com, dakr@kernel.org, gregkh@linuxfoundation.org,
 lenb@kernel.org, pavel@kernel.org, rafael@kernel.org, simona@ffwll.ch
References: <20251020165317.3992933-1-superm1@kernel.org>
 <20251020165317.3992933-2-superm1@kernel.org>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20251020165317.3992933-2-superm1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/20/25 9:50 PM, Mario Limonciello (AMD) wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> If a device failed to resume the PM core treats it as though it
> succeeded.  This could cause state machine problems.
> 
> Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>
> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
Tested-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

> ---
>  drivers/base/power/main.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index e83503bdc1fdb..bf9c3d79c455f 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -1104,6 +1104,9 @@ static void device_resume(struct device *dev, pm_message_t state, bool async)
>  	device_unlock(dev);
>  	dpm_watchdog_clear(&wd);
>  
> +	if (error)
> +		dev->power.is_suspended = true;
> +
>   Complete:
>  	complete_all(&dev->power.completion);
>  


-- 
---
Thanks,
Usama

