Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAEFE405991
	for <lists+linux-pm@lfdr.de>; Thu,  9 Sep 2021 16:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237415AbhIIOsG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Sep 2021 10:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344403AbhIIOru (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Sep 2021 10:47:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0320EC0698D9
        for <linux-pm@vger.kernel.org>; Thu,  9 Sep 2021 07:38:40 -0700 (PDT)
Date:   Thu, 09 Sep 2021 14:38:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631198318;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ugHSDru2y0FT62fGSqDvf6XgsTKwO9yiMRZzZBZQpvI=;
        b=temOqG7qWh7S3bo9TRzRgTaengrvu+v0JBbAeHesDfr/8eGbcbnqC30JqAi/C+/q8oK3za
        1fU3dZtc4KforfQDhV5hU/nNUk5d5AHDXeVqr5K1zPYeZvk8Lo8NaQF+HOTnT3hvseA57e
        HlXWyOymtsVM7/bUCItQrjZgbb+PaIAhteHaO00HPSQ+5EIoMkZfm1raOexdUs3pCBxHTU
        Gs/qtwfk1i2RsR1PxIcyLtZKuHhaoJlAoopaZIej4JK2CE+OZglc1AdnarHrkaXKX9nAlC
        RVjfUZgTri9NeOto3AvSeK5tu3XsLElM8gbDvUPGzG7I83llU6wExB3b+jftVw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631198318;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ugHSDru2y0FT62fGSqDvf6XgsTKwO9yiMRZzZBZQpvI=;
        b=HqtW3jvH20IxIjJUVgT6MVZqHvBOqaPjnHkRSSuWFozI46Fz98iBHdCiGxhcGiaGdRoUB3
        J1PN6G5ovLMrSaBw==
From:   "thermal-bot for Maxime Ripard" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] dt-bindings: thermal: Make trips node optional
Cc:     Amit Kucheria <amitk@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Rob Herring <robh@kernel.org>
In-Reply-To: <20210721140424.725744-34-maxime@cerno.tech>
References: <20210721140424.725744-34-maxime@cerno.tech>
MIME-Version: 1.0
Message-ID: <163119831790.25758.1267778969015204261.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     22fc857538c3a256563bb796f978b6d4693f5aa3
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//22fc857538c3a256563bb796f978b6d4693f5aa3
Author:        Maxime Ripard <maxime@cerno.tech>
AuthorDate:    Wed, 21 Jul 2021 16:04:03 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Sat, 14 Aug 2021 15:42:30 +02:00

dt-bindings: thermal: Make trips node optional

Even though the previous binding made it a required child node, the
implementation in Linux never made it mandatory and just ignored thermal
zones without trip points.

This was even effectively encouraged, since the thermal core wouldn't
allow a thermal sensor to probe without a thermal zone.

In the case where you had a thermal device that had multiple sensors but
with enough knowledge to provide trip points for only a few of them,
this meant that the only way to make that driver probe was to provide a
thermal zone without the trips node required by the binding.

This obviously led to a fair number of device trees doing exactly that,
making the initial binding requirement ineffective.

Let's make it clear by dropping that requirement.

Cc: Amit Kucheria <amitk@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-pm@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20210721140424.725744-34-maxime@cerno.tech
---
 Documentation/devicetree/bindings/thermal/thermal-zones.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
index 164f715..a07de5e 100644
--- a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
+++ b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
@@ -215,7 +215,7 @@ patternProperties:
       - polling-delay
       - polling-delay-passive
       - thermal-sensors
-      - trips
+
     additionalProperties: false
 
 additionalProperties: false
