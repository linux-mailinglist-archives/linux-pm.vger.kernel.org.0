Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50F6423B504
	for <lists+linux-pm@lfdr.de>; Tue,  4 Aug 2020 08:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726056AbgHDGcR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 4 Aug 2020 02:32:17 -0400
Received: from mga05.intel.com ([192.55.52.43]:4407 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725300AbgHDGcR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 4 Aug 2020 02:32:17 -0400
IronPort-SDR: SXTlxMYnynuG427s1x6wGphi0sjY02/NvP8xgvlo9QOu75acvMZYtOOVilvyG6aUQA6XeYHNRE
 LZjBoQGeghYg==
X-IronPort-AV: E=McAfee;i="6000,8403,9702"; a="237119693"
X-IronPort-AV: E=Sophos;i="5.75,433,1589266800"; 
   d="scan'208";a="237119693"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2020 23:32:16 -0700
IronPort-SDR: TBgSqAPb2j5qNj2YcM7HMiZjtefkEZKXFf1DtZojZ4gpRxYz6u0xChAwT94WIJHIlRq14oUaoc
 z2O43uvWtH5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,433,1589266800"; 
   d="scan'208";a="274355521"
Received: from yugao2-mobl1.ccr.corp.intel.com (HELO sfu5-MOBL1.ccr.corp.intel.com) ([10.255.30.103])
  by fmsmga007.fm.intel.com with ESMTP; 03 Aug 2020 23:32:13 -0700
Message-ID: <91e715f73a3e9197d4a5f597c7b303284db11ac9.camel@intel.com>
Subject: Re: [GIT PULL] thermal for v5.9-rc1
From:   Zhang Rui <rui.zhang@intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Amit Kucheria <amit.kucheria@linaro.org>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Colin King <colin.king@canonical.com>,
        Shawn Guo <shawn.guo@linaro.org>,
        Lukasz Luba <Lukasz.Luba@arm.com>,
        Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>,
        Henry Yen <henry.yen@mediatek.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM mailing list <linux-pm@vger.kernel.org>,
        Marian-Cristian Rotariu 
        <marian-cristian.rotariu.rb@bp.renesas.com>
Date:   Tue, 04 Aug 2020 14:32:12 +0800
In-Reply-To: <CAHk-=whbPwsdPom8pcJyo7P5KRRjDef_6ZEMbavJy=qArVoqVw@mail.gmail.com>
References: <0b3dd92e-0aa0-6f23-fcef-178f2bf6a1c1@linaro.org>
         <CAHk-=whbPwsdPom8pcJyo7P5KRRjDef_6ZEMbavJy=qArVoqVw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi, Linus,

On Mon, 2020-08-03 at 20:26 -0700, Linus Torvalds wrote:
> On Mon, Aug 3, 2020 at 2:44 PM Daniel Lezcano <
> daniel.lezcano@linaro.org> wrote:
> > 
> > 
ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git
> > tags/thermal-v5.9-rc1
> 
> This was all rebased just an hour before you sent it to me.
> 
> Why?
> 

There must be something wrong here, Daniel and I are following a strict
process to make sure that we don't lose any history.

For this PR, I'm not quite sure what happened, he probably did
something by mistake when generating it.

thanks,
rui

> Maybe it's how you commonly work, and I just haven't noticed before,
> but it's wrong for all the reasons I've stated about a million times
> now.
> 
> What makes it so hard for people to understand? What makes that "you
> sent me a completely untested pull request and that's not ok" so
> difficult a concept to get?
> 
> And dammit, if you do it and have a good reason to do this despite
> literally *decades* of me telling people not to do that, and why it's
> wrong, then  you can spend the five minutes *explaining* why you do
> something that is widely documented to be bad.
> 
> These commits sure as hell weren't in linux-next either.
> 
>                    Linus

