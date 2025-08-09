Return-Path: <linux-pm+bounces-32081-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99EBBB1F4E5
	for <lists+linux-pm@lfdr.de>; Sat,  9 Aug 2025 16:16:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A249218C05B6
	for <lists+linux-pm@lfdr.de>; Sat,  9 Aug 2025 14:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CBA72741D1;
	Sat,  9 Aug 2025 14:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iitb.ac.in header.i=@iitb.ac.in header.b="h0LcXw3H"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp1.iitb.ac.in (smtpd9.iitb.ac.in [103.21.126.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048FF22A7E9
	for <linux-pm@vger.kernel.org>; Sat,  9 Aug 2025 14:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.21.126.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754749008; cv=none; b=DJnSh5SRdhWFntGY98RbuYFZDdHNwOiRPzNNnGOv4iU6FOqiF7cEp6q54mqFwP9oN9jdSAjk2IhHjLA8o239MjEKTkvFrEs4y0nHtJKAcSetIB5+Zx+s1EaUBM4R7J8qBWFcdINVRCRjmry8Z9kZqE2hDgB2tcAsltwjsHxIsi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754749008; c=relaxed/simple;
	bh=YM/Qx7TWNpPuVxR9Sit+N+WIa6f7xmuztDnSOFGV+/E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=CW8dmnNDRU8fqTQm0LtpL2ZfUHx11ULLkgt/8CvUTvkq41nDbpY7cLVDa3qsP24jkbVHVYwqq4Lzenv/pNv11MJfb3Dy63wx3w2Anh0V6u0z7F11Ih1LWpjCUUNjdO/umA2GkD7DDdXQQj7xF1eWgRRniMI/EEJef+N70+hJ1EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ee.iitb.ac.in; spf=pass smtp.mailfrom=ee.iitb.ac.in; dkim=pass (1024-bit key) header.d=iitb.ac.in header.i=@iitb.ac.in header.b=h0LcXw3H; arc=none smtp.client-ip=103.21.126.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ee.iitb.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ee.iitb.ac.in
Received: from ldns2.iitb.ac.in (ldns2.iitb.ac.in [10.200.12.2])
	by smtp1.iitb.ac.in (Postfix) with SMTP id CB5C0104C1D8
	for <linux-pm@vger.kernel.org>; Sat,  9 Aug 2025 19:46:37 +0530 (IST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.iitb.ac.in CB5C0104C1D8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=iitb.ac.in; s=mail;
	t=1754748997; bh=YM/Qx7TWNpPuVxR9Sit+N+WIa6f7xmuztDnSOFGV+/E=;
	h=Date:From:To:Cc:Subject:From;
	b=h0LcXw3H3mYYET7ylkrl+IohQbWw6nGzNhpcN2qGuvLxD9egnZIWZWxVCmHnfgUEg
	 j59slYikDcy88tcqMmZCe0l3jMzksVLXpGjg2RUz0nA/ghCAfez5tBu7anmheDFkrE
	 xqQR2Xo5M0foO3ITLYI7wpdBsV5TjwGHTEEm62NM=
Received: (qmail 13183 invoked by uid 510); 9 Aug 2025 19:46:37 +0530
X-Qmail-Scanner-Diagnostics: from 10.200.1.25 by ldns2 (envelope-from <akhilesh@ee.iitb.ac.in>, uid 501) with qmail-scanner-2.11
 spamassassin: 3.4.1. mhr: 1.0. {clamdscan: 0.100.0/26337} 
 Clear:RC:1(10.200.1.25):SA:0(0.0/7.0):. Processed in 4.350738 secs; 09 Aug 2025 19:46:37 +0530
X-Spam-Level: 
X-Spam-Pyzor: Reported 0 times.
X-Envelope-From: akhilesh@ee.iitb.ac.in
X-Qmail-Scanner-Mime-Attachments: |
X-Qmail-Scanner-Zip-Files: |
Received: from unknown (HELO ldns2.iitb.ac.in) (10.200.1.25)
  by ldns2.iitb.ac.in with SMTP; 9 Aug 2025 19:46:33 +0530
Received: from bhairav.ee.iitb.ac.in (bhairav.ee.iitb.ac.in [10.107.1.1])
	by ldns2.iitb.ac.in (Postfix) with ESMTP id D54C8341554;
	Sat,  9 Aug 2025 19:46:32 +0530 (IST)
Received: from bhairav-test.ee.iitb.ac.in (bhairav.ee.iitb.ac.in [10.107.1.1])
	(Authenticated sender: akhilesh)
	by bhairav.ee.iitb.ac.in (Postfix) with ESMTPSA id 982101E81308;
	Sat,  9 Aug 2025 19:46:32 +0530 (IST)
Date: Sat, 9 Aug 2025 19:46:26 +0530
From: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
To: andrew@lunn.ch, gregory.clement@bootlin.com,
	sebastian.hesselbarth@gmail.com, rafael@kernel.org,
	viresh.kumar@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, akhileshpatilvnit@gmail.com,
	skhan@linuxfoundation.org
Subject: [PATCH 0/1] cpufreq: armada-37xx: use max() to calculate target_vm
Message-ID: <cover.1754747830.git.akhilesh@ee.iitb.ac.in>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This patch is motivated from previous patch [1]. As per discussion in [2],
I have tested the patch for build and no additional include files are
needed. Build works fine. This change is also reported by kernel test
robot.

Link: https://lore.kernel.org/lkml/20240822074548.1365390-1-11162571@vivo.com/ [1]
Link: https://lore.kernel.org/lkml/2c55fb07-b29e-43e0-8697-f75d1f0df89a@vivo.com/ [2]

Akhilesh Patil (1):
  cpufreq: armada-37xx: use max() to calculate target_vm

 drivers/cpufreq/armada-37xx-cpufreq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.34.1


