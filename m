Return-Path: <linux-pm+bounces-22087-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1182FA35F4F
	for <lists+linux-pm@lfdr.de>; Fri, 14 Feb 2025 14:36:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D9D617168C
	for <lists+linux-pm@lfdr.de>; Fri, 14 Feb 2025 13:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3003264A85;
	Fri, 14 Feb 2025 13:32:00 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9EA2139A8;
	Fri, 14 Feb 2025 13:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739539920; cv=none; b=Eo/OfwVKHXtZqJZe4Y+qeHfFfqL0hteWftMqBFMebWxKPFMyhuFSXvxzAgbQn/kywi66zcpU1tyKzXVD8cz6xHOAGDEgT3FLGtmt4gygAwzYXbId+7jPaRTYbCwuvBieCtsz4C25rXlEsdmmsIjq+bGnlrRC3sdbgoKqF323Cwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739539920; c=relaxed/simple;
	bh=G3KO93dVJzkzqyKqAbpRldruJuHi2xQw2ZHHHSW+eZU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q3iOAzYiJdruy5aT4fIitIR0tsYgsJP3m42KeqKEW59EUaFuSSWCFR+8lE6kQh8k55K8+o3yFsUm2+OYOkWsbSz09HXYSfk5X5k3l2cm3a/fqW88z6h0i1oZjH5mzOjwVGOuVqM9us1mBk0Nko5uWQXbbXp6WgB6EQTlDoTFKfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-4bbf0aab584so582077137.0;
        Fri, 14 Feb 2025 05:31:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739539917; x=1740144717;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DoB0GQglfkbE99K597Y7qNuzNigGvdYrd4FeOhL83jI=;
        b=g0XYTCue0/XrgYzxbhCP82xQcg9bpfNXSAr600oUJ7b0McxnzwbAye39MrUjqevGPH
         ShoC9klZaZ7IX1SyEHiSANzsKD2qXPrwbuQWR7rCyhIFIvo9PN1DGIJk2sgOUhyNDnXp
         9M4v6yM9su/o12WJqkCGnc9DVorYP4nY3Cd38uuSz3oD+IcEVx0ZKhgwyQK3IpxrgI2K
         wmg83aAaR231OBCjWmbK8pWpuYKSN76LcoSulDZBtToL3mq3WAx+wy5YPL2X/csvkzu8
         /u6pScZBbJBMGbrySLxIkhp5oo/+24x6kj5xGhfnRpZqiUHQqm2HGUZLExDdPRY1b2DJ
         KdRw==
X-Forwarded-Encrypted: i=1; AJvYcCVL2/5+1XTyYEEZQILpRsN4JEZJeia0InjrAoWV1xTuT+UaeR/gmoJxgii5iQbVeGWb2P2/ZoXusk8ZQCg=@vger.kernel.org, AJvYcCVSsP5/rtAFekYb2RNbkNR6uM4Gu9uqHoAPeuyyZ5BjRLA1vjzIStqoYUQwS832/LQuH5hBtuMDZj0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5nhGrfYHbqsV+wxbay/hqXEc5XwZrqIvm6Zd2ipzmU65Oq/Yo
	+WhHXy2lMRHDVcuCEMWfxaRVAy/eM5mdQLXmXA1ac5AzTJz342TC4ShHmvitWXk=
X-Gm-Gg: ASbGncuYBYayJCOAIwhNO3IRvwxwqOXg8nkJemdRkS/P8meHHoPEjxmQl62NvBadL0+
	9aqvLqhR40nbopGwj0x5TVGwrhDTjOcE7SezQ5/zAlgE1bn5aA2tiYKzFd5hZkKbyYwCr8y2XSz
	7NltZZNqHJVWAjCTvKCutQOOAaztTfK1lPNaUgZBgLF9RVnpyEpISjAW9dWssEwzm7jP0TcpsJb
	aZDhiedm1sO6G1ua6BFJ5UsyzZJ2Gce/g9K307nMksrpp1dqemV1WNEP6b++8ByFKT5tKj7WLOa
	TKZCGo+Zgbom6dmUGc7RKMeLHm/x12sbOJMzcREqjMHjIcGglW9XUHLm+A==
