Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1D8B135C36
	for <lists+linux-pm@lfdr.de>; Thu,  9 Jan 2020 16:06:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732155AbgAIPGe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Jan 2020 10:06:34 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:45395 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728346AbgAIPGe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Jan 2020 10:06:34 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200109150632euoutp011737c909ac249b80e5d3dc10c0ca40a8~oQFJyfDmw0998109981euoutp01q
        for <linux-pm@vger.kernel.org>; Thu,  9 Jan 2020 15:06:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200109150632euoutp011737c909ac249b80e5d3dc10c0ca40a8~oQFJyfDmw0998109981euoutp01q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1578582392;
        bh=jFFqGCtRGF5oe2+nOUE3OLodOmKRa6ErUN0sBN0Fe5A=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=OIEU8+qhTuG+83QCDGQPQ3kCbGZnreq0hXj7Hfh3EKiauQ+TZ9SxFPnNoReT1ZDTp
         1wTBNx158bu4d5IUg2hqYMfKmPdt1d4QHuXWkp05IF6LExaqqL8rGEK42fpX8ESwy6
         D5bROMcG0MTCoHRb0vftelLxUvDGxJ36T5skQukU=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200109150631eucas1p29b2f829c4f6ac90a8482e5cfdcf21dca~oQFJZ0S9g2365923659eucas1p2N;
        Thu,  9 Jan 2020 15:06:31 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 53.D6.60698.771471E5; Thu,  9
        Jan 2020 15:06:31 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200109150631eucas1p2d7a50f633e2b9902c767e2e68780a3aa~oQFI-O0rP2362123621eucas1p2b;
        Thu,  9 Jan 2020 15:06:31 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200109150631eusmtrp10b4928fccadf07c9d0873acf96cf83ad~oQFI_cIHT0581005810eusmtrp1x;
        Thu,  9 Jan 2020 15:06:31 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-9d-5e1741777841
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 5B.7C.07950.771471E5; Thu,  9
        Jan 2020 15:06:31 +0000 (GMT)
