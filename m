Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51A9FEBDA6
	for <lists+linux-pm@lfdr.de>; Fri,  1 Nov 2019 07:10:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbfKAGKK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 Nov 2019 02:10:10 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:21686 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726457AbfKAGKK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 Nov 2019 02:10:10 -0400
X-UUID: 90a92d519a89414a9fdd9345d3ad74ab-20191101
X-UUID: 90a92d519a89414a9fdd9345d3ad74ab-20191101
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw02.mediatek.com
        (envelope-from <roger.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 557455374; Fri, 01 Nov 2019 14:10:04 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 1 Nov 2019 14:09:57 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 1 Nov 2019 14:09:57 +0800
Message-ID: <1572588602.6939.1.camel@mtksdaap41>
Subject: Re: [PATCH v5 3/3] PM / AVS: SVS: Introduce SVS engine
From:   Roger Lu <roger.lu@mediatek.com>
To:     Pi-Hsun Shih <pihsun@chromium.org>
CC:     Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Boichat <drinkcat@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Fan Chen" <fan.chen@mediatek.com>,
        HenryC Chen <HenryC.Chen@mediatek.com>, <yt.lee@mediatek.com>,
        Angus Lin <Angus.Lin@mediatek.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Nishanth Menon" <nm@ti.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        "open list" <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>
Date:   Fri, 1 Nov 2019 14:10:02 +0800
In-Reply-To: <CANdKZ0dAWWy7QMMZhNHAha5ZpcBo1GHebPc5_FRu5gvBc569QA@mail.gmail.com>
References: <20190906100514.30803-1-roger.lu@mediatek.com>
         <20190906100514.30803-4-roger.lu@mediatek.com>
         <CANdKZ0dAWWy7QMMZhNHAha5ZpcBo1GHebPc5_FRu5gvBc569QA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-SNTS-SMTP: 37EE6EFD37277920D5707B79253F0016321E83FB9A72C31F0E381067B1C135692000:8
X-MTK:  N
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Dear Pi-Hsun,

Thanks for reminding me. I'll add dev_pm_opp_put(opp) in the next
patchset.

On Mon, 2019-10-21 at 15:51 +0800, Pi-Hsun Shih wrote:
> Hi Roger,
> 
> On Fri, Sep 6, 2019 at 6:06 PM Roger Lu <roger.lu@mediatek.com> wrote:
> > ...
> > +static int svs_resource_setup(struct mtk_svs *svs)
> > ...
> > +               for (i = 0, freq = (u32)-1; i < svsb->opp_count; i++, freq--) {
> > +                       opp = dev_pm_opp_find_freq_floor(svsb->dev, &freq);
> > +                       if (IS_ERR(opp)) {
> > +                               pr_err("%s: error opp entry!!, err = %ld\n",
> > +                                      svsb->name, PTR_ERR(opp));
> > +                               return PTR_ERR(opp);
> > +                       }
> > +
> > +                       svsb->opp_freqs[i] = freq;
> > +                       svsb->opp_volts[i] = dev_pm_opp_get_voltage(opp);
> > +                       svsb->freqs_pct[i] = percent(svsb->opp_freqs[i],
> > +                                                    svsb->freq_base) & 0xff;
> 
> Should have dev_pm_opp_put(opp); here.
Sure. Thanks.

> 
> > +               }
> > +       }
> > +
> > +       return 0;
> > +}
> > ...
> > +static int svs_status_proc_show(struct seq_file *m, void *v)
> > ...
> > +       for (i = 0, freq = (u32)-1; i < svsb->opp_count; i++, freq--) {
> > +               opp = dev_pm_opp_find_freq_floor(svsb->dev, &freq);
> > +               if (IS_ERR(opp)) {
> > +                       seq_printf(m, "%s: error opp entry!!, err = %ld\n",
> > +                                  svsb->name, PTR_ERR(opp));
> > +                       return PTR_ERR(opp);
> > +               }
> > +
> > +               seq_printf(m, "opp_freqs[%02u]: %lu, volts[%02u]: %lu, ",
> > +                          i, freq, i, dev_pm_opp_get_voltage(opp));
> > +               seq_printf(m, "svsb_volts[%02u]: 0x%x, freqs_pct[%02u]: %u\n",
> > +                          i, svsb->volts[i], i, svsb->freqs_pct[i]);
> 
> Same here.
Sure. Thanks.

> 
> > +       }
> > +
> > +       return 0;
> > +}
> > ...


