Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5343C29856C
	for <lists+linux-pm@lfdr.de>; Mon, 26 Oct 2020 02:48:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1421229AbgJZBsn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 25 Oct 2020 21:48:43 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:22772 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1418915AbgJZBsk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 25 Oct 2020 21:48:40 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20201026014836epoutp028fed40db6f45acb303396482311211cc~BZ6i3zlps2969729697epoutp02B
        for <linux-pm@vger.kernel.org>; Mon, 26 Oct 2020 01:48:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20201026014836epoutp028fed40db6f45acb303396482311211cc~BZ6i3zlps2969729697epoutp02B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1603676916;
        bh=37PnDkF5xPnXJofZfiHzZMGGvdWBOs4q7GwZvJLA/sg=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Fj1f4Df/+DDZdNhwcSPmU4OOpPjj1cYA5McPqrv1pd8x6UncCLed6ASIqRAapnNP0
         Wb9OMdUp8pLJYneQ+cBl05ZrLS9fU/gKLVpz84HvReUvgc6XafBLJTuxrGwEUSUaYM
         ni4EShWMqr1KDgaeWGz+X3Pr1MgykB0WoGXhiDJA=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20201026014836epcas1p38144d3db17e8f9b63f6dab1f72e20c2a~BZ6iZWjPx3049830498epcas1p3m;
        Mon, 26 Oct 2020 01:48:36 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.158]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4CKHmf4wVczMqYm9; Mon, 26 Oct
        2020 01:48:34 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        7C.94.09582.2FA269F5; Mon, 26 Oct 2020 10:48:34 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20201026014834epcas1p29d483b8c2aa3d7d7f3a62f0937d3b825~BZ6ghavLZ0717507175epcas1p2f;
        Mon, 26 Oct 2020 01:48:34 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20201026014834epsmtrp22db458c732a0742ee7eded9e318128a6~BZ6ggpvpy3006630066epsmtrp2d;
        Mon, 26 Oct 2020 01:48:34 +0000 (GMT)
X-AuditID: b6c32a37-8afff7000000256e-ae-5f962af2c391
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        DB.6C.08604.2FA269F5; Mon, 26 Oct 2020 10:48:34 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20201026014833epsmtip20007a16e5de1e388492d733fec49ab01~BZ6gQJKa-1996219962epsmtip2h;
        Mon, 26 Oct 2020 01:48:33 +0000 (GMT)
Subject: Re: [PATCH v5 2/2] PM / devfreq: Add governor attribute flag for
 specifc sysfs nodes
To:     Dmitry Osipenko <digetx@gmail.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Cc:     lukasz.luba@arm.com, enric.balletbo@collabora.com,
        hl@rock-chips.com, thierry.reding@gmail.com, jonathanh@nvidia.com,
        abel.vesa@nxp.com, k.konieczny@samsung.com,
        b.zolnierkie@samsung.com, chanwoo@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <8bd3c09d-a55d-318c-afc6-88a2215110e1@samsung.com>
