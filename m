Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8E72DA0AA
	for <lists+linux-pm@lfdr.de>; Mon, 14 Dec 2020 20:37:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502063AbgLNThS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Mon, 14 Dec 2020 14:37:18 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46483 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502360AbgLNThP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 14 Dec 2020 14:37:15 -0500
Received: by mail-ot1-f65.google.com with SMTP id w3so16911444otp.13
        for <linux-pm@vger.kernel.org>; Mon, 14 Dec 2020 11:36:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=20ZvIWGvWlDrvKEhjMQqg7rXf8wOW07pGgN08di/5mQ=;
        b=rHQrlo0Re5isD8kRVKYEhNqAKkayMvIDB/Ix+p5Zqb6WnZFM9UOpHiZOueMjl8AwuT
         yxgp1xVjVTmKFVlkjzAeNnj1fIuRo63aBND6LoV/waDqV7YWaiJtcv+zdaj7mo/6NZTS
         5zsXdKUbTBjemNnSiy3hs5XJ68lA6vfbkE2TuE19ZvvZqZ+WbK9j4komKzILFNpnzmaY
         CMIU3mr4RKqK11SQMhwH1UCMhzxR2kdrs2N47B2CpdTNncRi7NQbgIK01A+gzE9Jrm6i
         1VOPlrvEbPgNxQZsFrVsnbdpfD/kPuzCvxxdK3uHk/LmvsvrExXAdZimrW7LHoN7WV5T
         3bhw==
X-Gm-Message-State: AOAM532V3lMgq6Eg+WZqoQSkVgsha7Da8dvEeqsfC53aokGJgI6m0X6z
        zp1N30B7LAb5MKXs5Ftk5rUxOVDRZuNdu/VgtbY=
X-Google-Smtp-Source: ABdhPJwfSqt1r/oAg+xDEbKlv5YtXgLcBGqe6VtArEdMnNw5rT4dCid371kzPCASN85r2Tyes/8AJ2fIx+sltsb9fBY=
X-Received: by 2002:a9d:208a:: with SMTP id x10mr19042669ota.260.1607974592837;
 Mon, 14 Dec 2020 11:36:32 -0800 (PST)
MIME-Version: 1.0
References: <20201214113718.boh3z2rpnwitmphd@vireshk-i7>
In-Reply-To: <20201214113718.boh3z2rpnwitmphd@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 14 Dec 2020 20:36:21 +0100
Message-ID: <CAJZ5v0hRwPLORnD-kBugnRUoBkviTpkbZ9iS6dUFBNQAFuEgsA@mail.gmail.com>
Subject: Re: [GIT PULL] cpufreq/arm updates for 5.11
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Dec 14, 2020 at 12:37 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> Hi Rafael,
>
> This pull request contains following updates:
>
> - Fix imx's NVMEM_IMX_OCOTP dependency (Arnd Bergmann).
>
> - Add support for mt8167 and blacklist mt8516 (Fabien Parent).
>
> - Some ->get() callback related cleanups to the tegra194 driver and
>   some optimizations in tegra186 driver (Jon Hunter and Sumit Gupta).
>
> - Power scale improvements to arm_scmi driver (Lukasz Luba).
>
> - Add missing MODULE_DEVICE_TABLE and MODULE_ALIAS to several drivers
>   (Pali Rohár).
>
> - Fix error path in mediatek driver (Qinglang Miao).
>
> - Fix memleak in ST's cpufreq driver (Yangtao Li).
>
> Note that this stat shown by git is incorrect at the bottom, it
> somehow got confused as some of the stuff is based on rc3 and the
> other is based on rc1 (which got applied at rc6). And I didn't wanted
> to play around with patches to hide this.
>
> -------------------------8<-------------------------
> The following changes since commit f943849f720689214abb3930623c31ff91990be9:
>
>   cpufreq: scmi: Fix build for !CONFIG_COMMON_CLK (2020-11-23 10:15:56 +0530)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git cpufreq/arm/linux-next
>
> for you to fetch changes up to c8bb4520543823a9b3da3861304273dc7232e2c7:
>
>   Merge branch 'cpufreq/scmi' into cpufreq/arm/linux-next (2020-12-08 11:22:17 +0530)

Pulled, thanks!
