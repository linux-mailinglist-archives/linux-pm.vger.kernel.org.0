Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84AC57BFD84
	for <lists+linux-pm@lfdr.de>; Tue, 10 Oct 2023 15:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232072AbjJJNbF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Oct 2023 09:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231897AbjJJNbF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Oct 2023 09:31:05 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9D09AB0
        for <linux-pm@vger.kernel.org>; Tue, 10 Oct 2023 06:31:03 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0D5941FB;
        Tue, 10 Oct 2023 06:31:44 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 53DA63F762;
        Tue, 10 Oct 2023 06:31:02 -0700 (PDT)
Date:   Tue, 10 Oct 2023 14:30:59 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "cristian.marussi@arm.com" <cristian.marussi@arm.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>,
        Glen G Wienecke <glen.wienecke@nxp.com>
Subject: Re: Question regarding scmi_perf_domain.c
Message-ID: <20231010133059.57rs52qedrc5mxfr@bogus>
References: <DU0PR04MB9417DE145496DC03579F50E488CDA@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <20231010105503.jwrmjahuvcjgwtk5@bogus>
 <CAPDyKFqEpnKeF7Yuvv_a+=Kqs=pNU_kM59EqWdpCniHrY_373A@mail.gmail.com>
 <DU0PR04MB941755466872E84217378F6388CDA@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <20231010130054.ieylxocuapugajif@bogus>
 <DU0PR04MB94177FFEAA62AC27839D826F88CDA@DU0PR04MB9417.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DU0PR04MB94177FFEAA62AC27839D826F88CDA@DU0PR04MB9417.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Oct 10, 2023 at 01:15:26PM +0000, Peng Fan wrote:
> 
> Thanks for the detailed explanation, so power-domains property could be
> used both for power domain or performance domain. But if one
> device has both power domain and performance domain. Only power-domain
> property is not enough. I may understand wrong, let me look into the code.
> 

I haven't tried this but something I could come up quick wit Juno DTS
as reference:

We can change something like this:

      scmi_dvfs: protocol@13 {
              reg = <0x13>;
-             #clock-cells = <1>;
+             #power-domain-cells = <1>;
              mbox-names = "tx", "rx";
              mboxes = <&mailbox 1 0 &mailbox 1 1>;
              shmem = <&cpu_scp_hpri0 &cpu_scp_hpri1>;
      };

And then in the consumer node(taking GPU as it has both perf and power
domains). The CPUs are simpler as don't have explicit power domains, some
Qcom platforms do use that. Anyways I would change GPU node like this.
Hope this clarifies things for you.

 &gpu {
-       clocks = <&scmi_dvfs 2>;
-       power-domains = <&scmi_devpd 9>;
+       power-domains = <&scmi_dvfs 2 &scmi_devpd 9>;
+       power-domain-names = "perf", "power";
        status = "disabled";
 };

-- 
Regards,
Sudeep
