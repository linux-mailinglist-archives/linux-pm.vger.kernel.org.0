Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 249B3127A7F
	for <lists+linux-pm@lfdr.de>; Fri, 20 Dec 2019 13:01:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbfLTMBo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 20 Dec 2019 07:01:44 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:36372 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727281AbfLTMBn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 20 Dec 2019 07:01:43 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20191220120142euoutp0174c348856914893e07d4f4ca16dbda0e~iEqEcpj9X1021410214euoutp01B
        for <linux-pm@vger.kernel.org>; Fri, 20 Dec 2019 12:01:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20191220120142euoutp0174c348856914893e07d4f4ca16dbda0e~iEqEcpj9X1021410214euoutp01B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1576843302;
        bh=gGDgaeou7mugSh38EJgLmUfO6gmmRUW2noLrg7o4IwE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OE5Wz3qNfrJQTwXDcmfWX/oSTO2WqZYC8Uknd68xzf06hhZqIfemg0qAnAyFs7EjS
         OdhcHhZ2T84XiUKlTj//6Wykef1NQmFmfzPmO/wcPYBJFThhsJQTgjg3RhBNPH+Q68
         jMaOkymQ5LvOW4dKrYtGuSZK6tixShjqnr0QdA9w=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20191220120142eucas1p26044b2bc3c1fca412abad1ea33b73a92~iEqD7ln7C2935829358eucas1p22;
        Fri, 20 Dec 2019 12:01:42 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 8F.84.60679.628BCFD5; Fri, 20
        Dec 2019 12:01:42 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20191220120141eucas1p11f5fa9d76d17e80e06199cb7a911c482~iEqDolbst2484524845eucas1p13;
        Fri, 20 Dec 2019 12:01:41 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191220120141eusmtrp21b472949b61d003dee5e5352ab3edc7b~iEqDnz0sz2149221492eusmtrp2r;
        Fri, 20 Dec 2019 12:01:41 +0000 (GMT)
X-AuditID: cbfec7f4-0e5ff7000001ed07-1a-5dfcb82666c3
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 9E.58.07950.528BCFD5; Fri, 20
        Dec 2019 12:01:41 +0000 (GMT)
