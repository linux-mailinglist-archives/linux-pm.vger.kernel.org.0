Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E977D332261
	for <lists+linux-pm@lfdr.de>; Tue,  9 Mar 2021 10:55:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbhCIJzL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Mar 2021 04:55:11 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:10204 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbhCIJyn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Mar 2021 04:54:43 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20210309095441epoutp0241ebb4563becb14ca6f38bb47f818d0f~qo-M0CH282912129121epoutp022
        for <linux-pm@vger.kernel.org>; Tue,  9 Mar 2021 09:54:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20210309095441epoutp0241ebb4563becb14ca6f38bb47f818d0f~qo-M0CH282912129121epoutp022
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1615283681;
        bh=8mtqFK0glNIRpotH28XJZC+mz+WL9PP9gk21qobcjPg=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=a0mprsnDG7zMMT6RogLfYFjXlfVsiUV7/Pp71iErocFGvbEwFtq1fXh5bOPWbviAt
         Jo6eSTjKm50DZFWGtH3EGRdVhKMUwEWzFR7XWcZPY/etYR4oFeWN/zP5BQMEbSRWp6
         WQb/yRvHGDmXemTbm9NdqgYopEoqGG/AuXSFRrSc=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20210309095440epcas1p2bffe88cceb960d5c58fca95c3b1591c2~qo-L6-7Hq0904709047epcas1p2O;
        Tue,  9 Mar 2021 09:54:40 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.154]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4DvrCd6Cf3z4x9Pt; Tue,  9 Mar
        2021 09:54:37 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        1A.5A.63458.DD547406; Tue,  9 Mar 2021 18:54:37 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20210309095436epcas1p19f72c6f2d78c7dd708dfedd3a3c8500d~qo-Iv56xx3049530495epcas1p1L;
        Tue,  9 Mar 2021 09:54:36 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210309095436epsmtrp17f1163df094ae3f3dcd6926758051305~qo-IvBlBz2265422654epsmtrp1b;
        Tue,  9 Mar 2021 09:54:36 +0000 (GMT)
X-AuditID: b6c32a36-6c9ff7000000f7e2-97-604745dd0e89
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        BD.6A.13470.CD547406; Tue,  9 Mar 2021 18:54:36 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210309095436epsmtip2f0e2f05dcce8078494c92dc93a79040b~qo-IcKB3n2270722707epsmtip2y;
        Tue,  9 Mar 2021 09:54:36 +0000 (GMT)
Subject: Re: [PATCH] power: supply: max8997_charger: make EXTCON dependency
 unconditional
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Timon Baetz <timon.baetz@protonmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <6c40afc8-4ea7-aef7-73fd-8935e2bfe0dc@samsung.com>
Date:   Tue, 9 Mar 2021 19:11:19 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <CAJKOXPc0u+BH35W5s_6tCbvM_Rr4K3Y0kjAbPMM9=+VZTzr3FA@mail.gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLJsWRmVeSWpSXmKPExsWy7bCmnu5dV/cEg6OP9S1eTjjMaLFtyyZW
        i/PnN7BbXN41h83ic+8RRovt3x6xWZzeXWKx/sdLNgcOj99HH7N77Jx1l91j06pONo+etk1M
        Hp83yQWwRmXbZKQmpqQWKaTmJeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoqufgE6Lpl
        5gCdoqRQlphTChQKSCwuVtK3synKLy1JVcjILy6xVUotSMkpsCzQK07MLS7NS9dLzs+1MjQw
        MDIFKkzIzuhZe5yt4K1Axd1/mxgbGO/ydjFyckgImEg8v3+LpYuRi0NIYAejxLpne5kgnE+M
        EkvPP2SEcL4xSkxf28kK09J1/RlU1V5GidaWz1D97xkllh+/zgZSJSwQLdHRNx+og4NDRMBL
        4lajKUgNs8BiJomD3dNYQGrYBLQk9r+4AVbPL6AocfXHY0YQm1fATmLJ4Qtg21gEVCQWn9kI
        ViMqECZxclsLVI2gxMmZT8DmcAoESjR3HAerZxYQl7j1ZD4ThC0vsf3tHGaQxRICSzkkfnTu
        YoJ4wUXiyOvTzBC2sMSr41vYIWwpiZf9bVB2tcTKk0fYIJo7GCW27L8A9b+xxP6lk5lAPmMW
        0JRYv0sfIqwosfP3XEaIxXwS7772gD0vIcAr0dEmBFGiLHH5wV2oEyQlFrd3sk1gVJqF5J1Z
        SF6YheSFWQjLFjCyrGIUSy0ozk1PLTYsMEKO7k2M4HSqZbaDcdLbD3qHGJk4GA8xSnAwK4nw
        +h13SxDiTUmsrEotyo8vKs1JLT7EaAoM4InMUqLJ+cCEnlcSb2hqZGxsbGFiaGZqaKgkzpto
        8CBeSCA9sSQ1OzW1ILUIpo+Jg1OqgSnTY66B6yfDhBWlXtkCU67WvZ+UGqylaNv+R6huynQG
        WeO1Mt97V+hZyNqECKnxqyQ8/K37MXW9zi2necqZprvfzfSaN03nq5a5RuGp5MWVa4IctbUu
        GL82zFFpLs744brpYvc/SQlf3syQi32VAQ7BvfK5LT9T9d6uODFz+sZNt98qpr2S/GcveVPy
        4ZMZ2190mG/bFHfopeu0NjfGsKMfuCWm3322KXP1kxVKW+xDniq8c3EICE7jf68pomenvHxa
        gs6nXT66RrE3+KoU5Xe9rr+lX3B+2iU3p13BvEY5+eKR7xfs1fwj/PD+v4dfbjGzXd1hd+JE
        7AeWd53tv2JnemyOeHZMY723zbztXkosxRmJhlrMRcWJACoSHb0wBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjkeLIzCtJLcpLzFFi42LZdlhJXveOq3uCwYe3BhYvJxxmtNi2ZROr
        xfnzG9gtLu+aw2bxufcIo8X2b4/YLE7vLrFY/+MlmwOHx++jj9k9ds66y+6xaVUnm0dP2yYm
        j8+b5AJYo7hsUlJzMstSi/TtErgyetYeZyt4K1Bx998mxgbGu7xdjJwcEgImEl3XnzF1MXJx
        CAnsZpS48Oc5C0RCUmLaxaPMXYwcQLawxOHDxRA1bxklfvbfZQepERaIlujom88KUiMi4CVx
        q9EUpIZZYCmTxK+2WcwgNUICZ5gkPjYlgthsAloS+1/cYAOx+QUUJa7+eMwIYvMK2EksOXyB
        FcRmEVCRWHxmI1iNqECYxM4lj5kgagQlTs58AnYbp0CgRHPHcbB6ZgF1iT/zLjFD2OISt57M
        Z4Kw5SW2v53DPIFReBaS9llIWmYhaZmFpGUBI8sqRsnUguLc9NxiwwLDvNRyveLE3OLSvHS9
        5PzcTYzgqNLS3MG4fdUHvUOMTByMhxglOJiVRHj9jrslCPGmJFZWpRblxxeV5qQWH2KU5mBR
        Eue90HUyXkggPbEkNTs1tSC1CCbLxMEp1cDEpTGDIY3Pp+Pdoc4JiyM+mi89/6zVyC7U5Mf6
        rXIx3s230g6Gse6OZDj+yNP/QvNyOfdHKWnp7h47OE3+rmRcuNapbe71bVVnV5c+/H/t3eW/
        K3tYNwp2RP0y+ak1Mfa5Cy8fU7Oj8rxNyxJXThTMDV/gFJnOF7jk2OU7M2YWlrEG1/0S/D+p
        VVdw8uW1F+a07ubpOb/tg3u5vdS0i+Uue77abLOc2i2rdz7ugfHunhI24+frJi27+36/m+76
        +GBhZdM+1sIVOtr5je+k7SatEIx5r79xdiifwOzzG39krd4UwstyVc1EdN8F8+xobQvnrZPL
        f92yWDznKvvnzacuxGgLd2zj56z415p45GeFEktxRqKhFnNRcSIAHt8muBkDAAA=
