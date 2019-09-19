Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 181FAB7C20
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2019 16:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390462AbfISOXa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Sep 2019 10:23:30 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:46486 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390547AbfISOXa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Sep 2019 10:23:30 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190919142329euoutp0164848637ac5a6507ea9c212502a63d17~F3Pl1KcRA2200122001euoutp017
        for <linux-pm@vger.kernel.org>; Thu, 19 Sep 2019 14:23:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190919142329euoutp0164848637ac5a6507ea9c212502a63d17~F3Pl1KcRA2200122001euoutp017
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1568903009;
        bh=+PvoXwVxpcTid0j87bA2tcY3zWf42daZc3R0G6YTUlc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YxU38emjcGVQXoG7BBxxjU8OxRTWPhHrofsGqWdJJ5T+JZTdqHHOQdH0Ij3/Fc45R
         +heUQJNlZxQJdnrZjnnToCF4mevVw5xIBuD80meKIBNlv1X9K+HY5lUN25QIbP5Owg
         3biDrNLgmzWkTkYfPjvjRY0L/lywB2zOTjUQV/uk=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190919142328eucas1p242dc467060e42704b69ed7f086bbb466~F3Pk2708H3081730817eucas1p2s;
        Thu, 19 Sep 2019 14:23:28 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 51.69.04374.F5F838D5; Thu, 19
        Sep 2019 15:23:27 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190919142327eucas1p183470eede07b50c1e3acda58f2af1eba~F3PkEGT6Y0295602956eucas1p1S;
        Thu, 19 Sep 2019 14:23:27 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190919142326eusmtrp164d5d419c24ac75e6ccfb6e7a3e4ca01~F3Pju1HxD0555105551eusmtrp1b;
        Thu, 19 Sep 2019 14:23:26 +0000 (GMT)
X-AuditID: cbfec7f5-4ddff70000001116-06-5d838f5f5030
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 53.1F.04166.E5F838D5; Thu, 19
        Sep 2019 15:23:26 +0100 (BST)
