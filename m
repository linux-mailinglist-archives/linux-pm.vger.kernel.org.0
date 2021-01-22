Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E94463008FE
	for <lists+linux-pm@lfdr.de>; Fri, 22 Jan 2021 17:51:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729491AbhAVQrn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 Jan 2021 11:47:43 -0500
Received: from mail.eaton.com ([192.104.67.6]:10400 "EHLO mail.eaton.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729599AbhAVQUf (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 22 Jan 2021 11:20:35 -0500
Received: from mail.eaton.com (simtcimsva03.etn.com [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E561AA40AD;
        Fri, 22 Jan 2021 11:19:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=eaton.com;
        s=eaton-s2020-01; t=1611332387;
        bh=NXPnl/Y3FJq8m/0J4qPQ1JlhxEaQclaFLA2zzJv3CPg=; h=From:To:Date;
        b=QIKIgm26Lxh6i2FVsUXUMW269CHeNKsuytJxrQKsKxKu0Ya5FPXwDCidzatcLz8pw
         W5GMC2ecD/vWJWm0QKCbeZjKqGfNkLFP2DnXYCLy4Ts4YKM9P4X8I693wE4aVmXiIk
         zB4paWEtiVvTQgl55wJ4K/z9YN7y4X6LipsB6yYlu2bNwBvbglPf+/iI8FZgsZshZK
         IMMcCY7ok+yzDoJkOidJ/qqStop65IWkpHWuGRbhM9U4siks9Qvl3S3wMa9jFLA0iN
         RC/kpPzGWQM0HjpEodATGKAKxbs2JD2Ha51tqkg+A2ww8+mm7kIaKJ0I/exXgVQ5Wu
         FwnbjUUg/1GJA==
Received: from mail.eaton.com (simtcimsva03.etn.com [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D8DF4A4071;
        Fri, 22 Jan 2021 11:19:46 -0500 (EST)
Received: from LOUTCSGWY02.napa.ad.etn.com (loutcsgwy02.napa.ad.etn.com [151.110.126.85])
        by mail.eaton.com (Postfix) with ESMTPS;
        Fri, 22 Jan 2021 11:19:46 -0500 (EST)
Received: from localhost (151.110.234.147) by LOUTCSGWY02.napa.ad.etn.com
 (151.110.126.205) with Microsoft SMTP Server id 14.3.487.0; Fri, 22 Jan 2021
 11:19:45 -0500
From:   Laurent Badel <laurentbadel@eaton.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, <linux-pm@vger.kernel.org>
CC:     Laurent Badel <laurentbadel@eaton.com>
Subject: [PATCH 1/1] PM: hibernate: flush swap writer after marking
Date:   Fri, 22 Jan 2021 17:19:41 +0100
Message-ID: <20210122161941.1080-2-laurentbadel@eaton.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210122161941.1080-1-laurentbadel@eaton.com>
References: <20210122161941.1080-1-laurentbadel@eaton.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-EXCLAIMER-MD-CONFIG: 96b59d02-bc1a-4a40-8c96-611cac62bce9
X-TM-SNTS-SMTP: 715C64F744E28E5A2948BB37267D5B377C467E3C98275D80EE16C0E2530A32AE2002:8
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSVA-9.1.0.1988-8.6.0.1013-25928.001
X-TM-AS-Result: No--3.473-7.0-31-10
X-imss-scan-details: No--3.473-7.0-31-10
X-TMASE-Version: IMSVA-9.1.0.1988-8.6.1013-25928.001
X-TMASE-Result: 10--3.472800-10.000000
X-TMASE-MatchedRID: uc5cNCUKFYqYizZS4XBb31BHQbxjMzOFTq7p0H1d1uu6NZ1Y50LtWSPT
        yo5Y6UW77Pogmtrmo9fULQp/uiPRelroFJ9oH6bIPwKTD1v8YV5MkOX0UoduuVVkJxysad/I0oQ
        J+FjC5oYspcdwc8Msxy7sD033+LBef+zeSFi2bEodDctFr7spHAQzkAzkcS6b2bNx1HEv7HAqtq
        5d3cxkNZdacNh8njm7bHRTANuSLj3DGsaJp9Q5c5GZW2ivGVlRI9B4eYpWy1yJMLGAigMWQ49Di
        fSBN2vd4vyLjpN/V07Oxp7WEObs+fjl+LaaxyHgU/JCITmuhS7oZbNFHtbIdPl43iPWIJMPxwTT
        797Vag8=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-12:0,22:0,33:0,34:0-0
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

=EF=BB=BFFlush the swap writer after, not before, marking the files, to ens=
ure the
signature is properly written.=20

Signed-off-by: Laurent Badel <laurentbadel@eaton.com>
---
 kernel/power/swap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index c73f2e295167..72e33054a2e1 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -497,10 +497,10 @@ static int swap_writer_finish(struct swap_map_handle =
*handle,
 		unsigned int flags, int error)
 {
 	if (!error) {
-		flush_swap_writer(handle);
 		pr_info("S");
 		error =3D mark_swapfiles(handle, flags);
 		pr_cont("|\n");
+		flush_swap_writer(handle);
 	}
=20
 	if (error)
--=20
2.17.1



-----------------------------
Eaton Industries Manufacturing GmbH ~ Registered place of business: Route d=
e la Longeraie 7, 1110, Morges, Switzerland=20

-----------------------------

