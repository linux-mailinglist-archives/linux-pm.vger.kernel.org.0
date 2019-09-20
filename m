Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5378B8CC3
	for <lists+linux-pm@lfdr.de>; Fri, 20 Sep 2019 10:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392352AbfITI1H (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 20 Sep 2019 04:27:07 -0400
Received: from sonic317-28.consmr.mail.bf2.yahoo.com ([74.6.129.83]:37923 "EHLO
        sonic317-28.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2393491AbfITI1H (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 20 Sep 2019 04:27:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1568968025; bh=zPC9p8T5S06DA73PD5F75wViZ/EpBpeYylTS7OqjCU4=; h=Date:From:Reply-To:Subject:From:Subject; b=nnDIF05TSjqUOxLwoS2PdR8guus8mBS25qjPu9KiTwVvxlCUkl7nvXnyc71bxEUFfajgDmSUHtwE/Xpb1UqFBCfZckDvRJObf9/Ldw6aXc9eucszhKmg6DK4vjmT/m+4xGDPRwZCppFMViGNHb6+RsQgRbm7KbdTw1QFFJPj4c54R0Hokr519k2LLDm1xX2B/uc6Sr00dbZtmLYn8qRwHcUMjkta9fAa6MbPnFXuS+L5kRIaN9yWlb8WEZBx2pYb66ET6Nlwc+IA0VngUfR0xXZyQhRkgiydgH8i+3b4iM8HNyKtFIG7kXma9rX+a469JC6SkHZWfr0d0c7xVVVA1w==
X-YMail-OSG: Uj75ns8VM1nBezpEbaXbumQT14wfbDNg0VJIB15lkg_.JBthXsG4lTHJGRSxHch
 xmgjl.AJTEPss7tG.ZbybEoHCesV3zFsaiA88FOqnKMMknqNP0hUkWYL4EruZ7ECm2rtWgd2sHvc
 ScriZVmL1CFl3O9tTxkpDDblSTQ0f.BdruNzCeOxbP8I8C4H65KyAUy42J_tL.jXadC8aDhHt86t
 nSlSAUEr_2OpRYQl13qd_GgIYOLc_W1LHrAHivPgXmlfW4myt7K0T.KLJCFg.Hd_UCWNRgFnPO3l
 slb9bSskyYoqSoJLohH.c_ve1hv7X._T4fXL_WTMw1FCGj9RrAfnTi4Ec0HA4dGJD_Lkxpsfbnyv
 Jyh3k0URFL.VqtIyl_DFDOCk8RBWANBvawMrBIVhAxTk9.yBr376dNR9JS3EHf3JVZM06P.BYT8e
 OCvQlv6xuZqa21zTSlNVCrP27zSQF5nf6ln.ImpDw0wnazixvkQ55EM91Xo5PuMJnDrOnYluNu3n
 k_SIxDzkdsVS9dHV2lBteJuXkxbbqgxHoWMaoxVeh5wSCh5uJphKWn._zyoxrstwYC9FBxPfM7Rh
 NwOJ7DOPMV8Z5.v8g3HBiGCzyYKuVMLlgAQUF1w1jlUSbNX421StSgNZjo6zEfqNg7F_7wdZRsHv
 IUNWuhv57_8YA2_AoGdJd1GM.LwVyL6pV2q_XrdoswajDTQRemL9NTxAREyR9cJ28gyxzHvg6Ngo
 4ngJoEOi1JkF1YARXh0K4C1K0x230ZEmssCE2Ta4nFOk_tzvjmcWRjQ.F3mh3jlHl9b3Xl6uDmEk
 gAbSAR9Mav8csUmM9Ay6SR0u1MEHf4QSi.q4AUEn7xrWlx8vOWA8hZD47kw70QhG4IseqlQo2tKk
 2QP_hXs47P8M0rMqCmkqfTu5rq4oNaaAUYv_lubHiSLficlD.rDOxUS_wx1iq2DAnRALpIHNDm9u
 LakqUDOHGN05iHtaaKHLpdKPcQJuMtfAMqN7uoz0JmcVwoEEm95oIRcQzH6AqtqH8qNWq2iqXaBm
 EwJzOcrc14qS9Rh2Mc_lOaKJmUHXitnRhaCKtEbD7C11752SymOaEoiqCTzTbUGP4rLAoK_rJdy0
 WTZmbv1xppBvcf2mbpWZRtgO_K28I3Qvys9KXxcLFuFc1UyyZpkZCx72.XYwECluAy5O4V9KCDBg
 o63TgvgRfacrklBOl09VJD5gluWr436ilooKWXThYSnfwinapuQHe3AmV9caJZike07ytgTzj_RV
 rX.dCjot37txuiAsZV1z_TQs5aoucm1kvNjM-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.bf2.yahoo.com with HTTP; Fri, 20 Sep 2019 08:27:05 +0000
Date:   Fri, 20 Sep 2019 08:27:02 +0000 (UTC)
From:   Ms Lisa Hugh <lisa.hugh222@gmail.com>
Reply-To: ms.lisahugh000@gmail.com
Message-ID: <1074883072.6851247.1568968022574@mail.yahoo.com>
Subject: FROM MS LISA HUGH(BUSINESS).
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



Dear Friend,

I am Ms Lisa Hugh work with the department of Audit and accounting manager here in the Bank(B.O.A).

Please i need your assistance for the transferring of thIs fund to your bank account for both of us benefit for life time investment, amount (US$4.5M DOLLARS).

I have every inquiry details to make the bank believe you and release the fund in within 5 banking working days with your full co-operation with me forsuccess.

Note/ 50% for you why 50% for me after success of the transfer to your bank
account.

Below information is what i need from you so will can be reaching each
other

1)Full name ...
2)Private telephone number...
3)Age...
4)Nationality...
5)Occupation ...


Thanks.

Ms Lisa Hugh
