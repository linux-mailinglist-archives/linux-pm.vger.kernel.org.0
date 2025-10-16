Return-Path: <linux-pm+bounces-36226-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B11FBE2079
	for <lists+linux-pm@lfdr.de>; Thu, 16 Oct 2025 09:52:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DDB119C4D13
	for <lists+linux-pm@lfdr.de>; Thu, 16 Oct 2025 07:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E4B2FA0DB;
	Thu, 16 Oct 2025 07:52:22 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8482D6E72
	for <linux-pm@vger.kernel.org>; Thu, 16 Oct 2025 07:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760601142; cv=none; b=MCLpz/UY4xDKZRs00RJGjYGcHidEKrIjhhcayXwpnbRarY1QbFabE6CLfXM8a9WiaGQF7KXeeTbLy991ymvhaZNH9uoC9ixek6FM7XHwJncIY/7yBYn7tet3IT/vWkf1vHOmblZzZlR5RYEGp3gCGJMi65gy1H2zlxNwuM5LcKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760601142; c=relaxed/simple;
	bh=AJH7WrJPOAN6kLMOwNFtaIrtlfTcjK2iYHOpcKmV6vg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EuDJ1JXFl9TsK3murVVpGytAcRYyrz3ufRTktd9mukrpdrN2zA6db94WN6hrfTQTm7ev9BZnXGgtWzG0tkC10LGdkpTuId7m+azNtpMQAarJaj08wUr7oOC3RKCsGl+HKft4B1H7rb4gSjBpZVW21gTYy9rbYgyNZzGIGdRWIwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-8e1d6fd99c1so105233241.2
        for <linux-pm@vger.kernel.org>; Thu, 16 Oct 2025 00:52:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760601139; x=1761205939;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EM+UMNW8Lw0f3qHhaxOgNQsZ553oQZShOlYIZj5jsS0=;
        b=w3RKu7MbuKRV2D0JSCxwvjsx9RYxPfk93in9YhGjszZa0Wg1ddcpB8jP0+Fq7TRUFn
         47UHLYJJyEj80bFi82ZIgNB7qT0SCisRrVPyHNdtaDXihlzvFsCSgC8mPh30hrg2jK5n
         oNUgSI4PHjXLMQ9VAoQUmoEZRwQRz+WiVw2VbMlbjfY1jTWglqqMaDxcRB/fIe5OtnKo
         ZugYM6Fk/Okuj6Sxme+uvRq1R/y92VWBH3ljdABL2uThVgkjZGW1gwD0MdJVxk/3109I
         NuVthaSDDnuOGwZlbtxzkf3+KRmp802dhxLKmeW5AzkViXCtlWqsNmdyBMiFt6yvVUlO
         62BQ==
X-Forwarded-Encrypted: i=1; AJvYcCUI7inOc0wDanO5Ym/PTnN1yP+eud2WVNX/I8IiLueF2TRzslY0UySogPpsLSMYRXS5+BwZKkFhDQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzT20TASQL69XrQcTNWfUka+6PZBhCTkg/1ZCHtodeBGkQM/JAQ
	QmW1COflQdIU9WQ98GYzxpl/R0ouAKdpdKKuYiLLE0AIy37+q6CecnGLL57m41cq
X-Gm-Gg: ASbGncscDO+8K42AFItfwqL0BjhCOIMzA4cTkQfKe3A04yz3NozCSkTZAVN6aJCg66r
	hUF0W9shkiC3BioNxlX1AdR0WUigun5f4D/5aTzS3p/apfI04MfgVa26nRaGForeS9rlz8Y3sGM
	3Vd+1vMLN1Zq+AsRXTQy3TJqEIxu5Gbk/yC/NFRV9rD7jZv7vtrEonxaYR4ukKzXahCJIFqWIl8
	GU7d2d7eI8K7IBOd5713gNniG0v1z2zbygKIfPzs57WKg9QXZfKkyxObVbxHG+WOxpNPlF2frHa
	zQ9vKJZsV1mSSoEeweXYdOXelUTTFkDZfzo0DtzwqNKJ+bIoUu5bWp4Ac+673jZSDNqilA6/o+4
	4OluPTH+7ZKtBf5J/5n54M/CT6qJvyb7Zn+F/kW4JOMiONkDhwR4hpQRHpV2dvHKECFRA9w3rdB
	Hhsbvt/9Ef+ZU0Ct/sx+Qh6kVHc24MQwmLr1zYHyKGNp/9hSnq
