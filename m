Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06AE57A2460
	for <lists+linux-pm@lfdr.de>; Fri, 15 Sep 2023 19:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234696AbjIORMg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Fri, 15 Sep 2023 13:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235770AbjIORMZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Sep 2023 13:12:25 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A2012717;
        Fri, 15 Sep 2023 10:12:15 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RnLM908Zwz6K5wf;
        Sat, 16 Sep 2023 01:11:33 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (7.191.163.213) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 15 Sep 2023 18:12:12 +0100
Received: from lhrpeml500001.china.huawei.com ([7.191.163.213]) by
 lhrpeml500001.china.huawei.com ([7.191.163.213]) with mapi id 15.01.2507.031;
 Fri, 15 Sep 2023 18:12:12 +0100
From:   Salil Mehta <salil.mehta@huawei.com>
To:     Jonathan Cameron <jonathan.cameron@huawei.com>
CC:     Russell King <linux@armlinux.org.uk>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        James Morse <james.morse@arm.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "loongarch@lists.linux.dev" <loongarch@lists.linux.dev>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
        "x86@kernel.org" <x86@kernel.org>,
        "Jean-Philippe Brucker" <jean-philippe@linaro.org>,
        "jianyong.wu@arm.com" <jianyong.wu@arm.com>,
        "justin.he@arm.com" <justin.he@arm.com>
Subject: RE: [RFC PATCH v2 27/35] ACPICA: Add new MADT GICC flags fields [code
 first?]
Thread-Topic: [RFC PATCH v2 27/35] ACPICA: Add new MADT GICC flags fields
 [code first?]
Thread-Index: AQHZ5mDqpYLh+nkhC0mj9mPBt3XEBLAZ5MMAgAB0lICAAAsFgIAAEfIQgADzSoCAABq9gIAAG4DQgAA3wICAACNmMP//+zYAgAArSrA=
Date:   Fri, 15 Sep 2023 17:12:12 +0000
Message-ID: <62c89f1c03f34f2796244ba83c08adbb@huawei.com>
References: <20230913163823.7880-1-james.morse@arm.com>
        <20230913163823.7880-28-james.morse@arm.com>
        <CAMj1kXHRAt7ecB9p_dm3MjDL5wZkAsVh30hMY2SV_XUe=bm6Vg@mail.gmail.com>
        <20230914155459.00002dba@Huawei.com>
        <CAMj1kXFquiLGCMow3iujHUU4GBZx2t9KfKy1R9iqjBFjY+acaA@mail.gmail.com>
        <f5d9beea95e149ab89364dcdb0f8bf69@huawei.com>
        <ZQQDJT6MOaIOPmq5@shell.armlinux.org.uk>
        <CAJZ5v0jUQ+4G5ArYAtu1gvYF4356CK_QVTO4oWn0ukwdOiZaHA@mail.gmail.com>
        <80e36ff513504a0382a1cbce83e42295@huawei.com>
        <ZQRfaYYwrYQEfICN@shell.armlinux.org.uk>
        <9e327ad1128045fa80eebf327abaa8f0@huawei.com>
 <20230915163238.000054c8@Huawei.com>
In-Reply-To: <20230915163238.000054c8@Huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.174.239]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Jonathan,

