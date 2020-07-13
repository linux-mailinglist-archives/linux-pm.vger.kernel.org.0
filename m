Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE04B21D187
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jul 2020 10:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729199AbgGMITw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Jul 2020 04:19:52 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:17127 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729157AbgGMITv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Jul 2020 04:19:51 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200713081948epoutp048ef96b4abac89b80831737b87e15e31a~hQhINvGBX1460114601epoutp04E
        for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2020 08:19:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200713081948epoutp048ef96b4abac89b80831737b87e15e31a~hQhINvGBX1460114601epoutp04E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1594628388;
        bh=08kVqR/obW4L7snWVqmw3fbKC/OAyxBu0Rss715hRKc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pQucxQ5DgUK3c3Ue+/vTGdwEi3wMJOVM+MecbjeZLHaQnIdnfIcY3jATXC35xy8+4
         WUZplPHOW4VtfBXBq+XljlTEpeLek3mk0FXH+LS13fkbEv9E9wDMdBz0OMqlKq6TU/
         ct74AOwxv8h0cHnhDmIQbPTzxxG6alrw7aB7wpwk=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200713081947epcas1p157091b016b2daa62b97f636da4d2a57f~hQhHb5BPi2540325403epcas1p1o;
        Mon, 13 Jul 2020 08:19:47 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.154]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4B4xQS6tP5zMqYkj; Mon, 13 Jul
        2020 08:19:44 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        5D.38.18978.0291C0F5; Mon, 13 Jul 2020 17:19:44 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200713081943epcas1p2a618d5a2e87610be7442e1fa584076cf~hQhECF07V2976329763epcas1p2U;
        Mon, 13 Jul 2020 08:19:43 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200713081943epsmtrp18cbbb2e065e7e6b91826412f984764b2~hQhEBSJAk0739907399epsmtrp1x;
        Mon, 13 Jul 2020 08:19:43 +0000 (GMT)
X-AuditID: b6c32a35-5edff70000004a22-64-5f0c1920eee1
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        8E.F3.08303.F191C0F5; Mon, 13 Jul 2020 17:19:43 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200713081943epsmtip28a8a189ef993d0c5683fab54a2141ec4~hQhD1KYcE2956229562epsmtip2Z;
        Mon, 13 Jul 2020 08:19:43 +0000 (GMT)
From:   Chanwoo Choi <cw00.choi@samsung.com>
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     leonard.crestez@nxp.com, lukasz.luba@arm.com,
        enric.balletbo@collabora.com, hl@rock-chips.com, digetx@gmail.com,
        thierry.reding@gmail.com, jonathanh@nvidia.com, abel.vesa@nxp.com,
        cw00.choi@samsung.com, chanwoo@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com
Subject: [PATCH v2 1/2] PM / devfreq: Clean up the devfreq instance name in
 sysfs attr
