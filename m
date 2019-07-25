Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E15E753CE
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jul 2019 18:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389553AbfGYQXv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 Jul 2019 12:23:51 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:47765 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388704AbfGYQXu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 Jul 2019 12:23:50 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190725162349euoutp01cd8539e38c55bf098c58cc87e6fa4b6b~0swrAsriL3239732397euoutp01-
        for <linux-pm@vger.kernel.org>; Thu, 25 Jul 2019 16:23:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190725162349euoutp01cd8539e38c55bf098c58cc87e6fa4b6b~0swrAsriL3239732397euoutp01-
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1564071829;
        bh=VcdlZyKrQCdgkYUt20ZBw2/TUXd1x62JJBXr6EHpia8=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=XvNiJPnR4xylIsj9T2NATRQ2lcH0fM8lr9CVTXhzw4VUMrYhSsiO7IbPuueFrHpU5
         yU0ipTKi81vTWARn2GpTEMpfVE13c1mSWD+N4WZDx10h8htD9dI+9sLMRDHqZtjNrj
         FkifOq9e/gJ4ync6ko/sksv1UPjhChQlQ5oAAIJg=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190725162348eucas1p2d04c89a2846f8586af7949b4a13942de~0swqMOc8H1109611096eucas1p2u;
        Thu, 25 Jul 2019 16:23:48 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id CB.B0.04298.497D93D5; Thu, 25
        Jul 2019 17:23:48 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190725162347eucas1p15f983918e07b912c4a00fefd0c2a5d8e~0swpaXOGQ3041930419eucas1p1N;
        Thu, 25 Jul 2019 16:23:47 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190725162347eusmtrp29900cce149672f61a0bdef0c8a88c966~0swpMPzBg1648516485eusmtrp2B;
        Thu, 25 Jul 2019 16:23:47 +0000 (GMT)
X-AuditID: cbfec7f2-f2dff700000010ca-4a-5d39d7949571
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 04.46.04146.397D93D5; Thu, 25
        Jul 2019 17:23:47 +0100 (BST)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190725162346eusmtip1ad4b284580c6a68ae2f63e50c9027790~0swoSc50i3163931639eusmtip1Z;
        Thu, 25 Jul 2019 16:23:46 +0000 (GMT)
Subject: Re: [PATCH v4 3/5] drivers: devfreq: events: extend events by type
 of counted data
To:     Chanwoo Choi <cw00.choi@samsung.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, myungjoo.ham@samsung.com
Cc:     b.zolnierkie@samsung.com, krzk@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, kyungmin.park@samsung.com,
        m.szyprowski@samsung.com, s.nawrocki@samsung.com, kgene@kernel.org,
        willy.mh.wolff.ml@gmail.com
