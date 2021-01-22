Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA5A430097F
	for <lists+linux-pm@lfdr.de>; Fri, 22 Jan 2021 18:22:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729527AbhAVQsK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 Jan 2021 11:48:10 -0500
Received: from mail2.eaton.com ([192.104.67.3]:10500 "EHLO mail2.eaton.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729609AbhAVQUl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 22 Jan 2021 11:20:41 -0500
Received: from mail2.eaton.com (simtcimsva04.etn.com [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7231B8C11B;
        Fri, 22 Jan 2021 11:19:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=eaton.com;
        s=eaton-s2020-01; t=1611332389;
        bh=yWewDqoIBEqGUJz3VJAg+qs4xm37J7YinYjIwl0kKps=; h=From:To:Date;
        b=Bj3UCrE/V93GblhwRuGkf+vxzMPHXGiLcRNOnarYsyfELbEbRF2oNdJGrjwJtuRip
         ANm39c1LhuSzpWdN/MNuU7xR9lGlc3GCdyS7D74YYzq0GhR68YImitG175sgyJKJVH
         LQxFM96GUWDeit2CZWm9TjJgDXn9WpzPRc+7hmno6R5CSVVyqfEcfz85Ee31hQOKOX
         F4vz8kMTbKCLGQqnGewXQfWlLAfVT77ySDdCQBGLfDRRY2uf6s/AV9BEkGxG8iyOtA
         c2V5NhuvpP9bLY078wnSRdmCdy0H43y+hbarPT/2dObV5nr4oZLEwgA43RL7ixh6mc
         dn4dboo8M+J4g==
Received: from mail2.eaton.com (simtcimsva04.etn.com [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6E6958C114;
        Fri, 22 Jan 2021 11:19:49 -0500 (EST)
Received: from SIMTCSGWY03.napa.ad.etn.com (simtcsgwy03.napa.ad.etn.com [151.110.126.189])
        by mail2.eaton.com (Postfix) with ESMTPS;
        Fri, 22 Jan 2021 11:19:49 -0500 (EST)
Received: from localhost (151.110.234.147) by SIMTCSGWY03.napa.ad.etn.com
 (151.110.126.205) with Microsoft SMTP Server id 14.3.487.0; Fri, 22 Jan 2021
 11:19:44 -0500
From:   Laurent Badel <laurentbadel@eaton.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, <linux-pm@vger.kernel.org>
CC:     Laurent Badel <laurentbadel@eaton.com>
Subject: [PATCH 0/1] PM: hibernate: Fix swap file marking
Date:   Fri, 22 Jan 2021 17:19:40 +0100
Message-ID: <20210122161941.1080-1-laurentbadel@eaton.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-EXCLAIMER-MD-CONFIG: 96b59d02-bc1a-4a40-8c96-611cac62bce9
X-TM-SNTS-SMTP: B934DEEAB4CB8FD8A5B7994CBC3DB3C2852D84A63AEE7A0BEA346469ED5EFD062002:8
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSVA-9.1.0.1988-8.6.0.1013-25928.001
X-TM-AS-Result: No--0.054-7.0-31-10
X-imss-scan-details: No--0.054-7.0-31-10
X-TMASE-Version: IMSVA-9.1.0.1988-8.6.1013-25928.001
X-TMASE-Result: 10--0.054200-10.000000
X-TMASE-MatchedRID: e7Ukgmbx2cyYizZS4XBb37SlePUaQB976HigDLMyLuZUQwJCGT3cGsEI
        kNzFiDxLd/zkRsk3r3D7XRb/M9j3617bBp0oAOqqfid4LSHtIAOo2aYwunflnzNCQB9pla5ySwj
        GLfgtslIEf1geLaoegC/AK98t35jA7aNCrPxQ/ucmxU58j99z8wEPJrYlsf/6WMFR4yyN53oIyT
        NFi0TCbVYJIpN1DYJ5DsmL+Dl+ilTQLWxBF9DMQcRB0bsfrpPIcSqbxBgG0w5RAl+fwAdPp61+6
        pBftFJwfzZLo3h5LcJ45zoy90LssUzsUHcZ+ORfyTZfip8hAZrEWIS2IDhm/mix8CxzEqVSR/zg
        aQpTZVZB73EZz7XBCOp1XUG/h2MOieWdV7FfKATLbAp0fm+COw==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-12:0,22:0,33:0,34:0-0
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

=EF=BB=BFIt seems that the swap writer might need be flushed after marking =
the=20
signature into the swap files, otherwise the system may power off before
the signature is written. This is what happened on my system (the swap=20
file was missing the hibernation signature) and this patch allowed it
to restore from the hibernation image.=20

I don't know if it might be due to a peculiarity of the system I am using,
it is a custom board with an iMX28 SoC and the hibernation image is stored
on the gpmi nand flash.

Best regards,

Laurent

Laurent Badel (1):
  PM: hibernate: flush swap writer after marking

 kernel/power/swap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--=20
2.17.1



-----------------------------
Eaton Industries Manufacturing GmbH ~ Registered place of business: Route d=
e la Longeraie 7, 1110, Morges, Switzerland=20

-----------------------------

