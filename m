Return-Path: <linux-pm+bounces-1393-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE1681985D
	for <lists+linux-pm@lfdr.de>; Wed, 20 Dec 2023 07:02:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 020F91F269E7
	for <lists+linux-pm@lfdr.de>; Wed, 20 Dec 2023 06:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3203FC06;
	Wed, 20 Dec 2023 06:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Xk7beHXK"
X-Original-To: linux-pm@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6331516403;
	Wed, 20 Dec 2023 06:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=V2XLrvBNlSvWfWER+NFbcM1HOV3BBjacqgahQWtCuOM=; b=Xk7beHXKtJ6Wz9V6Fw3nuUGOED
	UFmT6F7UO9YDBALVRzKcbM3UMF6Kc/0z5AESygtNhc2dqThgxkqV6lvphbtUCOGZtLMA4wQ95OoAa
	fhT7juFXJ7nCATsKlitGecglDtMkQiT55Qm31aRpgNEoLDtxVsFWyj3WoREU00pRg/0DrVGLwEfji
	pTn/539nYu5tSRR9MSAHxPJhBO9XhqxXiD9HOCpUi6Bt+6ryrFEFXlPKL3Y+7EjXpJBBVHkMGyTko
	2V9/MZgBYT29fy4RoZVySi9zIwAeuxfYJK5k7KCcl/OhdUuiOszeDlh7ieWzo2oQjU+myJ75HyOrJ
	ECD83tsw==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rFpfK-00GF2z-26;
	Wed, 20 Dec 2023 06:02:46 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>,
	Len Brown <len.brown@intel.com>,
	linux-pm@vger.kernel.org
Subject: [PATCH] PM: hibernate: repair Excess function parameter warning
Date: Tue, 19 Dec 2023 22:02:46 -0800
Message-ID: <20231220060246.511-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Function swsusp_close() does not have any parameters, so remove the
description of parameter @exclusive to prevent this warning.

swap.c:1573: warning: Excess function parameter 'exclusive' description in 'swsusp_close'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Len Brown <len.brown@intel.com>
Cc: linux-pm@vger.kernel.org
---
 kernel/power/swap.c |    1 -
 1 file changed, 1 deletion(-)

diff -- a/kernel/power/swap.c b/kernel/power/swap.c
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -1566,7 +1566,6 @@ put:
 
 /**
  * swsusp_close - close resume device.
- * @exclusive: Close the resume device which is exclusively opened.
  */
 
 void swsusp_close(void)

