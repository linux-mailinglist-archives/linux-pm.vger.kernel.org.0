Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB1321D594
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jul 2020 14:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729593AbgGMMPD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Jul 2020 08:15:03 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:60652 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729027AbgGMMPD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Jul 2020 08:15:03 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200713121459epoutp010857449f9db813b53aff88c0de65bbf7~hTueS20P42685226852epoutp01n
        for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2020 12:14:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200713121459epoutp010857449f9db813b53aff88c0de65bbf7~hTueS20P42685226852epoutp01n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1594642499;
        bh=Cx5LldlF77o0QgRdx0TTuNxGcM5bUySUzgMVo27aDMU=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=ZpKSu9YnPKwXwAp91WpUhGejaPPNDji1N5zNCeECp6/Ivwp3KajcpsTWtwokaPKzk
         eDpQwRTYuk27SC1A9W0pJnnZv3J+x4BwYWUw1p77hk224Xm7CIdtFGQA2wkL0Peu4n
         qWyKu+TZjv9yFhIeixgThfNcP7dccp+t37xaYpxk=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20200713121458epcas1p37b46f2a2db50ebe474931aea779a6b72~hTuc45Yjr0307703077epcas1p3g;
        Mon, 13 Jul 2020 12:14:58 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.158]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4B52dq6g2lzMqYkb; Mon, 13 Jul
        2020 12:14:55 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        B1.97.28578.F305C0F5; Mon, 13 Jul 2020 21:14:55 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20200713121454epcas1p3d472f83056de098afeeac42e0c5ad08f~hTuZqaGxf0057600576epcas1p3U;
        Mon, 13 Jul 2020 12:14:54 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200713121454epsmtrp223df2696529a839c5674368ee1d38eed~hTuZpmSJt1769817698epsmtrp2M;
        Mon, 13 Jul 2020 12:14:54 +0000 (GMT)
X-AuditID: b6c32a39-8c9ff70000006fa2-16-5f0c503fa8b0
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        65.11.08382.E305C0F5; Mon, 13 Jul 2020 21:14:54 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200713121454epsmtip2fd722762b6911c3bcd485e6c73721002~hTuZciesl2603426034epsmtip2Z;
        Mon, 13 Jul 2020 12:14:54 +0000 (GMT)
Subject: Re: [PATCH v2 2/2] PM / devfreq: Add governor flags to clarify the
 features
To:     Dmitry Osipenko <digetx@gmail.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     leonard.crestez@nxp.com, lukasz.luba@arm.com,
        enric.balletbo@collabora.com, hl@rock-chips.com,
        thierry.reding@gmail.com, jonathanh@nvidia.com, abel.vesa@nxp.com,
        chanwoo@kernel.org, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <69ae2524-22d0-2444-da13-fae199392029@samsung.com>