Date:   Mon, 13 Jul 2020 17:31:12 +0900
Message-Id: <20200713083113.5595-2-cw00.choi@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200713083113.5595-1-cw00.choi@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMJsWRmVeSWpSXmKPExsWy7bCmvq6CJE+8wflDxhbLLh1ltJh44wqL
        xfUvz1ktVn98zGix5vYhRosfG04xW7TMWsRicbbpDbvFirsfWS0u75rDZvG59wijxcKmFnaL
        240r2Cx+7prH4sDnsWbeGkaPHXeXMHrsnHWX3WPTqk42j97md2weG9/tYPL4O2s/i0ffllWM
        Hp83yQVwRmXbZKQmpqQWKaTmJeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoqufgE6Lpl
        5gBdr6RQlphTChQKSCwuVtK3synKLy1JVcjILy6xVUotSMkpsCzQK07MLS7NS9dLzs+1MjQw
        MDIFKkzIztg5Zw5bwW6Ligl/p7A1MB7U7WLk5JAQMJF492gGWxcjF4eQwA5GiY+vNjFDOJ8Y
        Jb4+u8AE4XxmlJh07w4jTMvtZ6tZIRK7GCWW72xkAUkICXxhlDj/XhjEZhPQktj/4gYbiC0i
        YCVx+n8H2FhmgXlMEotPXwVrEBaIkJi0bhUTiM0ioCpxZ9YhsA28ApYSJ09cZ4XYJi+xesMB
        ZhCbE2jQm2sdYCdJCCzkkHi+uBkowQHkuEjMvaoDUS8s8er4FnYIW0riZX8blF0tsfLkETaI
        3g5GiS37L0AtMJbYv3QyE8gcZgFNifW79CHCihI7f88Fu4dZgE/i3dceVohVvBIdbUIQJcoS
        lx/cZYKwJSUWt3eyQdgeEh8e7mKChEkvo8SiPqUJjHKzEBYsYGRcxSiWWlCcm55abFhgiBxj
        mxjBqVPLdAfjxLcf9A4xMnEwHmKU4GBWEuGNFuWMF+JNSaysSi3Kjy8qzUktPsRoCgy7icxS
        osn5wOSdVxJvaGpkbGxsYWJoZmpoqCTO++8se7yQQHpiSWp2ampBahFMHxMHp1QD084WfgXj
        4hfXXyaX//nDdXWOmMfWluWbZKt2H1786Orah42+rrcu79hwY2/3uQcLmzJC39+LM5riHtp5
        Nf+PerrrxqsfmNfWeaSEVs1LaTifZnqxIsS898fjnQzfNbcusEoUcl9+a5NcvfaR+fwKwoez
        Vvxc+EN18Snz5Q52HL9sOe6sM0zXThS7Jt+5aLLOuSMNqo7Tlpk/vH/59q7Hr+pPcZpzsSUH
        /rm+KN5RaXPyapewH0uq28Mni0y6cHHDLWdTbi8BGaGPx/9f/y1QKTBbyalyv816jcp9H6f/
        jHi07YHWQcl7d9c9nHXsWpltmd+Nv/+Wrp29S2XZp9esKX1nMraWJ5yXnJOtvm1+/vNoJZbi
        jERDLeai4kQAbsVWKyYEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHLMWRmVeSWpSXmKPExsWy7bCSvK68JE+8waGvhhbLLh1ltJh44wqL
        xfUvz1ktVn98zGix5vYhRosfG04xW7TMWsRicbbpDbvFirsfWS0u75rDZvG59wijxcKmFnaL
        240r2Cx+7prH4sDnsWbeGkaPHXeXMHrsnHWX3WPTqk42j97md2weG9/tYPL4O2s/i0ffllWM
        Hp83yQVwRnHZpKTmZJalFunbJXBl7Jwzh61gt0XFhL9T2BoYD+p2MXJySAiYSNx+tpq1i5GL
        Q0hgB6PEgp9b2CESkhLTLh5l7mLkALKFJQ4fLoao+cQosaq7nQ2khk1AS2L/ixtgtoiAjcTd
        xddYQIqYBdYwSbzbfogJJCEsECYxteUVK4jNIqAqcWfWIUYQm1fAUuLkieusEMvkJVZvOMAM
        YnMKWEm8udYB1isEVLP2awPzBEa+BYwMqxglUwuKc9Nziw0LjPJSy/WKE3OLS/PS9ZLzczcx
        goNcS2sH455VH/QOMTJxMB5ilOBgVhLhjRbljBfiTUmsrEotyo8vKs1JLT7EKM3BoiTO+3XW
        wjghgfTEktTs1NSC1CKYLBMHp1QD0+nZwb783klec2IvL91Te7N8N5tpVZTHmcP/ee1qTBPt
        5R963dqmwKu1S901X1W7NaKlb8oXtQ0BHXuea87a0fFOkOnny6Wymx9NXR7/cXceYzH/Bc7N
        C1Wsdzb69Pyb+lugs8Bvu+v2Rws5pR5cndNVcq9iolab5O9ZW/9u22maOF1f+aTPs3fWSzsa
        JivO9qp8zbbAPyfS2zno9rtV19nkau4xLWFfYXJ8t8KE430+PIVZh/f+eay3vzdh4emHEc3r
        tm8t/Wj91GeOW9POqe9Y481YLWIf8EivcLrQppF19bbEyT8/PnfcWXuzZ4nE9B0rTrSwStw+
        lLA06N6ZOi0mBe+PLT5PS04vvrXxbaQSS3FGoqEWc1FxIgCrc/w84QIAAA==
X-CMS-MailID: 20200713081943epcas1p2a618d5a2e87610be7442e1fa584076cf
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200713081943epcas1p2a618d5a2e87610be7442e1fa584076cf
References: <20200713083113.5595-1-cw00.choi@samsung.com>
        <CGME20200713081943epcas1p2a618d5a2e87610be7442e1fa584076cf@epcas1p2.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The sysfs attr interface used eithere 'df' or 'devfreq' for devfreq instance
