Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D20C2847F8
	for <lists+linux-pm@lfdr.de>; Tue,  6 Oct 2020 09:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbgJFH47 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Oct 2020 03:56:59 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:20023 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726934AbgJFH47 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Oct 2020 03:56:59 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20201006075656epoutp03ddb70e8788330c5ced597033613db7d8~7WCb9NHj72468624686epoutp03k
        for <linux-pm@vger.kernel.org>; Tue,  6 Oct 2020 07:56:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20201006075656epoutp03ddb70e8788330c5ced597033613db7d8~7WCb9NHj72468624686epoutp03k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1601971016;
        bh=eGJ/o/4mHLr8azDiSIfZgtOCa4YXD3Uyr1TeR5gmAUw=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=K05jsex6CZ//NkIMIgyPhxM7kplqo0mi966D8H8lSwhJ8Ke/0VnpEVvCPorF07LK3
         yD0nSgLGDVWWDH+DjKlVYMSb9MKXQ9k3/Ks43vK7wLcB9e9371S4vcjyR+EQhh1TKa
         WdjHWOxMNfLOxnLS+JvYEKc5Jc+TA267WOt18V+c=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20201006075656epcas1p141f361f953fb4227d6d1810fc3510718~7WCbbgwr22887328873epcas1p1l;
        Tue,  6 Oct 2020 07:56:56 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.154]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4C58ts1dMjzMqYlp; Tue,  6 Oct
        2020 07:56:53 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        B7.4B.09543.5432C7F5; Tue,  6 Oct 2020 16:56:53 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20201006075652epcas1p46e5781a799c2782c9f9fa61b0d1f3ebe~7WCX7QWHP3158031580epcas1p4L;
        Tue,  6 Oct 2020 07:56:52 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20201006075652epsmtrp1b3dc79eea2bb85b6e5411b144e11dcc7~7WCX6sIH22802928029epsmtrp1d;
        Tue,  6 Oct 2020 07:56:52 +0000 (GMT)
X-AuditID: b6c32a35-35dff70000002547-d4-5f7c2345c9d1
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        45.29.08745.4432C7F5; Tue,  6 Oct 2020 16:56:52 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20201006075652epsmtip29934adc2804d8ca34c520cc65efb6f5a~7WCXmXszN1963719637epsmtip2R;
        Tue,  6 Oct 2020 07:56:52 +0000 (GMT)
Subject: Re: [GIT PULL] devfreq next for v5.10
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki <rjw@rjwysocki.net>" <rjw@rjwysocki.net>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Chanwoo Choi (chanwoo@kernel.org)" <chanwoo@kernel.org>,
        =?UTF-8?B?7ZWo66qF7KO8?= <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <da43236a-b44e-d4d7-97c5-37ce3c447c95@samsung.com>