Date:   Mon, 13 Jul 2020 21:26:25 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <746837bc-6734-3e52-453f-2b59bbca0230@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPJsWRmVeSWpSXmKPExsWy7bCmnq59AE+8QeM5U4tll44yWky8cYXF
        YvXHx4wWa24fYrT4seEUs0XLrEUsFmeb3rBbrLj7kdXi8q45bBafe48wWnR+mcVmsbCphd3i
        duMKNoufu+axOPB5rJm3htFjx90ljB47Z91l99i0qpPNo7f5HZvHxnc7mDz+ztrP4tG3ZRWj
        x+dNcgGcUdk2GamJKalFCql5yfkpmXnptkrewfHO8aZmBoa6hpYW5koKeYm5qbZKLj4Bum6Z
        OUDXKymUJeaUAoUCEouLlfTtbIryS0tSFTLyi0tslVILUnIKLAv0ihNzi0vz0vWS83OtDA0M
        jEyBChOyMy4+38le8ECp4sf3TYwNjLMkuxg5OSQETCS+r7/DBGILCexglHiwIK+LkQvI/sQo
        cWX1bWYI5xujxNT2PawwHS/6/kF17GWUmL5PDaLoPVD3k9NgRcICYRKPmq6yg9giAgkSR/6A
        NHBxMAtsYpLYPucaM0iCTUBLYv+LG2wgNr+AosTVH48ZQWxeATuJvVsawAaxCKhK3O95BFYv
        CjT05LYWqBpBiZMzn7CA2JwCthKrf1wEq2EWEJe49WQ+E4QtL9G8dTbYCxICbzgkJq1tYoF4
        wUWi4/U2RghbWOLV8S3sELaUxOd3e9kg7GqJlSePsEE0dzBKbNl/Aep/Y4n9SycDbeAA2qAp
        sX6XPkRYUWLn77mMEIv5JN597WEFKZEQ4JXoaBOCKFGWuPzgLhOELSmxuL2TbQKj0iwk78xC
        8sIsJC/MQli2gJFlFaNYakFxbnpqsWGBKXJsb2IEp2wtyx2M099+0DvEyMTBeIhRgoNZSYQ3
        WpQzXog3JbGyKrUoP76oNCe1+BCjKTCAJzJLiSbnA7NGXkm8oamRsbGxhYmhmamhoZI477+z
        7PFCAumJJanZqakFqUUwfUwcnFINTALBK8uNPP3uHV8vqt9/q+X1lBbnmDs9nJ6C/L89vzP/
        eha3/5Ps9ybWo/VexWc/7FZLnpfzcfLSc2y+EiV/jNee9Oy5w6uy8U2nn/utpCrBcxLN+9a6
        vJpwf6nqsg5rDa+mJ+zuCwKrDwZM7vjf0CH8czv7xV3fcrdlS6aJ6qfUztQtmxez+VRw5xSJ
        Gosf/tcfvm7dtj07L/Npwvojj1fwPI06n3u6rnZVSZjcS/0rZyZb/zHNec2uWW5uf+blmVd5
        Ky/7xvzZ7Xu74OUNlXmnJI5xxekvWzTroppxlsg2LuZC0UP+zQJXdKOlulYLTFnu3H9ScMeZ
        ZezXJmXqaNa48FhMsX377uPOy0WvliqxFGckGmoxFxUnAgDJth1mYgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Ra0hTcRiH+Z9z3M6Gq+PW3F+NpqNRjfJSSodSCbqdpMIoIpLS4Y7Tcpvt
        qN2I5qXQldJV7ViaplFLMIeZ08qYWSiITV2si2hqGZiiGDqv1VyB3x74PQ/vhxdHhY2YL56k
        TaX1WmWyjMPH6ppl0g2R0Z6xwXc7peTDzhZAXnd0Y+ST8QFAVn22AtL5tA0ls9lyjGzP/Mkl
        H/WMe5BdDXc55ETeG0Dm/mI5ZFlmNpf8nPGIQ043lGDbllFVJVWAqu+pAJSF7eFSZlMuh8rL
        GuVQNaP1CDXPNmFUfq0JUBPmVdG8o/xwFZ2clE7rgyLj+Im2IQs3pU92xjllBgbA+hgBD4dE
        KPyRv4AYAR8XEo0Afut4gLgHH1hga0GNAP/LItjczLidEQDz7Y0clyMiDsP+TDvXxSuIODj/
        exy4JJQwI3C4shx1F2MAVlU893BZHEIBm344FuvlRAC0OweAiwVEJHxZa1h0MEIOe6/2oy4W
        /71gqRhA3I4XbL0ziLmYR0TAJ07booMSa+BcSec/lsBPg6WIm6Uw61kxeg2I2CU5uyRhlyTs
        kuQ+wEzAh05hNGoNE5ISoqVPBzJKDZOmVQfG6zRmsPhfxbp68Nw0FmgFCA6sAOKobIUgRsyL
        FQpUyrPnaL0uVp+WTDNW4IdjMonAcarsuJBQK1PpkzSdQuv/rwjO8zUg/rwXN5mvt1Ydap71
        6fBPU9i6vMPjVWucZYl1O4Smy5a3xCa+wHZsh0hYXbfLVC/Jm/Pdx/YUDfEhWcw7od/e9kze
        Wx02PXzIwX8Q160L6B7cfbvI7lsW7sipTF84ofHaXOdZmnRwy41SCsv2Tlj7YThUnmpskEy9
        9gweylmpLT8iNn0RMda9NbG24K32j0pLtXpC1Rfw/VXATNdsFHZAN9mXaJBXnlQkeUs95jPi
        92u/i28Y+gPpxyPiW6lif7+a6vObCo0bJy7du6ib27NesjHGSzUTpopiKFVo3M5J7F205kvh
        e95ORbuhddpmu5BwPGKZvMAkVRN+V4JWyzAmURmiQPWM8g8l5WK/TgMAAA==
X-CMS-MailID: 20200713121454epcas1p3d472f83056de098afeeac42e0c5ad08f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200713081944epcas1p22871b6d8a9455226e6cccd08ac0baa73
References: <20200713083113.5595-1-cw00.choi@samsung.com>
        <CGME20200713081944epcas1p22871b6d8a9455226e6cccd08ac0baa73@epcas1p2.samsung.com>
        <20200713083113.5595-3-cw00.choi@samsung.com>
        <746837bc-6734-3e52-453f-2b59bbca0230@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 7/13/20 7:37 PM, Dmitry Osipenko wrote:
