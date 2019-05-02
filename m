Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB23111666
	for <lists+linux-pm@lfdr.de>; Thu,  2 May 2019 11:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbfEBJQb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 May 2019 05:16:31 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:59867 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbfEBJQa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 May 2019 05:16:30 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190502091627euoutp01bdeb166dd3fe66ae0e6c49ac3c74bded~a0vj3sp6i1271712717euoutp01W
        for <linux-pm@vger.kernel.org>; Thu,  2 May 2019 09:16:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190502091627euoutp01bdeb166dd3fe66ae0e6c49ac3c74bded~a0vj3sp6i1271712717euoutp01W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1556788587;
        bh=B3tN+K7lE2MQpgRT2CZWdfYL2aEGtKrilC8xr415AdA=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Kz2giV5Ak2DiL6P0NYPsiSqWt51/ACPw71NbEH0Ggy3iP0emuBKDMY/6q7lz9tKNj
         6qxqrn2765mmz0xN+WIUQ69rvQ5hcBYIWp8ZEK6sQ399Vs5vcub9DnsTu8T9QAimHA
         GEhQ3IuOsZUXnFGMRvHGB/KZQAM/RNDWQSD2slxA=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190502091627eucas1p12bb661f6e576e143f4075012aa2358fc~a0vjIC8ns0110001100eucas1p1j;
        Thu,  2 May 2019 09:16:27 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 25.0C.04377.A65BACC5; Thu,  2
        May 2019 10:16:26 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190502091626eucas1p266773ad4e83e48578a80dbd5bd3a49b9~a0viW56T42997629976eucas1p2z;
        Thu,  2 May 2019 09:16:26 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190502091626eusmtrp2b756b2912a580528586be9d526a50263~a0viIxPg52363723637eusmtrp2g;
        Thu,  2 May 2019 09:16:26 +0000 (GMT)
X-AuditID: cbfec7f4-12dff70000001119-83-5ccab56a2494
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 17.50.04146.A65BACC5; Thu,  2
        May 2019 10:16:26 +0100 (BST)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190502091625eusmtip275ca303fdaad4ea1436741f1168956a5~a0vhJqNJa0616106161eusmtip2e;
        Thu,  2 May 2019 09:16:25 +0000 (GMT)
Subject: Re: [PATCH v3 1/4] include: dt-bindings: add Performance Monitoring
 Unit for Exynos
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, b.zolnierkie@samsung.com,
        krzk@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        cw00.choi@samsung.com, kyungmin.park@samsung.com,
        m.szyprowski@samsung.com, s.nawrocki@samsung.com,
        myungjoo.ham@samsung.com, kgene@kernel.org,
        willy.mh.wolff.ml@gmail.com