Date:   Mon, 26 Oct 2020 11:02:23 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <53199cd1-772c-f30e-4f74-93572d6875cb@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02TfUxbVRjGc3ovl3YRuRQYZzCB3TmWwYBeSunFUdSMYMNAMURF/rBe6ZUS
        Slt7QRzTBDayURzbmrmCtVI2ZK5Q5VNSCrOmQydGEwHBzQ2pDpUwLBsf23RibHu3yH+/vO/z
        nuc854OPCCewaH65porRa2g1gW1Bhy7tSU1eSTQpRE7bLur85JeA6mvtCaKMV35Aqe7bNwBl
        v+YG1L3ebxCqwXwOpdpXWoOo7w4vBVNTTgtGrTaPAcqwZsaos4cbgqlr9Rcw6i9nG/pUqNze
        Zgdyx+xHQD5sng2W93cZMHnzES8m7/M6ePINswuVnxjsAvLV/thCQUlFloqhlYw+ntGUapXl
        mjIZcaBIsV8hyRCRyWQmJSXiNXQlIyNy8guTc8vVvghE/Ju0utpXKqRZlkjNztJrq6uYeJWW
        rZIRjE6p1mXqUli6kq3WlKWUaiufIEWiNIlP+GqF6sfh48G6q+hbd0ZtoA5cR5qAgA/xdOg2
        H+M1gS18Ie4AcMnhwvwNIb4CYMNkAcd3AHzXoH448OnvAwg3cBHAm78sBHGiZQDPXT7k53Bc
        Ae0Dl1A/R+DvwLEJD+YfQPBmHjSNdvL8DQxPhK6FKwG3UHwHnL53A/g5BM+Gfabzge2h+C44
        +5sloI/EX4TjQw0PNGFw/P35gIEAl0Gj9XSAETwK/jRv5XEcB4989sGDmGt82GrRNgG+j3Pg
        TEsYVw6Hi5cHgzmOhqveixjHh6BtfCywZ4g3Ajjo+j6Ia4ihq/M0z78Ogu+BPc5UrrwDDt//
        EHC2j0Lv+vEgzioENh4VcpKdcMozy+N4G+w4ZsBOAcK8KYx5UwDzpgDm/83aAdoFtjI6trKM
        YUmdePNV94PA206UOoDpz1spbsDjAzeAfISICLFsP6MQhijpg7WMXqvQV6sZ1g0kvuM1ItGR
        pVrf59BUKUhJmlgsptLJDAlJElEh/yQ1KoR4GV3FVDCMjtE/nOPxBdF1vKN/6OYRd7rh74PP
        hHkslqGn52oX6x7rHlXpBJ6MHlOESHz/donaa3jOSF+NLL15duZk9Ccxqn/ze4tK2mua897L
        Tv96rn4gX/W64YuGvutJd8PQnesn9N7tv1IeMu3ZbcWLxpFTwy/HJNTaOpbpC2/DKU1NUpa1
        O7wtedoIBQn7p/bujk1GbXmyuI5e6dK3WNTEz9PL9tjXbJMZpDFO5Hxy8kBj3uPKhRE8/42X
        1gsK1tSdhVZpZFSPc0SUIbv1yt2afcVFz6+2mGbMIG7fxy3p2q+yqfGc3bm5Zxb3SutnqfUI
        2Fi88cjcC1YiVLIwuqHXKUFEzdbPYxL0yx42k0BZFU0mInqW/g8aauaTZAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPIsWRmVeSWpSXmKPExsWy7bCSvO4nrWnxBlPXMFssu3SU0WLjjPWs
        FhNvXGGxWP3xMaPFmtuHGC1+bDjFbNEyaxGLxYJPM1gtzja9Ybe4vGsOm8Xn3iOMFp1fZrFZ
        LGxqYbe43biCzeLnrnksDvwea+atYfTYcXcJo8fOWXfZPTat6mTz6G1+x+ax8d0OJo+/s/az
        ePRtWcXo8XmTXABnFJdNSmpOZllqkb5dAlfG9Z097AU3WSq+7VnJ2MB4h7mLkZNDQsBEYt2z
        zUA2F4eQwG5GiW+T5rNBJCQlpl08CpTgALKFJQ4fLoaoecsosXXyG7AaYYF4iTWbD7OA2CIC
        tRKvVk9nBSliFuhlkujatZcVJCEk8I5R4sXVEBCbTUBLYv+LG2DN/AKKEld/PGYEsXkF7CQ2
        TlsGdhGLgKrE3adzmEBsUYEwiZ1LHjNB1AhKnJz5BGwZp4CtxMT5k8FsZgF1iT/zLjFD2OIS
        t57MZ4Kw5SWat85mnsAoPAtJ+ywkLbOQtMxC0rKAkWUVo2RqQXFuem6xYYFhXmq5XnFibnFp
        Xrpecn7uJkZwHGtp7mDcvuqD3iFGJg7GQ4wSHMxKIrxzZKbGC/GmJFZWpRblxxeV5qQWH2KU
        5mBREue9UbgwTkggPbEkNTs1tSC1CCbLxMEp1cCUc+Cz2LZDf9aFBdxQYDPZ/+noE3m2//si
        7c1vCx2bye7yMtMrPW3VMY3zBj/dF0x+f/lJJss538VsPyOf16YuSQruvG3BY33qmdoy7o4L
        J1Z33pAwL/vXuMZwXd0cDQFD+fkPra9+fm5gtbn43g6bxyXvwvfofFyootBW//uMhfKHRfdn
        fH/VqlYaOTvFNkzb98/mLStfmwYypzDUC/L/47KvZdn8lcPuXEWK84PYTWmhtlqvftVUrJdy
        YCha/OBzi0urFNe6ki8PLNeLRpjzy1w9seloU6fwyy15x2bpfPU3C/L9NfPIHZXqxUf3Rzxf
        5u4zw1z3x8GjbaffxBxnZS93e59/6s8U7rTewyuuK7EUZyQaajEXFScCALfjQbJSAwAA
X-CMS-MailID: 20201026014834epcas1p29d483b8c2aa3d7d7f3a62f0937d3b825
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20201023101247epcas1p14b14dc1be24842daac1dc7bd229d4570
References: <20201023102632.740-1-cw00.choi@samsung.com>
        <CGME20201023101247epcas1p14b14dc1be24842daac1dc7bd229d4570@epcas1p1.samsung.com>
        <20201023102632.740-3-cw00.choi@samsung.com>
        <53199cd1-772c-f30e-4f74-93572d6875cb@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10/26/20 1:30 AM, Dmitry Osipenko wrote:
> 23.10.2020 13:26, Chanwoo Choi пишет:
>> @@ -909,6 +915,8 @@ struct devfreq *devfreq_add_device(struct device *dev,
>>  		goto err_init;
>>  	}
>>  
>> +	create_sysfs_files(devfreq, governor);
>> +
>>  	devfreq->governor = governor;
>>  	err = devfreq->governor->event_handler(devfreq, DEVFREQ_GOV_START,
>>  						NULL);
> 
> Shouldn't sysfs be created *after* GOV_START? This is inconsistent with
> governor_store().
> 
> 

Good point. Thanks for the review. I'll edit it.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
