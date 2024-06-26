Return-Path: <linux-pm+bounces-10056-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5952491842F
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 16:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 877291C21D8B
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 14:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BDAF1862AA;
	Wed, 26 Jun 2024 14:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IBx8LZaN"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F80186295;
	Wed, 26 Jun 2024 14:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719412233; cv=none; b=LDDcYEAYZE2L6KV37+K1JMdqzjVgDCP9RInnU4KL8FK1gJP/euy0/Q2hWwBP0ckeYfDlDHL0NT5r7pinz+BJUziQhS+Tf2ikz6NblnYnkQ4DyMQzbg6knmIqFqogAR1Bu77DFLe6ojGmphUF0U/HXfchV29STBd5UmYLs3e/N6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719412233; c=relaxed/simple;
	bh=K5WCWCG8V47pPDg/ygPM4ZRiyfsSbygbFQeDkm7lcn8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qcSwnb+eMEr7DZyHXGlLj7riT2oIVZvh/1uTiyWGGi305rsmwgeodU+JueEV7l8TxFKsSTFKtsUrwUCgpSyOsfKgEGjt4jsqU4WYh057lMfFuRFH8O5fHPRSrt62qyXnrsE0EVzRQHyyYQY+HWu6YcJqfChrZCDXwPSnSPx1M94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IBx8LZaN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5155C116B1;
	Wed, 26 Jun 2024 14:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719412232;
	bh=K5WCWCG8V47pPDg/ygPM4ZRiyfsSbygbFQeDkm7lcn8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IBx8LZaNrreiIDRoAYmMyFCkC/QSvYT03FTy7GXHSNnbw+TcDOxJQqhiyPWwK03fv
	 DS1fegFC3oGDk4e+fCCv0YOKKLiHfARLNo5J+is6tBH4UzpauZv6BvWc8+QApGZRDG
	 URcPuV/HKJo70rgL36fvyHEWhI6Mi02yIv2kUh5c1dhJFBOsDkq9fNIoCJSDDVHyMI
	 940Ta0FK7McMkUU5MJ+SATK0JiT07oxFLY/dNWbpNzlbhJlKvpjPpVO6S2U1XvIn9R
	 MT1NepaxHA18ai0KRg+9VjAwX3I0HHorDGHp7rJeHiDa/qUJUzVSN17WCmsUB8CoLd
	 wET9cDw0f3bzQ==
Message-ID: <15b164aa-601f-4dad-8115-14a715608319@kernel.org>
Date: Wed, 26 Jun 2024 23:30:32 +0900
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] PM / devfreq: exynos: Use Use
 devm_clk_get_enabled() helpers
To: Anand Moon <linux.amoon@gmail.com>, Chanwoo Choi <cw00.choi@samsung.com>,
 MyungJoo Ham <myungjoo.ham@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240510094034.12493-1-linux.amoon@gmail.com>
 <CANAwSgTRfEChziyys251-FezSevSq9pxHLJixVCAybJhq5YAqw@mail.gmail.com>
From: Chanwoo Choi <chanwoo@kernel.org>
Content-Language: en-US
In-Reply-To: <CANAwSgTRfEChziyys251-FezSevSq9pxHLJixVCAybJhq5YAqw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

24. 6. 17. 17:24에 Anand Moon 이(가) 쓴 글:
> Hi All,
> 
> On Fri, 10 May 2024 at 15:10, Anand Moon <linux.amoon@gmail.com> wrote:
>>
>> The devm_clk_get_enabled() helpers:
>>     - call devm_clk_get()
>>     - call clk_prepare_enable() and register what is needed in order to
>>      call clk_disable_unprepare() when needed, as a managed resource.
>>
>> This simplifies the code and avoids the calls to clk_disable_unprepare().
>>
>> While at it, use dev_err_probe consistently, and use its return value
>> to return the error code.
>>
>> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> 
> Gentle ping?
> 
> Thanks
> -Anand
> 

Applied it. Thanks.
I'm sorry for late reply.

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi


