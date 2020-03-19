Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DBDA18B0C1
	for <lists+linux-pm@lfdr.de>; Thu, 19 Mar 2020 11:01:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725767AbgCSKBf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Mar 2020 06:01:35 -0400
Received: from sonic312-25.consmr.mail.ir2.yahoo.com ([77.238.178.96]:40374
        "EHLO sonic312-25.consmr.mail.ir2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726976AbgCSKBf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Mar 2020 06:01:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1584612092; bh=7bAj2aTmdt2qZuhBQReQcDKGCSJd8LlC9EcZcjUJr8M=; h=Date:From:Reply-To:Subject:References:From:Subject; b=b4DIOGzB6N3ueDrov3FYiLwLMLy9xmhUlQMzmLzkNLfjW4ZaQwFskoTUj0Eto2AtxgGQ72lWrxvnnULGrAQhTecVLIA15sdvTed6Io9MZ/QH3yzRWOzlzRo243XLh3fOI6SJxQJPBrgSJLJxNVwp+A5za0h3pEVy0ZTOzIi6+FaFNgYpHVnCJlqBWG5WTpHtVMqSB0GyayqycoWpYo/VeAcLhgpDgnL+Z/ql9idP+yVVFNLWk3RtatE9ollYKTVOfUnC9TXA9FWWHbk8QchzCS5n11vl/beDlC3+blnn0e7RcxGmilgHyJB9Sig/6bfl2rHBDCIfWMpXNFjx7HHn/w==
X-YMail-OSG: XsKmVsAVM1m1_ndx0E9KcHxvxNm88TsqbzjBdLwhYCW3pnU_._fRzGx40mJN15b
 AGakuO5KprAeLZIPi20BarkrKva.7BiJYkJkrPNH7qGQi.nEckRsF9XdfEBDEer0A_8V3bkKeV4v
 PzABkkjI5jcoMUns8UYdf8ggJYNA021mfwHL8nWmXG0nqPNsfDkDAgH_Z0u3cXhqMDqxv28DIcMQ
 vvxRmhFEyLDK6egOJRIFcpgB8CLzGqytMizRS4aU6ujh5LVS7IhZoKpRQqQG8hmzlIhRw.VL7lzq
 ECpD4SG.qKmTsejzbY9AIR6RUp7SYCC8Q.KysRntB84lCR1MUnQ0Rr2_l1mvh6I7pbmCiOowW9jb
 FZvPaqqa5oo50LUQeaXQYZsMaRgu5NJExRkPEOHJbUTCdV5Kx7MEL4cmhJzO0f7cw5XIeZkBELXN
 trYYpSL.wrKfQyvRoN_L9ThOfGdi7sc3gY1BFBxD4jq.6DDA.ePxvWlkrO53mx.ELY7kZZXXiayr
 tw3rIWkHy1mjJw0TMe1rE16TBxZVAyPJeTMXtDsj1EiAXBiifanYfVgGI5sH58_qKFpPum390JRO
 k.LlBIrAcGQ.DOVv26dVmALLbFip7qBKtbLPKG1j6Oe4No8ewGuP._xxw3JqjPiwNDNDkn2JDhnS
 ZgpHIoD9OlooGG8bo4_dfMfdvDz9ls7dwPqROIH_8atCimsQNidH4vjbfHsXoM69Jfzdh8pLQsQY
 9DQpSbHIZ3f19oBROR4LBmO4aFy75WD5vsI0wapb5Rl_BDdkD8uN35Y6esH4broaUqa.o9XJ6o12
 PSKBUttvsOJy3BjLHWbJdjvy8a0Q7XxClit2AkPr5AeZKi43y3HKhcOtr1tEI0Vdg.ttw1SVwvfM
 bzK1SDs6cpjVnmCV3sAdKZcxZTqErRCQrOk_2TAEYXd67ajNrtLNiPUwSUBVEFcPLSjcfyOqsr_P
 sp8bjlo1c9VCi6Qfh6mTmLhpimJQWXtHpIucar88ipHqDDgRyNI5As0O5TgE6zv_s76fERaLuYTU
 4E3Bu1TWUtfd._kDQLTS5xiIfwPjeHZTIPlS83A1KtyJB0EdIXlLEHxRe4Zg.esoIrR.91AlV4Wo
 hew2SPbSQqGBJYubCuKQ6gv7b1b5tgeM6CNTgA3C7ncqSpX1ibjyAPS0jDvSODC2pzZlduYYLDVK
 R0B5dbZAQBi0ezvH7eJpFZ.ZknR6kisimhq79B328xnY_W4KuGAZMjqAJTYCneMoJWcHX2d56RNy
 ThZ25FjPQylzxZQKtlWRuuxqSuyP0xg5NXhrNPBu_dKGc1yV.JpvxBnn1G_81RkNWPwmEAD22UmP
 a1w--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ir2.yahoo.com with HTTP; Thu, 19 Mar 2020 10:01:32 +0000
Date:   Thu, 19 Mar 2020 10:01:30 +0000 (UTC)
From:   Suleiman Abubaker <suleimanabubaker84612@gmail.com>
Reply-To: suleimanabubaker@mail.com
Message-ID: <515971425.1359819.1584612090282@mail.yahoo.com>
Subject: Helo
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <515971425.1359819.1584612090282.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.15471 YMailNodin Mozilla/5.0 (Windows NT 6.1; rv:74.0) Gecko/20100101 Firefox/74.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org







Dear Friend,

I am. Mr. Suleiman Abubaker, Manager Auditing and Accountancy Department,Bank of Africa in (B.O.A) Burkina Faso

i am writing to seek for your highly esteemed consent/assistance in a lasting business relationship of mutual benefit involving $18. Million Usd for investment in your country, under a joint venture partnership.

Thank you for accommodating my inquiry, as i look forward to hear from you on this business collaboration and meeting with you soon.


(1)Your Full name:..........................
(2)Your Age.................................
(3)Occupation:.................................
(4)Mobile phone number:.....................
(5)Your Country..........................

Waiting to hear from you.

Your's truly,

Mr. Suleiman Abubaker,
