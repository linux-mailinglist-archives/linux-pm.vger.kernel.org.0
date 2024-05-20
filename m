Return-Path: <linux-pm+bounces-8001-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BC5E8CA26B
	for <lists+linux-pm@lfdr.de>; Mon, 20 May 2024 20:58:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D1851C2102B
	for <lists+linux-pm@lfdr.de>; Mon, 20 May 2024 18:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F741386DF;
	Mon, 20 May 2024 18:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DLwMdlwM"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F21C11184
	for <linux-pm@vger.kernel.org>; Mon, 20 May 2024 18:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716231506; cv=none; b=XivxCNkom1lwS4+GermJP9ZpTh4C8L2sw7JAJKPgRQZEfF3yFevJkCIvbHVfmm26+PesLexp8EaN/iMFn2ukR3P8YWplW5eQJOOGVqrQ5ERbBnvi5NltnjTbPvOlrxbB0X3IMUZiIA5kYlcSN50IagqthocXF/PTSY999m1SpTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716231506; c=relaxed/simple;
	bh=a+eA01vjVkP3G5nFgnuhnP1gKtaM1FSkoDTcoDq1BTs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d1MZ4Mggf9SkrnjHWvZfughv0rfMlguL1hFBvft3HzEdEdv2P/VLhF//WhrrWgD6FDavJwJRRK2PkhrZKNP49k2eY2ZcuEHzkSApXmplCwdKpOYGj4TzW+OML3rPttMCTTZeobFh3klmVbAPDVsOal9MYil7y+XPtYyJsFVSYX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DLwMdlwM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716231503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dl4+SLBeFPnriuBwYnryUMkurFVrv5hxlqLG9E31XsI=;
	b=DLwMdlwM3sxzzc2exIbSidQAu2hscf+KJWidhX91uSqhY6uCMTbb7RXF8D6zQLzCE2tklH
	W/0pzfkTOHZRtqAL9Y9u0JD7nNum9UD4BL2eB523jvQnTBp4UKrz0PE9WXRCaVleGvktUj
	FsNydgz4hh/X12HZUMdHUgH+Ftyprec=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-tnOtF_v7M-ide5nKun1KlQ-1; Mon, 20 May 2024 14:58:19 -0400
X-MC-Unique: tnOtF_v7M-ide5nKun1KlQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 51AFA101A525;
	Mon, 20 May 2024 18:58:18 +0000 (UTC)
Received: from dba-icx.bos.redhat.com (prarit2023-dbaguest.khw.eng.bos2.dc.redhat.com [10.26.1.94])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2BDBA200A78F;
	Mon, 20 May 2024 18:58:18 +0000 (UTC)
From: David Arcari <darcari@redhat.com>
To: linux-pm@vger.kernel.org
Cc: David Arcari <darcari@redhat.com>,
	Len Brown <lenb@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] tools/power turbostat: make the '-n' command line argument work in all cases
Date: Mon, 20 May 2024 14:57:49 -0400
Message-ID: <20240520185749.1404283-1-darcari@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

In some cases specifying the '-n' command line argument will cause
turbostat to fail.  For instance 'turbostat -n 1' works fine; however,
'turbostat -n 1 -d' will fail.  This is the result of the first call
to getopt_long_only() where "MP" is specified as the optstring.  This can
be easily fixed by changing the optstring from "MP" to "MPn:" to remove
ambiguity between the arguments.

Signed-off-by: David Arcari <darcari@redhat.com>
Cc: Len Brown <lenb@kernel.org>
Cc: linux-kernel@vger.kernel.org
---
 tools/power/x86/turbostat/turbostat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 98256468e248..8071a3ef2a2e 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -7851,7 +7851,7 @@ void cmdline(int argc, char **argv)
 	 * Parse some options early, because they may make other options invalid,
 	 * like adding the MSR counter with --add and at the same time using --no-msr.
 	 */
-	while ((opt = getopt_long_only(argc, argv, "MP", long_options, &option_index)) != -1) {
+	while ((opt = getopt_long_only(argc, argv, "MPn:", long_options, &option_index)) != -1) {
 		switch (opt) {
 		case 'M':
 			no_msr = 1;
-- 
2.44.0


