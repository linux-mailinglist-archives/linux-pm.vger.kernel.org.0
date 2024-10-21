Return-Path: <linux-pm+bounces-16062-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2391E9A5E72
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 10:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53A2E2832DC
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 08:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0687D1E201D;
	Mon, 21 Oct 2024 08:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S0ctVuCK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE35B1E1C39
	for <linux-pm@vger.kernel.org>; Mon, 21 Oct 2024 08:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729498783; cv=none; b=bnn/D6eZ2bCj/F1lURh5I91S7GY+soasoA/7GtZf1xalOEoLJCTeBvGsSJ3UcIr9rLiXIHJ0cebc6GpyEbBYwFbKvlSDEAezmC5O27VlbhchbRYTxvGZNczp/OyFFT0X48mi3yP+MMPeNModcyeOvdfFU2q+AoeLCHj64CtD+xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729498783; c=relaxed/simple;
	bh=mmy0lUHY10XMceDWyuEECF+zZB2RmGtgnb3/AvNSYCo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=kmETHNpQcGFRv6I2WQRUYdg63cGsSTSKYXmcd1SoknPQhoywy8B4RodFvgWx9nPn1nKiLTGkrCy61N0J7qwNByeYliudbiGZa2U3NQdFsEGq94JZ3AvXPmhz4jYFRiTi+QMMIt15n19PuAiUE+fKrKXZA6FzapoPKZ5t1O3bOmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=S0ctVuCK; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-431688d5127so18173265e9.0
        for <linux-pm@vger.kernel.org>; Mon, 21 Oct 2024 01:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729498780; x=1730103580; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yHRPgg+q8bk3cyQ9cnZf7YUjXWEJzbMQoHFo/LIaFgA=;
        b=S0ctVuCKHuLGQgfyGJ7LamZxDqA3okHH+MVYQZFrT9i6KFSG1YmZxr204byiIjnASY
         jT4ecbxRpgI6dMmeRBLseyBVMQNnlANIC+YbD01mFm4e6WfybX+ocSuHP12k3eQ/yDhY
         5x+W+RnVD3BUwfeeY4FchwgHhU1nOzFYskPwVoQg/+Fp8s57XrRFEPWDh37t4Xuya9ca
         JO0kKPk/vhUPZrcJKWQLc2/K0TNcHYG1PX3e1dZB88w6FMiq/GN2Zxyoy8+DrzvhrJJl
         BzoILzcERpEj6nQgEqTkCn/TIs1/kzcfE1ctkoFELELzFEJLJpQWHnI7H8izXtX6Kokk
         V7/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729498780; x=1730103580;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yHRPgg+q8bk3cyQ9cnZf7YUjXWEJzbMQoHFo/LIaFgA=;
        b=QYJ6OqngqOEUIuGay3Tu0MfcXLHcv2SGFJvNtzUY20qEK1Vw8VCBx/YBJEHAsu8ACO
         26q4ZXo4BlwLXRuPVSrkBgp1h4osC0c6ioeUmQFFy3X3TRvWTNKUjLBiyU49lQj/wOUf
         NQFR5EBA5w56MH/S/4/QFqNY7bPzhdwPjILF5u+0t5lArRfAqBsNINrvGAaCdttmfWyK
         AOFRDT0y7lwAV/RJVe9+b3x9Z8K/l50e0MkQqVIPe2/oq8WDQ4m4XQo0gc0LE2m4HQpi
         9LOSwzLiEwZg4Au4ejgHNTMjlJXuzDqMahCLR4whO+3+bWaIjLkQvDTgfWMFS2as89YZ
         wnaw==
X-Forwarded-Encrypted: i=1; AJvYcCWq/aevCiLjWpAU/UYB8jY/CQqHThTJyRSniHDN4gzySk+AsmCBGXVPalGPWrusLZ/YfupJnitPEg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxWXbh30rQ2Qjo03q5KZv8+jgQtfvZwFXkfuyoPbXK95Zq+/XBY
	VBypbrcMwAfFlqNIpuHkOSgfK4LictqHtZLntsGe9x5qXBV0bYjlRZaz2XFW8R4=
X-Google-Smtp-Source: AGHT+IED/LBgjQ55uXpNqcKrHvKk9qFESp+rHavpuh2rAeQBHY5Zz4n7XG5LLtXWp2zMyidtrRUo/g==
X-Received: by 2002:a05:600c:3591:b0:431:4c14:abf4 with SMTP id 5b1f17b1804b1-4316163a1b2mr86387655e9.14.1729498780195;
        Mon, 21 Oct 2024 01:19:40 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4316f58f1fdsm48847795e9.28.2024.10.21.01.19.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 01:19:39 -0700 (PDT)
Message-ID: <19198432-6d86-4763-80e8-4dd163e65d2f@linaro.org>
Date: Mon, 21 Oct 2024 10:19:39 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [pm?] WARNING in thermal_thresholds_flush
To: syzbot <syzbot+f24dd060c1911fe54c85@syzkaller.appspotmail.com>,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, lukasz.luba@arm.com,
 rafael@kernel.org, rui.zhang@intel.com, syzkaller-bugs@googlegroups.com
References: <67124175.050a0220.10f4f4.0012.GAE@google.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <67124175.050a0220.10f4f4.0012.GAE@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Hi,

I found the issue. I'll send a fix for that in a moment

Thanks for reporting

   -- D.

On 18/10/2024 13:07, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    15e7d45e786a Add linux-next specific files for 20241016
> git tree:       linux-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=123c2f27980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=c36416f1c54640c0
> dashboard link: https://syzkaller.appspot.com/bug?extid=f24dd060c1911fe54c85
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1192f887980000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1417e830580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/cf2ad43c81cc/disk-15e7d45e.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/c85347a66a1c/vmlinux-15e7d45e.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/648cf8e59c13/bzImage-15e7d45e.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+f24dd060c1911fe54c85@syzkaller.appspotmail.com


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

