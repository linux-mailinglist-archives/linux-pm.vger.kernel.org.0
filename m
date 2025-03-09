Return-Path: <linux-pm+bounces-23706-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B3DEA58565
	for <lists+linux-pm@lfdr.de>; Sun,  9 Mar 2025 16:25:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41DDE16499E
	for <lists+linux-pm@lfdr.de>; Sun,  9 Mar 2025 15:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 474161DE2D4;
	Sun,  9 Mar 2025 15:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PjbLzxF3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48EE646426;
	Sun,  9 Mar 2025 15:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741533901; cv=none; b=JTSsX4wUsCOQ12COhMWu0cQBh/Orqy/POfaix647fmCehgu03VKP+4lMaYd0XOmX6dQPMBrgN6f4Wwjs7qYuouvYKbx7aA9dzVjoA+Wt6cUsQfJTDBTjXJTI8cpjD1ORN89u0lKqfDZ+Lpv/kqvSm5CSKKuwbd1QRzkuAlYrgn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741533901; c=relaxed/simple;
	bh=PSFXUHUfKDV0VsXHDLScH1d0tKwFMoxRxuZhJj9brJ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ieBpCItmC5H1LBOaER2L/uOuz7O37VS3RmGFn00j3AMExY++U6q5Jq6mX9BQLzwlK8NZFIKDC5LjpZbSGtN0IXIyQ+LYoag52xfgNIKDJ1tn0hn2BNF4BVwH/p1vdpAgmv6rSNA7P3XyfA7civY4MrKADywvELM+kspy/BcRHhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PjbLzxF3; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2feb91a25bdso5183909a91.1;
        Sun, 09 Mar 2025 08:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741533898; x=1742138698; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=oE5dlvn/PoFAmzZkkwv7d6PSwwGsaZPhhmrL0ebICmo=;
        b=PjbLzxF3ApXIc9H7AdnUqm7/c/SbTlRflU9TubEvNhkVZk2SBTVjE5rLF1qTz2Q8tZ
         LZr1ajmYxokZtkhb6FgAZOVV60LJhagSnEeE87xOEgaP/LIjZZiDwZpDiImq3W9DOaoz
         ig57QEzy1x8XTdQd2eGV236J3LrizWa9aOupG/K0eHvaG1wXeQ4NExEkMPTbyvEYJowx
         G2jaQjUferCCUdK1YuRfvq0AQKJX0qM6L5nuIZG//BD3mswyTGVxjHmQWSL5WM9Kw0nF
         H4w1UYqW0DXpNVKdMkpwEQiDu8+wWYBFbSnSfJ8EI8mtL0PJWJMdmETTkvEEpMI9xHXJ
         SsFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741533898; x=1742138698;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oE5dlvn/PoFAmzZkkwv7d6PSwwGsaZPhhmrL0ebICmo=;
        b=tec9/Ka+Z8wlNk7o9UvdCAj2aGjVBlb2seosx2xcqoLc1kNH7EgogWLQZdNjE4S8na
         7TFvDjlm51C4fnRvkHj39mIqe5MuRxp6J7IvEBeyCvuoWgAlpeVctqXg3WU0A8WdV3Bo
         U4zVrHdOl+L3IP7zq3Xl3McHumLrU27lf94rkL94JVZ8+/TmM164RMzuuCGhD4i3Uz64
         oQ644spEsdKOmUWZiAjAWViXTu6SEsgqqXSJDnU+ag6Jh55zrP8gqvB7uSH+o60qu7Jb
         M+Y+TzIBZuMzPo6RYi0mYAQT4YZSiKdXIYJKlV1jIVkl+RpDxHXodsSs8RTd4ArDs1HF
         HU+g==
