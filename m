Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7DFC2C192
	for <lists+linux-pm@lfdr.de>; Tue, 28 May 2019 10:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725943AbfE1Ip1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 28 May 2019 04:45:27 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:36816 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbfE1Ip0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 28 May 2019 04:45:26 -0400
Received: by mail-lf1-f66.google.com with SMTP id y10so13913808lfl.3
        for <linux-pm@vger.kernel.org>; Tue, 28 May 2019 01:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1VOmEm5K04vWbQ2l+72yNvPSeFo3+7LnA906Ryblkpw=;
        b=WXO/EwKP8KEJ++Jhoxlga+tHjsb5QQqMf2XP9NljzGGYqXky3VPzeSCXM1wHpQc4jJ
         +cjmkbygR1VCuemCziTSsOypdaIcgTUPTOmKdK8iApgWH5Pf+p9q8FpM1vaDPg+NbRMg
         rDKSbmrhANR0G0+waRI280Qgz0RMyEJ07u0HRONb7lgseklCe0ZDVV8nqi1zmsQ4ur55
         85CNkY2nl5Y9Gu1q7LtKgYLCK7kO88S7FC0OyrAQGJp9QgUSdsR3bzPLrgdl96CMyQuk
         idbf8wk4O1FA+iaQWUyc5Hpio2p765424/rjgGRpgjZJjogLOfRMa6UCpNPI8xC+1zJy
         q63g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1VOmEm5K04vWbQ2l+72yNvPSeFo3+7LnA906Ryblkpw=;
        b=CqBSstw5Qqt9xDuWlBgoX1ZCvu4IFnTe7VDe4eGntU08b1M6LjXxYWqhOycYJ9H8Fd
         sZFlAUGVr6l7ntv6K364v93k3T5Rw6iVBE1GEhly9d1WWLzdGd+UZBOoljhIl2TkdnD1
         APq0vOrQYd+fXNC4NW5sQf3N0B9P18bHlzEGmKac3JO30LW05o9mifLLbE2Zj8amsGQe
         +LfCKegLsoEsarGU80DDloXuQ4/d3/+izdAtnlX80OjiNywB2ioES8ZvAZ28QnN/W3c0
         orT0l/Af3QN8Snmm0NgtMXzavhl8sGoJb7suSwQPbRswLeolhb/FPI18zmQg/QucQiEO
         1ZxQ==
X-Gm-Message-State: APjAAAXPKkLv8dolrnqbXudOoKqG3ZCsH6C7hUabp6OP7huSQePWtQqF
        4UZ77lucnyT6ufKzkLJ6LFM4PzXQZ41ryv+SG4VyOw==
X-Google-Smtp-Source: APXvYqxTvYIP1dmooWeXzZi4SJCWIlRrpTF/nExWAU3fqYB71spv0WzoKeq+wsuMB/CY94xrgHl2E12zlzb5qJiatJk=
X-Received: by 2002:ac2:429a:: with SMTP id m26mr3232015lfh.152.1559033125238;
 Tue, 28 May 2019 01:45:25 -0700 (PDT)
MIME-Version: 1.0
References: <5cec74e8.1c69fb81.37335.9d7b@mx.google.com> <0edab48f-06e5-9ed8-09be-7c9976ae1afb@collabora.com>
 <CAMuHMdUF1Csi1ZMccOj=kurijMLcA6G+TP_spsE+fnMvZR71Vw@mail.gmail.com> <de92e3bd-70e8-fcba-3c88-c04170704e7b@collabora.com>
In-Reply-To: <de92e3bd-70e8-fcba-3c88-c04170704e7b@collabora.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 28 May 2019 10:45:13 +0200
Message-ID: <CACRpkdb-Dv614V7STLRMpiLkmb_7NVyKnh2oUi=7Rx366tmZ-A@mail.gmail.com>
Subject: Re: linusw/for-next boot bisection: v5.2-rc1-8-g73a790c68d7e on rk3288-veyron-jaq
To:     Guillaume Tucker <guillaume.tucker@collabora.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Mark Brown <broonie@kernel.org>,
        Matt Hart <matthew.hart@linaro.org>, mgalka@collabora.com,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, May 28, 2019 at 10:36 AM Guillaume Tucker
<guillaume.tucker@collabora.com> wrote:

> > Can't you mark this as a known issue, to prevent spending cycles on the
> > same bisection, and sending out more bisection reports for the same
> > issue?
>
> Not really, so I've disabled bisections in the linux-gpio tree
> and a few other maintainers' trees for now.  I'll see if we can
> come up with a more systematic way of suppressing bisections in
> similar cases (i.e. the issue has been fixed in mainline later
> than the base commit for the branch being tested).

I think this is what the zeroday autobuilder does because
they never seem to show this problem. Thanks for looking
into it!

Yours,
Linus Walleij
