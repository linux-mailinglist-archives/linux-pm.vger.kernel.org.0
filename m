Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D78FD9496
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2019 16:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404209AbfJPO6j (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Oct 2019 10:58:39 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:40578 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404364AbfJPO6j (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Oct 2019 10:58:39 -0400
Received: by mail-qt1-f196.google.com with SMTP id m61so36529606qte.7;
        Wed, 16 Oct 2019 07:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1SJ9O1hv6AGRPvGN3YJyHukSgaXaII1XJ7m1yidoToE=;
        b=fD6M65eaSsiiQNdv+FkaHIcl/CY2CbF2BBQGlxCIVAHC+8eW/DIziv6P+VfZMyy5yt
         zdn+v6yIdpx4/DGpQuM3s/mIhjIdnYEPt2zcSrFShEvSqABOdVbDVFGwUzN3mJF8D2o0
         6z6uMmP37hGBg7pPN+QSz2RGuw14Dro3zJchGztbWHHeR7QaTljkm6rSF271GPRc4bui
         YYAtQUfMdxMrYSI5kUla6Qzirqc/xX+lmlbyXFdl7z50lvV56b+hH9dnJH8PO2kiu0Mv
         +68X7j8WFHDZhCIA3ftg8j+DI7BthBEdUVqFv6gc1a9rb+tK/l5HJZesE9LeKw9e2KAC
         9mHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1SJ9O1hv6AGRPvGN3YJyHukSgaXaII1XJ7m1yidoToE=;
        b=cQrkg0CUIUDYrn6UiF+ElHkAA2GSXm/vN1JViB2Dzx+CCe8LkPAbx9rhFBs5fcb33v
         usDI6gU4yenfBY6G6s/XoqfeCgZseV5/Gpu2ti1c0DhztqpKEsHXO2F5bGPoxusObvsK
         N+EZSO74zgLZbUC8yAhAb+Kv0JU3dIiTTnhfeq8eaD4cIVfEQ0xLj+G7VUO8a32zcbQg
         442W0fdme0T8Emght1NHFYlY2y2wKVCmCkZ+4R5HEPG+FMLHET8Jzrhmgq34d4hmrLjC
         Unlr++9AapxgKiZ4VCjB+hAfhfy4ht8+CTQjuiHtvkGUodomrXzHKY/IwR5vnPdkLJ2j
         gyaA==
X-Gm-Message-State: APjAAAUcYfctuBL5pZl1Zb7bOsZA0ug4PrjZv5znugR7JorSpK5NAD1J
        yqj1uHfDWT7PVqt39P7sL76bu82aihWuaIPvo78=
X-Google-Smtp-Source: APXvYqx16lcsihvARp7EDwvguspXt7bEHTmoYkAFZTfAKC+muGfv2rqx07fp6W1V3Z9DrBXH+0vfcKUeTpnkAC5s86o=
X-Received: by 2002:a0c:c684:: with SMTP id d4mr23370254qvj.148.1571237917418;
 Wed, 16 Oct 2019 07:58:37 -0700 (PDT)
MIME-Version: 1.0
References: <20191015211618.20758-1-digetx@gmail.com> <20191015211618.20758-8-digetx@gmail.com>
 <20191016051802.rrxv56vtvxfm6qqe@vireshk-i7> <13a9ebd6-8dce-0217-d306-defb8eb6fb96@gmail.com>
In-Reply-To: <13a9ebd6-8dce-0217-d306-defb8eb6fb96@gmail.com>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Wed, 16 Oct 2019 10:58:25 -0400
Message-ID: <CAMdYzYoasuEobJLC4RLW_5WCNGnaKtTth0xKov0tUQuDhkX3EA@mail.gmail.com>
Subject: Re: [PATCH v1 07/17] cpufreq: tegra20: Use generic cpufreq-dt driver
 (Tegra30 supported now)
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Oct 16, 2019 at 9:29 AM Dmitry Osipenko <digetx@gmail.com> wrote:
>
> 16.10.2019 08:18, Viresh Kumar =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > On 16-10-19, 00:16, Dmitry Osipenko wrote:
> >> Re-parenting to intermediate clock is supported now by the clock drive=
r
> >> and thus there is no need in a customized CPUFreq driver, all that cod=
e
> >> is common for both Tegra20 and Tegra30. The available CPU freqs are no=
w
> >> specified in device-tree in a form of OPPs, all users should update th=
eir
> >> device-trees.
> >>
> >> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> >> ---
> >>  drivers/cpufreq/Kconfig.arm          |   4 +-
> >>  drivers/cpufreq/cpufreq-dt-platdev.c |   2 +
> >>  drivers/cpufreq/tegra20-cpufreq.c    | 236 ++++++--------------------=
-
> >>  3 files changed, 55 insertions(+), 187 deletions(-)
> >>
> >> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> >> index a905796f7f85..2118c45d0acd 100644
> >> --- a/drivers/cpufreq/Kconfig.arm
> >> +++ b/drivers/cpufreq/Kconfig.arm
> >> @@ -301,8 +301,8 @@ config ARM_TANGO_CPUFREQ
> >>      default y
> >>
> >>  config ARM_TEGRA20_CPUFREQ
> >> -    tristate "Tegra20 CPUFreq support"
> >> -    depends on ARCH_TEGRA
> >> +    bool "Tegra20 CPUFreq support"
> >
> > Google is currently working on the GKI (generic kernel image) project w=
here they
> > want to use a single kernel image with modules for all kind of android =
devices.
> > And for that they need all such drivers to be built as module. Since th=
is is
> > already an module, I would ask you to keep it as is instead of moving i=
t to bool
> > here. Else some google guy will switch it back as module later on.
> >
> > LGTM otherwise. Nice work. Thanks.
> >
>
> Okay, I'll keep the modularity in v2.
>
> Although, tegra20-cpufreq isn't a driver anymore because now it merely
> prepares OPP table for the cpufreq-dt driver, which is really a one-shot
> action that is enough to do during boot and thus modularity is a bit
> redundant here.

I doubt Google will care much, since Android has moved on to aarch64.
Do they even support arm32 any more?