X-Forwarded-Encrypted: i=1; AJvYcCV7TayuM2KYFfha7FlHxwNA4Lsqk8uP/X7RjoExjZcU5/4z0xHkorOdfvIjFgmvO3MZ9mqgPEoHpuc=@vger.kernel.org, AJvYcCW4rT3XAHo9ptXbbmReZ0vF2YFIHzY8jCg7sBoGnk04K+JoVx4oHRFmlg8I51Am/g94/TJ1w80SVxs=@vger.kernel.org, AJvYcCX7wx+SgR1Ax5erZIGva73K0yqXcN8sPOC8zQjsism0guoADpSoa6oQpAWrFsi48Hgg0mr0yjb1RYvi3MFwzziLr/33rQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxExknHuKkHchoiz7wHVq/Ir1cxLOt1UuYnyAPBlGALDUm0KpN1
	brenjB2MqgTIyYS93kskuDkSdyckbde628fsTGM3QuLW8mLDdV1k
X-Gm-Gg: ASbGncuaaYfdjbT0YFaJxKPrCA3YFJYa9wTE05Ih/pYPcH08m8inIqR9f+vzvkZtB/N
	rfthjRFsXc1AtRp1EBPaHRMcj7SWwCdC9AvgE0Y/wnc+lbM4Tk761Wt149hRigIo/RL1b7yP3GJ
	uL4edtmXIiegAPSv/UkxMTJPujnC26e09PhQ7rTZa52BpYobbf3KTiMsnjRaELBzBKXVc9xJS04
	+vWIUYiSv0EBN+E8Umzad7KS7ak27dxzhlxY7sZDd5F7G13MCa66Wyc99vXCj8NaC8eiziEnq2c
	yDKTuWhKQtokXOv2jZFAevFrSM7ji4Haqg6Jbkk6IVBTHnTUomPLEKM0oeHHaVex0AaW7cyOsTk
	qnpa/izsw3Oyighfgs83Fd9AkR4l5
X-Google-Smtp-Source: AGHT+IGJ6fL03acBX7QB9IKawki20pcEFlM7EqCNYYvfl210N08+64JLV1DFRu5PmPzu9ZKwhOIEWw==
X-Received: by 2002:a17:90b:2883:b0:2ff:6788:cc67 with SMTP id 98e67ed59e1d1-2ff7cf31b55mr13178351a91.34.1741533898557;
        Sun, 09 Mar 2025 08:24:58 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ff693534f8sm6218041a91.17.2025.03.09.08.24.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Mar 2025 08:24:58 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <72528e65-5feb-40d6-9ea6-12ba45cef8d2@roeck-us.net>
Date: Sun, 9 Mar 2025 08:24:56 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/12] hwmon: (oxp-sensors) Add all OneXFly variants
To: Antheas Kapenekakis <lkml@antheas.dev>,
 platform-driver-x86@vger.kernel.org
Cc: linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-pm@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Joaquin Ignacio Aramendia <samsagax@gmail.com>,
 Derek J Clark <derekjohn.clark@gmail.com>,
 Kevin Greenberg <kdgreenberg234@protonmail.com>,
 Joshua Tam <csinaction@pm.me>, Parth Menon <parthasarathymenon@gmail.com>,
 Eileen <eileen@one-netbook.com>
References: <20250309112114.1177361-1-lkml@antheas.dev>
 <20250309112114.1177361-3-lkml@antheas.dev>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20250309112114.1177361-3-lkml@antheas.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/9/25 04:21, Antheas Kapenekakis wrote:
> Currently, the driver only has the F1 OneXFly variant, which was based
> on the 7000 AMD platform. Add its special editions: F1 EVA-01, F1 OLED.
> F1 OLED might have been a dev unit, but it is supported by OneXConsole
> with the same features so add it. Then add the F1L variant which is
> based on the 8000 AMD platform and the F1Pro and its special edition
> EVA-02.
> 
> One might ask why not just fuzzy match. Well, EVA-02 is a variant of
> F1Pro which is a Strix Point handheld, but does not have F1Pro in its
> name. This makes it risky to fuzzy match, as special variants in the
> future from different platforms might not have the same feature set
> or registers.
> 
> By happenstance, all current devices use the same registers. For the
> charge limitting feature on this series, only F1Pro/X1 (AMD) were
> released with it, but OneXPlayer is providing bios updates for F1, F1L,
> X1 Mini units that use the same register, so treat all of them the same.
> 
> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>

Acked-by: Guenter Roeck <linux@roeck-us.net>


