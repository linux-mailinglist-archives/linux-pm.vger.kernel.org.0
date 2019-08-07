Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90C268474B
	for <lists+linux-pm@lfdr.de>; Wed,  7 Aug 2019 10:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387858AbfHGI1k (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Aug 2019 04:27:40 -0400
Received: from sonic306-20.consmr.mail.ne1.yahoo.com ([66.163.189.82]:43727
        "EHLO sonic306-20.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387857AbfHGI1k (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Aug 2019 04:27:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1565166458; bh=tPdyM4f7Tq8kspt5syr9wxbiHLUxanV8lkCr2Pkkkas=; h=Date:From:Reply-To:Subject:From:Subject; b=E6sM2NpOWGsDM88ZbJzXdlsONrO1IhkXSLzCbIciPqy8T+x82eVNztt0epZsA+G2QdJnRH5HelieyhnYtvyJ9KlO4IWiGZv/3gEEwfjAdvvXfBLkQ4wtEkoLJ1+Zlt4y/ugkhRja3OrV7zwzrDl+S8UC+dYiUh6Vob+yzBA8ypajRf01dmaQuBP8CmJ44wYJyVPPlDEmDdolmFYAG4JoF18eFyYbLDmPiGRbE4t7XBUOLCZ3eVmBbBlJ1rGscLMdJsbRs2w7Qu/GGw7LlxtsXkK+Qff3gYqOpJGrixKh5WtaBm0Vh0Wq8C+BjCtGCQSTJWPLsi63DYAz9vQw+YiIeg==
X-YMail-OSG: dqXSJDAVM1mfYDujPjz1ZCy11zOqO5.4mPIxKEUIKMZbPYZrYgOuCJxYaf4Khmf
 gN_syQdLNTRcRsx8HW4yQ1aIKJIPY.amGaVQbmwKdAEkDF4avxqUGPJ3_6s_iBNZIss2I9yT9FWu
 2kbEeK_dYS1GS1lX0A9iWs.ckMLOMvzjAer5B77Pfn20k_vmqNGbhO_AFn_bcf6fA.QIL7f3j9DN
 33si9Cs9WW6NGJxupb3ZUfeAT7mBSJv9tQd.wegtbjBMAYgxpqexlNJuNaiMSO_XAz5tetdTZZ77
 ZNPzpKCCspqVBIMHDUWl0jke76SNa2XJc_FievzjbHvgJwLkBiTB5YGSSLe6SfJih8ME_TN0NPwU
 iBcDia9BLH7tqXdC7AoRtq1kF1NnRbg6TTj88asNPpD0mK724dNWaJN5LWtKIuCxv2xZ4tkOiVRp
 zb7FWrRQuiD3Q5pSPRwEa7zZcerzJ7lgAX2gczoY9P_TJmZecv.5tfM1cYBTPIpYqShiYaAmmYyn
 HhF_F15v4KMnQj9cc9up7BRzfq5ual5qRIj9a5Qv_mtjORo0.QmxiI8wAdpYOYtz5LZMwipfdR.k
 CApOYixlBb0SnrO1jQzvBrHpUFOYMKmq9o_6IHHzXTnjc.rzuJzGRK1pjCPNhl5HsRLYDHlChGeM
 fQeSjjOJT6SgenyjfXNBhKldHaSxkCDGtjhWIYk9L4UJNBvlphmOR2rYZBU5x6N2VyJ8LtMNIFNB
 nHgz03M2Mu3E3TX2DQLpKrBunxiVnYSZZyinKaQeUPkW4C2VzovAyHDTpUURvXfRPKr4dtyPaUpq
 vL0HBTCDeopQ6qlzrBQw21HECwWwDGO.VM0RjGv0Xwwr_o_UeEoDD3OEINaQHF.oE2sEx5NS.5AG
 5J0R8iXVZ19Y7Y0MeY8IP75w1D9PghJgQQxFHhgTXHuxAcrVZ.4v0MqwDq.72WlRlSlGvugibpe_
 mxzmTOrzj6gbRPYmhb6Kw2jcNR7F7oR8Ek1jA_p4docrJ5wJSyCS81EDoEzpo1zBqQrUdYFPnKPw
 BSQxwhL2K_5C1A3mWLhVRfL0bgm8T700VkgJCO0f.W6IGAMRcP.iFgzxFX2TNHp8QL0fhkpyRa8b
 s7BxExeXntt4U49GW.078mflFYaCeytkmuTa4QD3h63Snipj5nVmVRkxhxWG8fpEryciRAOrdeKc
 yB_V6xe6h1LX7pAN31OjkZgaKnmmVbZedRhc4BIAGrTq7Z_hxJnF4v2dQ5hs0OPktw_zuKO0OXGc
 DTmtJ
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Wed, 7 Aug 2019 08:27:38 +0000
Date:   Wed, 7 Aug 2019 08:27:37 +0000 (UTC)
From:   Aisha Gaddafi <gaddafi661@gmail.com>
Reply-To: gaisha983@gmail.com
Message-ID: <1626481099.2130770.1565166457031@mail.yahoo.com>
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
