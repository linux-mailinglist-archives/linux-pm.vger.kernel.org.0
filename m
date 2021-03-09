Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE8B332273
	for <lists+linux-pm@lfdr.de>; Tue,  9 Mar 2021 11:00:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbhCIJ7n (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Mar 2021 04:59:43 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:15510 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbhCIJ7T (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Mar 2021 04:59:19 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20210309095917epoutp02f9c71429b988b6dce4f2fd7805654a0d~qpDOB6a0r0161901619epoutp02X
        for <linux-pm@vger.kernel.org>; Tue,  9 Mar 2021 09:59:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20210309095917epoutp02f9c71429b988b6dce4f2fd7805654a0d~qpDOB6a0r0161901619epoutp02X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1615283957;
        bh=H7GXZNe8mDiZk+7xJer+ZHMXA8WilmQDrfBYS4hqAJA=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=VRnAV0h44JLfiZVHFmdL/87NLzIWxO0GvUFHHkp5TCo8whzC/ylJ7QPacMXvOqaNx
         eYYkYHFH+mDYGEkL64o74VRCkWhQewDsZM2/HpveWWNv0iuex5XwOspIfnXQk3yQTD
         Ar9p/7AvpmexLZLF+R1b064O6GOsv+oO15bijCEU=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20210309095916epcas1p1f79304e646b2d8fab370aaaa035a9e47~qpDNKMLys0671406714epcas1p1y;
        Tue,  9 Mar 2021 09:59:16 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.153]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4DvrJw6YpWz4x9Pt; Tue,  9 Mar
        2021 09:59:12 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        98.8A.09582.0F647406; Tue,  9 Mar 2021 18:59:12 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20210309095912epcas1p363f088c2e3d0a3b1a1702607265f0d11~qpDJHgqeU3025930259epcas1p3g;
        Tue,  9 Mar 2021 09:59:12 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210309095912epsmtrp1ec456487c50bfa33282d005b4101f136~qpDJGesGG2524525245epsmtrp1B;
        Tue,  9 Mar 2021 09:59:12 +0000 (GMT)
X-AuditID: b6c32a37-899ff7000000256e-ee-604746f05728
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        8E.DA.13470.FE647406; Tue,  9 Mar 2021 18:59:11 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210309095911epsmtip2105fd04b6a2baec3cbed47338a852124~qpDIqkEIx2762327623epsmtip2J;
        Tue,  9 Mar 2021 09:59:11 +0000 (GMT)
Subject: Re: [RESEND PATCH v5 1/4] dt-bindings: devfreq: rk3399_dmc: Add
 rockchip,pmu phandle.
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, heiko@sntech.de
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        =?UTF-8?Q?Ga=c3=abl_PORTAY?= <gael.portay@collabora.com>,
        Rob Herring <robh@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:DEVICE FREQUENCY (DEVFREQ)" <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <04bed90e-c523-0638-65ab-e286fdc98a34@samsung.com>
Date:   Tue, 9 Mar 2021 19:15:54 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20210308233858.24741-1-daniel.lezcano@linaro.org>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLJsWRmVeSWpSXmKPExsWy7bCmvu4HN/cEg5YmA4t5n2Ut5h85x2qx
        5vYhRoslu96wWfx/9JrV4mzTG3aLTY+vsVpc3jWHzeJz7xFGi08P/jNb3G5cwWbRuvcIu8X/
        PTvYHXg9dtxdwuixaVUnm8eda3vYPDYvqffo27KK0WP7tXnMHp83yQWwR2XbZKQmpqQWKaTm
        JeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoqufgE6Lpl5gAdq6RQlphTChQKSCwuVtK3
        synKLy1JVcjILy6xVUotSMkpsCzQK07MLS7NS9dLzs+1MjQwMDIFKkzIzjg5R67gKnfF5amC
        DYyPObsYOTkkBEwkNs3cxdTFyMUhJLCDUWLBrjlQzidGiT9vtzBDON+AnOUn2WFaJvw9BlW1
        l1Hi874PUM57RonNC7exdDFycAgLJEi8bQ4GaRARsJc42ziRBaSGWWAVi8TD5lcsIAk2AS2J
        /S9usIHY/AKKEld/PGYEsXkF7CQuPP4JFmcRUJE4OGshWL2oQJjEyW0tUDWCEidnPgGLcwIt
        eDf/OVg9s4C4xK0n85kgbHmJ5q2zwV6QELjAIfF29g5miBdcJE7sf8EIYQtLvDq+Beo1KYmX
        /W1QdrXEypNH2CCaOxgltuy/wAqRMJbYv3QyE8iXzAKaEut36UOEFSV2/p7LCLGYT+Ld1x5W
        kBIJAV6JjjYhiBJlicsP7jJB2JISi9s72SYwKs1C8s4sJC/MQvLCLIRlCxhZVjGKpRYU56an
        FhsWGCNH9iZGcDrWMt/BOO3tB71DjEwcjIcYJTiYlUR4/Y67JQjxpiRWVqUW5ccXleakFh9i
        NAUG8ERmKdHkfGBGyCuJNzQ1MjY2tjAxNDM1NFQS500yeBAvJJCeWJKanZpakFoE08fEwSnV
        wFSc/1V+veP2o9Faxp7PJ2yd8WKnZqW+Y/Xq/CkRc9IsdnlumzNtiYGtwGOH9kt7T0YliH3+
        /rXje0IbZ1PULUX+h2l7/FPMtp8U7XSdfE+g/OH/M5tOdBWmxd/a4nAmz61s0l8FA7Wco+vE
        hBzPXl7Ps286v7xG6+ETOTnfTFfKFyZ9C5tr9bnp0Acdk9eCs8tibqldfVu8eJJHpbpe0K79
        TebtZU+3XPnU2hKuyccj67f//Y3zG259NFSUPt5od+pT2ZJgpZxz3x5smpV8eddiR/UMPVYe
        h02cYiz8/25tmda6ibE5oNMh78lyvZ5zF79H5IotXnPiCV97b83vrelrjm6ccCUvWOd82OL8
        i61KLMUZiYZazEXFiQAo4T0NUAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOIsWRmVeSWpSXmKPExsWy7bCSvO57N/cEg2uHrSzmfZa1mH/kHKvF
        mtuHGC2W7HrDZvH/0WtWi7NNb9gtNj2+xmpxedccNovPvUcYLT49+M9scbtxBZtF694j7Bb/
        9+xgd+D12HF3CaPHplWdbB53ru1h89i8pN6jb8sqRo/t1+Yxe3zeJBfAHsVlk5Kak1mWWqRv
        l8CVcXKOXMFV7orLUwUbGB9zdjFyckgImEhM+HuMqYuRi0NIYDejRO/fiywQCUmJaRePMncx
        cgDZwhKHDxdD1LxllDjU/4gRJC4skCDxtjkYpFxEwF7ibONEFpAaZoEVLBJ3Jh9gh2iYxCix
        tO092FA2AS2J/S9usIHY/AKKEld/PGYEsXkF7CQuPP4JFmcRUJE4OGshWL2oQJjEziWPmSBq
        BCVOznwCFucE2vZu/nOwemYBdYk/8y4xQ9jiEreezGeCsOUlmrfOZp7AKDwLSfssJC2zkLTM
        QtKygJFlFaNkakFxbnpusWGBYV5quV5xYm5xaV66XnJ+7iZGcFxqae5g3L7qg94hRiYOxkOM
        EhzMSiK8fsfdEoR4UxIrq1KL8uOLSnNSiw8xSnOwKInzXug6GS8kkJ5YkpqdmlqQWgSTZeLg
        lGpg8vzEuqe051LC9fi+t2JnLq6ffnReh0p18WZj82c6Do76ZxX1W98WvYq6222wcZad/usP
        Lyfc/lnQ+UL74P4fVrmv9rnc9BVVSK7bXhz36nngkZB1lcr7nysu9Wh+scUxJeG1nbdI0Y4v
        mg6Vvd0vNCUuzujs2+eem/CrauOafRHfZ+m0/94RG9TOfXv5nXjmU12b+iaJlh0qWugmc/BT
        jpNo9zxt1f95rEuSZT6u3CLIHLjW1Lr6Uw+T7JlXvp9sN1h7q2UZ7i+fvDwicrMlY+avthcX
        9N4f2XbkV3i0KOP5B00e0wSeJjvp3Evq9VTiqd0i+dKMZeHfu9cbtFcc9w9S/G2UsLz2ULns
        JrMVSizFGYmGWsxFxYkAopRhgDoDAAA=
X-CMS-MailID: 20210309095912epcas1p363f088c2e3d0a3b1a1702607265f0d11
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210308234058epcas1p43f00b9dcc3ea75e758ae2cf9a35d36ac
References: <CGME20210308234058epcas1p43f00b9dcc3ea75e758ae2cf9a35d36ac@epcas1p4.samsung.com>
        <20210308233858.24741-1-daniel.lezcano@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 3/9/21 8:38 AM, Daniel Lezcano wrote:
> From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> 
> The Rockchip DMC (Dynamic Memory Interface) needs to access to the PMU
> general register files to know the DRAM type, so add a phandle to the
> syscon that manages these registers.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Gaël PORTAY <gael.portay@collabora.com>
> Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt b/Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt
> index a10d1f6d85c6..a41bcfef95c8 100644
> --- a/Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt
> +++ b/Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt
> @@ -12,6 +12,8 @@ Required properties:
>  			 for details.
>  - center-supply:	 DMC supply node.
>  - status:		 Marks the node enabled/disabled.
> +- rockchip,pmu:		 Phandle to the syscon managing the "PMU general register
> +			 files".
>  
>  Optional properties:
>  - interrupts:		 The CPU interrupt number. The interrupt specifier
> 

Applied it. Thanks.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
