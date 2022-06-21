Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27562552CF8
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jun 2022 10:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236616AbiFUI1I (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 21 Jun 2022 04:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348243AbiFUI0x (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 Jun 2022 04:26:53 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9760620F6E
        for <linux-pm@vger.kernel.org>; Tue, 21 Jun 2022 01:26:41 -0700 (PDT)
X-UUID: ad798b01dc17493091eaec5238e0e9bd-20220621
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.6,REQID:3deda79b-99fe-49e1-af61-c963d26803cd,OB:10,L
        OB:0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:51,FILE:0,RULE:Release_Ham,AC
        TION:release,TS:56
X-CID-INFO: VERSION:1.1.6,REQID:3deda79b-99fe-49e1-af61-c963d26803cd,OB:10,LOB
        :0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:51,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:56
X-CID-META: VersionHash:b14ad71,CLOUDID:57c40d38-5e4b-44d7-80b2-bb618cb09d29,C
        OID:2c42c87310f4,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: ad798b01dc17493091eaec5238e0e9bd-20220621
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <johnson.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1387115645; Tue, 21 Jun 2022 16:26:36 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Tue, 21 Jun 2022 16:26:35 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Tue, 21 Jun 2022 16:26:35 +0800
Message-ID: <1b58a827f2b7a4798091c785a845465ed18e331a.camel@mediatek.com>
Subject: Re: [PATCH] PM / devfreq: mediatek: Fix unnecessary check of drvdata
From:   Johnson Wang <johnson.wang@mediatek.com>
To:     <matthias.bgg@kernel.org>, <dan.carpenter@oracle.com>
CC:     <linux-pm@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <angelogioacchino.delregno@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Date:   Tue, 21 Jun 2022 16:26:35 +0800
In-Reply-To: <20220620154347.14756-1-matthias.bgg@kernel.org>
References: <20220620154347.14756-1-matthias.bgg@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 2022-06-20 at 17:43 +0200, matthias.bgg@kernel.org wrote:
> From: Matthias Brugger <matthias.bgg@gmail.com>
> 
> Probe function will error out if drvdata 'mtk_ccifreq_drv' is null.
> So when mtk_ccifreq_target get's called, the drv pointer will never
> be
> NULL. This fixes a static checker warning.
> 
> Cc: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
> ---
>  drivers/devfreq/mtk-cci-devfreq.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/devfreq/mtk-cci-devfreq.c b/drivers/devfreq/mtk-
> cci-devfreq.c
> index 71abb3fbd042..ad05b152071d 100644
> --- a/drivers/devfreq/mtk-cci-devfreq.c
> +++ b/drivers/devfreq/mtk-cci-devfreq.c
> @@ -132,9 +132,6 @@ static int mtk_ccifreq_target(struct device *dev,
> unsigned long *freq,
>  	unsigned long opp_rate;
>  	int voltage, pre_voltage, inter_voltage, target_voltage, ret;
>  
> -	if (!drv)
> -		return -EINVAL;
> -
>  	if (drv->pre_freq == *freq)
>  		return 0;
>  

Hi Matthias,

Thank you for improving this driver.
I've tested this patch on the MT8183 and MT8186 platforms.

Tested-by: Johnson Wang <johnson.wang@mediatek.com>

BRs,
Johnson Wang

