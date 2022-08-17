Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67C0F596CD5
	for <lists+linux-pm@lfdr.de>; Wed, 17 Aug 2022 12:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235969AbiHQKaE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Aug 2022 06:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbiHQKaD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Aug 2022 06:30:03 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35807753A3
        for <linux-pm@vger.kernel.org>; Wed, 17 Aug 2022 03:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660732203; x=1692268203;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YFyw8ePpOR/YWgamqPT5omk7L5LB63Al9HrTqNicsbg=;
  b=lJK5OxxKVhXKq70jMKpa/4q8PJBrk9zHYNRpDj09krD+Cq8CI/m/6HXW
   GgqMh0AJKjHcP9sh3G5ij7kSur2N46afNW4OQECMnq42LslH1qPrqaNiI
   6OyYluMiHBQ1/VhnF2zcVhTihCURG8HoaueE0clnd/eqTcgsctUi5d/+F
   /w6/OLWNdKC4mbeMTNmF9iKEf1iGZtND32DMemo73Ot0ghVQyrR1DpUZC
   45z/WC/8Of8YIUKBooTveSBIQUEdJIsuvJlL1gwP4VbLBZGa0yvpDDElt
   WV7RaR5mKulSwzGfqAVic1tP13guLlQpGbhz7d4HE9tJbR87gm4Dl0ttF
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10441"; a="290030136"
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="290030136"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 03:30:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="675593350"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 17 Aug 2022 03:30:01 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id AFD4F192; Wed, 17 Aug 2022 13:30:14 +0300 (EEST)
Date:   Wed, 17 Aug 2022 13:30:14 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: How to get "wake up reason" for Suspend-to-Idle
Message-ID: <YvzDNgBgMiMrfc1M@black.fi.intel.com>
References: <CAAd53p6VowO3WJt4mUJtxJenL8qbxtPFtXGjgiMkckX71bPrfw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAd53p6VowO3WJt4mUJtxJenL8qbxtPFtXGjgiMkckX71bPrfw@mail.gmail.com>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On Wed, Aug 17, 2022 at 03:08:18PM +0800, Kai-Heng Feng wrote:
> We are seeing laptops wake up when Thunderbolt dock gets plugged, or
> even wake up on AC plugging.
> 
> On Windows these events are logged with "Wakeup Reason", and if the
> wakeup event is from unplugging AC, the system will be put to suspend
> again.
> 
> So I wonder if it's possible to get the "Wakeup Reason" under Linux?
> 
> '/sys/power/wakeup_count' seems to be insufficient for this purpose.

I don't know if there is a way but unfortunately several systems (or
their firmware) are expecting Windows style "dark resume" so they pretty
much wake up each time something gets plugged or even unplugged to these
ports. Linux does not have similar mechanism at the moment but I think
at least if you have lid closed it will eventually go back to s2idle.