X-CMS-MailID: 20210309095436epcas1p19f72c6f2d78c7dd708dfedd3a3c8500d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210308161250epcas1p4da36a013b0b7fdd93b643f8e28041ca7
References: <20210308152935.2263935-1-arnd@kernel.org>
        <12c5050f-feb3-e07f-45d2-5e89b678841a@kernel.org>
        <CAK8P3a3xEw9yiVY-dDmQEKTSPSXaZJEhXEQ2M=7ZoUA8_P5Qzg@mail.gmail.com>
        <CGME20210308161250epcas1p4da36a013b0b7fdd93b643f8e28041ca7@epcas1p4.samsung.com>
        <CAJKOXPc0u+BH35W5s_6tCbvM_Rr4K3Y0kjAbPMM9=+VZTzr3FA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Krzysztof,

On 3/9/21 1:11 AM, Krzysztof Kozlowski wrote:
> On Mon, 8 Mar 2021 at 17:02, Arnd Bergmann <arnd@kernel.org> wrote:
>>
>> On Mon, Mar 8, 2021 at 4:33 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>>
>>> On 08/03/2021 16:29, Arnd Bergmann wrote:
>>>> From: Arnd Bergmann <arnd@arndb.de>
>>>>
>>>> Some of the extcon interfaces have a fallback implementation that can
>>>> be used when EXTCON is disabled, but some others do not, causing a
>>>> build failure:
>>>>
>>>> drivers/power/supply/max8997_charger.c:261:9: error: implicit declaration of function 'devm_extcon_register_notifier_all' [-Werror,-Wimplicit-function-declaration]
>>>>                 ret = devm_extcon_register_notifier_all(&pdev->dev, charger->edev,
>>>>                       ^
>>>> drivers/power/supply/max8997_charger.c:261:9: note: did you mean 'devm_extcon_register_notifier'?
>>>> include/linux/extcon.h:263:19: note: 'devm_extcon_register_notifier' declared here
>>>> static inline int devm_extcon_register_notifier(struct device *dev,
>>>>
>>>> I assume there is no reason to actually build this driver without extcon
>>>> support, so a hard dependency is the easiest fix. Alternatively the
>>>> header file could be extended to provide additional inline stubs.
>>>
>>> Hi Arnd,
>>>
>>> Thanks for the patch but I think I got it covered with:
>>> https://lore.kernel.org/lkml/20210215100610.19911-2-cw00.choi@samsung.com/
>>> (sent via extcon tree).
>>>
>>> Did you experience a new/different issue?
>>
>> The patch should be fine and address the problem, I just didn't see it was
>> already fixed in linux-next as I'm still testing on mainline (rc2 at
>> the moment).
>>
>> I assume the fix will make it into a future -rc then.
> 
> It's still only in linux-next via extcon tree, so it seems Greg did
> not take it yet.
> 
> Chanwoo,
> You might need to follow up on this, so your pull request won't get lost.

I'm sorry. Because of my fault, the previous pull request was not merged to v5.12-rc1.
To fix this issue, I'll send the pull request for rc3 to Greg.

Best Regards,
Chanwoo Choi
Samsung Electronics
