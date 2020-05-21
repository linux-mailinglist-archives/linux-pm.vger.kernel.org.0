Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5D6B1DCCD4
	for <lists+linux-pm@lfdr.de>; Thu, 21 May 2020 14:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729043AbgEUM2v (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 May 2020 08:28:51 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:46922 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727983AbgEUM2v (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 May 2020 08:28:51 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200521122849euoutp017f9b75089208096f73b8e311f777fc02~RCuamG4_k3003330033euoutp01H
        for <linux-pm@vger.kernel.org>; Thu, 21 May 2020 12:28:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200521122849euoutp017f9b75089208096f73b8e311f777fc02~RCuamG4_k3003330033euoutp01H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1590064129;
        bh=vBvGj6yVvqPmrnQJqKFzoHCAcWR8PLLPXDMQj5rAEsg=;
        h=From:To:Cc:Subject:Date:References:From;
        b=nJWaVzrjUOh1nB2E7nj/LpV+y+KTZsOXDrKNB7FPNwNyDOg0eGhPjohaSG44j21HU
         HRfhMtUFVNCtAzujt3N1/quciUPlMttMP14te/XiyWqgV8XDrkA8H3CE0AcodQfpgf
         g4zkG9kileN6GBPr4ebS0PqSsz1dzv5qz5fEGpvo=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200521122848eucas1p2348735369f4dbe70ad1a3a91b0eb796a~RCuaTU06z2596525965eucas1p2a;
        Thu, 21 May 2020 12:28:48 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id D8.E3.61286.00476CE5; Thu, 21
        May 2020 13:28:48 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200521122848eucas1p27ce74486ea2044cb0b942b2619426e21~RCuaCSnFA2363023630eucas1p2-;
        Thu, 21 May 2020 12:28:48 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200521122848eusmtrp1459126053d931b29a3e895cac6282a50~RCuaBp_Nh2920829208eusmtrp1O;
        Thu, 21 May 2020 12:28:48 +0000 (GMT)
X-AuditID: cbfec7f2-ef1ff7000001ef66-ae-5ec67400d674
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id E4.8F.08375.00476CE5; Thu, 21
        May 2020 13:28:48 +0100 (BST)
Received: from AMDC3061.digital.local (unknown [106.120.51.75]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200521122848eusmtip23ca13617ce6c491920eb1698e3ac3651~RCuZjEaZP0357403574eusmtip2h;
        Thu, 21 May 2020 12:28:48 +0000 (GMT)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     georgi.djakov@linaro.org
Cc:     a.swigon@samsung.com, cw00.choi@samsung.com,
        b.zolnierkie@samsung.com, m.szyprowski@samsung.com,
        krzk@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH v5 0/3] interconnect: Support Samsung Exynos use-case
Date:   Thu, 21 May 2020 14:28:38 +0200
Message-Id: <20200521122841.8867-1-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFKsWRmVeSWpSXmKPExsWy7djPc7oMJcfiDM6sM7S4P6+V0WLjjPWs
        Fte/PGe1mL53E5vF+fMb2C0u75rDZvG59wijxYzz+5gs1h65y25x+E07qwOXx6ZVnWwed67t
        YfPo27KK0ePzJrkAligum5TUnMyy1CJ9uwSujJWX3jEV3BKqWNrXxdjA+J2vi5GTQ0LAROL4
        1QPsXYxcHEICKxgl7k36yAzhfGGU6N1yAcr5zCjxckMfK0zLv4MnoFqWM0rMuLKMEa7l453l
        bCBVbAKGEr1H+xhBbBEBGYk9TZNYQYqYBZqYJG4u3sACkhAWcJVYuu8bO4jNIqAqce3OVzCb
        V8BK4sHCW8wQ6+QlVm84wAwRF5Q4OfMJWC8zULx562yw+yQE5rFL7D97GqrBReLk+SVsELaw
        xKvjW9ghbBmJ05N7WCAamhklenbfZodwJjBK3D++gBGiylrizrlfQN0cQCs0Jdbv0gcxJQQc
        JZYtUoUw+SRuvBWEuIFPYtK26cwQYV6JjjYhiBkqEr9XTWeCsKUkup/8Z4GwPSQmrX0OtkdI
        IFbi+O85LBMYFWYh+WwWks9mIZywgJF5FaN4amlxbnpqsWFearlecWJucWleul5yfu4mRmAK
        Ov3v+KcdjF8vJR1iFOBgVOLhfZB8LE6INbGsuDL3EKMEB7OSCO9C/qNxQrwpiZVVqUX58UWl
        OanFhxilOViUxHmNF72MFRJITyxJzU5NLUgtgskycXBKNTDWZc076fO1et8e3au6WsYH9qRX
        Fa1Qtlr8oq/TWKvl0ZvZ7/Y8/+W6I/j1itVfW6OevEgUbci3Lqwu3dvtyv3407/2zsx9VoHf
        Nk6vsdue8uJwoqTN9cqfagnzipYLeBiqF+xt4chJ6bjVZHs2njfRtPFzWoDaw/PXN0hLmUau
        8VzUu1TvbKMSS3FGoqEWc1FxIgD5GryePQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCIsWRmVeSWpSXmKPExsVy+t/xe7oMJcfiDOZelbO4P6+V0WLjjPWs
        Fte/PGe1mL53E5vF+fMb2C0u75rDZvG59wijxYzz+5gs1h65y25x+E07qwOXx6ZVnWwed67t
        YfPo27KK0ePzJrkAlig9m6L80pJUhYz84hJbpWhDCyM9Q0sLPSMTSz1DY/NYKyNTJX07m5TU
        nMyy1CJ9uwS9jJWX3jEV3BKqWNrXxdjA+J2vi5GTQ0LAROLfwRPsXYxcHEICSxkltl74B+Rw
        ACWkJOa3KEHUCEv8udbFBmILCXxilNjzlRvEZhMwlOg92scIYosIyEjsaZrECjKHWaCHSeLM
        5wXsIAlhAVeJpfu+gdksAqoS1+58BbN5BawkHiy8xQyxQF5i9YYDzBBxQYmTM5+wgNzALKAu
        sX6eEEiYGaikeets5gmM/LOQVM1CqJqFpGoBI/MqRpHU0uLc9NxiQ73ixNzi0rx0veT83E2M
        wBjZduzn5h2MlzYGH2IU4GBU4uF9kHwsTog1say4MvcQowQHs5II70L+o3FCvCmJlVWpRfnx
        RaU5qcWHGE2BXpjILCWanA+M37ySeENTQ3MLS0NzY3NjMwslcd4OgYMxQgLpiSWp2ampBalF
        MH1MHJxSDYzTb3zpW3798fvErIlxszctNN0hOXGyj/gNgzch5dKiR39t5jy8v6H3uG/CVIUP
        gpcq1N5/OP33qvWmC8HHu27fdp6oZ9+9UnnF5ljumNkb/0+L3XEmT+Snf99129gLikfWms6R
        fr/tbvKzNw46F6/fk7vIvTrp6c6eDX3cSb2CfTmL7+cdjpTZoMRSnJFoqMVcVJwIAFD+4fmn
        AgAA
X-CMS-MailID: 20200521122848eucas1p27ce74486ea2044cb0b942b2619426e21
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200521122848eucas1p27ce74486ea2044cb0b942b2619426e21
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200521122848eucas1p27ce74486ea2044cb0b942b2619426e21
References: <CGME20200521122848eucas1p27ce74486ea2044cb0b942b2619426e21@eucas1p2.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi All,

This is a continuation of Artur's efforts to add interconnect and PM QoS
support for Exynos SoCs. Previous version of the patch set can be found 
at [1]. The only change comparing to v4 is an addition of missing 'static
inline' qualifier to the of_icc_get_from_provider() function stub, i.e.
addresing Georgi's review comments.

The patches have been tested on Odroid U3 (Exynos4412 SoC). 

Below is detailed description of the patch set as in v3.

                              ---------
Previously posted as a part of a larger RFC [2].

The Exynos SoC family relies on the devfreq driver for frequency
scaling. However, a means for programmatically enforcing QoS constraints
(i.e., minimum frequency) for devices is required. A solution which uses 
the interconnect framework to ensure QoS is currently being developed [2].

The exynos-bus hierarchy is composed of multiple buses which are probed
separately. Sometimes the DMC is even handled by a different driver.
Since the exynos-bus driver is generic and supports multiple differing
bus hierarchies, IDs for nodes (i.e. buses) are assigned dynamically. Due
to an unspecified relative probing order, every bus registers its own
interconnect provider.

Rationale for each patch in this series:
* Patch 01 (exporting of_icc_get_from_provider()) makes it easy to
  retrieve the parent node from the DT (cf. patch 05 in [2]).
* Patch 02 (allowing #interconnect-cells = <0>) allows to remove dummy
  node IDs from the DT.
* Patch 03 (allowing inter-provider node pairs) is necessary to make
  such multi-provider hierarchy work. A new approach implemented in v3
  ensures we will not cause regressions in any existing driver.

---
Changes since v3 (to patches in this series):
* Improve commit messages.
                              ---------

[1] https://lore.kernel.org/linux-pm/20200116144202.12116-4-a.swigon@samsung.com/T
[2] https://patchwork.kernel.org/patch/11305287/

--
Regards,
Sylwester


Artur Świgoń (3):
  interconnect: Export of_icc_get_from_provider()
  interconnect: Relax requirement in of_icc_get_from_provider()
  interconnect: Allow inter-provider pairs to be configured

 drivers/interconnect/core.c           | 16 ++++++++--------
 include/linux/interconnect-provider.h |  8 ++++++++
 2 files changed, 16 insertions(+), 8 deletions(-)

-- 
2.7.4

