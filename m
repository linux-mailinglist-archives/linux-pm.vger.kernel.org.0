Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5D2D7C5690
	for <lists+linux-pm@lfdr.de>; Wed, 11 Oct 2023 16:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346934AbjJKOR0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Oct 2023 10:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346919AbjJKORZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Oct 2023 10:17:25 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9018A9E
        for <linux-pm@vger.kernel.org>; Wed, 11 Oct 2023 07:17:23 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 17DDE106F;
        Wed, 11 Oct 2023 07:18:04 -0700 (PDT)
Received: from bogus (unknown [10.57.93.106])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4E6703F762;
        Wed, 11 Oct 2023 07:17:22 -0700 (PDT)
Date:   Wed, 11 Oct 2023 15:15:51 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Peng Fan <peng.fan@nxp.com>, Sudeep Holla <sudeep.holla@arm.com>,
        "cristian.marussi@arm.com" <cristian.marussi@arm.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>,
        Glen G Wienecke <glen.wienecke@nxp.com>
Subject: Re: Question regarding scmi_perf_domain.c
Message-ID: <20231011141551.exqxkmt3xsl5fyjh@bogus>
References: <20231010105503.jwrmjahuvcjgwtk5@bogus>
 <CAPDyKFqEpnKeF7Yuvv_a+=Kqs=pNU_kM59EqWdpCniHrY_373A@mail.gmail.com>
 <DU0PR04MB941755466872E84217378F6388CDA@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <20231010130054.ieylxocuapugajif@bogus>
 <DU0PR04MB94177FFEAA62AC27839D826F88CDA@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <20231010133059.57rs52qedrc5mxfr@bogus>
 <DU0PR04MB9417D01218CA4803D00545A788CDA@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <20231010145137.fyxjlsj5qq3elq7l@bogus>
 <DU0PR04MB9417233F914A061FB0A23B3088CCA@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <CAPDyKFo32GQdgMWJ_rkb88mcdc+0jYubWiCapf99Zg9JTnNnPw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFo32GQdgMWJ_rkb88mcdc+0jYubWiCapf99Zg9JTnNnPw@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Oct 11, 2023 at 11:26:54AM +0200, Ulf Hansson wrote:

[..]

> Not sure exactly what you are referring to when saying that "automatic
> power domain on is broken". Genpd power-on the PM domain for a device
> that gets attached to it, if the device has only a single PM domain.
> This is the legacy behaviour.
> 
> When we added support for multiple PM domains per device, we decided
> to *not* power-on the PM domain, if the device that gets attached has
> multiple PM domains. This behaviour was chosen deliberately, to allow
> consumer drivers to decide themselves instead. Is there a problem with
> this you think?
> 

Just my understanding. Since the second PM domain added now is for perf
and is not strictly power domain, Peng's concern is switching to this
binding will make the platform loose this automatic genpd power-on
feature.

-- 
Regards,
Sudeep
