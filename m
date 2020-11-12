Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AAFF2B0760
	for <lists+linux-pm@lfdr.de>; Thu, 12 Nov 2020 15:11:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728342AbgKLOLg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Nov 2020 09:11:36 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:54885 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728395AbgKLOLG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Nov 2020 09:11:06 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20201112141054euoutp01ca88d627738bc78af61f48d7e38c6c33~GyAgzKFlW1532815328euoutp01B
        for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2020 14:10:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20201112141054euoutp01ca88d627738bc78af61f48d7e38c6c33~GyAgzKFlW1532815328euoutp01B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1605190254;
        bh=ifeX9jM6Nj9NQH/PbyRcohNnfKEnI/gwBb9dDyit1ls=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FO9oeXGfGiAMfPQyPuyMrX//oXYQWoU96528Yl1HoggygLbKI53c012GFt8A18RiE
         IyNuhQ6t7Qo9t+IRVQ9ywibdsoQJhEqpf9aBT1NcMUYqQOqBG8jspDBp6PpFA1S/Tk
         TuJp5IkowbZ6LtLfpV9RqDwSBtmafIR0s1ucmg8A=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20201112141052eucas1p10fe743ce2efb797033cae19b408e54e1~GyAeXAzNH1698416984eucas1p1m;
        Thu, 12 Nov 2020 14:10:52 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id FB.B9.44805.C624DAF5; Thu, 12
        Nov 2020 14:10:52 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20201112141051eucas1p1c94de8fd6032e0a9966cbff9e41c0f2f~GyAd89kSV1700417004eucas1p1s;
        Thu, 12 Nov 2020 14:10:51 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20201112141051eusmtrp17e7746e109f8668bfadbd9d027e39dae~GyAd8QmPV1172011720eusmtrp1f;
        Thu, 12 Nov 2020 14:10:51 +0000 (GMT)
X-AuditID: cbfec7f4-b37ff7000000af05-65-5fad426c473b
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 59.11.21957.B624DAF5; Thu, 12
        Nov 2020 14:10:51 +0000 (GMT)
