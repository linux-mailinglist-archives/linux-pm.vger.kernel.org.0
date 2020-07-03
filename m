Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDE8B213071
	for <lists+linux-pm@lfdr.de>; Fri,  3 Jul 2020 02:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726028AbgGCA11 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Jul 2020 20:27:27 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:15674 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbgGCA10 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Jul 2020 20:27:26 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200703002723epoutp01ad9eb18b0416fcc2e6707cf833672736~eFnzH_Pdl0983009830epoutp01b
        for <linux-pm@vger.kernel.org>; Fri,  3 Jul 2020 00:27:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200703002723epoutp01ad9eb18b0416fcc2e6707cf833672736~eFnzH_Pdl0983009830epoutp01b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1593736043;
        bh=78YFWLUy8a6bG0IHznbUMinVUfMhZKY0hWn/f2bKTPQ=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=n/eJ46kdngbho6R0418x+3ptVzEAavlFvhuaUY2BHsla8mP5Q/RzSI/oaxSYIVt/b
         hH/qGO48oEYjQUgkxphVrIvxE9iKB1uGwcl4n3y+g9sil1ljeA9a7ijUjRy3F/cd3b
         L0LrT/VG/QmEcacGcXiT5+6ODkzBFLB7MuK4p7GY=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20200703002722epcas1p47dc4697da12a5d1999b0f1135600081e~eFnysJkqp0272102721epcas1p4F;
        Fri,  3 Jul 2020 00:27:22 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.158]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 49ybPz7487zMqYkk; Fri,  3 Jul
        2020 00:27:19 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        B3.18.28578.76B7EFE5; Fri,  3 Jul 2020 09:27:19 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200703002719epcas1p2d9c4f9d0f4bbfdb31f21be4ab6fa4408~eFnvewYGC3267232672epcas1p2v;
        Fri,  3 Jul 2020 00:27:19 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200703002719epsmtrp2015c4aa95c939ae170c46502b7a9dce8~eFnveA_Ur0126401264epsmtrp27;
        Fri,  3 Jul 2020 00:27:19 +0000 (GMT)
X-AuditID: b6c32a39-e6f5da8000006fa2-96-5efe7b67c9d6
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        6C.8E.08303.76B7EFE5; Fri,  3 Jul 2020 09:27:19 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200703002719epsmtip2bca91588d12f05b243b2729bc6967a00~eFnvQf75I2430624306epsmtip2H;
        Fri,  3 Jul 2020 00:27:19 +0000 (GMT)
Subject: Re: [PATCH 12/17] drivers: devfreq: Fix trivial spelling
To:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc:     linux-renesas-soc@vger.kernel.org,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Jiri Kosina <trivial@kernel.org>,
        "open list:DEVICE FREQUENCY EVENT (DEVFREQ-EVENT)" 
        <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <bc52868b-e468-70b3-74ec-782bca8ada25@samsung.com>
