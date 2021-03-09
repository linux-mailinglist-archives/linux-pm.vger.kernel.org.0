Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3A4332259
	for <lists+linux-pm@lfdr.de>; Tue,  9 Mar 2021 10:52:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbhCIJv4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Mar 2021 04:51:56 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:62991 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbhCIJvo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Mar 2021 04:51:44 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210309095142epoutp03809fdf95c8580d123533c4336bdeb6a1~qo8mEdWQw1821218212epoutp03U
        for <linux-pm@vger.kernel.org>; Tue,  9 Mar 2021 09:51:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210309095142epoutp03809fdf95c8580d123533c4336bdeb6a1~qo8mEdWQw1821218212epoutp03U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1615283502;
        bh=oxiutAjaXGXoZLnipJZeYYsoy+lkP9GOgalFCteI0BI=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=RgdxHASpq6Mp2mLX6iQXnJHkDeFy70K22bKyh6wqEab88mdpDsPpRi+V9eoisFHbB
         EJAVvves/cz7D0Wy7i9xYVBYNd3w06mc9c9zIoLc+x3tPT8CYLRcL8mgbE64yvvBim
         gMgF0oTKahlKLd8wEhGWtpDZ/jXUVMCgOkuKImTA=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20210309095141epcas1p1ce710c720ef2992e40139dcd512ed341~qo8lKtSov0868408684epcas1p1_;
        Tue,  9 Mar 2021 09:51:41 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.156]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4Dvr8B1mM3z4x9Pq; Tue,  9 Mar
        2021 09:51:38 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        C6.6D.02418.A2547406; Tue,  9 Mar 2021 18:51:38 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20210309095137epcas1p1feaf4a59335045b9df643238a80befcb~qo8hcGCgZ0868608686epcas1p1b;
        Tue,  9 Mar 2021 09:51:37 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210309095137epsmtrp106d0e68b8e5537a61ddc46764f48a637~qo8hbVPjR2126421264epsmtrp1c;
        Tue,  9 Mar 2021 09:51:37 +0000 (GMT)
X-AuditID: b6c32a35-c23ff70000010972-9d-6047452a9dc8
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        D6.4B.08745.92547406; Tue,  9 Mar 2021 18:51:37 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210309095136epsmtip2d3a7fe9cb2035622ae4e99249e2230d2~qo8hKNe--2085820858epsmtip2N;
        Tue,  9 Mar 2021 09:51:36 +0000 (GMT)
Subject: Re: [PATCH v6 1/4] PM / devfreq: Register devfreq as a cooling
 device on demand
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, cwchoi00@gmail.com
Cc:     lukasz.luba@arm.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, steven.price@arm.com,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <2307329b-7a69-17e9-e1b2-8416b2dddfa2@samsung.com>
Date:   Tue, 9 Mar 2021 19:08:19 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20210308133041.10516-1-daniel.lezcano@linaro.org>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJJsWRmVeSWpSXmKPExsWy7bCmga6Wq3uCwfQdnBbPjmpbzPssa3G2
        6Q27xeVdc9gsPvceYbRY2NTCbnG7cQWbReOR92wOHB5r5q1h9Ng56y67x51re9g8+rasYvT4
        vEkugDUq2yYjNTEltUghNS85PyUzL91WyTs43jne1MzAUNfQ0sJcSSEvMTfVVsnFJ0DXLTMH
        6BIlhbLEnFKgUEBicbGSvp1NUX5pSapCRn5xia1SakFKToFlgV5xYm5xaV66XnJ+rpWhgYGR
        KVBhQnbGpHOHmQqeCles2N7B2sD4jr+LkZNDQsBEYs/Ww4xdjFwcQgI7GCVOnelhgnA+MUps
        71jCAuF8ZpR4vPIsUBkHWEvzIkeI+C5GiXsTvkF1vGeUeHP8OhPIXGGBKIm+PcdYQWwRASeJ
        nWduMIPYzAJ7GSX231UHsdkEtCT2v7jBBmLzCyhKXP3xGGwBr4CdxNK/4iAmi4CKxKI/KSAV
        ogJhEie3tTCC2LwCghInZz5hAbE5Bewlvs49zggxXVzi1pP5TBC2vMT2t3OYQU6TEFjIIdG7
        qI0N4mUXiWUrf7JA2MISr45vYYewpSRe9rdB2dUSK08eYYNo7mCU2LL/AitEwlhi/9LJTCDH
        MQtoSqzfpQ8RVpTY+Xsu1BF8Eu++9rBCwopXoqNNCKJEWeLyg7tMELakxOL2TrYJjEqzkLwz
        C8kLs5C8MAth2QJGllWMYqkFxbnpqcWGBYbIcb2JEZxGtUx3ME58+0HvECMTB+MhRgkOZiUR
        Xr/jbglCvCmJlVWpRfnxRaU5qcWHGE2B4TuRWUo0OR+YyPNK4g1NjYyNjS1MDM1MDQ2VxHmT
        DB7ECwmkJ5akZqemFqQWwfQxcXBKNTDFBCqvKZbwbHox45xky5TNT0vElmY9Nm0VZO/58M1a
        JuSkyssjZasqDyuekOPzmllx4EHYm8+ZTybcLH0ZdrWq6q771O96Ti7fzMTy667cFdfawhI9
        8Y+dmKKMzl+Nqea3/vh4L+wSWmla+m6DxHR3bWUOk5Z/J5oD7hflL5j3ct8N12MLpks/53s+
        LX9CRaLbT1npdnF+sYT4WO+Sq6eeS5399LjyWOv8pbfCNiiLakUGzP/t27Dl0+c3t3jCe97a
        bZb/NFNEI3AGv8sZpdNGis+zwlWbmA6KGs49nNOUv1xROUDtssdiice1viFbTTM1eMS+H/Rd
        e1RQ4071V4+DyoYVD5Kcyp6/UVj5cJUSS3FGoqEWc1FxIgBxP1a0LAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphkeLIzCtJLcpLzFFi42LZdlhJXlfT1T3B4OVcHotnR7Ut5n2WtTjb
        9Ibd4vKuOWwWn3uPMFosbGpht7jduILNovHIezYHDo8189YweuycdZfd4861PWwefVtWMXp8
        3iQXwBrFZZOSmpNZllqkb5fAlTHp3GGmgqfCFSu2d7A2ML7j72Lk4JAQMJFoXuTYxcjFISSw
        g1HiyeVmti5GTqC4pMS0i0eZIWqEJQ4fLoaoecsocePjV1aQGmGBKIkfzz4wgtgiAk4SO8/c
        YAYpYhbYzyhxumcqK0THJEaJ3bOugnWwCWhJ7H9xA2wDv4CixNUfjxlBNvAK2Eks/SsOYrII
        qEgs+pMCUiEqECaxc8ljJhCbV0BQ4uTMJywgNqeAvcTXucfB9jILqEv8mXeJGcIWl7j1ZD4T
        hC0vsf3tHOYJjMKzkLTPQtIyC0nLLCQtCxhZVjFKphYU56bnFhsWGOWllusVJ+YWl+al6yXn
        525iBEeUltYOxj2rPugdYmTiYDzEKMHBrCTC63fcLUGINyWxsiq1KD++qDQntfgQozQHi5I4
        74Wuk/FCAumJJanZqakFqUUwWSYOTqkGJsV5R+Zq21Rcnxr3if335f9/W7/dVFI+yrXlqr8Y
        2/O99XeZTe7WMtp6X7igZ/PmTFd4eaf2c8Vj/f9Of12qEvX1Zan8SZ7tk7rUPymKl0Vw34r+
        1K1/f7K4RXu2hdUvVZb1xSUL/Cxsfyu3yj7cvHSq0tmaoucRC/82bI89+PVZ1pyVLbti0j6/
        FYiJb2Pg8JIRc3xtdVu4f9WjI5sP7i7VLda6lxb880aTsYRi6EMVVq4dajtnbpI6s+PFzog3
        e6XMmRZwFnifXsFaNP2GranHFpuQlCO7DILWu9mVrProXbK4s6VN/O75Jmdpq4f9EWezQvIW
        /rdJtq/cOW3C7hYnnbcTS1cw8wv/WCrsrcRSnJFoqMVcVJwIAO6RWggXAwAA
