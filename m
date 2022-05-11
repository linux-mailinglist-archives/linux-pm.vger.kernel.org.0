Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10934523088
	for <lists+linux-pm@lfdr.de>; Wed, 11 May 2022 12:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbiEKKRa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 May 2022 06:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbiEKKR2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 May 2022 06:17:28 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A138024BF7
        for <linux-pm@vger.kernel.org>; Wed, 11 May 2022 03:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1652264245; x=1683800245;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=e76YbbcJAIaWL6oq8ERlef6zyHi3bYsCnwvHmGABLoM=;
  b=qTcCqMTAIL191JjX83/CAgBAwjqqSsyR8/8z87KjDwHMLvvLddLCjFU4
   ENgO32ylvjjJWazzCqPAzr/CbBLC2XlU0sles2R/CIQaYpYl8JKAdMZ19
   81hIqonBFmlT4U/82Cnpg1AqWdDtN67D2zG0H9pmT0eDfQc9+YXOiosiZ
   5gwOTpzCZAsqa7f6TbIiD9+BNHKRONkc1UpOSQT56FAV9MMsQgUjgAGQJ
   aEDcNYaFBy9HGPKr/OgltSAD1YrgaotfIYnp7MGqXagugCPqy8D1Sx+CM
   ucIgXFG5ynMSnhtT6Uh8Q6l3WoJ97MNuGaKEcM8iUrkNd3sDGdpAO2RJS
   g==;
X-IronPort-AV: E=Sophos;i="5.91,216,1647298800"; 
   d="scan'208";a="23806256"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 11 May 2022 12:17:21 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Wed, 11 May 2022 12:17:21 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Wed, 11 May 2022 12:17:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1652264241; x=1683800241;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=e76YbbcJAIaWL6oq8ERlef6zyHi3bYsCnwvHmGABLoM=;
  b=YUZ/P4IsjG6WTqFxUNl5MqsoZ1vTQX9a+wJrNzyfll8ToxISMh2eTne/
   IQmuonU34NCQQ1YFfkCSTILuFdM/M685TPcVetYxAxjmNpVoMWIwKqzK6
   WZnmpgaiD0KExC/sviHDFIIYD/ssJjlEAY1QMp2OMeBssB1Cq5hpEwSyg
   KBWq4hitQ56xbundDFE67o2viYVfQpXV+JMx5Fd54lDzHW2NlgpcXgTTa
   mnV6sKTwIGx49zkPLZMm/RnAPJkTDM7n1KvZEIosFt8rQ1+OZPUgOcJhX
   0VHiBmvRJRaOu/+bQP2uBlztVZ6aL+ubrOlIyTRapxeWwW/tPBA7YCL9Q
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,216,1647298800"; 
   d="scan'208";a="23806255"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 11 May 2022 12:17:21 +0200
Received: from steina-w.localnet (unknown [10.123.49.12])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 71977280070;
        Wed, 11 May 2022 12:17:21 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Nitin Garg <nitin.garg@nxp.com>
Cc:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: (EXT) RE: [PATCH 2/2] thermal/drivers/thermal_helpers: Adjust output format
Date:   Wed, 11 May 2022 12:17:19 +0200
Message-ID: <4711874.GXAFRqVoOG@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <AM9PR04MB81964FA6990F9E19F39E2A399AC99@AM9PR04MB8196.eurprd04.prod.outlook.com>
References: <20220408110920.3809225-1-alexander.stein@ew.tq-group.com> <82d08ff0-41bf-d249-1216-0da3f0cdc5b9@linaro.org> <AM9PR04MB81964FA6990F9E19F39E2A399AC99@AM9PR04MB8196.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello,

