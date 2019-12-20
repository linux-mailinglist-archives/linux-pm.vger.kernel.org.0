Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F26DE127A94
	for <lists+linux-pm@lfdr.de>; Fri, 20 Dec 2019 13:02:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727436AbfLTMBq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 20 Dec 2019 07:01:46 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:36396 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727395AbfLTMBq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 20 Dec 2019 07:01:46 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20191220120144euoutp01dd8a06b090b20e6760673edabb67c73b~iEqGClhe-0861508615euoutp01f
        for <linux-pm@vger.kernel.org>; Fri, 20 Dec 2019 12:01:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20191220120144euoutp01dd8a06b090b20e6760673edabb67c73b~iEqGClhe-0861508615euoutp01f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1576843304;
        bh=s4kRbuQ3Hb8eo8oQqLWyy6KxuzGwfImAAZepS0JGEVw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C7YGZZ9X3oOkC9IHHnryqxDrUlNIjbhS+5eSAI9R46gjfuKmFJJqkq/ADaBJkIEUK
         9IzI92N9KY3JCYvRKV3+rRx1C0DrEB7fjifa0pY91BSlw8eoRg/yFksNREB3N6jHMO
         mi0bVbW4BOTAWR7zbsiGxxTcfVqEvCdRP7hbZ65M=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20191220120144eucas1p255f58b670015246946f49606b925c015~iEqFsC3AQ2385123851eucas1p2J;
        Fri, 20 Dec 2019 12:01:44 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 72.3E.60698.728BCFD5; Fri, 20
        Dec 2019 12:01:43 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20191220120143eucas1p1c9b01ae8c2e4ecd70423ef9d8001536f~iEqFPIy1T1904419044eucas1p1N;
        Fri, 20 Dec 2019 12:01:43 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191220120143eusmtrp2b884f64582ad1d849e0567c67ef48dca~iEqFOgpKV2149121491eusmtrp2v;
        Fri, 20 Dec 2019 12:01:43 +0000 (GMT)
X-AuditID: cbfec7f5-a0fff7000001ed1a-45-5dfcb8272004
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id B0.68.07950.728BCFD5; Fri, 20
        Dec 2019 12:01:43 +0000 (GMT)
