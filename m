Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 032002681FB
	for <lists+linux-pm@lfdr.de>; Mon, 14 Sep 2020 02:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725963AbgINADS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 13 Sep 2020 20:03:18 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:29816 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbgINADQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 13 Sep 2020 20:03:16 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200914000312epoutp041d0e39f1aad51efa2764cf68c2b8615a~0fYhoKVC63147331473epoutp048
        for <linux-pm@vger.kernel.org>; Mon, 14 Sep 2020 00:03:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200914000312epoutp041d0e39f1aad51efa2764cf68c2b8615a~0fYhoKVC63147331473epoutp048
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1600041792;
        bh=zD3gLmTYhnddHFCsa6cntVi8nNSLykR1usqvZQp7WT4=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=GTH0kISh5tNImTuIi0ev2fgwM3JBJ930Ud4Ec6uBCJk0JriB1Xd3VG3TVhyAMWhtW
         vQdSS84lzjsOmv6henCE/Ru/4oBadYK5LQPmDbfA3eiZgO5aKfoYjllaRA3hubo4ct
         Rkn1nK3E+WTbmzb/Y+caDpOz5ZZzTM7Th6T6YpBc=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20200914000311epcas1p43fc273c362e0cb8d2ba842ed6c90fceb~0fYhH53Qa0935009350epcas1p4W;
        Mon, 14 Sep 2020 00:03:11 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.154]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4BqRQP5MdczMqYkh; Mon, 14 Sep
        2020 00:03:09 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        A8.A5.18978.B33BE5F5; Mon, 14 Sep 2020 09:03:07 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20200914000306epcas1p424ad2c28e76185e55b8db51d7f987027~0fYcM7Oym0935409354epcas1p4n;
        Mon, 14 Sep 2020 00:03:06 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200914000306epsmtrp19b22c3cae49db1ab8432c8adc6837908~0fYcMDcGk0656106561epsmtrp1m;
        Mon, 14 Sep 2020 00:03:06 +0000 (GMT)
X-AuditID: b6c32a35-b8298a8000004a22-8d-5f5eb33b8dc7
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        14.4E.08303.A33BE5F5; Mon, 14 Sep 2020 09:03:06 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200914000306epsmtip1ee2f606f3184bc53cccecb14dfa8fe3e~0fYb-A76V2589225892epsmtip1Q;
        Mon, 14 Sep 2020 00:03:06 +0000 (GMT)