X-Google-Smtp-Source: AGHT+IGj32SQ+ouGIQmvLlny32lSB9yEvzrubGRaTUtw7Mk+5vG8/NAXZkh7NWw/pTiaom6duFVXGQ==
X-Received: by 2002:a05:6122:d11:b0:518:773b:39f with SMTP id 71dfb90a1353d-52067b85482mr9150204e0c.4.1739539914639;
        Fri, 14 Feb 2025 05:31:54 -0800 (PST)
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com. [209.85.221.178])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5208ae7718dsm311213e0c.29.2025.02.14.05.31.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Feb 2025 05:31:54 -0800 (PST)
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-520349fc3ddso651897e0c.1;
        Fri, 14 Feb 2025 05:31:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV5Z1toZSZ1Di0sKwvWSaojIuNgzQVagPLMP3W/PgwhlahZBeEc5mmZG/Oo+6ySaL/46SmNE8Nvkt8=@vger.kernel.org, AJvYcCXamJajVVURxkEoqviKQFQIfGm2a8Gph3F516Rh0GSt9Dz3wc5qz8l0pSuM48hHRylDgrxGMu7II4ihyQE=@vger.kernel.org
X-Received: by 2002:a05:6122:32c6:b0:520:60c2:3fb with SMTP id
 71dfb90a1353d-520678bd90cmr9295309e0c.0.1739539913724; Fri, 14 Feb 2025
 05:31:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214102130.3000-1-johan+linaro@kernel.org>
 <CAPDyKFr98DraLvOC83rRFa=uKj_hmwS7Lj0L3JqrbqcFuhdWGA@mail.gmail.com>
 <Z688uKdqVDaQhm5V@hovoldconsulting.com> <CAMuHMdXD1yF65ezOmLz2ShP=gnYNNkUfTLfY8RA0m=C+WwtaVw@mail.gmail.com>
 <Z69ExkCLfv_xLLUm@hovoldconsulting.com>
In-Reply-To: <Z69ExkCLfv_xLLUm@hovoldconsulting.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 14 Feb 2025 14:31:41 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVZyh4ooooFM_ox0ZU5xChie+ivbFFKdVM5=r8xvY9QaA@mail.gmail.com>
X-Gm-Features: AWEUYZmNIoURtMZkV8g-fr8c-dVm3ih5jXXS6AhSCrloM8oFmml3XVvnAhB9IPE
Message-ID: <CAMuHMdVZyh4ooooFM_ox0ZU5xChie+ivbFFKdVM5=r8xvY9QaA@mail.gmail.com>
Subject: Re: [PATCH] bus: simple-pm-bus: fix forced runtime PM use
To: Johan Hovold <johan@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Johan Hovold <johan+linaro@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Liu Ying <victor.liu@nxp.com>
Content-Type: text/plain; charset="UTF-8"

Hi Johan,

On Fri, 14 Feb 2025 at 14:27, Johan Hovold <johan@kernel.org> wrote:
> On Fri, Feb 14, 2025 at 02:16:14PM +0100, Geert Uytterhoeven wrote:
> > On Fri, 14 Feb 2025 at 13:53, Johan Hovold <johan@kernel.org> wrote:
>
> > > I didn't add a CC stable tag since this currently works, but I still
> > > consider it a bug to call these helpers unconditionally when not using
> > > runtime PM.
> >
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >
> > > [ And during rc1 these callbacks were suddenly called and triggered a
> > > NULL-pointer dereference as you know. [1] ]
>
> > > [1] https://lore.kernel.org/lkml/Z6YcjFBWAVVVANf2@hovoldconsulting.com/
> >
> > Thanks, that was the context I needed to raise review priority ;)
> >
> > Perhaps Reported-by: and Closes:?
>
> The glitch was only temporary this time and the immediate issue was
> addressed by Rafael's partial revert in rc2:
>
>         https://lore.kernel.org/lkml/6137505.lOV4Wx5bFT@rjwysocki.net/
>
> (and which has these tags).

OK.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

