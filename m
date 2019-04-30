Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 551CCF05F
	for <lists+linux-pm@lfdr.de>; Tue, 30 Apr 2019 08:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725996AbfD3GOz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Apr 2019 02:14:55 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:34676 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbfD3GOy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Apr 2019 02:14:54 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20190430061451epoutp02d98ec1a87f0d52b1ba11dedf3b7b7c71~aK_bTQkBu3209632096epoutp02i
        for <linux-pm@vger.kernel.org>; Tue, 30 Apr 2019 06:14:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20190430061451epoutp02d98ec1a87f0d52b1ba11dedf3b7b7c71~aK_bTQkBu3209632096epoutp02i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1556604891;
        bh=WJb+Cvmknz8hSilXK5stDWt6Ffwo/cFmz3E+umI80Lw=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=BP7nn9vtNH+sG9dASYJfuE/jNf0Z2g4CyNpdbL6IXjzU4h4+/pIBr/PgNjwFFhKLw
         n5HZ66/tKBuS2C2HHygX5MChCcVVcxxZLTZtqKVUeDbI3gNx9+613DWoKkZpDDdynz
         B11NmqYsCJ+4v42Fz5BI6VLuuyNQPDLgOqiUk8IA=
Received: from epsmges1p2.samsung.com (unknown [182.195.40.153]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190430061450epcas1p13807d3828b1819dfd48b9bdaf73ac0fa~aK_Z15ws03071130711epcas1p16;
        Tue, 30 Apr 2019 06:14:50 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        70.35.04142.9D7E7CC5; Tue, 30 Apr 2019 15:14:49 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190430061449epcas1p2ec80e66533f22b069220106f5bebbf63~aK_Zmq7xn1333613336epcas1p2-;
        Tue, 30 Apr 2019 06:14:49 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190430061449epsmtrp12160b23b169e2d774048dd51bfe7dfc0~aK_ZlwQF80891208912epsmtrp1-;
        Tue, 30 Apr 2019 06:14:49 +0000 (GMT)
X-AuditID: b6c32a36-cf9ff7000000102e-31-5cc7e7d9b248
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        61.63.03662.9D7E7CC5; Tue, 30 Apr 2019 15:14:49 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190430061449epsmtip2a1fc43e97f636a9b7801fe6e4444257f~aK_ZQPIkw2206222062epsmtip2j;
        Tue, 30 Apr 2019 06:14:49 +0000 (GMT)
Subject: Re: [PATCH v3 3/4] Documentation: devicetree: add PPMU events
 description
To:     Lukasz Luba <l.luba@partner.samsung.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     b.zolnierkie@samsung.com, krzk@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, kyungmin.park@samsung.com,
        m.szyprowski@samsung.com, s.nawrocki@samsung.com,
        myungjoo.ham@samsung.com, kgene@kernel.org,
        willy.mh.wolff.ml@gmail.com
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <52204c4b-80fa-1a87-2e00-1cfb774478f6@samsung.com>
Date:   Tue, 30 Apr 2019 15:16:04 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1555681688-19643-4-git-send-email-l.luba@partner.samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLJsWRmVeSWpSXmKPExsWy7bCmvu7N58djDM49t7HYOGM9q8X8I+dY
        Lfofv2a2OH9+A7vF2aY37Ba3GmQsNj2+xmpxedccNovPvUcYLWac38dksfbIXXaLpdcvMlnc
        blzBZtG69wi7xeE37awW3048YnQQ8Fgzbw2jx85Zd9k9Nq3qZPPYvKTe4+C7PUwefVtWMXp8
        3iQXwB6VbZORmpiSWqSQmpecn5KZl26r5B0c7xxvamZgqGtoaWGupJCXmJtqq+TiE6DrlpkD
        dLuSQlliTilQKCCxuFhJ386mKL+0JFUhI7+4xFYptSAlp8CyQK84Mbe4NC9dLzk/18rQwMDI
        FKgwITtjXs8j1oJpshWPPr1lbGCcJdbFyMkhIWAi8a1lB3MXIxeHkMAORolJs5cyQTifGCUe
        fD8I5XxjlJj66jgLTMvl1s2sEIm9jBJrulYyQjjvGSWWrDwEViUsECKx7t41dpCEiMBZoFlN
        29hAHGaBz4wSJx9cYwWpYhPQktj/4gYbiM0voChx9cdjRhCbV8BO4uCPx2CTWARUJRoaboHZ
        ogIREvePbWCFqBGUODnzCVicU8Bb4vbeK2BzmAXEJW49mc8EYctLNG+dDfaehMAhdolNl1uY
        IJ5wkVjc3MIMYQtLvDq+hR3ClpJ42d8GZVdLrDx5hA2iuYNRYsv+C6wQCWOJ/UsnAw3iANqg
        KbF+lz7EMj6Jd197WEHCEgK8Eh1tQhDVyhKXH9yFWispsbi9kw3C9pCYMvknywRGxVlI3pmF
        5IVZSF6YhbBsASPLKkax1ILi3PTUYsMCI+QI38QITtpaZjsYF53zOcQowMGoxMPr8e5YjBBr
        YllxZe4hRgkOZiURXo/jR2OEeFMSK6tSi/Lji0pzUosPMZoCQ3sis5Rocj4wo+SVxBuaGhkb
        G1uYGJqZGhoqifOud3COERJITyxJzU5NLUgtgulj4uCUamCckMzw1EBi9ZQ1Nw/yXmCzvVrV
        Zrjyru3lCp44y3CrrAdOgo/9OLU/PZ6xmN1L522mlv3KV1efnjjWZe6Q9rKRz+9l6eOEAMPN
        k47Kuitwz1r51Va3IbMt/N33qvWRC052nS3Mfp4o8vQpw1Wzg1eN+UQ9nzl+23c03W6l+teq
        pQyx6V3Ht+9XYinOSDTUYi4qTgQAi2ypK/ADAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOIsWRmVeSWpSXmKPExsWy7bCSvO7N58djDHbvUrfYOGM9q8X8I+dY
        Lfofv2a2OH9+A7vF2aY37Ba3GmQsNj2+xmpxedccNovPvUcYLWac38dksfbIXXaLpdcvMlnc
        blzBZtG69wi7xeE37awW3048YnQQ8Fgzbw2jx85Zd9k9Nq3qZPPYvKTe4+C7PUwefVtWMXp8
        3iQXwB7FZZOSmpNZllqkb5fAlTGv5xFrwTTZikef3jI2MM4S62Lk5JAQMJG43LqZtYuRi0NI
        YDejxOEdrSwQCUmJaRePMncxcgDZwhKHDxdD1LxllNj7eQkbSI2wQIjEunvX2EESIgJnGSUW
        TVoA5jALfGaUmL7mMjNEy31GiaubZoKNZRPQktj/4gZYO7+AosTVH48ZQWxeATuJgz8eg9Ww
        CKhKNDTcArNFBSIkzrxfwQJRIyhxcuYTMJtTwFvi9t4rYHOYBdQl/sy7xAxhi0vcejKfCcKW
        l2jeOpt5AqPwLCTts5C0zELSMgtJywJGllWMkqkFxbnpucWGBUZ5qeV6xYm5xaV56XrJ+bmb
        GMHRq6W1g/HEifhDjAIcjEo8vB7vjsUIsSaWFVfmHmKU4GBWEuH1OH40Rog3JbGyKrUoP76o
        NCe1+BCjNAeLkjivfP6xSCGB9MSS1OzU1ILUIpgsEwenVAOjvF1yb8Pmhw0p98rOnbq7aEP7
        oo87xDd+yNyrGzRj85yQnG035L8bC2xW2vFNs8nG9cpFO29pEe/i9yVORrYBAUEfvq0//ct0
        Uc7UD2sk9jrnv1hxW4uFYePf1jIVLZvdnDe32i76yVmccnLnT+cQTcOs6PaKE4wrJRjcHzME
        fOjR288zKcBKiaU4I9FQi7moOBEAXHzNeNoCAAA=
X-CMS-MailID: 20190430061449epcas1p2ec80e66533f22b069220106f5bebbf63
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190419134822eucas1p29c6eff0f500311749b33c4f556123cf0
References: <1555681688-19643-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190419134822eucas1p29c6eff0f500311749b33c4f556123cf0@eucas1p2.samsung.com>
        <1555681688-19643-4-git-send-email-l.luba@partner.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Lukasz,

On 19. 4. 19. 오후 10:48, Lukasz Luba wrote:
> Extend the documenation by events description with new 'event-data-type'
> field. Add example how the event might be defined in DT.
> 
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  .../devicetree/bindings/devfreq/event/exynos-ppmu.txt  | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/devfreq/event/exynos-ppmu.txt b/Documentation/devicetree/bindings/devfreq/event/exynos-ppmu.txt
> index 3e36c1d..47feb5f 100644
> --- a/Documentation/devicetree/bindings/devfreq/event/exynos-ppmu.txt
> +++ b/Documentation/devicetree/bindings/devfreq/event/exynos-ppmu.txt
> @@ -145,3 +145,21 @@ Example3 : PPMUv2 nodes in exynos5433.dtsi are listed below.
>  			reg = <0x104d0000 0x2000>;
>  			status = "disabled";
>  		};
> +
> +The 'event' type specified in the PPMU node defines 'event-name'
> +which also contains 'id' number and optionally 'event-data-type'.
> +
> +Example:
> +
> +		events {
> +			ppmu_leftbus_0: ppmu-event0-leftbus {
> +				event-name = "ppmu-event0-leftbus";
> +				event-data-type = <PPMU_RO_DATA_CNT>;
> +			};
> +		};
> +
> +The 'event-data-type' defines the type of data which shell be counted
> +by the counter. You can check include/dt-bindings/pmu/exynos_ppmu.h for
> +all possible type, i.e. count read requests, count write data in bytes,
> +etc. This field is optional and when it is missing, the driver code will
> +use default data type.
> 

