Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D1974CEBFE
	for <lists+linux-pm@lfdr.de>; Sun,  6 Mar 2022 15:51:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbiCFOwI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 6 Mar 2022 09:52:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiCFOwI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 6 Mar 2022 09:52:08 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D531B6A035
        for <linux-pm@vger.kernel.org>; Sun,  6 Mar 2022 06:51:15 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6200,9189,10277"; a="254172859"
X-IronPort-AV: E=Sophos;i="5.90,159,1643702400"; 
   d="scan'208";a="254172859"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2022 06:51:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,159,1643702400"; 
   d="scan'208";a="812235549"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga005.fm.intel.com with ESMTP; 06 Mar 2022 06:51:15 -0800
Received: from abityuts-desk1.fi.intel.com (abityuts-desk1.fi.intel.com [10.237.68.32])
        by linux.intel.com (Postfix) with ESMTP id 1AD06580A85;
        Sun,  6 Mar 2022 06:51:13 -0800 (PST)
Message-ID: <aec20cd55501f0aaeabe00609437087bb3faf2f2.camel@gmail.com>
Subject: Re: [PATCH] turbostat: fix PC6 displaying on some systems
From:   Artem Bityutskiy <dedekind1@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM Mailing List <linux-pm@vger.kernel.org>
Date:   Sun, 06 Mar 2022 16:51:12 +0200
In-Reply-To: <20211004105224.3145916-1-dedekind1@gmail.com>
References: <20211004105224.3145916-1-dedekind1@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        NML_ADSP_CUSTOM_MED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 2021-10-04 at 13:52 +0300, Artem Bityutskiy wrote:
> From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
> 
> 'MSR_PKG_CST_CONFIG_CONTROL' encodes the deepest allowed package C-state limit,
> and turbostat decodes it.
> 
> Before this patch: turbostat does not recognize value "3" on Ice Lake Xeon
> (ICX), treats it as "unknown", and does not display any package C-states in the
> results table.
> 
> After this patch: turbostat recognizes value 3 on ICX, treats it as "PC6", and
> correctly displays package C-states in the results table.
> 
> Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>

Hi Rafael,

would you please take a look at this patch and possibly apply it? Thanks!

