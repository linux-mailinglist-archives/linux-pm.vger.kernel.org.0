Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE6163530F
	for <lists+linux-pm@lfdr.de>; Wed, 23 Nov 2022 09:46:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235466AbiKWIqC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 23 Nov 2022 03:46:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiKWIqB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Nov 2022 03:46:01 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 062D332BA3;
        Wed, 23 Nov 2022 00:46:00 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="376161748"
X-IronPort-AV: E=Sophos;i="5.96,186,1665471600"; 
   d="scan'208";a="376161748"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2022 00:46:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="766637954"
X-IronPort-AV: E=Sophos;i="5.96,186,1665471600"; 
   d="scan'208";a="766637954"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga004.jf.intel.com with ESMTP; 23 Nov 2022 00:46:00 -0800
Received: from abityuts-desk1.fi.intel.com (abityuts-desk1.fi.intel.com [10.237.72.79])
        by linux.intel.com (Postfix) with ESMTP id A7EE1580897;
        Wed, 23 Nov 2022 00:45:58 -0800 (PST)
Message-ID: <635d481206b8945db751ea036cf789fe13b9698e.camel@gmail.com>
Subject: Re: [PATCH resend] platform/x86: intel-uncore-freq: add Emerald
 Rapids support
From:   Artem Bityutskiy <dedekind1@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Linux PM Mailing List <linux-pm@vger.kernel.org>
Date:   Wed, 23 Nov 2022 10:45:57 +0200
In-Reply-To: <0b867f52-5fe8-f0e8-3f05-746b1db0059e@redhat.com>
References: <20221122070014.3639277-1-dedekind1@gmail.com>
         <0b867f52-5fe8-f0e8-3f05-746b1db0059e@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        NML_ADSP_CUSTOM_MED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_SOFTFAIL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello Hans,

On Tue, 2022-11-22 at 16:30 +0100, Hans de Goede wrote:
There are 3 different issues with this patch, next time please
check your patch a bit more thorough before submitting it:

1. This is the first time I see this, or that the
platform-driver-x86@vger.kernel.org
list sees this. Next time please make sure you address the patch to the right
people the first time you send it:

sure, thanks.

2. This has checkpatch warnings which are easily fixable:

[hans@shalem platform-drivers-x86]$ scripts/checkpatch.pl 0001-platform-x86-
intel-uncore-freq-add-Emerald-Rapids-su.patch 
WARNING: Possible unwrapped commit description (prefer a maximum 75 chars per
line)

OK.

3. This fails to build on top of:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=for-next

OK, thanks for the pointer. I'd need platfrom-drivers-x86 git tree to include
this upstream commit:

7beade0dd41d x86/cpu: Add several Intel server CPU model numbers

Would you please consider updating?

Thanks!

