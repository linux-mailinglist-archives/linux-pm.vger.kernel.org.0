Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCA462A3D0C
	for <lists+linux-pm@lfdr.de>; Tue,  3 Nov 2020 07:53:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725993AbgKCGxG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Nov 2020 01:53:06 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:54784 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727821AbgKCGxF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Nov 2020 01:53:05 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20201103065303epoutp010ca28225bcf35b522dfaae3d896ab257~D7Oo_88hM2013320133epoutp01N
        for <linux-pm@vger.kernel.org>; Tue,  3 Nov 2020 06:53:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20201103065303epoutp010ca28225bcf35b522dfaae3d896ab257~D7Oo_88hM2013320133epoutp01N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1604386383;
        bh=qDYMOrFOTz+ymAOrSh1pm/ZDNncI1MtDIPapENGjask=;
        h=From:To:Cc:Subject:Date:References:From;
        b=baIqBuCEgkoylISixSkP2wuTdTaBeZJrNGnTg2pOqnvFBpKj3XzcWIYiHT9rRLSDl
         S9zzw/HwZR7SBptPyVfWW+7mM0lP+j7eEwvsoWN8LBLXERY6Mk7DSXnnI6hzPu9oOO
         4oc+85CS3y5/c1a3dOCXyKoTS11eFAFrrihJCbDk=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20201103065302epcas1p1c4d59162fca6a746d379f320791c13e8~D7Oobs95d2671126711epcas1p1l;
        Tue,  3 Nov 2020 06:53:02 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.152]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4CQL8C3TgkzMqYkh; Tue,  3 Nov
        2020 06:52:59 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        A7.D2.02418.34EF0AF5; Tue,  3 Nov 2020 15:52:51 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20201103065250epcas1p4421332566646a4464d7871429aabafd9~D7OdrZBi63229732297epcas1p4u;
        Tue,  3 Nov 2020 06:52:50 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20201103065250epsmtrp12d27d340bb49b1148cdb2df1ee17688a~D7Odqu_Xn2631926319epsmtrp1L;
        Tue,  3 Nov 2020 06:52:50 +0000 (GMT)
X-AuditID: b6c32a35-c23ff70000010972-98-5fa0fe436747
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        27.63.08745.24EF0AF5; Tue,  3 Nov 2020 15:52:50 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20201103065250epsmtip1dcf9d0ead76d05133d25442a62a0ad06~D7Odb6axo1509215092epsmtip1b;
        Tue,  3 Nov 2020 06:52:50 +0000 (GMT)
