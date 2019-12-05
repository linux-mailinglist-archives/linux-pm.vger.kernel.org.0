Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 040871138F1
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2019 01:45:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728510AbfLEAp5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Dec 2019 19:45:57 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:53165 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728011AbfLEAp4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Dec 2019 19:45:56 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20191205004553epoutp02fb5c117968f99de5f7876fff2a90fb84~dUwuGQe3T1872518725epoutp022
        for <linux-pm@vger.kernel.org>; Thu,  5 Dec 2019 00:45:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20191205004553epoutp02fb5c117968f99de5f7876fff2a90fb84~dUwuGQe3T1872518725epoutp022
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1575506753;
        bh=4yx3iV5vYirEct6BeRZWUx6tNEIRqMbuST2Pl2b84Hs=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=CKwgtTgFa5Jd30MUoNnsnbxjFbkyhG+MrCoTT6s7hk/PrOJcHCcV8DCZJxziWG+z3
         EOsgpfmMMC+9i0vDL2dkQaRbVf+enjMsxUXMcSqkVJOCp4ScJ+ccnAeRhhlLHxUK7x
         XUgYhoSs6oqWgykqKUVL8Az5LSThCoP5bCiMgwA8=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191205004553epcas1p1ef977b6ac7d666fe7336f4405b9ec6d9~dUwtirXGF1335713357epcas1p1y;
        Thu,  5 Dec 2019 00:45:53 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.157]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 47Sxpk4L7TzMqYkb; Thu,  5 Dec
        2019 00:45:50 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        70.32.52419.D3358ED5; Thu,  5 Dec 2019 09:45:49 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20191205004549epcas1p29c48279019c4812fbdf92f3a744ac55d~dUwqORc0A0507205072epcas1p2V;
        Thu,  5 Dec 2019 00:45:49 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191205004549epsmtrp1737b8bc0f8edebc49190e5dd6bdd8852~dUwqNeHwq3139631396epsmtrp17;
        Thu,  5 Dec 2019 00:45:49 +0000 (GMT)
X-AuditID: b6c32a37-59fff7000001ccc3-2b-5de8533dd4de
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        41.E9.10238.D3358ED5; Thu,  5 Dec 2019 09:45:49 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191205004549epsmtip18584782c722c1abdc598c3b1606c927f~dUwp6c4oS0331103311epsmtip1i;
        Thu,  5 Dec 2019 00:45:49 +0000 (GMT)
