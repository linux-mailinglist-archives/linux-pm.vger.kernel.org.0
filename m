Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6F2EBEE1
	for <lists+linux-pm@lfdr.de>; Fri,  1 Nov 2019 09:09:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730080AbfKAIJM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 Nov 2019 04:09:12 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:64131 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729975AbfKAIJM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 Nov 2019 04:09:12 -0400
X-UUID: 9d1bb3c0240a495ca1d94641288e2b60-20191101
X-UUID: 9d1bb3c0240a495ca1d94641288e2b60-20191101
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <roger.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 598440622; Fri, 01 Nov 2019 16:09:00 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 1 Nov 2019 16:08:54 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 1 Nov 2019 16:08:54 +0800
Message-ID: <1572595738.6939.7.camel@mtksdaap41>
Subject: Re: [v4, 6/8] PM / OPP: Support adjusting OPP voltages at runtime
From:   Roger Lu <roger.lu@mediatek.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
CC:     Andrew-sh Cheng =?UTF-8?Q?=28=E9=84=AD=E5=BC=8F=E5=8B=B3=29?= 
        <andrew-sh.cheng@mediatek.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        Fan Chen =?UTF-8?Q?=28=E9=99=B3=E5=87=A1=29?= 
        <fan.chen@mediatek.com>, Stephen Boyd <sboyd@codeaurora.org>
Date:   Fri, 1 Nov 2019 16:08:58 +0800
In-Reply-To: <20190819111836.5cu245xre6ky6xav@vireshk-i7>
References: <1565703113-31479-1-git-send-email-andrew-sh.cheng@mediatek.com>
         <1565703113-31479-7-git-send-email-andrew-sh.cheng@mediatek.com>
         <20190819111836.5cu245xre6ky6xav@vireshk-i7>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-SNTS-SMTP: DA0E43A199AF13C7A7A488606389C63F2A52057B18D158DDCD6B0E5FDE7197552000:8
X-MTK:  N
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Dear Viresh,

Sorry for the late reply.

On Mon, 2019-08-19 at 19:18 +0800, Viresh Kumar wrote:
> On 13-08-19, 21:31, Andrew-sh.Cheng wrote:
> > From: Stephen Boyd <sboyd@codeaurora.org>
> > 
> > On some SoCs the Adaptive Voltage Scaling (AVS) technique is
> > employed to optimize the operating voltage of a device. At a
> > given frequency, the hardware monitors dynamic factors and either
> > makes a suggestion for how much to adjust a voltage for the
> > current frequency, or it automatically adjusts the voltage
> > without software intervention. Add an API to the OPP library for
> > the former case, so that AVS type devices can update the voltages
> > for an OPP when the hardware determines the voltage should
> > change. The assumption is that drivers like CPUfreq or devfreq
> > will register for the OPP notifiers and adjust the voltage
> > according to suggestions that AVS makes.
> > 
> > This patch is devired from [1] submitted by Stephen.
> > [1] https://lore.kernel.org/patchwork/patch/599279/
> > 
> > Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> > Signed-off-by: Roger Lu <roger.lu@mediatek.com>
> > ---
> >  drivers/opp/core.c     | 63 ++++++++++++++++++++++++++++++++++++++++++++++++++
> >  include/linux/pm_opp.h | 11 +++++++++
> >  2 files changed, 74 insertions(+)
> > 
> > diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> > index c094d5d20fd7..407a07f29b12 100644
> > --- a/drivers/opp/core.c
> > +++ b/drivers/opp/core.c
> > @@ -2054,6 +2054,69 @@ static int _opp_set_availability(struct device *dev, unsigned long freq,
> >  }
> >  
> >  /**
> > + * dev_pm_opp_adjust_voltage() - helper to change the voltage of an OPP
> > + * @dev:		device for which we do this operation
> > + * @freq:		OPP frequency to adjust voltage of
> > + * @u_volt:		new OPP voltage
> > + *
> > + * Return: -EINVAL for bad pointers, -ENOMEM if no memory available for the
> > + * copy operation, returns 0 if no modifcation was done OR modification was
> > + * successful.
> > + */
> > +int dev_pm_opp_adjust_voltage(struct device *dev, unsigned long freq,
> > +			      unsigned long u_volt)
> 
> Can you please update this to take a triplet instead ? That is what we are
> storing in OPP core now a days.

I've studied opp/core.c and still don't know meaning of triplet here.
Could you give me more hints (reference API?) about how to take a
triplet instead? Thanks in advance.

