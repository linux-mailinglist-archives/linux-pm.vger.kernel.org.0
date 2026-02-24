Return-Path: <linux-pm+bounces-43142-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aDaQEqOYnWnwQgQAu9opvQ
	(envelope-from <linux-pm+bounces-43142-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 24 Feb 2026 13:25:07 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C1008186EA8
	for <lists+linux-pm@lfdr.de>; Tue, 24 Feb 2026 13:25:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0BABF311A703
	for <lists+linux-pm@lfdr.de>; Tue, 24 Feb 2026 12:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F39396D16;
	Tue, 24 Feb 2026 12:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JSVmqfsi"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBD7396D03
	for <linux-pm@vger.kernel.org>; Tue, 24 Feb 2026 12:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771935682; cv=none; b=Fagw9esJTkbpKUo2Y0+mfQNDpArUPY0IHqB/JHPao7jHML7jAyfwMBOuA17P8Mu3Fyc5aB9e48CAF1ofYT0DumcmxSOGjCh3o9Dbf6O2Aw8HUDmu71xUt4xpwqnHG2qMAwbJdAYCkiANme4VVxah1oTOF0fHd9CNUWsziSi6esg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771935682; c=relaxed/simple;
	bh=Z7lG3+MmWUHSBEpYz2jAKp2j1jBFLDcncGLZgsmhgmA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b/C+4ymELaTzywoRg1cAshs3KcuM7BiRLoc9p3cXPoT0MuhyqrGpEiwmfrXKMnfRrxihyD/juDjwkgQcdgu7KWeBZI2ONvivmvKrWu2smSU/hh8C3+V3iKKm214qsajdsA1XBpXPvt3qU7iYi2ywD2E5bDYAkxfCkASfUxDSn4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JSVmqfsi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771935680;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=D7Gfr7GUfvWmA2TjaJIS+S17ZwfwsborvxzxZUcJTAo=;
	b=JSVmqfsi4fJXThd1YfIw2wM6mYohyV7GDk/i2R6g//OSZljk995T4ia94op3+w76ajH9l5
	CjD6wJu1MreEVH4XBQKb5et7UciiYPZJR0SjI59CNQUO9LZ5XZ3JwaVexz+pzTiS6aA4n+
	8fmkpbHmZvolVS3i1sfR0JzJzQjdi3w=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-689-F4yYw0GrOBSolj6ea0XI3A-1; Tue,
 24 Feb 2026 07:21:16 -0500
X-MC-Unique: F4yYw0GrOBSolj6ea0XI3A-1
X-Mimecast-MFC-AGG-ID: F4yYw0GrOBSolj6ea0XI3A_1771935675
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 198171800365;
	Tue, 24 Feb 2026 12:21:15 +0000 (UTC)
Received: from dba-icx.bos.redhat.com (prarit2023-dbaguest.khw.eng.bos2.dc.redhat.com [10.26.1.94])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7CDAD1955F43;
	Tue, 24 Feb 2026 12:21:13 +0000 (UTC)
From: David Arcari <darcari@redhat.com>
To: srinivas.pandruvada@linux.intel.com,
	lenb@kernel.org,
	rafael@kernel.org
Cc: viresh.kumar@linaro.org,
	zhangzihuan@kylinos.cn,
	jhladky@redhat.com,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Arcari <darcari@redhat.com>
Subject: [PATCH] cpufreq: intel_pstate: Fix NULL pointer dereference in update_cpu_qos_request()
Date: Tue, 24 Feb 2026 07:21:06 -0500
Message-ID: <20260224122106.228116-1-darcari@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43142-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[darcari@redhat.com,linux-pm@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C1008186EA8
X-Rspamd-Action: no action

The update_cpu_qos_request() function attempts to initialize the 'freq'
variable by dereferencing 'cpudata' before verifying if the 'policy'
is valid.

This issue occurs on systems booted with the "nosmt" parameter, where
all_cpu_data[cpu] is NULL for the SMT sibling threads. As a result,
any call to update_qos_requests() will result in a NULL pointer
dereference as the code will attempt to access pstate.turbo_freq using
the NULL cpudata pointer.

Fix this by deferring the 'freq' assignment until after the policy and
driver_data have been validated.

Fixes: ae1bdd23b99f ("cpufreq: intel_pstate: Adjust frequency percentage computations")
Reported-by: Jirka Hladky <jhladky@redhat.com>
Closes: https://lore.kernel.org/all/CAE4VaGDfiPvz3AzrwrwM4kWB3SCkMci25nPO8W1JmTBd=xHzZg@mail.gmail.com/
Signed-off-by: David Arcari <darcari@redhat.com>
---
 drivers/cpufreq/intel_pstate.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index a48af3540c74..bdc37080d319 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1647,8 +1647,8 @@ static ssize_t store_no_turbo(struct kobject *a, struct kobj_attribute *b,
 static void update_cpu_qos_request(int cpu, enum freq_qos_req_type type)
 {
 	struct cpudata *cpudata = all_cpu_data[cpu];
-	unsigned int freq = cpudata->pstate.turbo_freq;
 	struct freq_qos_request *req;
+	unsigned int freq;
 
 	struct cpufreq_policy *policy __free(put_cpufreq_policy) = cpufreq_cpu_get(cpu);
 	if (!policy)
@@ -1661,6 +1661,8 @@ static void update_cpu_qos_request(int cpu, enum freq_qos_req_type type)
 	if (hwp_active)
 		intel_pstate_get_hwp_cap(cpudata);
 
+	freq = cpudata->pstate.turbo_freq;
+
 	if (type == FREQ_QOS_MIN) {
 		freq = DIV_ROUND_UP(freq * global.min_perf_pct, 100);
 	} else {
-- 
2.52.0


