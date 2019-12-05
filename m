Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25351114318
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2019 15:56:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729668AbfLEOzq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Dec 2019 09:55:46 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:47473 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729530AbfLEOzp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Dec 2019 09:55:45 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20191205145544euoutp024bb3698290fdc03758765ebadb2a2f1e~dgWvA2rEb0629206292euoutp02B
        for <linux-pm@vger.kernel.org>; Thu,  5 Dec 2019 14:55:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20191205145544euoutp024bb3698290fdc03758765ebadb2a2f1e~dgWvA2rEb0629206292euoutp02B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1575557744;
        bh=G7b0CnZGU9BRWv3eF1cy9YZv7wIiWIcyZFvI6lNpCyY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l4GvQDXHNaAhXq3ERH8GTEyh/iANVWfNMl1NcFJlKruNz0guxpyBR6ABSnuN2BqCO
         nImC5ABavJyw8i7L75qR61VQGHOH6A/Lk/HDRXgkSpoM+a0JunlHZTRTwSGFiycZ8J
         adCLH4ZlmLK1EAxzJVPG0zHYSF8kODqT0pbqCViY=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20191205145544eucas1p211fc681adf95fd0c69bcc4acf1721afa~dgWusPUKg0132801328eucas1p2U;
        Thu,  5 Dec 2019 14:55:44 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id E3.EB.60679.F6A19ED5; Thu,  5
        Dec 2019 14:55:44 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20191205145543eucas1p1a317647203c47be07bbcee7867fb3e1e~dgWuXgrDt2191821918eucas1p1m;
        Thu,  5 Dec 2019 14:55:43 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191205145543eusmtrp158a4b6e9429ea83b81c9ba5fcaa0e826~dgWuW2GEe2567425674eusmtrp1V;
        Thu,  5 Dec 2019 14:55:43 +0000 (GMT)
X-AuditID: cbfec7f4-0e5ff7000001ed07-09-5de91a6f64f7
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 35.6F.08375.F6A19ED5; Thu,  5
        Dec 2019 14:55:43 +0000 (GMT)
Received: from AMDC3218.digital.local (unknown [106.120.51.18]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191205145543eusmtip228d456584ab0d23944522d6771bbafbe~dgWt1N_KJ2088220882eusmtip2Y;
        Thu,  5 Dec 2019 14:55:43 +0000 (GMT)
From:   Kamil Konieczny <k.konieczny@samsung.com>
To:     k.konieczny@samsung.com
Cc:     Andrew Donnellan <ajd@linux.ibm.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v3 2/3] devfreq: add clearing transitions stats
Date:   Thu,  5 Dec 2019 15:55:26 +0100
Message-Id: <20191205145527.26117-3-k.konieczny@samsung.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191205145527.26117-1-k.konieczny@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIKsWRmVeSWpSXmKPExsWy7djPc7oFUi9jDb7dZrF4s+QYs8XGGetZ
        La5/ec5q0bx4PZvFgk8zWC3On9/AbnG26Q27xeVdc9gsPvceYbRYe+Quu8WyTX+YLG43rmCz
        eLziLbsDr8fiPS+ZPDat6mTzmLDoAKPH/rlr2D36tqxi9Pi8SS6ALYrLJiU1J7MstUjfLoEr
        42T3J+aCM+IVC1ffZWlgXCPcxcjJISFgIvH59wn2LkYuDiGBFYwS3dvWs0E4Xxgl/vw/zQLh
        fGaUWHxwHwtMy++G24wQieWMElc/7meBa5n/5BkjSBWbgL7EwbMnwTpEBKQlOhdNZAIpYhZo
        ZJG49b4FLCEsYC9x9HoPmM0ioCqxb+ETdhCbV8BGoun1USCbA2idvMSctxogYU4BW4ltl54x
        QZQISpyc+QSslRmopHnrbGaQ+RICh9glDj56yQxxqovE3CO/oM4Wlnh1fAs7hC0jcXpyD1S8
        XOLpwj52iOYWRokH7R+hEtYSh49fZAU5gllAU2L9Ln2IexwlTh22gDD5JG68FYQ4gU9i0rbp
        zBBhXomONiGIGaoSz0/1MEHY0hJd/9exQtgeEosWHWKdwKg4C8kzs5A8Mwth7QJG5lWM4qml
        xbnpqcVGeanlesWJucWleel6yfm5mxiBCev0v+NfdjDu+pN0iFGAg1GJh3fG5xexQqyJZcWV
        uYcYJTiYlUR40/lexgrxpiRWVqUW5ccXleakFh9ilOZgURLnrWZ4EC0kkJ5YkpqdmlqQWgST
        ZeLglGpgZEqPXjFvS+v6GTqLLDlNeQKLxT82+6ZoTFjuNkVcj9VLUmRTtOQuvcx7zdd/6t8M
        fngjXtfWJPUAe8P1VstTnC37zs3T/MxXvbNxPZdO5Oq9K42ijMJqWQoyts67kcGwLuH7qkk/
        w/T39VSo9furi31ZJNXXGbdsbq/q874LVpFSK/kMXhorsRRnJBpqMRcVJwIAbhqQZ1QDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPIsWRmVeSWpSXmKPExsVy+t/xe7r5Ui9jDRpW6Vi8WXKM2WLjjPWs
        Fte/PGe1aF68ns1iwacZrBbnz29gtzjb9Ibd4vKuOWwWn3uPMFqsPXKX3WLZpj9MFrcbV7BZ
        PF7xlt2B12PxnpdMHptWdbJ5TFh0gNFj/9w17B59W1YxenzeJBfAFqVnU5RfWpKqkJFfXGKr
        FG1oYaRnaGmhZ2RiqWdobB5rZWSqpG9nk5Kak1mWWqRvl6CXcbL7E3PBGfGKhavvsjQwrhHu
        YuTkkBAwkfjdcJuxi5GLQ0hgKaPEjPnbmSES0hKNp1czQdjCEn+udbFBFH1ilFh29ipYEZuA
        vsTBsydZQGwRoIbORROZQIqYBTpZJJq29rOCJIQF7CWOXu8BK2IRUJXYt/AJO4jNK2Aj0fT6
        KJDNAbRBXmLOWw2QMKeArcS2S8+YQMJCQCUNb1ggqgUlTs58AmYzA1U3b53NPIFRYBaS1Cwk
        qQWMTKsYRVJLi3PTc4sN9YoTc4tL89L1kvNzNzECI2vbsZ+bdzBe2hh8iFGAg1GJh3fG5xex
        QqyJZcWVuYcYJTiYlUR40/lexgrxpiRWVqUW5ccXleakFh9iNAV6YSKzlGhyPjDq80riDU0N
        zS0sDc2NzY3NLJTEeTsEDsYICaQnlqRmp6YWpBbB9DFxcEo1MGbJTVCRbtDymXbjxluvM9cP
        xcsqLwjQk7kZJ25esfvo7ExHZv/f9TeMZqR8fvnIV8DmjX2oNWfr5731ts/Up+w8cTRu8fWb
        5WVbje5EnmFfGWj8T9m3LiQkyrBTdPFxx1q7XTWx36pe3btmGdn/WjNszfGfWxxn/iyWXcV7
        qJIt/OxsIb876kosxRmJhlrMRcWJADOWdoLCAgAA