Received: from AMDC3555.digital.local (unknown [106.120.51.67]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191220120142eusmtip2ad17b9c1cc2c8795cf1c39a213e1ea8a~iEqEZKDP12783527835eusmtip2u;
        Fri, 20 Dec 2019 12:01:42 +0000 (GMT)
From:   =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@samsung.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@samsung.com>,
        cw00.choi@samsung.com, myungjoo.ham@samsung.com,
        inki.dae@samsung.com, sw0312.kim@samsung.com,
        georgi.djakov@linaro.org, leonard.crestez@nxp.com,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com, krzk@kernel.org
Subject: [RFC PATCH v3 3/7] interconnect: Allow inter-provider pairs to be
 configured
Date:   Fri, 20 Dec 2019 12:56:49 +0100
Message-Id: <20191220115653.6487-4-a.swigon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191220115653.6487-1-a.swigon@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTYRjG+XZ2zi40OU2pF7tIg6ikK4V8lYiWxKGgyz8FhdXSk4s5jR0v
        WUGaaVMxZFKzaRdNUqalzgu2Sm2NRlSTZq2B2kyzYbSiVEgd1raT1X+/732f53veF14xIe8n
        I8Wn0jNZbboyTUFJhZ3Pph3rVnX5kzY6LRh7bhYi3FrZTOJ3k14S37I5SPxm6huFDY/NFNZ7
        yoW4r69FhBuGvpPYPOoicb+lmsITZTaEK/u6BfiebUiEB/IbKFxZMU7F04zZVEwxg65HFOMp
        tQuYtroLTOvXLgFzpd2EmAnz8v2iw9LYFDbtVDar3RB3XKoq7C2iTt+JOPPTWk3moRa6BEnE
        QG+BmqYeKshyugFB4+XVPE8ieNe7twRJAzyBwOW6JJo3dLZ2iPhGPQJTswH9dRQ9lAaZohNA
        f3U4JIqgbQgqbn8TBh8EXS0AXXG9MKgKpw/BeM2XEAvplfD4SW1oDhmNoarVTfFxUdDY0ksE
        WUJvBfdbJ8FrFsLz6x9DXiKgKeioIoIBQE+JQFdrJ3lzIhhmRhDP4fDZ3v5nh6Xw68EtAc8c
        jD3wkLw5D4H5ro3gG9th0DETmEIcSFgDzZYNfDkBHK58UbAMdBi4fQv5GcJA32kg+LIMdEVy
        HhVguR7GGwEuNrr+/M1Apc2IytEK43/LGP9bxvgv9jYiTGgxm8VpUlluczqbs55Taris9NT1
        yRkaMwqc2os5+1QX6vafsCJajBQLZPEnZ5PkpDKby9VYEYgJRYRsQDedJJelKHPPstqMY9qs
        NJazoiVioWKxbHPteJKcTlVmsmqWPc1q57sCsSQyD2V4o/w73QVl9w/cHRmJO+hz1znvvbZ9
        6Xz5vHh3GErO8ZvWDvtKb/Rf23XuqPepZXSqeU/kud0bf8yu0nuzPlgPH6GSU+qqdLHl25ZJ
        nvWo7F/3VbXlNKli/D1qa7exfSCGXpDIjM3FIHX7q/evfQnRn87ueLLomM9xfjjaWaNmFEJO
        pdwUTWg55W8CpCNgZgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJIsWRmVeSWpSXmKPExsVy+t/xe7rqO/7EGrTvkrK4P6+V0WLjjPWs
        Fte/PGe1mH/kHKvFla/v2Sym793EZjHp/gQWi/PnN7BbrLj7kdVi0+NrrBaXd81hs/jce4TR
        Ysb5fUwWa4/cZbe43biCzWLG5JdsDgIem1Z1snncubaHzeN+93Emj81L6j02vtvB5NG3ZRWj
        x+dNcgHsUXo2RfmlJakKGfnFJbZK0YYWRnqGlhZ6RiaWeobG5rFWRqZK+nY2Kak5mWWpRfp2
        CXoZrQfa2AoWi1T8ODSHtYFxg0AXIyeHhICJxLaNW9m7GLk4hASWMkocurOJESIhIfFx/Q1W
        CFtY4s+1LjaIok+MEn29S9hBEmwCjhKTpj4A6xYROMUosXX5OTaQBLPACiaJ/jnCXYwcHMIC
        oRIr25NAwiwCqhJ7Dy4CK+EVsJCYvfEGG8QCeYnVGw4wg9icApYSN65eArOFgGp2fu5jgqgX
        lDg58wkLyEhmAXWJ9fOEIDbJSzRvnc08gVFwFpKqWQhVs5BULWBkXsUoklpanJueW2ykV5yY
        W1yal66XnJ+7iREYrduO/dyyg7HrXfAhRgEORiUeXoe037FCrIllxZW5hxglOJiVRHhvd/yM
        FeJNSaysSi3Kjy8qzUktPsRoCvTaRGYp0eR8YCLJK4k3NDU0t7A0NDc2NzazUBLn7RA4GCMk
        kJ5YkpqdmlqQWgTTx8TBKdXA6KN24Oe94n9n305TaP6lvKi+e70Mm4/mpg/Z6guurRBk6eWb
        9kfy0Zfej9bqX3M+z55i/HnVinK5O9rdD73LMz5m3T34PyQrhVFwaq2Um0vrq2sXXbIt1X8+
        fXy+SfpFwp54mT+/tojcFejuejk5I6b1bbQFh/80e9Ed917fLXyWtORD301uQyWW4oxEQy3m
        ouJEAA8iFKbsAgAA
X-CMS-MailID: 20191220120143eucas1p1c9b01ae8c2e4ecd70423ef9d8001536f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20191220120143eucas1p1c9b01ae8c2e4ecd70423ef9d8001536f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191220120143eucas1p1c9b01ae8c2e4ecd70423ef9d8001536f
References: <20191220115653.6487-1-a.swigon@samsung.com>
        <CGME20191220120143eucas1p1c9b01ae8c2e4ecd70423ef9d8001536f@eucas1p1.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

In the exynos-bus devfreq driver every bus is probed separately and is
assigned a separate interconnect provider. However, the interconnect
framework does not call the '->set' callback for pairs of nodes which
belong to different providers.

This patch adds support for a new boolean 'inter_set' field in struct
icc_provider. Setting it to 'true' enables calling '->set' for
inter-provider node pairs. All existing users of the interconnect
framework allocate this structure with kzalloc, and are therefore
unaffected.

Signed-off-by: Artur Świgoń <a.swigon@samsung.com>
---
 drivers/interconnect/core.c           | 11 +++++------
 include/linux/interconnect-provider.h |  2 ++
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index 74c68898a350..a28bd0f8a497 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -259,23 +259,22 @@ static int aggregate_requests(struct icc_node *node)
 static int apply_constraints(struct icc_path *path)
 {
 	struct icc_node *next, *prev = NULL;
+	struct icc_provider *p;
 	int ret = -EINVAL;
 	int i;
 
 	for (i = 0; i < path->num_nodes; i++) {
 		next = path->reqs[i].node;
+		p = next->provider;
 
-		/*
-		 * Both endpoints should be valid master-slave pairs of the
-		 * same interconnect provider that will be configured.
-		 */
-		if (!prev || next->provider != prev->provider) {
+		/* both endpoints should be valid master-slave pairs */
+		if (!prev || (p != prev->provider && !p->inter_set)) {
 			prev = next;
 			continue;
 		}
 
 		/* set the constraints */
-		ret = next->provider->set(prev, next);
+		ret = p->set(prev, next);
 		if (ret)
 			goto out;
 
diff --git a/include/linux/interconnect-provider.h b/include/linux/interconnect-provider.h
index cc965b8fab53..b6ae0ee686c5 100644
--- a/include/linux/interconnect-provider.h
+++ b/include/linux/interconnect-provider.h
@@ -41,6 +41,7 @@ struct icc_node *of_icc_xlate_onecell(struct of_phandle_args *spec,
  * @xlate: provider-specific callback for mapping nodes from phandle arguments
  * @dev: the device this interconnect provider belongs to
  * @users: count of active users
+ * @inter_set: whether inter-provider pairs will be configured with @set
  * @data: pointer to private data
  */
 struct icc_provider {
@@ -53,6 +54,7 @@ struct icc_provider {
 	struct icc_node* (*xlate)(struct of_phandle_args *spec, void *data);
 	struct device		*dev;
 	int			users;
+	bool			inter_set;
 	void			*data;
 };
 
-- 
2.17.1

