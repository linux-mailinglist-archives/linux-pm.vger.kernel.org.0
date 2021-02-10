Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC8F5316C71
	for <lists+linux-pm@lfdr.de>; Wed, 10 Feb 2021 18:22:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231987AbhBJRVy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 Feb 2021 12:21:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:43568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230263AbhBJRVx (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 10 Feb 2021 12:21:53 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D84C864E7E;
        Wed, 10 Feb 2021 17:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612977674;
        bh=oi52NGlFNqNCCDTyPgjBQebaWnixIVhZEGbGu5Pid9A=;
        h=From:To:Subject:Date:From;
        b=EkRfWXtT6a/l9KhePFhdWLBdlF/k1U6A0sEAuQidBeRpaF5bo8UT/6nJ7me6Lddm+
         w5jlkH5jBdeAjWz+vBDRedDK1KnfwTfeSrrdSrUJeKgH5q23lEGfNKJUuSKBUzAxsP
         E6iCnq8k7p+yUfnviu03aP1C4AJuxWT89g0Pv0xQ6LgWBc2DVzuGviwIUqsEOSWecA
         a59r9thS3acScYLygUFnrk1up4cWVmKb7s2vlcED3glbbh9nWbKmnmAgc2nwOwQ3UE
         JJZyQ9OJBVIDOChJgU0A3BX1T89mPUr6TQtaAme6PSNvqSQ/B1Uy8iK/3aLZeBTHJy
         ah3NYeP2PUpbg==
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH 1/3] MAINTAINERS: power: supply: add entry for S3C ADC battery driver
Date:   Wed, 10 Feb 2021 18:21:06 +0100
Message-Id: <20210210172108.334896-1-krzk@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The S3C ADC battery driver is a very old piece of code but still used by
(very old as well) S3C24xx platforms (iPAQ h1930/h1940/rx1950).
Currently the header file is not covered by maintainers file, so it
might look abandoned.  Add a new entry for entire S3C ADC battery driver
with Krzysztof Kozlowski as maintainer (as Krzysztof maintains still
Samsung S3C24xx platform) to indicate that some basic review can take
place.

However considering that the S3C24xx platform is quite old with only few
users currently and Krzysztof does not have the actual hardware, let's
mark the driver as "Odd fixes".

Cc: Sebastian Reichel <sre@kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5f7aa507b812..6abf7cc513df 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15614,6 +15614,13 @@ S:	Supported
 W:	http://www.ibm.com/developerworks/linux/linux390/
 F:	drivers/s390/scsi/zfcp_*
 
+S3C ADC BATTERY DRIVER
+M:	Krzysztof Kozlowski <krzk@kernel.org>
+L:	linux-samsung-soc@vger.kernel.org
+S:	Odd Fixes
+F:	drivers/power/supply/s3c_adc_battery.c
+F:	include/linux/s3c_adc_battery.h
+
 S3C24XX SD/MMC Driver
 M:	Ben Dooks <ben-linux@fluff.org>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-- 
2.25.1

