Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EEB019A23B
	for <lists+linux-pm@lfdr.de>; Wed,  1 Apr 2020 01:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731259AbgCaXEp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 31 Mar 2020 19:04:45 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:35760 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731498AbgCaXEn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 31 Mar 2020 19:04:43 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200331230441epoutp01f35eaf7400d1207c3e6a8696a17fe8f5~BhgC_Ynhd0738907389epoutp01O
        for <linux-pm@vger.kernel.org>; Tue, 31 Mar 2020 23:04:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200331230441epoutp01f35eaf7400d1207c3e6a8696a17fe8f5~BhgC_Ynhd0738907389epoutp01O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1585695881;
        bh=I2qNvxYsnMhgjz7vv3e+IBnyt/mBwlreFpG3uPjXxFI=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=YT3gFZs73Ei0sXOEhJBp6XX/cV/foyR51C2DQGPnsv31QfAxS8DcL8KAfRgDwR53x
         8OrHL4KOvK7uOuQwtuvoC78qKXmcEWrLiKIrnOFBi/0b1RxFnliTi/Y7E4VLaJyoYp
         4QxPhfO8mgFo4YnmpKHpBZWR+pdGPwgsgVt4BXA0=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200331230440epcas1p2b4e761025fa9cd7b8a83a80d86c8aaba~BhgCciaUZ2205822058epcas1p2f;
        Tue, 31 Mar 2020 23:04:40 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.152]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 48sPzV49M9zMqYkb; Tue, 31 Mar
        2020 23:04:38 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        64.69.04160.68CC38E5; Wed,  1 Apr 2020 08:04:38 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20200331230437epcas1p4d802f63c12e014d47fe44715ae9c6a74~Bhf-gW0WF1803018030epcas1p48;
        Tue, 31 Mar 2020 23:04:37 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200331230437epsmtrp217a52aefc4ff1f55d78be37b6be3b948~Bhf-fIJLN0841408414epsmtrp2h;
        Tue, 31 Mar 2020 23:04:37 +0000 (GMT)
X-AuditID: b6c32a38-297ff70000001040-be-5e83cc867058
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C2.35.04158.58CC38E5; Wed,  1 Apr 2020 08:04:37 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200331230437epsmtip11fa331ae70de6ac5bb330de4cd2f37a9~Bhf-NdAXK2139221392epsmtip1J;
        Tue, 31 Mar 2020 23:04:37 +0000 (GMT)
