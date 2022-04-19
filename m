Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62CB85071DC
	for <lists+linux-pm@lfdr.de>; Tue, 19 Apr 2022 17:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353830AbiDSPf1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Apr 2022 11:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231163AbiDSPf1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Apr 2022 11:35:27 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BCEF186E2
        for <linux-pm@vger.kernel.org>; Tue, 19 Apr 2022 08:32:45 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="326693468"
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="326693468"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 08:32:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="666414427"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga004.jf.intel.com with ESMTP; 19 Apr 2022 08:32:43 -0700
Received: from abityuts-desk1.fi.intel.com (abityuts-desk1.fi.intel.com [10.237.72.79])
        by linux.intel.com (Postfix) with ESMTP id 4A4725807D2
        for <linux-pm@vger.kernel.org>; Tue, 19 Apr 2022 08:32:42 -0700 (PDT)
Message-ID: <46b99f3914347190d396dd7eecf61435c6a67bec.camel@gmail.com>
Subject: pepc: new tool for configuring Linux PM
From:   Artem Bityutskiy <dedekind1@gmail.com>
To:     linux-pm@vger.kernel.org
Date:   Tue, 19 Apr 2022 18:32:41 +0300
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        NML_ADSP_CUSTOM_MED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_SOFTFAIL,
        SPOOFED_FREEMAIL,SPOOF_GMAIL_MID,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

we've released a new tool for configuring various Linux power management
aspects. The tool is called "pepc".

Please, find the tool and its description here: https://github.com/intel/pepc

Short highlights.

1. BSD license.
2. Carefully written in python3 with a lot of focus on maintainability.
3. Makes it easy to configure P/C-states and some other PM-related aspects.

In short, I deal with Linux power management a lot, and at some point I got
tired of maintaining various little shell scripts for doing this and that (e.g.,
enable C1 on cores 5 and 6 of package #1, and disable it on all other CPUs). So
I started the pepc project for myself, but then it grew into a useful utility
and we published it.

We keep improving the tool and add features as we need.

Artem.

