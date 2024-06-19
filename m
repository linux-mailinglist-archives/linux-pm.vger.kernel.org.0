Return-Path: <linux-pm+bounces-9528-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A5D990E1D9
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 05:13:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93C1D281A70
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 03:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE195381B;
	Wed, 19 Jun 2024 03:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kef1R7LX"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FC652F7A;
	Wed, 19 Jun 2024 03:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718766778; cv=none; b=FO4c39N09ADx+N1GG5eh9Fc9I6UfgIPix5tfQS3egn2MnTwn4ngBnDSZIp4oIQNKkYJTz75FrDGhzqXw2JOZQ6MQGwg4yMYkkPDXXMmJcEej0OVQbNun6wmmHLgbl6srTiFVk24faA0WbaJbSSAiRLGSFDDHa0a4V/N1RysCkFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718766778; c=relaxed/simple;
	bh=5b3w2NPSh5iEXOcXIaes7wCdTigmUfw1L/MtSDp0Kn8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A9qWRSvJz7L5bkCFnm9w8MkpRbM0mtM6QKcZhgwAVu+J34wQGvZfspx1knTGb+rytEgPQGN0hc5g3Di1s2Bb+OmB6HxU0XLSfgdzo0CsbyG2KAsMO5Vhgtb/okUtPmnP5e6l62SZsF1u0k0McL7jz0PaBTpoAyVdONLGKRiy0TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kef1R7LX; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2c2e31d319eso5067359a91.1;
        Tue, 18 Jun 2024 20:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718766777; x=1719371577; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=PPsoxqySqMZr+7Ne3i+pedtNXjUhYm5TqfhrsG3xE/c=;
        b=Kef1R7LXgMO96/Zx+fNIf+f+hOSIoM61feZ9h3rbdBpn0M4jCdjHpP0h5ihiH0eVs5
         hVnXI5FhpMNkZw5f8U1eXAdhW8nGZE/aaIFxD6C9c+I1jUrmTEsU8iBuGnH6kyPQtuJM
         1FezsqcZ69ogGXqOwEMKOjuIq0eF09o4uvbhqf/uN5syaBUTKyW14V0shTHaGUNAbk7F
         XiOcANlUiulRidMO30W0CjUqsqPscKkJUGawF2maNk47jo8TKWtvVBTaaG2AQYbWs98v
         U34Ansj02/rUOLAwjzFTiEzoQAzxqQNpyDtFGkJIr6Srqj+ZgFSvSu0wKqvnrIQPjjFZ
         77LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718766777; x=1719371577;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PPsoxqySqMZr+7Ne3i+pedtNXjUhYm5TqfhrsG3xE/c=;
        b=TDylMgY2wg3MBHCpvehMSlbQmxKC75dhkFAywz4KvPfpSE3qQuGtXmSMC9vG9GqkR1
         dR3eru3fu2AILozQhdykowcr6Y3Ru629IQGubLONvFqxdLPY015Z7x4RVhi11MqOANTC
         8BCPVbfOzmTfJZKK3MRoxLHR0QepWvfiUYBSeGdBVclUlpkpGCXil9Fe5ePORVDkx+om
         iO82lPHRlMznqdFLHXZYc6aUsvXcshtO/HXmyJEN5WoQ/m3kTP8SePf7HAjWmfg0g7la
         uf8P/NN4loQK1X6ZMzDCH7E6f+tfUYpWKaQHEzM0eD3AnJbuqXWHHnkRFR0rMQwrJhgH
         wG3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUOG9SicBae99xZ2KuUc0xdP2IVVMVcV70+AORPeI0H4tUEopi4FZ9CQQDAcfGvxekDyUQo/AuMdjc+mkZeTgLMDgOnSEvbaQhaqzZ3
X-Gm-Message-State: AOJu0Yz8D8q8/UaSazP+6iHT3rpSgxqfGNnYRKwETODJMimuwrWImEi4
	R/a32MHxEo9KjjO41gaa9J0zchMCV21I+YXw2xpSbcuPlUC+cXb8
X-Google-Smtp-Source: AGHT+IHmz4itdOqrgumzg+a4N3BNtUk2I2Fp3b1SuO7NgdZNm1I+xvJel/jRADo/8gEgn16Jx1gu7g==
X-Received: by 2002:a17:90a:fc92:b0:2c7:3e4c:e782 with SMTP id 98e67ed59e1d1-2c7b4e4f27cmr1759144a91.0.1718766776710;
        Tue, 18 Jun 2024 20:12:56 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c4ac192848sm13589606a91.56.2024.06.18.20.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 20:12:56 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: rafael@kernel.org,
	viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org,
	void@manifault.com,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	mingo@redhat.com,
	peterz@infradead.org
Subject: [PATCHSET sched_ext/for-6.11] sched_ext: Integrate with schedutil
Date: Tue, 18 Jun 2024 17:12:01 -1000
Message-ID: <20240619031250.2936087-1-tj@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sched_ext currently does not integrate with schedutil. When schedutil is the
governor, frequencies are left unregulated and usually get stuck close to
the highest performance level from running RT tasks.

This patchset integrates sched_ext with schedutil so that the BPF scheduler
can steer CPU frequencies when the schedutil governor is in use. The
implementation is straightforward. sugov_get_util() is updated to add the
BPF scheduler provided utilization metric when sched_ext is enabled.

This patchset is on top of sched_ext/for-6.11 (a5db7817af78 ("sched_ext: Add
selftests")) and contains the following two patches:

 0001-cpufreq_schedutil-Refactor-sugov_cpu_is_busy.patch
 0002-sched_ext-Add-cpuperf-support.patch

and is also available in the following git branch:

 git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git scx-cpuperf

diffstat follows. Thanks.

 kernel/sched/cpufreq_schedutil.c         |   50 +++++++++-------
 kernel/sched/ext.c                       |   83 ++++++++++++++++++++++++++
 kernel/sched/ext.h                       |    9 ++
 kernel/sched/sched.h                     |    1
 tools/sched_ext/include/scx/common.bpf.h |    3
 tools/sched_ext/scx_qmap.bpf.c           |  142 +++++++++++++++++++++++++++++++++++++++++++++-
 tools/sched_ext/scx_qmap.c               |    8 ++
 7 files changed, 270 insertions(+), 26 deletions(-)

--
tejun

