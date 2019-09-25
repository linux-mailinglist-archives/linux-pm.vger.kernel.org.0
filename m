Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD652BD624
	for <lists+linux-pm@lfdr.de>; Wed, 25 Sep 2019 03:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390826AbfIYBkM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Sep 2019 21:40:12 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:18916 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389596AbfIYBkM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 Sep 2019 21:40:12 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190925014007epoutp03213d47211c115e08bf58c4ffd44d8da5~HiszDwEhN2451624516epoutp03L
        for <linux-pm@vger.kernel.org>; Wed, 25 Sep 2019 01:40:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190925014007epoutp03213d47211c115e08bf58c4ffd44d8da5~HiszDwEhN2451624516epoutp03L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1569375607;
        bh=VlFBabLxsT6pVY5OvbKB1AxeSRnSdAhftzYuJEwPV9s=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=V7Fhkq9fLTh8ORnQb4dXUKrf63yT0usl5gxmXYlZG8EXKLb5hdqlyWxWg88ZVThfp
         Jdp65WcA2MfPKuSDOjSSdzNgAWVMfH4MsXpx/ZxtbT/GJyLnTE74fggvcm+DvQ6Id4
         VHTtf8PlipM+dOGf5JoZQduqicrDITERwHxl7c3E=
Received: from epsnrtp5.localdomain (unknown [182.195.42.166]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190925014006epcas1p16ec69fe9a8e2fa77ee648fa6c986a238~HisybJBGz1145911459epcas1p1B;
        Wed, 25 Sep 2019 01:40:06 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.157]) by
        epsnrtp5.localdomain (Postfix) with ESMTP id 46dLN36KCBzMqYkb; Wed, 25 Sep
        2019 01:40:03 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        A4.18.04068.375CA8D5; Wed, 25 Sep 2019 10:40:03 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20190925014002epcas1p3a664abfe3476208f9a269b6c9b3971c2~Hisuz9FlG1260612606epcas1p3_;
        Wed, 25 Sep 2019 01:40:02 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190925014002epsmtrp2256ef98aaf207af7c02cddbff87d9a0b~HisutpN4u1881918819epsmtrp2D;
        Wed, 25 Sep 2019 01:40:02 +0000 (GMT)
X-AuditID: b6c32a39-f5fff70000000fe4-7d-5d8ac57302ff
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        2B.76.04081.275CA8D5; Wed, 25 Sep 2019 10:40:02 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190925014002epsmtip270c53580d133b51efe825d977f089cd3~HisuVh4S_2174121741epsmtip2c;
        Wed, 25 Sep 2019 01:40:02 +0000 (GMT)
Subject: Re: [PATCH v8 0/6] PM / devfreq: Add dev_pm_qos support
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Matthias Kaehlcke <mka@chromium.org>
Cc:     =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Abel Vesa <abel.vesa@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Lukasz Luba <l.luba@partner.samsung.com>,
        NXP Linux Team <linux-imx@nxp.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <b0cb5290-7b85-b803-2264-89d7d572fd1c@samsung.com>
