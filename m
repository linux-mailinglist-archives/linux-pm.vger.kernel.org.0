Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1FBEBBB8
	for <lists+linux-pm@lfdr.de>; Fri,  1 Nov 2019 02:31:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728245AbfKABbs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 31 Oct 2019 21:31:48 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:1099 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726540AbfKABbs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 31 Oct 2019 21:31:48 -0400
X-UUID: cceab31f80664af784cf9a81d1993b5e-20191101
X-UUID: cceab31f80664af784cf9a81d1993b5e-20191101
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <michael.kao@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 637181562; Fri, 01 Nov 2019 09:31:41 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 1 Nov 2019 09:31:35 +0800
Received: from [172.21.84.99] (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 1 Nov 2019 09:31:35 +0800
Message-ID: <1572571899.23942.3.camel@mtksdccf07>
Subject: Re: [RESEND PATCH] thermal: mediatek: add suspend/resume callback
From:   Michael Kao <michael.kao@mediatek.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
CC:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <hsinyi@chromium.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Louis Yu <louis.yu@mediatek.com>
Date:   Fri, 1 Nov 2019 09:31:39 +0800
In-Reply-To: <a0af0b72-dbc3-f284-34b7-fc94bbe349a4@linaro.org>
References: <1570613704-16609-1-git-send-email-michael.kao@mediatek.com>
         <a0af0b72-dbc3-f284-34b7-fc94bbe349a4@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-TM-SNTS-SMTP: FBAAD417DA093FF98E142D814BA2901E3D11B820C756EC48F85BA1DB00C7872C2000:8
X-MTK:  N
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, 2019-10-13 at 19:50 +0200, Daniel Lezcano wrote:
> On 09/10/2019 11:35, michael.kao@mediatek.com wrote:
> > From: Louis Yu <louis.yu@mediatek.com>
> > 
> > Add suspend/resume callback to disable/enable Mediatek thermal sensor
> > respectively. Since thermal power domain is off in suspend, thermal driver
> > needs re-initialization during resume.
> > 
> > Signed-off-by: Louis Yu <louis.yu@mediatek.com>
> > Signed-off-by: Michael Kao <michael.kao@mediatek.com>
> > ---
> > This patch series base on these patches [1][2].
> > 
> > [1]thermal: mediatek: mt8183: fix bank number settings (https://patchwork.kernel.org/patch/10938817/)
> > [2]thermal: mediatek: add another get_temp ops for thermal sensors (https://patchwork.kernel.org/patch/10938829/)
> 
> There is no new version with the comments take into account. Did I miss
> something?
> 
> The patch base on Kenrel 5.4. I resend to linux-pm. The original patch is at linux-mediatek only.


