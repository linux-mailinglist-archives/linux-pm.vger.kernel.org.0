Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8BEC274663
	for <lists+linux-pm@lfdr.de>; Tue, 22 Sep 2020 18:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgIVQTY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Sep 2020 12:19:24 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:49891 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbgIVQTY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Sep 2020 12:19:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1600791563; x=1632327563;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=sbYPZK8xnT+me5+gN8PP0qGeozCdiHbdq5mlbrBADxM=;
  b=vGLdX33b8dUkwIUw3qSyblNtQZ2QfYqfxc3e7tiOnMFfu6aXGJeBDgxh
   VHNsWup5TZxBFfAAaucnSmA1Bg/BCJOy1y5C4EyvNnjbM0s/ItMHb7anr
   R2FHNOeJLWU59McKRz6Mm8XxE7hkIUEKe681DFJ121j3WiZQd7Tc6LjYT
   M=;
X-IronPort-AV: E=Sophos;i="5.77,291,1596499200"; 
   d="scan'208";a="55377844"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1a-af6a10df.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 22 Sep 2020 16:19:22 +0000
Received: from EX13MTAUWA001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-1a-af6a10df.us-east-1.amazon.com (Postfix) with ESMTPS id 1668AA1D56;
        Tue, 22 Sep 2020 16:19:19 +0000 (UTC)
Received: from EX13D07UWA001.ant.amazon.com (10.43.160.145) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.58) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 22 Sep 2020 16:19:19 +0000
Received: from EX13D12UWA002.ant.amazon.com (10.43.160.88) by
 EX13D07UWA001.ant.amazon.com (10.43.160.145) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 22 Sep 2020 16:19:19 +0000
Received: from EX13D12UWA002.ant.amazon.com ([10.43.160.88]) by
 EX13D12UWA002.ant.amazon.com ([10.43.160.88]) with mapi id 15.00.1497.006;
 Tue, 22 Sep 2020 16:19:19 +0000
From:   "Chen, Xiaoyi" <cxiaoyi@amazon.com>
To:     "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
CC:     "Agarwal, Anchal" <anchalag@amazon.com>,
        "Duncan, David" <davdunc@amazon.com>,
        "dchinner@redhat.com" <dchinner@redhat.com>,
        "esandeen@redhat.com" <esandeen@redhat.com>
Subject: [PATCH] PM: Batch hibernate and resume IO requests
Thread-Topic: [PATCH] PM: Batch hibernate and resume IO requests
Thread-Index: AdaQ+2sK1P/qE6qvS5Gln2Uc8epdqg==
Date:   Tue, 22 Sep 2020 16:19:19 +0000
Message-ID: <cc09f36e506145399fe470c71ad34c7c@EX13D12UWA002.ant.amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.162.73]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Hibernate and resume process submits individual IO requests for each page
of the data. With this patch, we use blk_plug to improve the batching of
these requests.

Tested this patch with hibernate and resumes, and consistently observed the
merging of the IO requests. We see more than an order of magnitude
improvement in hibernate and resume speed.

One hibernate and resume cycle for 16GB used RAM out of 32GB takes around
21 minutes before the change, and 1 minutes after the change on systems
with limited storage IOPS.

Signed-off-by: Xiaoyi Chen <cxiaoyi@amazon.com>
Signed-off-by: Anchal Agarwal <anchalag@amazon.com>
---
 kernel/power/swap.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index 01e2858b5fe3..961615365b5c 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -226,6 +226,7 @@ struct hib_bio_batch {
        atomic_t                count;
        wait_queue_head_t       wait;
        blk_status_t            error;
+       struct blk_plug         plug;
 };

 static void hib_init_batch(struct hib_bio_batch *hb)
@@ -233,6 +234,12 @@ static void hib_init_batch(struct hib_bio_batch *hb)
        atomic_set(&hb->count, 0);
        init_waitqueue_head(&hb->wait);
        hb->error =3D BLK_STS_OK;
+       blk_start_plug(&hb->plug);
+}
+
+static void hib_finish_batch(struct hib_bio_batch *hb)
+{
+       blk_finish_plug(&hb->plug);
 }

 static void hib_end_io(struct bio *bio)
@@ -294,6 +301,10 @@ static int hib_submit_io(int op, int op_flags, pgoff_t=
 page_off, void *addr,

 static blk_status_t hib_wait_io(struct hib_bio_batch *hb)
 {
+       /*
+        * We are relying on the behavior of blk_plug that a thread with
+        * a plug will flush the plug list before sleeping.
+        */
        wait_event(hb->wait, atomic_read(&hb->count) =3D=3D 0);
        return blk_status_to_errno(hb->error);
 }
@@ -561,6 +572,7 @@ static int save_image(struct swap_map_handle *handle,
                nr_pages++;
        }
        err2 =3D hib_wait_io(&hb);
+       hib_finish_batch(&hb);
        stop =3D ktime_get();
        if (!ret)
                ret =3D err2;
@@ -854,6 +866,7 @@ static int save_image_lzo(struct swap_map_handle *handl=
e,
                pr_info("Image saving done\n");
        swsusp_show_speed(start, stop, nr_to_write, "Wrote");
 out_clean:
+       hib_finish_batch(&hb);
        if (crc) {
                if (crc->thr)
                        kthread_stop(crc->thr);
@@ -1084,6 +1097,7 @@ static int load_image(struct swap_map_handle *handle,
                nr_pages++;
        }
        err2 =3D hib_wait_io(&hb);
+       hib_finish_batch(&hb);
        stop =3D ktime_get();
        if (!ret)
                ret =3D err2;
@@ -1447,6 +1461,7 @@ static int load_image_lzo(struct swap_map_handle *han=
dle,
        }
        swsusp_show_speed(start, stop, nr_to_read, "Read");
 out_clean:
+       hib_finish_batch(&hb);
        for (i =3D 0; i < ring_size; i++)
                free_page((unsigned long)page[i]);
        if (crc) {
--
2.23.3

