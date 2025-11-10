Return-Path: <linux-pm+bounces-37720-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B75B9C46657
	for <lists+linux-pm@lfdr.de>; Mon, 10 Nov 2025 12:54:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9473A4E3A04
	for <lists+linux-pm@lfdr.de>; Mon, 10 Nov 2025 11:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48019309EEC;
	Mon, 10 Nov 2025 11:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xp20MxYh"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FCCA2EB87F
	for <linux-pm@vger.kernel.org>; Mon, 10 Nov 2025 11:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762775672; cv=none; b=iE6dnKSXQJsobFro/EDJqIatuTHRJrBROgRSqQRrIeteAu6wWzsvtIHk0Y9uBU8IQVa0GJMmOMuHAZWlL5iIZQgmOlMyC7Z247TLPjdQQA1rlsQwDli2u1bwdWiqQPN/dkHpZY/d0uRNUh+/utX5iP1WOJy4ST+kMJnk8H/HAGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762775672; c=relaxed/simple;
	bh=m14UuhQAtTVkGBGRwXQgis+qG89w5J+jO0n0Pjk8p18=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ajr6y8s5yUqtKIb5n5UKv5OUSOaY/6YtMVus7hOzibUQO5uXUc+wbUfl7BswUorK2DtqhM9xt6KCk5IXhy1OzD1ELdw1ICejiYfZ0EyHEuC3niaAnlv6MLTxyTdQ56HaDklw04odBKvEIyPX2pBQAN4Z2g+6hJnZEV6j5rS7k3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xp20MxYh; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-42b3d7c1321so354757f8f.3
        for <linux-pm@vger.kernel.org>; Mon, 10 Nov 2025 03:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762775669; x=1763380469; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EMD9+URtcaUjSQn0X74/mQzArg3218Yo/nyvQktn/2A=;
        b=xp20MxYhf4/JtLImqEftv3pnj4AAIrYmDUNT2xh7nHegqxXXuMj/uhUKP4N/wvp+f6
         mVYd18RDVtuDRtrNbR0qgeOoqen/ZbkrBDzKcNND17EkqQaag406B0zbGsbVI0Tc/2QU
         zwKQIJgR1qfE0gfGFEbH+ZnisyGimfA7aY14c+LZVpdTrCXEQOS0UbmdsiuLftX3OgpW
         zCLgwNMVakguD3LPCh9NS5Q1V8SPobuQ1qd1B5Jph3/pR6wk6x/L5Ng49W77KoW91YKl
         Ro5E/X5yWhTeDV8ax4hSHweyeQSP0lHNSh2xT7JQZwWEGMOF/hJxZJg2UUh1yh4KhgFf
         H4EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762775669; x=1763380469;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EMD9+URtcaUjSQn0X74/mQzArg3218Yo/nyvQktn/2A=;
        b=H9icRy2LgtciDweWU2o2PTnrcTz7qY5OaI4wCIoeGKSdv64BHi/v5m4dQ9k4+ag6Dt
         wITOVw3ImYnlKAQ5bCNPQf7Zz4Tbyl/tMuTZRMhzt9a5OkO+FJ3RZqRutn5NS2kkIGYU
         r0dTS5HozoYRQFSRpG8IwHT4jQH7IFkKO87xDFt/3wZyl5VbJhMKRHUCBl03MzNVw5sA
         g5b3Nzmuc3XQFrFpVKhiGciJoGy5F2NDoncaB8BYvFh9QI0MdFEIRSk7Zr30swzGjHzA
         kMOoaj8eigP6MlwyozJY4dLB069j0827cdprGEgj9JFTfWUeSD2CTnhvt0bT6U+7msat
         QpnA==
X-Gm-Message-State: AOJu0YxI+emD2Oe3r2YO4tX4XtAGeBtaaaNCFGmXVnLBiKzLQnvrv+SB
	ZwCMdnbwx7KLMeuLMSycxm40au2p74LHRq+ilsPVKaFBuwNKGlSkWrXeL8aHxhOaqWo=
X-Gm-Gg: ASbGnctkm7rmwAH3a56nkD7TD86+3MZ/ujIniLuD4kIfW1n6J4GsWa/1kcU3SnPpVMH
	+asSRdLnw7y+D2xYe6JjBqsGIHOfE68kSIVpqrwJkGq4VLyDcGqPC7C1vHuBlEXjRJ961wBpLnr
	5l4O7wiymwBZ461YmqCRJtRLMqwFfL2bfbCYxdgMDnUqdc9msD4d3Z3hCAfXO159PJUp9HhcyOc
	10L4qRcDZCn2a0+Tz9J52hJNpaEvuKTcm/02OohULAi97HpytK9DeF8IMZGc2QUq2PFyxYYtjTi
	Dvt1IeOWM3+euRkrSTCcco+YMbJNHBr4fhmOtYvBk8gVdlSFVg7GMVsPoriPiZAgrswyhb+CQR3
	/qjzUrZ3u0Gy+4D1+2V8YyoQgYqgixlwGRshCUcL1K0pGmGQkflTCZc4wfZuDhFn1ykFO6YHlzD
	wJbB1XN1IRAc2S5DsAJBQSPj6gzDyyBabhBxsKMmZhtokrv/fpvBi5nqA6+Oie8+zxuUDSsQuD8
	6C3
X-Google-Smtp-Source: AGHT+IFt7FkGrjUGlQOSv30PcOTuYAg+G2jnyYcbkEOUdx4PafX6+NozVe5jVhG/6PDgSwaF9ZS0xA==
X-Received: by 2002:a05:6000:2dc6:b0:42b:3746:3b82 with SMTP id ffacd0b85a97d-42b3746406cmr3612494f8f.54.1762775668787;
        Mon, 10 Nov 2025 03:54:28 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:2b20:d700:6e9c:533c? ([2a05:6e02:1041:c10:2b20:d700:6e9c:533c])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-42b30dd4d86sm13217556f8f.26.2025.11.10.03.54.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 03:54:28 -0800 (PST)
Message-ID: <8f4e2705-6174-462d-9160-6723c28ea08a@linaro.org>
Date: Mon, 10 Nov 2025 12:54:27 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] thermal/drivers/rcar_gen3: Document R-Car Gen4 and
 RZ/G2 support in driver comment
To: Marek Vasut <marek.vasut@mailbox.org>,
 =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Lukasz Luba <lukasz.luba@arm.com>, Magnus Damm <magnus.damm@gmail.com>,
 Zhang Rui <rui.zhang@intel.com>, linux-renesas-soc@vger.kernel.org
References: <20251015155905.186612-1-marek.vasut+renesas@mailbox.org>
 <20251015173303.GA607688@ragnatech.se>
 <48f394d9-69d4-449b-8478-f2f24b230e94@mailbox.org>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <48f394d9-69d4-449b-8478-f2f24b230e94@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Hi Marek,

On 10/15/25 20:11, Marek Vasut wrote:
> On 10/15/25 7:33 PM, Niklas Söderlund wrote:
> 
> Hello Niklas,
> 
>>> - *  R-Car Gen3 THS thermal sensor driver
>>> + *  R-Car Gen3/Gen4 and RZ/G2 THS thermal sensor driver
>>
>> Super nit: I would write "Gen3, Gen4 and RZ/...". Compared to v1 you
>> updated the commit message not the comment here. Not a big deal all the
>> information is there.
> 
> Like this, right ? I will include that in V3, thanks:

Did you send the V3 ? Not sure if I missed it or if you had no time to 
send it yet


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

