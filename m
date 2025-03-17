Return-Path: <linux-pm+bounces-24148-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C268A64AE1
	for <lists+linux-pm@lfdr.de>; Mon, 17 Mar 2025 11:52:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C13A17463A
	for <lists+linux-pm@lfdr.de>; Mon, 17 Mar 2025 10:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB90225A22;
	Mon, 17 Mar 2025 10:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lSpWpmpI"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EEC6221730
	for <linux-pm@vger.kernel.org>; Mon, 17 Mar 2025 10:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742208686; cv=none; b=j40F9IdmvlnWuvHt7wrR+JVGs+thlEp5LYcQDT3UJsFA+qaKPLYwAj9lZOT2ixjXa48F8AgK5z0OA/GI5xGBneV9HLfpmcz4hO6l+eKQnvlHTlcwnZnkBna4ozPh2PpkTpKKJ1SWq2lB0U+A2N8jksmJqnYhL05VOfpucPiUMmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742208686; c=relaxed/simple;
	bh=oMZ2yf11cn6QsFjSCpGR+HdSkwBNuHuHfa6xY5WzLS8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eIwl4x9RKk5iH34FSKnvBOA2xXiGvNh8XqlusrvMPchZloNGRilsGYdS8l97PF8U6g+kW5DtDee5yfg3tpGJQVTXBlIjPoffFtIcdcqqiQzHk7+HpB39/CYSJXgw6Y2kdixEupOMoruBwPRh7dwx22PbOnCbOh6LtWr2TpBSboY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lSpWpmpI; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e63504bedd0so2785827276.0
        for <linux-pm@vger.kernel.org>; Mon, 17 Mar 2025 03:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742208684; x=1742813484; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hhHd7SXnwkBnjLxo83dsWFNVVc7WEn7JrzvB0bh3I1s=;
        b=lSpWpmpIM8Gp41D655wMruszhCql4PtB6XaDHbR0ifcyyxaL1NqZjEDDazr4WK9GDX
         dYmRnkPb0htV8lCeWlPIYtJPtPUhek7JCIq1wlpwKXm659YGBn+aa/yRa2Yv32z6ka5s
         CUIbpt0x523VNEaCTU2Tre0DuZ3b9K6UihCj8kg45aTnCadAmB7/LfMhtwtW0u8k0ry8
         zPcAO/QIHG7lrMLbJayaQuv1HGRKu62JWI54YyiNif6OpqFomgp1je9DkU8KWkDk9Bkl
         +2CabNSc/Zgkrogfk3XRsQUmQHzC8AGTGwWhiHZayWAMWP9G5hW+OTNrl+Eo5oyVWQyF
         isWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742208684; x=1742813484;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hhHd7SXnwkBnjLxo83dsWFNVVc7WEn7JrzvB0bh3I1s=;
        b=gVssDVvMDwVpI7CmOtZOaDQTb6DgxxKn2CfPdUaUEfUZrTVBBFKf5uhjpAl06Bu8iC
         yf/EFt9rA1V0OOqPnyOLqfyCiMe/R9vIedOLbRC+0RRToCWK+9Dp2RXnyXt1PsWnbFDr
         KW1SZ3Js+Ff7szEQu4i5yPjzEhjG11VVa0HfE1p54kwLhbwweYdcWlTh7hhhMiP8Q8il
         xEG0jksJDRFxAsb4fUJfu/6WDm3U8tB5bOmkvyhGtkljahzLmQ7h4riFnzBkjpI8ZXnw
         XpMakE6Hl85bYT0nuL2HuJ7FCl7465MugDpiaJ1AmmDHW5iCBqp+03SLkyzLmAR4CE+n
         QYqw==
X-Forwarded-Encrypted: i=1; AJvYcCWqUaF9uY2/AhHYNSGZhpwrsMSHxxpy3FePiRMG+3rR2dqce5tC0FsW/BBWzyqtX3nBEJp/QavtQQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxR8SfyvuwyEMZEpYNVycDN5K0iOLY27p9fwqviQ+Wfm2c61aBi
	OaMEpbWmFtPAVWcJgIFLASvxSkHZL63lsAlIjska6vBIDx5oWg2lHjwsrqv/+XcCkSvVS5b48Oi
	WtzEatvdIrwwxnzj/USZkePNxaO4J2mK8mRes9g==
