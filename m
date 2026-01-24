Return-Path: <linux-pm+bounces-41397-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0JR/GxYfdGk32QAAu9opvQ
	(envelope-from <linux-pm+bounces-41397-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sat, 24 Jan 2026 02:23:34 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1905B7BF09
	for <lists+linux-pm@lfdr.de>; Sat, 24 Jan 2026 02:23:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 103C730685AC
	for <lists+linux-pm@lfdr.de>; Sat, 24 Jan 2026 01:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A4F27732;
	Sat, 24 Jan 2026 01:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Lc5Qt/Lw"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3861DEFE8
	for <linux-pm@vger.kernel.org>; Sat, 24 Jan 2026 01:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769217719; cv=none; b=sukUNoXH4dAQw8hcLrbsbthlP3PG73AVAHca4uS7y57QgKpzVzlltdn1LEIcQ5mQr2FGGUpWXA4bLl8MH6NsVO179BLcy0S4HIOO5yHr7eX0SAlbYmwujzXSFnDm97HMFXusHCgDLdNNTDKmnBPVeRQ2L4XbsSwBbYRcebc5Ops=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769217719; c=relaxed/simple;
	bh=EIi/GnTlznjPON4PS8pc54m9LlDIbD5aj6rLgRF+Sso=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=TqbSWFISNSoy3doosRINNOAVTwlm9c8Q7mmdX08m7VOBZQHjQ8FRHEoBb2DnYhpkAD+THjmUO7HzAeGq5vcfxQYKTqtnGTjP1Z7+5tyoxRDit8Sne8SPGezkA29BHArOgPfvh2KIeQ35VF0vVDUi3xsCrwYfB20xA+f2NLPTXKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Lc5Qt/Lw; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2b708fa4093so10128012eec.0
        for <linux-pm@vger.kernel.org>; Fri, 23 Jan 2026 17:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769217716; x=1769822516; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eViLy/8042sT43+AqNLTZ9LY4N5fDHN38VganIaxaTI=;
        b=Lc5Qt/LwU9+12PlMQF0AMHqfguCK6yCsKwAwM1TVdqiVVNbBm5N5uk515eqlTuQJ53
         w2Hy7QdprHKoroVYbjl2d64TjX4HxKqzc5rsKyTk3+Je9ak9LD1gCczes+Kw2K4ZLr4O
         We+h0AJXZykX/AqV6fxknq8cd8s0YNeqLWEV8ItwkTuasGT7KXIfmDW5Sr5jQGq5qCi8
         6aOUASucFFGBd4JXpuOW/ZiiXemNnZuNb2YRuVm+OtxFOqXT7sZofBZpaVC9NVb6w9BC
         GZ2giBBKMf38gzoazhQGe08KBAy7Nw9lMQP6NtaWArx0qq0C4OjhVq15USZUGBLD3rJ1
         zjHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769217716; x=1769822516;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eViLy/8042sT43+AqNLTZ9LY4N5fDHN38VganIaxaTI=;
        b=n/sbZ1AQH/Txc2JXe4pncEymBCdigv0t+THM2Rmmrf3pwcEP3v9Hc1u6VicNAXIPHc
         M2y7054uX18Adg3GhDrHdUsi3fMEk4UHsqgtMF5lHzNZdd+VeDzjw5RF7EbxDvJPUHP6
         F7kIrEbjXYF002VDoJ0ejQq6q94zzWz/2yE0+8tkmaNCC1lg9AF13bHqXJjxpkxBFYiN
         ilku7jegUerse2hnlmKOWxkyuWtIo8VUVYeMiDK8KcXpwivCIsnsYYzFFymhCphpkOWp
         aoQS4VeCrQgqxlCRWTAiftq8emDrOwR9SgKD4ix2ws4WzjFvQf6c/DfVJ91TRXknJKZ2
         F22Q==
X-Forwarded-Encrypted: i=1; AJvYcCXNIwBKhJffo5xCnBCgQJpXN/uTW2J5Wasob8CJ/dVgTfrUSskb1hkw//LZ0Kvr3adWKuZjfWQZHQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwHlIE09CLFQf/1W9YiB14PBols1PfL/b/0BF6PptXNLtTQ8P8N
	bUSB04XAw+SdcolmPn/YPtIDiC1aR+ktFdoubxsTXs8AID61ERRoUpVdi0mjzYbYTMshE/QedcH
	9bvcVwIdUTI/0Rg==
X-Received: from dycna11.prod.google.com ([2002:a05:7300:ea8b:b0:2b0:5418:353f])
 (user=wusamuel job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7300:a984:b0:2b7:3955:f50a with SMTP id 5a478bee46e88-2b739beab86mr2393375eec.41.1769217715760;
 Fri, 23 Jan 2026 17:21:55 -0800 (PST)
Date: Fri, 23 Jan 2026 17:21:28 -0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260124012133.2451708-1-wusamuel@google.com>
Subject: [PATCH bpf-next v3 0/3] Add wakeup_source iterators
From: Samuel Wu <wusamuel@google.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: Samuel Wu <wusamuel@google.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,linuxfoundation.org,iogearbox.net,linux.dev,gmail.com,fomichev.me,google.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-41397-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[google.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wusamuel@google.com,linux-pm@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1905B7BF09
X-Rspamd-Action: no action

This patch series introduces BPF iterators for wakeup_source, enabling
BPF programs to efficiently traverse a device's wakeup sources.

Currently, inspecting wakeup sources typically involves reading interfaces
like /sys/class/wakeup/* or debugfs. The repeated syscalls to query the
sysfs nodes is inefficient, as there can be hundreds of wakeup_sources, and
each wakeup source have multiple stats, with one sysfs node per stat.
debugfs is unstable and insecure.

The iterators utilize pre-existing wakeup_sources_walk_* functions to
traverse over the SRCU that backs the list of wakeup_sources.

Changes in v3:
 - Update wakeup_sources_walk_start() to handle an empty list per bpf-ci
 - Simplify read of a struct's field in BPF program selftest per Andrii
 - Drop open coded iterators for wakeup_sources
 - Fix condition from !get_ws_iter_stream to get_ws_iter_stream in selftest
 - Read event_count instead of wakeup_count in selftest
 - v2 link: https://lore.kernel.org/all/20260108225523.3268383-1-wusamuel@google.com/

Changes in v2:
 - Guard BPF Makefile with CONFIG_PM_SLEEP to fix build errors
 - Update copyright from 2025 to 2026
 - v1 link: https://lore.kernel.org/all/20251204025003.3162056-1-wusamuel@google.com/

Samuel Wu (3):
  PM: wakeup: Handle empty list in wakeup_sources_walk
  bpf: Add wakeup_source iterator
  selftests/bpf: Add tests for wakeup_sources

 drivers/base/power/wakeup.c                   |   4 +-
 kernel/bpf/Makefile                           |   3 +
 kernel/bpf/wakeup_source_iter.c               | 103 +++++++
 tools/testing/selftests/bpf/config            |   1 +
 .../bpf/prog_tests/wakeup_source_iter.c       | 281 ++++++++++++++++++
 .../selftests/bpf/progs/wakeup_source_iter.c  |  60 ++++
 6 files changed, 449 insertions(+), 3 deletions(-)
 create mode 100644 kernel/bpf/wakeup_source_iter.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/wakeup_source_iter.c
 create mode 100644 tools/testing/selftests/bpf/progs/wakeup_source_iter.c

-- 
2.52.0.457.g6b5491de43-goog


