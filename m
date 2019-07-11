Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41D55651F5
	for <lists+linux-pm@lfdr.de>; Thu, 11 Jul 2019 08:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727996AbfGKGrR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 11 Jul 2019 02:47:17 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:10111
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725963AbfGKGrR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 11 Jul 2019 02:47:17 -0400
X-IronPort-AV: E=Sophos;i="5.63,476,1557180000"; 
   d="scan'208";a="313140146"
Received: from vaio-julia.rsr.lip6.fr ([132.227.76.33])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jul 2019 08:47:00 +0200
Date:   Thu, 11 Jul 2019 08:46:56 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     wen.yang99@zte.com.cn
cc:     Markus.Elfring@web.de, rjw@rjwysocki.net,
        daniel.lezcano@linaro.org, linux-pm@vger.kernel.org,
        kernel-janitors@vger.kernel.org, benh@kernel.crashing.org,
        cheng.shengyu@zte.com.cn, galak@kernel.crashing.org,
        mpe@ellerman.id.au, paulus@samba.org, oss@buserror.net,
        xue.zhihong@zte.com.cn, wang.yi59@zte.com.cn,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: Coccinelle: Checking of_node_put() calls with SmPL
In-Reply-To: <201907111435459627761@zte.com.cn>
Message-ID: <alpine.DEB.2.20.1907110845551.3626@hadrien>
References: 201907101533443009168@zte.com.cn,9d515026-5b74-cf0c-0c64-4fe242d4104e@web.de <201907111435459627761@zte.com.cn>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=====_001_next====="
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

--=====_001_next=====
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Thu, 11 Jul 2019, wen.yang99@zte.com.cn wrote:

> > > we developed a coccinelle script to detect such problems.
> >
> > Would you find the implementation of the function “dt_init_idle_driver”
> > suspicious according to discussed source code search patterns?
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/cpuidle/dt_idle_states.c?id=e9a83bd2322035ed9d7dcf35753d3f984d76c6a5#n208
> > https://elixir.bootlin.com/linux/v5.2/source/drivers/cpuidle/dt_idle_states.c#L208
> >
> >
> > > This script is still being improved.
> >
> > Will corresponding software development challenges become more interesting?
>
> Hello Markus,
> This is the simplified code pattern for it:
>
> 172         for (i = 0; ; i++) {
> 173                 state_node = of_parse_phandle(...);     ---> Obtain here
> ...
> 177                 match_id = of_match_node(matches, state_node);
> 178                 if (!match_id) {
> 179                         err = -ENODEV;
> 180                         break;                         --->  Jump out of the loop without releasing it
> 181                 }
> 182
> 183                 if (!of_device_is_available(state_node)) {
> 184                         of_node_put(state_node);
> 185                         continue;                    --->  Release the object references within a loop
> 186                 }
> ...
> 208                 of_node_put(state_node);  -->  Release the object references within a loop
> 209         }
> 210
> 211         of_node_put(state_node);       -->    There may be double free here.
>
> This code pattern is very interesting and the coccinelle software should also recognize this pattern.

In my experience, when you start looking at these of_node_put things, all
sorts of strange things appear...

julia
--=====_001_next=====--
