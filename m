Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0DF50E4DA
	for <lists+linux-pm@lfdr.de>; Mon, 25 Apr 2022 17:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243029AbiDYP6F (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 25 Apr 2022 11:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbiDYP6D (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 25 Apr 2022 11:58:03 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 300DA3B006
        for <linux-pm@vger.kernel.org>; Mon, 25 Apr 2022 08:54:59 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="325773759"
X-IronPort-AV: E=Sophos;i="5.90,288,1643702400"; 
   d="scan'208";a="325773759"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 08:54:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,288,1643702400"; 
   d="scan'208";a="660215212"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP; 25 Apr 2022 08:54:58 -0700
Received: from abityuts-desk1.fi.intel.com (abityuts-desk1.fi.intel.com [10.237.72.79])
        by linux.intel.com (Postfix) with ESMTP id 4328C5809EB;
        Mon, 25 Apr 2022 08:54:57 -0700 (PDT)
Message-ID: <70621d99576bca327283d3dccf39379405177bc5.camel@gmail.com>
Subject: Re: your patch "intel_idle: add 'preferred_cstates' module argument"
From:   Artem Bityutskiy <dedekind1@gmail.com>
To:     Jan Beulich <jbeulich@suse.com>
Cc:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Date:   Mon, 25 Apr 2022 18:54:56 +0300
In-Reply-To: <097a5547-2b0b-1b05-6b36-4e6a67e6f060@suse.com>
References: <097a5547-2b0b-1b05-6b36-4e6a67e6f060@suse.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        NML_ADSP_CUSTOM_MED,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_SOFTFAIL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 2022-04-25 at 17:47 +0200, Jan Beulich wrote:
> Artem,
> 
> while porting this change of yours to our clone of the driver in
> Xen, I've gained the impression that the respective MSR write
> wouldn't happen on all CPUs / cores. Was that an oversight, or am
> I overlooking something?

Hi,

on SPR the C1E promotion bit is "global". So any CPU can change it, and the
change should be visible to all CPUs.

But I can see that this is subtle and deserves at least a comment. Let me look
into this.

Artem.