Received: from AMDC3555.digital.local (unknown [106.120.51.67]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190919142326eusmtip10794ddcef50859ab7030e7943910eeb3~F3Pi4fy-a3274232742eusmtip1p;
        Thu, 19 Sep 2019 14:23:25 +0000 (GMT)
From:   =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@samsung.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@partner.samsung.com>,
        cw00.choi@samsung.com, myungjoo.ham@samsung.com,
        inki.dae@samsung.com, sw0312.kim@samsung.com,
        georgi.djakov@linaro.org, leonard.crestez@nxp.com,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com, krzk@kernel.org
Subject: [RFC PATCH v2 07/11] interconnect: Relax condition in
 apply_constraints()
Date:   Thu, 19 Sep 2019 16:22:32 +0200
Message-Id: <20190919142236.4071-8-a.swigon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190919142236.4071-1-a.swigon@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUyMcRzA/Z63e665PHeX9V2Muo2NTcnrzxjCeOav2vpLwqlnV9Od3KMS
        f0iJIsnd0vWily1JadzpLC055zgvy7myQqUMM2+hLpt3XU/ov8/35fP7fr/bjyVVz+gQNtmw
        VzAatCkaJoC6cvurZ8H2kznxC4c8kdh52y7DA5W5CFstF2nc43tN4yrXAxo/Gv3I4JJrNgab
        Booo7PFckuH6/s80tr3opnFXawWDR064ELZ42gnc5OqX4d5D9Qy2mN8wa5W8rSGf4fu62xh+
        4Lib4C/XHuStQy0Ef2OojeALmxsQP2KbFc1uCViVKKQkpwvGiNU7ApLqb5ynU7+y+6y9ZUQW
        qpMdQ3IWuCXgrLlF+1nF1SMY/Bx9DAWMsQ9BfrdFJgUjCNoch+m/Rof1PS0VziG4l/uE/Kc0
        F3dS/i6GiwJT8eC4HsS5EJirP1L+gORqCSgs94wpLKvmYqEmP9gvUNwcyM/zIj8rOAxeexOS
        xs2GxksO0s9ybgX42qsoqUcJd0tfjjM51pNjLx/fArhcFn58v0NI8gZwvGsnJVbDW3fzxNUz
        4b65gJJYhFdXB2hJzkJgq3NNCCvhpttL+xcluXlwsTVCSkfBBdt5wp8GLhAef1BKOwSC6UoJ
        KaUVkHdEJaEGWksDJREgu7F74m0eOiz9ZBEKK5t0TNmkY8r+j61GZAMKFtJEvU4QFxuEjHBR
        qxfTDLrwhN16Gxr7dfd/uUdbUPuPnU7EsUgzVRGakROvorXpYqbeiYAlNUGKiqXZ8SpFojZz
        v2Dcvd2YliKITjSDpTTBigNTBuNUnE67V9glCKmC8W+VYOUhWWhbUtSydHVP7KKCCkdcj9Pj
        mu9+WLLpi3IOzptuT35auk4p937riswo3Dh8pjchFhc8PGka/mmN7pC99a5PnNnsDPUlx5r3
        NM1K/9ZoCdUXdyxWBS2/HvpcPe3U3K47dZ8qz3pqj8adztL9Nses6TwaY9hSvLnPsFUpP7To
        Z1hd0BENJSZpI+eTRlH7ByHvRX9xAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKIsWRmVeSWpSXmKPExsVy+t/xu7px/c2xBi/mG1scOraV3eL+vFZG
        i40z1rNaXP/ynNVi/pFzrBZXvr5ns5i+dxObxaT7E1gszp/fwG6x4u5HVotNj6+xWlzeNYfN
        4nPvEUaLGef3MVmsPXKX3eJ24wo2ixmTX7I5CHpsWtXJ5nHn2h42j/vdx5k8Ni+p99j4bgeT
        x8F3e5g8+rasYvT4vEkugCNKz6Yov7QkVSEjv7jEVina0MJIz9DSQs/IxFLP0Ng81srIVEnf
        ziYlNSezLLVI3y5BL2PFwZWsBT85KjbensXUwLiMvYuRk0NCwETi7MY3rF2MXBxCAksZJe48
        PcIMkZCQ+Lj+BiuELSzx51oXG0TRJ0aJv3famUASbAKOEpOmPmAHSYgInGKU2Lr8HFgVs8AG
        JonlT1+CtQsLBEkcv3sezGYRUJXo7LjICGLzClhIXNy6lhFihbzE6g0HwFZzClhKfNk3nwXE
        FgKqmft4LlS9oMTJmU+A4hxAC9Ql1s8TAgkzA7U2b53NPIFRcBaSqlkIVbOQVC1gZF7FKJJa
        WpybnltsqFecmFtcmpeul5yfu4kRGMXbjv3cvIPx0sbgQ4wCHIxKPLwK5c2xQqyJZcWVuYcY
        JTiYlUR455g2xQrxpiRWVqUW5ccXleakFh9iNAV6bSKzlGhyPjDB5JXEG5oamltYGpobmxub
        WSiJ83YIHIwREkhPLEnNTk0tSC2C6WPi4JRqYJwpV9W1y7wkYfp8hfiW078fvuljPDbRZ8W+
        +W1T2wJ6r/Iuz3DieZfOe/CN8xomk8DDF2Z6JLUf4T9dcVn/j5Aa65GVl/+JLl+1J2WvnPTp
        e8vOH331T31yReisO2n77MwOh+ZHPeBmT3LVeZPkc35bjf0pJ8bfUawtN83X9fn4Mtl853vq
        X6fEUpyRaKjFXFScCADxKStz+AIAAA==
X-CMS-MailID: 20190919142327eucas1p183470eede07b50c1e3acda58f2af1eba
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190919142327eucas1p183470eede07b50c1e3acda58f2af1eba
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190919142327eucas1p183470eede07b50c1e3acda58f2af1eba
References: <20190919142236.4071-1-a.swigon@samsung.com>
        <CGME20190919142327eucas1p183470eede07b50c1e3acda58f2af1eba@eucas1p1.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Artur Świgoń <a.swigon@partner.samsung.com>

The exynos-bus devfreq driver is extended with interconnect functionality
by a subsequent patch. This patch removes a check from the interconnect
framework that prevents interconnect from working on exynos-bus, in which
every bus is a separate interconnect provider.

Signed-off-by: Artur Świgoń <a.swigon@partner.samsung.com>
---
 drivers/interconnect/core.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index f357c3a78858..e8243665d5ba 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -224,11 +224,8 @@ static int apply_constraints(struct icc_path *path)
 	for (i = 0; i < path->num_nodes; i++) {
 		next = path->reqs[i].node;
 
-		/*
-		 * Both endpoints should be valid master-slave pairs of the
-		 * same interconnect provider that will be configured.
-		 */
-		if (!prev || next->provider != prev->provider) {
+		/* both endpoints should be valid master-slave pairs */
+		if (!prev) {
 			prev = next;
 			continue;
 		}
-- 
2.17.1