Date:   Wed, 25 Sep 2019 10:44:26 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <cover.1569319738.git.leonard.crestez@nxp.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02TfUwTZxzH8/R6dy3aeRaU3xiZcGQmkvByQtnDJoRlZLlk/EE0JkZD2Aln
        i/Tl0muJbjErcwPsxl6ijlhcJHEYLBqkg6UqBS2IqS8oGkUUA4GaKOMlitVlm9laDjL++zy/
        3/d7v+f7PM9pCP0zKklTZXWIdqtgZqk49e/9mzIz5Cvusuzp+mQcHOymceT6NYRP3bmCcFPA
        R+Fbt87R+OZXMzR+6ErGbY+fk9g3dZ/E7r9OE3ihcQDhhXNTCD+qbaNw+9BlCruDbyjcGeGL
        GH7+wTc03+waVvMtPifv8x6i+LH7PRT/269f8p1zfhV/ea5HxX/f5UX8gu/d0rid1VtMolAp
        2lNEa4WtsspqLGA/3Vb+cbkhL5vL4PLx+2yKVbCIBWxxSWnGJ1XmaBA2pUYwO6OlUkGW2azC
        LXab0yGmmGyyo4AVpUqzlC9lyoJFdlqNmRU2ywdcdvZmQ1T4WbUpEhompMmN+57cqCNdKLTB
        jbQaYHLBe3gcuVGcRs/4EdQ2/EwqixcIrh8bWeq8QuD9J4KWLUP/XlMrjQCCV6EfaGUxj6Dz
        yAwZU8UzRRCOTKhijQSmHcHXrWOLdoIJE9DTsTidYtKh7+kDKsZrmFS49+fUokbHFEJTyyU6
        xmrmPZi9N07EeB2zA15M9JOKZi2EjoXVMdYyH0JT3fL3E+Fh+IRK4Q1wsLuZiG0CmDs0DPTW
        k0qGYrjbe4FQOB6mr3bRCifBwlyAUvgLOB0aoBRzA4KuvttL5hzoaz0cnaCJTtgEHReylHIq
        nP/7l6VNvAVzke/ImAQYHTTU6RVJGtydeKxS+G04WX+I+hGxnhVxPCsieFZE8Pw/rAWpvWi9
        KMkWoyhzkmHlffvQ4jNPz/ejwaGSIGI0iF2tKyLdZXpSqJH3W4IINASboPMkR0u6SmH/56Ld
        Vm53mkU5iAzR0/6JSFpXYYv+NFZHOWfYnJOTg3O5PAPHsYk63ugq0zNGwSFWi6Ik2pd9Ko02
        yYUa6ZaSVuuJP/TPdd8GtKOrEs68M/lIOiAd6Siobno603M8MdB9vOSjYufoSEj7cnJo5+vB
        jEs1+OpRx/go6994FuT+2jS0tXe+baRiNj5kzkUDqdN9hZlrVh+czdu9Nm0y358FjkDekz1H
        20zt24dzx1Rphl1v9o5cfN0cPtloZ9WySeDSCbss/AeD++D4/AMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAIsWRmVeSWpSXmKPExsWy7bCSvG7R0a5Ygxv90haHjm1lt/h6+hSj
        xbJLRxktpu/dxGZx/vwGdouzTW/YLW41yFisuPuR1WLT42usFl2/VjJbfO49wmjxecNjRovb
        jSvYLFafO8hm0XXoL5vFxq8eDgIe72+0snvMbrjI4rFgU6nHplWdbB53ru1h89i8pN5j47sd
        TB4H3+1h8ujbsorR4/MmuQCuKC6blNSczLLUIn27BK6MrycvMhc8Uqt4eqaNtYHxpHwXIyeH
        hICJxLn/p1i6GLk4hAR2M0rMPvaVBSIhKTHt4lHmLkYOIFtY4vDhYpCwkMBbRomTc9RBbGEB
        B4knXx8wgdgiAmsZJeacdwCxmQWeMUuc2JUGUd/HKLH0PA+IzSagJbH/xQ02EJtfQFHi6o/H
        jCA2r4CdxPQFB9hBbBYBVYm3V+8zg9iiAhESh3fMgqoRlDg58wnYaZwC1hLT2+4wQuxSl/gz
        7xIzhC0ucevJfCYIW16ieets5gmMwrOQtM9C0jILScssJC0LGFlWMUqmFhTnpucWGxYY5qWW
        6xUn5haX5qXrJefnbmIEx7OW5g7Gy0viDzEKcDAq8fA6sHbFCrEmlhVX5h5ilOBgVhLhnSUD
        FOJNSaysSi3Kjy8qzUktPsQozcGiJM77NO9YpJBAemJJanZqakFqEUyWiYNTqoFR1WLD1zym
        0ilLN3YWbC9aV6P7VigozbzxtM6ineW7juqtuCmT/KG/f4tv/gX+mhs9s7y6Ln5ttdt1aLL0
        70ijWaoJvi+V92wUWnXJ//iDDU+a13h4xUd95bd7d+vE9HmKz1/c2H3xWbHs/MCjmvbV82sX
        MZ2JC+wruuipES7/zq230bch3DxIiaU4I9FQi7moOBEAT5I8muMCAAA=
X-CMS-MailID: 20190925014002epcas1p3a664abfe3476208f9a269b6c9b3971c2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190924101140epcas1p4abeedf42f223e65f58c88a0ddf1e4e56
References: <CGME20190924101140epcas1p4abeedf42f223e65f58c88a0ddf1e4e56@epcas1p4.samsung.com>
        <cover.1569319738.git.leonard.crestez@nxp.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Leonard,

Basically, I think that these series are very important.

But, you better to send the next version patch
after finishing the review/discussion on previous version.

I reviewed the v7 and then you replied your comment.
It is OK. But, you just send v8 without waiting my comment
from your reply. It is not efficient discussion method.

If we finish the review of some point in the v7,
it doesn't need to discuss the same comment on v8. 

Please wait the reply for review. I think that
it can save the our time for the review and contribution.


