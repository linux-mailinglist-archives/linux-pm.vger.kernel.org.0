Return-Path: <linux-pm+bounces-31595-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 846CCB15DAC
	for <lists+linux-pm@lfdr.de>; Wed, 30 Jul 2025 11:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1730565590
	for <lists+linux-pm@lfdr.de>; Wed, 30 Jul 2025 09:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95FF226E71A;
	Wed, 30 Jul 2025 09:56:34 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B654B1ACEDE;
	Wed, 30 Jul 2025 09:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753869394; cv=none; b=eEc2l86Xe49WaKCYBwBYkhpfIWa+UoY5TxWYp5y7iGrU2J5O3Idt0RNnfWAXnghy5jU4Ch26Lye4nI4mtd0FHOT1D8Re1bhVLZnYxSlrZwYfGk6j1KJv+qR8aLyYiuKqRwTHskZolaHoPJLZWqQMlDOJicmpw8BcFkFefQq3W8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753869394; c=relaxed/simple;
	bh=h4QE5Qik/eRs2qOkqSaWcqVaq+Ol8rYWj1Hq3bUKEG4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KoEVqBzwMlTihbKsdS3Ti2wyV+Q+1yCFgZ/isQfbfcwXvwDhDyk/AKqu3s2s7Tv9WrCX5BJ/nGflpjy5dGE6BFGDF9F40ziOkMD+PU/M3j7/bbohZylKzArIUZHUioEYT7jx4wgjobn7jmAcnlyhSM87YSbHKmBwlxJEl0Rrx2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-4e7fc3309f2so1908267137.2;
        Wed, 30 Jul 2025 02:56:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753869391; x=1754474191;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AISXCkdyfWizizwGG/lMEnAGITAartWfZjVCOPp8Btc=;
        b=rJGgMqQU2yYjuAo55Qp9Uzzzrwq6O6oBqqGZH8Q0IvzIaCjXW3f0DMmIMQ/8uNR89b
         CjlzVEJo7KoWJYfGA71O2hSKpqvRCsrg4lKbbqafOAvD+zZlWISNrQjumNUDz5hpHoFo
         18xnRDBoSGRnW9/lYgX1ShoIgRCUFgEvegDumFco27KJiXI5W1724ex/ZdmLW1tO00YB
         OjMD6aJWKGVXIb9mvy6lVE/Ccp1RT3IOLw0Nh9AB1VVPQwY8arv0p2+VZDqmG6dHzYDI
         hLsvFdWJCGxm3TXg7NhlBDiMOR21jo7MQctqywWwdBgwUvkJ2mvDHPIOTfYYVaGFfFJo
         WSsQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1GQ69lyRE/s90o0YyP1G9M3OUWcKDnoOtOfQJMjugXPxbKv+vGmrp2hOd2ijb37peEqh0hNEIpetl1q+nl66a2uY=@vger.kernel.org, AJvYcCUKysKbI7caDBL3mC/A7QpUldWokY9InEfV+A3+tUeU/eLHp5ybgkc5YPFEqnq4hG4iklic0zFR89Q=@vger.kernel.org, AJvYcCXI8vPc/AjQUIIiH+TMysJlD+28p6NtEwFi46ywgsnzXc51BA3xBf5pV3xYc2IF+VN8plONOH7J9oprL/4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyiAwHH1taDB0kdPhxqF6nMJl9DetEYRwBLIAkEGk5luYiIGOF
	upFq0uP08gwEMSX5Y7g+xzMXppPjU4FY2rDDfrGPRye6TpDet2///17vHlfI159e
X-Gm-Gg: ASbGncuiPRugzylunD9hxeRhzeWGm/DDH2Ob4AwxiPve6VfetZGuraybWSeROjuQ3EN
	GnWwpCCkEGlG0BWyU9B4Zw+vBHNdx7HTSWX4Oe8Z+OVZKVeFhLZ/BHn7q/xt94hPWaeB5EZI7QX
	Vkn7ON4l2pL0ufhEaAwtLB25ixkd0IJlwPdIAM86MJm48G43dZVAuxhvmeMO+tGskWOKl1jYRXO
	cMVrczKGICsWzoh/nDy2yyKEfADSMS5qtJ/mlXoIj6P6QhaMitVWL6p89+uyPdifPR2dT85wSyG
	n8r8Nks0RiZ0FTRuXY+ee/jWFi1x52Cn3pn5+TCxhu1tgR2skzASbg0W+/Y3CNfCm9ZnewqEGiV
	O1wAsj90bliUV9AQNoNwi1jsVAtZtfwWgfhyi/M+oDcsZGKCX0fSSAGxCv7c9