Received: from AMDC3555.digital.local (unknown [106.120.51.67]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191220120140eusmtip29e07a574c6cc1c448fbf0f95b228c34d~iEqC1iVgJ2950829508eusmtip2P;
        Fri, 20 Dec 2019 12:01:40 +0000 (GMT)
From:   =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@samsung.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@samsung.com>,
        cw00.choi@samsung.com, myungjoo.ham@samsung.com,
        inki.dae@samsung.com, sw0312.kim@samsung.com,
        georgi.djakov@linaro.org, leonard.crestez@nxp.com,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com, krzk@kernel.org
Subject: [RFC PATCH v3 1/7] interconnect: Export of_icc_get_from_provider()
Date:   Fri, 20 Dec 2019 12:56:47 +0100
Message-Id: <20191220115653.6487-2-a.swigon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191220115653.6487-1-a.swigon@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRjm27lqTo5T8KWL0cqiTO0i8UkXEiQO+acgAq1lSw9qObUdteyP
        lzK8VIqRlxVqaWmuUmeaDhMbyxmZiy4rUFNKSYWUcgmaaG5nXf497/O8z/u878fHEgobtZJN
        SEoVtEnqRCXtTrb1zFkDN7YvqLZ1XGLxcGUuws3ljRT+YP9K4SpzP4Xf/ZymcdlTA41LhotJ
        bLU2Mbh+6DuFDV9sFH5rvEXjmatmhMutXTL80DzE4IHsehqXX5+g93O8oSGf5gdtnTQ/XGiR
        8S21mXzzVLuMv/a4AfEzBr9DTJT7nlghMSFd0AbvO+ke3z6qp1JaufNXvr5mslCOZwFyY4EL
        gRH9PFGA3FkFV49AVzNHSoUdQdWnalcxg6A7t4j8Y7GUvHAJdQiKHtwn/lp6O3NpRxfNhUHJ
        jRHGIfhwZgTXq6edFoK7JYO8/DrnLG8uAnRzo4QDk5w/6LpeMg4s5zB05NoJKW8t6Ju6ndiN
        C4WP798QUo8XvKgYdc4hlnsutt50rgHcdwaarIWMZA6HqW/dSMLeMGl57OJXw1JHlUzCIox1
        DFOSOQuB4Z7ZlbwbBvvnl+9hlxM2Q6MxWKLDoKDyOemggfOEj9+8pB08oaStjJBoOeRdVkhQ
        CcYK12MD5Ohtrtk8ZPWMUMVone6/Y3T/HaP7F1uNiAbkK6SJmjhB3JEknAsS1RoxLSkuKCZZ
        Y0DLv+3losXejowLp0yIY5HSQz4e80uloNTpYobGhIAllD7ygbw5lUIeq864IGiTo7VpiYJo
        QqtYUukr33lnQqXg4tSpwhlBSBG0f1QZ67YyC5EHSm+ELkW0FFypWjNdU1t3+jZ/dNKHqjke
        ebcvu3QgIKQ0W7WrxRbT45XgvylA5UFF3SaCTkSPawbOi+uPeBFlpp1H/fYefrYq88nU1iL1
        h0DdodnwyLQf5SsKmbNNwZUHczaMnbTNvppcnO+Nx5+PDeELer7H1GZ45FuXoeizK0kxXr19
        C6EV1b8BvDpsi2kDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJIsWRmVeSWpSXmKPExsVy+t/xe7qqO/7EGjSt17O4P6+V0WLjjPWs
        Fte/PGe1mH/kHKvFla/v2Sym793EZjHp/gQWi/PnN7BbrLj7kdVi0+NrrBaXd81hs/jce4TR
        Ysb5fUwWa4/cZbe43biCzWLG5JdsDgIem1Z1snncubaHzeN+93Emj81L6j02vtvB5NG3ZRWj
        x+dNcgHsUXo2RfmlJakKGfnFJbZK0YYWRnqGlhZ6RiaWeobG5rFWRqZK+nY2Kak5mWWpRfp2
        CXoZO56sZi3YKlDR8/wCewNjE18XIyeHhICJxPFJJ1lAbCGBpYwSDx7VQMQlJD6uv8EKYQtL
        /LnWxdbFyAVU84lRoutCJxtIgk3AUWLS1AfsIAkRgVOMEluXnwNLMAusYJLonyMMYgsLeEvM
        +vmEGcRmEVCVmLXvNDuIzStgIbGz9QszxAZ5idUbDoDZnAKWEjeuXmKGuAio5nMfE0S9oMTJ
        mU+ALuUAmq8usX6eEMQqeYnmrbOZJzAKzkJSNQuhahaSqgWMzKsYRVJLi3PTc4uN9IoTc4tL
        89L1kvNzNzECo3XbsZ9bdjB2vQs+xCjAwajEw+uQ9jtWiDWxrLgy9xCjBAezkgjv7Y6fsUK8
        KYmVValF+fFFpTmpxYcYTYFem8gsJZqcD0wkeSXxhqaG5haWhubG5sZmFkrivB0CB2OEBNIT
        S1KzU1MLUotg+pg4OKUaGFNMDrwzl2WamDZ/geBdq6Q36xpeX/dXtNdOehB7SnHC0ZPZi8y3
        TJ0kbPfU5GNWvUyTdL/mhu0yj5d8PrD5tG+vaco0zxfh6w3Pr+k71Lv7r/3h8/5OpRI9G9QD
        nrg7xvE2fI5PP74kZVXsjAZr7h6JB7GyQsXv88xiv6Y8Pn/4olrw6SoFYyWW4oxEQy3mouJE
        AIoeLovsAgAA
X-CMS-MailID: 20191220120141eucas1p11f5fa9d76d17e80e06199cb7a911c482
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20191220120141eucas1p11f5fa9d76d17e80e06199cb7a911c482
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191220120141eucas1p11f5fa9d76d17e80e06199cb7a911c482
References: <20191220115653.6487-1-a.swigon@samsung.com>
        <CGME20191220120141eucas1p11f5fa9d76d17e80e06199cb7a911c482@eucas1p1.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch makes the above function public (for use in exynos-bus devfreq
driver).

Signed-off-by: Artur Świgoń <a.swigon@samsung.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/interconnect/core.c           | 3 ++-
 include/linux/interconnect-provider.h | 6 ++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index 63c164264b73..e6035c199369 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -330,7 +330,7 @@ EXPORT_SYMBOL_GPL(of_icc_xlate_onecell);
  * Returns a valid pointer to struct icc_node on success or ERR_PTR()
  * on failure.
  */
-static struct icc_node *of_icc_get_from_provider(struct of_phandle_args *spec)
+struct icc_node *of_icc_get_from_provider(struct of_phandle_args *spec)
 {
 	struct icc_node *node = ERR_PTR(-EPROBE_DEFER);
 	struct icc_provider *provider;
@@ -349,6 +349,7 @@ static struct icc_node *of_icc_get_from_provider(struct of_phandle_args *spec)
 
 	return node;
 }
+EXPORT_SYMBOL_GPL(of_icc_get_from_provider);
 
 /**
  * of_icc_get() - get a path handle from a DT node based on name
diff --git a/include/linux/interconnect-provider.h b/include/linux/interconnect-provider.h
index 0c494534b4d3..cc965b8fab53 100644
--- a/include/linux/interconnect-provider.h
+++ b/include/linux/interconnect-provider.h
@@ -103,6 +103,7 @@ void icc_node_del(struct icc_node *node);
 int icc_nodes_remove(struct icc_provider *provider);
 int icc_provider_add(struct icc_provider *provider);
 int icc_provider_del(struct icc_provider *provider);
+struct icc_node *of_icc_get_from_provider(struct of_phandle_args *spec);
 
 #else
 
@@ -154,6 +155,11 @@ static inline int icc_provider_del(struct icc_provider *provider)
 	return -ENOTSUPP;
 }
 
+struct icc_node *of_icc_get_from_provider(struct of_phandle_args *spec)
+{
+	return ERR_PTR(-ENOTSUPP);
+}
+
 #endif /* CONFIG_INTERCONNECT */
 
 #endif /* __LINUX_INTERCONNECT_PROVIDER_H */
-- 
2.17.1

