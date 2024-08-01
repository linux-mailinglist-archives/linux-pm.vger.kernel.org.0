Return-Path: <linux-pm+bounces-11814-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89525945179
	for <lists+linux-pm@lfdr.de>; Thu,  1 Aug 2024 19:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB2ED1C2262D
	for <lists+linux-pm@lfdr.de>; Thu,  1 Aug 2024 17:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C931B9B2E;
	Thu,  1 Aug 2024 17:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="oh8vdwfk"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7EDA1B32B7
	for <linux-pm@vger.kernel.org>; Thu,  1 Aug 2024 17:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722533329; cv=none; b=E6iNrTs1CDEtQQg8RI9/08beAp2Gsk7hQ1k4H5Kl4x/j2SGJsSdjUlLYnNaGh4nVTaAGCv5U2lAu3hAjERIwls8HW2D5VYeKILC9D8OmLIdtrszARkcuiU64FcPQ7gP9Mlmh7KHjdDbxQz9JTzL4wGBt56rZtdCP8KysuGz3OVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722533329; c=relaxed/simple;
	bh=xYp1qctPQ3XCpMinrXG+jW9arJfjc0jjCGgwQ6JAppA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iKl/AELrudqao4VoAx34Z6M0bB7fnuUYwS+aQ7ut+ponHZ79MPChBfI0PO3/VkknCWp+YKfqns2uywXT9FVtao36xhvQEDlljgKF8XcFIN4Yqq7EvSrWbbDz9/nIYpFxSM6aRb/e8++koQbB0N1nu8MLsNUuK1nmcFlx7PzbVHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=oh8vdwfk; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-428e1915e7fso7223275e9.1
        for <linux-pm@vger.kernel.org>; Thu, 01 Aug 2024 10:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1722533324; x=1723138124; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XnwjnjetY7dv9eCyx710zpOpIL7zDgItoHiS/DQyjbw=;
        b=oh8vdwfk+W1mR2x14bS68ATlOQLJ6HZMU1zdufP5d7Rg6lIs+9UDYcgIvT9WdT7nNC
         OQp+OSJqTASdPbruP/YWNgNMJNjfJQLTQkOShdz3Z0n4St/2AKtNCdxJiW8ZYo6/DI/O
         efgyLeMxmgpZ5eT/Ob0s6nK6qRnl6MwEhqbEZ2X74KpwkSpy/Klks5vPzmmmCSDsnw1o
         zO44yDnWXi7SIW4Cs4s3mlthO+DKzuR9ixrs1cd3cIWFTvNyYiKlRJdLbdcOjx/SaYog
         8WCwhDtQTxsKzz6bWK59vjPHdEfNS60L0waatMGlOsVE2FYRgZkJm3uSeA6VHPwPNpAS
         Gigw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722533324; x=1723138124;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XnwjnjetY7dv9eCyx710zpOpIL7zDgItoHiS/DQyjbw=;
        b=BRWnwa1F/f9Byjduw2TINY9cDc41+1RP7mfa9f8wTepMvM1Sp7VT1bN0Zw9RexCRvl
         ZzFDR7cQqvhmot1wRfk/KAIAkdqnbfGC9bg0K15RNm8O8VK9CDz49sHbQR2n6eixUHzl
         qICnGkLOTtbBS/mAX3JWKdieVob/s66Myp9D4UsWu1lUUW8ffY4diK5g+nPMVcCXt84i
         KVqWr8TrSBI5YQz3iXSPR6QINUpJ/onqKcPVLCd0CkllneJHUthBH/dXE/nA8Q+4jI5h
         k3HcHjVYybCzf6u1tjWvNmlRgVlTzvHS1+uFbzniQg24w9Fj0xe6aPKdJsDF6NUbnVEi
         7ong==
X-Forwarded-Encrypted: i=1; AJvYcCUDVtnFe+4Pt92xyZFimysJe69HnJjKhUmIGOOfzMnXa6Et3lkf0t0MvRwvOeQ94fBwiFo5PAKgL/y0jZAlykvSlNqflMh7HJU=
X-Gm-Message-State: AOJu0YywVxO6mxcYstVbI0hOPn5MH0wto+w5FT9m+s7TGdq9cd4g24Y8
	nWRVse8pkUxJAuvKRTon3A7/kNYCsaCqH7ygcr6G380Rzk/eHM74yn9WqWIgKeQ=
X-Google-Smtp-Source: AGHT+IHS4knhHpTTc3R8fFT40aZdqgWtj3Bjf8KF8/wk14Wl+xIhW2xqBDu0DirWFImXVhfOp8H0SQ==
X-Received: by 2002:a05:600c:3b17:b0:426:58cb:8ca3 with SMTP id 5b1f17b1804b1-428e6b07c64mr5187045e9.21.1722533323640;
        Thu, 01 Aug 2024 10:28:43 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282bb6405csm65736205e9.34.2024.08.01.10.28.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Aug 2024 10:28:43 -0700 (PDT)
Message-ID: <80d56236-2499-4c89-8044-6a271e47515d@tuxon.dev>
Date: Thu, 1 Aug 2024 20:28:41 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 8/8] arm64: dts: renesas: r9a08g045: Update
 #power-domain-cells = <1>
Content-Language: en-US
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: mturquette@baylibre.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, magnus.damm@gmail.com, ulf.hansson@linaro.org,
 linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20240422105355.1622177-1-claudiu.beznea.uj@bp.renesas.com>
 <20240422105355.1622177-9-claudiu.beznea.uj@bp.renesas.com>
 <CAMuHMdWhRRdfoqg_o6bU7jjt5_Di0=z7MJ4fMh=MJ0m8=u4tgg@mail.gmail.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <CAMuHMdWhRRdfoqg_o6bU7jjt5_Di0=z7MJ4fMh=MJ0m8=u4tgg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi, Geert,

On 01.08.2024 19:13, Geert Uytterhoeven wrote:
> Hi Claudiu,
> 
> On Mon, Apr 22, 2024 at 12:54 PM Claudiu <claudiu.beznea@tuxon.dev> wrote:
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> Update CPG #power-domain-cells = <1> and move all the IPs to be part of the
>> IP specific power domain as the driver has been modified to support
>> multiple power domains.
>>
>> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> Now the watchdog fixes are in v6.11-rc1, I will queue this in
> renesas-devel for v6.12.

Only the RZ/G3S support has been merged.

The watchdog fixes that allows us to use this patch were submitted as RFC
but got no input from Ulf, yet.

Thank you,
Claudiu Beznea

[1]
https://lore.kernel.org/all/20240619120920.2703605-1-claudiu.beznea.uj@bp.renesas.com/

> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds

