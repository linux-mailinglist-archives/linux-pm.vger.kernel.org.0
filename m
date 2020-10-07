Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C2FC2863EC
	for <lists+linux-pm@lfdr.de>; Wed,  7 Oct 2020 18:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbgJGQ3P (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Oct 2020 12:29:15 -0400
Received: from sonic313-13.consmr.mail.bf2.yahoo.com ([74.6.133.123]:39240
        "EHLO sonic313-13.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727033AbgJGQ3P (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Oct 2020 12:29:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1602088153; bh=PxMwWzXvs+dqOoH0/FHvFmQpYH2JguaCUHYAVLLmaiw=; h=Date:From:Reply-To:Subject:References:From:Subject; b=BYUpui7n3XZ3A3WOCI+c+axsdjFRRR8Kj/NhfK7wk+AUcR7GUA+Gv4e434PqYaCZh6mtxwLtquwlIFuEf6Na1HFVhrSaE59rTdxRSZ0RkX9n2MjOOUpOk4M55oCLM0oKHCRtRdOBsEwr1v4qtqlQCy5wj6GuiM8NzsXsrQ2x8vtxmrnAJa7EFLMe2Vi7W83Bz+WriWB39WwYman6xOYQE594fB1Uif6xt25GguZHaBodAWnLDKUS40D9s4oOHcPu57xObw1+bmHh0R9IiqkOzz2tSlD2xx/+J2sB/lrAGd87BJwAeLU7m5H2hwTbsl0A6klNoHBZ+PB5e4S50qsQcg==
X-YMail-OSG: hff22QwVM1n1lr7kUhvwHmB9d.SXs.adS5qmrkMziCP7qYJ9pOzG_a.Jx2ZQdFI
 C.SumHH6zu8GKC8cBNlJ8SARPLEuET.ZZ7.NCDhxfsZS7kqz8pG2I63tcuGf_4aTEuNmPBepRmpd
 rXYdcNAdfpeTAutwPy_UjIZs8MqWFFNDBsh_tKhoZdZSyIhRpSEMkrr2fO7hNv93wFwq0fZf9JrA
 oWBAfS7o4CJb6910ZfCfyUn9r23w1J17jPO_m_l1498U3_cNbD4qjgehHdaNq9fXVPTgnxeH69Wj
 yjKpEVjlxb90g_.Z9MJtxVNKM6laAdSgXa.5Xu403O5NBGVAQKrXUpBHCxlWneTJMfqpd2AYYust
 WswH5DyBwOaJr6GQw0XxSRw5.uTzgajso_cEsmSNvcF4tt32Ay.lVUr5sh0Ij1r_x92XGQUga21H
 IYNF1yTUy45.r0RSpyy.mXJcYY9.r3tdw5r28Mag6S5EEj0nih3UdDyLA30o_0BNE_BveeGP3kkX
 LiwfaKUAB8WD.ZyO4zAioik11yttXhI8FY6EpOOiP8U4P1mPHfefZPo98qRdmegPTPn8t0VUEIAV
 5On5c0In5O44vVN_5cxeq867PX.5ixfR50.mwRL71s5Tv_M8w7SZFW7HT26MqcMGeCcxUHHprjGb
 ACBX0sMZ_OpVytBx0Y.f8pW51q3T_32iWy36i0GyJboYWWgvHUjcd_bXS7a8Mz3TVx0vmw1dbyE4
 RbrcotyrMj2o5Wp_BRy2ZhKGwht.ue6b7dywa_0XZStuWqr3pPAcGTQJmFCPyy3Ir1TbpsZN3uai
 2IptIMGz8dk2gSoDG6AFWl1yOg2CHY7rBKSjFqx4envIzFt_diyjsNw.TINVFTlVAyIljaMGNHF6
 CXBngo_a9Bt9r1LJFpxCl_CNYnJTZ9I7lCeMnaOPT0xiCsiF5Ms3FXmuSLwsUVKpAtV9XVodP4WT
 l5RfdKAR8TRWmRnvu9zQDMc_Xl3i0Dl__mmAYZLwHEOQxlw2bdrTmXWLWg8u37c_Hq0_BQS_DVc.
 VKa3WATcbYuU05K86Blp6FGPUqGiDVGvlM840nH0tjsNSVYLpaE6hWk8c9udvxN770bLwnUPZrOX
 3.6spxFK8IH7Uulrh4eTvsa5BhvSCgf9jW.mjVG_DDI5cJ1yiobbmWlGieXX7216ZfjmejOGfcCC
 LDm9ngoz4O_TgbwHgyFSV0nvCvKcWxFNwYQ.yNXw9ftYfWJk8QI6wkpMtZuij1jrProlGSRBJFcy
 vFGCe7eKaKKBnVuSJxpWfk8IiEn3PMCe5AqM7EFzz0POq3PdJFbVwThiS9ZMeYO0hvN4FP7NOwwK
 x_jOJYCG_.084eLouohjeMp6aR2lXmRAuBDPMHGKlJqyaimMljVMMk7eMwnoxWVeaoqnIxN3vvWq
 uF140tj8r3xk2KJfa5Hy5t2WORUBnlCgATtBoFMO9
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.bf2.yahoo.com with HTTP; Wed, 7 Oct 2020 16:29:13 +0000
Date:   Wed, 7 Oct 2020 16:23:24 +0000 (UTC)
From:   Marilyn Robert <fredodinga22@gmail.com>
Reply-To: marilyobert@gmail.com
Message-ID: <1187042417.143758.1602087804794@mail.yahoo.com>
Subject: =?UTF-8?B?0J3QsNGY0LzQuNC70LAg0LrQsNGYINCz0L7RgdC/0L7QtNCw0YDQvtGC?=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
References: <1187042417.143758.1602087804794.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16795 YMailNodin Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.125 Safari/537.36
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

DQoNCtCd0LDRmNC80LjQu9CwINC60LDRmCDQs9C+0YHQv9C+0LTQsNGA0L7Rgg0KDQrQiNCw0YEg
0YHRg9C8IDY4LdCz0L7QtNC40YjQvdCwINC20LXQvdCwLCDQutC+0ZjQsCDRgdGC0YDQsNC00LAg
0L7QtCDQv9GA0L7QtNC+0LvQttC10L0g0LrQsNGA0YbQuNC90L7QvCDQvdCwINC00L7RmNC60LAs
INC+0LQg0YHQuNGC0LUg0LzQtdC00LjRhtC40L3RgdC60Lgg0LjQvdC00LjQutCw0YbQuNC4LCDQ
vNC+0ZjQsNGC0LAg0YHQvtGB0YLQvtGY0LHQsCDQvdCw0LLQuNGB0YLQuNC90LAg0YHQtSDQstC7
0L7RiNC4INC4INC+0YfQuNCz0LvQtdC00L3QviDQtSDQtNC10LrQsCDQvNC+0LbQtdCx0Lgg0L3Q
tdC80LAg0LTQsCDQttC40LLQtdCw0Lwg0L/QvtCy0LXRnNC1INC+0LQg0YjQtdGB0YIg0LzQtdGB
0LXRhtC4INC60LDQutC+INGA0LXQt9GD0LvRgtCw0YIg0L3QsCDQsdGA0LfQuNC+0YIg0YDQsNGB
0YIg0Lgg0LHQvtC70LrQsNGC0LAg0YjRgtC+INGB0LUg0ZjQsNCy0YPQstCwINC60LDRmCDQvdC1
0LAuINCc0L7RmNC+0YIg0YHQvtC/0YDRg9CzINC/0L7Rh9C40L3QsCDQvdC10LrQvtC70LrRgyDQ
s9C+0LTQuNC90Lgg0L3QsNC90LDQt9Cw0LQg0Lgg0L3QsNGI0LjRgtC1INC00L7Qu9Cz0Lgg0LPQ
vtC00LjQvdC4INCx0YDQsNC6INC90LUg0LHQtdCwINCx0LvQsNCz0L7RgdC70L7QstC10L3QuCDR
gdC+INC90LjRgtGDINC10LTQvdC+INC00LXRgtC1LCDQv9C+INC90LXQs9C+0LLQsNGC0LAg0YHQ
vNGA0YIg0LPQviDQvdCw0YHQu9C10LTQuNCyINGG0LXQu9C+0YLQviDQvdC10LPQvtCy0L4g0LHQ
vtCz0LDRgtGB0YLQstC+Lg0KDQrQlNC+0LDRk9Cw0Lwg0LrQsNGYINCy0LDRgSDQvtGC0LrQsNC6
0L4g0YHQtSDQv9C+0LzQvtC70LjQsiDQt9CwINGC0L7QsCwg0L/QvtC00LPQvtGC0LLQtdC9INGB
0YPQvCDQtNCwINC00L7QvdC40YDQsNC8INGB0YPQvNCwINC+0LQgMiwgMzAwLCAwMDAg0LXQstGA
0LAg0LfQsCDQv9C+0LzQvtGIINC90LAg0YHQuNGA0L7QvNCw0YjQvdC40YLQtSwg0YHQuNGA0L7Q
vNCw0YjQvdC40YLQtSDQuCDQv9C+0LzQsNC70LrRgyDQv9GA0LjQstC40LvQtdCz0LjRgNCw0L3Q
uNGC0LUg0LzQtdGT0YMg0LLQsNGI0LjRgtC1INGB0L7QsdGA0LDQvdC40ZjQsCAvINC+0L/RiNGC
0LXRgdGC0LLQvi4g0JfQsNCx0LXQu9C10LbQtdGC0LUg0LTQtdC60LAg0L7QstC+0Zgg0YTQvtC9
0LQg0LUg0LTQtdC/0L7QvdC40YDQsNC9INCy0L4g0LHQsNC90LrQsCDQutCw0LTQtSDRiNGC0L4g
0YDQsNCx0L7RgtC10YjQtSDQvNC+0ZjQvtGCINGB0L7Qv9GA0YPQsy4gQXBwcmVjaWF0ZdC1INGG
0LXQvdCw0Lwg0LDQutC+INC+0LHRgNC90LXRgtC1INCy0L3QuNC80LDQvdC40LUg0L3QsCDQvNC+
0LXRgtC+INCx0LDRgNCw0ZrQtSDQt9CwINC/0YDQvtC/0LDQs9C40YDQsNGa0LUg0L3QsCDQvNCw
0YHQsNC20LDRgtCwINC90LAg0LrRgNCw0LvRgdGC0LLQvtGC0L4sINGc0LUg0LLQuCDQtNCw0LTQ
sNC8INC/0L7QstC10ZzQtSDQtNC10YLQsNC70Lgg0LfQsCDRgtC+0LAg0LrQsNC60L4g0LTQsCDQ
v9C+0YHRgtCw0L/QuNGC0LUuDQoNCtCR0LvQsNCz0L7QtNCw0YDQsNC8DQrQky3Rk9CwINCc0LXR
gNC40LvQuNC9INCg0L7QsdC10YDRgg==
