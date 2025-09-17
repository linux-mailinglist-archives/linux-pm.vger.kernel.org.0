Return-Path: <linux-pm+bounces-34874-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C0BB800B0
	for <lists+linux-pm@lfdr.de>; Wed, 17 Sep 2025 16:35:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FE4216B1ED
	for <lists+linux-pm@lfdr.de>; Wed, 17 Sep 2025 14:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 924842F066A;
	Wed, 17 Sep 2025 14:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZAzfgnhf"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65CD2D46A4
	for <linux-pm@vger.kernel.org>; Wed, 17 Sep 2025 14:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758119579; cv=none; b=tMMQ0j3hdvScF6bZvF0TM+bkFSLOKJuYIxdiHe9AUjk2JW5/H8tzZJWGUSQzb0Dyi1RfeRdY40peZz9hz9koc3qSveEed2esK57W6loTNFjEATr2QI7yum+EJgxIA20XOHv3XYze4XfY1t57k66V2prSK+yafYrpCSQjNTlifIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758119579; c=relaxed/simple;
	bh=tcnHxortbdFdgmr9duRFABSbgVONmqvd0HPd6fDcn/A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d6wa6ORwvdN0OnSa/2ggGwI8FnLYIzizzYbAheDizxIr8tHgsVX3XY3+jJmwwiE+Mg6attQc8C3KRNOKe9YDDKBcxCeC4VJfxtueumD+zmkLKeKX5q2P+iLmJF8aqgQMP1nmj9s5r8rHfBZfLShOLxxTnR2mYFKRZDnkiY1Xi3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZAzfgnhf; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-ea5c1a18acfso719531276.0
        for <linux-pm@vger.kernel.org>; Wed, 17 Sep 2025 07:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758119577; x=1758724377; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dCz4bFinyR1BieLUIHZQZV0TDdidYv9V2bEcGI7xH7o=;
        b=ZAzfgnhfmlHY3kWDrEgfGpTFDQM5zNLAp4u0yML2KyRy2y6Q+93SKmnEWvz7UEgTWz
         /OcjGzC6pAvm+ddVkNAW9+6YhnW6NQH8JzBVL3qbtFYSLVGQ29mDhQRWIfWJfZrGWLcC
         uQw3fC1w7r70oKqh342UuABIEmEcTD0a4KxehjL+1JoqsUG8pjfQW2C2P3855vWZtMIi
         7LlCwmu5WrBBHAcGh5dIfediBCTeaMJxw6U5DLPItpyZbBq2GNAWTU9ZAPMeIcPoamt2
         QnjFP8rRQf07Oy6+oNw6KkSvrDPLP81G+cRiPcr4p4tnkJi7qYiyJ4W84cCEgHOrDdZs
         423A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758119577; x=1758724377;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dCz4bFinyR1BieLUIHZQZV0TDdidYv9V2bEcGI7xH7o=;
        b=WvES5a8JtaauvBu5U44oN4Nu8FRfUli/ioRKhEUBkfL4+UO7YIYgNt2uCH2mp1A7Rj
         hi0Xg9hg4IP6grB1sOs69bOn/PrAPlEsEg2GvMChdmJKf9AdHGKqno7iF4M7vzKo1ksz
         yWj23tEVDFCyhpvSQV7ixecGIv38QebB4a19aSNrB4xlr6CA6ACgz5JOO4ksMBO9h75v
         +qqCEHhTPwAmoCrbFNPjexd4inTZhnIsTqhU0fsnt/SU4kB3Pwx6jQtc6CHhs1OMQBd9
         3io19YUfH04uQEcn8bwcSnp9ddp8jzVtBDZLaJF6rZpb8s4OYSWhb4YFF7DexylaQ3q0
         xz8w==
X-Gm-Message-State: AOJu0YxCXqCKcWrWCKqYDCdjyhzjA+K6aLGMGJ/TyMOqQ4SgkXlNCF7x
	iWFs6Rj5H/K36y4NADbhNDBvNMAeLswd4PnaD/Tk0y7E5k/4bmMq51JOfBM44lmjTR/33L/LTaX
	3+pkVUujA4LxuoVy76nWXOR7mVTqwt8k8TKyjuLdmDQ==
