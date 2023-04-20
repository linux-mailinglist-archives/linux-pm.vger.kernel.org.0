Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7DE76E8A3E
	for <lists+linux-pm@lfdr.de>; Thu, 20 Apr 2023 08:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232546AbjDTGSm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Thu, 20 Apr 2023 02:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbjDTGSl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Apr 2023 02:18:41 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE48746A6
        for <linux-pm@vger.kernel.org>; Wed, 19 Apr 2023 23:18:40 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="373537983"
X-IronPort-AV: E=Sophos;i="5.99,211,1677571200"; 
   d="scan'208";a="373537983"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2023 23:18:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="761024148"
X-IronPort-AV: E=Sophos;i="5.99,211,1677571200"; 
   d="scan'208";a="761024148"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP; 19 Apr 2023 23:18:40 -0700
Received: from abityuts-desk1.ger.corp.intel.com (abityuts-desk1.fi.intel.com [10.237.68.150])
        by linux.intel.com (Postfix) with ESMTP id 53BE1580505;
        Wed, 19 Apr 2023 23:18:39 -0700 (PDT)
Message-ID: <cb68f905246a8daa7d4c8fd387b6b147827b071a.camel@gmail.com>
Subject: Re: [PATCH 4/7] intel_idle: improve C-state flags handling
 robustness
From:   Artem Bityutskiy <dedekind1@gmail.com>
To:     "Zhang, Rui" <rui.zhang@intel.com>,
        "rafael@kernel.org" <rafael@kernel.org>
Cc:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Date:   Thu, 20 Apr 2023 09:18:38 +0300
In-Reply-To: <35a8253cf195fc804acee900380e31da5680f0ff.camel@intel.com>
References: <20230419143947.1342730-1-dedekind1@gmail.com>
         <20230419143947.1342730-5-dedekind1@gmail.com>
         <35a8253cf195fc804acee900380e31da5680f0ff.camel@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        NML_ADSP_CUSTOM_MED,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rui,

On Thu, 2023-04-20 at 01:50 +0000, Zhang, Rui wrote:
> what is the expected behavior for a state with CPUIDLE_FLAG_IBRS or
> CPUIDLE_FLAG_INIT_XSTATE set when using "force_irq_on"?
> the CPUIDLE_FLAG_IBRS/CPUIDLE_FLAG_INIT_XSTATE flag always wins, right?

Yes.

> I think it would be good to add a comment about this, say in patch 6/7.

Sure, will do.

Thanks!
