Return-Path: <linux-pm+bounces-25979-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC25A97ADE
	for <lists+linux-pm@lfdr.de>; Wed, 23 Apr 2025 01:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 781695A180B
	for <lists+linux-pm@lfdr.de>; Tue, 22 Apr 2025 23:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E861FAC48;
	Tue, 22 Apr 2025 23:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OyDMv2u5"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26ADB1D61A3
	for <linux-pm@vger.kernel.org>; Tue, 22 Apr 2025 23:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745363146; cv=none; b=JyjOm3j9WOiVFBMfAB+wBLkEYod32Oo9TxQRfE5QAyCWPVE1gsB8DFC9Sn/XDZjqYQlfslj6Z0MuWVTPPNlRN7RQXPmO1lTrKzQGZF+DtyWKfFA204kPMzvtCT4h5qhuEKxrAtrkuOmDbhrEyl1q7jodRHqNtgaiaqSmouYne+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745363146; c=relaxed/simple;
	bh=0H0uKZ693mlpOCVqBXLPrlDdTN8NIHveQOdXj53aAW4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A+flMDUHrMjE4NAkPgS3u72tYwZHTJs0JtHD67E8Gm6xU2R/p6hpo/VHJULjxJRJbyvUB6xJc2eShd/1JqA97z7XXvp+DB/soyc2nct7B6mbRgl5bJXGy11fur3duV2SNTFXDVSE6bK1/SPp1MlZKcgL1Ewisgyjar0hSZ3q8cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OyDMv2u5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745363143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=eA2dPJ7kUmIfz4lKYy/AXLtHSVSq2pKZ9vTXMKbDLTg=;
	b=OyDMv2u5Z+7OQwfuTaBhKgbDfYo9sOZViM/A6DufjVyTiQdW/iAQwoOuWaeULtKHDg+yTL
	th6iDVkgTun9h6Ew+/XqZjBoNwz1/H2cBSejDhJAsJ3nSFjofzlhG8SJZKRdM3aDIXLWBn
	VKyzOyJO0mlRsuYJFaPWeEcDMfzStpM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-342-zFzYHi_wNxSfo9fhPr4raw-1; Tue,
 22 Apr 2025 19:05:40 -0400
X-MC-Unique: zFzYHi_wNxSfo9fhPr4raw-1
X-Mimecast-MFC-AGG-ID: zFzYHi_wNxSfo9fhPr4raw_1745363139
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C0C3C180048E;
	Tue, 22 Apr 2025 23:05:39 +0000 (UTC)
Received: from omen.home.shazbot.org (unknown [10.22.88.22])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3381418001DD;
	Tue, 22 Apr 2025 23:05:38 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
To: bhelgaas@google.com,
	rafael@kernel.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
	linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] PCI/PM: Elevate PM usage during reset probing
Date: Tue, 22 Apr 2025 17:05:30 -0600
Message-ID: <20250422230534.2295291-1-alex.williamson@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

I encountered a confusing scenario where a device reports NoSoftRst- and
doesn't have any associated quirks to set PCI_DEV_FLAGS_NO_PM_RESET, but
it refuses to probe for PM reset support using the sysfs reset_method
attribute.  The reason turns out to be that we don't increment the usage
count while probing, the driver has the device in D3, where this system
seems to support D3cold, and the PM control register is read back as
0xffff.

The cleanup __free helper seems to be the cleanest solution here, versus
refactoring to a common exit point or wrappers around reset_fn, but feel
free to suggest otherwise.  I see a couple potential other use cases for
this helper in the vfio code.

Please review.  Thanks,

Alex

Alex Williamson (2):
  PM: runtime: Define pm_runtime_put cleanup helper
  PCI: Increment PM usage counter when probing reset methods

 drivers/pci/pci-sysfs.c    | 3 +++
 include/linux/pm_runtime.h | 2 ++
 2 files changed, 5 insertions(+)

-- 
2.48.1


