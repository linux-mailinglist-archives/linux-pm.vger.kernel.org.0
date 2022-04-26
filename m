Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 768CD50FB1D
	for <lists+linux-pm@lfdr.de>; Tue, 26 Apr 2022 12:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237276AbiDZKiL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 Apr 2022 06:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240986AbiDZKhz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 Apr 2022 06:37:55 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2619F10DE
        for <linux-pm@vger.kernel.org>; Tue, 26 Apr 2022 03:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650968566; x=1682504566;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=93qH1TAJOPKEYm0Y8RSvYHDJaobslV+cAJ0c9DtOyEg=;
  b=BLm+4fkmgMlY/rbNVPloaGx/seh2xpzH3Tc8AEH5NLM2kCpP5whg3K9e
   JYSlRS/4+29eDdqptuvliOHRWw9knWsQWALVARgXOF0qNyZigylow7d8x
   C1CjnlU3G4WoZrupalks2N382z/t8Ae/ttvaudopSYe91ADKmmrH+G+CU
   Ef24Ge/NzdWx9P4GreWTOVIOjSWGvYAb6YcPsPTM4iyFlh0rZWnHhuqES
   PK3UrNazBoi3wRnjxqd6LjzLTCQEvABPVyn4GujDUFJ2Ogm961dWm01/a
   9eo8+uJiTRUuNZesHj+HoCgY+VyNbr6HrMwd6koKlDptJNedR3KnmZxga
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="265697460"
X-IronPort-AV: E=Sophos;i="5.90,290,1643702400"; 
   d="scan'208";a="265697460"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 03:22:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,290,1643702400"; 
   d="scan'208";a="650137692"
Received: from linux.intel.com ([10.54.29.200])
  by FMSMGA003.fm.intel.com with ESMTP; 26 Apr 2022 03:22:45 -0700
Received: from abityuts-desk1.fi.intel.com (abityuts-desk1.fi.intel.com [10.237.72.79])
        by linux.intel.com (Postfix) with ESMTP id C5F79580AE2;
        Tue, 26 Apr 2022 03:22:44 -0700 (PDT)
Message-ID: <339d6f1495779ba402dab7f7940cdcae3bb94e71.camel@linux.intel.com>
Subject: Re: your patch "intel_idle: add core C6 optimization for SPR"
From:   Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
To:     Jan Beulich <jbeulich@suse.com>
Cc:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Date:   Tue, 26 Apr 2022 13:22:43 +0300
In-Reply-To: <af7b829e-0d4c-8e4d-faf7-e86f2813cdab@suse.com>
References: <af7b829e-0d4c-8e4d-faf7-e86f2813cdab@suse.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 2022-04-26 at 11:35 +0200, Jan Beulich wrote:
> Artem,
> 
> somewhat similarly to the C1E patch, while porting this one to our
> driver clone in Xen I've noticed that the code added here would not
> be reached in case the user specified a conflicting C1E-related
> command line option (which ought to be unrelated to C6 handling).
> In my port of the patch I've converted to
> 
>         /* Check if user prefers C1E over C1. */
>         if (preferred_states_mask & BIT(2, U) &&
>             /* Both can't be enabled, stick to the defaults. */
>             !(preferred_states_mask & BIT(1, U))) {
>                 ...
>         }

Hi, ack, I'll send a fix for this too.



