Return-Path: <linux-pm+bounces-16877-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C04529B93C7
	for <lists+linux-pm@lfdr.de>; Fri,  1 Nov 2024 15:53:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58BA8B21591
	for <lists+linux-pm@lfdr.de>; Fri,  1 Nov 2024 14:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 520C51A706F;
	Fri,  1 Nov 2024 14:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NTh4XGl0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85AE719F485;
	Fri,  1 Nov 2024 14:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730472787; cv=none; b=KL+PCBvjWlNzr8bmnTIsNoLhykD8F8TZNjsuKvPVIaqh3PS+aMViCcZiQm4BkFKaZMdM3LwLaipx74QBtuZHfYScUYCFOC7JHBWMG+dPvxTb/XQnXTUPp0zNtCq1KnMDBhBw8hLuXUAEGjw/DaoOZhIP7lJkmV9hPHbIidr8SRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730472787; c=relaxed/simple;
	bh=gdzhFJW7AghxABWVWepa1mAQS2QMNTrl4Nn1B5gwzVY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=L5os5bJVQFpY48pZxq69qLfLg0VxRIZckT3EDpfpLbGzNcVi8MsrvGm5UnIEYJ4ocAUtApzILojXUplW21tTQGe1v+IxaUKdYzCRlioTO/BR9Gmy859QvgoAngm2L+L3RcW0bnpwn6PZT0UC6jSbkjxNgHn9aD6Z0ogGnFF9inU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NTh4XGl0; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2e56750bb0dso1491350a91.0;
        Fri, 01 Nov 2024 07:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730472785; x=1731077585; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E5SX5NqdV5GfRyEJ/smcBZMTNvaT7jRpEZDUb9kdB6o=;
        b=NTh4XGl0F5SqnTS1ODlCubV9OITYedzEoMiSn4VmxfJ2xcHJgGwyLY3JS6h0pL9CAH
         wBqv/jpf9qOforlXP3ycuLXg9/j4CkaK4tC0aixPilgz32wnaaq96bN2RQN7CAmBJB8K
         Dfzny7NxKubel0iDuX4rlP7kTc1SbL5rXof2iw4+f4kiI2f4tTIRrSnKpv0zhW1Pmm8D
         U1fOSF0epz3MFA3BsB+HQhZbYauJ+N7ViPw5ocsRqnf/CFyG68m4DP1g6RcUsSLwAArX
         jIm9UdUiAzuZf3AH3Yn9idD4Msy6NOGhqKEYPFeHWmu2fg3goS81nlIH47eadiB5BkJ7
         ssYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730472785; x=1731077585;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E5SX5NqdV5GfRyEJ/smcBZMTNvaT7jRpEZDUb9kdB6o=;
        b=UvL9GTLV5S0zVb8tUtH6xwH5RFJtkMsQhyYgU0de5RUFUmwjulBSqXLHv3pA2JKzqG
         lcgQ/rhCv+29Fp9hPSuJ25qaSGF84brHEcxBKnGuHyQiM+u6GF6v3HAIHPNRiGVVZWNi
         pSDsLq4lE02hBtMlBOdFpSiH0LDZq2VP3zZe7OD78BGlhiqiPYOJojQWvOvBjEmJOrwh
         G9MiRJewcKup3KhlyGo8+Gkfj1A0D3BFMS6fT9s26lWBrDbckfndIuNZtebWyUdVzK8I
         5yuuGIRzJA3Q9b87E0KArAmPgyqli+75aXZHy3vYfcuWalJ6hsfimTHzNyCJ9E2+Xeb0
         mH7A==
X-Forwarded-Encrypted: i=1; AJvYcCUWIAAVKiWkX/WDj2SFcamhPLWU7cyhnS6xuxgIwMDBRhVHCvDtRmh9+Up8sI3ghNNYnf09uIClqQOzVEE=@vger.kernel.org, AJvYcCXpizpXSsi4kGENmHituny8rN+M01RL3iklOvykLN+aRyVBMZCSL6VcdDBLaxPp09GXlsV1XWFoWog=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoTkXr+rXnCynRaGTtEbut4znf+nPe7DKgCFuZ0gdet7wNvE8r
	LNwD/Z1ElNv0AyDs5Ddv4mSWvCnn1o7ebwhe9KojpYm/WamUHBdt
X-Google-Smtp-Source: AGHT+IHMaIYJQgvi+rHO0tIXu0CPB3KdYCWQUoyyOm6bR46LXVj7R6WnhRRAdrqyBe/DGrH+2xhERA==
X-Received: by 2002:a17:90b:4c0f:b0:2e2:e660:96d5 with SMTP id 98e67ed59e1d1-2e94c2e2121mr5434450a91.24.1730472784661;
        Fri, 01 Nov 2024 07:53:04 -0700 (PDT)
Received: from localhost.localdomain ([2409:40c1:5e:dc6d:d4a9:3dbd:7f84:6140])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e92fbfb021sm5038090a91.49.2024.11.01.07.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 07:53:04 -0700 (PDT)
From: Amit Vadhavana <av2082000@gmail.com>
To: todd.e.brandt@linux.intel.com,
	skhan@linuxfoundation.org,
	ricardo@marliere.net
Cc: av2082000@gmail.com,
	linux-kernel-mentees@lists.linux.dev,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] pm-graph: Refactor installation script
Date: Fri,  1 Nov 2024 20:22:41 +0530
Message-Id: <20241101145241.10326-1-av2082000@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change installation script to ensure that the terminal returns to the
original directory after the installation process completes.

Signed-off-by: Amit Vadhavana <av2082000@gmail.com>
---
 tools/power/pm-graph/install_latest_from_github.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/power/pm-graph/install_latest_from_github.sh b/tools/power/pm-graph/install_latest_from_github.sh
index eaa332399d36..aaf3515400ed 100755
--- a/tools/power/pm-graph/install_latest_from_github.sh
+++ b/tools/power/pm-graph/install_latest_from_github.sh
@@ -4,6 +4,9 @@
 # Script which clones and installs the latest pm-graph
 # from http://github.com/intel/pm-graph.git
 
+# Save the current directory
+CURRENT_DIR=$(pwd)
+
 OUT=`mktemp -d 2>/dev/null`
 if [ -z "$OUT" -o ! -e $OUT ]; then
 	echo "ERROR: mktemp failed to create folder"
@@ -36,3 +39,6 @@ else
 	echo "INSTALL FAILED"
 fi
 cleanup
+
+# Return to the original directory
+cd "$CURRENT_DIR"
-- 
2.25.1


