Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1953031A13
	for <lists+linux-pm@lfdr.de>; Sat,  1 Jun 2019 09:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbfFAH1F (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 1 Jun 2019 03:27:05 -0400
Received: from sonic302-20.consmr.mail.ne1.yahoo.com ([66.163.186.146]:39936
        "EHLO sonic302-20.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726058AbfFAH1E (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 1 Jun 2019 03:27:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1559374023; bh=1LKMS8SBaWamW9K3zAVkPh3f7GuSqi0LjsT3aai4KDA=; h=Date:From:Reply-To:Subject:From:Subject; b=HiKdTm9Df3f6MtZcUM5F43WXF1v0sD4Jl9WM37vdR7um/oGHrTfJL++XB9J1XjFTViykjR37ZuMQjOfaIBLiAjV4fTznl9KoX7E6EJL5XfiaUjMZ5iI6aAbTIGTr77ayvEqGR3JefT/ujgImZauTkwwaKfjBmh6oOA3E6c16w+HsDOGBPgLK8R1eBTdo72f7XiraVPStyH/WSZkR1N2rPYWrVKZPLe/pIKiI2UFYzBnDKKUaZgKoaLUBiJBcTIl7I0VCIo38fkMbft/7Hut/LYEK16FWnIeRpcfnCJxrkAHRyB64Az1LdVqJO1gwi4wQ38J7nHcylJSxEBDAmx070g==
X-YMail-OSG: 8YTt3XoVM1kyS6eiyIb9ndeDld5MN0wfJEvd5OWxLvPJFX7JMuh5fSz9ctjad87
 O86m_aKPMqv0A4D4WcgHfQusGXQbvK_szek6fFg_YuiPhii1Qp1E5wXJ.foIpHyajrUXheqHyMOj
 XdTnETokZ4hlSDAOfazB8uErdySctfx5eObH2CIaxHaEBwatoyOTSlr.VjPP7imy5SGoHykOfjw_
 SarhJu6MsEjrGfJsh2Pm21F.8JrAGTnqtsc8f9irxIPj0OFLpYNpVc9Cdv1RyCTJHvEsCbUidzYg
 bs0s3sDxe1CwdwbUJPMk2XH.S19Ew46y6zBNVqh_t1WyHjI.6aF7kuKh0nVrRrh4kWir433OsM_k
 8Btzqje08CrWgqxrBCzBFD9qBb2xc1Yll0hQ37XU2U9eBi09VkotWMmrKDvwDgXpZluqM_UgPjdb
 2ET.C__Ps.7q9gYjhSIyBBKkDqHQuPm3HeTzjy8kvDRprZaKMQJD6.0RAIWT2oSlJwp87VRLbxyE
 RxaFWfXWvwRaF6EpIYmnHhmdF3fJtBjKroRMPovXGi41ilZ9dKDdx.EAi55TuM4MTcvN4bQr.oFd
 Ck1I4WHiz3M0NJVPoZKLLct6S_5lkMOW1cNb.u2lYOtLOLSSxfAUphoTCzix2A.MEtv2dAakAXJ0
 dOo1ihqvfF.PRJQt9iq.9.CweWVaxacOXfFI5mresnhCraGGDPMF71c1mRzxZTP7_do4xZjZsRO6
 sogaRKP6xQDsRHjqnWBHg7p4N0huQi0huU6kSuK7KlXOWwnYneesza.k0N.yXkF2RdHwoyNFifVq
 Fhzk4cVac05SI_Lx5CUmMTzaUX5QTtCLy_qWPSfkWs.FuhiraPsG5D73kgkgwNhvJ7cS4EvWUzBA
 m8Ds3ulplZgbaIpuVhD.uN.BnjLYz8t2Lox2sA1TQXt0UmIuaH_84T8VJ.JjrCYxfN9IeEBeEVPv
 Q7WHbBg_meWaipE5YdLtdfXjAyHddrBwr1204IQJi.RbnyWp0gGuUqKI4sDEMOMnVTDmcKur3Wo7
 TOyFxIv81OnzAMK5Wzzwufnthc4o5Za3pmQHEs75.zO9KzKemHkyCtIb_SuScSse2TmfOAy9mMNs
 g.yDlcMG0vf6oyjAqMZa_egXLLcNKqLi9yPrBOfpL2Jq9tb3sVA2cFguWAIz5i5pNBpxrD7KDECC
 zUh90lT4UxnN2lEqu5MGNvNIM50YoZvkIWG0gD3BUwQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ne1.yahoo.com with HTTP; Sat, 1 Jun 2019 07:27:03 +0000
Date:   Sat, 1 Jun 2019 07:27:02 +0000 (UTC)
From:   Jay Oga <ugojacob70@gmail.com>
Reply-To: gfred12@yahoo.com
Message-ID: <62512912.9887127.1559374022836@mail.yahoo.com>
Subject: Dearest Friend,
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



Dearest Friend,

This is to inform you about my success in getting the money moved under the=
 co-operation of a new partner from Australia,

Presently I'm in Australia for investment with my new partner who helped me=
 in moving the funds,Meanwhile,i didn't forget your past efforts and attemp=
ts to assist me in moving the cash despite that both of us could not make i=
t.
Now contact my secretary by name Mr Fred Greg in Cotonou Benin Republic and=
 his email address is (gfred12@yahoo.com) ask him to send you the sum of ( =
$550,000.00) in an ATM MASTER CARD which i kept for your compensation for a=
ll the past efforts and attempts to assist me in this matter,

I appreciated your efforts at that time very=C2=A0=C2=A0so much=C2=A0=C2=A0=
feel free and get in touched with my secretary Mr Fred Greg and instruct hi=
m where to send your total share of the money that was loaded into an ATM V=
ISA CARD.

Please do let me know immediately you receive it so that we can share the j=
oy together after all the process and effort's at that time. In the moment,=
 I am very busy here investing with my new partner

Finally, I have forwarded instruction to my secretary to send the ATM MASTE=
R CARD to you, so feel free to get in touch with Mr Fred Greg and he will s=
end the CARD to you without any delay.


Best Regards,