X-Gm-Gg: ASbGncsPfTrm+ikusYIGR9k60dKzBIRwdg0wDfevidcJkbhLilv48VYxd/Dp65yy9bn
	e7gFft/nXldZ+Q/T8xiQOLBA4NG74hUmAoGOLQvSZg/JRwNZsp82j6i/D4h1O3SlV+Ox9ZW9l8E
	GsRWOH+LX14LK3uCi13wRjzqkyN/I=
X-Google-Smtp-Source: AGHT+IEe40CfksyDI5mdSQUSHhqAslmj6SGjaz3DQ4bTsoYnRMhPf4eCW4qJvzXcD+bNgB+yF6CSG5NQVgbkPysQZfM=
X-Received: by 2002:a05:690c:b8e:b0:6f7:5605:c62b with SMTP id
 00721157ae682-6ff4600ebd2mr140912807b3.27.1742208684308; Mon, 17 Mar 2025
 03:51:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250314154834.4053416-1-arnd@kernel.org>
In-Reply-To: <20250314154834.4053416-1-arnd@kernel.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 17 Mar 2025 11:50:47 +0100
X-Gm-Features: AQ5f1Jr6iktPjJh5-3SyBgHuMVQK2t5ir32zhMU3Ip0MrgbDCFUExx4K6sMmMQQ
Message-ID: <CAPDyKFrBfoMpGxnYM1g4M2+LViy8OAtogLL9swUFQfhhm9Ge1Q@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: thead: fix TH1520_AON_PROTOCOL dependency
To: Arnd Bergmann <arnd@kernel.org>
Cc: Drew Fustini <drew@pdp7.com>, Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, 
	Michal Wilczynski <m.wilczynski@samsung.com>, Arnd Bergmann <arnd@arndb.de>, 
	linux-riscv@lists.infradead.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 14 Mar 2025 at 16:48, Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> Kconfig treats the dependency as optional, but the header file only provides
> normal declarations and no empty API stubs:
>
> ld: fs/btrfs/extent_io.o: in function `writepage_delalloc':
> extent_io.c:(.text+0x2b42): undefined reference to `__udivdi3'
> ld: drivers/pmdomain/thead/th1520-pm-domains.o: in function `th1520_pd_power_off':
> th1520-pm-domains.c:(.text+0x57): undefined reference to `th1520_aon_power_update'
> ld: drivers/pmdomain/thead/th1520-pm-domains.o: in function `th1520_pd_power_on':
> th1520-pm-domains.c:(.text+0x8a): undefined reference to `th1520_aon_power_update'
> ld: drivers/pmdomain/thead/th1520-pm-domains.o: in function `th1520_pd_probe':
> th1520-pm-domains.c:(.text+0xb8): undefined reference to `th1520_aon_init'
> ld: th1520-pm-domains.c:(.text+0x1c6): undefined reference to `th1520_aon_power_update'
>
> Since the firmware code can easily be enabled for compile testing, there
> is no need to add stubs either, so just make it a hard dependency.
>
> Fixes: dc9a897dbb03 ("pmdomain: thead: Add power-domain driver for TH1520")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/pmdomain/thead/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pmdomain/thead/Kconfig b/drivers/pmdomain/thead/Kconfig
> index c7a1ac0c61dc..7d52f8374b07 100644
> --- a/drivers/pmdomain/thead/Kconfig
> +++ b/drivers/pmdomain/thead/Kconfig
> @@ -2,7 +2,7 @@
>
>  config TH1520_PM_DOMAINS
>         tristate "Support TH1520 Power Domains"
> -       depends on TH1520_AON_PROTOCOL || !TH1520_AON_PROTOCOL
> +       depends on TH1520_AON_PROTOCOL
>         select REGMAP_MMIO
>         help
>           This driver enables power domain management for the T-HEAD
> --
> 2.39.5
>

