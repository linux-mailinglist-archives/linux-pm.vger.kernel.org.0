Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C4D979F4FD
	for <lists+linux-pm@lfdr.de>; Thu, 14 Sep 2023 00:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjIMWbC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 Sep 2023 18:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjIMWbB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Sep 2023 18:31:01 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CF06A8
        for <linux-pm@vger.kernel.org>; Wed, 13 Sep 2023 15:30:57 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-59bdad64411so3523797b3.3
        for <linux-pm@vger.kernel.org>; Wed, 13 Sep 2023 15:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694644256; x=1695249056; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LpRvRmdLKZN1fAsXTvuEC4vXsjz/GIuJNG6GTfaK4Ls=;
        b=H/XXKiyBFmC3DjUfhhMSTu2FfYPEz20qWSft1OvCJyWduj3hVheOD3SC78VLrHdTrH
         QypKvoTJfTi+f7wyW4kTwOkQSZsdpL5trFoKmYvEVZdBvgqc21XECUtkI++2qWL+Pf0G
         5cgDjWITWWazyr4Y/LFjLVnhZ04NouP2AK7XVnNupF4RjAH0Tw5TewhRhZlMd75a1I7R
         FFciOnPSiYz+KOVhn5FE7/MlD+yX5XglTw3eIyFMo24lW79XPjU5v0wxiHvlSrXLg+d1
         5yNzWX6Ajy6r8rsAbrhs2VXwdczStoYy9yTYopqXrGrMJOtta7EL0GTpNYOD40MLExVG
         RS6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694644256; x=1695249056;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LpRvRmdLKZN1fAsXTvuEC4vXsjz/GIuJNG6GTfaK4Ls=;
        b=lv8aH74x6R9Md5JqVALy2X2hZFAAQ1Tby9SjecPvgmQAvSlZDlmAJQhiQHDgpuhV+t
         sGQniYPnO6SY0/41+pVfEcKpaJZei6eDP1ZhsFJLn8QqOWjDY2XJ8gTXrRUh9MFJkUc3
         39G6zEKbZ12caDZgZm0vTYaon2zSIymXGBAcoHdQbkvoYpUetIuZgKLjTIVnXa4RSZYF
         2QlqYVU65rYg+jQ94L9kBjg6sxVDmYfFGBUtAgc03tAJ2sCF8UfvYsf15yRJ+F2LN7Uy
         aEw22pa4wvFqC+IOfoWnmmr30SoP831gGwrL6EbaiMTP+Fl8rtDwUrD2rb8FK5W/rMrR
         Mlrg==
X-Gm-Message-State: AOJu0YwErsrdXQ6+CKCjQHmj3I5oZr32j1esksf5BSHnzyWQX+cP6Jiu
        SSVMbfYPeSkGrnPoUcKMS3VRtLASvmJPreNG1yEWjA==
X-Google-Smtp-Source: AGHT+IEg5emrh3Qk7P/wBxCbLwpiY1lTtDrRo47SLgbxFH5mT1OakFbaAVGWO+TMZ4ICQLGHbBFMooRRI5AfjrnsXWk=
X-Received: by 2002:a25:8389:0:b0:d7a:c527:38cd with SMTP id
 t9-20020a258389000000b00d7ac52738cdmr3460613ybk.63.1694644256645; Wed, 13 Sep
 2023 15:30:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230913-bloomers-scorebook-fb45e0a2aa19@spud>
In-Reply-To: <20230913-bloomers-scorebook-fb45e0a2aa19@spud>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 14 Sep 2023 00:30:20 +0200
Message-ID: <CAPDyKFoENVp7+VjKkPpJWDecowxYD=QM6TSa6HjyzOZ=z7r81w@mail.gmail.com>
Subject: Re: [GIT PULL 0/5] Missed starfive pmdomain changes for v6.6, now for v6.7
To:     Conor Dooley <conor@kernel.org>
Cc:     Conor Dooley <conor.dooley@microchip.com>, arnd@arndb.de,
        changhuang.liang@starfivetech.com, jiajie.ho@starfivetech.com,
        linux-pm@vger.kernel.org, linux-riscv@lists.infradead.org,
        robh@kernel.org, walker.chen@starfivetech.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 13 Sept 2023 at 15:56, Conor Dooley <conor@kernel.org> wrote:
>
> From: Conor Dooley <conor.dooley@microchip.com>
>
> Hey Uffe,
>
> Here's those missed changes in patch form. I figured it might be a bit
> easier this way given the name of the subsystem is in flux, doubly so if
> you'd like to put the header change of Rob's on fixes.

Not sure we really need to queue up patch 1 for fixes - or is it
fixing a real problem for us?

>
> I had this out for LKP last night, seemed to get a clean bill of health,
> before I rebased it on top of the new name this afternoon, and ofc it was
> in linux-next on top of v6.5 for quite a while...
>
> Thanks,
> Conor.
>
> CC: arnd@arndb.de
> CC: changhuang.liang@starfivetech.com
> CC: jiajie.ho@starfivetech.com
> CC: linux-pm@vger.kernel.org
> CC: linux-riscv@lists.infradead.org
> CC: robh@kernel.org
> CC: ulf.hansson@linaro.org
> CC: walker.chen@starfivetech.com
>
> Changhuang Liang (4):
>   dt-bindings: power: Add power-domain header for JH7110
>   pmdomain: starfive: Replace SOC_STARFIVE with ARCH_STARFIVE
>   pmdomain: starfive: Extract JH7110 pmu private operations
>   pmdomain: starfive: Add JH7110 AON PMU support
>
> Rob Herring (1):
>   pmdomain: starfive: Explicitly include correct DT includes
>
>  MAINTAINERS                                   |   1 +
>  drivers/pmdomain/starfive/jh71xx-pmu.c        | 139 ++++++++++++++----
>  drivers/soc/starfive/Kconfig                  |   4 +-
>  .../dt-bindings/power/starfive,jh7110-pmu.h   |   5 +-
>  4 files changed, 117 insertions(+), 32 deletions(-)
>

The series applied for next, thanks!

Kind regards
Uffe
