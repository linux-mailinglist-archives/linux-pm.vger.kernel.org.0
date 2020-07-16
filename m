Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC8022197E
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jul 2020 03:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728112AbgGPBaI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jul 2020 21:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727105AbgGPBaH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jul 2020 21:30:07 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E7EC061755;
        Wed, 15 Jul 2020 18:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Cc:To:Subject:From:Sender:Reply-To:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=9NuwhqVj/zsoi98TNdlLdHx/B5plb0BCl27m5hSL7VA=; b=fsxo3kFl/nwOdchW2Be3CHpyQx
        EqPJAhl0r5NK9PJN2jIiXh3j4svZXxKIfmlLiVLlN8TObAsQCujTIHMr93EELHUj5ehHplvkr2YhP
        SBnJWY+z+lCVc6OKEheNQ1dEnTmGPrEP7xy2c4CeOC0Y8Vpw1oODtd+mlOA74bzQqAGClV2lS5X56
        mhVL+7VZQrlRdN5mtCSSlUrNIHekcEeaUN3+de8H08wF35JGwNO6EWBG98TGVV2Z0Zi1bD+qlKfjH
        emVkR5IoMYsezsEM5NmOctej0NihCTBxjFyGF+emUcdid8/PWmTnppQdHlLgdG5InKpadX863V8Zi
        ciDbMZiw==;
Received: from [2601:1c0:6280:3f0::19c2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jvsiq-0000Uh-JB; Thu, 16 Jul 2020 01:30:04 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] power: fix duplicated words in bq2415x_charger.h
To:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Cc:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        Sebastian Reichel <sre@kernel.org>
Message-ID: <74a380ee-d0a7-a58b-5740-6f1049d05d76@infradead.org>
Date:   Wed, 15 Jul 2020 18:30:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Drop the doubled word "for".
Change "It it" to "If it".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Pali Rohár <pali@kernel.org>
Cc: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org
---
 include/linux/power/bq2415x_charger.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20200714.orig/include/linux/power/bq2415x_charger.h
+++ linux-next-20200714/include/linux/power/bq2415x_charger.h
@@ -14,8 +14,8 @@
  * value is -1 then default chip value (specified in datasheet) will be
  * used.
  *
- * Value resistor_sense is needed for for configuring charge and
- * termination current. It it is less or equal to zero, configuring charge
+ * Value resistor_sense is needed for configuring charge and
+ * termination current. If it is less or equal to zero, configuring charge
  * and termination current will not be possible.
  *
  * For automode support is needed to provide name of power supply device

