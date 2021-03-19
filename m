Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F23D341EA1
	for <lists+linux-pm@lfdr.de>; Fri, 19 Mar 2021 14:44:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbhCSNoL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Mar 2021 09:44:11 -0400
Received: from mail-oi1-f172.google.com ([209.85.167.172]:46735 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbhCSNn5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 19 Mar 2021 09:43:57 -0400
Received: by mail-oi1-f172.google.com with SMTP id m13so4798248oiw.13;
        Fri, 19 Mar 2021 06:43:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5ZzDN7D8RGi6ZW/yyDxL9t3qkp73cKM3VEN+oqEJhWs=;
        b=B5r4T+p6cmbKqsHrtGZ3MtMnMC2RtPe6EHk8kcJC3Uffn892M9T5S0qNXqdtzR21XW
         qgPNJSwZEztAzQv5NyLBLCw1Xbk5UGcuH8m5KAcAYXE+jpS2+qz3gRv6R+cC3JukRZNJ
         bFzkiOMQRibUeK9DPDiiLZTFlHNSuI8bbS20/YQVU/TRX2aUfMf4Q1Ba0TfJRCbygcMY
         FAZIJGZ8TfxoHsuIZcG77z8hlir96BZ0uMVCiymB9h8EkPdGUzJSS576Kgi3r1htr1lW
         /6TAwFiTDa4VmieLV0UckZl3H9rvuolOv7n4A5G1l/hLjNLE4FJDGPn0I767LmgJfRRr
         bV7w==
X-Gm-Message-State: AOAM533kQi9oOOye9ud7UHjYJqy0s3XLDl4MZ9xoKx+K6V1Jc1bRAtc1
        mznBnue+xUmjUtevOwGe5h+XqzMN18v6VSyVujc=
X-Google-Smtp-Source: ABdhPJz8nqjw9vDEvVfTofW90lxMCMuOlFEgkt/GVdm7SinSp9IA6/mY8Z6qjCcAJZhh8pbKtwr38DY3jf8vyY2jnLI=
X-Received: by 2002:aca:c4c5:: with SMTP id u188mr1079430oif.71.1616161437306;
 Fri, 19 Mar 2021 06:43:57 -0700 (PDT)
MIME-Version: 1.0
References: <5448054.DvuYhMxLoT@kreacher> <4304785.LvFx2qVVIh@kreacher> <CAPDyKFpU45vQMB_gdGnodV1=-fORJgtG3VXpeLaKvw4p5vMZhQ@mail.gmail.com>
In-Reply-To: <CAPDyKFpU45vQMB_gdGnodV1=-fORJgtG3VXpeLaKvw4p5vMZhQ@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 19 Mar 2021 14:43:42 +0100
Message-ID: <CAJZ5v0iCSrN0Nf=2zfz=9GJKip8JY4MH1_kMS1A_MX3qmeZVDw@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] Revert "PM: runtime: Update device status before
 letting suppliers suspend"
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        "elaine.zhang" <zhangqing@rock-chips.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Mar 19, 2021 at 2:31 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Thu, 18 Mar 2021 at 19:15, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >
> > From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> >
> > Revert commit 44cc89f76464 ("PM: runtime: Update device status
> > before letting suppliers suspend") that introduced a race condition
> > into __rpm_callback() which allowed a concurrent rpm_resume() to
> > run and resume the device prematurely after its status had been
> > changed to RPM_SUSPENDED by __rpm_callback().
>
> Huh, the code path is not entirely easy to follow. :-)
>
> Did you find this by code inspection or did you get an error report?

There was a bug report that caused me to look at the code once again.

> > Fixes: 44cc89f76464 ("PM: runtime: Update device status before letting suppliers suspend")
> > Link: https://lore.kernel.org/linux-pm/24dfb6fc-5d54-6ee2-9195-26428b7ecf8a@intel.com/
> > Reported by: Adrian Hunter <adrian.hunter@intel.com>
> > Cc: 4.10+ <stable@vger.kernel.org> # 4.10+
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Thanks!