> 13.07.2020 11:31, Chanwoo Choi пишет:
>> DEVFREQ supports the default governors like performance, powersave and also
>> allows the devfreq driver to add their own governor like tegra30-devfreq.c
>> according to their requirement. In result, some sysfs attributes are
>> useful or not useful. Prior to that the user can access all sysfs attributes
>> regardless of availability.
>>
>> So, clarify the access permission of sysfs attributes according to governor.
>> When adding the devfreq governor, can specify the available attribute
>> information by using DEVFREQ_GOV_ATTR_* constant variable. The user can
>> read or write the sysfs attributes in accordance to the specified attributes.
>>
>> /* Devfreq governor flags for attributes and features */
>> [Definition for sysfs attributes]
>> - DEVFREQ_GOV_ATTR_GOVERNOR
>> - DEVFREQ_GOV_ATTR_AVAIL_GOVERNORS
>> - DEVFREQ_GOV_ATTR_AVAIL_FREQUENCIES
>> - DEVFREQ_GOV_ATTR_CUR_FREQ
>> - DEVFREQ_GOV_ATTR_TARGET_FREQ
>> - DEVFREQ_GOV_ATTR_MIN_FREQ
>> - DEVFREQ_GOV_ATTR_MAX_FREQ
>> - DEVFREQ_GOV_ATTR_TRANS_STAT
>> - DEVFREQ_GOV_ATTR_POLLING_INTERVAL
>> - DEVFREQ_GOV_ATTR_TIMER
>>
>> Also, the devfreq governor is able to have the specific flag as follows
>> in order to implement the specific feature. For example, Devfreq allows
>> user to change the governors on runtime via sysfs interface.
>> But, if devfreq device uses 'passive' governor, don't allow user to change
>> the governor. For this case, define the DEVFREQ_GOV_FLAT_IMMUTABLE
>> and set it to flag of passive governor.
>>
>> [Definition for governor flag]
>> - DEVFREQ_GOV_FLAG_IMMUTABLE
>> : If immutable flag is set, governor is never changeable to other governors.
>> - DEVFREQ_GOV_FLAG_IRQ_DRIVEN
>> : Devfreq core won't schedule polling work for this governor if value is set.
>>
>> [Table of governor flag for devfreq governors]
>> ------------------------------------------------------------------------------
>>                       | simple    | perfor | power | user | passive | tegra30
>> 		      | ondemand  | mance  | save  | space|         |
>> ------------------------------------------------------------------------------
>> governor              | O         | O      | O     | O    | O       | O
>> available_governors   | O         | O      | O     | O    | O       | O
>> available_frequencies | O         | O      | O     | O    | O       | O
>> cur_freq              | O         | O      | O     | O    | O       | O
>> target_freq           | O         | O      | O     | O    | O       | O
>> min_freq              | O         | O      | O     | O    | O       | O
>> max_freq              | O         | O      | O     | O    | O       | O
>> trans_stat            | O         | O      | O     | O    | O       | O
>>                       --------------------------------------------------------
>> polling_interval      | O         | X      | X     | X    | X       | O
>> timer                 | O         | X      | X     | X    | X       | X
>> ------------------------------------------------------------------------------
>> immutable             | X         | X      | X     | X    | O       | O
>> interrupt_driven      | X(polling)| X      | X     | X    | X       | O (irq)
>> ------------------------------------------------------------------------------
>>
>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>> ---
> 
> Hello, Chanwoo! I tested this series on NVIDIA Tegra30 and everything
> working fine!
> 
> Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
> Tested-by: Dmitry Osipenko <digetx@gmail.com>
> 
> 
> BTW, I'm curious what do you think about hiding the unsupported debugfs

Do you mean that sysfs?

> attributes per-device instead of returning the -EACCES?

I considered the hiding of sysfs node too instead of -EACCES.


But,
For a long time, devfreq showed the sysfs interface of all devfreq devices
regardless of the kind of devfreq governor. It means that devfreq keeps
the ABI interface. If devfreq hides the unsupported sysfs node
according to the type of governor, it will break the ABI.

Although I knew that maybe performance/powersave/userspace didn't use
the 'polling_interval' node, I just returned -EACCESS.

Thanks for suggesting your opinion. We can discuss it more.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
