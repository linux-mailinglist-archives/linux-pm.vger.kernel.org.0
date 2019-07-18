Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25A476CC58
	for <lists+linux-pm@lfdr.de>; Thu, 18 Jul 2019 11:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbfGRJxR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Jul 2019 05:53:17 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:15407 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727666AbfGRJxQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Jul 2019 05:53:16 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20190718095313epoutp045f3edaa0f274089e07c188c347560f9e~yd6pLaFbk1304613046epoutp043
        for <linux-pm@vger.kernel.org>; Thu, 18 Jul 2019 09:53:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20190718095313epoutp045f3edaa0f274089e07c188c347560f9e~yd6pLaFbk1304613046epoutp043
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563443593;
        bh=uwL3QNapMBYokNIzLaQHpwasbLjWtKmrqJg35DdYJL0=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=W7FZRT+AxgdYoEJZEtY1OxKVJ6czuKB2xOHyRk5A//i+mJB5miPWO1Dgx+gSvvwqC
         ImmCrmdEbJMvQDpeFZ3BRpOGiXahg5n3MXWS6dLTNz0xFJFdns9ZFeyI1/68xtM2Yp
         UJwkXT0oizudBAkW2rFBx+4OB0Ez3XLtZlRbZt7M=
Received: from epsnrtp6.localdomain (unknown [182.195.42.167]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20190718095313epcas1p4134a217222f40a37b168b8430b3ba8c2~yd6orAGZZ1846418464epcas1p4x;
        Thu, 18 Jul 2019 09:53:13 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.157]) by
        epsnrtp6.localdomain (Postfix) with ESMTP id 45q8Zv16BrzMqYkX; Thu, 18 Jul
        2019 09:53:11 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        A1.B9.04066.781403D5; Thu, 18 Jul 2019 18:53:11 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20190718095310epcas1p31b048b8fd64ca3ff9b86b1a5f9f1415c~yd6mHr9fQ0313803138epcas1p3D;
        Thu, 18 Jul 2019 09:53:10 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190718095310epsmtrp243d7775a8d52216a21e59552ca59d806~yd6mG8oVF1330913309epsmtrp2X;
        Thu, 18 Jul 2019 09:53:10 +0000 (GMT)
X-AuditID: b6c32a37-29ba59c000000fe2-da-5d304187f03c
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        36.8C.03638.681403D5; Thu, 18 Jul 2019 18:53:10 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190718095310epsmtip1490c46377cebcd689a7a3858b6ea304f~yd6l7UFpD2451724517epsmtip1h;
        Thu, 18 Jul 2019 09:53:10 +0000 (GMT)
