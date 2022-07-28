Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB6C58435D
	for <lists+linux-pm@lfdr.de>; Thu, 28 Jul 2022 17:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbiG1PmF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Jul 2022 11:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232060AbiG1PmE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Jul 2022 11:42:04 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA73C69F2C
        for <linux-pm@vger.kernel.org>; Thu, 28 Jul 2022 08:42:02 -0700 (PDT)
Date:   Thu, 28 Jul 2022 15:42:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1659022921;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o2pg7/Ef4iXgAIxmM/uUgaDhM60j6caLZmwwoXBpMQs=;
        b=lUyz4ML6jj5/ndQh/qO0aIA18YAtc9woXeFJhKjQD0MRrvLhWjikUavYjCEkrvw/P50szp
        W4u96tc8qK+4QsQfiX/0eWroCmmMRQCwqkBaa2dzn/g7Eug9Ev+Lrpc+HN1VSn8PZx0vZI
        lyRdr1mSKMyW4OBQajD/naRq7rPoUqxauNGDzkODPWbCiOR/wZEPRQeQ/pHVjIWEo2uRzN
        9nNo0vHu0+ADJRAqipmQ7ayi8E+SBEHBWGX7c7VZJNTDfrfXDxVphIgnzHtyqfOCxMWyHe
        pwRZ2BkAI6TZyBKkHTT9qlsL4m5NF6F3YI1EZG2yQIxIXBqZ/QG0x00z4CBPQQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1659022921;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o2pg7/Ef4iXgAIxmM/uUgaDhM60j6caLZmwwoXBpMQs=;
        b=6tBPJoIyu8w0ZTnVSnR49DEmgFa/5d/uV/fcn/IxF49VbeFy7MXl09KCoDg2j53DeU5dlw
        Eu6ffxJ8/cxiRlBw==
From:   "thermal-bot for Lukas Bulwahn" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] MAINTAINERS: add include/dt-bindings/thermal
 to THERMAL
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20220613124309.28790-1-lukas.bulwahn@gmail.com>
References: <20220613124309.28790-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Message-ID: <165902292023.15455.2835710756933197447.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     037a6ea0debbe3da3f5cef311d835fb7f1a5e2c7
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//037a6ea0debbe3da3f5cef311d835fb7f1a5e2c7
Author:        Lukas Bulwahn <lukas.bulwahn@gmail.com>
AuthorDate:    Mon, 13 Jun 2022 14:43:09 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 28 Jul 2022 17:29:43 +02:00

MAINTAINERS: add include/dt-bindings/thermal to THERMAL

Maintainers of the directory Documentation/devicetree/bindings/thermal
are also the maintainers of the corresponding directory
include/dt-bindings/thermal.

Add the file entry for include/dt-bindings/thermal to the appropriate
section in MAINTAINERS.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Link: https://lore.kernel.org/r/20220613124309.28790-1-lukas.bulwahn@gmail.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3ad3328..b0fbf28 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19586,6 +19586,7 @@ F:	Documentation/ABI/testing/sysfs-class-thermal
 F:	Documentation/devicetree/bindings/thermal/
 F:	Documentation/driver-api/thermal/
 F:	drivers/thermal/
+F:	include/dt-bindings/thermal/
 F:	include/linux/cpu_cooling.h
 F:	include/linux/thermal.h
 F:	include/uapi/linux/thermal.h
