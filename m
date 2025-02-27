Return-Path: <linux-pm+bounces-23122-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 854E4A48641
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 18:09:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59D7416DD40
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 17:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0671DC9AB;
	Thu, 27 Feb 2025 17:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="qrJ9xGeR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422121A2C27;
	Thu, 27 Feb 2025 17:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740675666; cv=none; b=bUv0NKbjKneEKHDIiwkuD8TDXdg3PvQW2JMjn5dXGm2tYQ0nk2uoUNDQlPbVonRpLl/2AbUs9n6ASW6HyVufCaoa0OXskgX5PK3fPOQKl3y1aLhRxylss7LiYP6S7oW2aDziTMbe3xagEauZCszLlb15xG6+y/qgx5Pv7UkbEII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740675666; c=relaxed/simple;
	bh=9MBcuTrLdyeu9PVZqo4nvXGKB1LZxk1KfWB0wAf/1Bo=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=N6vPuZ2eCbOvBm1Zt01J2r4L7nohFEbKzVyPCYfW5Aqj+WSpaQQqRcI1ScB8VqJhFMVfWPIyngMOfAQdij06XJVVJqffmfH0SAPD38HDuuKYAuhj2PUPCs7CHf+bmYI8n5ItsLLsWRyme64wuyqzUZQhEAq40+e7GqxUE+uMaRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=qrJ9xGeR; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1740675661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t3GT2Q59z7jRgJeDRmMHoLHVswcssOZ7ZZ/HLhh5BeQ=;
	b=qrJ9xGeRk+ZoCCKaNXMPs6xQlPX39ci0CumbybmMrC6mVweHQH5PlKL2yj8BheOaIHOcB+
	+hzhs3pexdg3aZotFFKWOuVzAJxkvGnNkrBJCTebjkY75j0bkdK1V0Lu617yzD7ilnGPR7
	i0B4Wz8JrDWwn0UbWL2eipuZtE/JJNjPA3D+YyFFRPAdON/aM2VBiRDYUFZTb4ER8XcswK
	SxrOvHM9owPT8JX7pPnBznvCtOWsTC48wicoLtxgmd8kcQRUYFg3wocSb34Z4fZ9wovthg
	YXH+fP/2PHByu/Yxjffx8F/sGJW1fBQhdgHVJrRdUkhDQ87a8tMRawdv5G7Meg==
Date: Thu, 27 Feb 2025 18:01:00 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: rafael@kernel.org, daniel.lezcano@linaro.org,
 linux-rockchip@lists.infradead.org, rui.zhang@intel.com, heiko@sntech.de,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kever
 Yang <kever.yang@rock-chips.com>, Diederik de Haas <didi.debian@cknow.org>,
 linux-pm@vger.kernel.org
Subject: Re: [PATCH] thermal: rockchip: Extract TSADC conversion tables into a
 header file
In-Reply-To: <8fcb202f-d1b3-4989-9777-5bafd6fed59e@arm.com>
References: <08d2fc6e1972f1f90c900542bf66945d6dc6db63.1740577122.git.dsimic@manjaro.org>
 <8fcb202f-d1b3-4989-9777-5bafd6fed59e@arm.com>
Message-ID: <f13f480aae41e7d893bc6b285e3ad95c@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Lukasz,

On 2025-02-27 15:42, Lukasz Luba wrote:
> On 2/26/25 13:42, Dragan Simic wrote:
>> Move the TSADC code-to-temperature mapping tables from the Rockchip 
>> thermal
>> driver to a separate header file, to no longer have the somewhat 
>> cluttering
>> mapping data as part of the driver itself. [1]
>> 
>> These mapping tables come verbatim from the SoC technical reference 
>> manuals
>> (TRMs) and the downstream kernel code, [2] and may be updated at some 
>> point
>> in the future, according to the manufacturer test results, [3] so 
>> extracting
>> the tables into a separate header file not just improves the 
>> readability of
>> the driver code, but introduces a clear separation.
>> 
>> Improve the wording of the moved comment block, sprinkle a few short 
>> comments
>> over the newly introduced header file, and move the already existing 
>> single
>> stray #include directive in the driver code to its beginning.
>> 
>> [1] 
>> https://lore.kernel.org/linux-rockchip/7f17cc55-a741-4bb8-9513-0580ca6fedd3@linaro.org/T/#u
>> [2] 
>> https://raw.githubusercontent.com/rockchip-linux/kernel/f8b9431ee38ed561650be7092ab93f564598daa9/drivers/thermal/rockchip_thermal.c
>> [3] 
>> https://lore.kernel.org/linux-rockchip/b4ab86b56177a234f3738c477693e858@manjaro.org/T/#u
> 
> I think Daniel was more thinking something about saving the
> memory in the kernel. I see how this patch can help the readability
> of the driver code, but that doesn't help much to not occupy the kernel
> data. The driver will be built with that memory and the distro would
> run on some platform with particular chip. The other chips data won't
> be needed.

Thanks for your response!  Yes, carrying all that data in the kernel
memory, out of which only one variant actually gets used at runtime,
is far from optimal.

> Why not to have that information in the DT?
> That would save the memory and be configurable for only needed 
> platform.
> Please have a look into the generic thermal ADC driver and related
> DT entry, which is used e.g. here [1].
> That table looks similar to your info.

Let me have a detailed look into all that, please, and I'll come back
with some further thoughts.

> [1] 
> https://elixir.bootlin.com/linux/v6.13.4/source/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi#L136

