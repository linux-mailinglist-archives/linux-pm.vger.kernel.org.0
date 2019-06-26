Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 753A056B64
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2019 15:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727700AbfFZN64 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 26 Jun 2019 09:58:56 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:43122 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbfFZN6z (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Jun 2019 09:58:55 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190626135852euoutp0124eb222c38b1e5e36ea7461d0a0ccecc~rxE10a8MQ2337523375euoutp01O
        for <linux-pm@vger.kernel.org>; Wed, 26 Jun 2019 13:58:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190626135852euoutp0124eb222c38b1e5e36ea7461d0a0ccecc~rxE10a8MQ2337523375euoutp01O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1561557532;
        bh=BT3zIcGmvUV+ueH1TilZMhs4g/vfOTc1I+ZwJJdTOdI=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=P9Eghto3c5GHdQbSZgR9ytQs7pme55qEmeJAKtmXwNgYcF2wQqa0Wt+ZeDDifpIn/
         PMnj2zWFzkM9zgas7G07f/EN/6CyF3fW8ZSoqpQe6pm5hJ1ZXjZsKF1po7AKXw5zZ8
         Inj9Ti1Iv8Lvo/O2mxF1eybn0wNYhMWDGt4YbUsA=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190626135851eucas1p16099d70110d216a9de1c227f02331451~rxE04uHpe0568305683eucas1p1S;
        Wed, 26 Jun 2019 13:58:51 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id E9.95.04298.B1A731D5; Wed, 26
        Jun 2019 14:58:51 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190626135850eucas1p11ee7d7e5e2ae50e8245e2f6366d365eb~rxEz7Lnl-0630806308eucas1p1K;
        Wed, 26 Jun 2019 13:58:50 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190626135850eusmtrp145647492546fa5341906e8062e54e818~rxEzs0GTO0282502825eusmtrp1U;
        Wed, 26 Jun 2019 13:58:50 +0000 (GMT)
X-AuditID: cbfec7f2-f2dff700000010ca-cf-5d137a1bb4a6
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 2A.11.04140.A1A731D5; Wed, 26
        Jun 2019 14:58:50 +0100 (BST)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190626135849eusmtip228f6bdc30e55bd68f74a4eccc4642b46~rxEzAIVz31436614366eusmtip2c;
        Wed, 26 Jun 2019 13:58:49 +0000 (GMT)
Subject: Re: [PATCH v4 4/5] Documentation: devicetree: add PPMU events
 description
To:     cwchoi00@gmail.com
Cc:     devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, b.zolnierkie@samsung.com,
        krzk@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        cw00.choi@samsung.com, kyungmin.park@samsung.com,
        m.szyprowski@samsung.com, s.nawrocki@samsung.com,
        myungjoo.ham@samsung.com, kgene@kernel.org,
        willy.mh.wolff.ml@gmail.com
From:   Lukasz Luba <l.luba@partner.samsung.com>
Message-ID: <7498059d-95f7-e154-cf49-bcbc8ee6fdb9@partner.samsung.com>
Date:   Wed, 26 Jun 2019 15:58:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAGTfZH2kTNWtx=Jp1UJaLN50Qxbq+Q9ThV4vhQ240QbOy1TRMQ@mail.gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SeUhUURjFu/OWeUpj1xnTLw2NifbStj8utlBSMlS0WFAUam/yoaKONi8r
        LVDbTNHMCq1pUaN1chknLbUMHS0T0bGC9sUaKTI1cSyyRXLmGfnf77vfOfeeA5ejlK8Zby5a
        t0vQ6/hYNetK33owaJ3jk6wKnXsl35uUny5jyLOBTwz5eH8WKWhsY0iO7QtFrFaTnLQe6JYT
        s+0pQ57UnGOJPbsRkdPWezJS0vhGTi4/eyQjr9KuseRwbaOcNHSnM+T7ww9ombum+EIx0lQb
        3sg1ZmMGq7l5KUVzrMKINHaz73p2q+viCCE2eregD1i63TWq50+dLGGA3Ztbb5KnojtMJnLh
        AC+EoUOHqEzkyinxNQT9v0tZx0KJBxDcaF8lsR2BqXLuP0PH3c+MZLiK4E7HIC0NPQj6Svtk
        DpUKb4Ihs8XJHtgTbud1IoeIws0UtPZahgeOY7E/VBl3OjQKHAynKrNpB9N4Chiyjji94/EW
        GKg2I0njDs1nOp0aF7wBrCU2Z1IKe8HLzgKZxH5wsPKssw7gNA7qGq6zUuwVUGgvG2EVdDVV
        yCWeCC0ns2iJRUjNLkIS7wdbzvkRzSJoaHrEODJTeAaU1QQ4EPByaL44TkI3eN7jLiVwgxO3
        8inpWAFHjyilO6ZDRVa7TGJPuFqcJz+O1IZRvQyjuhhGdTH8f7YQ0UbkJSSKcZGCOE8n7PEX
        +TgxURfpvyM+zoyG/1zLUFN/Ffr2WGtBmEPqsYpUP2WokuF3i0lxFgQcpfZQXOZxqFIRwScl
        C/r4cH1irCBakA9Hq70U+8Z0bFPiSH6XECMICYL+31bGuXinosDt8zMrMtJKs2bnvzVqTJ1r
        UP66fb6DVU+ntq7cr4oJ1MVmBM7qnRT0YvI227gfubJLN4vLN4fgr7kxpv4qe1iKtvadqpv8
        pMu/1acH9/yZkHmuYP3q81AUNmYa3xX/vrXLeLessDvCnhK+MehXSV/C2gXaqUtCErTJ2rbk
        tjAcrqbFKH7eTEov8n8BL6Fkn28DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrEIsWRmVeSWpSXmKPExsVy+t/xe7pSVcKxBg9eSFpsnLGe1eL6l+es
        Fs+OalvMP3KO1aL/8Wtmi/PnN7BbnG16w26x6fE1VovLu+awWXzuPcJoMeP8PiaLtUfuslss
        vX6RyeJ24wo2i9a9R9gtDr9pZ7X4duIRo4Ogx5p5axg9ds66y+6xaVUnm8fmJfUefVtWMXp8
        3iQXwBalZ1OUX1qSqpCRX1xiqxRtaGGkZ2hpoWdkYqlnaGwea2VkqqRvZ5OSmpNZllqkb5eg
        l/H27wGmgi9sFRMPbmBvYNzN2sXIySEhYCLxYM9LMFtIYCmjxK93ARBxMYlJ+7azQ9jCEn+u
        dbF1MXIB1bxmlLi6fzcbSEJYIETi36ZDTCC2CFDD9mlPGEGKmAVOMktc2nKdEaJjApPE3T2v
        gBwODjYBPYkdqwpBGngF3CSmbO1lAbFZBFQlZvW0gQ0SFYiQmL2rgQWiRlDi5MwnYDanQKDE
        +bWPwRYzC5hJzNv8kBnCFpe49WQ+E4QtL9G8dTbzBEahWUjaZyFpmYWkZRaSlgWMLKsYRVJL
        i3PTc4uN9IoTc4tL89L1kvNzNzEC43vbsZ9bdjB2vQs+xCjAwajEw9sgLxQrxJpYVlyZe4hR
        goNZSYR3aaJArBBvSmJlVWpRfnxRaU5q8SFGU6DnJjJLiSbnA1NPXkm8oamhuYWlobmxubGZ
        hZI4b4fAwRghgfTEktTs1NSC1CKYPiYOTqkGxk1nDFxeB1o/narb89rXXuR9yaboM88Zskw4
        rK4su7yzgntiO/sKs6dL9q5V/PHt1MXU2vuerlmXxec6LDtv9/t1Z5LqXd3UaQkXN7CfEFay
        ncTu5a5/3bjxdPH8r6m/cs4yTvGZ1S+9f+mhCAFfSd4i09SLhy+9YAyIb3mfUuj46QKLys/l
        HUosxRmJhlrMRcWJAKM4h7sFAwAA
X-CMS-MailID: 20190626135850eucas1p11ee7d7e5e2ae50e8245e2f6366d365eb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190605091304eucas1p21e0717cafa17a14de569f1773cc7abe5
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190605091304eucas1p21e0717cafa17a14de569f1773cc7abe5
References: <CGME20190605091304eucas1p21e0717cafa17a14de569f1773cc7abe5@eucas1p2.samsung.com>
        <20190605091236.24263-1-l.luba@partner.samsung.com>
        <20190605091236.24263-5-l.luba@partner.samsung.com>
        <CAGTfZH2kTNWtx=Jp1UJaLN50Qxbq+Q9ThV4vhQ240QbOy1TRMQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Chanwoo,

On 6/26/19 10:23 AM, Chanwoo Choi wrote:
> Hi Lukasz,
> 
> 2019년 6월 5일 (수) 18:14, Lukasz Luba <l.luba@partner.samsung.com 
> <mailto:l.luba@partner.samsung.com>>님이 작성:
> 
>     Extend the documenation by events description with new 'event-data-type'
>     field. Add example how the event might be defined in DT.
> 
>     Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com
>     <mailto:l.luba@partner.samsung.com>>
>     Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com
>     <mailto:cw00.choi@samsung.com>>
>     ---
>       .../bindings/devfreq/event/exynos-ppmu.txt    | 26 +++++++++++++++++--
>       1 file changed, 24 insertions(+), 2 deletions(-)
> 
> 
> 
> Acked-by: Chanwoo Choi <cw00.choi@samsung.com 

Thank you for the ACKs for this a 2/5 patch.
Do you think the v4 could be merged now?

Regards,
Lukasz
