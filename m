Return-Path: <linux-pm+bounces-6798-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE8C18ACBF2
	for <lists+linux-pm@lfdr.de>; Mon, 22 Apr 2024 13:22:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB78C285F3D
	for <lists+linux-pm@lfdr.de>; Mon, 22 Apr 2024 11:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F92414658C;
	Mon, 22 Apr 2024 11:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QpL+rkRy"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC24145FE9
	for <linux-pm@vger.kernel.org>; Mon, 22 Apr 2024 11:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713784944; cv=none; b=a/7cXpqY/V4c9kdPjgE8vRlnOKqNEdGNCOTANb88Qoh1cazDmeAcS6ySsO0Om1210GCMYLvxLCNzd+SbvL1j4P78U6JMRGdzEyViAALrLC7IVUT9TUwJHZLBhIcv1dSfx4Qrg+oGlG+FX+3MaBujxifwjQhQ415zdOHXcwqhDFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713784944; c=relaxed/simple;
	bh=ZWYE1QjPK4DfJdpl3qs9Bik5fZDJcYLXEIcmrPF3gvs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nnAhesKZMP+jymUDdXFxLldy7s6NM7jOh7vtrKkdHkrGKjCP73Tcbi6h29hFUPfzm/UJtivyQkY8YgES0f0zlmARsUaHOCj83rrnPW8MAnT/FT7pcDi6o06KxuV3o1cvpQNLQp024Bkb/61UzeKH5Jpq4aoY1bPgASpFZX44qwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QpL+rkRy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0408C113CC;
	Mon, 22 Apr 2024 11:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713784943;
	bh=ZWYE1QjPK4DfJdpl3qs9Bik5fZDJcYLXEIcmrPF3gvs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QpL+rkRyOU6Hoo/L/aSrYelrs6uQeFAewWE0VHCm8ReC/VP1stAj5lusV1ihj1PAa
	 qVI9o9wAmWp371aatuLmwBuuR5AeipB/nNm+TmklI4SufuPX3KdYplgR2IvWT2XpQ4
	 QILI4KQ8QZUd5Z1Xr/VbyUihxC4KFiHEydWr1ToLDxoe/uyxc6QDFDd2F73K9nncbc
	 o/okm7sd5lcfpW2Adhdatj95b3cfPI/IpCiZMbTIo1nAmviPGvaEIWbZNiQJzl78eV
	 u+fUtp5CfGIKdvxC4viUpcH5/R3t3Pu3Uk507ccZ2de5912aqs7LUwGPqHu/LEU0TI
	 vzX4XldLpCvQg==
Message-ID: <6e72f357-f944-4f0f-b74a-587de5780a78@kernel.org>
Date: Mon, 22 Apr 2024 05:21:26 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Re:Re:Re: [PATCH] cpufreq: exit() callback is optional
To: lizhe <sensor1010@163.com>
Cc: "grygorii.strashko" <grygorii.strashko@ti.com>, viresh.kumar@linaro.org,
 Greg KH <gregkh@linuxfoundation.org>, torvalds@linux-foundation.org,
 "gregory.clement" <gregory.clement@bootlin.com>,
 "grant.likely" <grant.likely@secretlab.ca>, bsegall <bsegall@google.com>,
 broonie <broonie@kernel.org>, bristot <bristot@redhat.com>,
 brgl <brgl@bgdev.pl>, "f.fainelli" <f.fainelli@gmail.com>,
 "fancer.lancer" <fancer.lancer@gmail.com>, festevam <festevam@gmail.com>,
 Finn Thain <fthain@linux-m68k.org>, rafael <rafael@kernel.org>,
 linux-pm <linux-pm@vger.kernel.org>, Shuah Khan <skhan@linuxfoundation.org>
References: <b97964653d02225f061e0c2a650b365c354b98c8.1712900945.git.viresh.kumar@linaro.org>
 <5759bc29.32d04.18ed0ef5037.Coremail.sensor1010@163.com>
 <20240412062407.ntahibzv6xsbrnxs@vireshk-i7>
 <1b53a162.32e95.18ed0fdb13e.Coremail.sensor1010@163.com>
 <20240412063246.tk5z245miakbxws4@vireshk-i7>
 <2117690204.533771.1712904398042.JavaMail.root@mail-tracker-145-3ep34-c9h23-5f64cf7787-82gdh>
 <2024041212-bony-emphasize-75dd@gregkh>
 <663acff5.349d4.18ed18da6ff.Coremail.sensor1010@163.com>
 <20240412092108.xuvrfd6ioszltonf@vireshk-i7>
 <2024041259-ranking-aeration-29f8@gregkh>
 <28e13fe5.bc4.18ed2962985.Coremail.sensor1010@163.com>
 <1209348234.554742.1712932905664.JavaMail.root@mail-tracker-145-3ep34-c9h23-5f64cf7787-82gdh>
Content-Language: en-US
From: shuah <shuah@kernel.org>
In-Reply-To: <1209348234.554742.1712932905664.JavaMail.root@mail-tracker-145-3ep34-c9h23-5f64cf7787-82gdh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Lizhe,

On 4/12/24 08:41, lizhe wrote:
> 
> Let's both take a step back and add my signature to the patch,
> since I was the one who discovered and reported the vulnerability.
> 
> 

You might have discovered the vulnerability and sent in a patch. After that,
it is totally up to the maintainer to decide to accept or reject the patch.
Developers can't demand their patches to be reviewed and/or accepted. They
can request a review and inclusion if maintainer deems it acceptable.

In this email thread, I can see that maintainers and developers have been
advising you to understand the kernel development process.

Refer to the following document to understand the process:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst

Refer to the following Contributor Covenant Code of Conduct to understand the
code of conduct the Linux kernel community abides by:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/code-of-conduct.rst

thanks,
-- Shuah (On behalf of the Code of Conduct Committee)