Received: from AMDC3061.digital.local (unknown [106.120.51.75]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20201112141050eusmtip21d92e9213206af69f58b783917e1dc6f~GyAdKblpN3001030010eusmtip29;
        Thu, 12 Nov 2020 14:10:50 +0000 (GMT)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     georgi.djakov@linaro.org, cw00.choi@samsung.com,
        inki.dae@samsung.com
Cc:     krzk@kernel.org, devicetree@vger.kernel.org, robh+dt@kernel.org,
        a.swigon@samsung.com, myungjoo.ham@samsung.com,
        sw0312.kim@samsung.com, b.zolnierkie@samsung.com,
        m.szyprowski@samsung.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, s.nawrocki@samsung.com
Subject: [PATCH v9 3/5] MAINTAINERS: Add entry for Samsung interconnect
 drivers
Date:   Thu, 12 Nov 2020 15:09:29 +0100
Message-Id: <20201112140931.31139-4-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201112140931.31139-1-s.nawrocki@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJKsWRmVeSWpSXmKPExsWy7djP87o5TmvjDbramC3uz2tltNg4Yz2r
        xfUvz1kt5h85x2px5et7NovpezexWUy6P4HF4vz5DewWmx5fY7W4vGsOm8Xn3iOMFjPO72Oy
        WHvkLrvF7cYVbBate4+wWxx+085qMWPySzYHQY9NqzrZPO5c28Pmcb/7OJPH5iX1Hn1bVjF6
        fN4kF8AWxWWTkpqTWZZapG+XwJUx7c5WpoJXHBVH/11kamDcwt7FyMkhIWAisfXIO6YuRi4O
        IYEVjBJNs78wQjhfGCXWrJzJDuF8ZpRYt/4vG0zLxws7WCESyxkltt9ZzA7X0tm2nhmkik3A
        UKL3aB/QLA4OEQFPiZMN+iA1zALNzBINzZsYQWqEBQIldv1/yApiswioSty/eokJxOYVsJbY
        decnK8Q2eYnVGw6AzeQUsJGY+7SVDaJGUOLkzCcsIDYzUE3z1tnMIAskBOZzSnS9+8gI0ewi
        ceLQRqizhSVeHYf5Wkbi9OQeFoiGZkaJnt232SGcCYwS948vgOq2lrhz7hcbyAvMApoS63fp
        Q4QdJd4tmccKEpYQ4JO48VYQ4gg+iUnbpjNDhHklOtqEIKpVJH6vms4EYUtJdD/5zwJhe0gs
        vbqVaQKj4iwk78xC8s4shL0LGJlXMYqnlhbnpqcWG+WllusVJ+YWl+al6yXn525iBKa20/+O
        f9nBuPzVR71DjEwcjIcYJTiYlUR4lR3WxAvxpiRWVqUW5ccXleakFh9ilOZgURLnTdoClBJI
        TyxJzU5NLUgtgskycXBKNTDVtfsGTn+1pavyYscug/4Q60YhWY6pPiKWH1yWPo6xaXsRr75E
        afonhf1iRq9f7XdvEuhSWzfjqLJ01b0HTEejM55WHmntn3fUZn7G3ePz900yX3nncBGHiX5K
        8v1NSw1Uwh5fVrn+32Ta6QL11Qp3lj6YfU19gk2P7jdf5mVTBH/mRF3UkgyrZ0ncucdVbntY
        mM2Sc73ZVx9zXRe0v6ckqhontttW/prdYf2jM9YqOB6tnJx+rkQqqcxe1Pvenu8BFTMOfzzw
        ZeHSD/cKzKxFe/gtbqyIlbTQZpVfcfdSzv6Dkm4q15pavvhrnJF5k+7h41OmuXfHZzPRP5NZ
        zGY/Ngn+/HJHRaX+oyRTm6tKLMUZiYZazEXFiQBJ/wlt3AMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDIsWRmVeSWpSXmKPExsVy+t/xe7rZTmvjDVo/q1rcn9fKaLFxxnpW
        i+tfnrNazD9yjtXiytf3bBbT925is5h0fwKLxfnzG9gtNj2+xmpxedccNovPvUcYLWac38dk
        sfbIXXaL240r2Cxa9x5htzj8pp3VYsbkl2wOgh6bVnWyedy5tofN4373cSaPzUvqPfq2rGL0
        +LxJLoAtSs+mKL+0JFUhI7+4xFYp2tDCSM/Q0kLPyMRSz9DYPNbKyFRJ384mJTUnsyy1SN8u
        QS9j2p2tTAWvOCqO/rvI1MC4hb2LkZNDQsBE4uOFHaxdjFwcQgJLGSXWrNvP2MXIAZSQkpjf
        ogRRIyzx51oXG0TNJ0aJ+V/3s4Ik2AQMJXqP9jGC2CICvhKrT05iASliFpjMLPHodgsbSEJY
        wF/ifdMrsG0sAqoS969eYgKxeQWsJXbd+ckKsUFeYvWGA8wgNqeAjcTcp61gvUJANfu726Dq
        BSVOznzCAnIcs4C6xPp5QiBhZqDW5q2zmScwCs5CUjULoWoWkqoFjMyrGEVSS4tz03OLDfWK
        E3OLS/PS9ZLzczcxAqN127Gfm3cwznv1Ue8QIxMH4yFGCQ5mJRFeZYc18UK8KYmVValF+fFF
        pTmpxYcYTYG+mcgsJZqcD0wXeSXxhmYGpoYmZpYGppZmxkrivFvnAjUJpCeWpGanphakFsH0
        MXFwSjUwLQy4e+luFFu4zbsPz/d/NlhS6s5mX+1+T/X8H49Nsns+qVovczfvN1uXeoN5qok3
        7/PmCtXsQ+9f+DYGzA7g03FOdA4sPnxrV85SO6ngyHeO1XqyE+dw/5DL4dO4ZXLZL6Vac3YO
        36nZc3cHrSnfIP5tcorup1vHnDanC0hN6O1IdZ13LbGkJPn/1acKDzpe5K6cffjAzg1fSu8l
        ilycvmXvjcrG3c9Unz6YV3lc4U1/vNy8L5deu3NLTq9Zt3SJ29/Losbf1pvKML/U52/8I9e+
        53y5c/tyI4mmaHfPFfk3H7QyXcy+lLM9cPG3OzG7L8bYOK+ddUppfVRHUQTDNhaOmMUppre5
        Q5teGzwKVGIpzkg01GIuKk4EACwfgtZfAwAA
X-CMS-MailID: 20201112141051eucas1p1c94de8fd6032e0a9966cbff9e41c0f2f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20201112141051eucas1p1c94de8fd6032e0a9966cbff9e41c0f2f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20201112141051eucas1p1c94de8fd6032e0a9966cbff9e41c0f2f
References: <20201112140931.31139-1-s.nawrocki@samsung.com>
        <CGME20201112141051eucas1p1c94de8fd6032e0a9966cbff9e41c0f2f@eucas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add maintainers entry for the Samsung SoC interconnect drivers, this
currently includes the Exynos generic interconnect driver.

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
Changes for v9:
 - add linux-samsung-soc ML,
 - fixed Artur's last name spelling,
 - whole entry moved to maintain alphabetical order,
 - added missing traling '/' to directory path.

Changes since v7:
 - new patch.
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e73636b..1d8246c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15400,6 +15400,14 @@ L:	linux-fbdev@vger.kernel.org
 S:	Maintained
 F:	drivers/video/fbdev/s3c-fb.c
 
+SAMSUNG INTERCONNECT DRIVERS
+M:	Sylwester Nawrocki <s.nawrocki@samsung.com>
+M:	Artur Świgoń <a.swigon@samsung.com>
+L:	linux-pm@vger.kernel.org
+L:	linux-samsung-soc@vger.kernel.org
+S:	Supported
+F:	drivers/interconnect/samsung/
+
 SAMSUNG LAPTOP DRIVER
 M:	Corentin Chary <corentin.chary@gmail.com>
 L:	platform-driver-x86@vger.kernel.org
-- 
2.7.4