X-Google-Smtp-Source: AGHT+IGsULorRTe6vAGA4MMFatdhHfaW8cHQeGwpRlcYZeLlgexo++dF4pJnagGIhF1AdKEOdR89GA==
X-Received: by 2002:a05:6102:3053:b0:4fb:142:f4d3 with SMTP id ada2fe7eead31-4fbe8910b7cmr1331479137.25.1753869391238;
        Wed, 30 Jul 2025 02:56:31 -0700 (PDT)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com. [209.85.222.41])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4fa46d08f92sm1978484137.3.2025.07.30.02.56.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 02:56:30 -0700 (PDT)
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-884f7d29b85so1516442241.1;
        Wed, 30 Jul 2025 02:56:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVLeCJhb3tHQxpWwe0zksb8WT1tQmv6lctnsd6iFHcIShqkCHB6C00N93syneDna+296qbpvAQ4/5ZUfxU=@vger.kernel.org, AJvYcCWe22A4ZUxeigMvGaBMgAu4VUNfAVFZyTiolm8K8s8xIvVU/eVoJqLycfmXYtPzWlRZMJxfjG+dVTE=@vger.kernel.org, AJvYcCXsEkgbhbt35OncxVvP31l7t8FTfGaI8d8XG5/NjtacPLLV3wSe18IMwzf5e5HH8oqA0xEs8vr5XA0PmZLZsiF99WI=@vger.kernel.org
X-Received: by 2002:a05:6102:6488:10b0:4fb:f31a:98ce with SMTP id
 ada2fe7eead31-4fbf31a9e23mr303837137.6.1753869389838; Wed, 30 Jul 2025
 02:56:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250701114733.636510-1-ulf.hansson@linaro.org> <CAPDyKFr=u0u2ijczExkntHK1miWZ6hRrEWBMiyUwShS3m6c29g@mail.gmail.com>
In-Reply-To: <CAPDyKFr=u0u2ijczExkntHK1miWZ6hRrEWBMiyUwShS3m6c29g@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 30 Jul 2025 11:56:18 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX1BacUfqtmV8g7NpRnY9aTdL=fh+jC7OryMLz4ijaOCg@mail.gmail.com>
X-Gm-Features: Ac12FXyBxoyf0eZjZq4tsf22xBIlBFOx02dopJh05JbQN3Bvqm8lfaYDOjqls6g
Message-ID: <CAMuHMdX1BacUfqtmV8g7NpRnY9aTdL=fh+jC7OryMLz4ijaOCg@mail.gmail.com>
Subject: Re: [PATCH v3 00/24] pmdomain: Add generic ->sync_state() support to genpd
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Saravana Kannan <saravanak@google.com>, Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Michael Grzeschik <m.grzeschik@pengutronix.de>, Bjorn Andersson <andersson@kernel.org>, 
	Abel Vesa <abel.vesa@linaro.org>, Peng Fan <peng.fan@oss.nxp.com>, 
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, Johan Hovold <johan@kernel.org>, 
	Maulik Shah <maulik.shah@oss.qualcomm.com>, Michal Simek <michal.simek@amd.com>, 
	Konrad Dybcio <konradybcio@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Hiago De Franco <hiago.franco@toradex.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Ulf,

On Wed, 9 Jul 2025 at 13:31, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On Tue, 1 Jul 2025 at 13:47, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > Changes in v3:
> >         - Added a couple of patches to adress problems on some Renesas
> >         platforms. Thanks Geert and Tomi for helping out!
> >         - Adressed a few comments from Saravanna and Konrad.
> >         - Added some tested-by tags.
>
> I decided it was time to give this a try, so I have queued this up for
> v6.17 via the next branch at my pmdomain tree.
>
> If you encounter any issues, please let me know so I can help to fix them.

Thanks for your series!  Due to holidays, I only managed to test
this very recently.

Unfortunately I have an issue with unused PM Domains no longer being
disabled on R-Car:
  - On R-Car Gen1/2/3, using rcar-sysc.c, unused PM Domains are never
    disabled.
  - On R-Car Gen4, using rcar-gen4-sysc.c, unused PM Domains are
    sometimes not disabled.
    At first, I noticed the IOMMU driver was not enabled in my config,
    and enabling it did fix the issue.  However, after that I still
    encountered the issue in a different config that does have the
    IOMMU driver enabled...

FTR, unused PM Domains are still disabled correctly on R/SH-Mobile
(using rmobile-sysc.c) and on BeagleBone Black. Note that these use
of_genpd_add_provider_simple(), while all R-Car drivers use
of_genpd_add_provider_onecell().  Perhaps there is an issue with
the latter?  If you don't have a clue, I plan to do some more
investigation later...

BTW, the "pending due to"-messages look weird to me.
On R-Car M2-W (r8a7791.dtsi) I see e.g.:

    genpd_provider ca15-cpu0: sync_state() pending due to e6020000.watchdog
    renesas-cpg-mssr e6150000.clock-controller: sync_state() pending
due to e6020000.watchdog

ca15-cpu0 is the PM Domain holding the first CPU core, while
the watchdog resides in the always-on Clock Domain, and uses the
clock-controller for PM_CLK handling.

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

