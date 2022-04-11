Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09D234FBC1A
	for <lists+linux-pm@lfdr.de>; Mon, 11 Apr 2022 14:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234971AbiDKMdx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Apr 2022 08:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234322AbiDKMdw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 Apr 2022 08:33:52 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7DF26ED;
        Mon, 11 Apr 2022 05:31:36 -0700 (PDT)
X-UUID: c9bd375bd5254f299a47637b00ef07f7-20220411
X-UUID: c9bd375bd5254f299a47637b00ef07f7-20220411
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1664485756; Mon, 11 Apr 2022 20:31:31 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Mon, 11 Apr 2022 20:31:31 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 11 Apr
 2022 20:31:30 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 11 Apr 2022 20:31:30 +0800
Message-ID: <bc6dd020a1cc3f00f5be2bf2929046b9116bbeef.camel@mediatek.com>
Subject: Re: [PATCH V2 13/15] cpufreq: mediatek: Link CCI device to CPU
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     Kevin Hilman <khilman@baylibre.com>, <rafael@kernel.org>,
        <viresh.kumar@linaro.org>, <robh+dt@kernel.org>,
        <krzk+dt@kernel.org>
CC:     <matthias.bgg@gmail.com>, <jia-wei.chang@mediatek.com>,
        <roger.lu@mediatek.com>, <hsinyi@google.com>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Mon, 11 Apr 2022 20:31:30 +0800
In-Reply-To: <7hfsmn5m9f.fsf@baylibre.com>
References: <20220408045908.21671-1-rex-bc.chen@mediatek.com>
         <20220408045908.21671-14-rex-bc.chen@mediatek.com>
         <7hfsmn5m9f.fsf@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 2022-04-08 at 13:54 -0700, Kevin Hilman wrote:
> Rex-BC Chen <rex-bc.chen@mediatek.com> writes:
> 
> > From: Jia-Wei Chang <jia-wei.chang@mediatek.com>
> > 
> > In some MediaTek SoCs, like MT8183, CPU and CCI share the same
> > power
> > supplies. Cpufreq needs to check if CCI devfreq exists and wait
> > until
> > CCI devfreq ready before scaling frequency.
> > 
> > - Add is_ccifreq_ready() to link CCI device to CPI, and CPU will
> > start
> >   DVFS when CCI is ready.
> > - Add platform data for MT8183.
> > 
> > Signed-off-by: Jia-Wei Chang <jia-wei.chang@mediatek.com>
> 
> The checks here are not enough, and will lead to unexpected behavior.
> IIUC, before doing DVFS, you're checking:
> 
> 1) if the "cci" DT node is present and
> 2) if the driver for that device is bound
> 
> If both those conditions are not met, you don't actually fail, you
> just
> silently do nothing in ->set_target().  As Angelo pointed out also,
> this
> is not a good idea, and will be rather confusing to users.
> 
> The same thing would happen if the cci DT node was present, but the
> CCI
> devfreq driver was disabled.  Silent failure would also be quite
> unexpected behavior.  Similarily, if the cci DT node is not present
> at
> all (like it is in current upstream DT), this CPUfreq driver will
> silently do nothing.  Not good.
> 
> So, this patch needs to handle several scenarios:
> 
> 1) CCI DT node not present
> 
> In this case, the driver should still operate normally.  With no CCI
> node, or driver there's no conflict.
> 
> 2) CCI DT present/enabled but not yet bound
> 
> In this case, you could return -EAGAIN as suggested by Angelo, or
> maybe
> better, it should do a deferred probe.
> 
> 3) CCI DT present, but driver disabled
> 
> This case is similar to (1), this driver should continue to work.
> 
> Kevin

Hello Kevin and Angelo,

In my review, if we do not get the link or the link status is not
correct between cci and cpufreq in target_index, I think it will never
established again for this link.
Because it's not checked in probe stage.

So I think we just need to deal with the issue without cci device, and
don't expect the link between cci and cpufreq will be connected again.

If I am wrong, please correct me.
Thanks.

BRs,
Rex

