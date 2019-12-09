Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4177B116F6D
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2019 15:45:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727936AbfLIOow (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Dec 2019 09:44:52 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:53806 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727913AbfLIOoo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Dec 2019 09:44:44 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20191209144443euoutp026060cd75772f4e79d72ae24085771e30~euyQgBa9h2421224212euoutp02I
        for <linux-pm@vger.kernel.org>; Mon,  9 Dec 2019 14:44:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20191209144443euoutp026060cd75772f4e79d72ae24085771e30~euyQgBa9h2421224212euoutp02I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1575902683;
        bh=WzxcJ59gNp8il6neN2DdkauTkF314FsLCY6M8Z2mAPo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xo4Pkq5p94MZjF1xE9mpkIO18EK9iRU49ssF4tlWcSL9Unfhd3vKVESAaq5BqCdsy
         62hrOxKsya/XqfyZW1d99XwedhXSMhJEctU9Q3m7Y/lEN8dc7oWp7l3jC4nw0w7e25
         dER8pu4ihe3Q+0CAdtVRQmM3Jlv/CbRRTNcmewPA=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191209144443eucas1p13af02c6d9c3ee96923731419cac4d131~euyQO_GzB1796517965eucas1p1M;
        Mon,  9 Dec 2019 14:44:43 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id FF.28.60698.BDD5EED5; Mon,  9
        Dec 2019 14:44:43 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20191209144442eucas1p214c553519b7a9d3d005802984bc6fb31~euyP5moCq1662616626eucas1p2w;
        Mon,  9 Dec 2019 14:44:42 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191209144442eusmtrp2c0d5e4c9bda2feaf9c4b23e408e4bc1b~euyP4-lhL2834828348eusmtrp2m;
        Mon,  9 Dec 2019 14:44:42 +0000 (GMT)
X-AuditID: cbfec7f5-a0fff7000001ed1a-18-5dee5ddb09d1
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 67.09.08375.ADD5EED5; Mon,  9
        Dec 2019 14:44:42 +0000 (GMT)
Received: from AMDC3218.digital.local (unknown [106.120.51.18]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191209144442eusmtip2429bc4ca617da4080f05b8994f119bcd~euyPYHo0o1707917079eusmtip2E;
        Mon,  9 Dec 2019 14:44:42 +0000 (GMT)
From:   Kamil Konieczny <k.konieczny@samsung.com>
To:     k.konieczny@samsung.com
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: [PATCH 4/4] PM / devfreq: use delayed work if DEVFREQ_DELAYED_TIMER
 set
Date:   Mon,  9 Dec 2019 15:44:25 +0100
Message-Id: <20191209144425.13321-5-k.konieczny@samsung.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191209144425.13321-1-k.konieczny@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SfSxVcRje757Pa107DuWNYt1NXytqWjtFTcuWrLZqba3aTUfOfMSle3xd
        f1GtizBKEoasibtQ0lW3xeJGCLO2Utj8kYmQr/KRjxyH8t/zPu/zPO/7bi+NsXmEAx2sjRR0
        Wj5UTVrhpoaZtt1dmhHNnp/tJPcsu4LgPk/2E1zheDbBtbc/pbjW60MU99GcR3ITqRbElVl6
        KK4roYT0UvpUGpNIn7QqI/KZqHQ6hV2w8gwQQoOjBZ3b4ctWQWVF+VSEkYpdXDBT8aiYTEZK
        Gph9YEptx5ORFc0yJQj6R6couZhEYOqYJOViAkFDy3ds1TLfl6+QMMs8RmA0Rv9zZBUbl3NJ
        xg3etjbhErZjHCGpKEMhiTCmQQHmunlCatgyZ6CzZw4lI5rGGReoN1yUaBXjCfdmc0mJBsYZ
        8oa3S7SSOQQ/xjIxWWIDTQ++LcdjS5IbL3IxKR6Y2xSUvl/1ekNmX4i8sy0MNlZRMt4Ei68K
        FDKOgb6HaZTsvYmg1zCGyw0PqG/sIKQcjNkBFWY3mT4Cid3NK/HW0DlsI69gDXdM9zGZVkHi
        LVZWu0B/c8rKJEdIXiwnZOwDiePNZDrakrPmmJw1x+T8n1uIMCOyF6LEsEBBdNcKMa4iHyZG
        aQNdr4SHVaKln2lZaPz1EtXM+dchhkbqdapCrxENS/DRoj6sDgGNqe1UjzIGNawqgNfHCbpw
        P11UqCDWIUcaV9ur3IsGNCwTyEcKVwUhQtCtdhW00iEe6S8ZjrGntXHXSrd2/x56c6AzKISZ
        tgTM2tfo//CxparX1fr1eRW16tqNLh71fRlnfYdHWr/g+w+ajNXZd9+p56bavP0LnI5W+qpP
        1CTM4B98v5Z/ck6f9gvcYM5IFLV2w71Pelli4CT/fJez2dFi2JxSMHp+sTrrXOq0tyF923E1
        Lgbxe3diOpH/C3TZ/QQvAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupikeLIzCtJLcpLzFFi42I5/e/4Pd1bse9iDQ491LLYOGM9q8X1L89Z
        LRZ8msFqcf78BnaLs01v2C0u75rDZvG59wijxdojd9ktbjeuYHPg9Ni0qpPNo2/LKkaPz5vk
        Apij9GyK8ktLUhUy8otLbJWiDS2M9AwtLfSMTCz1DI3NY62MTJX07WxSUnMyy1KL9O0S9DLW
        LprHXrCKveL/v13sDYzL2LoYOTkkBEwk/j6dxwRiCwksZZT41aoOEZeWaDy9mgnCFpb4c60L
        qJ4LqOYTo0T3gVUsIAk2AX2Jg2dPgtkiQA2diyaCNTALnGGS+NVSAWILCwRIbLl4HyjOwcEi
        oCpxuD0aJMwrYCMx9ddsNpCwhIC8xJy3GiBhTgFbidcfpzBDnGMj0f7/PwtEuaDEyZlPWCCm
        y0s0b53NPIFRYBaS1CwkqQWMTKsYRVJLi3PTc4sN9YoTc4tL89L1kvNzNzEC42HbsZ+bdzBe
        2hh8iFGAg1GJh3eBw7tYIdbEsuLK3EOMEhzMSiK8Sya+ihXiTUmsrEotyo8vKs1JLT7EaAr0
        wkRmKdHkfGCs5pXEG5oamltYGpobmxubWSiJ83YIHIwREkhPLEnNTk0tSC2C6WPi4JRqYPSr
        Oda76EqBsk9XX3Ai5649bK0+hklsRzQty6zTt/NezX11MSHlm6V0URhLzVLGKUuuz14apMLA
        uvmnn4qUz2ZDm82M5pNFJmQY29aWpdm8/W7aIs59jG3rTFetMLkdR7bEnnZr3bWxe476co1G
        x12J1ln77lQZVExzqgvby3XwxEOLTdsvKrEUZyQaajEXFScCABkg26udAgAA
X-CMS-MailID: 20191209144442eucas1p214c553519b7a9d3d005802984bc6fb31
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20191209144442eucas1p214c553519b7a9d3d005802984bc6fb31
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191209144442eucas1p214c553519b7a9d3d005802984bc6fb31
References: <20191209144425.13321-1-k.konieczny@samsung.com>
        <CGME20191209144442eucas1p214c553519b7a9d3d005802984bc6fb31@eucas1p2.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

If option DEVFREQ_DELAYED_TIMER is set use delayed work in devfreq
workqueue from devfreq start.

Signed-off-by: Kamil Konieczny <k.konieczny@samsung.com>
---
 drivers/devfreq/devfreq.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index c277d1770fef..d9edf648a09e 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -702,7 +702,10 @@ struct devfreq *devfreq_add_device(struct device *dev,
 	devfreq->last_status.current_frequency = profile->initial_freq;
 	devfreq->data = data;
 	devfreq->nb.notifier_call = devfreq_notifier_call;
-	devfreq->delayed_timer = false;
+	if (IS_ENABLED(CONFIG_DEVFREQ_DELAYED_TIMER))
+		devfreq->delayed_timer = true;
+	else
+		devfreq->delayed_timer = false;
 
 	if (!devfreq->profile->max_state && !devfreq->profile->freq_table) {
 		mutex_unlock(&devfreq->lock);
-- 
2.24.0