Subject: Re: [PATCH v1 1/5] PM / devfreq: tegra: Add Dmitry as a maintainer
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <db4883d4-18b7-238a-798b-ad45aad978fc@samsung.com>
Date:   Wed, 1 Apr 2020 08:13:43 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20200330231617.17079-2-digetx@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHJsWRmVeSWpSXmKPExsWy7bCmnm7bmeY4g43diharPz5mtGiZtYjF
        4mzTG3aLjz33WC0u75rDZvG59wijReeXWWwWF0+5WtxuXMFm8e/aRhaLn7vmsThwe7y/0cru
        sXPWXXaPTas62Tx6m9+xefRtWcXo8XmTXABbVLZNRmpiSmqRQmpecn5KZl66rZJ3cLxzvKmZ
        gaGuoaWFuZJCXmJuqq2Si0+ArltmDtB5SgpliTmlQKGAxOJiJX07m6L80pJUhYz84hJbpdSC
        lJwCywK94sTc4tK8dL3k/FwrQwMDI1OgwoTsjO6lK9kLfnNV7O/fzdzA2MfZxcjBISFgIvFu
        v04XIxeHkMAORolHb9eyQjifGCVOXF3LBOF8Y5Q4u/ktWxcjJ1jHgnn3oKr2Mkosn/6VBcJ5
        zyhxZFkXM0iVsIC3xK83P8ASIgKLmSReb57LApJgFiiR2D3xCBOIzSagJbH/xQ2wsfwCihJX
        fzxmBLF5Bewk5h1aBDaIRUBF4ubLO2BxUYEwiZPbWqBqBCVOznwCNpNTwExiwoV+Joj54hK3
        nsyHsuUltr+dwwxyhITAZHaJnffvskL84CKxrWECI4QtLPHq+BZ2CFtK4vO7vVB/VkusPHmE
        DaK5g1Fiy/4LUM3GEvuXTmYCBR+zgKbE+l36EGFFiZ2/5zJCLOaTePe1hxUSwrwSHW1CECXK
        Epcf3GWCsCUlFrd3sk1gVJqF5J1ZSF6YheSFWQjLFjCyrGIUSy0ozk1PLTYsMEGO7k2M4LSr
        ZbGDcc85n0OMAhyMSjy8ClbNcUKsiWXFlbmHGCU4mJVEeNn8G+KEeFMSK6tSi/Lji0pzUosP
        MZoCQ3sis5Rocj4wJ+SVxBuaGhkbG1uYGJqZGhoqifNOvZ4TJySQnliSmp2aWpBaBNPHxMEp
        1cCoUnVwhl7YGb/TBrPfLvLy0Q0RnLU4KcLkXl6Nca/l3akqMvKdMvVHIr41HJAxf/hw5QyG
        ZSwOcco/a+bmy0b8zZh58J6XNkesh+xN9w3T1dbfOsB/6vPBL5ervrnWB8x75Pzu4aqaqOMn
        Z4uF/5R9KM5Xfuiss2dRdWez7dP3JccdPLbIfzJWYinOSDTUYi4qTgQAtLOlhNEDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBIsWRmVeSWpSXmKPExsWy7bCSnG7rmeY4gzendS1Wf3zMaNEyaxGL
        xdmmN+wWH3vusVpc3jWHzeJz7xFGi84vs9gsLp5ytbjduILN4t+1jSwWP3fNY3Hg9nh/o5Xd
        Y+esu+wem1Z1snn0Nr9j8+jbsorR4/MmuQC2KC6blNSczLLUIn27BK6M7qUr2Qt+c1Xs79/N
        3MDYx9nFyMkhIWAisWDePVYQW0hgN6PEj5OsEHFJiWkXjzJ3MXIA2cIShw8XdzFyAZW8ZZTY
        vvsBO0iNsIC3xK83P1hAEiICS5kkVtz8ApZgFiiROPHsHytEx1ZGic0f14El2AS0JPa/uMEG
        YvMLKEpc/fGYEcTmFbCTmHdoETOIzSKgInHz5R2wuKhAmMTOJY+ZIGoEJU7OfMICYnMKmElM
        uNDPBLFMXeLPvEvMELa4xK0n86Hi8hLb385hnsAoPAtJ+ywkLbOQtMxC0rKAkWUVo2RqQXFu
        em6xYYFRXmq5XnFibnFpXrpecn7uJkZw/Glp7WA8cSL+EKMAB6MSD6+iVXOcEGtiWXFl7iFG
        CQ5mJRFeNv+GOCHelMTKqtSi/Pii0pzU4kOM0hwsSuK88vnHIoUE0hNLUrNTUwtSi2CyTByc
        Ug2Msyqmn/zotOZDnty80/z71T7UfF1UFuXFpZnCN9n95k0129eNzJeevWvRmujwbMH3/H3i
        pd/068yF3hyx6Fh+7FT/vyTzY+cO5YrtTPBde2r17e1vFzN/vnnt8vyzch0em3ewecfcVJPP
        9lih+W1zpd5aS/fQ03eOuKqEfTX78ruALfmiT5zuGiWW4oxEQy3mouJEAB/GwL27AgAA
X-CMS-MailID: 20200331230437epcas1p4d802f63c12e014d47fe44715ae9c6a74
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200330232036epcas1p2cba89238a41fa0941d0abcaf2b457072
References: <20200330231617.17079-1-digetx@gmail.com>
        <CGME20200330232036epcas1p2cba89238a41fa0941d0abcaf2b457072@epcas1p2.samsung.com>
        <20200330231617.17079-2-digetx@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 3/31/20 8:16 AM, Dmitry Osipenko wrote:
> I was contributing to the NVIDIA Tegra20+ devfreq drivers recently and
> want to help keep them working and evolving in the future.
> 
> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  MAINTAINERS | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8b8abe756ae0..9e8b0779f6df 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10931,6 +10931,15 @@ F:	include/linux/memblock.h
>  F:	mm/memblock.c
>  F:	Documentation/core-api/boot-time-mm.rst
>  
> +MEMORY FREQUENCY SCALING DRIVERS FOR NVIDIA TEGRA
> +M:	Dmitry Osipenko <digetx@gmail.com>
> +L:	linux-pm@vger.kernel.org
> +L:	linux-tegra@vger.kernel.org
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mzx/devfreq.git

Need to update it as following:
git git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git

> +S:	Maintained
> +F:	drivers/devfreq/tegra20-devfreq.c
> +F:	drivers/devfreq/tegra30-devfreq.c
> +
>  MEMORY MANAGEMENT
>  M:	Andrew Morton <akpm@linux-foundation.org>
>  L:	linux-mm@kvack.org
> 

I already agreed it. To prevent the merge conflict of MAINTAINERS,
better to be merged it to linux-pm.git maintainer. On next time,
please add Rafael J. Wysocki to To list.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
