Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD212E0E8C
	for <lists+linux-pm@lfdr.de>; Tue, 22 Dec 2020 20:10:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725811AbgLVTKz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Dec 2020 14:10:55 -0500
Received: from mail-oi1-f169.google.com ([209.85.167.169]:37768 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbgLVTKz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Dec 2020 14:10:55 -0500
Received: by mail-oi1-f169.google.com with SMTP id l207so15841564oib.4;
        Tue, 22 Dec 2020 11:10:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qJcLuqhGyTdulZyHvFUwRf4VUU/U5lmTCF6MQyRDs2g=;
        b=GZfajE4JXKnGt7PAHeNTLu+v2lfvCBncLCp5BlV/iJdsSjGGRxJx8eKsYQOP1LFme+
         ICeS3fvnTtMqohUyG9fmySxElPVFx82ok/CiqXDK5ST5f2HpzbAH2d/cDtMdt0iw2+Zn
         VQtnYPAS917OvxxH4Ztr0R22mNi9uED9W9pUBEBqhLSMzgGYErsyfI0y4WSXOnYQAxfF
         RYGIUnpzYx+zkCRWYMASU+P1Cxl476YSpEIwS2z+yx30ntCc6OEndiikM6LfxxMSnhuE
         JLXTQsuv2idx4MummYrMU+mFPoK3iyEeDLaPyk9w3xxqRwaxy7CInfbkU3u6VKatOfSY
         nv+A==
X-Gm-Message-State: AOAM531wVmdkrAhhT9aa3I0c2Uf4y/retFYu4aKwWdPgVhNC1M00kwag
        fuHoKot7/jSPsOLlirkLgy2mJ6Y4S2RCGIfX1NI=
X-Google-Smtp-Source: ABdhPJxIYc4zK08MtEYs62IqavskxUUN8yV3pd/5j8oRAIkj9unjY1mocXJ73PQVKyOWwTXy+PWdKomrjkOYp/vtwRw=
X-Received: by 2002:aca:4892:: with SMTP id v140mr15360311oia.71.1608664213995;
 Tue, 22 Dec 2020 11:10:13 -0800 (PST)
MIME-Version: 1.0
References: <20201217071501.31267-1-lukas.bulwahn@gmail.com>
In-Reply-To: <20201217071501.31267-1-lukas.bulwahn@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 22 Dec 2020 20:10:03 +0100
Message-ID: <CAJZ5v0gC_SLBvSsGC=1OJ-uNEVPC=JLwELEZKj=LKoQkoOuEkQ@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: include governors into CPU IDLE TIME
 MANAGEMENT FRAMEWORK
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>,
        Pia Eichinger <pia.eichinger@st.oth-regensburg.de>,
        Joe Perches <joe@perches.com>, kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Dec 17, 2020 at 8:16 AM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
>
> The current pattern in the file entry does not make the files in the
> governors subdirectory to be a part of the CPU IDLE TIME MANAGEMENT
> FRAMEWORK.
>
> Adjust the file pattern to include files in governors.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> applies cleanly on current master and next-20201215
>
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 952731d1e43c..ac679aa00e0d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4596,7 +4596,7 @@ B:        https://bugzilla.kernel.org
>  T:     git git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
>  F:     Documentation/admin-guide/pm/cpuidle.rst
>  F:     Documentation/driver-api/pm/cpuidle.rst
> -F:     drivers/cpuidle/*
> +F:     drivers/cpuidle/
>  F:     include/linux/cpuidle.h
>
>  CPU POWER MONITORING SUBSYSTEM
> --

Applied as 5.11-rc material, thanks!

>
