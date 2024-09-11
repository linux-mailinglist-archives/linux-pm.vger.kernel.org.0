Return-Path: <linux-pm+bounces-14027-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D367A975504
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2024 16:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 055A31C222D6
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2024 14:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14300199949;
	Wed, 11 Sep 2024 14:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ISqFutuI"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2B7188A05;
	Wed, 11 Sep 2024 14:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726063851; cv=none; b=cDq4C5I58DZCfUffVGYyji9rNfNG21ArurAhxoLisqvEm5iA0g1e8tb1APROOtVXPiqMeTUWkcEIG5qYeObd5y25SQ+VW8bYGJBW9LKJ99eE86FnGtY88iXvkNoMOVnyx11Fl1EUdP/lpqN5thdOfkMmfuDkaSJVYLUWrueitgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726063851; c=relaxed/simple;
	bh=ZK2+IxRNVqlt2+SM3hV6kWAM5192f+KQT98Sa8nIYdo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=B64jba/TOW0i7cCFdOyVYwr5/DpiRZEzdUTqWh5ad+ralNI0x9MRmaIs8FCexCmeun0OP08Sq+7MU05KtcyHqVXbcj3d7AhMXgls5CGQuLqNdz5dA4EcIvj+53irCSCB5FkTF3bw4EsEWWUMgbcea6fpOG0mTZJH4AQEwny75wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ISqFutuI; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2054feabfc3so60235805ad.1;
        Wed, 11 Sep 2024 07:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726063849; x=1726668649; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UHmfW921nMYPHNEVvSEZf5hsK+I8JZQzxqbgs7+8dbY=;
        b=ISqFutuIGEKxMPoSb/7j5LbXYonXaAH5TnzuWZk6+8ALBVItGHO4hug0TVl+V4U67/
         GH2XDpWCX0wDdGrOwRwdwr6LA/ynl3olX2wxiSWZUpmE8MVAYSOuwSt56msb1jK0Xdyf
         zMD2nJcJKdVpE2pTWNEULDMo3+6NK/6KIZhpYrMPZuIZ2GOYTbOT7MbpYq9ecGhqOpw9
         NNiEL9DhDothlcr24TT32bkwtZxGFY3TcXQbquxqE1cNXZZZ25l4Ozh/VwaOhwHDw0Wk
         GbKtOFesD7nD95d9KxG6G9xCoVJyVUDde5INYyLjLgQ5EBhUkC5nvnNGUG4OnYBJhnVM
         cS6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726063849; x=1726668649;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UHmfW921nMYPHNEVvSEZf5hsK+I8JZQzxqbgs7+8dbY=;
        b=US7SdHAJXPV0O3cUG+DZnVzxcD2UFtZx9zV7cd6JAQEXPybrhdd4mmTXAsqk5QQPK/
         9UsYZHpxlygyx8P5PTwYx/j9JVVVl5aGkORMdz4VyabJIOKeUBkUCbBMAs/UZHYCrFv3
         SyheAxcGjHnKcvaHcdfk7KSQTF1hb3C6GNB5OPMX88h2pWbyV9uhgcCSamYOS8CDuDvR
         OGp6uwi3bj6fqcVmKrMwq32uSdGsLZr8FjHYkWwqJea62rRxDdJ4v4Dy8o8eAkC26ZxR
         Z+d8O9AIYU0awtgQRlx0dzah3MAZt4wt9Wv8xEK/aOpqXO8z8MRWnJz7vDEQ3aXt0O6D
         eTgg==
X-Forwarded-Encrypted: i=1; AJvYcCV4+DMyzeW/9L1MYjTbG2kdMSd0jsyAf5PoT/3ow545xzHBx7CBz8Vfc2V7Er/iz9ZFCa45CBplXQOlCFF5@vger.kernel.org, AJvYcCVSxhdGoWaT0scIQJivPwRr0bevMEC5h97ALnMOyo3DKZMvRbuqMH4DpwXVYlOICy0J2J4kr1XXJJa5D3YpW6M=@vger.kernel.org, AJvYcCWGY2IQklM8QFEVMamW7kEStghM8yG0/tzcCEszh2KqRqfprKnHMhKy2Voovk7u9koL8ntTKVn9WgLE7w==@vger.kernel.org, AJvYcCXC2OYAOAz2gOWijINiQXRbZl3fPOAZhRs0wKASlA/+PWk8XXz7dn+2pHLdvd7EumVLD+cq0cig99zw@vger.kernel.org, AJvYcCXL1XIGLqxJBHpmRZW6n1G5JQi1kfEMmtW3mcXW/L8JkBagtH7h7v/+umsp2m6seWF2F1guLpitCxo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGmq6H7tj+xNGK420MeSaw5NeSdnHcluSo22RisTS5T1sWEbLG
	0K0myj8V8LCFeBf2uzahjANw/eSg1mBd91MSjV10GihmWjqY1Xrp
X-Google-Smtp-Source: AGHT+IGrJBh462kHYswwLIVvVm5LhvRtm2F/elyjLvrWN1VG/mzjIm1UzoZqu6qi8hy8Ub1yQ5B1YQ==
X-Received: by 2002:a17:902:f646:b0:206:c675:66cc with SMTP id d9443c01a7336-2074c5de235mr57743545ad.17.1726063848732;
        Wed, 11 Sep 2024 07:10:48 -0700 (PDT)
Received: from [192.168.0.122] ([59.188.211.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2076b01a896sm7975ad.298.2024.09.11.07.10.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Sep 2024 07:10:48 -0700 (PDT)
Message-ID: <587a431c-c62a-4c29-9c69-8a256a4b84a0@gmail.com>
Date: Wed, 11 Sep 2024 22:10:43 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/22] Initial device trees for A7-A11 based Apple devices
From: Nick Chan <towinchenmi@gmail.com>
To: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck
 <linux@roeck-us.net>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Mark Kettenis <kettenis@openbsd.org>, asahi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-watchdog@vger.kernel.org
Cc: Konrad Dybcio <konradybcio@kernel.org>,
 Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
References: <20240911084353.28888-2-towinchenmi@gmail.com>
 <369a32dc-330e-4827-a61f-5686f7d90a07@gmail.com>
Content-Language: en-MW
In-Reply-To: <369a32dc-330e-4827-a61f-5686f7d90a07@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/9/2024 20:13, Nick Chan wrote:
> The Home Button probably should be assigned KEY_MENU instead of
> KEY_LEFTMETA.
So this is a bit confusing, there is KEY_HOME, KEY_MENU and KEY_HOMEPAGE,
other phones like arch/arm64/boot/dts/qcom/msm8939-samsung-a7.dts seems
to be using KEY_HOMEPAGE, so I think I will stick with KEY_HOMEPAGE

> 
> Nick Chan

Nick Chan

