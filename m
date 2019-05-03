Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1C5A12581
	for <lists+linux-pm@lfdr.de>; Fri,  3 May 2019 02:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbfECAaq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 May 2019 20:30:46 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:64504 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbfECAaq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 May 2019 20:30:46 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20190503003042epoutp0277f35a84e48441dcbeae4f577ae1178a~bBNzQ5xa20907009070epoutp021
        for <linux-pm@vger.kernel.org>; Fri,  3 May 2019 00:30:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20190503003042epoutp0277f35a84e48441dcbeae4f577ae1178a~bBNzQ5xa20907009070epoutp021
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1556843442;
        bh=/mW0a7EgdXP+GfFi7jYspPoh/2Xo3nNNKJQZy1psROk=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=EevzGfXb8KTzL6LdBVYKdAHdsF8ClX/SMOfJQ283GORN7+v5FG4Wr1/yg/ROGoPiI
         dYY8U/uCPbJWme42IOaH2oqrMM5lr9SZqmzQJiq6Uge1ZweUs5wgN+RQ95NtGhj/KT
         Wmukf9DhF5ohgNxL79386oF54kcwcMa0PuGuIML0=
Received: from epsmges1p4.samsung.com (unknown [182.195.40.154]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20190503003039epcas1p43ba529e11d0482a746ba80d2f4c223c7~bBNwxuz4g0549105491epcas1p48;
        Fri,  3 May 2019 00:30:39 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        07.06.04257.FAB8BCC5; Fri,  3 May 2019 09:30:39 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20190503003039epcas1p3aafe98914e562da9afcb98efafc34a51~bBNwG0R532972529725epcas1p3D;
        Fri,  3 May 2019 00:30:39 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190503003039epsmtrp24b72614b729428bcafc33a4c336fa573~bBNwGB4vn2268622686epsmtrp2L;
        Fri,  3 May 2019 00:30:39 +0000 (GMT)
X-AuditID: b6c32a38-5e3ff700000010a1-be-5ccb8bafdc1f
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        09.F8.03692.FAB8BCC5; Fri,  3 May 2019 09:30:39 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190503003038epsmtip16700f36f9cdb8a16aa7ab99078369749~bBNvzI7zd1157511575epsmtip1W;
        Fri,  3 May 2019 00:30:38 +0000 (GMT)
Subject: Re: [PATCH v4 00/16] NVIDIA Tegra devfreq improvements and
 Tegra20/30 support
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <60ef6e47-e61b-3a92-e90d-90debedfcfc4@samsung.com>
Date:   Fri, 3 May 2019 09:31:57 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190501233815.32643-1-digetx@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SWUwTURSGc9vOtBCKY0E4VKM4+mJDgRFaRyPEBGJqJIZEEzcCjnRsCe20
        6RSi+KIWN9QqaowWogQxKhVLFJVFhADRqHGJKAEMuEBUdhE34jrtYOTtm3P+c/7737kKqaoa
        VytyOCfr4BgLiQfLbrYu0mp9hx5mxBd362jveB+iCz3lMvrRnmE53V5fitMTR9oQffCzB6df
        7r6E05P1Z2W0u+oZviLIUNtTgQx1nh654YhrFDe4ayqRYeLa3HRsU+5yM8sYWUc0y2XbjDmc
        KYlcvTYrJUunj6e01FJ6CRnNMVY2iUxNS9euzLEIByKj8xlLnlBKZ3iejEte7rDlOdlos413
        JpGs3WixL7XH8oyVz+NMsdk26zIqPn6xThBuyTV3DU3i9q6I7ecGnsh3oaKZRShIAUQivO0s
        x4pQsEJF1CKofPdVJn58QuDrm8T9KhXxFUFndcS/Cd9YlUQUNSLYe/zB1PgYgpqTZZhfFUZs
        gMHyq1J/I5z4jeBT/elAQ0pshNY6r8TPOKGBpg+dAYsZxHx48b0P+VlJJMPg8z9SP8uIhVD3
        42mAZwlLX92txkTNTLh/pl/m5yBCD66PzRJxfyR095+b4nngulESOAQQ33DoKjsmFTOkwvhw
        MS5yGAzeq5GLrIaJ0cap+k64fL8NF4cPCNGanmJiIwGaLpwQHBSCwyLw1ceJZqEw+uUw5i8D
        oYQD+1SiegG0v+6RiBwF5/cfnFpvgHvHG7BjaL5nWhzPtAieaRE8/83KkKwSRbB23mpiecqe
        OP13X0OB16qha9Htx2ktiFAgMkQJvQ8yVBiTz++wtiBQSMlwZea4UFIamR0FrMOW5cizsHwL
        0gm3XSxVz8q2CW+fc2ZRusUJCQl0IqXXURQZqfStSMlQESbGyeayrJ11/JuTKILUu1CUV8O5
        kn59HygYmzO3NPNn+eeLhUMpm8syQ3XJpjBNofx6fnNMyJU76670WB+e0htnd/SPVJu8Je6O
        gcT2W66bFYWZ+tCcVWcHovq/bXX3drgaUi6PaIPPl3pHKwrqtmktVe9j00pisGL1OrubCz9q
        nly1PrRVnmo5Ojby5kLaGlLGmxlKI3XwzF9/oYjYwwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFIsWRmVeSWpSXmKPExsWy7bCSnO767tMxBpcPsFms/viY0aJl1iIW
        i7NNb9gtLu+aw2bxufcIo0Xnl1lsFrcbV7BZ/Nw1j8Wib+0lNgdOjx13lzB67Jx1l92jt/kd
        m0ffllWMHp83yQWwRnHZpKTmZJalFunbJXBl3Hz9k63gpljF/Jfn2RsYuwS7GDk5JARMJNa/
        X8vUxcjFISSwm1Hi0A+gFFhCUmLaxaPMXYwcQLawxOHDxRA1bxkl/h9bwQRSIywQITH/wiWw
        ZhGBJiaJzw9bwBLMApESPXO3sIHYQgKdjBJnpoDZbAJaEvtf3ACz+QUUJa7+eAy2jFfATuLV
        lf/MIDaLgIrEzt8XwGxRoAVn3q9ggagRlDg58wmYzSlgJtH84QDULnWJP/MuMUPY4hK3nsyH
        istLNG+dzTyBUXgWkvZZSFpmIWmZhaRlASPLKkbJ1ILi3PTcYsMCw7zUcr3ixNzi0rx0veT8
        3E2M4BjT0tzBeHlJ/CFGAQ5GJR7eggenYoRYE8uKK3MPMUpwMCuJ8MZ9BArxpiRWVqUW5ccX
        leakFh9ilOZgURLnfZp3LFJIID2xJDU7NbUgtQgmy8TBKdXAmN+1+XHzp28dir3lZTvWa9UJ
        CunvdvWVEdr8wVmirH9OU8TNlZ/7Db5evHBur9jD7X+e6ByQUvhfrl6bM4vJNeq4bdWCYynl
        hw6dUNj3L2YtN1fREo7GcMXAf7/Ydv5WN8j/lccckatvoFffdv1ghk+0pQqT+nbpPSvu7dpU
        FWuz0UHs4Yf5SizFGYmGWsxFxYkAJvgQ7K0CAAA=
X-CMS-MailID: 20190503003039epcas1p3aafe98914e562da9afcb98efafc34a51
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190501234148epcas5p1cc9a8dafa9ee6d8d046d1292b8270727
References: <CGME20190501234148epcas5p1cc9a8dafa9ee6d8d046d1292b8270727@epcas5p1.samsung.com>
        <20190501233815.32643-1-digetx@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Dmitry,

On 19. 5. 2. 오전 8:37, Dmitry Osipenko wrote:
> Changelog:
> 
> v4: Addressed all review comments that were made by Chanwoo Choi to v3:
> 
>     - changed the driver removal order to match the probe exactly
>     - added clarifying comment for 1/8 ratio to the Tegra20 driver
> 
>     Chanwoo, please also note that the clk patch that should fix
>     compilation problem that was reported the kbuild-test-robot is already
>     applied and available in the recent linux-next.

I knew that Stephen picked up your path about clock.

> 
> v3: Addressed all review comments that were made by Chanwoo Choi to v2.
> 
>     Patch "Synchronize IRQ after masking it in hardware" morphed into
>     "Properly disable interrupts", which disables interrupts more solidly.
> 
>     Added new minor patch: "Rename tegra-devfreq.c to tegra30-devfreq.c".
> 
>     Added missed error handlings for dev_pm_opp_add().
> 
> v2: The patchset was quite heavily reworked since v1, few patches we
>     dropped or squashed into the new ones and more patches we added.
>     In a result more bugs and potential problems are fixed now, driver's
>     code got more clean up.
> 
>     The Tegra20 driver-addition patch is now a part of this series, it has
>     no changes since v1.
> 
> Dmitry Osipenko (16):
>   PM / devfreq: tegra: Fix kHz to Hz conversion
>   PM / devfreq: tegra: Replace readl-writel with relaxed versions
>   PM / devfreq: tegra: Replace write memory barrier with the read
>     barrier
>   PM / devfreq: tegra: Don't ignore clk errors
>   PM / devfreq: tegra: Don't set EMC clock rate to maximum on probe
>   PM / devfreq: tegra: Drop primary interrupt handler
>   PM / devfreq: tegra: Properly disable interrupts
>   PM / devfreq: tegra: Clean up driver's probe / remove
>   PM / devfreq: tegra: Avoid inconsistency of current frequency value
>   PM / devfreq: tegra: Mark ACTMON's governor as immutable
>   PM / devfreq: tegra: Move governor registration to driver's probe
>   PM / devfreq: tegra: Reconfigure hardware on governor's restart
>   PM / devfreq: tegra: Support Tegra30
>   PM / devfreq: tegra: Enable COMPILE_TEST for the driver
>   PM / devfreq: tegra: Rename tegra-devfreq.c to tegra30-devfreq.c
>   PM / devfreq: Introduce driver for NVIDIA Tegra20
> 
>  MAINTAINERS                                   |   8 +
>  drivers/devfreq/Kconfig                       |  15 +-
>  drivers/devfreq/Makefile                      |   3 +-
>  drivers/devfreq/tegra20-devfreq.c             | 212 ++++++++++++
>  .../{tegra-devfreq.c => tegra30-devfreq.c}    | 315 ++++++++----------
>  5 files changed, 379 insertions(+), 174 deletions(-)
>  create mode 100644 drivers/devfreq/tegra20-devfreq.c
>  rename drivers/devfreq/{tegra-devfreq.c => tegra30-devfreq.c} (81%)
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