name. In order to keep the consistency and to improve the readabilty,
unify the instance name as 'df'. Add add the missing conditional statement
to prevent the fault.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/devfreq/devfreq.c | 94 +++++++++++++++++++++++++--------------
 1 file changed, 60 insertions(+), 34 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 5320c3b37f35..286957f760f1 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -1280,18 +1280,20 @@ EXPORT_SYMBOL(devfreq_remove_governor);
 static ssize_t name_show(struct device *dev,
 			struct device_attribute *attr, char *buf)
 {
-	struct devfreq *devfreq = to_devfreq(dev);
-	return sprintf(buf, "%s\n", dev_name(devfreq->dev.parent));
+	struct devfreq *df = to_devfreq(dev);
+	return sprintf(buf, "%s\n", dev_name(df->dev.parent));
 }
 static DEVICE_ATTR_RO(name);
 
 static ssize_t governor_show(struct device *dev,
 			     struct device_attribute *attr, char *buf)
 {
-	if (!to_devfreq(dev)->governor)
+	struct devfreq *df = to_devfreq(dev);
+
+	if (!df->governor)
 		return -EINVAL;
 
-	return sprintf(buf, "%s\n", to_devfreq(dev)->governor->name);
+	return sprintf(buf, "%s\n", df->governor->name);
 }
 
 static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
@@ -1302,6 +1304,9 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
 	char str_governor[DEVFREQ_NAME_LEN + 1];
 	const struct devfreq_governor *governor, *prev_governor;
 
+	if (!df->governor)
+		return -EINVAL;
+
 	ret = sscanf(buf, "%" __stringify(DEVFREQ_NAME_LEN) "s", str_governor);
 	if (ret != 1)
 		return -EINVAL;
@@ -1315,20 +1320,18 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
 	if (df->governor == governor) {
 		ret = 0;
 		goto out;
-	} else if ((df->governor && df->governor->immutable) ||
-					governor->immutable) {
+	} else if (df->governor->immutable || governor->immutable) {
 		ret = -EINVAL;
 		goto out;
 	}
 
