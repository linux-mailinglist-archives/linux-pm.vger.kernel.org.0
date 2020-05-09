Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2AE31CBE4E
	for <lists+linux-pm@lfdr.de>; Sat,  9 May 2020 09:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729009AbgEIHDG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 9 May 2020 03:03:06 -0400
Received: from mout.web.de ([217.72.192.78]:51543 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728471AbgEIHDF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 9 May 2020 03:03:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1589007770;
        bh=kDJTCtXtYcbpkL8hwDBkWtiOYtx0rgVWacu2fHE5bgs=;
        h=X-UI-Sender-Class:To:Cc:Subject:From:Date;
        b=magyDjl8pWAeZ96slZ6RUzMA0AsIVXbLL2gMZykCe+0RbUKRz2DMgzfQ/uoNAMEn6
         0Co31R+o2QQMmv55caPaxnwIFOvhJZxBfh0dbgpJeK3LmY1zYpHrfDwNbV0vX+eOeY
         g1DrkAXXsF2EGcUSY4DmsGWFji0Y8AWLVz3Sv2mg=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.48.147.78]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MGxQX-1jJrFT33wp-00E5xg; Sat, 09
 May 2020 09:02:48 +0200
To:     Hongbo Yao <yaohongbo@huawei.com>, linux-pm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Chen Zhou <chenzhou10@huawei.com>,
        Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] power: reset: ltc2952: remove set variable but unused
 value
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <e40a971a-68b8-8d63-41d1-2617763fb042@web.de>
Date:   Sat, 9 May 2020 09:02:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5JyDbG3bZgXKd8ldDbOvYEuCINmvvP7IenG8Byblf/EnXDgURO1
 rK/PisbhNrDJxj8JXydUHKe/zX5dMQ8nKmpIUy61FQPo9eTXG949oW358p3pa3Y3w3AyAWB
 +pBIg8uBGa7GUGiEvxO2/2vOWNhgHh28SB9FOSuc/4Aa2Eah/uxr+KeR86l2yVEFOa+HrxE
 WK/xM1vxRQFP6esAucBgw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:WMeo8hbqx+Q=:2YDgLNqRWUU38a+EQKoLcm
 NiLuIfBQ1krB03Z0pPVpCOAXlxE9NOhNOMjHSFdQSFfi5Xm3icZLDbn3mrf2xjPAdKpGlkE6v
 QMMpbAzNlS1Pq88K8E6jSv68ixX/FgzhDkK0KbzMhRdMNwlZPFvB35XnfAMWZpafcMKVeQiGQ
 T0fO/aZILLhTsyvxzzSQH9KqM3udg1AL34RwznTU09Z4/tcanhdhTaLiKzQOY69exGH0Ow8pU
 uMloq0ShWrgamhyAlmanYzMn6qZiQFQjPcuThTmRjQPOwXA28t47slh33P1s7etbZ44dLgj+1
 GEYPhzvA4g7JxMw19UM9pHgWK4lo48GxL8AC43FTfTkC7hHc0AsCktQLsTFVwvrphbN96DhM9
 KR3s/CSncCJKtsopUOWhEHbNOdHavtiaWSCGKUcXZR8/Z6/cQW+CsgrXDtX6yMPdaMsb+aOkb
 UoRBh9zWUfad3iS9PMQzB67UtYQJLk/13ysILDZOymS8gOKyrL81EhI2EPdI38bdy9kRYswAF
 wh2h+vEjqrgyxJ7CdVFzvbNVjH89DsA2toeFYDEfS4/1qcGdEi1ts6EfRh8hVMn+Wzqlh3RlI
 Uo/hBlHzxiBvscS5YFcKtsBz74jXwUYBpBdesyil3cAAqsao/vwPsstW163iA2LS+67utmaWp
 QaGx1eMHqV/JvBvIoGppTcVVdZmnq7EIZ4ZkBNXW9juJEoCzwea5By7mZoCoVq8F2Y1z/+f85
 8r45Be44qFOFv1xjfeldL8CF4ZpqaRS7F422lq0iJ4f6h9V2ILBFCzb8/NL+VdvadOl0vlZRQ
 LMcX1btK/BV6MAFm5YJ63fsUE9vqLLLaQ9JW9e+eeQFe6KkoY+t2vHmjt7cck7PFWI5LRA9M3
 cc1eD5vbXF6VT2Rb+u2wzpr4ix7lD9Bwq9XePUZlRjGZjwHB2SGI8rfXRVvgKg1uakuSpVPEq
 47Y8VrJh+sEIB3C4ZBnRIbEhu9+D/uyD+HMPqNi3Mfye+D6VDJJdfOotq6gu+pWaivCT4DGXt
 lljVVC0lAqQ0BlFWlRZ2g6W3nRvV0Qhwlmol+ph5B+2LvevtjPL9/ans6jjDZD6BWI1Gw183W
 FcOEV076JXxOsv3PGoD2xLozWwp2LpEWocbjO033UYPbtjDDwozCCMXXGgChpmhhPhourLcD8
 Kf4iCOerx4sx3NaZ624F4K28HOrv5ukD8ZvTPMKof1L2/vLQ/MbY4UxZRd1xqdGSfjiqiE+33
 As2RXX13J0rxS31YH
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

> Fixes gcc '-Wunused-but-set-variable' warning:
> drivers/power/reset/ltc2952-poweroff.c:97:16: warning: variable
> =E2=80=98overruns=E2=80=99 set but not used [-Wunused-but-set-variable]

I suggest to improve also this commit message.

* Can it be helpful to replace the word =E2=80=9CFixes=E2=80=9D by the tex=
t
  =E2=80=9CAn issue was pointed out by the compiler.=E2=80=9D?

* How do you think about to add the wording =E2=80=9CThus delete the menti=
oned variable.=E2=80=9D
  to the change description?

* The value of an assigned variable was not reused in this function implem=
entation.
  Should this detail be better represented in the final commit subject?

* Would you like to add the tag =E2=80=9CFixes=E2=80=9D?

Regards,
Markus
