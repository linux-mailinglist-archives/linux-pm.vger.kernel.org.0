Return-Path: <linux-pm+bounces-40035-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F53CE93A1
	for <lists+linux-pm@lfdr.de>; Tue, 30 Dec 2025 10:36:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A67C93012CF2
	for <lists+linux-pm@lfdr.de>; Tue, 30 Dec 2025 09:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E90288517;
	Tue, 30 Dec 2025 09:36:06 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0783224B1B;
	Tue, 30 Dec 2025 09:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767087366; cv=none; b=LP1KnUlV5Pd3I1cFGdZLdhN9KG6idERuJUgtJj3EW7s3180GwySgcSB4uQTmmA+2Z0DjUDC6Juzi4jCZleRc7ixoXCJImCoiJIJebIO1quefKFUkmJDYYOiy7fWbGtASf9Fi1EoMTk1zYDCub2G7GDi77ifC6GR2X+SUglHyu5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767087366; c=relaxed/simple;
	bh=PuQuJLAZxuEqtB+iiLnCbmFsuA1FAB3fWJEpP3b7AMQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=lXu/bCEhhtyEQlBkumGWuWvHbBDj/EdvLBlHQaHZt7Z7lEnQ3WB6bW2v10l9p8LWQGyGv4hnF20zJDrZ98uTL00eZDk06ac+rlXuiHb62acSW6R+oYACiIJuH/pUVrhEEMbcW0agD5ygzCu/2o+eH98aimS3CPQ1F/Wp8BGqEas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C0CF7497;
	Tue, 30 Dec 2025 01:35:54 -0800 (PST)
Received: from [10.57.10.231] (unknown [10.57.10.231])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9846C3F63F;
	Tue, 30 Dec 2025 01:36:00 -0800 (PST)
Message-ID: <d5ee5e5b-d636-47c7-83e6-b58cab9f4d6e@arm.com>
Date: Tue, 30 Dec 2025 09:35:49 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Lukasz Luba <lukasz.luba@arm.com>
Subject: Re: [PATCH 1/2] PM: EM: Fix incorrect description of the cost field
 in struct em_perf_state
To: Yaxiong Tian <tianyaxiong@kylinos.cn>
Cc: linux-pm@vger.kernel.org, lenb@kernel.org, linux-kernel@vger.kernel.org,
 pavel@kernel.org, rafael@kernel.org
References: <20251230061534.816894-1-tianyaxiong@kylinos.cn>
Content-Language: en-US
In-Reply-To: <20251230061534.816894-1-tianyaxiong@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/30/25 06:15, Yaxiong Tian wrote:
> Due to commit 1b600da51073 ("PM: EM: Optimize em_cpu_energy() and remove
> division"), the logic for energy consumption calculation has been modified.
> The actual calculation of cost is 10 * power * max_frequency / frequency
> instead of power * max_frequency / frequency.
> 
> Therefore, the comment for cost has been updated to reflect the correct
> content.
> 
> Signed-off-by: Yaxiong Tian <tianyaxiong@kylinos.cn>
> ---
>   include/linux/energy_model.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
> index 43aa6153dc57..e7497f804644 100644
> --- a/include/linux/energy_model.h
> +++ b/include/linux/energy_model.h
> @@ -18,7 +18,7 @@
>    * @power:	The power consumed at this level (by 1 CPU or by a registered
>    *		device). It can be a total power: static and dynamic.
>    * @cost:	The cost coefficient associated with this level, used during
> - *		energy calculation. Equal to: power * max_frequency / frequency
> + *		energy calculation. Equal to: 10 * power * max_frequency / frequency
>    * @flags:	see "em_perf_state flags" description below.
>    */
>   struct em_perf_state {

Good catch, thank you!

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

