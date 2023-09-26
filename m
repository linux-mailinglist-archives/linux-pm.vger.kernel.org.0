Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11F0E7AE870
	for <lists+linux-pm@lfdr.de>; Tue, 26 Sep 2023 10:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234054AbjIZI7D (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 Sep 2023 04:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234051AbjIZI67 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 Sep 2023 04:58:59 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2360511D;
        Tue, 26 Sep 2023 01:58:51 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38Q8qnJk015453;
        Tue, 26 Sep 2023 08:58:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=k5Sv1kn8ZcVmckNzzP/u21m594GegbOMImbMQMb1eU4=;
 b=KLJ1Nkmi2FhApsx1HUx7963MVgFG48UP88B34+sgn4N8szrNbav2pvMKmcwudajgW8Q4
 8ZO0e4KXnHbDlxdTADNZK6+BEA8mXKtjDGaq9FMhMDDEwabBpT8Mm5zS42iyTe0L6e4w
 kPN4ZO31ZEAVePN+T0aZXftdqNfnAmfCSGcrz5OM82ybS8erqYpmJZzy4ebgbDe8Wtb7
 0195yxnZSkdEZ4SpQvgTMmMTOWS+DRBiKucs/haAAZ5VepE7InqFQ+5rdjgWT1tuy+3y
 Vveh2/bZPR3luWFomiOvpH7ZwfEQkwIxEbWqzGFYHOlem1vSiBj4ZxX1kygjqJGz7lAM 6Q== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tbexghfsg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Sep 2023 08:58:36 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38Q8wZdC004975
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Sep 2023 08:58:35 GMT
Received: from hu-nprakash-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Tue, 26 Sep 2023 01:58:28 -0700
From:   Nikhil V <quic_nprakash@quicinc.com>
To:     Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        "Rafael J. Wysocki" <rafael@kernel.org>
CC:     Nikhil V <quic_nprakash@quicinc.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, Tejun Heo <tj@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <quic_pkondeti@quicinc.com>,
        <quic_kprasan@quicinc.com>, <quic_mpilaniy@quicinc.com>,
        <quic_shrekk@quicinc.com>, <mpleshivenkov@google.com>,
        <ericyin@google.com>
Subject: [RFC PATCH 2/4] PM: hibernate: Move to crypto APIs for LZO compression
Date:   Tue, 26 Sep 2023 14:27:12 +0530
Message-ID: <486273fb828eb56d1895fee49481f5c035df8300.1695711299.git.quic_nprakash@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1695711299.git.quic_nprakash@quicinc.com>
References: <cover.1695711299.git.quic_nprakash@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: eoIBFVhtYgmfeaeUrpM0att45z3NCuGv
X-Proofpoint-GUID: eoIBFVhtYgmfeaeUrpM0att45z3NCuGv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-26_07,2023-09-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 spamscore=0 suspectscore=0 impostorscore=0 mlxlogscore=999
 adultscore=0 clxscore=1015 bulkscore=0 mlxscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309260078
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Currently for hibernation, LZO is the only compression algorithm
available and uses the existing LZO library calls. However, there
is no flexibility to switch to other algorithms which provides better
results. The main idea is that different compression algorithms have
different characteristics and hibernation may benefit when it uses
alternate algorithms.

By moving to crypto based APIs, it lays a foundation to use other
compression algorithms for hibernation. There are no functional changes
introduced by this approach.

Signed-off-by: Nikhil V <quic_nprakash@quicinc.com>
---
 kernel/power/Kconfig     |  20 +++++++-
 kernel/power/hibernate.c |  33 +++++++++++++
 kernel/power/power.h     |   5 ++
 kernel/power/swap.c      | 101 +++++++++++++++++++++++++++++----------
 4 files changed, 131 insertions(+), 28 deletions(-)

diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
index 4b31629c5be4..bc449d05c23d 100644
--- a/kernel/power/Kconfig
+++ b/kernel/power/Kconfig
@@ -39,9 +39,8 @@ config HIBERNATION
 	bool "Hibernation (aka 'suspend to disk')"
 	depends on SWAP && ARCH_HIBERNATION_POSSIBLE
 	select HIBERNATE_CALLBACKS
-	select LZO_COMPRESS
-	select LZO_DECOMPRESS
 	select CRC32
+	select CRYPTO_LZO
 	help
 	  Enable the suspend to disk (STD) functionality, which is usually
 	  called "hibernation" in user interfaces.  STD checkpoints the
@@ -92,6 +91,23 @@ config HIBERNATION_SNAPSHOT_DEV
 
 	  If in doubt, say Y.
 
+choice
+	prompt "Default compressor"
+	default HIBERNATION_COMP_LZO
+	depends on HIBERNATION
+
+config HIBERNATION_COMP_LZO
+	bool "lzo"
+	depends on CRYPTO_LZO
+
+endchoice
+
+config HIBERNATION_DEF_COMP
+	string
+	default "lzo" if HIBERNATION_COMP_LZO
+	help
+	  Default compressor to be used for hibernation.
+
 config PM_STD_PARTITION
 	string "Default resume partition"
 	depends on HIBERNATION
diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index 8d35b9f9aaa3..ed9901b75333 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -47,6 +47,15 @@ dev_t swsusp_resume_device;
 sector_t swsusp_resume_block;
 __visible int in_suspend __nosavedata;
 
+static const char *default_compressor = CONFIG_HIBERNATION_DEF_COMP;
+
+/*
+ * Compression/decompression algorithm to be used while saving/loading
+ * image to/from disk. This would later be used in 'kernel/power/swap.c'
+ * to allocate comp streams.
+ */
+char hib_comp_algo[CRYPTO_MAX_ALG_NAME];
+
 enum {
 	HIBERNATION_INVALID,
 	HIBERNATION_PLATFORM,
@@ -726,6 +735,17 @@ int hibernate(void)
 		return -EPERM;
 	}
 
+	/*
+	 * Query for the compression algorithm support if compression is enabled.
+	 */
+	if (!nocompress) {
+		strscpy(hib_comp_algo, default_compressor, sizeof(hib_comp_algo));
+		if (crypto_has_comp(hib_comp_algo, 0, 0) != 1) {
+			pr_err("%s compression is not available\n", hib_comp_algo);
+			return -EOPNOTSUPP;
+		}
+	}
+
 	sleep_flags = lock_system_sleep();
 	/* The snapshot device should not be opened while we're running */
 	if (!hibernate_acquire()) {
@@ -949,6 +969,19 @@ static int software_resume(void)
 	if (error)
 		goto Unlock;
 
+	/*
+	 * Check if the hibernation image is compressed. If so, query for
+	 * the algorithm support.
+	 */
+	if (!(swsusp_header_flags & SF_NOCOMPRESS_MODE)) {
+		strscpy(hib_comp_algo, default_compressor, sizeof(hib_comp_algo));
+		if (crypto_has_comp(hib_comp_algo, 0, 0) != 1) {
+			pr_err("%s compression is not available\n", hib_comp_algo);
+			error = -EOPNOTSUPP;
+			goto Unlock;
+		}
+	}
+
 	/* The snapshot device should not be opened while we're running */
 	if (!hibernate_acquire()) {
 		error = -EBUSY;
diff --git a/kernel/power/power.h b/kernel/power/power.h
index a98f95e309a3..d9bf10d92546 100644
--- a/kernel/power/power.h
+++ b/kernel/power/power.h
@@ -6,6 +6,7 @@
 #include <linux/compiler.h>
 #include <linux/cpu.h>
 #include <linux/cpuidle.h>
+#include <linux/crypto.h>
 
 struct swsusp_info {
 	struct new_utsname	uts;
@@ -54,6 +55,10 @@ asmlinkage int swsusp_save(void);
 
 /* kernel/power/hibernate.c */
 extern bool freezer_test_done;
+extern char hib_comp_algo[CRYPTO_MAX_ALG_NAME];
+
+/* kernel/power/swap.c */
+extern unsigned int swsusp_header_flags;
 
 extern int hibernation_snapshot(int platform_mode);
 extern int hibernation_restore(int platform_mode);
diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index 139fb33778a0..5ae68dab9cf8 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -23,7 +23,6 @@
 #include <linux/swapops.h>
 #include <linux/pm.h>
 #include <linux/slab.h>
-#include <linux/lzo.h>
 #include <linux/vmalloc.h>
 #include <linux/cpumask.h>
 #include <linux/atomic.h>
@@ -338,6 +337,13 @@ static int mark_swapfiles(struct swap_map_handle *handle, unsigned int flags)
 	return error;
 }
 
+/*
+ * Hold the swsusp_header flag. This is used in software_resume() in
+ * 'kernel/power/hibernate' to check if the image is compressed and query
+ * for the compression algorithm support(if so).
+ */
+unsigned int swsusp_header_flags;
+
 /**
  *	swsusp_swap_check - check if the resume device is a swap device
  *	and get its index (if so)
@@ -513,6 +519,12 @@ static int swap_writer_finish(struct swap_map_handle *handle,
 	return error;
 }
 
+/*
+ * Bytes we need for compressed data in worst case. We assume(limitation)
+ * this is the worst of all the compression algorithms.
+ */
+#define bytes_worst_compress(x) ((x) + ((x) / 16) + 64 + 3 + 2)
+
 /* We need to remember how much compressed data we need to read. */
 #define CMP_HEADER	sizeof(size_t)
 
@@ -521,7 +533,7 @@ static int swap_writer_finish(struct swap_map_handle *handle,
 #define UNC_SIZE	(UNC_PAGES * PAGE_SIZE)
 
 /* Number of pages we need for compressed data (worst case). */
-#define CMP_PAGES	DIV_ROUND_UP(lzo1x_worst_compress(UNC_SIZE) + \
+#define CMP_PAGES	DIV_ROUND_UP(bytes_worst_compress(UNC_SIZE) + \
 				CMP_HEADER, PAGE_SIZE)
 #define CMP_SIZE	(CMP_PAGES * PAGE_SIZE)
 
@@ -532,7 +544,6 @@ static int swap_writer_finish(struct swap_map_handle *handle,
 #define CMP_MIN_RD_PAGES	1024
 #define CMP_MAX_RD_PAGES	8192
 
-
 /**
  *	save_image - save the suspend image data
  */
@@ -628,6 +639,7 @@ static int crc32_threadfn(void *data)
  */
 struct cmp_data {
 	struct task_struct *thr;                  /* thread */
+	struct crypto_comp *cc;                   /* crypto compressor stream */
 	atomic_t ready;                           /* ready to start flag */
 	atomic_t stop;                            /* ready to stop flag */
 	int ret;                                  /* return code */
@@ -637,15 +649,18 @@ struct cmp_data {
 	size_t cmp_len;                           /* compressed length */
 	unsigned char unc[UNC_SIZE];              /* uncompressed buffer */
 	unsigned char cmp[CMP_SIZE];              /* compressed buffer */
-	unsigned char wrk[LZO1X_1_MEM_COMPRESS];  /* compression workspace */
 };
 
+/* Indicates the image size after compression */
+static atomic_t compressed_size = ATOMIC_INIT(0);
+
 /*
  * Compression function that runs in its own thread.
  */
 static int compress_threadfn(void *data)
 {
 	struct cmp_data *d = data;
+	unsigned int cmp_len = 0;
 
 	while (1) {
 		wait_event(d->go, atomic_read(&d->ready) ||
@@ -659,9 +674,13 @@ static int compress_threadfn(void *data)
 		}
 		atomic_set(&d->ready, 0);
 
-		d->ret = lzo1x_1_compress(d->unc, d->unc_len,
-					  d->cmp + CMP_HEADER, &d->cmp_len,
-					  d->wrk);
+		cmp_len = CMP_SIZE - CMP_HEADER;
+		d->ret = crypto_comp_compress(d->cc, d->unc, d->unc_len,
+					      d->cmp + CMP_HEADER,
+					      &cmp_len);
+		d->cmp_len = cmp_len;
+
+		atomic_set(&compressed_size, atomic_read(&compressed_size) + d->cmp_len);
 		atomic_set(&d->stop, 1);
 		wake_up(&d->done);
 	}
@@ -693,6 +712,8 @@ static int save_compressed_image(struct swap_map_handle *handle,
 
 	hib_init_batch(&hb);
 
+	atomic_set(&compressed_size, 0);
+
 	/*
 	 * We'll limit the number of threads for compression to limit memory
 	 * footprint.
@@ -702,14 +723,14 @@ static int save_compressed_image(struct swap_map_handle *handle,
 
 	page = (void *)__get_free_page(GFP_NOIO | __GFP_HIGH);
 	if (!page) {
-		pr_err("Failed to allocate compression page\n");
+		pr_err("Failed to allocate %s page\n", hib_comp_algo);
 		ret = -ENOMEM;
 		goto out_clean;
 	}
 
 	data = vzalloc(array_size(nr_threads, sizeof(*data)));
 	if (!data) {
-		pr_err("Failed to allocate compression data\n");
+		pr_err("Failed to allocate %s data\n", hib_comp_algo);
 		ret = -ENOMEM;
 		goto out_clean;
 	}
@@ -728,6 +749,13 @@ static int save_compressed_image(struct swap_map_handle *handle,
 		init_waitqueue_head(&data[thr].go);
 		init_waitqueue_head(&data[thr].done);
 
+		data[thr].cc = crypto_alloc_comp(hib_comp_algo, 0, 0);
+		if (IS_ERR_OR_NULL(data[thr].cc)) {
+			pr_err("Could not allocate comp stream %ld\n", PTR_ERR(data[thr].cc));
+			ret = -EFAULT;
+			goto out_clean;
+		}
+
 		data[thr].thr = kthread_run(compress_threadfn,
 		                            &data[thr],
 		                            "image_compress/%u", thr);
@@ -766,7 +794,7 @@ static int save_compressed_image(struct swap_map_handle *handle,
 	 */
 	handle->reqd_free_pages = reqd_free_pages();
 
-	pr_info("Using %u thread(s) for compression\n", nr_threads);
+	pr_info("Using %u thread(s) for %s compression\n", nr_threads, hib_comp_algo);
 	pr_info("Compressing and saving image data (%u pages)...\n",
 		nr_to_write);
 	m = nr_to_write / 10;
@@ -816,14 +844,14 @@ static int save_compressed_image(struct swap_map_handle *handle,
 			ret = data[thr].ret;
 
 			if (ret < 0) {
-				pr_err("compression failed\n");
+				pr_err("%s compression failed\n", hib_comp_algo);
 				goto out_finish;
 			}
 
 			if (unlikely(!data[thr].cmp_len ||
 			             data[thr].cmp_len >
-			             lzo1x_worst_compress(data[thr].unc_len))) {
-				pr_err("Invalid compressed length\n");
+				     bytes_worst_compress(data[thr].unc_len))) {
+				pr_err("Invalid %s compressed length\n", hib_comp_algo);
 				ret = -1;
 				goto out_finish;
 			}
@@ -861,6 +889,9 @@ static int save_compressed_image(struct swap_map_handle *handle,
 	if (!ret)
 		pr_info("Image saving done\n");
 	swsusp_show_speed(start, stop, nr_to_write, "Wrote");
+	pr_info("Image size after compression: %d kbytes\n",
+		(atomic_read(&compressed_size) / 1024));
+
 out_clean:
 	hib_finish_batch(&hb);
 	if (crc) {
@@ -869,9 +900,12 @@ static int save_compressed_image(struct swap_map_handle *handle,
 		kfree(crc);
 	}
 	if (data) {
-		for (thr = 0; thr < nr_threads; thr++)
+		for (thr = 0; thr < nr_threads; thr++) {
 			if (data[thr].thr)
 				kthread_stop(data[thr].thr);
+			if (data[thr].cc)
+				crypto_free_comp(data[thr].cc);
+		}
 		vfree(data);
 	}
 	if (page) free_page((unsigned long)page);
@@ -1112,6 +1146,7 @@ static int load_image(struct swap_map_handle *handle,
  */
 struct dec_data {
 	struct task_struct *thr;                  /* thread */
+	struct crypto_comp *cc;                   /* crypto compressor stream */
 	atomic_t ready;                           /* ready to start flag */
 	atomic_t stop;                            /* ready to stop flag */
 	int ret;                                  /* return code */
@@ -1129,6 +1164,7 @@ struct dec_data {
 static int decompress_threadfn(void *data)
 {
 	struct dec_data *d = data;
+	unsigned int unc_len = 0;
 
 	while (1) {
 		wait_event(d->go, atomic_read(&d->ready) ||
@@ -1142,9 +1178,11 @@ static int decompress_threadfn(void *data)
 		}
 		atomic_set(&d->ready, 0);
 
-		d->unc_len = UNC_SIZE;
-		d->ret = lzo1x_decompress_safe(d->cmp + CMP_HEADER, d->cmp_len,
-					       d->unc, &d->unc_len);
+		unc_len = UNC_SIZE;
+		d->ret = crypto_comp_decompress(d->cc, d->cmp + CMP_HEADER, d->cmp_len,
+						d->unc, &unc_len);
+		d->unc_len = unc_len;
+
 		if (clean_pages_on_decompress)
 			flush_icache_range((unsigned long)d->unc,
 					   (unsigned long)d->unc + d->unc_len);
@@ -1192,14 +1230,14 @@ static int load_compressed_image(struct swap_map_handle *handle,
 
 	page = vmalloc(array_size(CMP_MAX_RD_PAGES, sizeof(*page)));
 	if (!page) {
-		pr_err("Failed to allocate compression page\n");
+		pr_err("Failed to allocate %s page\n", hib_comp_algo);
 		ret = -ENOMEM;
 		goto out_clean;
 	}
 
 	data = vzalloc(array_size(nr_threads, sizeof(*data)));
 	if (!data) {
-		pr_err("Failed to allocate compression data\n");
+		pr_err("Failed to allocate %s data\n", hib_comp_algo);
 		ret = -ENOMEM;
 		goto out_clean;
 	}
@@ -1220,6 +1258,13 @@ static int load_compressed_image(struct swap_map_handle *handle,
 		init_waitqueue_head(&data[thr].go);
 		init_waitqueue_head(&data[thr].done);
 
+		data[thr].cc = crypto_alloc_comp(hib_comp_algo, 0, 0);
+		if (IS_ERR_OR_NULL(data[thr].cc)) {
+			pr_err("Could not allocate comp stream %ld\n", PTR_ERR(data[thr].cc));
+			ret = -EFAULT;
+			goto out_clean;
+		}
+
 		data[thr].thr = kthread_run(decompress_threadfn,
 		                            &data[thr],
 		                            "image_decompress/%u", thr);
@@ -1272,7 +1317,7 @@ static int load_compressed_image(struct swap_map_handle *handle,
 		if (!page[i]) {
 			if (i < CMP_PAGES) {
 				ring_size = i;
-				pr_err("Failed to allocate compression pages\n");
+				pr_err("Failed to allocate %s pages\n", hib_comp_algo);
 				ret = -ENOMEM;
 				goto out_clean;
 			} else {
@@ -1282,7 +1327,7 @@ static int load_compressed_image(struct swap_map_handle *handle,
 	}
 	want = ring_size = i;
 
-	pr_info("Using %u thread(s) for decompression\n", nr_threads);
+	pr_info("Using %u thread(s) for %s decompression\n", nr_threads, hib_comp_algo);
 	pr_info("Loading and decompressing image data (%u pages)...\n",
 		nr_to_read);
 	m = nr_to_read / 10;
@@ -1343,8 +1388,8 @@ static int load_compressed_image(struct swap_map_handle *handle,
 			data[thr].cmp_len = *(size_t *)page[pg];
 			if (unlikely(!data[thr].cmp_len ||
 			             data[thr].cmp_len >
-					lzo1x_worst_compress(UNC_SIZE))) {
-				pr_err("Invalid compressed length\n");
+					bytes_worst_compress(UNC_SIZE))) {
+				pr_err("Invalid %s compressed length\n", hib_comp_algo);
 				ret = -1;
 				goto out_finish;
 			}
@@ -1395,14 +1440,14 @@ static int load_compressed_image(struct swap_map_handle *handle,
 			ret = data[thr].ret;
 
 			if (ret < 0) {
-				pr_err("decompression failed\n");
+				pr_err("%s decompression failed\n", hib_comp_algo);
 				goto out_finish;
 			}
 
 			if (unlikely(!data[thr].unc_len ||
 				data[thr].unc_len > UNC_SIZE ||
 				data[thr].unc_len & (PAGE_SIZE - 1))) {
-				pr_err("Invalid uncompressed length\n");
+				pr_err("Invalid %s uncompressed length\n", hib_comp_algo);
 				ret = -1;
 				goto out_finish;
 			}
@@ -1463,9 +1508,12 @@ static int load_compressed_image(struct swap_map_handle *handle,
 		kfree(crc);
 	}
 	if (data) {
-		for (thr = 0; thr < nr_threads; thr++)
+		for (thr = 0; thr < nr_threads; thr++) {
 			if (data[thr].thr)
 				kthread_stop(data[thr].thr);
+			if (data[thr].cc)
+				crypto_free_comp(data[thr].cc);
+		}
 		vfree(data);
 	}
 	vfree(page);
@@ -1534,6 +1582,7 @@ int swsusp_check(bool exclusive)
 
 		if (!memcmp(HIBERNATE_SIG, swsusp_header->sig, 10)) {
 			memcpy(swsusp_header->sig, swsusp_header->orig_sig, 10);
+			swsusp_header_flags = swsusp_header->flags;
 			/* Reset swap signature now */
 			error = hib_submit_io(REQ_OP_WRITE | REQ_SYNC,
 						swsusp_resume_block,
-- 
2.17.1

