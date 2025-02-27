Return-Path: <linux-pm+bounces-23080-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 098C8A481E1
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 15:47:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9326C3B0219
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 14:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA2C23957C;
	Thu, 27 Feb 2025 14:42:47 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E223239095;
	Thu, 27 Feb 2025 14:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740667367; cv=none; b=JxhZ0oZegQyD0GuyEl/pJQ3YR2lL+7EhjkuPe67kWKmmjuLX4isWBJmalygDTUUbY1J6V0dxwAgVmW6xMYCR9jKGNfeIxVqIkmOlo+8nY/waHMckkEZxuAqv8XVhc1Tqml1eWYKkRi/o6BB1AP9qp/FHL4N/t+E3SmqPSnYJ96w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740667367; c=relaxed/simple;
	bh=4bCEWjUpANniqInLJ6xunO0frs/gu1vAUozAUMry0mo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ANKwv/PfVoDDvWaPh4vcJeMdZWgwfuVfEjXD1xMJN3Fx21kWEe/66IiB4Z9zKOz/yitnRJzbZq9WG+kXh99rFgBMP7nSI0J3hFpUPge/6fuVWrX6VW2WgJGt8gqg21CNYtrhTtxSxE7RVJFnYmJ33RYUfcegCJm3pQ3xJQN+rbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ED50A2BCA;
	Thu, 27 Feb 2025 06:43:00 -0800 (PST)
Received: from [10.57.78.204] (unknown [10.57.78.204])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A5E423F673;
	Thu, 27 Feb 2025 06:42:43 -0800 (PST)
Message-ID: <8fcb202f-d1b3-4989-9777-5bafd6fed59e@arm.com>
Date: Thu, 27 Feb 2025 14:42:46 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal: rockchip: Extract TSADC conversion tables into a
 header file
To: Dragan Simic <dsimic@manjaro.org>
Cc: rafael@kernel.org, daniel.lezcano@linaro.org,
 linux-rockchip@lists.infradead.org, rui.zhang@intel.com, heiko@sntech.de,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Kever Yang <kever.yang@rock-chips.com>,
 Diederik de Haas <didi.debian@cknow.org>, linux-pm@vger.kernel.org
References: <08d2fc6e1972f1f90c900542bf66945d6dc6db63.1740577122.git.dsimic@manjaro.org>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <08d2fc6e1972f1f90c900542bf66945d6dc6db63.1740577122.git.dsimic@manjaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Dragan,

On 2/26/25 13:42, Dragan Simic wrote:
> Move the TSADC code-to-temperature mapping tables from the Rockchip thermal
> driver to a separate header file, to no longer have the somewhat cluttering
> mapping data as part of the driver itself. [1]
> 
> These mapping tables come verbatim from the SoC technical reference manuals
> (TRMs) and the downstream kernel code, [2] and may be updated at some point
> in the future, according to the manufacturer test results, [3] so extracting
> the tables into a separate header file not just improves the readability of
> the driver code, but introduces a clear separation.
> 
> Improve the wording of the moved comment block, sprinkle a few short comments
> over the newly introduced header file, and move the already existing single
> stray #include directive in the driver code to its beginning.
> 
> [1] https://lore.kernel.org/linux-rockchip/7f17cc55-a741-4bb8-9513-0580ca6fedd3@linaro.org/T/#u
> [2] https://raw.githubusercontent.com/rockchip-linux/kernel/f8b9431ee38ed561650be7092ab93f564598daa9/drivers/thermal/rockchip_thermal.c
> [3] https://lore.kernel.org/linux-rockchip/b4ab86b56177a234f3738c477693e858@manjaro.org/T/#u
> 

I think Daniel was more thinking something about saving the
memory in the kernel. I see how this patch can help the readability
of the driver code, but that doesn't help much to not occupy the kernel
data. The driver will be built with that memory and the distro would
run on some platform with particular chip. The other chips data won't
be needed.

Why not to have that information in the DT?
That would save the memory and be configurable for only needed platform.
Please have a look into the generic thermal ADC driver and related
DT entry, which is used e.g. here [1].
That table looks similar to your info.

Regards,
Lukasz


[1] 
https://elixir.bootlin.com/linux/v6.13.4/source/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi#L136