-	if (df->governor) {
-		ret = df->governor->event_handler(df, DEVFREQ_GOV_STOP, NULL);
-		if (ret) {
-			dev_warn(dev, "%s: Governor %s not stopped(%d)\n",
-				 __func__, df->governor->name, ret);
-			goto out;
-		}
+	ret = df->governor->event_handler(df, DEVFREQ_GOV_STOP, NULL);
+	if (ret) {
+		dev_warn(dev, "%s: Governor %s not stopped(%d)\n",
+			 __func__, df->governor->name, ret);
+		goto out;
 	}
+
 	prev_governor = df->governor;
 	df->governor = governor;
 	strncpy(df->governor_name, governor->name, DEVFREQ_NAME_LEN);
@@ -1363,13 +1366,16 @@ static ssize_t available_governors_show(struct device *d,
 	struct devfreq *df = to_devfreq(d);
 	ssize_t count = 0;
 
+	if (!df->governor)
+		return -EINVAL;
+
 	mutex_lock(&devfreq_list_lock);
 
 	/*
 	 * The devfreq with immutable governor (e.g., passive) shows
 	 * only own governor.
 	 */
-	if (df->governor && df->governor->immutable) {
+	if (df->governor->immutable) {
 		count = scnprintf(&buf[count], DEVFREQ_NAME_LEN,
 				  "%s ", df->governor_name);
 	/*
@@ -1403,27 +1409,37 @@ static ssize_t cur_freq_show(struct device *dev, struct device_attribute *attr,
 			     char *buf)
 {
 	unsigned long freq;
-	struct devfreq *devfreq = to_devfreq(dev);
+	struct devfreq *df = to_devfreq(dev);
 
-	if (devfreq->profile->get_cur_freq &&
-		!devfreq->profile->get_cur_freq(devfreq->dev.parent, &freq))
+	if (!df->profile)
+		return -EINVAL;
+
+	if (df->profile->get_cur_freq &&
+		!df->profile->get_cur_freq(df->dev.parent, &freq))
 		return sprintf(buf, "%lu\n", freq);
 
-	return sprintf(buf, "%lu\n", devfreq->previous_freq);
+	return sprintf(buf, "%lu\n", df->previous_freq);
 }
 static DEVICE_ATTR_RO(cur_freq);
 
 static ssize_t target_freq_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
-	return sprintf(buf, "%lu\n", to_devfreq(dev)->previous_freq);
+	struct devfreq *df = to_devfreq(dev);
+
+	return sprintf(buf, "%lu\n", df->previous_freq);
 }
 static DEVICE_ATTR_RO(target_freq);
 
 static ssize_t polling_interval_show(struct device *dev,
 				     struct device_attribute *attr, char *buf)
 {
-	return sprintf(buf, "%d\n", to_devfreq(dev)->profile->polling_ms);
+	struct devfreq *df = to_devfreq(dev);
+
+	if (!df->profile)
+		return -EINVAL;
+
+	return sprintf(buf, "%d\n", df->profile->polling_ms);
 }
 
 static ssize_t polling_interval_store(struct device *dev,
@@ -1551,6 +1567,9 @@ static ssize_t available_frequencies_show(struct device *d,
 	ssize_t count = 0;
 	int i;
 
+	if (!df->profile)
+		return -EINVAL;
+
 	mutex_lock(&df->lock);
 
 	for (i = 0; i < df->profile->max_state; i++)
@@ -1571,49 +1590,53 @@ static DEVICE_ATTR_RO(available_frequencies);
 static ssize_t trans_stat_show(struct device *dev,
 			       struct device_attribute *attr, char *buf)
 {
-	struct devfreq *devfreq = to_devfreq(dev);
+	struct devfreq *df = to_devfreq(dev);
 	ssize_t len;
 	int i, j;
-	unsigned int max_state = devfreq->profile->max_state;
+	unsigned int max_state;
+
+	if (!df->profile)
+		return -EINVAL;
+	max_state = df->profile->max_state;
 
 	if (max_state == 0)
 		return sprintf(buf, "Not Supported.\n");
 
-	mutex_lock(&devfreq->lock);
-	if (!devfreq->stop_polling &&
-			devfreq_update_status(devfreq, devfreq->previous_freq)) {
-		mutex_unlock(&devfreq->lock);
+	mutex_lock(&df->lock);
+	if (!df->stop_polling &&
+			devfreq_update_status(df, df->previous_freq)) {
+		mutex_unlock(&df->lock);
 		return 0;
 	}
-	mutex_unlock(&devfreq->lock);
+	mutex_unlock(&df->lock);
 
 	len = sprintf(buf, "     From  :   To\n");
 	len += sprintf(buf + len, "           :");
 	for (i = 0; i < max_state; i++)
 		len += sprintf(buf + len, "%10lu",
-				devfreq->profile->freq_table[i]);
+				df->profile->freq_table[i]);
 
 	len += sprintf(buf + len, "   time(ms)\n");
 
 	for (i = 0; i < max_state; i++) {
-		if (devfreq->profile->freq_table[i]
-					== devfreq->previous_freq) {
+		if (df->profile->freq_table[i]
+					== df->previous_freq) {
 			len += sprintf(buf + len, "*");
 		} else {
 			len += sprintf(buf + len, " ");
 		}
 		len += sprintf(buf + len, "%10lu:",
-				devfreq->profile->freq_table[i]);
+				df->profile->freq_table[i]);
 		for (j = 0; j < max_state; j++)
 			len += sprintf(buf + len, "%10u",
-				devfreq->stats.trans_table[(i * max_state) + j]);
+				df->stats.trans_table[(i * max_state) + j]);
 
 		len += sprintf(buf + len, "%10llu\n", (u64)
-			jiffies64_to_msecs(devfreq->stats.time_in_state[i]));
+			jiffies64_to_msecs(df->stats.time_in_state[i]));
 	}
 
 	len += sprintf(buf + len, "Total transition : %u\n",
-					devfreq->stats.total_trans);
+					df->stats.total_trans);
 	return len;
 }
 
@@ -1624,6 +1647,9 @@ static ssize_t trans_stat_store(struct device *dev,
 	struct devfreq *df = to_devfreq(dev);
 	int err, value;
 
+	if (!df->profile)
+		return -EINVAL;
+
 	if (df->profile->max_state == 0)
 		return count;
 
-- 
2.17.1

