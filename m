Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8D906366ED
	for <lists+linux-pm@lfdr.de>; Wed, 23 Nov 2022 18:25:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235917AbiKWRZL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 23 Nov 2022 12:25:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236917AbiKWRZL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Nov 2022 12:25:11 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E8B18E0AF;
        Wed, 23 Nov 2022 09:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669224310; x=1700760310;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aHPTRHcVkUFTZr5J3tL/G7ryRw1ZZyMFvn0MlXiPpPk=;
  b=lEI9u7QCt9G99XEEpih+lKUJDypC1BiYweccJtN2DDsHxdaO6DMzkMHI
   v3oQblHbUw/fHCA611oP0Mr25EadrfJ6cwULb1Prf6FmZWYb3Lyz2eASR
   lrnejQyIm3m10EWRG86UgsQA/DbuyBPBm7niGXgRmydm+BzTlk31pcJab
   9s6iu+v5mTtsfkbakeTRjmjQl3MJrL1FiBMS6XliRCn2rAbkqwrJQe0tG
   4/n3HW5cbQAochYo7oYMzE3JUj6HfpMEYEeA2RiaVPxJJV9/f53jmBmxc
   AZ6u3SoSiZZfOXEWZYtVramMpSAV8WxVg+BrAmxqyjvcWdmBUlXhFYQ+c
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="312818625"
X-IronPort-AV: E=Sophos;i="5.96,187,1665471600"; 
   d="scan'208";a="312818625"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2022 09:25:09 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="747878276"
X-IronPort-AV: E=Sophos;i="5.96,187,1665471600"; 
   d="scan'208";a="747878276"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2022 09:25:09 -0800
Message-ID: <d0f51fe4d653c47d7fb9b464c19b58a866f58459.camel@linux.intel.com>
Subject: Re: [PATCH resend] platform/x86: intel-uncore-freq: add Emerald
 Rapids support
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Artem Bityutskiy <dedekind1@gmail.com>,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org,
        Linux PM Mailing List <linux-pm@vger.kernel.org>
Date:   Wed, 23 Nov 2022 09:25:08 -0800
In-Reply-To: <ee34cb44-9782-9c91-3ec8-3b9d37353b10@redhat.com>
References: <20221122070014.3639277-1-dedekind1@gmail.com>
         <0b867f52-5fe8-f0e8-3f05-746b1db0059e@redhat.com>
         <635d481206b8945db751ea036cf789fe13b9698e.camel@gmail.com>
         <01c732b1-7211-8298-61da-0a6892988743@redhat.com>
         <CAJZ5v0gqmZNRQ61LiG-HKVLLciC9=7MPUB9di0LhuUe_tjHJGg@mail.gmail.com>
         <ee34cb44-9782-9c91-3ec8-3b9d37353b10@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Hans,

> > > 

[...]

> > > Ugh, no, *NO*! I really expect Intel to do better here!
> > > 
Sorry, I didn't realize the CPUID is not added to rc1. Our internal
tree constantly gets rebased. So difficult to catch.

As you rule, I will communicate internally that apply on top of 
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=for-next
 
If doesn't build atleast add that to the patch notes.

BTW, I send my PULL from this tree and branch always.

Thanks,
Srinivas

> > > As I repeated explained with the
> > > 
> > > "platform/x86/intel: pmc/core: Add Raptor Lake support to pmc core
> > > driver"
> > > 
> > > patch I cannot just go and cherry-pick random patches merged
> > > through other trees
> > > because that may cause conflicts and will cause the merge to look
> > > really
> > > funky.
> > 
> > I don't think this is about requesting a cherry-pick though.
> > 
> > > There are proper ways to do this and this is not it!
> > > 
> > > This is something which Intel really *must* do correctly next time
> > > because
> > > having this discussion over and over again is becoming very
> > > tiresome!
> > > 
> > > So the proper way to do starts with realizing *beforehand* that
> > > things
> > > will not build on top of pdx86/for-next. By like actually doing
> > > a build-test based on top of pdx86/for-next instead of this
> > > nonsense of
> > > repeatedly sending me broken patches.
> > 
> > This patch is based on the mainline.  The requisite commit has been
> > included into the Linus' tree since at least 6.1-rc4 AFAICS and I
> > suppose that it has been tested on top of that.
> 
> Ah, I did not know that; and that is typically info which I would
> have expected to be explicitly mentioned in the non-existing cover-
> letter
> for this patch.
> 
> > 
> > You could in principle create a temporary branch based on 6.1-rc4 (or
> > a later -rc), apply the patch on top of it, merge your current branch
> > on top of that and merge it back into your current branch (that
> > should
> > result in a fast-forward merge, so the temporary branch can be
> > deleted
> > after it).
> 
> Yes I could merge rc4 into my for-next, but I'm not really a big fan
> of back-merges like this. I try to keep my for-next history linear
> based on the last rc1, because I find seeing what is going on
> a lot easier that way. But if this happens more often I guess
> I may need to get used to doing back-merges more often then
> just after rc1 is out.
> 
> What I don't understand is why this patch was not send as a part of
> the series starting which also had the
> "7beade0dd41d x86/cpu: Add several Intel server CPU model numbers"
> patch. That patch just adds a couple #define-s presumably there
> were more patches in that series actually using those defines.
> 
> Things would have been cleaner / easier if this patch had simply
> been a part of that series and if it was merged in one go with
> that series...
> 
> Btw this new CPU ID is also missing from:
> drivers/platform/x86/intel/pmc/core.c
> drivers/platform/x86/intel/ifs/core.c
> 
> At least I assume it will need to be added there too, although
> I guess it might not be as simple as only adding the CPU-id
> match there ?
> 
> > Alternatively, if you'd rather not do that, I can merge the Artem's
> > patch through the PM tree (it is PM-related after all).
> 
> If you can do that, that would be great, thank you.
> 
> > I suppose that your ACK would be applicable for that too?
> 
> Yes.
> 
> Regards,
> 
> Hans
> 
> 


