Return-Path: <linux-pm+bounces-28293-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2C4AD1733
	for <lists+linux-pm@lfdr.de>; Mon,  9 Jun 2025 04:59:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E67DB167898
	for <lists+linux-pm@lfdr.de>; Mon,  9 Jun 2025 02:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28AA019F464;
	Mon,  9 Jun 2025 02:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="egEALj+8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3E52F3E;
	Mon,  9 Jun 2025 02:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749437937; cv=none; b=D8T+xKfz3NMsryg066lQxC0EIrcerdAKe7Xo2Xs8+nm+Y1TMzmtHKdQdOV2NMHCc0cKPtIcJLnMg72RiiaN6EYZo+yvLNjHTA2NCdAjsKKmjBTIon7SELHH5OLQKONAmS39Z21/WA5k6AnVzlssV+C2p5PSAtJj0InFJIFvzxuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749437937; c=relaxed/simple;
	bh=v6UPCPtnveux8OgvSGb3WrSCb85Ye2wB2jPPXUMjN2U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VqE+vVM9OgcDndgN0JEdgnKguYs1e5Bdgk5jG1waRNvFEVEegUsdnymAI/bWPqoKBZ899PSJWoZ54M+UVns1C1xEqKnaG+fG8BxBfrib14cjiJe3b53ZVjK7pUawOoFVsOO1bBEvJUdiVzzzXiVNlc06/utoiyNYlxTAo42vIoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=egEALj+8; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43edecbfb94so45303555e9.1;
        Sun, 08 Jun 2025 19:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1749437934; x=1750042734; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yp/jvaoC1WcWLG/0zffbhCmf3ZGbY/LJEvB/9n/Tguo=;
        b=egEALj+881kHtypXzGYV5nGIZYmC68tTrjwCZt1OFqGKpHmFjVIZrqUvgb3fIBM3YZ
         igq+2xjebyx+t2q6uOzoy7mPhfb2Oj6ugKRL/n+AS8JA8FjjfV6svwMsY4Cuty2YoG0N
         cFOI0q7CypDuNwcQMlw6UCfqT4dQBeH/7Og38/dtquN9RrVJgbkh0YNrR5R+U6PSK+Zh
         CsxvSZ1BF4m35/fTV+nLtYYSJlS+JGWAGHa5a0+OS9Ah5mEoeOBgy+PX5ro1EiwGn5v9
         lAcNObcmnUPvKvvHsioxwfSwU0w9Hv2jZ6RNUKBwfPHozYAyM8b0OcyX19ZEAU5MV+p5
         ofjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749437934; x=1750042734;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yp/jvaoC1WcWLG/0zffbhCmf3ZGbY/LJEvB/9n/Tguo=;
        b=N/gW7wizGMiQeyxevT/eUkh/PTEa5ZjUU//MJi2JlRNU0S5t32yI9deuLGihiV+12M
         514QaNmeNE+MbFj0JQxKPRh6qENzd/N5JGejDkacK6Zot/yqKHnZw0jCX9dZ88nrxYct
         qUajSQMwKKfEOVh/VJmkEh0YbkEV1vVMAyvDM0m578zqRXuWkYgqoxVHOlVjR1BYVf9y
         ip/bB6eMjbjMzI3N/ewgUJrvToINJ9K1vZwsjRzkYJuyv/Q3zqbJ2JPuiYVedmENB0v7
         4SuP3yqGFrco8lFqU3Y9ASf8l8Od/0K0ei0pq5ZvPSMdnA+1I2njmMqrJo0b0avri6Kr
         lHCg==
X-Forwarded-Encrypted: i=1; AJvYcCU1t9f8LYf8gFeOjrvygw8Df7QfljIwbD5OQg6U6nn8NJTr0z/yemQSsmyZ0yx7NH6WMLS/NIgW0Ks=@vger.kernel.org, AJvYcCXa/ROd2OaOd9MlLIMlu69PC7zVcXYfJ56Ivtq5oHcB1rctLZPNzOS66xrF6vwwJiJqlw0YDlB3ZohuzxM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2UANiOK53zCMhNEWCLXNRbRIjM76DhHaUEKaX/OWCenvm96tS
	TVP6q+GaR+PNOSSvmld9WhLoRwmYotqqb8u0qm7580LDiZVdrsiKJXg=
