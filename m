Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC6852D62E
	for <lists+linux-pm@lfdr.de>; Thu, 19 May 2022 16:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbiESOe5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 May 2022 10:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbiESOe4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 May 2022 10:34:56 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E861179398
        for <linux-pm@vger.kernel.org>; Thu, 19 May 2022 07:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652970895; x=1684506895;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wcOVudT5cVsT7rbfUsAP5M5CSQhBUAGB6bH8KBKA8Kw=;
  b=mFT0GKkJzkyXxYlq4geFLBhfrAPrQqqOCjLchRbBgqQ+sK1WSkbUbS+1
   qlnWx5XocS9G/eXXfhqN3HLh8c3R9LNYDuHfCc3kabTur0gVSQDzB2NSc
   GbkmTnyuU+a636Q1DjsOWL/OIvawGeEi/jjlnJ5Zx0I6MEY81+IC5a3IQ
   Chtz/NmlgLOoLXwhbgDvHmIPgLOKAIVacCE49084aKboH07uGU5zB+Va5
   xELrPYI8rDNP/T7lV/8JC7uUauCJ6FNz9mx6XYec6fOXID/RI32Wri+KE
   JeQzeqoQ4CE3YlKrAsQyLC3mq9c0m7ybmC2T3H4NxLjfYmEuXAbKGW/+D
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10352"; a="259804214"
X-IronPort-AV: E=Sophos;i="5.91,237,1647327600"; 
   d="scan'208";a="259804214"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 07:34:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,237,1647327600"; 
   d="scan'208";a="570244506"
Received: from rzhang1-dev.sh.intel.com ([10.239.48.43])
  by orsmga007.jf.intel.com with ESMTP; 19 May 2022 07:34:54 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     rjw@rjwysocki.net
Cc:     linux-pm@vger.kernel.org, daniel.lezcano@linaro.org,
        sumeet.r.pawnikar@intel.com, len.brown@intel.com
Subject: [PATCH V2 0/4] PM/Thermal: Enhance PCH overheat handling
Date:   Thu, 19 May 2022 22:35:04 +0800
Message-Id: <20220519143508.3803894-1-rui.zhang@intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On some Intel client platforms like SKL/KBL/CNL/CML, there is a
PCH thermal sensor that monitors the PCH temperature and blocks the system
from entering S0ix in case it overheats.

Commit ef63b043ac86 ("thermal: intel: pch: fix S0ix failure due to PCH
temperature above threshold") introduces a delay loop to cool the
temperature down for this purpose.

However, in practice, we found that the time it takes to cool the PCH down
below threshold highly depends on the initial PCH temperature when the
delay starts, as well as the ambient temperature.

For example, on a Dell XPS 9360 laptop, the problem can be triggered 
1. when it is suspended with heavy workload running.
or
2. when it is moved from New Hampshire to Florida.

In these cases, the 1 second delay is not sufficient. As a result, the
system stays in a shallower power state like PCx instead of S0ix, and
drains the battery power, without user' notice.

In order to fix this, we
1. move the delay to .suspend_noirq phase instead, in order to
   do the cooling when the system is in a more quiescent state
2. expand the default overall cooling delay timeout to 60 seconds.
3. make sure the temperature is below threshold rather than equal to it.

Compared with V1, the last four patches are dropped from the series, and
we focus on the PCH Overheat issue only. Plus, splitted one of the patch
according to Rafael' suggestion.

thanks,
rui
