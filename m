Return-Path: <linux-pm+bounces-34251-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54DBFB4AD49
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 14:04:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66EF71892191
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 12:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601E3321426;
	Tue,  9 Sep 2025 12:02:10 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0BF1E0DE3;
	Tue,  9 Sep 2025 12:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757419330; cv=none; b=T3xnvEck1IN1ZrGhRtrIwBVhz9G64FEN2P1a+SNi0fecjlEpaX7C157zc8HL8GEOd6P7vzpy5nt/aWr+iRmVkHyomTqo5xDB5WruaAUg7ycKX8uFiohnN+BRJtgI62hMQBo+HQbk8CqrcLdk3dXrLAxrw5wYebIKjngNagxTjQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757419330; c=relaxed/simple;
	bh=bk8So7vwQUq8tynZGfke7TIGVQNJnIj2l9Ust6VqaLM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W2R8VILwhT83ZPvLiDvdyqbHTUTuK+/xnf33YPSTQQH0DsO5eBnGE/vCW/kNnWZgz+pc/ZBrvuugk13+Onf1o5X9tEgTEDyd/bWttIbSnxlHEj8BRWC5rEyhjr4qQhocrguZ4bI+26od9fBJ7ECuCwCUkUyCOpzmXFgUImnsAoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-52a73cc9f97so1680479137.3;
        Tue, 09 Sep 2025 05:02:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757419327; x=1758024127;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fxUGtZkFgaEMMGyv9UP/AiQPFkPAv1YigptM6VlT4dI=;
        b=s0Zo5kivYQq0SRQhIsfiXGRISNcFYVyN+PNLnEAJNf5Rkfxwa3uP/1asExx/NNBlJV
         esegxfu/lA5azc2KP8rSjXWXs+O4hR/6reozAQz/Cdd+sXck8kXsyEudZ5m2KuefmGok
         r1URkFhCFjWaL0IIFayqGTfSGNr7Y2l406dAFUSBmEIhSk85M6Ws6IEmLeBQDN4pidnD
         zv5cFt7FhgpxgtR8iDsY8Al4XOmgx52C3nyaepjamYG5xS0nH7zjjYELSjKwgaYlgodh
         5xaGdX/+AJhjFhvsDa6RdGfbne+Uow7RDKDeTtTY0sVca11jJpEdI9bX7AntgV7dZMdj
         aV4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWpo0UHO3mqwzywvLiXm7MUrEwKcD34TlZS4v3NKAmVsoglMtrVXr+Rkgoc2GRz5mGEDRcVm4t6Bg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxhYN2HSdhTNstByuFFQPQe3XUl5b0whaZ3AwSlub8Ayq0yz6En
	BeYbXlqKL0lpzSRg0G6cWhcdI2wtp7f98CfccMXI3ngP1aHl0eHG6aRyhZR8BnnT
X-Gm-Gg: ASbGnctamrtuTB/79ATyYFIBv+Cb88kW5muY7BQeFHWb6it0OWkWJz7AbabV88e7Fgd
	deFyFkgn+cVGtQ/dZUv/MPrMH3C7KgYNB1GKoJ50OYANu6AvrRiI5A21mg9wRC8kyPahuxAo5XN
	HD0RpFjL1Q3g0+vslBmB5SqIHJBfI2ZwJyZF4/xNSVKKPvpctG1oEd+vdGGdOdGF9xXDqqR3Flp
	7vT42ipqSn36Nst8okNGuY9QRqwpaISFIvnqZq16s7IS+m7bGcZpw4fyTbe19hKphKAlshHNvCZ
	R7GbYp3/4aXkZtqd5b6ybnxx96fNuM6EHtL4Tb+nfL4AsCo3Kx126KS1a9g0Bh+1+J01qwfA4ws
	68TtN9cwnmVvFe10JRtheR3fwBTQqiIEmmWtMllC14SDzd9GMNFVrlC/X7JmMloUjYwC0dpA=
X-Google-Smtp-Source: AGHT+IGyYplVgTSg777iYG4XAj+xCyfdpgMJQLKAVUWIEvm+/JNtt7MGXeTpob7W9t7dMyibZDj1nA==
X-Received: by 2002:a05:6102:26c6:b0:528:6ec3:307 with SMTP id ada2fe7eead31-53d149b5828mr3246989137.23.1757419325795;
        Tue, 09 Sep 2025 05:02:05 -0700 (PDT)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com. [209.85.217.42])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-8943ba549d2sm10776111241.12.2025.09.09.05.02.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 05:02:05 -0700 (PDT)
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-529da1b07b5so766257137.2;
        Tue, 09 Sep 2025 05:02:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU2bLHO21/TAsm6Djd8mE5RRqfmkjN/ZIfEqyzX3jMa9W2DS39UBbVHfkM5xHelg8fWxTPi8D4BIA==@vger.kernel.org
X-Received: by 2002:a05:6102:b11:b0:524:a2fa:4d23 with SMTP id
 ada2fe7eead31-53d0c988440mr3125866137.2.1757419324234; Tue, 09 Sep 2025
 05:02:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909084618.23082-4-wsa+renesas@sang-engineering.com>
In-Reply-To: <20250909084618.23082-4-wsa+renesas@sang-engineering.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 9 Sep 2025 14:01:51 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUx2Ytke6KOi89MK3s26RWOhcLWsoH9GsZi4xCKUZqbmQ@mail.gmail.com>
X-Gm-Features: AS18NWBq7Id6sGb1wqPWGmJ_Q9ksKIgEpOgj1CZm8HzVtxUtAnroAp25S3tDFGI
Message-ID: <CAMuHMdUx2Ytke6KOi89MK3s26RWOhcLWsoH9GsZi4xCKUZqbmQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] thermal/drivers/rcar_gen3: improve Gen4 handling
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org, 
	=?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>, 
	Marek Vasut <marek.vasut@gmail.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, linux-pm@vger.kernel.org, 
	Lukasz Luba <lukasz.luba@arm.com>, Magnus Damm <magnus.damm@gmail.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"

Hi Wolfram,

On Tue, 9 Sept 2025 at 10:46, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> Here are some patches to discuss the findings we had yesterday during a
> collaborative effort. Details are in the patches. Let's discuss!

Thanks for your series!

Results from the two unfused R-Car Gen4 boards I have:

root@white-hawk:~# grep . /sys/class/thermal/thermal_zone?/temp
/sys/class/thermal/thermal_zone0/temp:43100
/sys/class/thermal/thermal_zone1/temp:27400
/sys/class/thermal/thermal_zone2/temp:33300
/sys/class/thermal/thermal_zone3/temp:28000

root@gray-hawk-single:~# grep . /sys/class/thermal/thermal_zone?/temp
/sys/class/thermal/thermal_zone0/temp:46300
/sys/class/thermal/thermal_zone1/temp:29500

Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

