Return-Path: <linux-pm+bounces-25611-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A761A915A5
	for <lists+linux-pm@lfdr.de>; Thu, 17 Apr 2025 09:48:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04C8419E1447
	for <lists+linux-pm@lfdr.de>; Thu, 17 Apr 2025 07:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B68A821ABCC;
	Thu, 17 Apr 2025 07:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="bvJrstqz"
X-Original-To: linux-pm@vger.kernel.org
Received: from out203-205-221-210.mail.qq.com (out203-205-221-210.mail.qq.com [203.205.221.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574D01DE3BA;
	Thu, 17 Apr 2025 07:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744876102; cv=none; b=fKJOCiKNZfuAZPsL71r+6jnUecfgjaZvxRnbf/43zdAO7pob4uIBnq4C7zt0eIkzAkgZv4ZvHtItjQx26vFp0WcjJ+aajJlSFXZKoFCsH+9Gbg9a9wKOrRfga9AFMGmAymLJbMqcnNECWPEcB6W5t4aQFdNUSbyEt7kX27OVeLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744876102; c=relaxed/simple;
	bh=g69U3MXxWXrTcJzezoDF5hQtVmdFyUMPr2vui6AhBd8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ona6zFl/TL55hSSS90gg13onWzhAP3c3GW72EsKUM5jhFfC7ZeR90VV8khQy9zq+yzZ0IpacidDC9MAMXxtT29ccaTrMsaeljuBGL/QSWsNbu7Ia+njtB+b3mlA5LyzLxNNMayfuocHOdNHxPF8kv5MLkYZ0t+zj++9Vrx3gfE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=bvJrstqz; arc=none smtp.client-ip=203.205.221.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1744876088; bh=jtLqqxgkkS7hjzhrNQSkLpeFrvyKORWwVkpEiRFM2y8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=bvJrstqzWSBhPkVWeMYuT4HIziUbUr2BmpzDrBQUj9Aj+f6SdLWVxoUWR/PA7X7E/
	 XaF3W1MVMkWlEOwAt1sYQiXWyQqe+vD9rXwHI7L92zGR6FIOYqeHiGkhd/c/PPfPrn
	 /SawPI1AAUjKf5cOPHXoG+dyDSMW9pCf4JHBEdW0=
Received: from [10.42.13.21] ([116.128.244.169])
	by newxmesmtplogicsvrsza29-0.qq.com (NewEsmtp) with SMTP
	id A7A83A38; Thu, 17 Apr 2025 15:41:58 +0800
X-QQ-mid: xmsmtpt1744875718tyr8k8gfy
Message-ID: <tencent_7F0AB62F9DA4BF9F250063A7421F23AC3908@qq.com>
X-QQ-XMAILINFO: Ntt/5q+SsafOsnPnwUxg9cH2jNPvQoJzy31D/qLKszyBC1og0zhcJchIQtlALw
	 yhx15RO9RGMw20WtvpxUWUQo20XfMgAfPdLgw+wKOYbTvty1D9A3BPY5mDdcZXA8kGUlQ6MeoRQz
	 /ZJC81lKrRE2ViL5gjYfMb/V8y5poj4OG6byl/wOFmwWyiRah8joVvZF5bQjJ3J3DRbIYtmG2Kiv
	 2qRyNkjpH6fN6uv9TuCakoF7A1yolmQ0z6hhsHEWNPDp/R/VxQp2GkLFA9q7VIx0P0XbQG7E/Ekj
	 OvY/BSzVoOelpQJ/tZHl5TAmOaN5mH2/l/xZQhvA4bxlIPtqWhJ5lUZzOTBG23CH6XU28+RtGodS
	 0jMRKlUefrQD4Z6MCcB1yA247Rn8egl9Un4AzfRIAyZ8DHUE56yF4Lxhcyvmv8gp6lZP7E9x7Ixt
	 bObvD8JGkmjRr8nWbVgnFMUkVWgQHJBEiPF4IA+z5csJGd7KrUHPWtpqXLtonmRMd+H6e6dmNERX
	 vbsNV74B+BAT8pOsMs9wqmTotDoBPjzV3WjjykVFFcL3Z8cBO1M2M/4Jm+kMl6tKuGEU02Vjsc5K
	 R8lBwCeXRgYRTgOwH0YlP3a815PNuFzmc3O6AKENw6nJULxm1G2T0J6yPjDLia5ZIqhMA7WouB3c
	 yM7yCLhagWCeicBWMhWdwnThoKWfJVCXttrr577B2vvHWrJgmDN13AtxiC4YwsjiRdZ78aNPTiT9
	 TsWsu3TAvz8q1QkKBlEpZTowIQYUNJe8bXSnJ6YcbaljQYTpMUtxhQzseIp3WKLni4gMZDmeMdqG
	 MAo/xIaxinbMgSKdL9BcyzDcKOUW5BmpPUELmQcBo0HRxZOAIvMmH7TmVmSdrSvbTVEMiKSuiDPC
	 X4+PF7yY9M3CV50P9eCCZ9HPb0TbvyeHZxu+mFLPa4WeITYu/BSs3caw0yjgrLAA7RZ4+yGlTlU7
	 7a8FCGy9crh+Aeg6wyA5aT8wGTtgfgTvFgLOCBRKxwzGnYQf4HoEDqvF7ZJgXnEDvCPXj3zPYUvM
	 d4azrXsp5PxJmD9HPDKx5CEXsYHzU=
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-OQ-MSGID: <e7ecc530-af6e-4ac5-92ea-b3976aa0f13d@qq.com>
Date: Thu, 17 Apr 2025 15:41:58 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PM: EM: Fix potential division-by-zero error in
 em_compute_costs()
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yaxiong Tian <tianyaxiong@kylinos.cn>,
 rafael@kernel.org, Konstantin Ryabitsev <konstantin@linuxfoundation.org>
References: <tencent_EE27C7D1D6BDB3EE57A2C467CC59A866C405@qq.com>
 <143378b0-5740-4f2b-9a79-f04cf9ef1f77@arm.com>
 <tencent_C16C813B177E434BEAC73E842C46D872BC09@qq.com>
 <CAMuHMdVAvMuzmn48aVB-xshMjbENXFc1MmYB=r7iPrMvfDZjDg@mail.gmail.com>
Content-Language: en-US
From: Yaxiong Tian <iambestgod@qq.com>
In-Reply-To: <CAMuHMdVAvMuzmn48aVB-xshMjbENXFc1MmYB=r7iPrMvfDZjDg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/4/17 15:20, Geert Uytterhoeven 写道:
> Hi Yaxiong,
> 
> On Mon, 14 Apr 2025 at 11:14, Yaxiong Tian <iambestgod@qq.com> wrote:
>> I wasn’t sure whether the new patch should reuse the current Message-ID
>> or create a new one, so I checked with ChatGPT and kept the original
>> Message-ID for v2. If a new Message-ID is required, I can resend the
>> email.
> 
> Different (revisions of) patches must have different Message-IDs,
> else they can no longer be distinguished by our tooling.
> Fortunately it seems like you didn't succeed (which is good ;-),
> as all four revisions do have different Message-IDs:
> 
> https://lore.kernel.org/all/tencent_8478BF8F2549630842D323E7394CB6F49D08@qq.com/
> https://lore.kernel.org/all/tencent_EE27C7D1D6BDB3EE57A2C467CC59A866C405@qq.com/
> https://lore.kernel.org/all/tencent_6D2374392DB66C9D23BF6E2546638A42EC08@qq.com/
> https://lore.kernel.org/all/tencent_2256A7C02F7849F1D89390E488704E826D06@qq.com/
> 
> Gr{oetje,eeting}s,
> 
>                          Geert
> 
Thank you for your explanation. My previous description might have been
a bit unclear. Actually, what I meant was whether it should be --in-
reply-to=original Message-ID. I think if it's a patch, replying to the
  original Message-ID would be better.


