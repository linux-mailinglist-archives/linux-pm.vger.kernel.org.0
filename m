Return-Path: <linux-pm+bounces-28558-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC1C4AD775C
	for <lists+linux-pm@lfdr.de>; Thu, 12 Jun 2025 18:02:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 755783AC1CA
	for <lists+linux-pm@lfdr.de>; Thu, 12 Jun 2025 15:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60062248884;
	Thu, 12 Jun 2025 15:54:13 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA35922094;
	Thu, 12 Jun 2025 15:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749743653; cv=none; b=Uke2NhumC4gkEPTdixfZ2yMN+WSuMrD1ADmUZEUIX7Tk7EIvX6xWLD6hR2+BuG5WwLBHWE9Gec/3kF4YdYPhbuEqgHBsXzxzQWB9JOQL5UqmoobYZS3B8JvFZH9+s7E5tlDD4mw3hMePuOafVEOrKbo4oETwdlc0hYnYViyewC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749743653; c=relaxed/simple;
	bh=Lozr22R6CO+RNvwVhifH/eSDDg9MlLQKcOlojkNqxc8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XdPRtZ+04TiEXzaDq4DThV1C333xqU4VygjfUKGnyykOEBYDm32UuzpXdo7FxR8irvLNeGIzWaWRt8+kdpaXnUsKiCbeqU5PloBzL/zHH8XSZJxmVykWMifMC0DaVhOkuBTfEZ+Ss6Wk5X1lGhLYGth00d8d1G3DVDIxGsYei0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-53125ca7837so635169e0c.0;
        Thu, 12 Jun 2025 08:54:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749743649; x=1750348449;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MCWdKGDkn0LPrrpZul9GwNXUtPRdna1q2f9cpPPTLvA=;
        b=CJnRmZoQ0g9EeciCPu5VSgLQ6+Yp0sVzbIUuG7Hw0r3haTpYwF21HW+9STnyJy6O9c
         ulAGUTqJFZZfKyYx/K9NAHZq9OU4XUGGSQzDF0D5+rG37dGfugK7tLcJ9ORfzhwnEdQ2
         ti8J6zb1CBNoqI5l8cnMvtPfjuH+ukszGhAyaFPr5OHh/UeB8CYRcL6oquxChjyuBW1c
         75JQwTuG2WmdTRREClWXwkFWny5EXotZJgDPDhfxb/VpPjOPKrPKDBDm9xXULB56wR/y
         lvFSnQs1LIR/19ZvQ0vyI13j1dumLw5yZsi3MMq44nbsnXSUxfJ5PsmbxY6ihEIRP5TX
         q5zg==
X-Forwarded-Encrypted: i=1; AJvYcCUOVp7hSMWtR+LrlA6Frd0BnR/loTzLXVGb6IfRJO7daV1nKfwc2ox2u1PSzwU5k4/23/kwwAeqEMm9w3uvmGLhsmg=@vger.kernel.org, AJvYcCUkZcsR3Ss3sCr5/R3dPXHOmKXPpE59twdWjwVLTketmtnJNYDJ3kPULDU99nRe4YSVsXlAh0JNFYH4SYA=@vger.kernel.org, AJvYcCVbnRcHQmj3qmkwUVH4uDHh359MlnmZw+hxJIOKJLUIRCe8QteOwLNd3L6MdTDZ+eKj8BmX18AmuyG77/kodmX/YFI=@vger.kernel.org, AJvYcCWsUzdGiOMYf+//lkaORyRFeoFsvPxny/1EZNLGOuHbmdEiHkak0tkMBCrPcOAZESHHA/eWlS5GaNs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yypo7DB0NRFCzgTV2JyaYjQsPVhDNqsZD6nC0sYs4+DFYO0wRw9
	IuOIFBrVs9ll+nasIhuD6sCSZpN4pXFZAn6GFed51DM3bval9f63U43ztnW7OMh2
X-Gm-Gg: ASbGncthSQPf+5XFYpGw9rz9RnmwgYBPMmsSf/aO4NlXWcmxPqrPSxGDsrvwSA9nc4H
	ggZO0xyU9NMVKfNL9/DIvmHoyCTz6LJlXydyT5ii9OKpBxwbMzA4WWWKHnEt1eOtI0xP5oqIygC
	BXv7X5BOdhCV0UqHWyPrt92Qw7A56FZ3Qg8EVoZDF5565LsBmqC9jBMZZmi2DDcEd0eihrZDaHv
	TC3LVQlK8rQJOJrFvxrxWMoJEl68PPviRzP6aON/dNAOtcnjNHHQ0BUfbi0eRLatc2HG+VET7T0
	p4Cngyb27KvSLopSDYHIODbb0e/lmWwZP/BGq0WtzpTGFLKU7/woo9Ole8Kme1yukA/DyeO0Jhi
	uLI5Vk/aaialT3Ga+tExBWS59
