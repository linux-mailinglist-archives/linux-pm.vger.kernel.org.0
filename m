Return-Path: <linux-pm+bounces-898-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0930E80CF13
	for <lists+linux-pm@lfdr.de>; Mon, 11 Dec 2023 16:08:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B458B2818D3
	for <lists+linux-pm@lfdr.de>; Mon, 11 Dec 2023 15:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC54B4A9AA;
	Mon, 11 Dec 2023 15:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="jY7hqMIZ"
X-Original-To: linux-pm@vger.kernel.org
X-Greylist: delayed 903 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 11 Dec 2023 07:08:14 PST
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.214])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 322E8D6;
	Mon, 11 Dec 2023 07:08:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=fHo18
	EM+IcnpLBqW24a0AePPsWSsCxUc4nRjtM6qLxY=; b=jY7hqMIZSjO2fVU++2hiR
	pmXvJrXqrGh9gg76HzxuZWLuypmIk5EkGQ2SgnbwwzwWEFjAoaNyAk8LdgkVim5N
	9CsAobMQv14zYiUVreMgHeoXvWRxExYe/8PgH4NhprPevMolo/sro3VTZApHBpO3
	V5ngZlGu7XQ47KDL5K4RDE=
Received: from ubuntu22.localdomain (unknown [117.176.219.50])
	by zwqz-smtp-mta-g5-3 (Coremail) with SMTP id _____wDXn1gqIndlz9+RFQ--.6479S2;
	Mon, 11 Dec 2023 22:52:27 +0800 (CST)
From: chenguanxi11234@163.com
To: rafael@kernel.org
Cc: pavel@ucw.cz,
	len.brown@intel.com,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chen Haonan <chen.haonan2@zte.com.cn>
Subject: [PATCH linux-next] kernel/power: Use kmap_local_page() in snapshot.c
Date: Mon, 11 Dec 2023 22:52:24 +0800
Message-Id: <b2fd8c52429b51fc0c060753e6b616f1edf81d92.1702020689.git.chen.haonan2@zte.com.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXn1gqIndlz9+RFQ--.6479S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WF13CFy5Aw45Xr43WFyDZFb_yoW8WrWkpF
	43AFyDG3yYvFW8t342qF1v9ry5JwnIyw4fXrW3A3WfXrnxWwnIvr10qa1Ut3W3trW7JFWr
	ZrZrtFWvyFs5GwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jtiSdUUUUU=
X-CM-SenderInfo: xfkh0wxxdq5xirrsjki6rwjhhfrp/xtbBhhRD+lc664ndOwABsD

From: Chen Haonan <chen.haonan2@zte.com.cn>

kmap_atomic() has been deprecated in favor of kmap_local_page().

Each call to kmap_atomic() in the kernel creates a non-preemptable
segment and disables the missing page exception. This can be one of
the sources of unexpected latency. Therefore users should choose
kmap_local_page() over kmap_atomic().

Signed-off-by: Chen Haonan <chen.haonan2@zte.com.cn>
---
 kernel/power/snapshot.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)
diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index 50a15408c3fc..feef0d4d3288 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -1487,11 +1487,11 @@ static bool copy_data_page(unsigned long dst_pfn, unsigned long src_pfn)
 	s_page = pfn_to_page(src_pfn);
 	d_page = pfn_to_page(dst_pfn);
 	if (PageHighMem(s_page)) {
-		src = kmap_atomic(s_page);
-		dst = kmap_atomic(d_page);
+		src = kmap_local_page(s_page);
+		dst = kmap_local_page(d_page);
 		zeros_only = do_copy_page(dst, src);
-		kunmap_atomic(dst);
-		kunmap_atomic(src);
+		kunmap_local(dst);
+		kunmap_local(src);
 	} else {
 		if (PageHighMem(d_page)) {
 			/*
@@ -1499,9 +1499,9 @@ static bool copy_data_page(unsigned long dst_pfn, unsigned long src_pfn)
 			 * data modified by kmap_atomic()
 			 */
 			zeros_only = safe_copy_page(buffer, s_page);
-			dst = kmap_atomic(d_page);
+			dst = kmap_local_page(d_page);
 			copy_page(dst, buffer);
-			kunmap_atomic(dst);
+			kunmap_local(dst);
 		} else {
 			zeros_only = safe_copy_page(page_address(d_page), s_page);
 		}
-- 
2.25.1


