Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2242C435D62
	for <lists+linux-pm@lfdr.de>; Thu, 21 Oct 2021 10:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbhJUIzU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Oct 2021 04:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbhJUIzT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Oct 2021 04:55:19 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE837C06161C;
        Thu, 21 Oct 2021 01:53:03 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id E4C991F44759
Subject: Re: [PATCH v16 4/7] soc: mediatek: SVS: add debug commands
To:     Roger Lu <roger.lu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Boichat <drinkcat@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Fan Chen <fan.chen@mediatek.com>,
        HenryC Chen <HenryC.Chen@mediatek.com>,
        YT Lee <yt.lee@mediatek.com>,
        Xiaoqing Liu <Xiaoqing.Liu@mediatek.com>,
        Charles Yang <Charles.Yang@mediatek.com>,
        Angus Lin <Angus.Lin@mediatek.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20210428065440.3704-1-roger.lu@mediatek.com>
 <20210428065440.3704-5-roger.lu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <715c9587-825f-6c22-96a2-273fb7f07bc3@collabora.com>
Date:   Thu, 21 Oct 2021 10:52:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210428065440.3704-5-roger.lu@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Il 28/04/21 08:54, Roger Lu ha scritto:
> The purpose of SVS is to help find the suitable voltages
> for DVFS. Therefore, if SVS bank voltages are concerned
> to be wrong, we can adjust SVS bank voltages by this patch.
> 
> Signed-off-by: Roger Lu <roger.lu@mediatek.com>
> ---
>   drivers/soc/mediatek/mtk-svs.c | 328 +++++++++++++++++++++++++++++++++
>   1 file changed, 328 insertions(+)
> 
> diff --git a/drivers/soc/mediatek/mtk-svs.c b/drivers/soc/mediatek/mtk-svs.c
> index 2d2153c92373..8794a2d87baa 100644
> --- a/drivers/soc/mediatek/mtk-svs.c
> +++ b/drivers/soc/mediatek/mtk-svs.c
> @@ -6,6 +6,7 @@
>   #include <linux/bits.h>
>   #include <linux/clk.h>
>   #include <linux/completion.h>
> +#include <linux/debugfs.h>
>   #include <linux/device.h>
>   #include <linux/init.h>
>   #include <linux/interrupt.h>
> @@ -24,6 +25,7 @@
>   #include <linux/pm_runtime.h>
>   #include <linux/regulator/consumer.h>
>   #include <linux/reset.h>
> +#include <linux/seq_file.h>
>   #include <linux/slab.h>
>   #include <linux/spinlock.h>
>   #include <linux/thermal.h>
> @@ -62,6 +64,39 @@
>   #define SVSB_INTSTS_COMPLETE		0x1
>   #define SVSB_INTSTS_CLEAN		0x00ffffff
>   
> +#define debug_fops_ro(name)						\
> +	static int svs_##name##_debug_open(struct inode *inode,		\
> +					   struct file *filp)		\
> +	{								\
> +		return single_open(filp, svs_##name##_debug_show,	\
> +				   inode->i_private);			\
> +	}								\
> +	static const struct file_operations svs_##name##_debug_fops = {	\
> +		.owner = THIS_MODULE,					\
> +		.open = svs_##name##_debug_open,			\
> +		.read = seq_read,					\
> +		.llseek = seq_lseek,					\
> +		.release = single_release,				\
> +	}
> +
> +#define debug_fops_rw(name)						\
> +	static int svs_##name##_debug_open(struct inode *inode,		\
> +					   struct file *filp)		\
> +	{								\
> +		return single_open(filp, svs_##name##_debug_show,	\
> +				   inode->i_private);			\
> +	}								\
> +	static const struct file_operations svs_##name##_debug_fops = {	\
> +		.owner = THIS_MODULE,					\
> +		.open = svs_##name##_debug_open,			\
> +		.read = seq_read,					\
> +		.write = svs_##name##_debug_write,			\
> +		.llseek = seq_lseek,					\
> +		.release = single_release,				\
> +	}
> +
> +#define svs_dentry(name)	{__stringify(name), &svs_##name##_debug_fops}
> +
>   static DEFINE_SPINLOCK(mtk_svs_lock);
>   
>   /*
> @@ -83,6 +118,7 @@ enum svsb_phase {
>   	SVSB_PHASE_INIT01,
>   	SVSB_PHASE_INIT02,
>   	SVSB_PHASE_MON,
> +	SVSB_PHASE_NUM,

I would move the addition of these last members in the previous (3/7) patch,
where you introduce the driver in the first place.

Also, I think that using _MAX instead would be better, as it is pretty
much a common practice. So, this would become SVSB_PHASE_MAX.

>   };
>   
>   enum svs_reg_index {
> @@ -140,6 +176,7 @@ enum svs_reg_index {
>   	SPARE2,
>   	SPARE3,
>   	THSLPEVEB,
> +	SVS_REG_NUM,

... and this would become SVS_REG_MAX

>   };
>   
>   static const u32 svs_regs_v2[] = {

Apart from that,

Acked-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

