Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FDF078B587
	for <lists+linux-pm@lfdr.de>; Mon, 28 Aug 2023 18:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbjH1QpR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Mon, 28 Aug 2023 12:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231311AbjH1Qov (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Aug 2023 12:44:51 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3A47184
        for <linux-pm@vger.kernel.org>; Mon, 28 Aug 2023 09:44:48 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="365351123"
X-IronPort-AV: E=Sophos;i="6.02,208,1688454000"; 
   d="scan'208";a="365351123"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2023 09:44:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="715169321"
X-IronPort-AV: E=Sophos;i="6.02,208,1688454000"; 
   d="scan'208";a="715169321"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 28 Aug 2023 09:43:43 -0700
Received: from abityuts-desk1.ger.corp.intel.com (abityuts-desk1.fi.intel.com [10.237.68.150])
        by linux.intel.com (Postfix) with ESMTP id 780AB580D7B;
        Mon, 28 Aug 2023 09:43:41 -0700 (PDT)
Message-ID: <52419d763dbd93e91499084c2bf4c04b199857a3.camel@gmail.com>
Subject: Re: [PATCH v4 0/4] Sapphire Rapids C0.x idle states support
From:   Artem Bityutskiy <dedekind1@gmail.com>
To:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>
Cc:     Linux PM Mailing List <linux-pm@vger.kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 28 Aug 2023 19:43:40 +0300
In-Reply-To: <20230710093100.918337-1-dedekind1@gmail.com>
References: <20230710093100.918337-1-dedekind1@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        NML_ADSP_CUSTOM_MED,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On Mon, 2023-07-10 at 12:30 +0300, Artem Bityutskiy wrote:

> Artem Bityutskiy (4):
>   x86/umwait: use 'IS_ENABLED()'
>   x86/mwait: Add support for idle via umwait

If these 2 patches are OK now, is there a chance to get them merged?

>   intel_idle: rename 'intel_idle_hlt_irq_on()'
>   intel_idle: add C0.2 state for Sapphire Rapids Xeon

The intel_idle part requires a refresh, but I thought I'd do that if/when the
x86 bits are merged.

Thanks!

