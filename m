Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82F6513C883
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jan 2020 16:56:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbgAOP4Z (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jan 2020 10:56:25 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:40455 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726501AbgAOP4Y (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jan 2020 10:56:24 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200115155622euoutp017e79a8db3b5211b0ab80106bac2aba91~qGoYj_5kG2878528785euoutp01m
        for <linux-pm@vger.kernel.org>; Wed, 15 Jan 2020 15:56:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200115155622euoutp017e79a8db3b5211b0ab80106bac2aba91~qGoYj_5kG2878528785euoutp01m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1579103782;
        bh=XfQrDuwfMB1/RW0gP/rZygphaWkcyV/9F+qlQtlGsz0=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=EJT87qqZn043G+lRyCAE+TGe447nFmTU9kEWnurY9QBw7MdxMuvvd04eBToTUQaZP
         XNpaqqPDjnAS4gblSdLQGOojZ9Y3fyEDu7Kt57C0XzdDkZAxFrdZSF/gP6NtB+MIiq
         EgV7hF3gTeWBXWnpc4tTMwk6Borrrkc3NwhR8qJU=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200115155622eucas1p2f01c2676156c662ae0c524fb40518570~qGoYE2iMk0833708337eucas1p2D;
        Wed, 15 Jan 2020 15:56:22 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 06.96.60698.6263F1E5; Wed, 15
        Jan 2020 15:56:22 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200115155621eucas1p1db3f830ef52babfd58d4bd4340d174c3~qGoXaEVMA3131631316eucas1p1D;
        Wed, 15 Jan 2020 15:56:21 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200115155621eusmtrp25a03846dd255ad40c2db5a3b98c31a06~qGoXZMF371584215842eusmtrp21;
        Wed, 15 Jan 2020 15:56:21 +0000 (GMT)
X-AuditID: cbfec7f5-a0fff7000001ed1a-ce-5e1f3626edaf
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id CD.32.08375.5263F1E5; Wed, 15
        Jan 2020 15:56:21 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200115155620eusmtip15e37a477548de28762c8dee44115842e~qGoWQCP9I0722007220eusmtip1n;
        Wed, 15 Jan 2020 15:56:20 +0000 (GMT)
Subject: Re: [PATCH 7/7] devfreq: move statistics to separate struct
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        Javi Merino <javi.merino@arm.com>,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        Kamil Konieczny <k.konieczny@samsung.com>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Zhang Rui <rui.zhang@intel.com>,
        =?UTF-8?Q?=c3=98rjan_Eide?= <orjan.eide@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        a.hajda@samsung.com, robin.murphy@arm.com
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <4da95c7f-7fc7-afb5-e569-4403e705f658@samsung.com>
Date:   Wed, 15 Jan 2020 16:56:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <d710f606-0013-ade3-904e-a56f0404eca7@arm.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SWUxTQRSGM3frBS25FJEjm9pERIxbRB3UEEh4aNAHfVExUqlypQYKpLVu
        iangBiSioiJWFAERrShIcQENiYAlCqUgiwQBRTFSFMNmIgho2wuRt2/mnP//z5kMS0oGaU/2
        YPwhXh2viJMyztRT05hlhd/6hfLVta/n4I5HDTR+P/qNxl8vPiFxTksbjcsmTonw7eEsGl/4
        8p3EFkuJCJuTf4hw6Rdbtbkim8Ej52sQzrJUEjg3+bQIP6zpEuEPSfcYXGmspvCrwV4a9/ak
        MyFusqJbRUhWru8SyfJfWglZqSGVkRnv6GTpZQYkGyn13Sba7bw5mo87eJhXrwqOclaaX3QT
        if3sUWNqAXESXRClIScWuED4frOVSUPOrIS7h6Aiq48WDqMIPnW2UsJhBMFo7iA1IymyNhF2
        lnCFCEy5/kLTAAKDRfB148KgPiOZsfM8bgm0NXY5nEgun4Yr2TccaobbCJfOGZCdxVwwDD1O
        dzBlE/RP1juM3LldMPypmhZ6XOHN9V7HFE7cJjiXYnIwyXlAR28OIfBCeDaQTdrDgLvKwrvG
        HiSMHQZJzdWEwG7QX1s2/QLe8LfcLrYLHiGYTOmbVj9DUHh5ihG6NkFnw7iNWVvEMiiuWGVH
        4EKhachLQBdoH3AVZnCBjKfXSOFaDClnJYKHH5TcLWFmUtPK75MXkVQ/azP9rG30s7bR/4+9
        jSgD8uC1GlUMr1kbzx9ZqVGoNNr4mJX7E1SlyPYP66Zqfz1HlRP7qhDHIulcsXLCVy6hFYc1
        x1RVCFhSOk/8JstHLhFHK44d59UJe9XaOF5ThbxYSuohXptnjZRwMYpDfCzPJ/LqmSrBOnme
        RErznImIMHPjxnUm97H7ARELrH/q//rE5VOD4V9Ned0P5k8p/H6qwuly3c38vmAiJ9DYFqvs
        DyrejjM79ugyQpeeWVzwMTKyRbs1ynriMZb+XpRS7J25o21nvS5zywZcF9TdPV47NZbtSu8/
        oPVfDu0hLYu7dG+lO4rkDZ9DzM1SSqNUrAkg1RrFP6L8HKmDAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpileLIzCtJLcpLzFFi42I5/e/4XV1VM/k4g5NLZSxurTvHanH9y3NW
        i6cTtjJbzL9yjdViy59mdosFn2awWvQ/fs1scf78BnaLs01v2C02PQbKXt41h83ic+8RRosZ
        5/cxWSxsamG3WHvkLrvF7cYVbBb7Nh9msTj44QmrxZOHfWwOwh5r5q1h9Ng56y67x+I9L5k8
        Nq3qZPPYvKTeo2/LKkaPz5vkAtij9GyK8ktLUhUy8otLbJWiDS2M9AwtLfSMTCz1DI3NY62M
        TJX07WxSUnMyy1KL9O0S9DLO7r7HVPCKo2Jz51KmBsZ+9i5GTg4JAROJNS8vMoHYQgJLGSWm
        3RHqYuQAistIHF9fBlEiLPHnWhdbFyMXUMlrRonmo4tYQBLCAi4SZyY1sYHYIgKqEtcu3GUB
        KWIWWMoq8fvdbhaIjt/MEtsvHgXrYBOwkpjYvooRxOYVsJP4uLEPzGYB6n719wzYRaICERKH
        d8yCqhGUODnzCVgvp4C1RHvHMTCbWUBd4s+8S8wQtrjErSfzmSBseYntb+cwT2AUmoWkfRaS
        lllIWmYhaVnAyLKKUSS1tDg3PbfYUK84Mbe4NC9dLzk/dxMjMP63Hfu5eQfjpY3BhxgFOBiV
        eHgz/sjFCbEmlhVX5h5ilOBgVhLhPTlDNk6INyWxsiq1KD++qDQntfgQoynQcxOZpUST84Gp
        Ka8k3tDU0NzC0tDc2NzYzEJJnLdD4GCMkEB6YklqdmpqQWoRTB8TB6dUA+MM2bN24WnK1eFu
        sxw5dizaaO0SEZK0ISy+a4pwy/8fhpqXTG7HrJxxyHXKQesFZgsWXfx3q6VEXVVYSLJR3mp3
        ZOSxL7ErJy56fGMKe3CQ4cJj0ueYKhKXM02s5Z6UZ/rAcpdkx/1w2w4NlfcHGQuTpicn/HBP
        S/thJxF8IETIRSJDbbOvhxJLcUaioRZzUXEiAEAOZ+0VAwAA
X-CMS-MailID: 20200115155621eucas1p1db3f830ef52babfd58d4bd4340d174c3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20191113091354eucas1p265de4985d167814f5080fbdf21b75a0a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191113091354eucas1p265de4985d167814f5080fbdf21b75a0a
References: <20191113091336.5218-1-k.konieczny@samsung.com>
        <CGME20191113091354eucas1p265de4985d167814f5080fbdf21b75a0a@eucas1p2.samsung.com>
        <20191113091336.5218-8-k.konieczny@samsung.com>
        <4942d2ad-fef7-89be-91c1-c02c319546ff@samsung.com>
        <38350d81-e916-b386-6727-f4c85689c172@samsung.com>
        <85a29ce4-0f89-2b50-b046-dba747208933@samsung.com>
        <4ed6b8bf-b415-c42d-33d6-d2ed0504eaf4@samsung.com>
        <d9d13537-f4c9-4420-c3bc-438bc87c5e6a@samsung.com>
        <d710f606-0013-ade3-904e-a56f0404eca7@arm.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 12/16/19 2:01 PM, Lukasz Luba wrote:
> Hi Bartek,
> 
> [added Dietmar, Robin, Andrzej (for upcoming DRM drm-misc-next)]
> 
> On 11/15/19 12:40 PM, Bartlomiej Zolnierkiewicz wrote:

[...]

>> Hmmm.. fixing partition_enable_opps() should be trivial but I wonder
>> why we are carrying devfreq_cooling.c code in upstream kernel at all?
> 
> Well, the devfreq_cooling.c is going to have a client in mainline:
> the GPU driver - Panfrost.
> 
> It is already in DRM branch 'drm-misc-next':
> https://patchwork.freedesktop.org/patch/342848/

OK, thanks for explaining this.

> Regarding the devfreq_cooling.c code structure.
> I am currently working on cleaning up the devfreq cooling code and
> adding Energy Model instead for private freq, power tables. It will be
> in similar fashion as it is done in cpufreq_cooling. The model will
> be also simplified so hopefully more clients would come.
> It is under internal review and will be posted shortly.

Great to hear this and thank you for working on it.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
