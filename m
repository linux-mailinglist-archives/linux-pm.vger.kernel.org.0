Return-Path: <linux-pm+bounces-23705-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE69A58560
	for <lists+linux-pm@lfdr.de>; Sun,  9 Mar 2025 16:25:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82EEE164A1F
	for <lists+linux-pm@lfdr.de>; Sun,  9 Mar 2025 15:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69CEB1C760D;
	Sun,  9 Mar 2025 15:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GTqBxfi2"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992B4137E;
	Sun,  9 Mar 2025 15:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741533884; cv=none; b=Ng6iY7KnVhhjApg8/FzqEM+AqXtmlmGm5K4Pkt3yKw1OemidXBDnjv8FIQes4mTt4iEBuJUjsbB+8JBWw0JDPVaAKgAzo3gCRZigTgOIoJSx4JPpdpjD24ooToxJSL7GBMcuE0LssuwfuGEpfAdivy4XPp9A9A+j39o8OYzQlwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741533884; c=relaxed/simple;
	bh=7LeKLyvUfwlPviWS3E5S+NwgUWxPL+hK93byC9r0tIU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VmaD5EJBtJcH3RbObScsQqovWB6gij30hwVZOIMD2Blswt6FIR6riNh09Gt6ZRikosc42QbREzwnyqhpz1JNdeXD325jfR2S+9sDfLpX5kpj1gG8A8n6aipKjur/5/0UXtEGeZ/fbbXFSZajjn8tAbCwC3x/3WqHLPkJmSDkvoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GTqBxfi2; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2239c066347so57049305ad.2;
        Sun, 09 Mar 2025 08:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741533882; x=1742138682; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=UAqUzuVnMRkASlHYk3uZY2bDfkxuMKv1oIKXPWP42v0=;
        b=GTqBxfi2NiuyH7z96B6ESr1j4ArXnBPHD2FUjQU/adEUqGIWl0XeQf6fkhisN7rdOs
         jSYtpXOpL7vete2bYoUxgP5AHg+djUol0KqbVKw2eUrWCiH6N/h5Bl9GT/q/jCZGTjdk
         uvB81Ie0CB4V0YxYmyaGKrPSHoAP0Empi10pqQOq/COAqB5aBaiuHiuzW1rh92m0uiKa
         rD2XrU9SDC7sBkpGofTtpeX+oJkIaqNq7WnL3TwHR1uK84cGTGI5GYMcSsKdcvfbsUPo
         lqqo4AijeZh/gX/pgqISuCQeOVQDOizi4lPoBje4Oow8nQwRkq3HUD4ZN55xS7HzpQTg
         IuWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741533882; x=1742138682;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UAqUzuVnMRkASlHYk3uZY2bDfkxuMKv1oIKXPWP42v0=;
        b=aJ65cStTDPUgmpEY3pGIKzBmjwrAFskJCJ9rPXFaoGOa0PKQnwTi938/BNESQFGxwP
         GPgzVcEse8hmYzlkvHDbPhb6QtqAucxfeoFZyVefFrqoefDoi9FeUAG1W7Q3jyspd3gy
         OQ/hCiqqRBvTjzjw9fyN+tN58uWVqYlzG7XojrGK29iOVdtMopv681V/q1NByRmLOhBY
         aqdGq8HP9n+QVrjoInpuAP3FSQbNcXVT2UHjMHfwpbWo6D44hcmBxvDwhTJF5ofhlphx
         S3WvNX1vgSTDbBJ7fkE7lh8OvCiQ6gD+YMO+kwcmZR2yfNp4PtRlFGJphVk9LOakyYJq
         9KjA==
X-Forwarded-Encrypted: i=1; AJvYcCV4XZgX/e3VWpCOCNB0lxm9KafhJA+G36Ar4Xqlp96TgjgZ/sYclR1Qgfll9Qk6XcqG1bgE+oFd9cdvyIVSdXsGJr5FAA==@vger.kernel.org, AJvYcCVUnFiRhm7/ZYiN7SYVBhPL46bGNZ/4FtVAENLXY08KabrQcK7Vjc7Ym+tIRYsPoFa8loPUb0chFcA=@vger.kernel.org, AJvYcCWxlAlaaSW3UkuRNp68boRVz35BWInJMI8SCX7XW9qmJZHQQBJ9TdFZG5gMmvue6jI42yyDPhfOyTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRq+fZqHaAb/Tjkuf1vm6y9Pq21wc+Z3HwyMTfktViQdxVMmsf
	ZmNRO1BfGX0iWh2u4VXrJovJxLUEwPbHSMpYG4ZXO4AZM6Y0s78e
X-Gm-Gg: ASbGncsVB+ur98m/RtM/Tnik7lHhuvY6abRsFXmysRzCLnTsy5zHO8FvN5PojwAgOna
	1KljrOfaTbW2DJS+IgWvRw/kpX7oOjeYHQhD60+NkoIl/oCSu34Ll/qEYvpuHXo9cjz3HfFvIhL
	vplNUZfDir2VnmQZm3p+L6GvoWId1annnI2Z1sb4Dx/fhP91VbYu99GseTrSLQRqyqjSTQTqe3p
	DoYTPopN2Slz8BAi1FhhllgbX74updqzOMmT6ka5TI4ZRHhpzJ8m+EI/GkT2t+1SgtrlhywLuul
	NcA3m5mofjQTQTUdpKTSktxxnPA6H6VGat/PWRhPVvI/KPYX1vVcHVHm2gBqimif0y5NdMn20nB
	OmFjripKb/feHOWgkNg==
X-Google-Smtp-Source: AGHT+IE6c4jfviidZDtlOhIpFP4Rxlczr0JvsZ9CPjg6TaobIbxFd0CKlNt4Wgwt1af2ulLHd4QpJg==
X-Received: by 2002:a17:902:e5d2:b0:224:160d:3f5b with SMTP id d9443c01a7336-22428c1169cmr177102065ad.49.1741533881875;
        Sun, 09 Mar 2025 08:24:41 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410a908f9sm61501455ad.166.2025.03.09.08.24.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Mar 2025 08:24:41 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <f0b4a493-4169-4f94-a14e-522a0f8b0074@roeck-us.net>
Date: Sun, 9 Mar 2025 08:24:39 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/12] hwmon: (oxp-sensors) Distinguish the X1 variants
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
 <20250309112114.1177361-2-lkml@antheas.dev>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20250309112114.1177361-2-lkml@antheas.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/9/25 04:21, Antheas Kapenekakis wrote:
> Currently, the oxp-sensors driver fuzzy matches the X1 variants. Luckily,
> X1 and X1 mini share most hardware features so this works. However, they
> are completely different product lines, and there is an expectation that
> OneXPlayer will release more devices in the X1 line that may have
> differences.
> 
> Therefore, distinguish the 3 devices that currently exist in the market.
> These are the OneXPlayer X1 AMD and Intel variants, and the X1 mini which
> only has an AMD variant. As far as registers go, all three support the
> current driver functionality.
> 
> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>

It doesn't make sense to handle those two patches in the hwmon subsystem
because the others depend on it. I'll assume that all patches
will be applied through a platform tree.

Acked-by: Guenter Roeck <linux@roeck-us.net>


