Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03C5F9FD82
	for <lists+linux-pm@lfdr.de>; Wed, 28 Aug 2019 10:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbfH1Ixo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 28 Aug 2019 04:53:44 -0400
Received: from mga12.intel.com ([192.55.52.136]:36181 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726463AbfH1Ixn (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 28 Aug 2019 04:53:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Aug 2019 01:53:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,440,1559545200"; 
   d="scan'208";a="332095289"
Received: from deyangko-mobl.ccr.corp.intel.com ([10.249.168.35])
  by orsmga004.jf.intel.com with ESMTP; 28 Aug 2019 01:53:40 -0700
Message-ID: <b94af6b2101f436c1bdeec744e164c78ee7c2682.camel@intel.com>
Subject: Re: [PATCH] thermal: armada: Fix -Wshift-negative-value
From:   Zhang Rui <rui.zhang@intel.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>, edubezval@gmail.com,
        linux-pm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nathan Huckleberry <nhuck@google.com>
Date:   Wed, 28 Aug 2019 16:53:49 +0800
In-Reply-To: <20190819102131.41da667b@xps13>
References: <20190613184923.245935-1-nhuck@google.com>
         <27428324-129e-ee37-304a-0da2ed3810a0@linaro.org>
         <CAJkfWY4X-YwuansL1R5w0rQNmE_hVJZKrMBJmOLp9G2DJPkNow@mail.gmail.com>
         <CAKwvOdkEp=q+2B_iqqyHJLwwUaFH2jnO+Ey8t-hn=x4shTbdoA@mail.gmail.com>
         <c2b821f2-545a-9839-3de6-d68dfee5b5dc@linaro.org>
         <20190819102131.41da667b@xps13>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 2019-08-19 at 10:21 +0200, Miquel Raynal wrote:
> Hello,
> 
> Daniel Lezcano <daniel.lezcano@linaro.org> wrote on Thu, 15 Aug 2019
> 01:06:21 +0200:
> 
> > On 15/08/2019 00:12, Nick Desaulniers wrote:
> > > On Tue, Aug 13, 2019 at 10:28 AM 'Nathan Huckleberry' via Clang
> > > Built
> > > Linux <clang-built-linux@googlegroups.com> wrote:  
> > > > 
> > > > Following up to see if this patch is going to be accepted.  
> > > 
> > > Miquel is listed as the maintainer of this file in MAINTAINERS.
> > > Miquel, can you please pick this up?  Otherwise Zhang, Eduardo,
> > > and
> > > Daniel are listed as maintainers for drivers/thermal/.  
> > 
> > I'm listed as reviewer, it is up to Zhang or Eduardo to take the
> > patches.
> > 
> > 
> 
> Sorry for the delay, I don't manage a tree for this driver, I'll let
> Zhang or Eduardo take the patch with my
> 
> Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>
> 

Patch applied.

thanks,
rui
> 
> Thanks,
> Miquèl