> From: Jonathan Cameron <jonathan.cameron@huawei.com>
> Sent: Friday, September 15, 2023 4:33 PM
> To: Salil Mehta <salil.mehta@huawei.com>
> Cc: Russell King <linux@armlinux.org.uk>; Rafael J. Wysocki
> <rafael@kernel.org>; Ard Biesheuvel <ardb@kernel.org>; James Morse
> <james.morse@arm.com>; linux-pm@vger.kernel.org; loongarch@lists.linux.dev;
> linux-acpi@vger.kernel.org; linux-arch@vger.kernel.org; linux-
> kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> riscv@lists.infradead.org; kvmarm@lists.linux.dev; x86@kernel.org; Jean-
> Philippe Brucker <jean-philippe@linaro.org>; jianyong.wu@arm.com;
> justin.he@arm.com
> Subject: Re: [RFC PATCH v2 27/35] ACPICA: Add new MADT GICC flags fields
> [code first?]
> 
> On Fri, 15 Sep 2023 16:17:21 +0100
> Salil Mehta <salil.mehta@huawei.com> wrote:
> 
> > Hi Russel,
> > Thanks for highlighting your concerns.
> >
> > > From: Russell King <linux@armlinux.org.uk>
> > > Sent: Friday, September 15, 2023 2:43 PM
> > > To: Salil Mehta <salil.mehta@huawei.com>
> > > Cc: Rafael J. Wysocki <rafael@kernel.org>; Ard Biesheuvel
> > > <ardb@kernel.org>; Jonathan Cameron <jonathan.cameron@huawei.com>; James
> > > Morse <james.morse@arm.com>; linux-pm@vger.kernel.org;
> > > loongarch@lists.linux.dev; linux-acpi@vger.kernel.org; linux-
> > > arch@vger.kernel.org; linux-kernel@vger.kernel.org; linux-arm-
> > > kernel@lists.infradead.org; linux-riscv@lists.infradead.org;
> > > kvmarm@lists.linux.dev; x86@kernel.org; Jean-Philippe Brucker <jean-
> > > philippe@linaro.org>; jianyong.wu@arm.com; justin.he@arm.com
> > > Subject: Re: [RFC PATCH v2 27/35] ACPICA: Add new MADT GICC flags fields
> > > [code first?]
> > >
> > > On Fri, Sep 15, 2023 at 09:34:46AM +0000, Salil Mehta wrote:
> > > > > > Note that the ACPI spec says enabled + online-capable isn't defined.
> > > > > >
> > > > > > "The information conveyed by this bit depends on the value of the
> > > > > > Enabled bit. If the Enabled bit is set, this bit is reserved and
> > > > > > must be zero."
> > > > > >
> > > > > > So, if x86 is doing something with the enabled && online-capable
> > > > > > state (other than ignoring the online-capable) then technically it
> > > > > > is doing something that the spec doesn't define
> > > > >
> > > > > And so it is wrong.
> > > >
> > > > Or maybe, specification has not been updated yet. code-first?
> > >
> > > What is the point in speculating. If you want to speculate about it,
> > > fine, but please don't use speculation as a reason that "oh we need
> > > to sort this out before we can merge the patches".
> >
> > [already replied in other thread but repeating it here]
> >
> > Sorry, I am not aware but I was suggesting this. Can we have this
> > done for ARM first because there is a legitimate use-case. This
> > can be done in parallel while other patches are getting reviewed.
> > It would be great if they get accepted even in the current form.
> >
> >
> > > This is precisely why engineers are bad at producing products. They
> > > like to continually tweak the design, and the design never gets out
> > > the door. You need someone who is a project manager to tell engineers
> > > when to stop. Without a project manager to do that, eventually the
> > > project fades into insignificance because it becomes no longer relevant
> > > or has its funding cut.
> > >
> > > Hotplug VCPU on aarch64 feels exactly like that - it seems to be an
> > > engineer project that is just going to for-ever rumble on and never
> > > actually see the light of day.
> >
> >
> > Sometimes things are not in single persons control. Yes, it is
> > frustrating, I do understand that.
> >
> >
> > > So please - stop speculating and lets get vCPU hotplug *actually*
> > > delivered and usable. Even if it's not 100% perfect.
> >
> > We need to decide what is the criteria of acceptability and it can
> > vary across organizations. It depends upon internal requirements.
> > The issues what I pointed are,
> >
> > 1. Legacy OS will not boot on latest platform with hotplug support.
> >    - Try running older windows on ARM platform with hotplug support.
> >      - older windows will only see boot cpu with online-capable bit.
> >      - Will windows use _OSC to check compatibility?
> >    - We have verified this with older Linux and it only shows 1 CPU.
> > 2. Hot(un)plug of cold-booted CPUs.
> >    - Its use-case is subjective. Maybe you can throw light on this.
> >
> > With current composition of bits both 1 & 2 cannot be supported
> > simultaneously.
> >
> > It is perfectly okay to live with them while clearly indicating
> > what we intend to support or are in process of supporting it.
> > But we do need an open discussion about how to proceed. This is
> > to avoid surprises later on.
> >
> > BTW, I am just trying to make every one aware of the problems.
> 
> Step 1 - just allow growing (and shrinking back to initial
> enabled cpus).  That is fine with current specification and legacy
> OS. We only assume CPUs that are hotplugged can later be removed.
> That covers most use cases.


Yes, we can do that for a moment (at least in qemu) and then
not allow unplugging vCPUs which were cold plugged or allow
it as a debugging feature but splash a warning.


> So what effectively what Russell said. Enable what we can with
> the specifications as they stand before getting distracted by
> modifying them (again).


Yes, agreed. Idea was to clearly highlight them. These can be
discussed as part of separate thread in parallel - absolutely!


Thanks
Salil.