Subject: Re: [PATCH RFC 0/2] PM / devfreq: Add dev_pm_qos support with
 minimal changes
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Jacky Bai <ping.bai@nxp.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <f13d1b5e-0c33-4cf4-352d-d48ddf309b5c@samsung.com>
Date:   Thu, 5 Dec 2019 09:52:03 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <5794906.l6Fuony6qs@kreacher>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBJsWRmVeSWpSXmKPExsWy7bCmvq5d8ItYg4eLlS0OHdvKbvH19ClG
        i+l7N7FZnD+/gd3ibNMbdosVdz+yWmx6fI3VouvXSmaLz71HGC0+b3jMaHG7cQWbxepzB9ks
        zpy+BJQ99JfNYuNXDwd+j/c3Wtk9ZjdcZPFYsKnUY9OqTjaPO9f2sHlsXlLvsfHdDiaPg+/2
        MHlsudrO4tG3ZRWjx+dNcgHcUdk2GamJKalFCql5yfkpmXnptkrewfHO8aZmBoa6hpYW5koK
        eYm5qbZKLj4Bum6ZOUCfKCmUJeaUAoUCEouLlfTtbIryS0tSFTLyi0tslVILUnIKLAv0ihNz
        i0vz0vWS83OtDA0MjEyBChOyM55t2sdWcFmu4sSuacwNjBcluxg5OSQETCQuPv3K2MXIxSEk
        sINR4vmxLYwgCSGBT4wSXQ8zIBLfGCXebd3ICtNx8t1CVoiivYwSE2a5QBS9Z5RY+vcqO0hC
        WCBC4s2/BiYQWwTIXvR1DtgKZoHpLBIdiyAmsQloSex/cYMNxOYXUJS4+uMx2GpeATuJmTsf
        M4PYLAIqEt1Nx8DqRQXCJE5ua4GqEZQ4OfMJC4jNCTRn1pI+MJtZQFzi1pP5TBC2vMT2t3OY
        QRZLCFxjl9j5awEbxAsuEqfmX4OyhSVeHd/CDmFLSbzsb4OyqyVWnjzCBtHcwSixZf8FqP+N
        JfYvnQy0gQNog6bE+l36EGFFiZ2/5zJCLOaTePe1hxWkREKAV6KjTQiiRFni8oO7TBC2pMTi
        9k62CYxKs5C8MwvJC7OQvDALYdkCRpZVjGKpBcW56anFhgXGyLG9iRGcyrXMdzBuOOdziFGA
        g1GJh7dh0/NYIdbEsuLK3EOMEhzMSiK82ySexgrxpiRWVqUW5ccXleakFh9iNAWG9kRmKdHk
        fGCeySuJNzQ1MjY2tjAxNDM1NFQS5+X4cTFWSCA9sSQ1OzW1ILUIpo+Jg1OqgbHEMV/4zdb9
        lmHzpJuMPknsW/ibrUiVs4mjVPv33rTl6+v/1fV8K/pi+7Lz39ql+6ce2lMV1lL2Z4Xmm4WS
        hw+yxS+/bH9++lyR9DC5E379z5Ula29FKh3KXCFh8zOa0apIeOG3r/KihT7rLi5/U/h1zdO6
        PGenfVcmCsTYH9cIYJl74rPw5qNKLMUZiYZazEXFiQA4bqVg+wMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMIsWRmVeSWpSXmKPExsWy7bCSnK5t8ItYg0svBC0OHdvKbvH19ClG
        i+l7N7FZnD+/gd3ibNMbdosVdz+yWmx6fI3VouvXSmaLz71HGC0+b3jMaHG7cQWbxepzB9ks
        zpy+BJQ99JfNYuNXDwd+j/c3Wtk9ZjdcZPFYsKnUY9OqTjaPO9f2sHlsXlLvsfHdDiaPg+/2
        MHlsudrO4tG3ZRWjx+dNcgHcUVw2Kak5mWWpRfp2CVwZzzbtYyu4LFdxYtc05gbGi5JdjJwc
        EgImEiffLWTtYuTiEBLYzSix/P4MVoiEpMS0i0eZuxg5gGxhicOHiyFq3jJKdF7ewQhSIywQ
        IfF+w0xmEFsEyJ61+gg7SBGzwEwWiaPrvrGBJIQE1jFKrDthA2KzCWhJ7H9xAyzOL6AocfXH
        Y7BBvAJ2EjN3PgYbxCKgItHddAzsCFGBMImdSx4zQdQISpyc+YQFxOYEmjNrSR+YzSygLvFn
        3iVmCFtc4taT+UwQtrzE9rdzmCcwCs9C0j4LScssJC2zkLQsYGRZxSiZWlCcm55bbFhgmJda
        rlecmFtcmpeul5yfu4kRHNVamjsYLy+JP8QowMGoxMPbsOl5rBBrYllxZe4hRgkOZiUR3m0S
        T2OFeFMSK6tSi/Lji0pzUosPMUpzsCiJ8z7NOxYpJJCeWJKanZpakFoEk2Xi4JRqYKw6uKz3
        7789apZGGfnRm7zP/lPw3sTzVO/UeuanXAfMd3H5OywrDatdyHsldOLWJYHK8Ws4kt995Q4I
        NtXfpsaxL2SF58rKo5dMdt7x/b0+Omd+2tf7liJ5dY1rptmucX1+uav1R+8HxW9uB2Tjfksr
        3pZf+CqZyz/Xb+WhvUfktPemPvoqbaPEUpyRaKjFXFScCACQ0ZgN5gIAAA==
X-CMS-MailID: 20191205004549epcas1p29c48279019c4812fbdf92f3a744ac55d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191204104624epcas1p16af5e2778fe0691c1ec29b25f11dc385
References: <cover.1574179738.git.leonard.crestez@nxp.com>
        <CGME20191204104624epcas1p16af5e2778fe0691c1ec29b25f11dc385@epcas1p1.samsung.com>
        <5794906.l6Fuony6qs@kreacher>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12/4/19 7:46 PM, Rafael J. Wysocki wrote:
