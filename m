Return-Path: <linux-pm+bounces-43334-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GD4wCwjBoWkVwQQAu9opvQ
	(envelope-from <linux-pm+bounces-43334-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 27 Feb 2026 17:06:32 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9193C1BA869
	for <lists+linux-pm@lfdr.de>; Fri, 27 Feb 2026 17:06:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D5DF330A4552
	for <lists+linux-pm@lfdr.de>; Fri, 27 Feb 2026 16:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 468E944B698;
	Fri, 27 Feb 2026 16:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b="OvR8DcUw"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.ilvokhin.com (mail.ilvokhin.com [178.62.254.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B8A32720C;
	Fri, 27 Feb 2026 16:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.62.254.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772208081; cv=none; b=URMlDAOZ0zKB2RDBNfa29zVM/4/5Yp3TwBQpy2kNGtEtp2e+6kGVBOY5KvwdbfcW28zWccfjQsnVWNlXvmfG71E4+7i7ncDX6kdc0WQNH4sa7beI39K6fZ0EGtM4thQfbV7/e9OBuX5C0dxoJZpCegRRHRCXHGuEYiNeU7bEuM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772208081; c=relaxed/simple;
	bh=cOWG1YRjVBiyl6if2qS3/oe6W/VcYdJNd1/MyLz6Ank=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E8VeTu82keNzgW1yWVC6T6GIE4PotiKbzXh/9ImEzdtg3vIwgSGENUwI8G4Lkur4JGRgwsjxn7BS68tyzEuCzFjW9a7KhvgAcmlpgNDbonrfEYJX67gIk1r0T9S1sm8ETiIzaH13GtoW7yNUNLNKmDD3UVHYynpGbFT/HiMlRQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com; spf=pass smtp.mailfrom=ilvokhin.com; dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b=OvR8DcUw; arc=none smtp.client-ip=178.62.254.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ilvokhin.com
Received: from localhost.localdomain (shell.ilvokhin.com [138.68.190.75])
	(Authenticated sender: d@ilvokhin.com)
	by mail.ilvokhin.com (Postfix) with ESMTPSA id 9847DB2E32;
	Fri, 27 Feb 2026 16:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilvokhin.com;
	s=mail; t=1772208071;
	bh=UzoB36Gdji3J1eB7hSJEZSO6/0RcFg8v9qSv2IGUJ3k=;
	h=From:To:Cc:Subject:Date;
	b=OvR8DcUwEVl2s2n57k8VSZguWeBebBaxFLg1zQpS8GImERtTnvoUro+qg+ZTBybVB
	 gh+IF+emoV8VDF0MbFl39pAuJbpLoFYrIbBkV8oO2NmBac1Ix8X1R+8Kav7ecD7Dhv
	 sBc+1bJ/bbqdp6Gj1VL7zWD3usYXcCP4MZAbgknI=
From: Dmitry Ilvokhin <d@ilvokhin.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>,
	Wei Xu <weixugc@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Zi Yan <ziy@nvidia.com>,
	Oscar Salvador <osalvador@suse.de>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Shakeel Butt <shakeel.butt@linux.dev>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	"linux-cxl@vger.kernel.orgkernel-team"@meta.com,
	Dmitry Ilvokhin <d@ilvokhin.com>
Subject: [PATCH v4 0/5] mm: zone lock tracepoint instrumentation
Date: Fri, 27 Feb 2026 16:00:22 +0000
Message-ID: <cover.1772206930.git.d@ilvokhin.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ilvokhin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ilvokhin.com:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43334-lists,linux-pm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[29];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[d@ilvokhin.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ilvokhin.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ilvokhin.com:mid,ilvokhin.com:dkim]
X-Rspamd-Queue-Id: 9193C1BA869
X-Rspamd-Action: no action

Zone lock contention can significantly impact allocation and
reclaim latency, as it is a central synchronization point in
the page allocator and reclaim paths. Improved visibility into
its behavior is therefore important for diagnosing performance
issues in memory-intensive workloads.

On some production workloads at Meta, we have observed noticeable
zone lock contention. Deeper analysis of lock holders and waiters
is currently difficult with existing instrumentation.

While generic lock contention_begin/contention_end tracepoints
cover the slow path, they do not provide sufficient visibility
into lock hold times. In particular, the lack of a release-side
event makes it difficult to identify long lock holders and
correlate them with waiters. As a result, distinguishing between
short bursts of contention and pathological long hold times
requires additional instrumentation.

This patch series adds dedicated tracepoint instrumentation to
zone lock, following the existing mmap_lock tracing model.

The goal is to enable detailed holder/waiter analysis and lock
hold time measurements without affecting the fast path when
tracing is disabled.

The series is structured as follows:

  1. Introduce zone lock wrappers.
  2. Mechanically convert zone lock users to the wrappers.
  3. Convert compaction to use the wrappers (requires minor
     restructuring of compact_lock_irqsave()).
  4. Rename zone->lock to zone->_lock.
  5. Add zone lock tracepoints.

The tracepoints are added via lightweight inline helpers in the
wrappers. When tracing is disabled, the fast path remains
unchanged.

Changes in v4:
- Fix build errors in kernel/power/snapshot.c and mm/shuffle.c files.
- Remove EXPORT_SYMBOL().
- Rename header zone_lock.h to mmzone_lock.h.
- Properly indent __acquires() annotation.

Changes in v3:
- Split compact_lock_irqsave() to compact_zone_lock_irqsave() and 
  compact_lruvec_lock_irqsave().
- Rename zone->lock to zone->_lock.

Changes in v2:
- Move mecanical changes from mm/compaction.c to different commit.
- Removed compact_do_zone_trylock() and compact_do_raw_trylock_irqsave().

v1: https://lore.kernel.org/all/cover.1770821420.git.d@ilvokhin.com/
v2: https://lore.kernel.org/all/cover.1772030186.git.d@ilvokhin.com/
v3: https://lore.kernel.org/all/cover.1772129168.git.d@ilvokhin.com/

Dmitry Ilvokhin (5):
  mm: introduce zone lock wrappers
  mm: convert zone lock users to wrappers
  mm: convert compaction to zone lock wrappers
  mm: rename zone->lock to zone->_lock
  mm: add tracepoints for zone lock

 MAINTAINERS                      |   2 +
 include/linux/mmzone.h           |   7 ++-
 include/linux/mmzone_lock.h      | 100 +++++++++++++++++++++++++++++++
 include/trace/events/zone_lock.h |  64 ++++++++++++++++++++
 kernel/power/snapshot.c          |   5 +-
 mm/Makefile                      |   2 +-
 mm/compaction.c                  |  58 +++++++++++-------
 mm/internal.h                    |   2 +-
 mm/memory_hotplug.c              |   9 +--
 mm/mm_init.c                     |   3 +-
 mm/page_alloc.c                  |  89 +++++++++++++--------------
 mm/page_isolation.c              |  23 +++----
 mm/page_owner.c                  |   2 +-
 mm/page_reporting.c              |  13 ++--
 mm/show_mem.c                    |   5 +-
 mm/shuffle.c                     |   9 +--
 mm/vmscan.c                      |   5 +-
 mm/vmstat.c                      |   9 +--
 mm/zone_lock.c                   |  28 +++++++++
 19 files changed, 330 insertions(+), 105 deletions(-)
 create mode 100644 include/linux/mmzone_lock.h
 create mode 100644 include/trace/events/zone_lock.h
 create mode 100644 mm/zone_lock.c

-- 
2.47.3