On 19. 9. 24. 오후 7:11, Leonard Crestez wrote:
> Add dev_pm_qos notifiers to devfreq core in order to support frequency
> limits via dev_pm_qos_add_request.
> 
> Unlike the rest of devfreq the dev_pm_qos frequency is measured in Khz,
> this is consistent with current dev_pm_qos usage for cpufreq and
> allows frequencies above 2Ghz (pm_qos expresses limits as s32).
> 
> Like with cpufreq the handling of min_freq/max_freq is moved to the
> dev_pm_qos mechanism. Constraints from userspace are no longer clamped on
> store, instead all values can be written and we only check against OPPs in a
> new devfreq_get_freq_range function. This is consistent with the design of
> dev_pm_qos.
> 
> Notifiers from pm_qos are executed under a single global dev_pm_qos_mtx and
> need to take devfreq->lock. Notifier registration takes the same dev_pm_qos_mtx
> so in order to prevent lockdep warnings it must be done outside devfreq->lock.
> Current devfreq_add_device does all initialization under devfreq->lock and that
> needs to be relaxed.
> 
> ---
> Changes since v7:
> * Only #define HZ_PER_KHZ in patch where it's used.
> * Drop devfreq_ prefix for some internal functions.
> * Improve qos update error message.
> * Remove some unnecessary comments.
> * Collect reviews
> Link to v7: https://patchwork.kernel.org/cover/11157649/
> 
> Changes since v6:
> * Don't return errno from devfreq_qos_notifier_call, return NOTIFY_DONE
> and print the error.
> * More spelling and punctuation nits
> Link to v6: https://patchwork.kernel.org/cover/11157201/
> 
> Changes since v5:
> * Drop patches which are not strictly related to PM QoS.
> * Add a comment explaining why devfreq_add_device needs two cleanup paths.
> * Remove {} for single line.
> * Rename {min,max}_freq_req to user_{min,max}_freq_req
> * Collect reviews
> Link to v5: https://patchwork.kernel.org/cover/11149497/
> 
> Sorry for forgetting to properly label v5. I know this is inside the
> merge window but review would still be appreciated.
> 
> Changes since v4:
> * Move more devfreq_add_device init ahead of device_register.
> * Make devfreq_dev_release cleanup devices not yet in devfreq_list. This is
> simpler than previous attempt to add to devfreq_list sonner.
> * Take devfreq->lock in trans_stat_show
> * Register dev_pm_opp notifier on devfreq parent dev (which has OPPs)
> Link to v4: https://patchwork.kernel.org/cover/11114657/
> 
> Changes since v4:
> * Move more devfreq_add_device init ahead of device_register.
> * Make devfreq_dev_release cleanup devices not yet in devfreq_list. This is
> simpler than previous attempt to add to devfreq_list sonner.
> * Take devfreq->lock in trans_stat_show
> * Register dev_pm_opp notifier on devfreq parent dev (which has OPPs)
> Like to v4: https://patchwork.kernel.org/cover/11114657/
> 
> Changes since v3:
> * Cleanup locking and error-handling in devfreq_add_device
> * Register notifiers after device registration but before governor start
> * Keep the initialization of min_req/max_req ahead of device_register
> because it's used for sysfs handling
> * Use HZ_PER_KHZ instead of 1000
> * Add kernel-doc comments
> * Move OPP notifier to core
> Link to v3: https://patchwork.kernel.org/cover/11104061/
> 
> Changes since v2:
> * Handle sysfs via dev_pm_qos (in separate patch)
> * Add locking to {min,max}_freq_show
> * Fix checkpatch issues (long lines etc)
> Link to v2: https://patchwork.kernel.org/patch/11084279/
> 
> Changes since v1:
> * Add doxygen comments for min_nb/max_nb
> * Remove notifiers on error/cleanup paths. Keep gotos simple by relying on
> dev_pm_qos_remove_notifier ignoring notifiers which were not added.
> Link to v1: https://patchwork.kernel.org/patch/11078475/
> 
> Leonard Crestez (6):
>   PM / devfreq: Don't fail devfreq_dev_release if not in list
>   PM / devfreq: Move more initialization before registration
>   PM / devfreq: Don't take lock in devfreq_add_device
>   PM / devfreq: Introduce get_freq_range helper
>   PM / devfreq: Add PM QoS support
>   PM / devfreq: Use PM QoS for sysfs min/max_freq
> 
>  drivers/devfreq/devfreq.c | 268 +++++++++++++++++++++++++-------------
>  include/linux/devfreq.h   |  14 +-
>  2 files changed, 191 insertions(+), 91 deletions(-)
> 

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
