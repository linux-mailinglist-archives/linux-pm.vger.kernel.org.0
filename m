Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70ED175425C
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jul 2023 20:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236597AbjGNSMg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Fri, 14 Jul 2023 14:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235350AbjGNSMc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Jul 2023 14:12:32 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 357512690
        for <linux-pm@vger.kernel.org>; Fri, 14 Jul 2023 11:12:09 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10771"; a="350411952"
X-IronPort-AV: E=Sophos;i="6.01,206,1684825200"; 
   d="scan'208";a="350411952"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 11:11:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10771"; a="1053151307"
X-IronPort-AV: E=Sophos;i="6.01,206,1684825200"; 
   d="scan'208";a="1053151307"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga005.fm.intel.com with ESMTP; 14 Jul 2023 11:11:49 -0700
Received: from abityuts-desk1.ger.corp.intel.com (abityuts-desk1.fi.intel.com [10.237.68.150])
        by linux.intel.com (Postfix) with ESMTP id 278D9580AFF;
        Fri, 14 Jul 2023 11:11:47 -0700 (PDT)
Message-ID: <d879fbfdd621239c278d3b306f99d93de03d4078.camel@gmail.com>
Subject: Re: [PATCH v4 3/4] intel_idle: rename 'intel_idle_hlt_irq_on()'
From:   Artem Bityutskiy <dedekind1@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     x86@kernel.org, Linux PM Mailing List <linux-pm@vger.kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Date:   Fri, 14 Jul 2023 21:11:47 +0300
In-Reply-To: <CAJZ5v0hb9ns2yZ==n83viqniCr4QqupY+FKR2Dy0jE0Obahq_g@mail.gmail.com>
References: <20230710093100.918337-1-dedekind1@gmail.com>
         <20230710093100.918337-4-dedekind1@gmail.com>
         <CAJZ5v0hb9ns2yZ==n83viqniCr4QqupY+FKR2Dy0jE0Obahq_g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        NML_ADSP_CUSTOM_MED,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 2023-07-14 at 17:34 +0200, Rafael J. Wysocki wrote:
> Any concerns regarding this?

No concerns, thanks!
