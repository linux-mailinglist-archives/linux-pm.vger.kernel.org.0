Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18F3570CE04
	for <lists+linux-pm@lfdr.de>; Tue, 23 May 2023 00:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232311AbjEVWeK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 May 2023 18:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbjEVWeJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 May 2023 18:34:09 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F4EA9C
        for <linux-pm@vger.kernel.org>; Mon, 22 May 2023 15:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684794848; x=1716330848;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=Eo97USfVaTkQcJ9Xc96+XvWhizVFjzMhO4g4VdF4O/k=;
  b=SWwyhSExs9BGpYmdWBy09WFlc4p89LYgoBJTgsaYzB0B0sEmo/MrNZeu
   19s5e+KUm2eklABobsN65F1tlLCMj4nuS16JyH0SWczDBuK0T6dyL3D4F
   vuYH0+nUbsfkIi4VPsvSrK2NkmBievKTkHlU7nwFH9aXxnznbURdcFFAp
   AZ7tMZcaP5IX8PG7ttRTFhCKbKJqKyngq1lz8RRBjquFodd0Pd/iZM4aS
   ZV+dEOe2U87Jl9rPUZrnbjTDpmt8eGzTkAHWZHBvEhjB0iuHVMefofMUZ
   3Qr0vf9GnjGaQr0Z+h27R8WOr+6ex+uL2G10Sv765OL6vBq784I/7U1Sr
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="342517031"
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="scan'208";a="342517031"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2023 15:34:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="877929749"
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="scan'208";a="877929749"
Received: from lwatts-mobl1.amr.corp.intel.com ([10.212.7.85])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2023 15:34:05 -0700
Message-ID: <abcc6689c283bbe91b6fd16572cfd4a8d5e78cc6.camel@linux.intel.com>
Subject: Re: [CfP] Power Management and Thermal Control MC (LPC2023)
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Date:   Mon, 22 May 2023 15:33:51 -0700
In-Reply-To: <CAJZ5v0juUuy2xKZHMXAKSRtfQxMyL6z12AFdU8_ZbdFRKKrR=Q@mail.gmail.com>
References: <CAJZ5v0juUuy2xKZHMXAKSRtfQxMyL6z12AFdU8_ZbdFRKKrR=Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

On Mon, 2023-05-22 at 19:12 +0200, Rafael J. Wysocki wrote:
> Hi Folks,
>=20
> I'm going to submit a Power Management and Thermal Control
> micro-conference proposal for LPC2023 along the lines of what
> happened
> in the previous iterations of it.
>=20
> If you have topics that you'd like to be discussed there, please let
> me know by Friday, May 26.
>=20
> Please note that LPC MC topics are expected to cover work in progress
> or at the concept stage.=C2=A0 They are not  supposed to be about work
> that
> has been done already.
"
1.
Idle injection and soft IRQs:
We still have no good solution to avoid races with soft IRQ scheduling
while using idle injection. The previous post to kernel to solve this
issue is rejected. Peter proposed a change, that also didn't work.

I am proposing a discussion on how the solve this:
- May be we need to use some in kernel IRQ affinity change for the
forced idle CPUs
- Other potential solution?

"

2.
Thermal sysfs/API Update

Thermal sysfs v2
There was proposal to correctly abstract thermal zones, sensors,
cooling devices and policies. Are we happy with the current state?

- Add capability to define additional private attributes for a zone
like cpufreq

Thanks,
Srinivas

>=20
> Kind regards,
> Rafael