X-Gm-Gg: ASbGnctEhwozjPxs4M8wH0INQEUHSJgZYSA2NIKhYWQolWDWFDV0bg0gFNijPkTF58C
	UizUFDkLBauQPWXonfyKC9nSlNk9ox/7Rv1YnJDQ1+blMiKQ+qZTOKqX/abILOGKzI/XqscpKBQ
	0W9Q2gnV983EA5lSG1I5rlOz0qIzQa0IPF4GGK0YPvmkIMwd62de2E0SbT5/anrJ0wB9GUaab4u
	oy7UDO1
X-Google-Smtp-Source: AGHT+IGYd75X0Qf3WTxoJJzFk2/YdrBkHI2rWEVx/WssCazdqocK2S+85yiq6AsUYraILKbckm2rz5VkDvdIi7Gceg0=
X-Received: by 2002:a05:6902:124c:b0:ea5:c97c:3182 with SMTP id
 3f1490d57ef6-ea5c97c50bcmr1102726276.36.1758119576502; Wed, 17 Sep 2025
 07:32:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250915083317.2885761-1-mikko.rapeli@linaro.org>
In-Reply-To: <20250915083317.2885761-1-mikko.rapeli@linaro.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 17 Sep 2025 16:32:20 +0200
X-Gm-Features: AS18NWBqAAb3pOa1iLGjs8mbJODRThiYyAWA34gbcKMC5sx254a7Jh6zE5vInCA
Message-ID: <CAPDyKFpR+uueS16P7OZi6-1NVrEyPbizuSnMHWMyROfqzPjarg@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] enable ROCKCHIP_PM_DOMAINS
To: Mikko Rapeli <mikko.rapeli@linaro.org>, Heiko Stuebner <heiko@sntech.de>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

+ Heiko

On Mon, 15 Sept 2025 at 10:33, Mikko Rapeli <mikko.rapeli@linaro.org> wrote:
>
> Hi,
>
> MMC_DW_ROCKCHIP needs ROCKCHIP_PM_DOMAINS before MMC is detected
> on Rockchip rk3399 rockpi4b and similar devices. Make this dependency
> more visible, or the default with ARCH_ROCKCHIP if possible.
>
> v4: fixed Kconfig whitespace, added select REGMAP_MMIO to MMC_LOONGSON2
>     instead of disabling COMPILE_TEST
>
> v3: use "default ARCH_ROCKCHIP" in ROCKCHIP_PM_DOMAINS as suggested
>     by Arnd Bergmann <arnd@arndb.de>, enable more MMC drivers for
>     COMPILE_TEST and remove MMC_LOONGSON2 which doesn't link,
>     remove PM dependency as suggested by
>     Geert Uytterhoeven <geert@linux-m68k.org>
>     https://lore.kernel.org/linux-mmc/aMQv1V49xa_MThGq@nuoska/T/#md2b3252f9dce14f3f79a493c426f2761cba1dc25
>
> v2: changed from "depend on" in MMC driver to "select" as default
>     on ARCH_ROCKCHIP as suggested by Ulf and Heiko
>     https://marc.info/?i=20250912084112.2795848-1-mikko.rapeli%20()%20linaro%20!%20org
>
> v1: https://lore.kernel.org/linux-mmc/20250911144313.2774171-1-mikko.rapeli@linaro.org/
>
> Mikko Rapeli (4):
>   pmdomain: rockchip: enable ROCKCHIP_PM_DOMAINS with ARCH_ROCKCHIP
>   mmc: add COMPILE_TEST to multiple drivers
>   mmc: select REGMAP_MMIO with MMC_LOONGSON2
>   ARM: rockchip: remove REGULATOR conditional to PM
>
>  arch/arm/mach-rockchip/Kconfig    |  2 +-
>  drivers/mmc/host/Kconfig          | 10 ++++++----
>  drivers/pmdomain/rockchip/Kconfig |  1 +
>  3 files changed, 8 insertions(+), 5 deletions(-)
>

Patch 1 applied for next to my pmdomain tree. Patch 2 and 3 applied
for next on my mmc tree. Thanks!

Heiko, can you pick up patch 4 via your Rockchip tree? Or if you
prefer me to pick it, I can funnel it via my pmdomain tree. Let me
know please.

Kind regards
Uffe

