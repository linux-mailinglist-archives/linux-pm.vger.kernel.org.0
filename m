Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09F072861D4
	for <lists+linux-pm@lfdr.de>; Wed,  7 Oct 2020 17:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727608AbgJGPJl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Oct 2020 11:09:41 -0400
Received: from mail-oo1-f65.google.com ([209.85.161.65]:44977 "EHLO
        mail-oo1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727061AbgJGPJk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Oct 2020 11:09:40 -0400
Received: by mail-oo1-f65.google.com with SMTP id 4so690114ooh.11;
        Wed, 07 Oct 2020 08:09:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/tU2H0QFkhYTEKve8VOdsTfMKldKOBblDMyZRsWaiNw=;
        b=XhGPAwXplZFTkgoiU7CEnPt297iZGudcF+ES9rctHXgCskdCvjp6/2scNHphP0LI5L
         58O635kZ9NRp7XaVqwCNd4C9/LaMgx4QyCHD+nFtDpqGZIVe3bq3cSdJHnZzeS7m9033
         jerO20oEEp2DrH4hoqeFJVcC5BnTTn0q43IqTOim7TKRFFbCmshx8B4hUs38xloyquqU
         qqeOYSAOxMmIgT6rCzAukZPme0aMGc8d+Lo7ZxuZuQhZztqDwfvjuy/uClTLUalu/46i
         lj5Ulw7tH/cZ2xNcu57ABwgPUBaNrBwjrjPmwnhiyOzwcGDczuf2xqo72yceAdnDUi+n
         4EQw==
X-Gm-Message-State: AOAM532Alzpu65E2pPNmeBYAARt6nW50Oj8KeYUKCAwZfnIr1ztUzSYI
        XDAAo2MJydRksPg76LZQObUUThtMP//q87KNBGw=
X-Google-Smtp-Source: ABdhPJy9dvA5ZRc8HWafvq6J0+KdfRaJS99FsDanCpAWyWHqm2179UFrKhlUd89UPv6nsuSGREleX9wA7928u+GuCwM=
X-Received: by 2002:a4a:d44:: with SMTP id 65mr2404239oob.44.1602083379840;
 Wed, 07 Oct 2020 08:09:39 -0700 (PDT)
MIME-Version: 1.0
References: <20201006160516.319830-1-ulf.hansson@linaro.org>
In-Reply-To: <20201006160516.319830-1-ulf.hansson@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 7 Oct 2020 17:09:27 +0200
Message-ID: <CAJZ5v0iNQ51C5WYUy-ZhzpFGMLxSAVV8=xxYBfMX9ia6FOpg1Q@mail.gmail.com>
Subject: Re: [PATCH 0/4] power: avs: Move drivers to the soc directories and
 drop avs
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Nishanth Menon <nm@ti.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Tony Lindgren <tony@atomide.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Niklas Cassel <nks@flawful.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Kevin Hilman <khilman@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Oct 6, 2020 at 6:05 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> The avs drivers in drivers/power/avs/* are all SoC specific drivers that
> doesn't share any code. Instead they are located in a directory, mostly to keep
> similar functionality together. From a maintenance point of view, it makes
> better sense to collect SoC specific drivers like these, into the SoC specific
> directories.
>
> Therefore, this series moves the drivers, one by one - and in the end, it
> deletes the empty avs directory.
>
> It seems best to me, if this can be funneled via Rafael's linux-pm tree. Then
> when going forward, each driver should be managed through the SoC maintainer's
> trees.

That's fine by me.

I'd like to get an ACK from the arm-soc side on this, though.

Cheers!