X-Google-Smtp-Source: AGHT+IHPQH4Y8zIYDo7jnYGjuCCKNfPDnUxt8yyPNZacUMOEktQBFF58LQrKvZEwDw2RZYYcI0kOoA==
X-Received: by 2002:a05:6122:81dc:b0:52d:cc6f:81a2 with SMTP id 71dfb90a1353d-5312dc21da3mr2539414e0c.6.1749743649358;
        Thu, 12 Jun 2025 08:54:09 -0700 (PDT)
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com. [209.85.217.49])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-87f01259249sm340861241.9.2025.06.12.08.54.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jun 2025 08:54:08 -0700 (PDT)
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-4e7c7680591so656668137.1;
        Thu, 12 Jun 2025 08:54:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUowVZxKTEwyQURYu7qTx9yNZ323/WGFV047Wy0s8MyKJSqJakBSpr/fIRonZdUt8U/qYz+nzu2uBpnToQ=@vger.kernel.org, AJvYcCVoNcpLFUGR19ERv5s2F4O+s4f3gt2yrCOjsUIjHjkRDU5Ku3VtOHRDbhtwC+IjSZvd/m/n1ATo8/JTQeNO69kadlQ=@vger.kernel.org, AJvYcCWqS1F10E6wubpH3w+gSsedHbklQtjSgYWni/MiuXsqtgfkDi3N7ItySzSw3ImnZ/ZtlX1LjN5gket2VllD36d9ohg=@vger.kernel.org, AJvYcCXRxK2ji42gfTE/fVcDTmDx9S+YlJO6PiHjtQMXYx+6S9XvQe4yrwGqZ8l0aJedtkRtAtuCkiclT4g=@vger.kernel.org
X-Received: by 2002:a05:6102:5113:b0:4e4:3c3a:f163 with SMTP id
 ada2fe7eead31-4e7cd7a4049mr3737309137.7.1749743648153; Thu, 12 Jun 2025
 08:54:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250610193403161UQCV5cVGXCRVDheTb7jvi@zte.com.cn>
In-Reply-To: <20250610193403161UQCV5cVGXCRVDheTb7jvi@zte.com.cn>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 12 Jun 2025 17:53:55 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV2Ar95nrmH=NTwY+pkrg6nD-sNoVG7MJY7ofJF4N3bNA@mail.gmail.com>
X-Gm-Features: AX0GCFsIwHF9_aoZ54iuAPGFucIDRqFn8Tjpa14cAUcOdjFvqEv5PYmW-DjzBPU
Message-ID: <CAMuHMdV2Ar95nrmH=NTwY+pkrg6nD-sNoVG7MJY7ofJF4N3bNA@mail.gmail.com>
Subject: Re: [PATCH v2] pmdomain: Use str_enable_disable-like helpers
To: shao.mingyin@zte.com.cn
Cc: ulf.hansson@linaro.org, changhuang.liang@starfivetech.com, 
	geert+renesas@glider.be, magnus.damm@gmail.com, heiko@sntech.de, 
	krzk@kernel.org, alim.akhtar@samsung.com, walker.chen@starfivetech.com, 
	sebastian.reichel@collabora.com, detlev.casanova@collabora.com, 
	finley.xiao@rock-chips.com, shawn.lin@rock-chips.com, pgwipeout@gmail.com, 
	qiu.yutan@zte.com.cn, linux-pm@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, yang.yang29@zte.com.cn, 
	xu.xin16@zte.com.cn, yang.tao172@zte.com.cn, ye.xingchen@zte.com.cn
Content-Type: text/plain; charset="UTF-8"

Hi Mingyin,

On Tue, 10 Jun 2025 at 13:34, <shao.mingyin@zte.com.cn> wrote:
> From: Shao Mingyin <shao.mingyin@zte.com.cn>
>
> Replace ternary (condition ? "enable" : "disable") syntax and ternary
> (condition ? "on" : "off") syntax with helpers from
> string_choices.h because:
> 1. Simple function call with one argument is easier to read.  Ternary
>    operator has three arguments and with wrapping might lead to quite
>    long code.
> 2. Is slightly shorter thus also easier to read.
> 3. It brings uniformity in the text - same string.
> 4. Allows deduping by the linker, which results in a smaller binary
>    file.
>
> Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
> ---
> v2:
>  %sable ==> %s in jh71xx_pmu_dev()

Thanks for the update!

While I already provided my Rb-tag on Krzysztof's original [1], your
version is whitespace-damaged (TABs replaced by spaces), and thus
cannot be applied.

[1] https://lore.kernel.org/all/CAMuHMdXJ57mATWW4AnBedn+D7TQ4PadkJ642daquFtAo=wZFrQ@mail.gmail.com/

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

