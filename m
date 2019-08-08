Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DABF85DA6
	for <lists+linux-pm@lfdr.de>; Thu,  8 Aug 2019 11:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731274AbfHHJBf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Aug 2019 05:01:35 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:38486 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731031AbfHHJBf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Aug 2019 05:01:35 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190808090133euoutp0233b7c1a6402179e313f1f2244e703603~45whLFRDX2116021160euoutp02G
        for <linux-pm@vger.kernel.org>; Thu,  8 Aug 2019 09:01:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190808090133euoutp0233b7c1a6402179e313f1f2244e703603~45whLFRDX2116021160euoutp02G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1565254893;
        bh=vAPC1KqG78EX5MpxZmqoLOpy+g6UHWhf1FKimkaWP4A=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=pO8Xm438v/7EEIdA82aSLOjUZqy0rWF8TNWSQFD2AuUDYX/6JwjPg1gXh8ENARgP2
         e3xr90ohBy3jU2A9JUj941NSAm82iGXDqWJYpcEXD2r9QK3gQDkIj++Hsv0mVA9LMF
         qGUuH5aFDn5ibGl0asc4wW2tKyfLh9vo9m2ngd+Y=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190808090132eucas1p13b40a53172facc537e31245aebf3bae7~45wgZWn290878908789eucas1p1O;
        Thu,  8 Aug 2019 09:01:32 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 6C.9E.04374.CE4EB4D5; Thu,  8
        Aug 2019 10:01:32 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190808090131eucas1p1df8f45ce2b1a6022be13edd66dc5a93d~45wfqrqUY0864008640eucas1p1M;
        Thu,  8 Aug 2019 09:01:31 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190808090131eusmtrp2e352ba3f317c555186224aacbaa12396~45wfp_rbZ0831808318eusmtrp2K;
        Thu,  8 Aug 2019 09:01:31 +0000 (GMT)
X-AuditID: cbfec7f5-92d689c000001116-c1-5d4be4ec97fd
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 1C.70.04166.BE4EB4D5; Thu,  8
        Aug 2019 10:01:31 +0100 (BST)