From:   Lukasz Luba <l.luba@partner.samsung.com>
Message-ID: <e29648bb-9e94-1b02-5c6e-03b099ad807e@partner.samsung.com>
Date:   Thu, 2 May 2019 11:16:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190430223358.GA22052@bogus>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sf0yMcRzHfZ/nnnuemmvfLvQZJm6YH1O08DW0MuP4y482v244eVZRV+4p
        Sn6UzamUWs3J+XEylFOqc7ga1eoqP9IVhiKsTjYVo2Z+9EN3T03/vT7v9/u7z/uzfTla3sZM
        5iI0sbxWo45USN0l9+p+Ny7Yd/eJamHRucWkNLeYIa/7PjPEaGtkSGZHF03s9hKWPDvRzRJz
        xyuGvCi/KCW9GTZEcu0VFCmytbHk+utmirxNLpCSkw9tLBl6YGVJTfcphvx81I6CPJWFlwuR
        sszQxirNplSp8s6148ozFhNS9pqnbZBud1+xl4+MOMhr/QJ3u4fnlw7QMZ3S+AF9CZ2EbjJp
        yI0DHABVnTY2DblzclyA4H1OldRpyHEfgryvIaLRi0CX/IcefdHQOcSIRj4CR1cTLQ49CNo/
        5SBnygvvhNuW86yTJ+AZ8Fend72gcRENKQOm4YHjpNgXrKYDaYjlZHgNGDc40xI8E3KzKygn
        T8Rb4UNdiaupDHvC4/MOiZPd8HywV+pdm2jsDa0OIyWyD9zvueiqAziVg9ridkosvRpuNegk
        InvBl3oLK/JUGCozjmQESMrIQyIfgY7MSyOZ5VBT3+xqTOO5UFzuJ8rB8M5opZwyYA940+Mp
        VvCA7HvnaFGWQYpOLqbngCW9aWTRJMgv1LNZSGEYc5hhzDGGMccY/u+9giQm5M3HCVFhvOCv
        4Q/5CuooIU4T5hsaHWVGw5/u6WB9nxWV9++pRphDivGyX2cfq+SM+qCQEFWNgKMVE2StD4Yl
        2V51wmFeG71LGxfJC9VoCidReMsSx33cIcdh6lh+P8/H8NpRl+LcJich/Y+WH6HrPKY6Aur8
        j14uWB/DPuprSzvWsPm4Uu5gg+3f114ISuxedajFJ70o60Zgs+a0Y9u3pbHbmSnmRnr91lbr
        vgDVptJ09bInstotgbNm94cNUVez3g9oai1LBs2BG5M1x6iagKojK3V3VSHP41u8XqqmL75Q
        m5miY2c27YyoVEiEcPWiebRWUP8DENpKoHADAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrEIsWRmVeSWpSXmKPExsVy+t/xe7pZW0/FGDw+x2KxccZ6VovrX56z
        Wsw/co7Vov/xa2aL8+c3sFucbXrDbrHp8TVWi8u75rBZfO49wmgx4/w+Jou1R+6yWyy9fpHJ
        4nbjCjaL1r1H2C3+79nBbnH4TTurxbcTjxgdBD3WzFvD6LFz1l12j02rOtk8Ni+p9+jbsorR
        4/MmuQC2KD2bovzSklSFjPziElulaEMLIz1DSws9IxNLPUNj81grI1MlfTublNSczLLUIn27
        BL2M5Rv/Mhc8Y6v4O20DcwPjStYuRk4OCQETiTPP/gPZXBxCAksZJU60HGODSIhJTNq3nR3C
        Fpb4c62LDaLoNaPEh+f/mUASwgJxEuu2zAQrEhFQlPjdNg1sErPAWmaJmWvuskN0NDBJvP66
        n6WLkYODTUBPYseqwi5Gdg5eATeJ+QEgrSwCKhIzJu0DGykqECFx5v0KFhCbV0BQ4uTMJ2A2
        p4C2xPn90xhBbGYBM4l5mx8yQ9jiEreezGeCsOUltr+dwzyBUWgWkvZZSFpmIWmZhaRlASPL
        KkaR1NLi3PTcYkO94sTc4tK8dL3k/NxNjMD43nbs5+YdjJc2Bh9iFOBgVOLh/TH1ZIwQa2JZ
        cWXuIUYJDmYlEd5be4BCvCmJlVWpRfnxRaU5qcWHGE2BnpvILCWanA9MPXkl8YamhuYWlobm
        xubGZhZK4rwdAgdjhATSE0tSs1NTC1KLYPqYODilGhjNas/U2ITfbOViLHH3vyP+VirCP8zs
        y8GgEkabFM8b3Ef4AkPCtI5ruy3wM75zabXV5LDmP/t/aT7xecD0oU0i7Adb7q5Dx76tW1cr
        Y3Qn2ZBzW0Sw/8ulMq8ar2/O8325ztmjdeXjqtthXp8abvHw/Dh6otrX6OVpoad5/pXSW9w8
        585XkFRiKc5INNRiLipOBABD6H4rBQMAAA==
X-CMS-MailID: 20190502091626eucas1p266773ad4e83e48578a80dbd5bd3a49b9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190419134820eucas1p154e839769af0e1b8bae17ce3efa0ba93
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190419134820eucas1p154e839769af0e1b8bae17ce3efa0ba93
References: <1555681688-19643-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190419134820eucas1p154e839769af0e1b8bae17ce3efa0ba93@eucas1p1.samsung.com>
        <1555681688-19643-2-git-send-email-l.luba@partner.samsung.com>
        <20190430223358.GA22052@bogus>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 5/1/19 12:33 AM, Rob Herring wrote:
> On Fri, 19 Apr 2019 15:48:05 +0200, Lukasz Luba wrote:
>> This patch add support of a new feature which can be used in DT:
>> Performance Monitoring Unit with defined event data type.
>> In this patch the event data types are defined for Exynos PPMU.
>> The patch also updates the MAINTAINERS file accordingly and
>> adds the header file to devfreq event subsystem.
>>
>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>> ---
>>   MAINTAINERS                           |  1 +
>>   include/dt-bindings/pmu/exynos_ppmu.h | 26 ++++++++++++++++++++++++++
>>   2 files changed, 27 insertions(+)
>>   create mode 100644 include/dt-bindings/pmu/exynos_ppmu.h
>>
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> 
> 
Thank you, added to the commit message for the next patch set version.

Regards,
Lukasz