> On Tuesday, November 19, 2019 5:12:12 PM CET Leonard Crestez wrote:
>> Add dev_pm_qos notifiers to devfreq core in order to support frequency
>> limits via dev_pm_qos_add_request.
>>
>> Unlike the rest of devfreq the dev_pm_qos frequency is measured in kHz,
>> this is consistent with current dev_pm_qos usage for cpufreq and
>> allows frequencies above 2Ghz (pm_qos expresses limits as s32).
>>
>> Like with cpufreq the handling of min_freq/max_freq is moved to the
>> dev_pm_qos mechanism. Constraints from userspace are no longer clamped on
>> store, instead all values can be written and we only check against OPPs in a
>> new devfreq_get_freq_range function. This is consistent with the design of
>> dev_pm_qos.
>>
>> Notifiers from pm_qos are executed under a single global dev_pm_qos_mtx and
>> need to take devfreq->lock, this means that calls into dev_pm_qos while holding
>> devfreq->lock are not allowed (lockdep warns about possible deadlocks).
>>
>> Fix this by only adding the qos request and notifiers after devfreq->lock is
>> released inside devfreq_add_device. In theory this means sysfs writes
>> are possible before the min/max requests are initialized so we guard
>> against that explictly. The dev_pm_qos_update_request function would
>> otherwise print a big WARN splat.
>>
>> Alternatively devfreq initialization could be refactored to avoid taking
>> devfreq->lock but that requires several intricate changes:
>>
>> 	https://protect2.fireeye.com/url?k=0cd18bf1-51473286-0cd000be-0cc47a312ab0-56d7069e720c53c0&u=https://patchwork.kernel.org/cover/11242865/
>>
>> I considered making dev_pm_qos call notifiers outside the lock but
>> that's another complex refactoring and it's difficult to ensure
>> correctness. If two identical qos requests are made in parallel then the
>> second shouldn't return until all notifiers are completely executed for
>> the first and QOS is enforced; otherwise it mostly defeats the purpose
>> of making proactive requests.
>>
>> This series implements the minimal changes in order to implement dev_pm_qos
>> support for devfreq. It only costs a little defensive programming.
>>
>> This series is also marked as [RFC] because it depends on restoring
>> DEV_PM_QOS_MIN/MAX_FREQUENCY inside the pm core:
>>
>> 	https://protect2.fireeye.com/url?k=304e4bce-6dd8f2b9-304fc081-0cc47a312ab0-ae5dd24df5aed564&u=https://patchwork.kernel.org/cover/11250413/
>>
>> ---
>> Changes since "big version" v10:
>> * Drop accepted cleanups
>> * Work with current locking approach (split cleanups into other series)
>> * Drop acks and deliberately relabel as a new series. It still incorporates
>> most previous discussion but takes a different approach to locking.
>> * Don't print errors if devfreq_dev_release is called on error cleanup from
>> devfreq_add_device, just accept that requests and notifiers might not be
>> registered yet. I wish dev_pm_qos cleanups behaved like standard "kfree" and
>> silently did nothing when there's nothing to be done.
>> Link to v10: https://protect2.fireeye.com/url?k=221a9dd6-7f8c24a1-221b1699-0cc47a312ab0-2fdb90bdac06bfe8&u=https://patchwork.kernel.org/project/linux-arm-kernel/list/?series=196443
>>
>> Leonard Crestez (2):
>>   PM / devfreq: Add PM QoS support
>>   PM / devfreq: Use PM QoS for sysfs min/max_freq
>>
>>  drivers/devfreq/devfreq.c | 151 ++++++++++++++++++++++++++++++++++----
>>  include/linux/devfreq.h   |  14 +++-
>>  2 files changed, 145 insertions(+), 20 deletions(-)
> 
> Please resend this series as non-RFC with the ACKs from Chanwoo included.
> 
> It may still be viable to push it for 5.5 during the -rc period.
> 

If Leonard resend this patch with Ack, I'll send the pull-request for -rc period
with the related minimal patches. Thanks.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