X-CMS-MailID: 20191205145543eucas1p1a317647203c47be07bbcee7867fb3e1e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20191205145543eucas1p1a317647203c47be07bbcee7867fb3e1e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191205145543eucas1p1a317647203c47be07bbcee7867fb3e1e
References: <20191205145527.26117-1-k.konieczny@samsung.com>
        <CGME20191205145543eucas1p1a317647203c47be07bbcee7867fb3e1e@eucas1p1.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add clearing transition table and time in states devfreq statistics
by writing 0 (zero) to trans_stat file in devfreq sysfs. An example use
is like following:

echo 0 > /sys/class/devfreq/devfreqX/trans_stat

Signed-off-by: Kamil Konieczny <k.konieczny@samsung.com>
---
Changes in v3:
- add checks for zero in input and clear stats only when zero is written
  to trans_stats
- change documentation of trans_stat in sysfs

Changes in v2:
- instead of creating new sysfs file, add new functionality to trans_stat
  and clear stats when anything is writen to it
---
 Documentation/ABI/testing/sysfs-class-devfreq | 11 +++++---
 drivers/devfreq/devfreq.c                     | 27 ++++++++++++++++++-
 2 files changed, 33 insertions(+), 5 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-devfreq b/Documentation/ABI/testing/sysfs-class-devfreq
index 75897e2fde43..9758eb85ade3 100644
--- a/Documentation/ABI/testing/sysfs-class-devfreq
+++ b/Documentation/ABI/testing/sysfs-class-devfreq
@@ -55,12 +55,15 @@ What:		/sys/class/devfreq/.../trans_stat
 Date:		October 2012
 Contact:	MyungJoo Ham <myungjoo.ham@samsung.com>
 Description:
-		This ABI shows the statistics of devfreq behavior on a
-		specific device. It shows the time spent in each state and
-		the number of transitions between states.
+		This ABI shows or clears the statistics of devfreq behavior
+		on a specific device. It shows the time spent in each state
+		and the number of transitions between states.
 		In order to activate this ABI, the devfreq target device
 		driver should provide the list of available frequencies
-		with its profile.
+		with its profile. If need to reset the statistics of devfreq
+		behavior on a specific device, enter 0(zero) to 'trans_stat'
+		as following:
+			echo 0 > /sys/class/devfreq/.../trans_stat
 
 What:		/sys/class/devfreq/.../userspace/set_freq
 Date:		September 2011
diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index abecadeb3dc2..218eb64d7f28 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -1478,7 +1478,32 @@ static ssize_t trans_stat_show(struct device *dev,
 					devfreq->total_trans);
 	return len;
 }
-static DEVICE_ATTR_RO(trans_stat);
+
+static ssize_t trans_stat_store(struct device *dev,
+				struct device_attribute *attr,
+				const char *buf, size_t count)
+{
+	struct devfreq *df = to_devfreq(dev);
+	unsigned int cnt = df->profile->max_state;
+	int err, value;
+
+	if (cnt == 0)
+		return count;
+
+	err = kstrtoint(buf, 10, &value);
+	if (err || value != 0)
+		return count;
+
+	mutex_lock(&df->lock);
+	memset(df->time_in_state, 0, cnt * sizeof(u64));
+	memset(df->trans_table, 0, cnt * cnt * sizeof(int));
+	df->last_stat_updated = get_jiffies_64();
+	df->total_trans = 0;
+	mutex_unlock(&df->lock);
+
+	return count;
+}
+static DEVICE_ATTR_RW(trans_stat);
 
 static struct attribute *devfreq_attrs[] = {
 	&dev_attr_name.attr,
-- 
2.24.0

