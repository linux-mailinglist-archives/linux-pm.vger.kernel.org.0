Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4887173DF
	for <lists+linux-pm@lfdr.de>; Wed,  8 May 2019 10:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbfEHIbr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 May 2019 04:31:47 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:48856 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbfEHIbr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 May 2019 04:31:47 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190508083145euoutp022ab8db1131df8838ee10d80bc29e9c68~cqAPGtgbc0998209982euoutp023
        for <linux-pm@vger.kernel.org>; Wed,  8 May 2019 08:31:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190508083145euoutp022ab8db1131df8838ee10d80bc29e9c68~cqAPGtgbc0998209982euoutp023
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1557304305;
        bh=myVgKEdDOFQaUFo3Ywfd4I2K16+zBnnOcmMYjlhueTE=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=suXrtihEcMAcRI66YR50nHmUCH2ZVU0RYfewgfGHHX1KunA5EkK3KR6taGlCeMFe/
         D8s3lSOGJaX1/B5BLXJKK/sPTkqzcrVDB9b0/GGHCNjbCLzZbWNr7SO6QaSq0shLxa
         EQ5F2E0Rl0GRRPpYpSj72/fWKVNN9hvkZdUZpWHo=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190508083144eucas1p275e410527baa9b6f89efac36ca20112a~cqAOUrpZ00526305263eucas1p27;
        Wed,  8 May 2019 08:31:44 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 8E.2F.04298.0F392DC5; Wed,  8
        May 2019 09:31:44 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190508083143eucas1p23bb074441c4a9d84797a7816c191874f~cqANf-06C1348213482eucas1p2x;
        Wed,  8 May 2019 08:31:43 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190508083143eusmtrp1d5083dcde65d9d2c8afcc1d757e6f00e~cqANRr6IJ0069700697eusmtrp14;
        Wed,  8 May 2019 08:31:43 +0000 (GMT)
X-AuditID: cbfec7f2-3615e9c0000010ca-9c-5cd293f07fdd
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id BC.FE.04146.FE392DC5; Wed,  8
        May 2019 09:31:43 +0100 (BST)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190508083142eusmtip17216ad43798633d9e6900f688401a25a~cqAMgkTC91488614886eusmtip1P;
        Wed,  8 May 2019 08:31:42 +0000 (GMT)
Subject: Re: [PATCH v7 04/13] dt-bindings: ddr: rename lpddr2 directory
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        b.zolnierkie@samsung.com, krzk@kernel.org, kgene@kernel.org,
        cw00.choi@samsung.com, kyungmin.park@samsung.com,
        m.szyprowski@samsung.com, s.nawrocki@samsung.com,
        myungjoo.ham@samsung.com, keescook@chromium.org, tony@atomide.com,
        jroedel@suse.de, treding@nvidia.com, digetx@gmail.com,
        willy.mh.wolff.ml@gmail.com