Am Mittwoch, 11. Mai 2022, 00:48:00 CEST schrieb Nitin Garg:
> On 08/04/2022 13:09, Alexander Stein wrote:
> >> Outputs like this where -1 is printed as unsigned is somewhat misleading
> >> 
> >>   thermal thermal_zone1: Trip3[type=0,temp=48000]:trend=4,throttle=1
> >>   thermal cooling_device3: cur_state=1
> >>   thermal cooling_device3: old_target=-1, target=2
> >>   thermal cooling_device3: zone1->target=1
> >>   thermal cooling_device3: zone1->target=2
> >>   thermal cooling_device3: zone1->target=18446744073709551615
> >>   thermal cooling_device3: set to state 2
> >> 
> >> With THERMAL_NO_TARGET assigning -1 as unsigned it make sense to print
> >> the target as signed integer, even if the type is actually unsigned.
> >> 
> >> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> >> ---
> >> An alternative would be to change thermal_instance::target from unsigned
> >> long to long, but this would entail a lot of API & driver changes as well
> >> which looks less intriguing.
> >> 
> >>   drivers/thermal/thermal_helpers.c | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >> 
> >> diff --git a/drivers/thermal/thermal_helpers.c
> >> b/drivers/thermal/thermal_helpers.c index 3edd047e144f..0d0da6670267
> >> 100644
> >> --- a/drivers/thermal/thermal_helpers.c
> >> +++ b/drivers/thermal/thermal_helpers.c
> >> @@ -199,7 +199,7 @@ void __thermal_cdev_update(struct
> >> thermal_cooling_device *cdev)>> 
> >>   	/* Make sure cdev enters the deepest cooling state */
> >>   	list_for_each_entry(instance, &cdev->thermal_instances, cdev_node) 
{
> >> 
> >> -		dev_dbg(&cdev->device, "zone%d->target=%lu\n",
> >> +		dev_dbg(&cdev->device, "zone%d->target=%ld\n",
> >> 
> >>   			instance->tz->id, instance->target);
> >>   		
> >>   		if (instance->target == THERMAL_NO_TARGET)
> >>   		
> >>   			continue;
> >
> >Actually you pointed out something fuzzy in the target values.
> >
> >The unsigned long type for the target and THERMAL_NO_TARGET are not
> >compatible.
> >
> >It would be much simpler to have THERMAL_NO_TARGET = 0 which
> >semantically makes more sense than a negative value.

Is it identical? Apparently target value is used differently in each governor. 
At least for gov_bang_bang 'THERMAL_NO_TARGET = 0' is no difference. Im not so 
sure about gov_step_wise.

> The compare of unsigned long and negative int is bad idea.

Well, THERMAL_NO_TARGET actually is an unsigned long (-1UL), so the comparison 
is unsigned long to unsigned long, so it should not be an issue.
But this implies that printing the target as unsigned int, results in a huge 
number, not immediately recognizable as -1, which I tried to address here.

> But there is serious problem introduced by "thermal: core: Add notifications
> call in the framework" patch. When system resumes from mem suspend first
> time (this happen only on 1st resume), the thermal notification is sent to
> drivers with value of 0 (meaning system is no longer hot). This is due to
> the fact target is init to 0 and when there is only 1 cooling device; it
> gets out of the loop (due to continue;) with target still set to 0 and
> calls thermal_cdev_set_cur_state(cdev, target). From there
> thermal_notify_cdev_state_update is called with argument of 0 which
> notifies drivers with value of 0.
> 
> May be "unsigned long target" should be initialized to THERMAL_NO_TARGET
> instead of 0.
> 
> [   29.107048] OOM killer enabled.
> [   29.110225] Restarting tasks ... done.
> [   29.124816] thermal cooling_device0: zone0->target=18446744073709551615
> [   29.138388] GPU0: Hot alarm is canceled.
> [   29.145399] thermal cooling_device0: set to state 0
> [   29.198954] PM: suspend exit

Is it legal to pass THERMAL_NO_TARGET to .set_cur_state()? At least pwm-fan 
will return -EINVAL in this case.

Alexander


