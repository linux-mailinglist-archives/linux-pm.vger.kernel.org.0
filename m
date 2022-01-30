Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD514A35AE
	for <lists+linux-pm@lfdr.de>; Sun, 30 Jan 2022 11:27:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232545AbiA3K1f (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 30 Jan 2022 05:27:35 -0500
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:35886
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1354584AbiA3K1e (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 30 Jan 2022 05:27:34 -0500
X-IronPort-AV: E=Sophos;i="5.88,328,1635199200"; 
   d="scan'208";a="4476194"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2022 11:27:34 +0100
Date:   Sun, 30 Jan 2022 11:27:32 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Len Brown <lenb@kernel.org>
cc:     linux-pm@vger.kernel.org
Subject: DRAM power consumption with turbostat
Message-ID: <alpine.DEB.2.22.394.2201301121380.3109@hadrien>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello,

I was wondering whether the DRAM power consumption reported by turbostat
is reliable on recent Intel machines?

In particular, I observed that turbostat reported a high DRAM energy
comsumption on a machine (Intel 5128) with persistent memory, but where
the persistent memory was not being used.  A colleague did an experiemnt
on another machine with persistent memory, and reported:

-----

I didn't run the test on troll but on another server equipped with PM
where I was able to reproduce the bug and by reading directly the msr
registers, I see that:
CPU Energy units = 0.00006104J
DRAM Energy units = 0.00001526J

However turbostat assumes that the DRAM  Energy units is 0.00006104J when
it runs the computation to obtain Joules (hence the too-high value
returned by turbostat)

-----

I see the code in turbostat that just uses the CPU energy units value
(rapl_dram_energy_units_probe), but I don't know what was the MSR used to
collect the above information.  Overall, I am wondering if the DRAM energy
consumption values are reliable in cases with and without persistent
memory.

thanks,
julia
