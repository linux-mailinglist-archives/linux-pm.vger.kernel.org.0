Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B647DA5194
	for <lists+linux-pm@lfdr.de>; Mon,  2 Sep 2019 10:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730070AbfIBI3P (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Sep 2019 04:29:15 -0400
Received: from sonic305-20.consmr.mail.ne1.yahoo.com ([66.163.185.146]:46096
        "EHLO sonic305-20.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730065AbfIBI3O (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 2 Sep 2019 04:29:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1567412953; bh=tPdyM4f7Tq8kspt5syr9wxbiHLUxanV8lkCr2Pkkkas=; h=Date:From:Reply-To:Subject:From:Subject; b=GLeqxm3YPHbhgihxMhf0X40A6UFhYnuKlKKzyMAe79JzKzwprNiLRlbKG4ifYjtlFHIuTY3cSNkB1NcVHCLWVtPDMToUHx+khmiUpQdngypn/n9rsZkThxOs6Q5v4jpNRRAyC8rFVovn/gjQE8JUYycxjDAESuIa48v7l2fCYghwMjwQyi8I6Qv+HFGATywtI3tziNMbLB7659I5zsq2xr62py7vuhvoKmW2Lg/u502K06WOLfDC/YrZoXWZiBRHDqENbvsD3H1ZfFJC5uVCxJ73gwjbUovaKuAFAXrfr9mzbh43oFzbSCLeuNvrgjYaXyK/VIegUeLhvjgMXZ6egQ==
X-YMail-OSG: EGbqIn8VM1lR.pGuMQ9s3rMspiZkw3YBB1sFXUZj8ogrHWyEzi2.BXaVncoINJ2
 OO_G8NaWxi8ACHt6Mg8IXG_pbXPzAhlsQR8OgQ5ATK2ODw.c.VXiKNWsjTCHuz_AvLyPWd4QJg64
 k65G6XHxEuf8fIGpBtCl6BcdBdfH.Y3icRT.O1TZvcpipWOELsXLUVrI_jLZTAUp6SO0rt3.JAhF
 h0_k.tvfDiiRk_r0vT2Zp9vcxvJFnChcuBJPoyRD97sM0txlqQZbiQpNdAChAOh.9jO5gBqouSZZ
 IO05JenBwHNnkWe4Aid7BPOlG4UxTGKP6E61CFHFeTYFx4YTggIXpwMhibvySqSNWZcl.DHd2sLb
 GuZQbNK3PrYxUkOtOn8ikgKjQ9n2Y128bwuaIJJR37FqTZVMnNf0IQ0Z.8CkOhisDXdJQ8mqpNCd
 qnniURgjiYpoBPu2C73nFviPF44zvzDL3TKQl9Jr9bw6EcnkX49vXGFd74GpO47Br65G8MCe0k3g
 kQdh6JxJL59gKx4cEpMU1WdwdWSm2ZCo4vD9XQiGTqVtRlnVrEAlcsomXq5xhHXn7prFuR2w04Rg
 A7OPzwCGcTnSGauwVw4.LOrYWjDBnQO2YhOQLYP66MSpXHUsTgUtbi5NBwSXXufZAdf5ePCUZOP4
 7l0syGY5tnyU.mnNOpxzdeKE60sZplhSnUE._AUY1SobFDCdUMk1.7_hrt6FZGE17hetXJCH291X
 EEUcdnf45Ird73P7nqvITD_CfaJiHmlTs4.i5Q99oBGbexXNrgKI2lpH.YjtbIED98piNC.kgFwZ
 .bed1NAp4VwvQPjcTRw6yJQPEIEIBVMyVyYzr7bYLmt_wCpS2X8Wj0SNhCpQaewXbD11kOa0iY3f
 x8mtBP5ydFDh_yk0zj8O1en9OTPmNETKDFFSV9Trgwgcah0CPBqlbaC4J45B_1gH2TJXnKIu9ZpY
 556eveEws1rkLT9GjegcBDv3B4ctnodbLyqAMjY4VVatwcfQgMBKpmB3CVAGJbkgqX6B6zP29yJN
 4fHXYMlui3zIeeCcbh1YvCBgUnWbtKYLOsCm2ut6PcqleBl727aLhC6JGihWv.z_UGSgbUPxJCr4
 OKM8qqnZLmoJrFXolR5WhGuLP__3XLZm9egGQjRRsTJ0mH.e3tbQfHskiHUsqluKSO0T0N2BIteV
 ci9JGTBplV9_OS5GjNLWcumY8iZ9L0QP1O3oZqihwB9vL3x5S7GQXmoa0sN8XxJhcsgCfh3ucNm6
 6nFBRkTrXnXk8
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.ne1.yahoo.com with HTTP; Mon, 2 Sep 2019 08:29:13 +0000
Date:   Mon, 2 Sep 2019 08:29:11 +0000 (UTC)
From:   Aisha Gaddafi <aishagnnnn@gmail.com>
Reply-To: gaisha983@gmail.com
Message-ID: <736087669.1118295.1567412951480@mail.yahoo.com>
Subject: Dear Friend,
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Dear Friend,

I came across your e-mail contact prior a private search while in need of 
your assistance. My name is Aisha  Gaddafi a single Mother and a Widow with 
three Children. I am the only biological Daughter of late Libyan President 
(Late Colonel Muammar Gaddafi).

I have investment funds worth Twenty Seven Million Five Hundred Thousand 
United State Dollar ($27.500.000.00 ) and i need a trusted investment 
Manager/Partner because of my current refugee status, however, I am 
interested in you for investment project assistance in your country, may be 
from there, we can build business relationship in the nearest future.

I am willing to negotiate investment/business profit sharing ratio with you 
base on the future investment earning profits.

If you are willing to handle this project on my behalf kindly reply urgent 
to enable me provide you more information about the investment funds.

Your Urgent Reply Will Be Appreciated.

Best Regards
Mrs Aisha Gaddafi
(gaisha983@gmail.com)