Subject: Re: [PATCH] PM / devfreq: Add timer type to devfreq_summary debugfs
To:     myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        lukasz.luba@arm.com, b.zolnierkie@samsung.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <a992b7cb-ef57-f4d9-b53b-9195d1073d2a@samsung.com>
Date:   Mon, 14 Sep 2020 09:15:18 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20200908110853.19277-1-cw00.choi@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupik+LIzCtJLcpLzFFi42LZdlhTX9d6c1y8wbJHqhYbZ6xntTjb9Ibd
        4vKuOWwWn3uPMFosbGpht7jduILNgc1jzbw1jB59W1YxenzeJBfAHJVtk5GamJJapJCal5yf
        kpmXbqvkHRzvHG9qZmCoa2hpYa6kkJeYm2qr5OIToOuWmQO0V0mhLDGnFCgUkFhcrKRvZ1OU
        X1qSqpCRX1xiq5RakJJTYFmgV5yYW1yal66XnJ9rZWhgYGQKVJiQnbHy7Ha2gjcaFZtn32Jr
        YFwo1cXIySEhYCJxZflFli5GLg4hgR2MEt+WHGWFcD4xSnz9uAYq85lRYmXzKUaYlnUTnkEl
        djFKdPe1s0E47xklLp9vZwWpEhbwkfj35iYTiC0ikCGx9NoxMJtZwEri9cdudhCbTUBLYv+L
        G2wgNr+AosTVH4/BNvAK2Ems3PocrJ5FQFVi9+WnYPWiAmESJ7e1QNUISpyc+YQFxOYUsJbY
        1tLIAjFfXOLWk/lQu+Qltr+dwwxynIRAK4fE8r/nWSBecJH49mQTO4QtLPHq+BYoW0riZX8b
        lF0tsfLkETaI5g5GiS37L7BCJIwl9i+dDLSBA2iDpsT6XfoQYUWJnb/nMkIs5pN497WHFaRE
        QoBXoqNNCKJEWeLyg7tMELakxOL2TrYJjEqzkLwzC8kLs5C8MAth2QJGllWMYqkFxbnpqcWG
        BYbI0b2JEZwotUx3ME58+0HvECMTB+MhRgkOZiURXteU2Hgh3pTEyqrUovz4otKc1OJDjKbA
        AJ7ILCWanA9M1Xkl8YamRsbGxhYmhmamhoZK4rwPbynECwmkJ5akZqemFqQWwfQxcXBKNTBp
        6Ulych8wtpxrMN90+vGr2yQWFV7Y13bnZvDHJDuZJSaKh9naLdLYA/gs/KX4vK2mbXMtvMHM
        plblkmwbadHk/fxzWXJPeKH47FLZH38MvIMEq3+5RnOyfn6uc9fkSM7ss6v6itvN/m42mF5z
        W/TUHqaJMn2RB7kv7L2guPfxvDmfu29bZFXscpda+/fWxDnr+jQv35lu1mNdE7/0gGz4/PqS
        LvFuFe3klYJHHMuqzC5vFNV9eed1u4+rw14GM1v7y6fvv5rS9lfx9Y/+NiVnVfEpJmJma8/0
        OE0q/qAbNl1w/6FnT2rmVVvekGh0M3xj3j9lae3hmmlXHE8XlyzdsaXk2PdpvEefffNb5K3E
        UpyRaKjFXFScCAAcbb3hHQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCLMWRmVeSWpSXmKPExsWy7bCSnK7V5rh4g7sz5S02zljPanG26Q27
        xeVdc9gsPvceYbRY2NTCbnG7cQWbA5vHmnlrGD36tqxi9Pi8SS6AOYrLJiU1J7MstUjfLoEr
        Y+XZ7WwFbzQqNs++xdbAuFCqi5GTQ0LARGLdhGcsXYxcHEICOxgltu3/xAyRkJSYdvEokM0B
        ZAtLHD5cDFHzllHi/c1d7CA1wgI+Ev/e3GQCsUUEMiS+d/5iA7GZBawkXn/sZodo6GOUeP3j
        HlgDm4CWxP4XN8CK+AUUJa7+eMwIYvMK2Ems3PocbBCLgKrE7stPwepFBcIkdi55zARRIyhx
        cuYTFhCbU8BaYltLIwvEMnWJP/MuMUPY4hK3nsxngrDlJba/ncM8gVF4FpL2WUhaZiFpmYWk
        ZQEjyypGydSC4tz03GLDAqO81HK94sTc4tK8dL3k/NxNjOCI0dLawbhn1Qe9Q4xMHIyHGCU4
        mJVEeF1TYuOFeFMSK6tSi/Lji0pzUosPMUpzsCiJ836dtTBOSCA9sSQ1OzW1ILUIJsvEwSnV
        wOSvstp8lmVqiNLswqwipatS/Q1l4c9Y/6dcOvRL4njGpTk8r5QOSIUs06q4pvb/8bszC1Pk
        Zn8RnHCjwdCzODjIs37ylyX390187fkyz5QpfVp+3EK5XubPi14+MFkjHmhQe2VLTFaihkPy
        r0kzD1n3fX5xwP/b9qtTkhr9jNlsJlz6E/zL+NklkyXv9FtyNxv26Af/LsvbffHkJEN3/9VS
        MvMvH1r80/gcV+vfShvvj3pLOw6861IyWXno0qt3YtHyGzrm7bXynuXIJ8+xacUl2aO+QvKS
        T5aLWe/+cTFQf/dymbe1rMI7+PZVPbuxXFqRifF7HG9tqtX92X+XTeh1t+y/H3DoUfnsyjCf
        rl1KLMUZiYZazEXFiQD0zW3uBwMAAA==
X-CMS-MailID: 20200914000306epcas1p424ad2c28e76185e55b8db51d7f987027
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200908105636epcas1p20ca5e07616e942c3b2a47fc5716c14ed
References: <CGME20200908105636epcas1p20ca5e07616e942c3b2a47fc5716c14ed@epcas1p2.samsung.com>
        <20200908110853.19277-1-cw00.choi@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 9/8/20 8:08 PM, Chanwoo Choi wrote:
> The commit 4dc3bab8687f ("PM / devfreq: Add support delayed timer for
> polling mode") supports the delayed timer but this commit missed
> the adding the timer type to devfreq_summary debugfs node.
> Add the timer type to devfreq_summary debugfs.
> 
> Fixes: 4dc3bab8687f ("PM / devfreq: Add support delayed timer for polling mode")
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
>  drivers/devfreq/devfreq.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> Example after adding 'timer' information to debugfs_summary debugfs node
> on Odroid-XU3 board as following:
> root@localhost:~# cat /sys/kernel/debug/devfreq/devfreq_summary
> dev                            parent_dev                     governor        timer      polling_ms  cur_freq_Hz  min_freq_Hz  max_freq_Hz
> ------------------------------ ------------------------------ --------------- ---------- ---------- ------------ ------------ ------------
> 10c20000.memory-controller     null                           simple_ondemand delayed           100    825000000    165000000    825000000
> 11800000.gpu                   null                           simple_ondemand deferrable         50    420000000    177000000    600000000
> soc:bus_wcore                  null                           simple_ondemand deferrable         50    532000000     88700000    532000000
> soc:bus_noc                    soc:bus_wcore                  passive         null                0    111000000     66600000    111000000
> soc:bus_fsys_apb               soc:bus_wcore                  passive         null                0    222000000    111000000    222000000
> soc:bus_fsys2                  soc:bus_wcore                  passive         null                0    200000000     75000000    200000000
> soc:bus_mfc                    soc:bus_wcore                  passive         null                0    333000000     83250000    333000000
> soc:bus_gen                    soc:bus_wcore                  passive         null                0    266000000     88700000    266000000
> soc:bus_peri                   soc:bus_wcore                  passive         null                0     66600000     66600000     66600000
> soc:bus_g2d                    soc:bus_wcore                  passive         null                0    333000000     83250000    333000000
> soc:bus_g2d_acp                soc:bus_wcore                  passive         null                0    266000000     66500000    266000000
> soc:bus_jpeg                   soc:bus_wcore                  passive         null                0    300000000     75000000    300000000
> soc:bus_jpeg_apb               soc:bus_wcore                  passive         null                0    166500000     83250000    166500000
> soc:bus_disp1_fimd             soc:bus_wcore                  passive         null                0    200000000    120000000    200000000
> soc:bus_disp1                  soc:bus_wcore                  passive         null                0    300000000    120000000    300000000
> soc:bus_gscl_scaler            soc:bus_wcore                  passive         null                0    300000000    150000000    300000000
> soc:bus_mscl                   soc:bus_wcore                  passive         null                0    666000000     84000000    666000000
>  
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index b9b27fb3291e..d4424b5d8306 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -1790,20 +1790,23 @@ static int devfreq_summary_show(struct seq_file *s, void *data)
>  	struct devfreq *p_devfreq = NULL;
>  	unsigned long cur_freq, min_freq, max_freq;
>  	unsigned int polling_ms;
> +	unsigned int timer;
>  
> -	seq_printf(s, "%-30s %-30s %-15s %10s %12s %12s %12s\n",
> +	seq_printf(s, "%-30s %-30s %-15s %-10s %10s %12s %12s %12s\n",
>  			"dev",
>  			"parent_dev",
>  			"governor",
> +			"timer",
>  			"polling_ms",
>  			"cur_freq_Hz",
>  			"min_freq_Hz",
>  			"max_freq_Hz");
> -	seq_printf(s, "%30s %30s %15s %10s %12s %12s %12s\n",
> +	seq_printf(s, "%30s %30s %15s %10s %10s %12s %12s %12s\n",
>  			"------------------------------",
>  			"------------------------------",
>  			"---------------",
>  			"----------",
> +			"----------",
>  			"------------",
>  			"------------",
>  			"------------");
> @@ -1827,13 +1830,15 @@ static int devfreq_summary_show(struct seq_file *s, void *data)
>  		cur_freq = devfreq->previous_freq;
>  		get_freq_range(devfreq, &min_freq, &max_freq);
>  		polling_ms = devfreq->profile->polling_ms;
> +		timer = devfreq->profile->timer;
>  		mutex_unlock(&devfreq->lock);
>  
>  		seq_printf(s,
> -			"%-30s %-30s %-15s %10d %12ld %12ld %12ld\n",
> +			"%-30s %-30s %-15s %-10s %10d %12ld %12ld %12ld\n",
>  			dev_name(&devfreq->dev),
>  			p_devfreq ? dev_name(&p_devfreq->dev) : "null",
>  			devfreq->governor_name,
> +			polling_ms ? timer_name[timer] : "null",
>  			polling_ms,
>  			cur_freq,
>  			min_freq,
>

Applied it.


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