From:   Lukasz Luba <l.luba@partner.samsung.com>
Message-ID: <9d652010-7193-68ec-058b-319100e460f7@partner.samsung.com>
Date:   Wed, 8 May 2019 10:31:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190507165703.GA20137@bogus>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SWUxTQRR1+laqxbGI3LiGxiiggiR+TKIYSYw2GhMTfwg2SpEnoC1LHyCg
        ISgBV0TFtVor/oC4UJYgGJEEGkDZpKKgssketSoiTRAVKQ8jf+ece+aeOZPhKeVXZjEfGRUn
        GKK0OhUrp0trxpvXfcu2adabW+eSwusFDGn7McQQs7WJIfdH+hDJfmGSkYazepLV94kizc0W
        jjSe+MyRV09usWQ004rI9eZnMvLQ2smR98fzWDL5tIwj1Z9PMqSydQd5P+FKHHW9aIub2jF2
        iVbfTG2h1eXGTk5dlH+aVWemfWHV50vykbq4/qh6tGj5bj5YvilM0EUmCAa/zSHyiIosB4q5
        zCfm2IvZVDTCnkEuPOAN4Mg8i84gOa/EeQi6OrpoifxA8D2rUSaRUQQ9P22yf0cKWx9x0iAX
        QUe6hZGIHcFE1xvG6XLD26FuOH0aL8SeMJFxddpE4QoKRvs/TCXyPIt9oSw/1ulR4G3Qfs/G
        OmUarwT7IHbK7jgIumssjGRZAM9v9NNO7ILXQMavjOkOFPaAd/1mmYRXwGP7LcoZBdjEQ/e1
        15xzJ+CtMDCskQq4wcfaEk7CS6E++xwtYRFSM3OQhI9BX5ZpxrMRqmtbGOcaCntDwRM/SQ6E
        u7ldM9tdod2+QLqBK1wqvUZJsgJOZSgltxeUnHs584KLIPfBVe4CUhln9TLO6mKc1cX4P/cO
        ovORhxAv6sMF0T9KOOIravVifFS474FofRGa+ob1f2q/l6ExW2gVwjxSzVMMx7RolIw2QUzS
        VyHgKdVCRdtFm0apCNMmJQuG6P2GeJ0gVqElPK3yUByd07NXicO1ccJhQYgRDP+mMt5lcSpa
        /do1XUw4EeseOHR7y+SHqtiGnJei/6ruY6c1Xt5LWlIGavcEaBMvhpAR38HxyuSdjw7t+2SG
        YOLjv/Nt35W2cV3TWs8V0QHioTxdUMARc2Wvm9XhgLTkHvky60f7/MahyV2/LdtMpvKDA5Gv
        Av08U4wTENwYVJk2XFcUstYSqqLFCK2/D2UQtX8B6fRYo4IDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphleLIzCtJLcpLzFFi42I5/e/4Xd33ky/FGNyeImSxccZ6VovrX56z
        Wsw/co7VYvXHx4wWk0/NZbI4051r0f/4NbPF+fMb2C3ONr1ht7i8aw6bxefeI4wWM87vY7JY
        e+Quu8XtxhVsFv/37GC3OPymndVi/xUvi9u/+Sy+nXjE6CDs8e3rJBaP2Q0XWTx2zrrL7rFp
        VSebR2/zOzaPvi2rGD02n672+LxJLoAjSs+mKL+0JFUhI7+4xFYp2tDCSM/Q0kLPyMRSz9DY
        PNbKyFRJ384mJTUnsyy1SN8uQS9jb/83xoIpHBUL325ma2D8yNbFyMkhIWAisfHKOvYuRi4O
        IYGljBJ3Tz6ESohJTNq3nR3CFpb4c62LDaLoNaPElkezWUESwgLuEidetILZIgKKEr/bprGC
        FDEL7GWWWL9rLlRHA5NE19ONTF2MHBxsAnoSO1YVgjTwCrhJ3Fh5iQ0kzCKgIvH2mQBIWFQg
        QuLM+xUsECWCEidnPgGzOQW0Jdr+tIEdxyxgJjFv80NmCFtc4taT+UwQtrzE9rdzmCcwCs1C
        0j4LScssJC2zkLQsYGRZxSiSWlqcm55bbKhXnJhbXJqXrpecn7uJEZgCth37uXkH46WNwYcY
        BTgYlXh4J+RdjBFiTSwrrsw9xCjBwawkwnt94qUYId6UxMqq1KL8+KLSnNTiQ4ymQL9NZJYS
        Tc4Hpqe8knhDU0NzC0tDc2NzYzMLJXHeDoGDMUIC6YklqdmpqQWpRTB9TBycUg2MliUesoYH
        DDQyJB/rcST3yfzZNb9o7gUOs4fnJLcuUdI5+9/vxez5IY6bX7S/LTx25chNrfU1BRoh4es+
        z93Vu/45f1nVu8ZQpbx/tb87Xy38yH7hvM+Lvst/H7r6xKcsKD27qY9V3HMt45vf//hTL9V5
        fV6xJWmr4KSzf4yumopEzRX4E/OgRImlOCPRUIu5qDgRAEUNQQMXAwAA
X-CMS-MailID: 20190508083143eucas1p23bb074441c4a9d84797a7816c191874f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190506151213eucas1p2ca40029d09ddbbcd11e4a1dd60ae9654
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190506151213eucas1p2ca40029d09ddbbcd11e4a1dd60ae9654
References: <1557155521-30949-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190506151213eucas1p2ca40029d09ddbbcd11e4a1dd60ae9654@eucas1p2.samsung.com>
        <1557155521-30949-5-git-send-email-l.luba@partner.samsung.com>
        <20190507165703.GA20137@bogus>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 5/7/19 6:57 PM, Rob Herring wrote:
> On Mon,  6 May 2019 17:11:52 +0200, Lukasz Luba wrote:
>> Change directory name to be ready for new types of memories.
>>
>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>> ---
>>   .../devicetree/bindings/ddr/lpddr2-timings.txt     |  52 +++++++++++
>>   Documentation/devicetree/bindings/ddr/lpddr2.txt   | 102 +++++++++++++++++++++
>>   .../devicetree/bindings/lpddr2/lpddr2-timings.txt  |  52 -----------
>>   .../devicetree/bindings/lpddr2/lpddr2.txt          | 102 ---------------------
>>   4 files changed, 154 insertions(+), 154 deletions(-)
>>   create mode 100644 Documentation/devicetree/bindings/ddr/lpddr2-timings.txt
>>   create mode 100644 Documentation/devicetree/bindings/ddr/lpddr2.txt
>>   delete mode 100644 Documentation/devicetree/bindings/lpddr2/lpddr2-timings.txt
>>   delete mode 100644 Documentation/devicetree/bindings/lpddr2/lpddr2.txt
>>
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
Thank you, added to the next version.

Regards,
Lukasz
