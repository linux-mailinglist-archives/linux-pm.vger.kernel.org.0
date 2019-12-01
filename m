Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4265610E230
	for <lists+linux-pm@lfdr.de>; Sun,  1 Dec 2019 15:32:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbfLAOcO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 1 Dec 2019 09:32:14 -0500
Received: from sonic303-21.consmr.mail.ne1.yahoo.com ([66.163.188.147]:33872
        "EHLO sonic303-21.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727200AbfLAOcN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 1 Dec 2019 09:32:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1575210732; bh=zPC9p8T5S06DA73PD5F75wViZ/EpBpeYylTS7OqjCU4=; h=Date:From:Reply-To:Subject:From:Subject; b=M95eGAkWI/5vSrgNxGRtCawB/oB3oPBh8V7NP7nT6NArLPvaGW9n7eR53cjjzqWL8tMJI01LfZaPP9tHxLvcWLMffIvAJN7T69MDTOs3ujNhtS/zJaUr524bAoxIFqHsB3zOlEpMH32vpCuqiwL9GjF+ZuZAkZENSPwlsecNoh4119Zd7WaYg1aZte3R5JgXQ0Y2CYBPb+zP7Q74dej0eawXfd9oX2YIscblpFeRzhNoqn683Pz0mO9ohYqZFTrqTfsUgLZqTQmEOjIZU30jmdjzOKYX4q5CNN0qTt+L1kxqdw7DSC+MofVNEMK06jlx06rpapS8cl6uoltRnDM/UQ==
X-YMail-OSG: R6n8AOEVM1l9H4zIb2.SC1q_MoDxRayOTlveZ_GalwUeBLy9rjVtQA5kNjgbrKW
 SJKwhLYd67YwycriHehvrOEU3TG0ijyDqQYbAZOk31i2tCKb5lfu5y8TyVm5ryV3m5gtcLYqN1Fn
 IPtCST8tFcK9B.bKQT_DcllCbruWjiqTZeBQ8Ws.vJh4DiYyx8RCDeDvB.f995cLQD1EXFpfSnlT
 J1b7y83Rn22ZJVI4WAzU_soce.wDKks0Y9QOEKlCoBz3kOXVFFLnQnzUv_KqvF33ID8lkKzWM_an
 zOJ0n2QKqOs0T2FteA26Fe3JGu93TA7yrWWFegcTQ0shMufQSNNL.wZQkzHQrrPYfaPpzXdjZteb
 rOix3bXUq5.lT8F4C0eexLJKBl1wdNjXGe.7Eis4KgzPUB.UG7TYSbgzWbdw3kI7IYrbXrOAcnKW
 76cIQNFNrf_r12frD.oJsv2l0EBI0ietbn2OCjHgmmEeBBuCGBySirPjVoy1PzYdsP6I3GPsNUBe
 p1uVr1Rwr7Sy45wAaV87Z8SG5Oi58P8b5JsXdpnoHTgOk0os0Wv.2zDY19SqYKcdZ9cvQqNzblOy
 _ujo0sQhxwFBjGl8gxzuDF.kXl4Mw0jQVQ1C9J1tnHR4RHWFliaWfhQctZSwcgl2TuOIvG0Aayvt
 9LeUEUDtDoQq.4v4Yozbv4H..SUIpVc0JrDPJxSWRLap_opWOSEOmCiS.FFMKr2V6y0noYxFy23K
 yhaouF2K1xAF4RBsNukfZSsh.ftm8aXhK9KbC01W6XlED2lke1sIRkiuifAWFAdaBI2xom.obm2v
 ECMXJ4dlB6nAt.w5gpa_89u9ABZuZncGKIpq91MOKyRpMKgCCh.ceHoL1tj6shSEvYlvTLPwhQeO
 mVqyU.93Det0loxDsUf7awpBX0ik1_h2ivqPXJS._VsWK4zEiUIcSu4v2ypUpvKjOqrtin3IAof7
 L0JhQAAUDaSFcPx5PpCcF6ezEvzs8kaDUMBDE2vj3kVuVX6orGzrDHdAAnFu1nxRRD_uff9_4VXL
 0.kw75xPVWGiuZUrzX64OsUTKlspffiXriOyZc7O8kUvQcGZpyJQVMy2uVLq5NIdhEPIMeJ8TuBD
 uB2CLYDKzNyY_10NUDhetbiUUj_iQ.2tIiP_4VRtl_T.7kotu3x2abKVJWwiO413yVdfZo4JfHLf
 rW4.gHF.ax594BTkPh9smGEGep4H0cWBKL5BZzA7eKPYHW4CyvQqTIFH5c.bYDDw36YNUA6SVqSt
 Zt9sEu_1aX8OkYSMPFSXKODAd2ihXKwC.hX5p0N3cw17CavclO2LxfBXRJ1QIiditf7fyc0hdmNP
 4c8XiizxC
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ne1.yahoo.com with HTTP; Sun, 1 Dec 2019 14:32:12 +0000
Date:   Sun, 1 Dec 2019 14:32:10 +0000 (UTC)
From:   Ms Lisa Hugh <lisa.hugh222@gmail.com>
Reply-To: ms.lisahugh000@gmail.com
Message-ID: <132215580.1347666.1575210730440@mail.yahoo.com>
Subject: I NEED YOUR HELP FOR THIS BUSINESS.
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
