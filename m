Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0C6519DE65
	for <lists+linux-pm@lfdr.de>; Fri,  3 Apr 2020 21:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728296AbgDCTMr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 Apr 2020 15:12:47 -0400
Received: from forwardcorp1p.mail.yandex.net ([77.88.29.217]:44082 "EHLO
        forwardcorp1p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728066AbgDCTMr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 Apr 2020 15:12:47 -0400
Received: from mxbackcorp1j.mail.yandex.net (mxbackcorp1j.mail.yandex.net [IPv6:2a02:6b8:0:1619::162])
        by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id 342ED2E1555;
        Fri,  3 Apr 2020 22:12:44 +0300 (MSK)
Received: from sas1-9998cec34266.qloud-c.yandex.net (sas1-9998cec34266.qloud-c.yandex.net [2a02:6b8:c14:3a0e:0:640:9998:cec3])
        by mxbackcorp1j.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id y5PtIN9u6I-ChZ4i8S5;
        Fri, 03 Apr 2020 22:12:44 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1585941164; bh=yErTpK2nek3FYXUaVjUvzfjtEJ5xZKzHKIulJz8EEmU=;
        h=Message-ID:Date:Subject:To:From:Cc;
        b=aZNKkf1PAT2uMTYThr+HhGWR2Ixsnd9gj61BogSQED7jnDHa/66BQpSimYqvVn8tH
         lV7HV5ICqeAzhd2KbCj1gZiBRJOU8CPDWXQPzT0eHKaKStUMqYvUl/DdalJaLdl6VY
         UqFxVgHtINW/lOx0e2ntgqIyoWnHLDaYSGs4llZs=
Authentication-Results: mxbackcorp1j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from unknown (unknown [2a02:6b8:0:506:f4ac:c870:e5e5:4233])
        by sas1-9998cec34266.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id g0mID34J1t-ChX81rkp;
        Fri, 03 Apr 2020 22:12:43 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
From:   Sergey Vidishev <sergeyv@yandex-team.ru>
To:     linux-kernel@vger.kernel.org
Cc:     Sergey Vidishev <sergeyv@yandex-team.ru>, trivial@kernel.org,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Javi Merino <javi.merino@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-pm@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH] Documentation: cpu-idle-cooling: fix diagram for 33% duty cycle
Date:   Fri, 03 Apr 2020 22:12:42 +0300
Message-ID: <2374188.AZIXMmL6Zy@sergeyv-box>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Signed-off-by: Sergey Vidishev <sergeyv@yandex-team.ru>
---
 Documentation/driver-api/thermal/cpu-idle-cooling.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/driver-api/thermal/cpu-idle-cooling.rst b/
Documentation/driver-api/thermal/cpu-idle-cooling.rst
index 9f0016ee4cfb..a1c3edecae00 100644
--- a/Documentation/driver-api/thermal/cpu-idle-cooling.rst
+++ b/Documentation/driver-api/thermal/cpu-idle-cooling.rst
@@ -95,28 +95,28 @@ and this variation will modulate the cooling effect.
 
 ::
 
      ^
      |
      |
      |-------                 -------
      |_______|_______________|_______|___________
 
      <------>
        idle  <-------------->
                 running
 
-      <----------------------------->
-              duty cycle 33%
+      <--------------------->
+          duty cycle 33%
 
 
      ^
      |
      |
      |-------         -------
      |_______|_______|_______|___________
 
      <------>
        idle  <------>
               running
 
       <------------->
-- 
2.17.1




