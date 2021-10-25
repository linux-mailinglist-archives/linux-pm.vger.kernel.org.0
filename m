Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0EA43A4FF
	for <lists+linux-pm@lfdr.de>; Mon, 25 Oct 2021 22:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbhJYUwT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 25 Oct 2021 16:52:19 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:38726
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230490AbhJYUwS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 25 Oct 2021 16:52:18 -0400
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AMRwSCKgxYZU7dRkm7HVJMztskXBQXuoji2hC?=
 =?us-ascii?q?6mlwRA09T+Wxi92plu8KzAKcslgssb8b9OxoS5PwJk80kqQFh7X5XI3SODUO11?=
 =?us-ascii?q?HJEGgP1+TfKnjbakjDH41mpMVdmspFaeEYZGIS5foSojPVLz9K+rK6Gc6T79s2?=
 =?us-ascii?q?g00dLj1XVw=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.84,326,1620684000"; 
   d="scan'208";a="397332773"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Oct 2021 22:49:54 +0200
Date:   Mon, 25 Oct 2021 22:49:54 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Doug Smythies <dsmythies@telus.net>
cc:     Julia Lawall <julia.lawall@inria.fr>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: problem in changing from active to passive mode
In-Reply-To: <CAAYoRsXeQravNXKsWAZvacMmE_iBzaQ+mQxNbB5jcD_vkny+Sg@mail.gmail.com>
Message-ID: <alpine.DEB.2.22.394.2110250832080.2938@hadrien>
References: <alpine.DEB.2.22.394.2110241452460.2997@hadrien> <CAAYoRsXeQravNXKsWAZvacMmE_iBzaQ+mQxNbB5jcD_vkny+Sg@mail.gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Thanks for the feedback.  I see that if I change the mode from active to
passive and back to active, I end up in active powersave, not active
performance.  Changing the governor to performance does reproducethe
original performance.

Still, I have the impression that the performance with passive/schedutil
is excessively bad because the frequency is excessively low.  But my
machines are not available at the moment, so I will have to try again
tomorrow to see what exactly is going on.

julia