Date:   Fri, 3 Jul 2020 09:38:34 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20200609124610.3445662-13-kieran.bingham+renesas@ideasonboard.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBJsWRmVeSWpSXmKPExsWy7bCmnm569b84g19/LS0+XetmtNh2+jer
        xdmmN+wWl3fNYbP43HuE0WLry3dMFrcbV7BZvN9/mcmBw2N2x0xWj02rOtk8+rasYvT4vEku
        gCUq2yYjNTEltUghNS85PyUzL91WyTs43jne1MzAUNfQ0sJcSSEvMTfVVsnFJ0DXLTMH6Awl
        hbLEnFKgUEBicbGSvp1NUX5pSapCRn5xia1SakFKToFlgV5xYm5xaV66XnJ+rpWhgYGRKVBh
        QnbGvpP/mAtm8lasfDWTtYHxEVcXIyeHhICJxKbdzcxdjFwcQgI7GCXWt59khHA+MUrc2POe
        DcL5zCjxt+kLO0zLzLcXoRK7GCXu9W1mgnDeM0p0tb1mBakSFnCU+LdsOiOILSJQILH96XKw
        ucwCc5gkVq1dD1bEJqAlsf/FDTYQm19AUeLqj8dgDbwCdhIHD39gBrFZBFQkLj87DlYjKhAm
        cXJbC1SNoMTJmU9Yuhg5ODgFAiRav4CNZBYQl7j1ZD4ThC0vsf3tHLDnJARmckhcXb8OrF5C
        wEXi0Al7iG+EJV4d3wL1mZTE53d72SDsaomVJ4+wQfR2MEps2X+BFSJhLLF/6WQmkDnMApoS
        63fpQ4QVJXb+nssIsZdP4t3XHlaIVbwSHW1CECXKEpcf3GWCsCUlFrd3sk1gVJqF5JlZSD6Y
        heSDWQjLFjCyrGIUSy0ozk1PLTYsMEWO7U2M4CSqZbmDcfrbD3qHGJk4GA8xSnAwK4nwJqj+
        ixPiTUmsrEotyo8vKs1JLT7EaAoM3onMUqLJ+cA0nlcSb2hqZGxsbGFiaGZqaKgkzutkfSFO
        SCA9sSQ1OzW1ILUIpo+Jg1OqgUl1pngHy5s1wpv5ptuFb7jBk5icvKBHYXJU6owqQV8RaaOE
        m/8fvYg+pLi643+r6IxFrRfS/63NfKRy9/++1uQ5J7cf3nWoLeCrRFaS2/73+15MtU///Ner
        zmTPzcrCtOT47Faraz9eaYazcvhOezhnvtWZf1L5SrNYZkzcyMrZ/VqoMZ7LetZsk8lP3qga
        P+U4eSJddmVEUFBo2aKSGWKRe7+znft34yWLR53V53vnnv+X1px7aHpi5jstS4H/IvvMuo8f
        vyU6c/7XogO/15aZfGAMXbmEsfDSox+89Z/5DYT+VlSf1p70TvCi26bwCbd+r/dqrJf4vOx5
        XGJ7xvKJFU73ctc3+DybmTTtWFe0EktxRqKhFnNRcSIAV+qFvisEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkkeLIzCtJLcpLzFFi42LZdlhJXje9+l+cwa0bQhafrnUzWmw7/ZvV
        4mzTG3aLy7vmsFl87j3CaLH15Tsmi9uNK9gs3u+/zOTA4TG7Yyarx6ZVnWwefVtWMXp83iQX
        wBLFZZOSmpNZllqkb5fAlbHv5D/mgpm8FStfzWRtYHzE1cXIySEhYCIx8+1FNhBbSGAHo8Ty
        F14QcUmJaRePMncxcgDZwhKHDxd3MXIBlbxllOje8YsFpEZYwFHi37LpjCC2iECBxNQtV5lB
        bGaBOUwSd++XQTS8YJS4PvsmWAObgJbE/hc3wJbxCyhKXP3xGKyZV8BO4uDhD2DNLAIqEpef
        HQerERUIk9i55DETRI2gxMmZT1hADuIUCJBo/cIKsUtd4s+8S1B7xSVuPZnPBGHLS2x/O4d5
        AqPwLCTds5C0zELSMgtJywJGllWMkqkFxbnpucWGBUZ5qeV6xYm5xaV56XrJ+bmbGMGxpKW1
        g3HPqg96hxiZOBgPMUpwMCuJ8Cao/osT4k1JrKxKLcqPLyrNSS0+xCjNwaIkzvt11sI4IYH0
        xJLU7NTUgtQimCwTB6dUA9OCLtbTuibpiskbXu7ass9mgnvVbPnqB3pR29ZqeCpY6Ou6yH4W
        YZt50/Z4xA/ZW2f7b6j9nFlz/zH78pT4xlftzIeiTn79u03t1R7HA70SvSzLr7wtXp217Ia2
        0ZkDyS+tN0j+LNiT1ul2pmGRn/HjqfdVI6qcXp5/V3kvdn3jDIbOlwIdX3Z+ylp/kWl79q3J
        EkFv5r58xNsUVqn4x0xm/nmxXsGpL8pYDq7fFSEdO2deZT6P69rahamFzYf9DjMvPG7P9Uvy
        0ce13Ycub9w4/xRTiuv2XY1RW2sSZ0asPJr3puN2wcG1lyazTb+kc+xZPlfYeXaV2jVe/+89
        jUvU5TyeeoHvyyRPu89Oaa8/K7EUZyQaajEXFScCAK1qN1wUAwAA
X-CMS-MailID: 20200703002719epcas1p2d9c4f9d0f4bbfdb31f21be4ab6fa4408
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200609124733epcas1p41612c63bd66692c16651622f4402efc4
References: <20200609124610.3445662-1-kieran.bingham+renesas@ideasonboard.com>
        <CGME20200609124733epcas1p41612c63bd66692c16651622f4402efc4@epcas1p4.samsung.com>
        <20200609124610.3445662-13-kieran.bingham+renesas@ideasonboard.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 6/9/20 9:46 PM, Kieran Bingham wrote:
> The word 'descriptor' is misspelled throughout the tree.
> 
> Fix it up accordingly:
>     decriptors -> descriptors
> 
> Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> ---
>  drivers/devfreq/devfreq-event.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/devfreq/devfreq-event.c b/drivers/devfreq/devfreq-event.c
> index 8c31b0f2e28f..56efbeb7851e 100644
> --- a/drivers/devfreq/devfreq-event.c
> +++ b/drivers/devfreq/devfreq-event.c
> @@ -293,7 +293,7 @@ static void devfreq_event_release_edev(struct device *dev)
>  /**
>   * devfreq_event_add_edev() - Add new devfreq-event device.
>   * @dev		: the device owning the devfreq-event device being created
> - * @desc	: the devfreq-event device's decriptor which include essential
> + * @desc	: the devfreq-event device's descriptor which include essential
>   *		  data for devfreq-event device.
>   *
>   * Note that this function add new devfreq-event device to devfreq-event class
> @@ -385,7 +385,7 @@ static void devm_devfreq_event_release(struct device *dev, void *res)
>  /**
>   * devm_devfreq_event_add_edev() - Resource-managed devfreq_event_add_edev()
>   * @dev		: the device owning the devfreq-event device being created
> - * @desc	: the devfreq-event device's decriptor which include essential
> + * @desc	: the devfreq-event device's descriptor which include essential
>   *		  data for devfreq-event device.
>   *
>   * Note that this function manages automatically the memory of devfreq-event
> 

Applied it. Thanks.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
