Return-Path: <linux-pm+bounces-38775-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 601C5C8DE3A
	for <lists+linux-pm@lfdr.de>; Thu, 27 Nov 2025 12:04:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03E623AE38B
	for <lists+linux-pm@lfdr.de>; Thu, 27 Nov 2025 11:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AD0D3218A6;
	Thu, 27 Nov 2025 11:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y7/YF6B6"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0245A27FD5B;
	Thu, 27 Nov 2025 11:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764241486; cv=none; b=WgfCVPHKzAnTquSPZ238xN0SZ+jQ3hSKIit8dI/TO2soNNega8Q9zcs44nPCoMrg67lgSFM8ba4ZDuFe/GBmy14cooXz3gR0evLHN7rPAUwUe1tozzsYPF45mQnTREMZk7wJVcRhFaraJsrR+hkFtCh5be87p4DFy78IT5RD4K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764241486; c=relaxed/simple;
	bh=ekonju7olEwIhnBxo7u/+axxWXW0xH1G0Euczdf9wDE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UqxFe80DlTmIgU/efgwLZVOgBJaLbyj+iymtLzHd62kpRqX4xFWZ05MbavTZhW9Q+Z0MUl4fBoKe30UELHJUrRD/izUhfMr76UGDx6bI9UAJvRwmfatly9zmXGzkja2KK7BcGzK+UiI8XFqBJSpFnFneVHRaugCz7MhuY+nFOOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y7/YF6B6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65F79C4CEF8;
	Thu, 27 Nov 2025 11:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764241485;
	bh=ekonju7olEwIhnBxo7u/+axxWXW0xH1G0Euczdf9wDE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Y7/YF6B6Uyzk8mMv2vd0Z9MVOgLGMW1C2VsutVuB9/X+CHy2+7CzSJmxGKkFRfeNO
	 nU7lstBLsMKtcmoFvPvxMhQPlrsD5LYn9Tb7AJTMgpowrGIzyqVgeYsrGw3mAEWESD
	 EAqlNwkOgDFK6WoWyGvk/Jx/GsIabIyhYY/3eBW14UXElYzEs5DUvJG7nQUdMdB4xx
	 ZX52AWoVmVBkL1k2UGGCfzv34dmA2mGvtJBn7Kf5Kl9tC3JzMsJAHNW45oYrxLFBGQ
	 wR6NU+0VCnqkgp2tBwxY7jX2B369wVO7JnLT+CM8TgopYLTtgaxfPVb5vxGV1qBPaP
	 iExGySzKtvSbQ==
Message-ID: <711d27d4-449f-43cf-8d5b-a8e7421e5540@kernel.org>
Date: Thu, 27 Nov 2025 12:04:42 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Linux 6.18-rc7
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Guenter Roeck <linux@roeck-us.net>, Sebastian Reichel <sre@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux PM <linux-pm@vger.kernel.org>
References: <CAHk-=wiFS7=wrjCoEguQUqwd=L4tJHNP8mCdagg0FR8NQTGLtw@mail.gmail.com>
 <0e90cb97-c0bc-48a9-92ec-2493e89ce6d5@roeck-us.net>
 <CAHk-=wj0coxhdnHMvhKAGfEy3AMgk+BX2n=Qvemt0Z=ZxsM8+A@mail.gmail.com>
 <d79d3d38-1fd3-4708-930c-621a4c28cce1@kernel.org>
 <CAHk-=wgmwZTxxT_hEbRR=-H0yT5uXtfr3t47Hw4B+Z_M4aGPAA@mail.gmail.com>
Content-Language: en-US, nl
From: Hans de Goede <hansg@kernel.org>
In-Reply-To: <CAHk-=wgmwZTxxT_hEbRR=-H0yT5uXtfr3t47Hw4B+Z_M4aGPAA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 26-Nov-25 10:14 PM, Linus Torvalds wrote:
> On Wed, 26 Nov 2025 at 12:45, Hans de Goede <hansg@kernel.org> wrote:
>>
>> Maybe you can cherry pick that patch?
> 
> My fix is different. It looks better to me, but is entirely untested:
> 
>     https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ad8cccc24887655ebf0a3f459d38d1fb683df46a
> 
> I did check that it at least builds on both i386 and x86-64, although
> only in limited configurations.

Your fix looks good to me, thanks.

Regards,

Hans



