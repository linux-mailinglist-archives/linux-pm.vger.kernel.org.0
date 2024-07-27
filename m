Return-Path: <linux-pm+bounces-11470-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5498C93E07C
	for <lists+linux-pm@lfdr.de>; Sat, 27 Jul 2024 20:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0085E281D11
	for <lists+linux-pm@lfdr.de>; Sat, 27 Jul 2024 18:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48FF8186E42;
	Sat, 27 Jul 2024 18:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UfzYWZrt"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7EE538A
	for <linux-pm@vger.kernel.org>; Sat, 27 Jul 2024 18:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722104809; cv=none; b=KM/WzHJb9ED/DyCITAXXjQiQ6Z9PcUqiRaVdqoQbjBr0f6gUlcgF6vYRnPHg+Bco6+sIcJJmi3iO//bjVVgELXLVy7k7v46KTev8d764nGOoDtIegscOytjvDVZIB8a1H2mN5lTTyAT2UZTPix/2pMvUklDDPhRTXQOoFBvasUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722104809; c=relaxed/simple;
	bh=dcQM1JHUfkBs5ABqWQhDEewS8KH3UKwDSlEM7hBzl+E=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=DFbaiCoQuZWoPb5vSNqKWflQvInFUdaZSFtPbBC+If7gkkvpB0dGd/5y3vDWRDqZyOZLOp1KOEQTiYqxCJ+iZXkeZoi3LuQNkT6+ExqAqHqizI9qIFALMmHZ+W8yd+bqEsvOUI+Dh6xi5V6EEUNpLFEH7S5NSKLlhbK+YgEDwg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UfzYWZrt; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-709485aca4bso44080a34.1
        for <linux-pm@vger.kernel.org>; Sat, 27 Jul 2024 11:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722104806; x=1722709606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=5qeUQbd/1NlINYG1ToI7CyjEI4zX+s54k81HN0zm484=;
        b=UfzYWZrt2q6Xyjw8/jNNC75UZNcoA3AIvNinGPQX0+9yGsvbw+jPQBSnuCtH1XXpXu
         Dw3TLZz7NUXicCF3bBpAYMfJIP/BpQCRZnCQ2nOdy7JR4rrvhIdFy/QhvtZzuF9fxMBx
         3jBLC59KlWlrpg9xKVY1MeLvbf4Z4gOEcsjqo1VUv7eumoUWji5yoxB/k9CASY5WEzdR
         dj0fHga1de9cicUrfTcmxCK5OWml82gn3AEdsDl4mQ2DG/Bhuyuuf0UT7MTDYG/9pR4+
         4RLwjbstznffLhV1gJiuXsRsRu2EBf7TU6l6eAysrCkGjLzv6gYqobArYqIxslyRa0Ps
         mPjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722104806; x=1722709606;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5qeUQbd/1NlINYG1ToI7CyjEI4zX+s54k81HN0zm484=;
        b=QUyyiUjEv3+LvFvXZLBi1EAisd4KRYd3osXrgkPoOe598fLe7OcYJ7PHPMBIQyVpOd
         nnNxjWijitaQFoZqhvVZSe36hMpwkWkJJBrzaSrqSaWbPyrYBHgqu41b5jlZpjNbC/gS
         Qt0GttiqoL3OyeddTBZBqlhphtQdixypORzffP94LIFmyLhCxy3Ywm1494IWUGBmuveK
         hb44TCXNDvEirvNoT0dMejdVSB5BHkNNdSXqMytMXPEdUOHc7dBMjmHWGqX2mgctaC07
         vHATQtkbNE2dSXQ+KP3L8Mx0cqoYAH/NBKjXb+NaD9R9NIj05Cw7tvMeSilB/bPhG/7U
         1AFw==
X-Gm-Message-State: AOJu0YzS8J9QvUubDML8ad1sFFCFtTsAuz+vG83CfQ0GO9zbtl+TrrSW
	26q0yPDfPv3YoMg0jtIAcUXcOB3Sec34DVKDoENxYOcgyMcivS+P+zIVsQ==
X-Google-Smtp-Source: AGHT+IFNM4oHhERGsr3coGXM2tazxB19D1Mo5nTzfQ1cD2In2ni4t+E0lVt95TFbItMn5ZkFwoXNNw==
X-Received: by 2002:a05:6830:6a8f:b0:703:5f48:7af0 with SMTP id 46e09a7af769-70940c8fabdmr3885685a34.21.1722104806588;
        Sat, 27 Jul 2024 11:26:46 -0700 (PDT)
Received: from lenb-intel-nuc8i7hvkva.. (h75-100-80-185.cntcnh.broadband.dynamic.tds.net. [75.100.80.185])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7093050a35fsm1314136a34.6.2024.07.27.11.26.46
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jul 2024 11:26:46 -0700 (PDT)
Sender: Len Brown <lenb417@gmail.com>
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Subject: [PATCH 0/18] turbostat 2024.07.26 for Linux-6.11.merge
Date: Sat, 27 Jul 2024 14:23:26 -0400
Message-ID: <20240727182641.414886-1-lenb@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


Hello All,

The following changes since commit b15943c4b3351173d5f3b0d87362d2994a89bb66:

  tools/power turbostat: Add local build_bug.h header for snapshot target (2024-06-27 23:53:27 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git tags/v6.11-merge

for you to fetch changes up to 866d2d36b81d7d0e6d91423b6dd9b1bcfd0510dd:

  tools/power turbostat: version 2024.07.26 (2024-07-26 14:36:08 -0400)

----------------------------------------------------------------
turbostat release 2024.07.26

Enable turbostat extensions to add both perf and PMT
(Intel Platform Monitoring Technology) counters via the cmdline.

Demonstrate PMT access with built-in support for Meteor Lake's Die%c6 counter.

----------------------------------------------------------------
Len Brown (1):
      tools/power turbostat: version 2024.07.26

Patryk Wlazlyn (16):
      tools/power turbostat: Remove anonymous union from rapl_counter_info_t
      tools/power turbostat: Replace enum rapl_source and cstate_source with counter_source
      tools/power turbostat: Add ZERO_ARRAY for zero initializing builtin array
      tools/power turbostat: Group SMI counter with APERF and MPERF
      tools/power turbostat: Extend --add option with perf counters
      tools/power turbostat: Fix formatting in turbostat.8
      tools/power turbostat: Add perf added counter example to turbostat.8
      tools/power turbostat: Fix typo in turbostat.8
      tools/power turbostat: Move debug prints from stdout to stderr
      tools/power turbostat: Move verbose counter messages to level 2
      tools/power turbostat: Add selftests for SMI, APERF and MPERF counters
      tools/power turbostat: Add selftests for added perf counters
      tools/power turbostat: Add early support for PMT counters
      tools/power turbostat: Add MTL's PMT DC6 builtin counter
      tools/power turbostat: Document PMT in turbostat.8
      tools/power turbostat: Include umask=%x in perf counter's config

Tony Luck (1):
      tools/power/turbostat: Switch to new Intel CPU model defines

 tools/power/x86/turbostat/Makefile                 |    1 +
 tools/power/x86/turbostat/turbostat.8              |   98 +-
 tools/power/x86/turbostat/turbostat.c              | 2341 ++++++++++++++++----
 .../selftests/turbostat/added_perf_counters.py     |  178 ++
 .../testing/selftests/turbostat/smi_aperf_mperf.py |  157 ++
 5 files changed, 2277 insertions(+), 498 deletions(-)
 create mode 100755 tools/testing/selftests/turbostat/added_perf_counters.py
 create mode 100755 tools/testing/selftests/turbostat/smi_aperf_mperf.py

