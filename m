Return-Path: <linux-pm+bounces-38184-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC61C6A7B9
	for <lists+linux-pm@lfdr.de>; Tue, 18 Nov 2025 17:03:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D15A435F101
	for <lists+linux-pm@lfdr.de>; Tue, 18 Nov 2025 15:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0385F364E98;
	Tue, 18 Nov 2025 15:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="goHw1NoV"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303E92F39BF
	for <linux-pm@vger.kernel.org>; Tue, 18 Nov 2025 15:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763481515; cv=none; b=XNHD2kESy/PpebXMSfnl9InfNu+gbpZ0+FaZr3etV0xOl/GeYO57EbiBXmLN1f+LxS4fsjzc8Vnu5SEPH6N14/4KB9APJvwMbWNXnOfpO1MDKr7PZjDAwWPzj8DI2rfOtoSrouJ1+XuhHYbFZQZ5ppc4h8352O+txJhs2cnqVP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763481515; c=relaxed/simple;
	bh=yiJDl6m3XAGcCfRTHYyJvD8loHqd12eWZyQ8i24k/iI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MmujR6GfP6ZOCWPmC9UL2O7RN7J/w+EdKdyjkobMYHSV6/eShidTkb1QBk8WgWDeTma7KnqThazT/nyjeYxRbSyQdrQ01C55srcd5tsFz5Qzr/O3LIXBqBKT+MH2cPnW/9Q3l1v0k3FqPf2QzOUojJqx5vX1xThJxeTZZqqiqbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=goHw1NoV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763481513;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bi9/FXUhgoW+SY4yZlL7frUadHPixUKVZpH6M4SJWqI=;
	b=goHw1NoVL6uqtNbEENtvTkc8J3BdQVORl67kejxIuPjHFg4UjjcMUuDMBHdZrIV/07pMm5
	81bSD9wYSOoLHdX75zghnBohbFwzhF0FuX6dL+0pW0EEveL/2MEkB3kNDcppMxf286TKpc
	YyR3zFeO/1tzX6dNa7kQOZhrIDHaaoI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-610-1SHvSqDFMPOZmChfMJx_wA-1; Tue,
 18 Nov 2025 10:58:31 -0500
X-MC-Unique: 1SHvSqDFMPOZmChfMJx_wA-1
X-Mimecast-MFC-AGG-ID: 1SHvSqDFMPOZmChfMJx_wA_1763481509
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C472D1956065;
	Tue, 18 Nov 2025 15:58:29 +0000 (UTC)
Received: from darcari-thinkpadt14sgen1.bos.com (unknown [10.22.64.106])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5165C19560B0;
	Tue, 18 Nov 2025 15:58:28 +0000 (UTC)
From: David Arcari <darcari@redhat.com>
To: lenb@kernel.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Arcari <darcari@redhat.com>
Subject: [PATCH 0/3] tools/power turbostat: Fix segfault and restart loop issues
Date: Tue, 18 Nov 2025 10:58:10 -0500
Message-ID: <20251118155813.533424-1-darcari@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

This patch series addresses three stability issues found in turbostat,
primarily affecting virtualized environments where specific hardware
counters (like APERF) or MSR access may be restricted or inconsistent.

Patch 1 fixes a segmentation fault caused by referencing a NULL
fd_instr_count_percpu pointer. This occurs on systems where has_aperf
is 0 (preventing allocation), but has_aperf_access is 1 (allowing the
function call).

Patch 2 prevents an infinite loop when turbostat attempts to restart.
It ensures the restart limit is checked in all error paths and removes
logic that incorrectly reset the retry counter.

Patch 3 allows turbostat to proceed gracefully when APERF is unavailable.
Previously, the missing counter caused delta_thread() to error out,
triggering the restart mechanism.


David Arcari (3):
  tools/power turbostat: avoid segfault referencing
    fd_instr_count_percpu
  tools/power turbostat: avoid an infinite loop of restarts
  tools/power turbostat: allow turbostat to work when aperf is not
    available

 tools/power/x86/turbostat/turbostat.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

-- 
2.51.0


