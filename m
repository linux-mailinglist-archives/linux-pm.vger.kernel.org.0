Return-Path: <linux-pm+bounces-25981-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76954A97AE5
	for <lists+linux-pm@lfdr.de>; Wed, 23 Apr 2025 01:06:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFEE61B62C21
	for <lists+linux-pm@lfdr.de>; Tue, 22 Apr 2025 23:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8D22D0260;
	Tue, 22 Apr 2025 23:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gVrAzPMv"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDE1262FE2
	for <linux-pm@vger.kernel.org>; Tue, 22 Apr 2025 23:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745363160; cv=none; b=sxuhN+DM5ZOc4b+yWZsMkZFnOdPX2/h0lMp5KqdnIgATswfVLJOj2ixhaxxMCa54sDts1kWr+kV2bfrKNLj1dFljSIbg51EqAfUn8xBdjyMh9kCXzraWbGyqFHPIWJ/KLE+hEw32uRdWU7HpofRkSMsoeDYqDFiwszDtY1O/VO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745363160; c=relaxed/simple;
	bh=irEw6+L+FOASxlUvYZZgJczgjod4d4aOBm/qDTnfY3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kE7+u9sgBIJsDDfs9wkW3nx1JymjnZIymRbQBh73JHw6R6CRgBRJPQnfLG87TQ272NxOeNjHSReK49gYrP8rUkeUlHQI4XAxUvS51gZWzg69nydPy+CBTdjpJpjH0+LnhZiQomqeBN4slG5cUWewutyRATkYwB4NQzGBl21UPfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gVrAzPMv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745363157;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IkY27Gdp5eznLfjbt7qpVQ0OYk/4ucZm/cTdksHi7i8=;
	b=gVrAzPMvjEZoyAmEbj8i9w47Uj38DhLD1BUhcITIfLDoR0r1hDOyf5v9S35A+jYMbWngnt
	ds1Bau714tANn8N24h1r0Ev/D18g6HHHIJgk1X4g//MEQzNyexk6TtfHKoyZBXCQDmVxRY
	FtLOh/yFafuzfNNQwT8TESVubnrb4vs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-642-sFOpMImRNl60evbqp62llg-1; Tue,
 22 Apr 2025 19:05:42 -0400
X-MC-Unique: sFOpMImRNl60evbqp62llg-1
X-Mimecast-MFC-AGG-ID: sFOpMImRNl60evbqp62llg_1745363141
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 94E2C180056F;
	Tue, 22 Apr 2025 23:05:41 +0000 (UTC)
Received: from omen.home.shazbot.org (unknown [10.22.88.22])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 283DA18001D7;
	Tue, 22 Apr 2025 23:05:39 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
To: bhelgaas@google.com,
	rafael@kernel.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
	linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] PM: runtime: Define pm_runtime_put cleanup helper
Date: Tue, 22 Apr 2025 17:05:31 -0600
Message-ID: <20250422230534.2295291-2-alex.williamson@redhat.com>
In-Reply-To: <20250422230534.2295291-1-alex.williamson@redhat.com>
References: <20250422230534.2295291-1-alex.williamson@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Define a cleanup helper for use with __free to automatically drop the
device usage count when out of scope.

Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 include/linux/pm_runtime.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
index 7fb5a459847e..69d4b2929ee6 100644
--- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -466,6 +466,8 @@ static inline int pm_runtime_put(struct device *dev)
 	return __pm_runtime_idle(dev, RPM_GET_PUT | RPM_ASYNC);
 }
 
+DEFINE_FREE(pm_runtime_put, struct device *, if (_T) pm_runtime_put(_T))
+
 /**
  * __pm_runtime_put_autosuspend - Drop device usage counter and queue autosuspend if 0.
  * @dev: Target device.
-- 
2.48.1