Received: from [106.120.51.18] (unknown [106.120.51.18]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190808090130eusmtip14e1361b874b470445d8ee44ed8931457~45wesHjyG0244502445eusmtip1v;
        Thu,  8 Aug 2019 09:01:30 +0000 (GMT)
Subject: Re: [PATCH v5 0/4] add coupled regulators for Exynos5422/5800
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Mark Rutland <mark.rutland@arm.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
From:   Kamil Konieczny <k.konieczny@partner.samsung.com>
Message-ID: <b0b8bd85-c016-ef13-7d5e-11d476e35ab0@partner.samsung.com>
Date:   Thu, 8 Aug 2019 11:01:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <6888b704-1971-4832-d7b9-092368c797d0@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRju2zln57ianU3DlxUKI6KbVij4UXaDioVF/uhHJKNWHrTSKTs6
        M6nWRS0jzUllVk5Luyy7eS0tqbmceWVoKppmXlBSiVKj0jS3Y+S/53nf93mf9/n4GEL+mVIw
        R7TRnE6rCVeKJWRJ1a8G7+G+QPXaweH5+HnGUwq3jg1Q2GRtoHBq7xCBGxuf0bj+7DCNC3pb
        KNxUdkuMRy9bEc5orBDhx9ZOGue12kW448wDMR7+WS/CCa+tNJ5qeU7iwu4q8RaZKj8rH6kK
        zBfFqsLc06qUIjNS2dpKRarRAs8g8X5JQAgXfkTP6dZsOigJG6x9REal0ceL+nNoA5qgkpEL
        A6wf1LVloWQkYeTsAwSWrFJaIGMIupIGSIGMIqgrryb/SYZMlyihcR+B3ZIxS0YQ1FT+ETum
        3Ngd0GxIIxzYnV0ON/40O00ItomEaz1Gp7uY9Yee0jqRA0tnBNn302kHJtml8M54y2m3iN0H
        37srKWFGBu9v9DnrLuxmSL435jQjWA9o7zOJBOwF54pvEg4zYBMY6G83zjgzM2QbGH8EChHc
        4IutiBbwEph+KWiBjYX+nBRa0J5H0J30bTbzBqi02SnHHoJdAU/L1gjlrfCqKpcS1rtC24hM
        OMEVjCXXCaEshQuJcmHaG7Km62bffTEkTz+hriBl5pxgmXPCZM4Jk/nfNxuRZuTBxfARoRzv
        q+VifXhNBB+jDfU5HBlRgGY+Xu2UbfwFqpg8ZEEsg5QLpNU1gWo5pdHzcREWBAyhdJd26Xeq
        5dIQTdwJThd5QBcTzvEWtJghlR7S+HndwXI2VBPNHeO4KE73rytiXBQGpDcxCyfXt+8J+vEw
        6aoi3fx93HQoOz735NhUflwqWdhwr78s2MuQm/bpQwtz+851nZ6+OS3zHW8rXWmwn+ePBlgm
        v+6yyjwfJQaoXSuKFem/sY7RB/jbJ/J2e3QqEr1X390bGSxZRk24JGjLN6q3r7K9MY8zfW/9
        PlZ3KPSnhpQkH6ZZt5LQ8Zq/61CsR3QDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKIsWRmVeSWpSXmKPExsVy+t/xu7qvn3jHGnw7rm6xccZ6VovrX56z
        Wsw/co7Vov/xa2aL8+c3sFucbXrDbrHp8TVWi8u75rBZfO49wmgx4/w+Jou1R+6yWyy9fpHJ
        4nbjCjaLNz/OMlm07j3CbvHv2kYWi80PjrE5CHqsmbeG0WPTqk42j81L6j36tqxi9Dh+YzuT
        x+dNcgFsUXo2RfmlJakKGfnFJbZK0YYWRnqGlhZ6RiaWeobG5rFWRqZK+nY2Kak5mWWpRfp2
        CXoZL06vZimYyF6x5elC9gbG36xdjJwcEgImEq/ndwPZXBxCAksZJb7ceckIkZCWaDy9mgnC
        Fpb4c62LDaLoNaPE/cWbWEASwgJuElcaJjKD2CICGhIz/15hBCliFrjKInF+4xyojrOMEpNv
        nwKrYhMwl3i0/QzYWF6g7gXLJ7OD2CwCKhJHJ80BmyoqECFxeMcsRogaQYmTM5+AxTkF7CW6
        ln1hA7GZBdQl/sy7xAxhi0vcejKfCcKWl2jeOpt5AqPQLCTts5C0zELSMgtJywJGllWMIqml
        xbnpucWGesWJucWleel6yfm5mxiBUb7t2M/NOxgvbQw+xCjAwajEw1twwjtWiDWxrLgy9xCj
        BAezkgjvvTLPWCHelMTKqtSi/Pii0pzU4kOMpkDPTWSWEk3OByagvJJ4Q1NDcwtLQ3Njc2Mz
        CyVx3g6BgzFCAumJJanZqakFqUUwfUwcnFINjPpFpkesp+WunWG9nO/Ujaws1kN787Ntu47H
        lbFuucg/VXHN2WNuF195tS4tSnnq6LF628b3ojPd9aMUqnbELGJ5YGLHrL/WT6ym5Ozq4K/d
        zwy0Y/9tidn4JmplcLeWQd3Fecu9N55oPpFTxHzrZOfNH5EO+3qF7k8smbzkTernE29vrMwo
        lldiKc5INNRiLipOBAAKRIgXCAMAAA==
X-CMS-MailID: 20190808090131eucas1p1df8f45ce2b1a6022be13edd66dc5a93d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190807133855eucas1p1cab425b791262e8dee1b17cbe8b1b3da
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190807133855eucas1p1cab425b791262e8dee1b17cbe8b1b3da
References: <CGME20190807133855eucas1p1cab425b791262e8dee1b17cbe8b1b3da@eucas1p1.samsung.com>
        <20190807133838.14678-1-k.konieczny@partner.samsung.com>
        <6888b704-1971-4832-d7b9-092368c797d0@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Chanwoo,

On 08.08.2019 03:47, Chanwoo Choi wrote:
> Hi Kamil,
> 
> When I applied them to testing branch, those don't have the author name
> only just have the email address as following:
> You have to edit the your git author information with your name.

Sorry, I will resend with proper From: info.

> author	k.konieczny@partner.samsung.com <k.konieczny@partner.samsung.com>	2019-08-07 15:38:36 +0200
> committer	Chanwoo Choi <cw00.choi@samsung.com>	2019-08-08 10:35:16 +0900
> commit	4304f4ecec93cebd255463d56b0a4f112ee9dc50 (patch)
> tree	2859e566d6f68219f71a61e7c412717c1adba4f5
> parent	57d85421038b458dd87ec268404ff608f90c36ae (diff)
> download	linux-4304f4ecec93cebd255463d56b0a4f112ee9dc50.tar.gz
> 
> Regards,
> Chanwoo Choi
> 
> On 19. 8. 7. 오후 10:38, k.konieczny@partner.samsung.com wrote:
>> [...]

-- 
Best regards,
Kamil Konieczny
Samsung R&D Institute Poland