From:   Chanwoo Choi <cw00.choi@samsung.com>
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     cw00.choi@samsung.com, chanwoo@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com
Subject: [PATCH] PM / devfreq: passive: Update frequency when start governor
Date:   Tue,  3 Nov 2020 16:06:46 +0900
Message-Id: <20201103070646.18687-1-cw00.choi@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIKsWRmVeSWpSXmKPExsWy7bCmvq7zvwXxBltbFC0m3rjCYnH9y3NW
        i7NNb9gtLu+aw2bxufcIo8XtxhVsDmwem1Z1snn0bVnF6PF5k1wAc1S2TUZqYkpqkUJqXnJ+
        SmZeuq2Sd3C8c7ypmYGhrqGlhbmSQl5ibqqtkotPgK5bZg7QXiWFssScUqBQQGJxsZK+nU1R
        fmlJqkJGfnGJrVJqQUpOgWWBXnFibnFpXrpecn6ulaGBgZEpUGFCdsaVJX4FTbwVS94tZ2xg
        vMLVxcjJISFgIvFoTidbFyMXh5DADkaJxp5d7BDOJ0aJ9i23oZzPjBJ7ux6wwbTMvtDLBJHY
        xSixavkaqKovjBLb9/xhAaliE9CS2P/iBliHiICVxOn/HcwgNrNAikT/7zNgNcICPhKbX71i
        BbFZBFQl1vyZywRi8wLVvz2yhQlim7zE6g0HmEEWSAjMY5dYdOkqO0TCReLkuWZmCFtY4tXx
        LVBxKYmX/W1QdrXEypNH2CCaOxgltuy/wAqRMJbYv3Qy0AYOoIs0Jdbv0ocIK0rs/D2XEeJQ
        Pol3X3tYQUokBHglOtqEIEqUJS4/uAt1m6TE4vZOaKh4SNxpmQzWKiQQK7Hy/V22CYyysxAW
        LGBkXMUollpQnJueWmxYYIgcS5sYwWlJy3QH48S3H/QOMTJxMB5ilOBgVhLhrYmcFy/Em5JY
        WZValB9fVJqTWnyI0RQYYBOZpUST84GJMa8k3tDUyNjY2MLE0MzU0FBJnPePdke8kEB6Yklq
        dmpqQWoRTB8TB6dUA9Oz+TfSCzk2N549s/CW+mzbEyKHgp91aTrGb67ribqf80VHOdclLFLx
        7/+L6/+ZRf4xOsv44KeZR+DDL8edtlw1TPF1XXjNa0ZoyOepYlFlsrMVvlU/c98mEil5aX2f
        5ha5XLcpnyY9P5G9LIptlcOx6cUfO5NCeK/UXp1v1OtyQHvvi82BF4xvxTjYRddu09sUrLxB
        8KHcdZ6gSXN5FnhbXviw3XNKdxHHYeu3aifqk259TQo3S7z4zOHVigMX4qYmy2YW9CTc/3ln
        mcPSuqky8s7bJSzOdB3uzKzVPH6g5IOukXSIx/zoOKdbfVn/hawuFUxxmVWidCVy4ca+v+9T
        lvv5nbhZNPeCu9hLz19KLMUZiYZazEXFiQCglcRi1AMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLJMWRmVeSWpSXmKPExsWy7bCSnK7TvwXxBrc7jCwm3rjCYnH9y3NW
        i7NNb9gtLu+aw2bxufcIo8XtxhVsDmwem1Z1snn0bVnF6PF5k1wAcxSXTUpqTmZZapG+XQJX
        xpUlfgVNvBVL3i1nbGC8wtXFyMkhIWAiMftCL1MXIxeHkMAORonG7lmMEAlJiWkXjzJ3MXIA
        2cIShw8XQ9R8YpR49qqFBaSGTUBLYv+LG2wgtoiAjcTdxddYQOqZBTIk/i9XAgkLC/hIbH71
        ihXEZhFQlVjzZy4TiM0rYCXx9sgWJohV8hKrNxxgnsDIs4CRYRWjZGpBcW56brFhgVFearle
        cWJucWleul5yfu4mRnCIaGntYNyz6oPeIUYmDsZDjBIczEoivDWR8+KFeFMSK6tSi/Lji0pz
        UosPMUpzsCiJ836dtTBOSCA9sSQ1OzW1ILUIJsvEwSnVwBR7zenXkoNuiezrPmdbbfXQNbLy
        qZNY4Sz+99NJV6EvFt9Pls14fHdjBUdXtKV+SoqcVFTU5mLd9LiIHRFb1LvNr/Jd/d07/WjT
        DL4rrSfs56So8dsJTVX0DVqVLr0wcu2xXV6O9WY6nz737X/l5D53rXJQ4+tlp/PWnK1n/dkR
        dXkz6+7eQ/sstx0qi1ifsLJWVjvxr3ePyOxPbzXNK0vlu9l//Jv1zi6kZNaX149X8ilP+F1/
        ZHE2y8USse0WZy6GuqU1zln2q5uF4+NiGwOupaeEjpz07uuatnqB4l2537qrq09HPjNTE6/8
        N6dg/8mAs69nKtnruW3Zdqxj57wk3Z1z/76+HCD4asNNlu9KLMUZiYZazEXFiQB/jnvkgAIA
        AA==
X-CMS-MailID: 20201103065250epcas1p4421332566646a4464d7871429aabafd9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20201103065250epcas1p4421332566646a4464d7871429aabafd9
References: <CGME20201103065250epcas1p4421332566646a4464d7871429aabafd9@epcas1p4.samsung.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

If the parent device changes the their frequency before registering
the passive device, the passive device cannot receive the notification
from parent device and then the passive device cannot be able to
set the proper frequency according to the frequency of parent device.

So, when start the passive governor, update the frequency
according to the frequency of parent device.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/devfreq/governor_passive.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/devfreq/governor_passive.c b/drivers/devfreq/governor_passive.c
index 63332e4a65ae..375aa636027c 100644
--- a/drivers/devfreq/governor_passive.c
+++ b/drivers/devfreq/governor_passive.c
@@ -141,6 +141,21 @@ static int devfreq_passive_event_handler(struct devfreq *devfreq,
 		if (!p_data->this)
 			p_data->this = devfreq;
 
+		/*
+		 * If the parent device changes the their frequency before
+		 * registering the passive device, the passive device cannot
+		 * receive the notification from parent device and then the
+		 * passive device cannot be able to set the proper frequency
+		 * according to the frequency of parent device.
+		 *
+		 * When start the passive governor, update the frequency
+		 * according to the frequency of parent device.
+		 */
+		ret = devfreq_update_target(devfreq, parent->previous_freq);
+		if (ret < 0)
+			dev_warn(&devfreq->dev,
+			"failed to update devfreq using passive governor\n");
+
 		nb->notifier_call = devfreq_passive_notifier_call;
 		ret = devfreq_register_notifier(parent, nb,
 					DEVFREQ_TRANSITION_NOTIFIER);
-- 
2.17.1

