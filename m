Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2821A10E422
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2019 02:12:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727279AbfLBBMX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 1 Dec 2019 20:12:23 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:32297 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727266AbfLBBMX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 1 Dec 2019 20:12:23 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20191202011220epoutp03709b8ff3afc072e9482f40a50ae86a5b~caL9Eeaos2800028000epoutp03X
        for <linux-pm@vger.kernel.org>; Mon,  2 Dec 2019 01:12:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20191202011220epoutp03709b8ff3afc072e9482f40a50ae86a5b~caL9Eeaos2800028000epoutp03X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1575249140;
        bh=WPmCv07YFAbFQUab+kB9SUv//GYFJQ8jwI8NVUbMbMw=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=p8GBTpIuffnQ3UIvVrR7LqNhJkR9WeZcEEKFYWHDWbKIFWdPSoXhnqhCMimHvWqxR
         xyPj+UgLmRomg77Gb7g+1I2JIbyaQ9upLjn8H+9LfSSckemGjNRg7Er5S62UwhrKkJ
         zP1xlkilIGrq6E5bGOWn0D9GtI3a07PYZGRPHYtM=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20191202011219epcas1p28179e6341adcfaf803b5681a36cf2694~caL8e30_M2060620606epcas1p2E;
        Mon,  2 Dec 2019 01:12:19 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.155]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 47R6XS0v5ZzMqYm2; Mon,  2 Dec
        2019 01:12:08 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        A6.86.48019.8E464ED5; Mon,  2 Dec 2019 10:12:08 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20191202011207epcas1p17234463709e10e6702887483e6e1130a~caLw7J-u_1842718427epcas1p1Y;
        Mon,  2 Dec 2019 01:12:07 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191202011207epsmtrp174a201102f0289530761e42a13cc038d~caLw6Le431218412184epsmtrp1b;
        Mon,  2 Dec 2019 01:12:07 +0000 (GMT)
X-AuditID: b6c32a38-23fff7000001bb93-92-5de464e80265
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        64.2E.10238.7E464ED5; Mon,  2 Dec 2019 10:12:07 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191202011207epsmtip10b781d8f3f2440a747e6d98546755082~caLwr6YaX0775007750epsmtip1e;
        Mon,  2 Dec 2019 01:12:07 +0000 (GMT)
