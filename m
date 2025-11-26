Return-Path: <linux-pm+bounces-38749-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 012EEC8BE61
	for <lists+linux-pm@lfdr.de>; Wed, 26 Nov 2025 21:45:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A03FD35759C
	for <lists+linux-pm@lfdr.de>; Wed, 26 Nov 2025 20:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F261A318135;
	Wed, 26 Nov 2025 20:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MOTM7BF5"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C316D21D3D2;
	Wed, 26 Nov 2025 20:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764189919; cv=none; b=i4i6DsHl4hJCr+8kVriZKD8IVkNCfv1kqdsTLMJj7va0I08BOMc7isugmvJ1+yrIQLc01qPIsB8cjxN/D/T0gF4Ot6sXfmX2TgByThp9X2e9dFbxc3liSV6ubOkMZMC5PIGCpkU1no0e/UqM4x0CgyVP+7xHEBh3cGX1jGWSQ+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764189919; c=relaxed/simple;
	bh=5OVZJfDAVvaPD5jqQXdxh51eTa4NVZE0z+7tHJ/JBcQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rTXO6pbTZ84yW/xCFHPHUPkKqfF8QIQ6N+j5W7LDjrTahlhpcZUUCSn0c23GLje0/E4xQ/QvAoFfOImi3w0GZVTbQ6VE0m7gmNNav/jwGjrmIxSLAx5Ejxv1GiwWP9TdyQ0cPJXwpItayrHe94cpbJwNdcI5hx9aSEnoMCsSOYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MOTM7BF5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42A9EC4CEF7;
	Wed, 26 Nov 2025 20:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764189919;
	bh=5OVZJfDAVvaPD5jqQXdxh51eTa4NVZE0z+7tHJ/JBcQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MOTM7BF5Dlb5mJgBqElC1sjPRuMSuzGG915icjJkVymXubHEhQU5IFADNSTorI7zX
	 rH1SfYWfoC9USG0eV2aAPy7t+B3MkjxUK7BsVI2pVPQmaqwryyytVNrwrzPxZa1JAT
	 tV5R3IruKjk+sTl2Kvh1Q5zHAkl+1S6FXpvRM9lnFnh2mb5GuIH9QnsSbKakBln8rr
	 80r6Pmz82lr9lSMk63NjZdICfU0yitWEshCmwPH3YXdmrMjKKbnkl1espq3Zksjs29
	 /85NvLgwf9UlhDSqpHxsg/b2lfGBCTqBMv6YORiMUOJ9D4KtvKpf2K1006PrXg8dMQ
	 jCPw7xFNZSGfw==
Message-ID: <d79d3d38-1fd3-4708-930c-621a4c28cce1@kernel.org>
Date: Wed, 26 Nov 2025 21:45:16 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Linux 6.18-rc7
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Guenter Roeck <linux@roeck-us.net>, Sebastian Reichel <sre@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux PM <linux-pm@vger.kernel.org>
References: <CAHk-=wiFS7=wrjCoEguQUqwd=L4tJHNP8mCdagg0FR8NQTGLtw@mail.gmail.com>
 <0e90cb97-c0bc-48a9-92ec-2493e89ce6d5@roeck-us.net>
 <CAHk-=wj0coxhdnHMvhKAGfEy3AMgk+BX2n=Qvemt0Z=ZxsM8+A@mail.gmail.com>
From: Hans de Goede <hansg@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <CAHk-=wj0coxhdnHMvhKAGfEy3AMgk+BX2n=Qvemt0Z=ZxsM8+A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 26-Nov-25 9:37 PM, Linus Torvalds wrote:
> On Tue, 25 Nov 2025 at 15:49, Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> i386:allyesconfig still suffers from
>>
>> Building i386:allyesconfig ... failed
> 
> Bah. I'll give up on waiting for proper channels, and am just fixing
> this myself.

Note there is a perfectly fine and reviewed fix for this sitting
in the linux-power-supply/next tree, unfortunately this never
got send to you this cycle:

https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git/commit/?h=for-next&id=3fd1695f5da0538ef72e1268baa00528b589347a

Maybe you can cherry pick that patch?

Regards,

Hans



