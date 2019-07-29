Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61C4B78AA0
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2019 13:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387674AbfG2Lcw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Jul 2019 07:32:52 -0400
Received: from foss.arm.com ([217.140.110.172]:42442 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387483AbfG2Lcw (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 29 Jul 2019 07:32:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1661728;
        Mon, 29 Jul 2019 04:32:51 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (unknown [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 110E23F694;
        Mon, 29 Jul 2019 04:32:48 -0700 (PDT)
Date:   Mon, 29 Jul 2019 12:32:44 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Eugeniu Rosca <erosca@de.adit-jv.com>,
        Ulrich Hecht <uli+renesas@fpond.eu>,
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
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 2/5] arm64: dts: r8a7795: Add cpuidle support for CA53
 cores
Message-ID: <20190729113244.GA12631@e121166-lin.cambridge.arm.com>
References: <1547808474-19427-1-git-send-email-uli+renesas@fpond.eu>
 <1547808474-19427-3-git-send-email-uli+renesas@fpond.eu>
 <20190726091325.GA13111@vmlxhi-102.adit-jv.com>
 <20190726094724.GA14913@vmlxhi-102.adit-jv.com>
 <CAMuHMdXiOBxUDXLcL6R7jHF4DMoH=72yMkSiv-51aV7cw3my9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdXiOBxUDXLcL6R7jHF4DMoH=72yMkSiv-51aV7cw3my9Q@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jul 29, 2019 at 09:44:52AM +0200, Geert Uytterhoeven wrote:
> Hi Eugniu,
> 
> CC cpuidle people
> 
> On Fri, Jul 26, 2019 at 11:47 AM Eugeniu Rosca <erosca@de.adit-jv.com> wrote:
> > On Fri, Jul 26, 2019 at 11:13:29AM +0200, Rosca, Eugeniu (ADITG/ESM1) wrote:
> > [..]
> > > The culprit BSP commits are:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas-bsp.git/commit/?id=3c3b44c752c4ee
> > > https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas-bsp.git/commit/?id=902ff7caa32dc71c
> > >
> > > Further narrowing it down, it turns out the CA57 cpuidle support is
> > > not responsible for generating the issue. It's all about the CA53 idle
> > > enablement. The reference target is H3-ES2.0-Salvator-X (the problem
> > > originally emerged on M3-based customer HW).
> > [..]
> >
> > Small amendment to the above (based on vanilla testing):
> >
> >  Version                              Issue reproduced?
> >                                       (H3-ES2.0-Salvator-X)
> >  v5.3-rc1-96-g6789f873ed37              No
> >  v5.3-rc1-96-g6789f873ed37 + [1]        No
> >  v5.3-rc1-96-g6789f873ed37 + [2]        No
> >  v5.3-rc1-96-g6789f873ed37 + [1] + [2]  Yes
> >
> > [1] https://patchwork.kernel.org/patch/10769701/
> > ("[v2,1/5] arm64: dts: r8a7795: Add cpuidle support for CA57 cores")
> >
> > [2] https://patchwork.kernel.org/patch/10769689/
> > ("[v2,2/5] arm64: dts: r8a7795: Add cpuidle support for CA53 cores")
> 
> Thanks for your report and investigation!
> 
> Unfortunately your original report didn't make it to lore.kernel.org, and
> probably also not to the list, due to the large audio attachment.
> 
> For the newly CCed people, the issue is about consistent dropouts
> during audio playback using an in-house application, introduced by
> adding cpuidle support to _both_ the big and LITTLE cores.

CPUidle entry/exit latencies are certainly bringing the issue
about, I am not an audio expert but I suspect buffering should
be tuned to cope with those _increased_ latencies or possibly
idle states disabled for certain specific use cases - there
is no silver bullet, entering deep idle states will increase
latencies, there is no way around it.

I am happy to help you debug the issue further.

Lorenzo
