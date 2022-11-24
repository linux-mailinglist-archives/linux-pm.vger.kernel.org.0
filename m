Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC86B6372C0
	for <lists+linux-pm@lfdr.de>; Thu, 24 Nov 2022 08:22:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbiKXHMc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Nov 2022 02:12:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiKXHMR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Nov 2022 02:12:17 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67CE6CFEAD;
        Wed, 23 Nov 2022 23:17:05 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="315383055"
X-IronPort-AV: E=Sophos;i="5.96,189,1665471600"; 
   d="scan'208";a="315383055"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2022 23:04:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="674991824"
X-IronPort-AV: E=Sophos;i="5.96,189,1665471600"; 
   d="scan'208";a="674991824"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP; 23 Nov 2022 23:04:30 -0800
Received: from abityuts-desk1.fi.intel.com (abityuts-desk1.fi.intel.com [10.237.72.79])
        by linux.intel.com (Postfix) with ESMTP id 03D7B580B9E;
        Wed, 23 Nov 2022 23:04:28 -0800 (PST)
Message-ID: <3fc564b6ad31ec8026102dda1a8bd4fbb27161c1.camel@gmail.com>
Subject: Re: [PATCH resend] platform/x86: intel-uncore-freq: add Emerald
 Rapids support
From:   Artem Bityutskiy <dedekind1@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Linux PM Mailing List <linux-pm@vger.kernel.org>
Date:   Thu, 24 Nov 2022 09:04:27 +0200
In-Reply-To: <01c732b1-7211-8298-61da-0a6892988743@redhat.com>
References: <20221122070014.3639277-1-dedekind1@gmail.com>
         <0b867f52-5fe8-f0e8-3f05-746b1db0059e@redhat.com>
         <635d481206b8945db751ea036cf789fe13b9698e.camel@gmail.com>
         <01c732b1-7211-8298-61da-0a6892988743@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        NML_ADSP_CUSTOM_MED,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Hans,

On Wed, 2022-11-23 at 15:37 +0100, Hans de Goede wrote:
> Ugh, no, *NO*! I really expect Intel to do better here!
...
> patch I cannot just go and cherry-pick random patches merged through other trees
> because that may cause conflicts and will cause the merge to look really
> funky.

I did not suggest or imply to cherry-pick.

Back when I was a kernel subsystem maintainer, I did merge Linus' master
sometimes, when there was a good reason. And this is what I implied by asking if
you'd consider updating: the referenced patch is in Linus' tree.

Also, just to be clear. I did accept the criticism in your first reply. This e-
mail seems to partially repeat the criticism, so let me do better job explicitly
addressing it.

1. I apologize for sending this patch against a wrong tree. It was my mistake.
This caused confusion. Sorry for this, and I do mean it. I do realize this
caused troubles and you wasted your time because of this.
2. I apologize for the commit message with more than 75 characters per line. I
acknowledge that I should have followed checkpatch.pl suggestion. Personally, I
do not think it is a big deal, but I do understand that it is not that difficult
to just follow checkpatch.pl suggestions.

I did not participate in kernel community much for the last 7 or so years, and
some of my knowledge/skills are rust/out-of-date. I acknowledge that too. But
basics like "won't cherry pick random patches" I do understand.

> Acked-by: Hans de Goede <hdegoede@redhat.com>

Thank you, this is appreciated.

Artem.

