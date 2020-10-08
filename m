Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8777C286FAE
	for <lists+linux-pm@lfdr.de>; Thu,  8 Oct 2020 09:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbgJHHks (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Oct 2020 03:40:48 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:46033 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727213AbgJHHks (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Oct 2020 03:40:48 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20201008074045epoutp01ef05c8dd71abdcf9eb14d085ec46fc20~79G3zoyIi1021010210epoutp01I
        for <linux-pm@vger.kernel.org>; Thu,  8 Oct 2020 07:40:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20201008074045epoutp01ef05c8dd71abdcf9eb14d085ec46fc20~79G3zoyIi1021010210epoutp01I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1602142845;
        bh=MCtneW5ZW/xmqkxzmXsjRSEsnWZHb9ZS23VNZRV6ibc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n+VbEf0aSLLGfrngWsKOd01UpzqHgyKL3pAeHoqRKD0VaunNfhM3dP36BA+xiVE5z
         vkGzNsJHULcpF4rUDx8WTSNb7YXd1eUiH0JNMVR62LjsXb96RMuqD0jwlmbBOSSk9H
         fR/VHgs1pDg2nglIWj7ox6NiYUVK6/WbOlbb/sUw=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20201008074044epcas1p434b3e3a72e061d241efb67191e9be50b~79G3F1xJS2323723237epcas1p40;
        Thu,  8 Oct 2020 07:40:44 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.158]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4C6NRG1Pk5zMqYkx; Thu,  8 Oct
        2020 07:40:42 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        58.BC.09582.972CE7F5; Thu,  8 Oct 2020 16:40:42 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20201008074041epcas1p4d2b9c36c5b3fef5c10db602b9d90c2aa~79G0E4tq42323723237epcas1p4t;
        Thu,  8 Oct 2020 07:40:41 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20201008074041epsmtrp268fbdd1dc89a06c212a1749305d634b4~79G0D4AYR0844008440epsmtrp2-;
        Thu,  8 Oct 2020 07:40:41 +0000 (GMT)
X-AuditID: b6c32a37-899ff7000000256e-c9-5f7ec279fc14
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        8D.5D.08745.972CE7F5; Thu,  8 Oct 2020 16:40:41 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20201008074041epsmtip1ad808c752984c3329a97746b32478c0f~79Gz3hu3j3022330223epsmtip1r;
        Thu,  8 Oct 2020 07:40:41 +0000 (GMT)
From:   Chanwoo Choi <cw00.choi@samsung.com>
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     mka@chromium.org, rostedt@goodmis.org, mingo@redhat.com,
        cw00.choi@samsung.com, chanwoo@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com
Subject: [PATCH 3/3] PM / devfreq: Add tracepoint for frequency changes
Date:   Thu,  8 Oct 2020 16:54:03 +0900
Message-Id: <20201008075403.26181-4-cw00.choi@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201008075403.26181-1-cw00.choi@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLKsWRmVeSWpSXmKPExsWy7bCmrm7Vobp4g/52RouJN66wWFz/8pzV
        4mzTG3aLy7vmsFl87j3CaHHpwAImi88bHjNa3G5cwWaxr+MBkwOnx+yGiyweLftusXtsWtXJ
        5vF+31U2j74tqxg9Pm+SC2CLyrbJSE1MSS1SSM1Lzk/JzEu3VfIOjneONzUzMNQ1tLQwV1LI
        S8xNtVVy8QnQdcvMAbpKSaEsMacUKBSQWFyspG9nU5RfWpKqkJFfXGKrlFqQklNgWaBXnJhb
        XJqXrpecn2tlaGBgZApUmJCdMf12F0vBFOGKyQsnMTcwLhDoYuTkkBAwkVh04yJLFyMXh5DA
        DkaJn53/mSGcT4wSF7e9Z4RwPjNKHFhxgRGm5dTkQ2wQiV2MEuvnHGOHcL4wSsw7ehqsik1A
        S2L/ixtsILaIgJXE6f8dYHOZBeYzSvy9+xOsSFjAXeLZqc1MXYwcHCwCqhL9F8RBwrxA9R0/
        XrJBbJOXWL3hADOIzSlgLfH99A+wORICj9glfrzdwQpR5CJx+M0KJghbWOLV8S3sELaUxOd3
        e6EGVUusPHmEDaK5g1Fiy/4LUM3GEvuXTgY7gllAU2L9Ln2IsKLEzt9zwe5kFuCTePe1hxWk
        REKAV6KjTQiiRFni8oO7UGslJRa3d0Kt8pBom/WIFRIofYwSeyc2ME9glJuFsGEBI+MqRrHU
        guLc9NRiwwJj5DjbxAhOd1rmOxinvf2gd4iRiYPxEKMEB7OSCG+6d028EG9KYmVValF+fFFp
        TmrxIUZTYOBNZJYSTc4HJty8knhDUyNjY2MLE0MzU0NDJXHeh7cU4oUE0hNLUrNTUwtSi2D6
        mDg4pRqYtpwP0LjCrnjEy8Hbim8pw4tnTnmNE+fcmnrOo/RwSwDH7ek+SvNM53FwrHhT5Npz
        6Oi2VTr8TqcFAx9dcgjasE7UriCi4ITq2puzP4k9qtya++uwQ07OeqbvM6WiDl9vvlXMdSr5
        7mXDMydenvMu6jVgtuaseJR24Od0xqoPFXFivElZmUwPNxaxGJjcmvF45e8WTVYXfl8/w3ui
        rAUHDrmYTX42repbOYfapRmCdzk+HH4q2bEw5WDKM7dL5h/u1FR8nXX24brMiMAtCx0ExMz3
        x2eVJm5dsbc+66XOG86d+zbHiR4QWyxqv1RsdWr4nIPLrz12seiKaZu5u7LerStYJY1j1Z3s
        FSW5AtHmSizFGYmGWsxFxYkAiD8zgwAEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCLMWRmVeSWpSXmKPExsWy7bCSnG7lobp4g67/khYTb1xhsbj+5Tmr
        xdmmN+wWl3fNYbP43HuE0eLSgQVMFp83PGa0uN24gs1iX8cDJgdOj9kNF1k8WvbdYvfYtKqT
        zeP9vqtsHn1bVjF6fN4kF8AWxWWTkpqTWZZapG+XwJUx/XYXS8EU4YrJCycxNzAuEOhi5OSQ
        EDCRODX5EFsXIxeHkMAORonH3ctZIRKSEtMuHmXuYuQAsoUlDh8uhqj5xCgx68lNdpAaNgEt
        if0vbrCB2CICNhJ3F19jAbGZBZYzSsxtFQSxhQXcJZ6d2swEModFQFWi/4I4SJhXwEqi48dL
        NohV8hKrNxxgBrE5Bawlvp/+AWYLAdWs3PeEaQIj3wJGhlWMkqkFxbnpucWGBUZ5qeV6xYm5
        xaV56XrJ+bmbGMEBqaW1g3HPqg96hxiZOBgPMUpwMCuJ8KZ718QL8aYkVlalFuXHF5XmpBYf
        YpTmYFES5/06a2GckEB6YklqdmpqQWoRTJaJg1OqgWn6k5jwoy52hlPnxOw/tvdHWMsslWv7
        VBhnsroVfIhgvbhq3dEXzZc+lGoZSfUVlpxuv6S0+oGM04+Vl3czFmQlhFy5YX9/l63nY+ub
        jb4L7SdzKxZ8UHpWMlGm3npOyUwj0Sv232Z+9foyu1OtNLBur/HHh+FyFgoFLQfkjkadYT//
        50Xo+bXS5iun97SWfXl2+i/38wTb5B+zlB4F9LhN2ubaufNOq6XTnKa/Tl+LmyM5XknOZ2ZJ
        /c625ZJ5pXL3bcEd1gYnFlsxfIpQ33vF7uB9wfOpD1wmKU3v0DbeJjdpokFItPHrsPoC7fdy
        1tr7Pb0Mhbjnuf7NrJY4wLeVf3GSqOsr5sSfVnveJCqxFGckGmoxFxUnAgCEz+sHtwIAAA==
X-CMS-MailID: 20201008074041epcas1p4d2b9c36c5b3fef5c10db602b9d90c2aa
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20201008074041epcas1p4d2b9c36c5b3fef5c10db602b9d90c2aa
References: <20201008075403.26181-1-cw00.choi@samsung.com>
        <CGME20201008074041epcas1p4d2b9c36c5b3fef5c10db602b9d90c2aa@epcas1p4.samsung.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Matthias Kaehlcke <mka@chromium.org>

Add a tracepoint for frequency changes of devfreq devices and
use it.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
[cw00.choi: Move print position of tracepoint and add more information]
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/devfreq/devfreq.c      |  8 ++++++++
 include/trace/events/devfreq.h | 28 ++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 5b069a8a1026..d4c4aa050efa 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -369,6 +369,14 @@ static int devfreq_set_target(struct devfreq *devfreq, unsigned long new_freq,
 		return err;
 	}
 
+	/*
+	 * Print devfreq_frequency trace information between DEVFREQ_PRECHANGE
+	 * and DEVFREQ_POSTCHANGE because for showing the correct frequency
+	 * change order of between devfreq device and passive devfreq device.
+	 */
+	if (trace_devfreq_frequency_enabled() && new_freq != cur_freq)
+		trace_devfreq_frequency(devfreq, new_freq, cur_freq);
+
 	freqs.new = new_freq;
 	devfreq_notify_transition(devfreq, &freqs, DEVFREQ_POSTCHANGE);
 
diff --git a/include/trace/events/devfreq.h b/include/trace/events/devfreq.h
index bd36d28d16bc..7627c620bbda 100644
--- a/include/trace/events/devfreq.h
+++ b/include/trace/events/devfreq.h
@@ -8,6 +8,34 @@
 #include <linux/devfreq.h>
 #include <linux/tracepoint.h>
 
+TRACE_EVENT(devfreq_frequency,
+	TP_PROTO(struct devfreq *devfreq, unsigned long freq,
+		 unsigned long prev_freq),
+
+	TP_ARGS(devfreq, freq, prev_freq),
+
+	TP_STRUCT__entry(
+		__string(dev_name, dev_name(&devfreq->dev))
+		__field(unsigned long, freq)
+		__field(unsigned long, prev_freq)
+		__field(unsigned long, busy_time)
+		__field(unsigned long, total_time)
+	),
+
+	TP_fast_assign(
+		__assign_str(dev_name, dev_name(&devfreq->dev));
+		__entry->freq = freq;
+		__entry->prev_freq = prev_freq;
+		__entry->busy_time = devfreq->last_status.busy_time;
+		__entry->total_time = devfreq->last_status.total_time;
+	),
+
+	TP_printk("dev_name=%-30s freq=%-12lu prev_freq=%-12lu load=%-2lu",
+		__get_str(dev_name), __entry->freq, __entry->prev_freq,
+		__entry->total_time == 0 ? 0 :
+			(100 * __entry->busy_time) / __entry->total_time)
+);
+
 TRACE_EVENT(devfreq_monitor,
 	TP_PROTO(struct devfreq *devfreq),
 
-- 
2.17.1