From:   Lukasz Luba <l.luba@partner.samsung.com>
Message-ID: <6ad9882f-10c8-3708-1a06-ee712bb1c66d@partner.samsung.com>
Date:   Thu, 25 Jul 2019 18:23:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <15375017-2e82-7df8-344c-a9c41d61331c@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SfUxNYRz23nPPR62bt9vl/pav7W6+MoWZvcXCmF0zk41NaJx0VtG9ck9F
        MepaoUkWI5eUj3aTS0la5aN2Sx8aUeO2SJSWUkJl+aNyTyfTf8/v+T2/93me7eUodQvtxUUY
        owWTkY/UMa7K4uo/rxZfdPgFL+kdciMPMvJp4hjsoklW1SuapHV8o0hDQwFLXpp7WVLY8Y4m
        TWXXGDKQWoVIRsMzBblX1cqSHMcbBXmfmMuQpKdVLKnsPUWT37XtaA3W267bkL7U0srqC/PO
        MPqHt0/ozxXlIf1A4exAZqfrqlAhMiJWMPkG7HUNz347wkT10EfOfL7OJKA6ZQpy4QAvh/vW
        fFrCapyLYKxek4JcnXgQwdBwJyMPAwjuVA8r/l1YKzJpeWF1XlQUK+ShD4G97SabgjjOEwdD
        8t0VEq/BnQjuljeOX1DYgcBm7kKSiME+UJJ3SHpVhTfAyR/9jISVeC587LYgCU/DO6CpqAzJ
        Gg+ou/JlPLcLXg0D5u/jPIW10PIlSyHjOXDy0VVK8gKcyEFTcRIrx14Pj5+PUjL2hJ6aogl+
        JoyVZk1UEyEh9QaS8THoSMuc0KyEypo3tJSZwgshv8xXptdCdlq7UqIBu0Nzn4ccwR3Siy9T
        Mq2C08lqWb0Ais6+njCaDlbbJfY80lkmFbNMKmOZVMby3zcbKfOQVogRDWGCuNQoHPYReYMY
        Ywzz2XfQUIicP65+tOZXCRpqDLEjzCGdm+q11S9YTfOxYpzBjoCjdBrVoxInpQrl4+IF08E9
        pphIQbSjGZxSp1UdnfJplxqH8dHCAUGIEkz/tgrOxSsBKWILzP7mW6eGDLVNbcs0tqRA//m6
        dZqYn2h3+dX4oEOVLr3Lkrqzm895b2mclfBk3sUdiVvdlrQmB9pyRjxSL3uHdH5e2B6/sV67
        6OuwNkAZdDx4/3Kv0Nqv6ezmvRdyjHxqzpQX27dtCijwTY7a3t96b2pG5gfU3jUYKJTW7Eyx
        x+qUYji/1JsyifxfdPWf8m0DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAIsWRmVeSWpSXmKPExsVy+t/xu7qTr1vGGnS3iFpsnLGe1eL6l+es
        FvOPnGO16H/8mtni/PkN7BZnm96wW2x6fI3V4vKuOWwWn3uPMFrMOL+PyWLtkbvsFkuvX2Sy
        uN24gs2ide8RdovDb9pZLb6deMToIOCxZt4aRo+ds+6ye2xa1cnmsXlJvUffllWMHp83yQWw
        RenZFOWXlqQqZOQXl9gqRRtaGOkZWlroGZlY6hkam8daGZkq6dvZpKTmZJalFunbJehlLLj6
        l63gFWtF58N5bA2MJ1m6GDk5JARMJJYfmMvaxcjFISSwlFFi85XfTBAJMYlJ+7azQ9jCEn+u
        dbFBFL1mlJj+YikzSEJYIFai6dJlsG4RgaeMEmt/NoJVMQtcZ5Q4O3EG1NzdTBJN02YDLeTg
        YBPQk9ixqhCkm1fATaL5w3s2EJtFQFXi3stZjCC2qECERF/bbDaIGkGJkzOfgN3KKWAv8bnp
        HVgNs4CZxLzND5khbHGJW0/mM0HY8hLNW2czT2AUmoWkfRaSlllIWmYhaVnAyLKKUSS1tDg3
        PbfYUK84Mbe4NC9dLzk/dxMjMLa3Hfu5eQfjpY3BhxgFOBiVeHgvLLeMFWJNLCuuzD3EKMHB
        rCTCu3UHUIg3JbGyKrUoP76oNCe1+BCjKdBzE5mlRJPzgWknryTe0NTQ3MLS0NzY3NjMQkmc
        t0PgYIyQQHpiSWp2ampBahFMHxMHp1QDY9eTWw+lP0oWdmaYvVpSceM3+y2O6M+LLNbJptz8
        4HXJ5oVg+7MzhSHLheIO/OCUtxAtyt/aoyf02slkKzP3Ac+LNZ/irJ5uf7pV+7Fam/6d858M
        sjbtstzQffKQ3cmHGZOKFzPM2fOz+2/J3ivSN3xrDmbGTDb+5FYUkShluOnc4tNuld83rVJi
        Kc5INNRiLipOBAC0EGq+AwMAAA==
X-CMS-MailID: 20190725162347eucas1p15f983918e07b912c4a00fefd0c2a5d8e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190605091303eucas1p27177d349e0f2bd37bf582dbd7266321a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190605091303eucas1p27177d349e0f2bd37bf582dbd7266321a
References: <20190605091236.24263-1-l.luba@partner.samsung.com>
        <CGME20190605091303eucas1p27177d349e0f2bd37bf582dbd7266321a@eucas1p2.samsung.com>
        <20190605091236.24263-4-l.luba@partner.samsung.com>
        <37af143f-a585-a28a-a36f-2ed25c5b6d3b@partner.samsung.com>
        <15375017-2e82-7df8-344c-a9c41d61331c@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Chanwoo,

On 7/24/19 12:24 PM, Chanwoo Choi wrote:
> Hi Lukasz,
> 
> On 19. 7. 24. 오후 7:15, Lukasz Luba wrote:
>> Hi Chanwoo,
>>
>> Could you have a look a this patch, please?
>> This patch has been rewritten accorifing to your suggestion.
>> Krzysztof tried to apply 5/5 DT patch on his current branch,
>> but it is missing earlier stuff.
>> The other patches have needed ACKs so could go through devfreq tree
>> probably, but this one left.
> 
> Sorry for the late reply. It looks good to me.
> 
> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
Thank you for the ACK.

MyungJoo could you take the patches (apart from 5/5 which will be in
Krzysztof's tree probably) through devfreq tree, please?

Regards,
Lukasz
