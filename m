Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 787F57868D
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2019 09:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbfG2HpG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Jul 2019 03:45:06 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46759 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726862AbfG2HpG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Jul 2019 03:45:06 -0400
Received: by mail-wr1-f65.google.com with SMTP id z1so60624423wru.13;
        Mon, 29 Jul 2019 00:45:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XXRHBEMKhef+dnocaNK4nkJJjQSEielvNAr/Iguh9Kg=;
        b=oj40/0/KeLwQngxHjPl2GoeOyasY3k7BCnHrmr3Sg/BR/L9Pn+tnb6MZHyqdaTR2Xz
         sh8XQte4Y6FJ2p5FU+mKAsbI1I+yS4xg7R3qVq7Hw1eGuCCAnWNMbfHjHcmp6IxW5i5U
         ReiTOLdqhbIPAFgvqT/5Esc3bG6tj/4apRNW920+iPQFDx7W+L0+nfvLIdvzZKQaQcn/
         dQHkiUTx7/qnyi4GrdcVakTdK96pb3g/zJ/6STxIH7bRHZxdyYe5Z3VhJC8g27af9s3a
         kBxStTDWN5cxOvhcmooP4hDgZE8+cAsoh2l+CAdlUCmvsALS7P49GbO7hYTxHPYwkmub
         YMSw==
X-Gm-Message-State: APjAAAV2ijiWPjDqF4ZLWIKB/g7CKB65nMqWGez+WO83z9zrF7uZN4fR
        33/FIGKu5ruSHRfydIbmFF1v1Stz0S+5K2f1iFw=
X-Google-Smtp-Source: APXvYqwpm/kijAIS8KFK2eMwQFo1bfr/p+cl9hcwaGna32JrVH4wttc50iYtIsPYz0ZfUBOIYS+MgRm8MWsiqonq7NU=
X-Received: by 2002:adf:f08f:: with SMTP id n15mr34464237wro.213.1564386304195;
 Mon, 29 Jul 2019 00:45:04 -0700 (PDT)
MIME-Version: 1.0
References: <1547808474-19427-1-git-send-email-uli+renesas@fpond.eu>
 <1547808474-19427-3-git-send-email-uli+renesas@fpond.eu> <20190726091325.GA13111@vmlxhi-102.adit-jv.com>
 <20190726094724.GA14913@vmlxhi-102.adit-jv.com>
In-Reply-To: <20190726094724.GA14913@vmlxhi-102.adit-jv.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 29 Jul 2019 09:44:52 +0200
Message-ID: <CAMuHMdXiOBxUDXLcL6R7jHF4DMoH=72yMkSiv-51aV7cw3my9Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] arm64: dts: r8a7795: Add cpuidle support for CA53 cores
To:     Eugeniu Rosca <erosca@de.adit-jv.com>
Cc:     Ulrich Hecht <uli+renesas@fpond.eu>,
        "horms@verge.net.au" <horms@verge.net.au>,
        "khiem.nguyen.xt@renesas.com" <khiem.nguyen.xt@renesas.com>,
        "dien.pham.ry@renesas.com" <dien.pham.ry@renesas.com>,
        "takeshi.kihara.df@renesas.com" <takeshi.kihara.df@renesas.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "Wischer, Timo (ADITG/ESM)" <twischer@de.adit-jv.com>,
        "Maik.Scholz@de.bosch.com" <Maik.Scholz@de.bosch.com>,
        "Dirk.Behme@de.bosch.com" <Dirk.Behme@de.bosch.com>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Eugniu,

CC cpuidle people

On Fri, Jul 26, 2019 at 11:47 AM Eugeniu Rosca <erosca@de.adit-jv.com> wrote:
> On Fri, Jul 26, 2019 at 11:13:29AM +0200, Rosca, Eugeniu (ADITG/ESM1) wrote:
> [..]
> > The culprit BSP commits are:
> > https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas-bsp.git/commit/?id=3c3b44c752c4ee
> > https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas-bsp.git/commit/?id=902ff7caa32dc71c
> >
> > Further narrowing it down, it turns out the CA57 cpuidle support is
> > not responsible for generating the issue. It's all about the CA53 idle
> > enablement. The reference target is H3-ES2.0-Salvator-X (the problem
> > originally emerged on M3-based customer HW).
> [..]
>
> Small amendment to the above (based on vanilla testing):
>
>  Version                              Issue reproduced?
>                                       (H3-ES2.0-Salvator-X)
>  v5.3-rc1-96-g6789f873ed37              No
>  v5.3-rc1-96-g6789f873ed37 + [1]        No
>  v5.3-rc1-96-g6789f873ed37 + [2]        No
>  v5.3-rc1-96-g6789f873ed37 + [1] + [2]  Yes
>
> [1] https://patchwork.kernel.org/patch/10769701/
> ("[v2,1/5] arm64: dts: r8a7795: Add cpuidle support for CA57 cores")
>
> [2] https://patchwork.kernel.org/patch/10769689/
> ("[v2,2/5] arm64: dts: r8a7795: Add cpuidle support for CA53 cores")

Thanks for your report and investigation!

Unfortunately your original report didn't make it to lore.kernel.org, and
probably also not to the list, due to the large audio attachment.

For the newly CCed people, the issue is about consistent dropouts during
audio playback using an in-house application, introduced by adding cpuidle
support to _both_ the big and LITTLE cores.

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
