Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55D563BAA25
	for <lists+linux-pm@lfdr.de>; Sat,  3 Jul 2021 21:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbhGCTnJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 3 Jul 2021 15:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbhGCTnJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 3 Jul 2021 15:43:09 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4331C061762
        for <linux-pm@vger.kernel.org>; Sat,  3 Jul 2021 12:40:34 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id w19so24697830lfk.5
        for <linux-pm@vger.kernel.org>; Sat, 03 Jul 2021 12:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LteJNCSpTKh9xbMe/59RuQkpJr9zFLx0HiImxwfUUxA=;
        b=IFW9WhGy7gFSHI4FBwLNIuzV3jUA75+mJyCK+RSA5ZyehBHPnhfC64M3+hb2OezQrK
         m7MqQccJenLyyKStvWQRZGdBsda0dzcSrb2ZGgtwwhul5AmkAarzV2BaueqXE/xZJGJL
         3JoduOJcq621Gck9Eq6b0+R9WviMs6Jp3URHM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LteJNCSpTKh9xbMe/59RuQkpJr9zFLx0HiImxwfUUxA=;
        b=cLGpSMHmkm4l0gd0AG6H2AL7o5hDxZfBKSSniGkARo+NIL5xaNJ8LQ+FUClxCm473N
         ps/hkHFVnV1lpZ6BqbKayNXQ5WreQvdfWZK2I2MKtmZWdW4PprY5puHoSvnuVnpivkeT
         GX+t/p8N4efQ/Z+DeoW5hq5cUJnZNfSbjSb9i4exkN7EgbGl75b4sfcl3grXSJwV5Epb
         bEumrs0ruXj5rkNUkE+wHm1YucHth8OMJHLDTtF8q5jegt4I80SyKGAOSZHupgGNNeKC
         N2i4+Vmx+khNUefXjA8YzRKyRVZWPaxZ9bYb3ah/tgj9f9b5P+H45hxuSjKCEY6W6gY4
         34wA==
X-Gm-Message-State: AOAM533qCkwlRDzB6qK+RtZ09GawVAfrqsBAerldW2Zw3ZJhAKEQ+yD6
        +VuLDwwXYJRYJDGeMG0oWKZzBs86ZPmlbxlo9N4=
X-Google-Smtp-Source: ABdhPJwPFqeCzxOerne1+h9EdOW2pGBFxuZAk1Ckfk/pl+foyC1bPRtfo8rVL0SnnMCo7IZKgpd9vQ==
X-Received: by 2002:a19:ca52:: with SMTP id h18mr4491313lfj.180.1625341232934;
        Sat, 03 Jul 2021 12:40:32 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id n6sm750634ljc.68.2021.07.03.12.40.32
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Jul 2021 12:40:32 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id d16so24693959lfn.3
        for <linux-pm@vger.kernel.org>; Sat, 03 Jul 2021 12:40:32 -0700 (PDT)
X-Received: by 2002:a2e:a276:: with SMTP id k22mr4368475ljm.465.1625340861140;
 Sat, 03 Jul 2021 12:34:21 -0700 (PDT)
MIME-Version: 1.0
References: <7a9ac752-2c1a-b05f-c5bd-9049c0bdd54e@linaro.org>
In-Reply-To: <7a9ac752-2c1a-b05f-c5bd-9049c0bdd54e@linaro.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 3 Jul 2021 12:34:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgZzeaZb0ByL+zPV1grizuxw2nAnmzU49S7pzV7sPS1Hg@mail.gmail.com>
Message-ID: <CAHk-=wgZzeaZb0ByL+zPV1grizuxw2nAnmzU49S7pzV7sPS1Hg@mail.gmail.com>
Subject: Re: [GIT PULL] thermal for v5.14-rc1
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Linux PM mailing list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chunyan Zhang <zhang.chunyan@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Rajeshwari Ravindra Kamble <rkambl@codeaurora.org>,
        Yang Yingliang <yangyingliang@huawei.com>,
        =?UTF-8?Q?Niklas_S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Finley Xiao <finley.xiao@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Jul 3, 2021 at 9:17 AM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git
> tags/thermal-v5.14-rc1

This does not build for me. And I suspect it never built in linux-next either.

I get

  ERROR: modpost: "tegra_fuse_readl"
[drivers/thermal/tegra/tegra30-tsensor.ko] undefined!
  ERROR: modpost: "tegra_fuse_readl"
[drivers/thermal/tegra/tegra-soctherm.ko] undefined!
  make[1]: *** [scripts/Makefile.modpost:150: modules-only.symvers] Error 1
  make[1]: *** Deleting file 'modules-only.symvers'
  make: *** [Makefile:1762: modules] Error 2

and I think it's due to that commit 1f9c5936b10c
("thermal/drivers/tegra: Correct compile-testing of drivers") which
quite sensibly tries to extend build coverage for the tegra thermal
drivers, but that build coverage doesn't actually *work* outside the
tegra world.

That commit says "All Tegra thermal drivers support compile-testing",
but clearly they stumble at the last hurdle.

I made the decision to just unpull this, not because I couldn't fix
it, but because if it was this untested, I don't want to worry about
all the *other* code in there too.

               Linus