Subject: Re: [PATCH RFC 2/2] PM / devfreq: Use PM QoS for sysfs min/max_freq
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Kyungmin Park <kyungmin.park@samsung.com>,
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
Message-ID: <a1c3f61e-f615-8b29-3c9e-bf65b529b038@samsung.com>
Date:   Mon, 2 Dec 2019 10:18:24 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <1f567d6478b1782f7f4afc27cb6d3f896d77ac9f.1574179738.git.leonard.crestez@nxp.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGJsWRmVeSWpSXmKPExsWy7bCmru6LlCexBuvms1ocOraV3eLr6VOM
        FtP3bmKzOH9+A7vF2aY37BYr7n5ktdj0+BqrRdevlcwWn3uPMFp83vCY0eJ24wo2i9XnDrJZ
        nDl9CSh76C+bxcavHg78Hu9vtLJ7zG64yOKxYFOpx6ZVnWwed67tYfPYvKTeY+O7HUweB9/t
        YfLYcrWdxaNvyypGj8+b5AK4o7JtMlITU1KLFFLzkvNTMvPSbZW8g+Od403NDAx1DS0tzJUU
        8hJzU22VXHwCdN0yc4A+UVIoS8wpBQoFJBYXK+nb2RTll5akKmTkF5fYKqUWpOQUWBboFSfm
        Fpfmpesl5+daGRoYGJkCFSZkZyzd/4y14BZbRWPzQuYGxp2sXYycHBICJhI32rczdTFycQgJ
        7GCUmH1nJTNIQkjgE6PEzi3aEPY3RolNf2RhGs5e380M0bCXUWL63XUsEM57oIb+A4xdjBwc
        wgI+Eoc/K4I0iAjUSfxc1MUKUsMs8JFZ4vGV9WCr2QS0JPa/uMEGYvMLKEpc/fGYEcTmFbCT
        OL1vEtgVLAIqEl+39IDViAqESZzc1gJVIyhxcuYTFpBdnAJxEotWJIKEmQXEJW49mc8EYctL
        bH87B+xQCYFL7BJ3F7yHetlFYt/kWYwQtrDEq+Nb2CFsKYmX/W1QdrXEypNH2CCaOxgltuy/
        ANVsLLF/6WQmkMXMApoS63fpQ4QVJXb+nssIsZhP4t3XHlaQEgkBXomONiGIEmWJyw/uMkHY
        khKL2zvZJjAqzULyzSwkL8xC8sIshGULGFlWMYqlFhTnpqcWGxaYIMf1JkZwGtey2MG455zP
        IUYBDkYlHt6OV49jhVgTy4orcw8xSnAwK4nwXld6GCvEm5JYWZValB9fVJqTWnyI0RQY2BOZ
        pUST84E5Jq8k3tDUyNjY2MLE0MzU0FBJnJfjx8VYIYH0xJLU7NTUgtQimD4mDk6pBsYke0ur
        07waT4RrmObX1HzraM4UC9VfEhmxpS2xvi77fxb7ekWD9o7zK4vO/j6ZFvosJnPhvoWhjbP+
        rn6wcSrrsZZTDZten9++m+no0qA/2df3F6+zXnM+yuGMbWxAiITk9n1ZBjNUE5jfHDTWKC2N
        frxcbOt8KdGJtQ193849UZttNFf1l4YSS3FGoqEWc1FxIgCqt00T+QMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEIsWRmVeSWpSXmKPExsWy7bCSnO7zlCexBn3L+SwOHdvKbvH19ClG
        i+l7N7FZnD+/gd3ibNMbdosVdz+yWmx6fI3VouvXSmaLz71HGC0+b3jMaHG7cQWbxepzB9ks
        zpy+BJQ99JfNYuNXDwd+j/c3Wtk9ZjdcZPFYsKnUY9OqTjaPO9f2sHlsXlLvsfHdDiaPg+/2
        MHlsudrO4tG3ZRWjx+dNcgHcUVw2Kak5mWWpRfp2CVwZS/c/Yy24xVbR2LyQuYFxJ2sXIyeH
        hICJxNnru5m7GLk4hAR2M0qcPL2UESIhKTHt4lGgBAeQLSxx+HAxRM1bRolV776yg8SFBXwk
        Dn9WBCkXEaiT+PT7ACNIDbPAR2aJg4sWQw19xCgx6/lkdpAqNgEtif0vbrCB2PwCihJXfzwG
        W8YrYCdxet8kZhCbRUBF4uuWHrAaUYEwiZ1LHjNB1AhKnJz5hAVkMadAnMSiFYkgYWYBdYk/
        8y4xQ9jiEreezGeCsOUltr+dwzyBUXgWku5ZSFpmIWmZhaRlASPLKkbJ1ILi3PTcYsMCw7zU
        cr3ixNzi0rx0veT83E2M4JjW0tzBeHlJ/CFGAQ5GJR7ejlePY4VYE8uKK3MPMUpwMCuJ8F5X
        ehgrxJuSWFmVWpQfX1Sak1p8iFGag0VJnPdp3rFIIYH0xJLU7NTUgtQimCwTB6dUA6PI1+NR
        E+0mfdKvt7y94txhgYTQwldM9ZIsRUGhcv1cSa94VY9Gd1g/2+9+S/m/4Ldd9/88U3W8n1TJ
        FMrfG7hqgw9ztF3OIs78+ZdS+SPYZ7PdUw1f6dq3+Fj+lQtB7UvLbm6P/nsxWf5WT0S8+98a
        0anJ6WyWfyO46vgitnhN9P237GJCgxJLcUaioRZzUXEiAHpvBAHlAgAA
X-CMS-MailID: 20191202011207epcas1p17234463709e10e6702887483e6e1130a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191119161307epcas1p2433f37aca4b40f6f122a786241d5399d
References: <cover.1574179738.git.leonard.crestez@nxp.com>
        <CGME20191119161307epcas1p2433f37aca4b40f6f122a786241d5399d@epcas1p2.samsung.com>
        <1f567d6478b1782f7f4afc27cb6d3f896d77ac9f.1574179738.git.leonard.crestez@nxp.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11/20/19 1:12 AM, Leonard Crestez wrote:
> Switch the handling of min_freq and max_freq from sysfs to use the
> dev_pm_qos_request interface.
> 
> Since PM QoS handles frequencies as kHz this change reduces the
> precision of min_freq and max_freq. This shouldn't introduce problems
> because frequencies which are not an integer number of kHz are likely
> not an integer number of Hz either.
> 
> Try to ensure compatibility by rounding min values down and rounding
> max values up.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> ---
>  drivers/devfreq/devfreq.c | 76 ++++++++++++++++++++++++++++++---------
>  include/linux/devfreq.h   |  9 ++---
>  2 files changed, 64 insertions(+), 21 deletions(-)

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

Thanks.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