How about editing it as following?

--- a/Documentation/devicetree/bindings/devfreq/event/exynos-ppmu.txt
+++ b/Documentation/devicetree/bindings/devfreq/event/exynos-ppmu.txt
@@ -10,14 +10,23 @@ The Exynos PPMU driver uses the devfreq-event class to provide event data
 to various devfreq devices. The devfreq devices would use the event data when
 derterming the current state of each IP.
 
-Required properties:
+Required properties for PPMU device:
 - compatible: Should be "samsung,exynos-ppmu" or "samsung,exynos-ppmu-v2.
 - reg: physical base address of each PPMU and length of memory mapped region.
 
-Optional properties:
+Optional properties for PPMU device:
 - clock-names : the name of clock used by the PPMU, "ppmu"
 - clocks : phandles for clock specified in "clock-names" property
 
+Required properties for 'events' child node of PPMU device:
+- event-name : the unique event name among PPMU device
+Optional properties for 'events' child node of PPMU device:
+- event-data-type : Define the type of data which shell be counted
+by the counter. You can check include/dt-bindings/pmu/exynos_ppmu.h for
+all possible type, i.e. count read requests, count write data in bytes,
+etc. This field is optional and when it is missing, the driver code
+will use default data type.
+
 Example1 : PPMUv1 nodes in exynos3250.dtsi are listed below.
 
                ppmu_dmc0: ppmu_dmc0@106a0000 {
@@ -145,3 +154,16 @@ Example3 : PPMUv2 nodes in exynos5433.dtsi are listed below.
                        reg = <0x104d0000 0x2000>;
                        status = "disabled";
                };
+
+Example4 : 'event-data-type' in exynos4412-ppmu-common.dtsi are listed below.
+
+       &ppmu_dmc0 {
+               status = "okay";
+               events {
+                       ppmu_dmc0_3: ppmu-event3-dmc0 {
+                               event-name = "ppmu-event3-dmc0";
+                               event-data-type = <(PPMU_RO_DATA_CNT |
+                                               PPMU_WO_DATA_CNT)>;
+                       };
+               };
+       };


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
