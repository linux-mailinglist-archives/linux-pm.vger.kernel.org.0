Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E67759700B
	for <lists+linux-pm@lfdr.de>; Wed, 17 Aug 2022 15:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236816AbiHQNe4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Aug 2022 09:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239273AbiHQNew (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Aug 2022 09:34:52 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F397B53
        for <linux-pm@vger.kernel.org>; Wed, 17 Aug 2022 06:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660743290; x=1692279290;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XTaAcVR6e112U7hsk5VyE6ny9Wqq3FAZHIkv8nCfc7Y=;
  b=JSFRIHLQZhgBpbGZWmIxEggbKmIO7aQ3Xc4AGWvUsAYd+TN4s9tpzNfs
   b4EQ0UdhARGg70ZSqrkXVtd9XV0/TxNS0jt677ertzgwk1KL5CdfAnayC
   zv7gOSOYEMFZKfGbSW+/W0lTtdAzLjH6sH9criJR82G+f+xyy6nuqX3o2
   kKtw1vfekkY/C/gGqOH41IEX6IW0kUo+H1eYmyp2blIVIzgcwHwcf6Dpo
   7LlkxhVAFPMVGpomKHGerqmjhA6noxDLxExVgls/T5TyBJBd4PN2tYzS6
   JU+eMb/qNryui9JLxWwUNNY3xZJ7VUkJSuRQDKs4hVq2/qt8xZJB/seEy
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10442"; a="354234379"
X-IronPort-AV: E=Sophos;i="5.93,243,1654585200"; 
   d="scan'208";a="354234379"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 06:34:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,243,1654585200"; 
   d="scan'208";a="667617965"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 17 Aug 2022 06:34:46 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 233F42F6; Wed, 17 Aug 2022 16:35:00 +0300 (EEST)
Date:   Wed, 17 Aug 2022 16:35:00 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: How to get "wake up reason" for Suspend-to-Idle
Message-ID: <YvzuhPmTtn74iruB@black.fi.intel.com>
References: <CAAd53p6VowO3WJt4mUJtxJenL8qbxtPFtXGjgiMkckX71bPrfw@mail.gmail.com>
 <YvzDNgBgMiMrfc1M@black.fi.intel.com>
 <CAAd53p7HDYz9b9rG236g4MVHAzksOKEOcDZW+MHYi4MoAbO99w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAd53p7HDYz9b9rG236g4MVHAzksOKEOcDZW+MHYi4MoAbO99w@mail.gmail.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Aug 17, 2022 at 08:53:00PM +0800, Kai-Heng Feng wrote:
> On Wed, Aug 17, 2022 at 6:30 PM Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> >
> > Hi,
> >
> > On Wed, Aug 17, 2022 at 03:08:18PM +0800, Kai-Heng Feng wrote:
> > > We are seeing laptops wake up when Thunderbolt dock gets plugged, or
> > > even wake up on AC plugging.
> > >
> > > On Windows these events are logged with "Wakeup Reason", and if the
> > > wakeup event is from unplugging AC, the system will be put to suspend
> > > again.
> > >
> > > So I wonder if it's possible to get the "Wakeup Reason" under Linux?
> > >
> > > '/sys/power/wakeup_count' seems to be insufficient for this purpose.
> >
> > I don't know if there is a way but unfortunately several systems (or
> > their firmware) are expecting Windows style "dark resume" so they pretty
> > much wake up each time something gets plugged or even unplugged to these
> > ports. Linux does not have similar mechanism at the moment but I think
> > at least if you have lid closed it will eventually go back to s2idle.
> 
> ChromeOS also developed their own version of dark resume [1], which
> checks  '/sys/power/wakeup_count' to decide if the system should go
> back to suspend again.

Right.

> However, if there's any spurious wakeup event occurs during s2idle
> like [2], checking 'wakeup_count' alone will put the system back to
> suspend, and the system will stuck in a wakeup/suspend loop.
> 
> So I think it's safer to implement the mechanism in the kernel, by
> implementing .suspend_again() callback for s2idle just like what S3
> does.
> However, to make the right decision on suspend or wakeup we need a
> concrete "wakeup reason", but I wonder how do we achieve that?
> 
> [1] https://chromium.googlesource.com/chromiumos/platform2/+/HEAD/power_manager/docs/dark_resume.md
> [2] https://bugzilla.kernel.org/show_bug.cgi?id=216295

Do we know why the AER event happens in the first place? I think that's
where we should look first. Perhaps there is something missing int the
Linux AER implementation that causes this?
