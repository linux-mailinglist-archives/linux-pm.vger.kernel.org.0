Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCD167CC8B7
	for <lists+linux-pm@lfdr.de>; Tue, 17 Oct 2023 18:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232849AbjJQQYN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 Oct 2023 12:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbjJQQYN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 17 Oct 2023 12:24:13 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3D64FF0
        for <linux-pm@vger.kernel.org>; Tue, 17 Oct 2023 09:24:11 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7BBB62F4;
        Tue, 17 Oct 2023 09:24:51 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AB2883F762;
        Tue, 17 Oct 2023 09:24:09 -0700 (PDT)
Date:   Tue, 17 Oct 2023 17:24:07 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "cristian.marussi@arm.com" <cristian.marussi@arm.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>,
        Glen G Wienecke <glen.wienecke@nxp.com>
Subject: Re: Question regarding scmi_perf_domain.c
Message-ID: <ZS61J7Zt2HD4ZI1u@bogus>
References: <DU0PR04MB9417D01218CA4803D00545A788CDA@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <20231010145137.fyxjlsj5qq3elq7l@bogus>
 <DU0PR04MB9417233F914A061FB0A23B3088CCA@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <CAPDyKFo32GQdgMWJ_rkb88mcdc+0jYubWiCapf99Zg9JTnNnPw@mail.gmail.com>
 <20231011141551.exqxkmt3xsl5fyjh@bogus>
 <CAPDyKFrWjAdujOr8JX5_JawaKqs0_MYUrsUN57XaB9q=darJ0w@mail.gmail.com>
 <CAPDyKFoJpnF_CezT6RySPpAwJY0+LO+RiSqqM=byTaRibKQPyg@mail.gmail.com>
 <DU0PR04MB9417BDFD8570B5406A62901788D6A@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <ZS6SUXQEknsHWJxz@bogus>
 <DU0PR04MB9417FE7E2D1861FF0B4E809F88D6A@DU0PR04MB9417.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DU0PR04MB9417FE7E2D1861FF0B4E809F88D6A@DU0PR04MB9417.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Oct 17, 2023 at 02:35:49PM +0000, Peng Fan wrote:
> > Subject: Re: Question regarding scmi_perf_domain.c
> >

[...]

> > What is the point in adding it ? You can always hack and test if you need.
> 
> I might misunderstand, I thought this was a formal solution.

Not really, it was a proposal which we are discussing the options here.

> > 
> > > >
> > > > Maybe a module parameter or Kconfig debug option could be used to
> > > > control this?
> > >
> > > Greg might not be happy for introducing module parameter, I guess.
> > >
> > 
> > True. But I don't see point in adding a Kconfig as it needs to be enabled with
> > single (distro) Image.


And figured out both module param and Kconfig are not good options.

> > 
> > > >
> > > > In this way an updated DTS with that adds a performance domain to a
> > > > consumer device node (which already has a power-domain), should
> > > > allow the consumer driver to continue to probe successfully.
> > > >
> > > > Peng, would this resolve your concern?
> > >
> > > Actually I am not sure. multiple PD is not a technical issue, it is
> > > just adding more changes to various device drivers, we have
> > > VPU/GPU/DISPLAY/NPU/ HSIO/CAMERA and etc.. so all the drivers need
> > > update, which is not welcomed by driver developers :)
> > 
> > Why ? Have you posted the patches ? Any discussions you can point to ?
> 
> I mean NXP internal.
>

OK at this point, I really don't care then. I was under the assumption
that we were talking everything upstream here. Downstream always has the
burden of constantly adapting to the upstream changes. This is not a
user ABI. I was pushing Ulf assuming something is needed upstream.

Sorry Ulf, I wasn't aware of this downstream driver business here, my bad.

So, if the genpd has changed the behaviour for multiple agents and has
decided not to support this case, then the drivers need to adapt. I don't
see a way out by working around in the SCMI driver as it may break some
other platforms and we haven't got a way to do it conditionally other
than module param which you have raised right concerns.

iAll I can say is downstream drivers need to adapt. Sorry I know it is
not what you want to hear but it is part and parcel for the downstream
code.

> > 
> > > I am still trying to enable multiple PD for saying MMC, and see how it
> > > works after adding performance domain and how device dvfs works in
> > > such case.
> > >
> > 
> > Interesting. So MMC domain is presented as perf domain rather than the
> > clock
> > + regulator ? Nice to see that abstraction being used.
> 
> MMC IP is inside a block(named mix) which contains several other IPs.
> Current scmi sever perf design only exports MIX level perf,  no regulator
> for now.
>

Thanks for the details.

-- 
Regards,
Sudeep