Received: from [106.120.51.18] (unknown [106.120.51.18]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200109150630eusmtip19f4b73203012fee7fd24310de73eb51b~oQFIQ1hEU2388923889eusmtip1D;
        Thu,  9 Jan 2020 15:06:30 +0000 (GMT)
Subject: Re: [PATCH 0/2] PM / devfreq: Add debugfs support
To:     Chanwoo Choi <cw00.choi@samsung.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     leonard.crestez@nxp.com, lukasz.luba@arm.com, a.swigon@samsung.com,
        m.szyprowski@samsung.com, enric.balletbo@collabora.com,
        hl@rock-chips.com, digetx@gmail.com, bjorn.andersson@linaro.org,
        jcrouse@codeaurora.org, chanwoo@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com
From:   Kamil Konieczny <k.konieczny@samsung.com>
Message-ID: <fb1e88a2-8a5d-3dc6-e36d-523c556e67b1@samsung.com>
Date:   Thu, 9 Jan 2020 16:06:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200107090519.3231-1-cw00.choi@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SW0wTQRSGM91tuzQUhwXtAQxg1QdRwIoPGzBGEsV90MQnMUbQRdfSQAtp
        QYQnRRStSLgEoRURikFSUYEgFDQiiBdA8BptRCJGhHoBqYABoqLtYuTtm/P/Z875J0MRtEPs
        T2l0abxexyUrJTKy+cFsf2hGtCJ+fVORinlXcRIxve3jJFNof0kyr6dGxcxV5wfE1A10Imam
        vodgGiqTmL7sr1KmdtApZl60lUuYyXNdiKnKzpEy17oGpczA8VrJliVsXUUdYl/knxOxtsHL
        iG01D0rZRusZCfv21W0J2zBuE7G/zO0km99kRexkY+Au2V7ZpkN8suYIrw/ffECW2HGvkEh1
        Rhyd/PkGHUOvg43IgwK8EZwDFSIjklE0rkVgKbxICIcpBJ+fFS0okwgmHOeREVHulpEzoa5u
        Gl9BUDYdI3jGEMz226UuwQdHgmOqnnSxL06AC7ab7osIXCOC7hG7W5DgcOjo63azHG+GuewZ
        wjWAxKvglCXBhUvxHuid5gSHN3Sbht1uj7/XT3355h5FYAW8Gb4kEjgIWsbK3QEAF1Jgei+Y
        AG+F75ZSQmAf+PywaaG+HHqL80iBM+BjVb5UaM5BMJTrXBCi4G3/nMS1EIHXwI22cKEcDcMd
        ZrHwJl5gH/MWdvCCouZSQijL4fQpWnCvhtGePJHAAWCcvy4uQErzomTmRWnMi9KY/8+tRKQV
        Kfh0g1bNGyJ0fEaYgdMa0nXqsIMp2kb09//1/n44bUN3fiZ0Ikwhpac80UcRT4u5I4ZMbScC
        ilD6yu/bl8XT8kNcZhavT9mvT0/mDZ0ogCKVCnmE5VMcjdVcGp/E86m8/p8qojz8jyFRT/Vy
        7WNWsbsvhr4aOTFe7Vh793CqI/LEhlpr7NlR9Y7xErEqxrYlJLI1V7PNT4VqAr13agKfllh/
        a+YDHmWZGoPELZ7JAXSZKc2hKr5DT5vmA5/R6FZflV/cSl0BV5KyMkruK1dvj7XuXvcjLG/F
        0Pp1jth9wUbO/PzJAFaShkROFULoDdwf5SysRXsDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLIsWRmVeSWpSXmKPExsVy+t/xu7rljuJxBi8+C1vcn9fKaHF6/zsW
        i4k3rrBYXP/ynNVi9cfHjBZrbh9itPix4RSzxcYF2RZnm96wW6y4+5HV4vKuOWwWn3uPMFos
        bGpht1h75C67xe3GFWwO/B5r5q1h9Ljc18vksePuEkaPnbPusntsWtXJ5nHn2h42j43vdjB5
        /J21n8Wjb8sqRo/Pm+QCuKL0bIryS0tSFTLyi0tslaINLYz0DC0t9IxMLPUMjc1jrYxMlfTt
        bFJSczLLUov07RL0Mg4enshc8NG44vOfW4wNjNcVuhg5OCQETCSedep2MXJxCAksZZQ4Pa+Z
        tYuREyguLdF4ejUThC0s8edaFxtE0WtGicnt79lBEsICVhIvvmxgAbFFBJIkdkxpYgYpYhZY
        xiRx4kkbM0RHL6PE4bfrwDrYBPQlDp49CdbBK2An8avpBzPIGSwCKhJti5JAwqICERLPt99g
        hCgRlDg58wlYOSfQsi+vIRYzC6hL/Jl3iRnCFpe49WQ+E4QtL7H97RzmCYxCs5C0z0LSMgtJ
        yywkLQsYWVYxiqSWFuem5xYb6RUn5haX5qXrJefnbmIERv22Yz+37GDsehd8iFGAg1GJhzdD
        WDxOiDWxrLgy9xCjBAezkgjv0RticUK8KYmVValF+fFFpTmpxYcYTYF+m8gsJZqcD0xIeSXx
        hqaG5haWhubG5sZmFkrivB0CB2OEBNITS1KzU1MLUotg+pg4OKUaGENm/chpMHgSk6Ad27u7
        /iHj8Zx9c5/ys3971N59v35Shuy7y7vDPeVrZbwSpqa265xdqcY392hzycmQYqNrlyrmPNwU
        kT0nPbtuxVeBrJtqSc8PcgnL9eoKihge5VLszpNZsl9QU72l9/qF5AUZMk5Xu9pv/os0lDqb
        Xuzkz2aQ+aFzIucfJZbijERDLeai4kQA9SG7DRADAAA=
X-CMS-MailID: 20200109150631eucas1p2d7a50f633e2b9902c767e2e68780a3aa
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200107085812epcas1p4eb4f51c2ade10db700fbfd62ab4779fb
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200107085812epcas1p4eb4f51c2ade10db700fbfd62ab4779fb
References: <CGME20200107085812epcas1p4eb4f51c2ade10db700fbfd62ab4779fb@epcas1p4.samsung.com>
        <20200107090519.3231-1-cw00.choi@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 07.01.2020 10:05, Chanwoo Choi wrote:
> Add debugfs interface to provide debugging information of devfreq device.
> It contains 'devfreq_summary' and 'debug_transitions' debugfs file
> in order to provide the simple profiling to user via debugfs
> without any specific profiling tool.
> 
> [Added debugfs file]
> - "/sys/kernel/debug/devfreq/devfreq_summary"
>   : Show the summary of the registered devfreq devices.
> - "/sys/kernel/debug/devfreq/devfreq_transitions"
>   : Show the frequency transition of the registered devfreq devices.
> 
> Recommend the each patch to check the detailed description
> of each fields of both devfreq_summary and devfreq_transitions.
> 
> This series contains the patch[1] and add the patch2 for 'devfreq_transitions'
> [1] https://patchwork.kernel.org/patch/11320265/
> - [v3] PM / devfreq: Add debugfs support with devfreq_summary file
> 
> 
> For example on Exynos5422-based Odroid-XU3 board,
> - In order to show the multiple governors on devfreq_summay result,
> change the governor of devfreq0 from simple_ondemand to userspace.
> 
> $ cat /sys/kernel/debug/devfreq/devfreq_summary
> dev_name                       dev        parent_dev governor        polling_ms cur_freq_hz  min_freq_hz  max_freq_hz

Imho either drop "_hz" or change it to "_Hz".

> ------------------------------ ---------- ---------- --------------- ---------- ------------ ------------ ------------
> 10c20000.memory-controller     devfreq0              userspace       0          206000000    165000000    825000000
> soc:bus_wcore                  devfreq1              simple_ondemand 50         532000000    88700000     532000000
> soc:bus_noc                    devfreq2   devfreq1   passive         0          111000000    66600000     111000000
> soc:bus_fsys_apb               devfreq3   devfreq1   passive         0          222000000    111000000    222000000
> soc:bus_fsys                   devfreq4   devfreq1   passive         0          200000000    75000000     200000000
> soc:bus_fsys2                  devfreq5   devfreq1   passive         0          200000000    75000000     200000000
> soc:bus_mfc                    devfreq6   devfreq1   passive         0          333000000    83250000     333000000
> soc:bus_gen                    devfreq7   devfreq1   passive         0          266000000    88700000     266000000
> soc:bus_peri                   devfreq8   devfreq1   passive         0          66600000     66600000     66600000
> soc:bus_g2d                    devfreq9   devfreq1   passive         0          0            83250000     333000000

Imho it better looks with freq aligned to right, eg.:

soc:bus_gen                    devfreq7   devfreq1   passive         0          266000000     88700000     266000000
soc:bus_peri                   devfreq8   devfreq1   passive         0           66600000     66600000      66600000
soc:bus_g2d                    devfreq9   devfreq1   passive         0                  0     83250000     333000000

> soc:bus_g2d_acp                devfreq10  devfreq1   passive         0          0            66500000     266000000
> soc:bus_jpeg                   devfreq11  devfreq1   passive         0          0            75000000     300000000
> soc:bus_jpeg_apb               devfreq12  devfreq1   passive         0          0            83250000     166500000
> soc:bus_disp1_fimd             devfreq13  devfreq1   passive         0          0            120000000    200000000
> soc:bus_disp1                  devfreq14  devfreq1   passive         0          0            120000000    300000000
> soc:bus_gscl_scaler            devfreq15  devfreq1   passive         0          0            150000000    300000000
> soc:bus_mscl                   devfreq16  devfreq1   passive         0          0            84000000     666000000
> 
> $ cat /sys/kernel/debug/devfreq/devfreq_transitions
> time_ms    dev_name                       dev        parent_dev load_% old_freq_hz  new_freq_hz
> ---------- ------------------------------ ---------- ---------- ---------- ------------ ------------
> 14600      soc:bus_noc                    devfreq2   devfreq1   0      100000000    67000000
> 14600      soc:bus_fsys_apb               devfreq3   devfreq1   0      200000000    100000000
> 14600      soc:bus_fsys                   devfreq4   devfreq1   0      200000000    100000000
> 14600      soc:bus_fsys2                  devfreq5   devfreq1   0      150000000    75000000
> 14602      soc:bus_mfc                    devfreq6   devfreq1   0      222000000    96000000
> 14602      soc:bus_gen                    devfreq7   devfreq1   0      267000000    89000000
> 14602      soc:bus_g2d                    devfreq9   devfreq1   0      300000000    84000000
> 14602      soc:bus_g2d_acp                devfreq10  devfreq1   0      267000000    67000000
> 14602      soc:bus_jpeg                   devfreq11  devfreq1   0      300000000    75000000
> 14602      soc:bus_jpeg_apb               devfreq12  devfreq1   0      167000000    84000000
> 14603      soc:bus_disp1_fimd             devfreq13  devfreq1   0      200000000    120000000
> 14603      soc:bus_disp1                  devfreq14  devfreq1   0      300000000    120000000
> 14606      soc:bus_gscl_scaler            devfreq15  devfreq1   0      300000000    150000000
> 14606      soc:bus_mscl                   devfreq16  devfreq1   0      333000000    84000000
> 14608      soc:bus_wcore                  devfreq1              9      333000000    84000000
> 14783      10c20000.memory-controller     devfreq0              35     825000000    633000000
> 15873      soc:bus_wcore                  devfreq1              41     84000000     400000000
> 15873      soc:bus_noc                    devfreq2   devfreq1   0      67000000     100000000
> [snip]
> 
> 
> Depends on:
> It depends on patch[2] for preventing the merge conflic.
> [2] https://patchwork.kernel.org/patch/11320257/
> - PM / devfreq: Add missing function description and rename static functions
> 
> Chanwoo Choi (2):
>   PM / devfreq: Add debugfs support with devfreq_summary file
>   PM / devfreq: Add devfreq_transitions debugfs file
> 
>  drivers/devfreq/Kconfig            |  13 ++
>  drivers/devfreq/devfreq.c          | 206 +++++++++++++++++++++++++++++
>  drivers/devfreq/governor.h         |   3 +
>  drivers/devfreq/governor_passive.c |   2 +
>  include/linux/devfreq.h            |   1 +
>  5 files changed, 225 insertions(+)
> 

-- 
Best regards,
Kamil Konieczny
Samsung R&D Institute Poland

