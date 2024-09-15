Return-Path: <linux-pm+bounces-14315-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BDCB979853
	for <lists+linux-pm@lfdr.de>; Sun, 15 Sep 2024 21:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B923F1F21D47
	for <lists+linux-pm@lfdr.de>; Sun, 15 Sep 2024 19:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C47E31CA6B2;
	Sun, 15 Sep 2024 19:03:24 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from sxb1plsmtpa01-06.prod.sxb1.secureserver.net (sxb1plsmtpa01-06.prod.sxb1.secureserver.net [188.121.53.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2A51C9ED9
	for <linux-pm@vger.kernel.org>; Sun, 15 Sep 2024 19:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.121.53.60
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726427004; cv=none; b=jXpsqG2IY7+dxfFwYzTH4ErQMCbZinb1fwkhU2CBbcqnURGuhpmvbTshqjOzxmMkZ2JFM0lEEnIqmJOV+DTXZDcsG02m0mSerZnGvmEHn0FR1j3jB0JHL/cBOfsWusTBtq6foqU9y5bBS1ZzTeHDYqupvBlFDXaWNfB+rpTewyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726427004; c=relaxed/simple;
	bh=fx8Y7JYlg4rbNgBARTDBCuvDk8+mpnNDQWmH267bmsM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HDMqRqhBRANpfrl0eo2LWDVqDZk/peb3J4o3SNoZ5Mt0ZdYQhG1Z1LEgaWZKSFBd0p0MqHzsdH05Nb0osJaDa9lvRVOWSGd7xobEAYI6rKMnWECvBBmvnzp1TFripOMVm7DQlVJec9HcuAffWNHcX/fip0oZfHvr6pWTgMWdr50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=piie.net; spf=pass smtp.mailfrom=piie.net; arc=none smtp.client-ip=188.121.53.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=piie.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=piie.net
Received: from localhost ([109.90.180.58])
	by :SMTPAUTH: with ESMTPSA
	id psvmszCxGiW5Ypsvns9sxY; Sun, 15 Sep 2024 10:21:03 -0700
X-CMAE-Analysis: v=2.4 cv=VoboAP2n c=1 sm=1 tr=0 ts=66e71780
 a=ujCVow8R4Y5jPCx6COW8WA==:117 a=ujCVow8R4Y5jPCx6COW8WA==:17
 a=IkcTkHD0fZMA:10 a=t3YNmgBSAAAA:8 a=o7PI2Wm5cik088qZixgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=ctH_qozkpUrkr3SVbfwb:22
X-SECURESERVER-ACCT: peter@piie.net
From: Peter Kaestle <peter@piie.net>
To: linux-pm@vger.kernel.org
Cc: rjw@rjwysocki.net,
	daniel.lezcano@linaro.org,
	linux-kernel@vger.kernel.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com,
	=?UTF-8?q?Peter=20K=C3=A4stle?= <peter@piie.net>
Subject: [PATCH 0/1] acerhdf refactoring
Date: Sun, 15 Sep 2024 19:19:52 +0200
Message-ID: <20240915171953.163220-1-peter@piie.net>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfDKYDgXJ2DHG8daYcwXJzJQ2Hz6VUuLEXEOEwTCLWrC/ZQmHDX4fWmav3gja537plxXjnXwnodXJ2lwGYJ4kwHv4RLVhOXE3mBpKvBmKrIAz6YPNrTWI
 dtK7XG19acYRcUYYWsYvK0BvTSVdqklmEj2kGkH2MKeFjVEulknlznCKr5z/GuS3KRyD8/vrk/PRso+Kv7rKGTUerWsTE6CgLt8CpG8yse6xK0Pjb+3ESFbi
 Ej5OBX/JDoVlrZvuoTcAJmtkQa7muV4/bQ2yxyjCRyOT0p3PgySCx0nUszxmWXQjHuJ4FgLYGwzT+TzVoUyDU/zrsrWcEI/ricnI31i4Kus/2+AV391gPgc3
 qroFGwWDgC/eFhycWfpYoXH6t/VyuQ==

From: Peter Kästle <peter@piie.net>

Hi,

hope you're doing good.  I finally found some time to rework acerhdf.
Main goal was to simplify testing by removing code of dynamically
instructing acerhdf, as all of this can be done in similar way by using
rmmod acerhdf ; modprobe acerhdf fanon=xx fanoff=xx kernelmode=x or so.

It was tested on top of 0a06811d pm-6.12-rc1.

Thanks and best regards,
--peter

Peter Kaestle (1):
  acerhdf: clean-up and remove interval parameter

 drivers/platform/x86/acerhdf.c | 95 +++++-----------------------------
 1 file changed, 12 insertions(+), 83 deletions(-)

-- 
2.46.1


