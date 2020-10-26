Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80BEB29856D
	for <lists+linux-pm@lfdr.de>; Mon, 26 Oct 2020 02:49:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1421234AbgJZBth (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 25 Oct 2020 21:49:37 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:23420 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1421233AbgJZBth (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 25 Oct 2020 21:49:37 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20201026014935epoutp0280710a30be5f4f1f6e6d0b8f23c82efa~BZ7Zfycj93048030480epoutp02E
        for <linux-pm@vger.kernel.org>; Mon, 26 Oct 2020 01:49:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20201026014935epoutp0280710a30be5f4f1f6e6d0b8f23c82efa~BZ7Zfycj93048030480epoutp02E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1603676975;
        bh=yzYHjnr3Zv5CrXB65QqR6xbr5PrU7I2vuwfmfUJSeI0=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=J7ADu9Y2hJIi6fP34NGD0TXGc8q9nIW6xktEUoS/oP1VQuDD9/hj7WbvS5PAwkcOQ
         EmX2Oyx1VkV2CMKcAZcuFiF8C9aFFV7SB8yCpubM++TLp4QfppKfPDFBl1Kc4Tptid
         r988iPVrrNzx/jwkOV7Gitr7H2XqMqqNob6aVUZo=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20201026014934epcas1p405eb8b9fdbcb815b5febe37347fab44b~BZ7Y-NL9k2822928229epcas1p4E;
        Mon, 26 Oct 2020 01:49:34 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.156]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4CKHnm34RhzMqYkd; Mon, 26 Oct
        2020 01:49:32 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        8A.61.10463.C2B269F5; Mon, 26 Oct 2020 10:49:32 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20201026014931epcas1p252b32cf13270bfcd4af756cc80a37be8~BZ7WK12ol2744827448epcas1p2P;
        Mon, 26 Oct 2020 01:49:31 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20201026014931epsmtrp2ab5f1a77c894de0e3fb13efa6d814bfc~BZ7WKF6lr3063230632epsmtrp2J;
        Mon, 26 Oct 2020 01:49:31 +0000 (GMT)
X-AuditID: b6c32a38-efbff700000028df-c4-5f962b2cb7f8
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        AB.8C.08604.B2B269F5; Mon, 26 Oct 2020 10:49:31 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20201026014931epsmtip194309b2dd7a25a8bf6e6c3996e5be5ab~BZ7V0KADe1579815798epsmtip1D;
        Mon, 26 Oct 2020 01:49:31 +0000 (GMT)
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
Message-ID: <213075d9-89ca-21c2-fbd4-2060200f22d0@samsung.com>
Date:   Mon, 26 Oct 2020 11:03:20 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <9a2c99d1-ef65-4d89-3740-90a3b60d4cd5@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02TfUwTZxzH8/SO4yBUbwjjGSMTDiWCFim08DCEbBO0iZpgzJbFzNVbeyuE
        0l7asg0Z4XUTlDoJSrAgMuRt0I13ht0ICZQ4NpoxmVsnYVNBRcYqb4JvLGt7mvHfJ7/7/O6b
        7/PckZjvNSKQTNcYWJ2GUdOEN943HB4p2rWzUh5VNe+Dmq6NANRZ1e6Byu2/4qhtcRog8+QQ
        QI86fsRQsakeR3VLVR7IVjjviSYsNQRaNloBKl0xEejLwmJPNFnQQqDHllr8jc0yc60ZyPqn
        GoDsimnKU9bVWkrIjEUOQtbp6BfI1k2DuOxMTyuQLXe9lup1NGNPGssoWV0wq1FolekaVSJ9
        4Ih8r1waGyUWieNRHB2sYTLZRDr5YKpoX7raWYEO/ohRZzlHqYxeT+9O2qPTZhnY4DSt3pBI
        s5xSzcVzkXomU5+lUUUqtJmvi6OioqVO8XhGWr7lMcHdJz4Z+W0UywctHqeAFwkpCXQMTwtc
        7Ev1A2hfk/C8BOBIzZFTwNvJqwA+HLGCFwsVBWuAlwYAfHqX4aUHAK6vluOuB1soOTR3D7vZ
        j8qF1l9uEi4Jo4wCWPl9ozuOoCLg4KydcPFmKgRefzTtfquQSoKFzTzj1HZY8UWN2/Gn3oGj
        fcXPnZfg6IUZZwBJelGJsPKP/a4xRgXAGzOXBDxvhUW91ZgrF1IrJFy8NYvzDZJh7Z3vMJ63
        wLmrPZ48B8JlxwDBcw78atRK8MslAPYMjj8/rxg42FghcAVjVDhst+zmxyHwytOLgA/eBB0P
        yzxcCqSEsORzX14JhRM3pwQ8vwIvnywlzgLatKGNaUMF04YKpv/D6gDeCl5mOX2mitWLOcnG
        u+4C7o87AvWDi/8sRA4BAQmGACQx2k9YE3Re7itUMtknWJ1WrstSs/ohIHWebzkW6K/QOv8O
        jUEulkbHxMQgiThWKhbTAcJnO0vkvpSKMbAZLMuxuhd7AtIrMF8QfuEte4loojVs00JeXGhC
        0GLfjoA5tP+Yf27Lv7d7912Py5ts/nmNPTFxqHp23C/o4+zew2PQ22f19v1j47FNTU3RB+Xl
        eWNBwwXC2bGiV7U5yXf9YJ9GmT1GSpby33vQ0WhL/+Dr+tARW3XMu0bLubgFzhZkxReEVzN/
        /wZv+OwW1pFwY7utzBjrWffT2am50wfamw93fxttnjOqU+wt9VFPJM/y4LbuMBEWzx3tuLRX
        jXp/UJzpuZMfZk5KSej6cMbgXdZUvr6Se3mg4lxb/4BNSu/wQYq/av/clnEv/u35zr9PU28i
        +a6q+BAueGnp+PsqaU7Dk2S01dGWcujTk/doXJ/GiCMwnZ75D5pVl3llBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHIsWRmVeSWpSXmKPExsWy7bCSnK629rR4g0s/FC2WXTrKaLFxxnpW
        i4k3rrBYrP74mNFize1DjBY/NpxitmiZtYjFYsGnGawWZ5vesFtc3jWHzeJz7xFGi84vs9gs
        Fja1sFvcblzBZvFz1zwWB36PNfPWMHrsuLuE0WPnrLvsHptWdbJ59Da/Y/PY+G4Hk8ffWftZ
        PPq2rGL0+LxJLoAzissmJTUnsyy1SN8ugSujYddPtoKXbBVHr51kbmBcwdrFyMkhIWAiMbnx
        O2MXIxeHkMBuRold0xsZIRKSEtMuHmXuYuQAsoUlDh8uhqh5yyixoe8hE0iNsEC8xJrNh1lA
        bBGBWolXq6ezghQxC/QySXTt2gu2QUjgHaPEyj/KIDabgJbE/hc32EBsfgFFias/HoMt4xWw
        k2haDmGzCKhKTO6fA1YjKhAmsXPJYyaIGkGJkzOfsIAcxClgKzHtpjtImFlAXeLPvEvMELa4
        xK0n85kgbHmJ5q2zmScwCs9C0j0LScssJC2zkLQsYGRZxSiZWlCcm55bbFhgmJdarlecmFtc
        mpeul5yfu4kRHMVamjsYt6/6oHeIkYmD8RCjBAezkgjvHJmp8UK8KYmVValF+fFFpTmpxYcY
        pTlYlMR5bxQujBMSSE8sSc1OTS1ILYLJMnFwSjUw8Wxh9uBUu6URLMcvfUHbsTtzrdSjd1Nk
        Ls3hMX6+74JH06sUgVN1NVL70xKKLrY+elqfz6gefvmAksXpyPYD3K9Kq7huJK1krZ38hYXT
        o1P77EVXee4z9/rm3T11IUm8rvVfp8JiIznFnc4OpaHT1V9bz/8faPjcqcvdquvFwbbC/t6f
        vydZtkjKOc909EnYUp54IrjqoMTkWcef/0qzY/DqkJx85HnNG8ktEfaWV1doXLe0kpvbvzJ9
        /ZyrCt9/8zO4Hto4Pf9PRbq50vOmQ1OKOrz6OZ1K5t/6uSNHmlvu1PaVFa5sJwuOBxc+zThi
        Nt+nkeeSovC1x2t8qn95KcnG38j/a9hnNXnTtWYlluKMREMt5qLiRAB0ksogUQMAAA==
X-CMS-MailID: 20201026014931epcas1p252b32cf13270bfcd4af756cc80a37be8
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
        <9a2c99d1-ef65-4d89-3740-90a3b60d4cd5@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10/26/20 1:31 AM, Dmitry Osipenko wrote:
> 23.10.2020 13:26, Chanwoo Choi пишет:
>> @@ -1401,8 +1423,13 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
>>  				"%s: reverting to Governor %s failed (%d)\n",
>>  				__func__, df->governor_name, ret);
>>  			df->governor = NULL;
>> +			goto out;
>>  		}
> ...
>> +		create_sysfs_files(df, df->governor);
>> +		goto out;
> 
> These two lines could be removed.

Right. These are redundant code. It is possible to support
with just fallback style.

> 
>>  	}
>> +	create_sysfs_files(df, df->governor);
>> +
>>  out:
>>  	mutex_unlock(&devfreq_list_lock);
> 
> Otherwise looks good to me.
> 
> Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
> Tested-by: Dmitry Osipenko <digetx@gmail.com>
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