Date:   Tue, 6 Oct 2020 17:10:15 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0giQRQG+V=XPVMJH4aRcvZo-JQ82bgw-KHAXBGfnEkgpQ@mail.gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMJsWRmVeSWpSXmKPExsWy7bCmrq6rck28wdot7BYTb1xhsTjb9Ibd
        4vKuOWwWn3uPMFrcblzBZjH3y1RmizOnL7E6sHtsWtXJ5rHlajuLR9+WVYwenzfJBbBEZdtk
        pCampBYppOYl56dk5qXbKnkHxzvHm5oZGOoaWlqYKynkJeam2iq5+AToumXmAF2gpFCWmFMK
        FApILC5W0rezKcovLUlVyMgvLrFVSi1IySmwLNArTswtLs1L10vOz7UyNDAwMgUqTMjO+DH3
        OEvBXpaK5fsfszQwnmTuYuTgkBAwkeg5F9fFyMUhJLCDUeLagd+sEM4nRonla9sYIZzPjBKH
        384C6uAE67i/8DsTRGIXo8T7J81sEM57RomfHbPZQKqEBfQkzqy+xApiiwhoSyxZdJUZpIhZ
        4DqTROPFxUwgCTYBLYn9L26ANfALKEpc/fGYEcTmFbCTePtsPtg6FgEViU9bXoHViwqESZzc
        1gJVIyhxcuYTFhCbUyBQ4uyq+2BzmAXEJW49mc8EYctLbH87B+rsqRwSLduTIWwXiYnf5zBC
        2MISr45vYYewpSRe9rdB2dUSK08eAftMQqCDUWLL/gusEAljif1LJzOBQo9ZQFNi/S59iLCi
        xM7fcxkh9vJJvPvawwoJYF6JjjYhiBJlicsP7jJB2JISi9s72SYwKs1C8s0sJB/MQvLBLIRl
        CxhZVjGKpRYU56anFhsWGCLH9iZGcOrUMt3BOPHtB71DjEwcjIcYJTiYlUR49cIq4oV4UxIr
        q1KL8uOLSnNSiw8xmgLDdyKzlGhyPjB555XEG5oaGRsbW5gYmpkaGiqJ8z68pRAvJJCeWJKa
        nZpakFoE08fEwSnVwFR6/OPSDQtO/wx8wfM0Y6tlZu2+q3qmapHuKzWXeXIFlzxw+Bbz7atD
        +bZMfec9n+I66jM1735rvD5dd7PPjqN1DtY7XO7GnJ7zw+U8q+TT3RvDbQWfn9RZoP/k6NnM
        nmm/psp4/tPevTgme9HfroPWIre7VwkKNL05JTTHJniz9X6LI2dL/QQfikrcPXl1z9Gvc7xk
        b9jlL2Bi8wxZZcNQFt0XcZFtm9G5wk6bx1Kv/55ZYpETOc27Qr9nI7N+k45W6oyLzm9m7BK/
        dvp5fu8NpkcW90UXflVY5Vo8XUK96OA8wxsTtyYudrq6b0vXAyOhvcGa2v+2zqy+albY5pPq
        WCLatXXLtnjviBQvRVUlluKMREMt5qLiRADWm1bVJgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPLMWRmVeSWpSXmKPExsWy7bCSvK6Lck28wdq3shYTb1xhsTjb9Ibd
        4vKuOWwWn3uPMFrcblzBZjH3y1RmizOnL7E6sHtsWtXJ5rHlajuLR9+WVYwenzfJBbBEcdmk
        pOZklqUW6dslcGX8mHucpWAvS8Xy/Y9ZGhhPMncxcnJICJhI3F/4namLkYtDSGAHo8SauXeY
        IBKSEtMuHgUq4gCyhSUOHy6GqHnLKNHy6RVYjbCAnsSZ1ZdYQWwRAW2JJYuuMoMUMQvcZJJ4
        9q2PDaLjJqPEuxvPWECq2AS0JPa/uMEGYvMLKEpc/fGYEcTmFbCTePtsPthJLAIqEp+2QGwQ
        FQiT2LnkMRNEjaDEyZlPwOZwCgRKnF11H2wOs4C6xJ95l5ghbHGJW0/mM0HY8hLb385hnsAo
        PAtJ+ywkLbOQtMxC0rKAkWUVo2RqQXFuem6xYYFRXmq5XnFibnFpXrpecn7uJkZwHGlp7WDc
        s+qD3iFGJg7GQ4wSHMxKIrx6YRXxQrwpiZVVqUX58UWlOanFhxilOViUxHm/zloYJySQnliS
        mp2aWpBaBJNl4uCUamDitxHawsfY5PUz9bKlxDTmGIFlH15efxRxT+fPBHdej4CaeYatQaYL
        ioudtC/zPXV6XvbOxrOrUM9z5pk9Wat2p/vvyzygHTFd5pvmthTDyAYXYeU359hXH/1hOSer
        5jmbzYxTGj+aZh9n/aW4Iku1RWipi/ReVdPOI20Pz9hZ9ZTvD5IzuFd4edb8Rzu22cTFn3Ov
        YdYS7r6lIRIrtflusZJNfeqGOY+aZFY/v3CJ24H3qv2W5TapkjnHynN/GBq8v+P8Jk5FTV90
        vnJAQqNL2vqLu9ZsLfkfvLBQ63R9Cb+K4MIXhi36l5d27m41Utxu7aC+QmdN+nbWwyvv3Azd
        0r4i4onWUZcPP0xatymxFGckGmoxFxUnAgBQstvdEgMAAA==
X-CMS-MailID: 20201006075652epcas1p46e5781a799c2782c9f9fa61b0d1f3ebe
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200929085610epcas1p2447455fd0bcde25f5dff466e71b7ac15
References: <CGME20200929085610epcas1p2447455fd0bcde25f5dff466e71b7ac15@epcas1p2.samsung.com>
        <b5d67c59-90c7-6a77-7420-a8783282430f@samsung.com>
        <CAJZ5v0giQRQG+V=XPVMJH4aRcvZo-JQ82bgw-KHAXBGfnEkgpQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Dear Rafael,

On 10/1/20 12:56 AM, Rafael J. Wysocki wrote:
> On Tue, Sep 29, 2020 at 10:56 AM Chanwoo Choi <cw00.choi@samsung.com> wrote:
>>
>> Dear Rafael,
>>
>> This is devfreq-next pull request for v5.10-rc1. I add detailed description of
>> this pull request on the following tag. Please pull devfreq with following updates.
>> - tag name : devfreq-next-for-5.10
> 
> Pulled, thanks!

Thanks for pulled the request. But, I tried to check on linux-pm.git,
I cannot find the pull request of devfreq patches for v5.10-rc1.

Best Regards,
Chanwoo Choi

