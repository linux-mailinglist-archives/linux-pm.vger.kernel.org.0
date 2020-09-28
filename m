Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2855027B129
	for <lists+linux-pm@lfdr.de>; Mon, 28 Sep 2020 17:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbgI1Psm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Sep 2020 11:48:42 -0400
Received: from sonic307-2.consmr.mail.bf2.yahoo.com ([74.6.134.41]:41681 "EHLO
        sonic307-2.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726424AbgI1Psm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Sep 2020 11:48:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1601308121; bh=NajTNMrfMLb6UXcjRhYpYerQX8PtVBLz0oFgaMINSWY=; h=Date:From:Reply-To:Subject:References:From:Subject; b=XhJeDd0tmfqtC479doAzae4XvHDeSim4IDIB4d1AGPwZb7rJIostTq/IfQWnDp4xczOnOT8tqY1F1UjDGp0o54YkAnjg3aat3/hcwc+bGkzOcPWpaQ6FDQE2EtraiMqjF34P71yzwtwg/QF5mcKB9Z0TT8mWcfkkkm48SgyLHeihdFbJ2A63KPA7pczgaz8hBybJodj5qHnH3EGlM6Di69fiCgq6nqxiioFhwEnEOaOX6onhhD7o7YSaKOhSaica3jwwsGFiJTUNr5iNqCp+y+tbXbijmPe/n6oeLvnEv3oICc1PoKuHfd7ktnDf7c3UG8eq4cav+DYakCTbBPBLwg==
X-YMail-OSG: f8VceZcVM1kYK9a8nJPbUPiKv7upkRAZ.pI.r3t4JKZvHGnoNcwkNnR3cvpZ9gS
 IQHU33Sr7gg_z4y7NyEISMW1LpULTUvp1uCnPz7iyOtdpro_2f6ICisYsUZZbg11_B8QvDtHf0Fg
 ibmegczgcst6xSifWDKpFx.YwUkxw97IGZ4PNMPQ0JVkp_rlJpQTiNNliw2RKsLGv9fblyiwD0x.
 lCfDRij9uaIZKQpGyNl3QKL2RBFi04clSHE4bRWAXhyA.cQYsERIsqL3AAktHmZN.aZTUKmjxmR9
 WVc_aCwZK0RmZ8mBAXctqQq1t2kgDap9IZYI22DRE9Ip.N5fdeYjllustyJMJ_1DCiD6n5JghkLG
 UnaYwzq2Y0hw_kVuSpsjopuFFLPQKL99s2flfCtzybsS01jGBaLnCSCOXWtOQ4qvRBwyTul1G2pY
 1i8J0vC7qXXleaa61dRpz5ECQ5LNyx0eQz7UArV2hcGROal8lqmom9neLTq.hMcWnFG5tpJtK9.e
 2lMdU1nSEQxtIqk84yIBaQOCX883HFZqXb_YOH2vF5u1kgJtwT8Z9UF.UglW8rBY4AzOjGIKfLTE
 eI97OnqH_Zp4SCsEY52jjPGA9dzz_VBeSGHTq_BCRqZCbNhlLUO5ftxicbpfC3bNlQulnZvfxwTd
 o7LXsf3egCNsSROxWsikgsDdEEQw1gQg4hbJqiIS5Y2YD_RutFOd3rMZh3Env9BKRsz3tQIKMmxc
 HRn0vG_eD3VrZHrRcx4hwTChxccUo0WfFqUVfGdWLEiRTKrrsfo3f_TVRBwH4idP_MvusJvTIf45
 kTYvfyzRtbn_QrgMtZtzdbTGF6UN2T8U0XzebSuail8Ic0OKBqpa3dTScFBCVzBpzFmOYYiRI6pZ
 goyuEdnEsEZDDKWpJlRMqY21W6TZVFn4JRG9w_1xvMU2.GVbeSJkI6wbPC1WcNG3ymmV5xbui3YY
 8321MphCVy6YfiIJ8yIhBIJsy1QTQb1LvTbyyDTfv6v6XrfU0cJdy1vaaK2JOoDXu2WaCtBqv7K8
 g3TV3rZxZp9J0jkFWxTVn_Uikps.Y4pAoSgeEJLtv8YRFm7NrQF3HVvjFnkNZTwq63gcXQZDDApN
 OlerG0OY5KlexOMMh_hKKePjHp2dpqWYZ14qYiIOGWhzJEQEGNvEkKxUQ3gD7zIyE59Zx0huKqg0
 4qJyuOaetSwMdY4FdKfSuwoNerr2cyHf9X6V6pxnREfcq1a86HwI9wOUFM5.MWsy1WSr9Q1OGlG5
 efeBQ1i80jcBFgyjy3ESbWglZCRKfzQcSRVXD8bmraqAjUdDVSG1U1V_vWyfQ2NZY9QlCTW.4KXX
 JeniqdCGgCoApqIv1RhPkpxQJogkZm_qY8Ua.kIqZCRduH80Bcamspo6_n054zqgpFGRbs9pQdAP
 MPbSRwGEagHMOm83uUA0RRTeH3RrcWHg8oMRiTfL4tKSfUL1uUthVcg--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.bf2.yahoo.com with HTTP; Mon, 28 Sep 2020 15:48:41 +0000
Date:   Mon, 28 Sep 2020 15:48:37 +0000 (UTC)
From:   Ms Lisa Hugh <lisa.hugh111@gmail.com>
Reply-To: ms.lisahugh000@gmail.com
Message-ID: <1807460202.1509517.1601308117212@mail.yahoo.com>
Subject: YOUR HELP FOR THIS TRANSFER.(Ms Lisa hugh).
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <1807460202.1509517.1601308117212.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16674 YMailNodin Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:81.0) Gecko/20100101 Firefox/81.0
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



Dear Friend,

I am Ms Lisa hugh, work with the department of Audit and accounting manager here in the Bank(B.O.A).

Please i need your assistance for the transferring of thIs fund to your bank account for both of us benefit for life time investment, amount (US$4.5M DOLLARS).

I have every inquiry details to make the bank believe you and release the fund in within 5 banking working days with your full co-operation with me for success.

Note/ 50% for you why 50% for me after success of the transfer to your bank account.

Below information is what i need from you so will can be reaching each other

1)Full name ...
2)Private telephone number...
3)Age...
4)Nationality...
5)Occupation ...


Thanks.

Ms Lisa hugh.
