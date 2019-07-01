Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC735C3D1
	for <lists+linux-pm@lfdr.de>; Mon,  1 Jul 2019 21:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbfGATur (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 1 Jul 2019 15:50:47 -0400
Received: from mout.web.de ([217.72.192.78]:45633 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726586AbfGATur (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 1 Jul 2019 15:50:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1562010633;
        bh=4QSkFMvtVelSfBqUzhSoXEZ0KM6revxybhU7eliZjqc=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=F/ECTlVtbppni1kvMpAqv/rhRj32WneKFFbI4Xuvts0wZzFygPiTuJaBgdQ6Sucri
         P8zHOMcBMg2iZ2Oxg8V0/cp8zIhWIGstN2RcwHsWOFKukreGrHv726JYU7wTHy/7wU
         2IUcCWy2L0tX9/kKp+2rvXGZLdNoo63wo54XBIBA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.131.202]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MeBDG-1htXb52ELW-00PsrE; Mon, 01
 Jul 2019 21:50:33 +0200
To:     linux-pm@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kevin Hilman <khilman@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
From:   Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] PM / Domains: Use seq_puts() in genpd_summary_one()
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <7a79ee59-884a-b769-5e07-37db57687f83@web.de>
Date:   Mon, 1 Jul 2019 21:50:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XXG6CWxFT52mlzSGyOr1ZOLJUo8+dWEn69Gh+S6vA13q5ooK7xJ
 f3+BFUkhH68SGyXTWKlWA9hAc1qoYYp0PsKARUUNucwl5OzHDkzRtLn7GijMkWWdjwa2csg
 FG3YmooIb0YE5qq/hzxEEiyphTZrpYhrTqR+JoK4fh9AliEl4pZ3iwDGsOC5bUAqzw6J8vk
 Exy6b7irkTlFWEm5Px+wA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:wDiAp800HvQ=:6FszKHqdpABplG9tPlcWL0
 7oQH7CTQo7AxKe4hcelLYProbEUjr4DWW6+xS2jlG97FH/Pb+Gev7msrc//vH23DTrS1jAGT2
 vSL9ENdWhjSSgTDbsP0akHj3Yo4kE5h3M14jqViJCqkLpaN9OrTHV8ysS9jP5nTHau8wDRldD
 ZqGKCbMvp8d8n070wes71VM8jSvBOEJfqmvHYku36gKgSWPnENEA2kabcywkICkAzT6nnC7f0
 6bHEGCTXTD/JMvhOqm0GPwZKFtyVXTLRoK77u3Ofl+i5NQ+glJVleNocftlxJ3Ey0dAuQzcU/
 qyuImtUrGRrZliosL4O3W/LSwuii4A5ZTakslsESi3k52almtyO4tr6VAcIbiKkaGB8egdgvN
 pDbEndwFwqN20E0hPeEF5Jjgm7qOD7/KSQ8GVsIQjojOUVhF8p8seSbQFucLCuclM1TM6kaYX
 Jh9ZuMy+c/nlf9ftW4B2E799HTx6dXQgJPFOkW4HBG9Yux2Hvfs55djAMPj1GBVk/i11U0Xce
 DYfTBp4PZJjHv4ts8o6usfchwDOVqiIXxJ+/mmgEwPfEhS93BSG2JhvYJSoOL4U8M0j15YGmm
 fkbAbGuhjxQXmUQ9vPPHicEJf0WCqQ8I8PKiDeI5qW+/j5e6lwdGwmVav4ZI2bl8AVyhXlwKk
 x6xxGloS0Q2i/87aMUxdmGcQ5C6fEJOgL4Vlqm3i1GGG0AToxl43tsV7ExAydyRT7FHmVovu7
 zvfwGCxsNMf3oyafVKnWmU6DaW+lfhIi2hR1zVF7tgndgFHaAkB8oaFAAA+K+voUBbMiOurEI
 UejYHXEehG1Y7j3I4p13RL9QrcuZKtXjTMrvnCHfEjNH767uHADl8S6SwEQy0T3FUw6Bpixc3
 uU08Cpzr6wRMU1zYjx6vV6ahBBEq0V0VK7QS1CllCi1sLImtpFhGDpyfcHk0iP+CjT1lA0vC/
 LCQ3eS8sTbByAE1gpo9h1WqmxJxrL7RH7bSJXChgJ/E8S4gsCpaglw+j7jDhZZxkNQw2YoJoH
 iNexcOmybC6+85XyoI3PqLh9lazHwCFnObdJ+VYI65DNFxjlD6jbwl0mbnAEaL8IeleAF5f4F
 66R7EnqCZIol+u6gMA/L0/uQctV95VR5ycO
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 1 Jul 2019 21:42:31 +0200

A string which did not contain a data format specification should be put
into a sequence. Thus use the corresponding function =E2=80=9Cseq_puts=E2=
=80=9D.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/base/power/domain.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 33c30c1e6a30..7dd433fab7ec 100644
=2D-- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2796,7 +2796,7 @@ static int genpd_summary_one(struct seq_file *s,
 	 * Also genpd->name is immutable.
 	 */
 	list_for_each_entry(link, &genpd->master_links, master_node) {
-		seq_printf(s, "%s", link->slave->name);
+		seq_puts(s, link->slave->name);
 		if (!list_is_last(&link->master_node, &genpd->master_links))
 			seq_puts(s, ", ");
 	}
=2D-
2.22.0