Subject: Re: [PATCH v4 24/24] PM / devfreq: tegra20/30: Add Dmitry as a
 maintainer
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <4f3eb6bd-a8fa-2bec-47fc-10b2eb228656@samsung.com>
Date:   Thu, 18 Jul 2019 18:56:19 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190707223303.6755-25-digetx@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRju2+V4Fs1OU+vNoOZJC4XpjnN6DJUuIqOk1uVHBbaO22GKuxx2
        tkiLbo5SSSuFqKVmV1K7UVYqmKCSGFiRClZI4aQ7yzLLqKxtZ5H/nu/5nud93+f7XlysuIlF
        44U2J+uwMRYSmy252x2vVh1Zpc5T//kQRjd/9iLa7TkvofsPfQyjB9prMXqisgfR5V89GP3i
        4BWM/tFeL6Grrj3FVsp0rSMXka7NMxKmqyz1Ybqqliakm7i1WC/dXpRRwDIm1qFkbUa7qdBm
        ziTXbTasMWhT1ZSKSqfTSKWNsbKZZHauXpVTaPEPRCp3MRaXn9IzPE8mZWU47C4nqyyw885M
        kuVMFi6dS+QZK++ymRONdusKSq1O1vqFO4sKTpVeFXND+G5vg/wAOhlWgWQ4ECnQfeyMqALN
        xhVEK4KxsQqpcPiC4Ou5U0g4fEPg+/hM+s9yaGo6ZOlA0Pb7TcjyCYG7140FVBHEFnh970tQ
        FUlMIyj/URq8EBPboLutWRTAGJEAnW+Hg/xcIgaGprwogOVEFgw/vxacUELEwZS3PchHEVvh
        YU+9RNDMg77TY0EsI1LhZXWHWKi/AJ6PnRUJeAmU3jkjDgwBxHcMbri7REKGbDg53h/KEwHv
        e1tCzxENE74OTMB7oLGvBxPMZQhaOp+EDBrovFTjL4T7O8TDjfYkgY6Btp91SGgcDr7Jo9KA
        BAg5lB1WCJKlMPBqJDTCQrhwpBw7jkjPjDieGRE8MyJ4/jdrQJImNJ/leKuZ5SlOM/O7b6Hg
        tiaktaKbj3K7EIEjco58mEzKU0iZXXyxtQsBLiYj5S/e+Sm5iSkuYR12g8NlYfkupPW/9glx
        dJTR7t99m9NAaZM1Gg2dQqVqKYpcIK//FZ+nIMyMky1iWY51/POJcFn0AZSwiTM2bIg1r27e
        H/suWX8098Tl8arxyRxpZ2z2243JSTmL1y5R7utJrDk4KMuP24HWvyo7e7nRlcvujzSVzNpr
        ncpreuO7PrrM/HgwQr0ozny7MVyl+DY47c1Pial9sKnB+1OnEundJuP9krUP60a5kRJFdR81
        aphUpV9fHmugSAlfwFAJYgfP/AWwz95VwwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFIsWRmVeSWpSXmKPExsWy7bCSnG6bo0GswdwjSharPz5mtGiZtYjF
        4mzTG3aLy7vmsFl87j3CaNH5ZRabxe3GFWwWP3fNY7HoW3uJzYHTY8fdJYweO2fdZffobX7H
        5tG3ZRWjx+dNcgGsUVw2Kak5mWWpRfp2CVwZM5rXMBdc5ah4vIC3gXEaexcjJ4eEgIlE049/
        TF2MXBxCArsZJZbvusQIkZCUmHbxKHMXIweQLSxx+HAxRM1bRonfW1+ANQsLhEg82/4JrFlE
        oIlJYlPvBbAEs0CkRM/cLWwQHVsYJbreLGECSbAJaEnsf3GDDcTmF1CUuPrjMdg2XgE7iRu3
        1oI1swioSvx4vAssLioQITHp2k4WiBpBiZMzn4DZnAJmEvcn7WWGWKYu8WfeJShbXOLWk/lM
        ELa8RPPW2cwTGIVnIWmfhaRlFpKWWUhaFjCyrGKUTC0ozk3PLTYsMMpLLdcrTswtLs1L10vO
        z93ECI4xLa0djCdOxB9iFOBgVOLhvaGkHyvEmlhWXJl7iFGCg1lJhPf2S6AQb0piZVVqUX58
        UWlOavEhRmkOFiVxXvn8Y5FCAumJJanZqakFqUUwWSYOTqkGxtWs/6uED0YJx5hfPKj17Lps
        5bX1Igkbs2ruGPZKuUh32M8sTrVatYL117/Sm921L8OfdDia5LUFlEVWXInx/Dx3guTVv1rN
        fy7G7O3hYXnT9eKznHxN/L0VbFe2xpy9dCBAuPZ06e2uSbHVf3z63oU7icacfLAjaN1S4ddP
        ei2L3vYKJNlVKbEUZyQaajEXFScCAB4DE6atAgAA
X-CMS-MailID: 20190718095310epcas1p31b048b8fd64ca3ff9b86b1a5f9f1415c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190707223611epcas1p4d1a36f169d3534c20aaeaec46d65f85c
References: <20190707223303.6755-1-digetx@gmail.com>
        <CGME20190707223611epcas1p4d1a36f169d3534c20aaeaec46d65f85c@epcas1p4.samsung.com>
        <20190707223303.6755-25-digetx@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19. 7. 8. 오전 7:33, Dmitry Osipenko wrote:
> I was contributing to the NVIDIA Tegra20+ devfreq drivers recently and
> want to help keep them working and evolving in the future.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  MAINTAINERS | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 95d4bd85df44..4e47ce737376 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10356,6 +10356,15 @@ F:	include/linux/memblock.h
>  F:	mm/memblock.c
>  F:	Documentation/core-api/boot-time-mm.rst
>  
> +MEMORY FREQUENCY SCALING DRIVERS FOR NVIDIA TEGRA
> +M:	Dmitry Osipenko <digetx@gmail.com>
> +L:	linux-pm@vger.kernel.org
> +L:	linux-tegra@vger.kernel.org
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mzx/devfreq.git
> +S:	Maintained
> +F:	drivers/devfreq/tegra20-devfreq.c
> +F:	drivers/devfreq/tegra30-devfreq.c
> +
>  MEMORY MANAGEMENT
>  L:	linux-mm@kvack.org
>  W:	http://www.linux-mm.org
> 

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