X-Gm-Gg: ASbGncuFWDnUPDzj2TT9xU/H3Rc3X62CsApALJmg4xfxk+X4DJJZzMIqV7situsDsia
	OZFP2STvf0TTh8IlYpNujqERwwY3N8VR4TWK0z5Ba39N+cNZuprGjFE2SGEif+FH+55u2OD3t8Y
	8Mvp/WjQgQOJiP+eseT3P1wAQpBK3wi0L9VNHRXuSU0ZRRBEn/qHDn2KOsBp2ZPfcjKgHj4E5za
	vfWDnXkegN1Bij+tlGslhGFKc2OwEL1WLGZVRswlVU3MitcR5/dZq6CsIYlgpftONpdfs+Cypag
	/o2A4nN8mP4rGaUbjrpl98/DpOtUEtvNC4RHXq7S7ze6+LSB2pJWgGFNpqyyeWqww3roAzXXOQQ
	SaTA+F9LkM44Pjo4LrZVj+zSWxBymeIlZb9N71MDi
X-Google-Smtp-Source: AGHT+IHJ8KSXj9LxiY1LnTRyYnJpUKrLchoAIrcl740HZvDckReCDsal+HTSzlwlhwqmv6fGLJftIA==
X-Received: by 2002:a05:600c:3b2a:b0:450:cea0:1781 with SMTP id 5b1f17b1804b1-4520137c0c8mr120167995e9.16.1749437933510;
        Sun, 08 Jun 2025 19:58:53 -0700 (PDT)
Received: from [192.168.1.3] (p5b2ac190.dip0.t-ipconnect.de. [91.42.193.144])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-452730c66a1sm95375935e9.27.2025.06.08.19.58.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Jun 2025 19:58:52 -0700 (PDT)
Message-ID: <b765500b-cfde-45a8-8f7e-eead57db7dcf@googlemail.com>
Date: Mon, 9 Jun 2025 04:58:51 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: Build error in 6.16-rc1 in drivers/mfd/88pm860x-core.c
To: Mario Limonciello <superm1@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 haojian.zhuang@marvell.com, mario.limonciello@amd.com,
 Thomas Gleixner <tglx@linutronix.de>, jirislaby@kernel.org,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Lee Jones <lee@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <fbea65b5-2015-44db-a7d9-b53cba9833b3@googlemail.com>
 <f656b948-aa3a-4811-b51f-64effa2001fc@kernel.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <f656b948-aa3a-4811-b51f-64effa2001fc@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 09.06.2025 um 04:31 schrieb Mario Limonciello:

> 
> On 6/8/25 8:58 PM, Peter Schneider wrote:
>>
>> I'm not a Kernel developer nor a C programmer, I only have superficial knowledge of C 
>> (but I love to test and to tinker), so I don't quite understand this warning/error 
>> message. Becauses some lines below, the node variable is used as a paramter to the 
>> of_fwnode_handle macro (from include/linux/of.h):
>>
>>          irq_domain_create_legacy(of_fwnode_handle(node), nr_irqs, chip-  >irq_base, 0,
>>                                   &pm860x_irq_domain_ops, chip);
>>
>> Does that not count as variable usage to the compiler? 
> It's not because there is a macro when CONFIG_OF is not defined that assigns it as NULL.  
> So to the compiler there is no variable use.

Ah, thanks for the explanation! I didn't quite see and grasp the nested #ifdefs depending 
on CONFIG_OF and the alternate macro definition for of_fwnode_handle when CONFIG_OF is not 
set. Now as I do, it makes perfect sense.

Beste Grüße,
Peter Schneider

-- 
Climb the mountain not to plant your flag, but to embrace the challenge,
enjoy the air and behold the view. Climb it so you can see the world,
not so the world can see you.                    -- David McCullough Jr.

OpenPGP:  0xA3828BD796CCE11A8CADE8866E3A92C92C3FF244
Download: https://www.peters-netzplatz.de/download/pschneider1968_pub.asc
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@googlemail.com
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@gmail.com