X-Google-Smtp-Source: AGHT+IGNNyphWKGFr7di3CRYrlENC/EVwHm10A6NymhcqHltNCbSsf+R0j78UgitLfsM64YUzogujQ==
X-Received: by 2002:a05:6102:2b8a:b0:5d6:156f:fedb with SMTP id ada2fe7eead31-5d6156fffd0mr5068996137.36.1760601138801;
        Thu, 16 Oct 2025 00:52:18 -0700 (PDT)
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com. [209.85.222.48])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5d5fc8b5e06sm6110382137.11.2025.10.16.00.52.18
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Oct 2025 00:52:18 -0700 (PDT)
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-8e1d6fd99c1so105231241.2
        for <linux-pm@vger.kernel.org>; Thu, 16 Oct 2025 00:52:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV5umqEFsSMegNcSZjIWWGZeGmmjtGDG4W25/N7UEEEWD30NkMSXJzggMuwHtJH1AgEfXWmrcaVxA==@vger.kernel.org
X-Received: by 2002:a05:6102:4a96:b0:5d6:5ac:3902 with SMTP id
 ada2fe7eead31-5d605ac3938mr7430525137.21.1760601137749; Thu, 16 Oct 2025
 00:52:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015155905.186612-1-marek.vasut+renesas@mailbox.org>
 <aO_eLEFLAnjc8n4G@shikoro> <62670d89-56f2-419e-8f80-0536858415f3@mailbox.org>
In-Reply-To: <62670d89-56f2-419e-8f80-0536858415f3@mailbox.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 16 Oct 2025 09:52:06 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWAhew_Mp0g71F3TYBtg0-ygyCA=CUN+kiqVyQBv7-4jg@mail.gmail.com>
X-Gm-Features: AS18NWAX5i90o9h8ql65F7fSE-NJTpXX6NfoQ0S55rLMlpTfCwhxCtz9GyA1ilQ
Message-ID: <CAMuHMdWAhew_Mp0g71F3TYBtg0-ygyCA=CUN+kiqVyQBv7-4jg@mail.gmail.com>
Subject: Re: [PATCH v2] thermal/drivers/rcar_gen3: Document R-Car Gen4 and
 RZ/G2 support in driver comment
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Marek Vasut <marek.vasut+renesas@mailbox.org>, linux-pm@vger.kernel.org, 
	=?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Lukasz Luba <lukasz.luba@arm.com>, 
	Magnus Damm <magnus.damm@gmail.com>, Zhang Rui <rui.zhang@intel.com>, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Marek,

My
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
on v1 is still valid

On Wed, 15 Oct 2025 at 22:13, Marek Vasut <marek.vasut@mailbox.org> wrote:
> On 10/15/25 7:47 PM, Wolfram Sang wrote:
> >> - *  R-Car Gen3 THS thermal sensor driver
> >> + *  R-Car Gen3/Gen4 and RZ/G2 THS thermal sensor driver
> >
> > I am not opposed to the patch. Just want to mention that such
> > information gets stale all the time, so I would suggest:
> >
> > + R-Car Gen3 THS and compatible thermal sensor driver
> This won't cover RZ/G2 which something else, and Gen5 seems like it will
> be also a bit different, so maybe the list is now exhaustive?

Until it gets reused in a non-R-Car SoC, a decade later...
BTW, do you know the origins of RZ/T2H RSCI?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