X-CMS-MailID: 20210309095137epcas1p1feaf4a59335045b9df643238a80befcb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210308133406epcas1p241befcbf4638c0ebd477c0836040bf63
References: <CGME20210308133406epcas1p241befcbf4638c0ebd477c0836040bf63@epcas1p2.samsung.com>
        <20210308133041.10516-1-daniel.lezcano@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 3/8/21 10:30 PM, Daniel Lezcano wrote:
> Currently the default behavior is to manually having the devfreq
> backend to register themselves as a devfreq cooling device.
> 
> Instead of adding the code in the drivers for the thermal cooling
> device registering, let's provide a flag in the devfreq's profile to
> tell the common devfreq code to register the newly created devfreq as
> a cooling device.
> 
> Suggested-by: Chanwoo Choi <cwchoi00@gmail.com>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Reviewed-by: Steven Price <steven.price@arm.com>
> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  V6:
>    - Did one line string instead of multiline
>    - Removed thermal.h header inclusion as it is in devfreq_cooling.h
>    - Added forward declaration for thermal_cooling_device pointer in devfreq.h
>  V5:
>    - Changed subject prefix by:  PM / devfreq
>  V4:
>    - Replaced thermal_cooling_device_unregister() by
>      devfreq_cooling_unregister()
>  V3:
>    - Rebased on linux-pm branch without units.h
>    - Set the cdev to NULL in case of error
>    - Added description for the cdev field in the devfreq structure
>  V2:
>    - Added is_cooling_device boolean in profile structure
>    - Register cooling device when the is_cooling_device boolean is set
>    - Remove devfreq cooling device registration in the backend drivers
>  V1:
>    - Register devfreq as a cooling device unconditionnally
> ---
>  drivers/devfreq/devfreq.c | 9 +++++++++
>  include/linux/devfreq.h   | 9 +++++++++
>  2 files changed, 18 insertions(+)

(snip)

Applied it. Thanks.

I made the pull request with immutable branch
for preventing the conflict on other git repo as following:

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics


The following changes since commit fe07bfda2fb9cdef8a4d4008a409bb02f35f1bd8:

  Linux 5.12-rc1 (2021-02-28 16:05:19 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git immutable-devfreq-v5.13-rc1

for you to fetch changes up to 1224451bb6f938023dd7fa4e7ba43bfb185bc9e3:

  PM / devfreq: Register devfreq as a cooling device on demand (2021-03-09 15:40:16 +0900)

----------------------------------------------------------------
Daniel Lezcano (1):
      PM / devfreq: Register devfreq as a cooling device on demand

 drivers/devfreq/devfreq.c | 9 +++++++++
 include/linux/devfreq.h   | 9 +++++++++
 2 files changed, 18 insertions(+)


