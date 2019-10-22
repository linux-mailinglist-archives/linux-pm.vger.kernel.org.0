Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8759E041C
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2019 14:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388290AbfJVMqb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Oct 2019 08:46:31 -0400
Received: from mx01-fr.bfs.de ([193.174.231.67]:42016 "EHLO mx01-fr.bfs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728346AbfJVMqa (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 22 Oct 2019 08:46:30 -0400
Received: from mail-fr.bfs.de (mail-fr.bfs.de [10.177.18.200])
        by mx01-fr.bfs.de (Postfix) with ESMTPS id 44E982034F;
        Tue, 22 Oct 2019 14:46:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bfs.de; s=dkim201901;
        t=1571748383; h=from:from:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c+tRPTlzoCwnRYEOA07Gp6Y8Oc5IPsLLz9/TmlPkbj0=;
        b=smPhmzCBxR/W6RJDmEX4SMj1A/S87/Jw1gojCqHWa9Xix6yQ+Zr73ne0VqRrrKE7CVBJZA
        8JirHg+vpZQGKjaLgLrTs14enpO37M9qWxb4rP6531eXqcNTUPq/mWljOQrNp34ftdmfrM
        UT5eJM3G4uTcbjdm/9PhJ5LMp9bhxX+MhQmIWXkOZmejOitFlYu42pKO8ds7nUwyHtwRBC
        L0/BE57Fx/Gk0spa3VWah8RzrvfRCt/c2TElbHAwoNOa2bdWdummX3QoBJ9Qs8fZO6+Iht
        QgJ57yoZbTV9p+H7vKpMUCy6/p14VF3ALrjP912jAGj6X227RnO6Afm2u1l6Kg==
Received: from [134.92.181.33] (unknown [134.92.181.33])
        by mail-fr.bfs.de (Postfix) with ESMTPS id A3FDBBEEBD;
        Tue, 22 Oct 2019 14:46:22 +0200 (CEST)
Message-ID: <5DAEFA1D.8070508@bfs.de>
Date:   Tue, 22 Oct 2019 14:46:21 +0200
From:   walter harms <wharms@bfs.de>
Reply-To: wharms@bfs.de
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.1.16) Gecko/20101125 SUSE/3.0.11 Thunderbird/3.0.11
MIME-Version: 1.0
To:     Colin King <colin.king@canonical.com>
CC:     Amit Kucheria <amit.kucheria@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] drivers: thermal: tsens: fix potential integer
 overflow on multiply
References: <20191022114910.652-1-colin.king@canonical.com>
In-Reply-To: <20191022114910.652-1-colin.king@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.10
Authentication-Results: mx01-fr.bfs.de
X-Spamd-Result: default: False [-3.10 / 7.00];
         ARC_NA(0.00)[];
         HAS_REPLYTO(0.00)[wharms@bfs.de];
         BAYES_HAM(-3.00)[100.00%];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         MIME_GOOD(-0.10)[text/plain];
         REPLYTO_ADDR_EQ_FROM(0.00)[];
         DKIM_SIGNED(0.00)[];
         RCPT_COUNT_SEVEN(0.00)[11];
         NEURAL_HAM(-0.00)[-0.999,0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         MID_RHS_MATCH_FROM(0.00)[];
         RCVD_TLS_ALL(0.00)[]
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



Am 22.10.2019 13:49, schrieb Colin King:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently a multiply operation is being performed on two int values
> and the result is being assigned to a u64, presumably because the
> end result is expected to be probably larger than an int. However,
> because the multiply is an int multiply one can get overflow. Avoid
> the overflow by casting degc to a u64 to force a u64 multiply.
> 
> Addresses-Coverity: ("Unintentional integer overflow")
> Fixes: fbfe1a042cfd ("drivers: thermal: tsens: Add interrupt support")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/thermal/qcom/tsens-common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
> index 03bf1b8133ea..3d7855106ecd 100644
> --- a/drivers/thermal/qcom/tsens-common.c
> +++ b/drivers/thermal/qcom/tsens-common.c
> @@ -92,7 +92,7 @@ void compute_intercept_slope(struct tsens_priv *priv, u32 *p1,
>  
>  static inline u32 degc_to_code(int degc, const struct tsens_sensor *s)
>  {
> -	u64 code = (degc * s->slope + s->offset) / SLOPE_FACTOR;
> +	u64 code = ((u64)degc * s->slope + s->offset) / SLOPE_FACTOR;
>  
looks ok
just to offer an alternative to avoid the cast;
	u64 code = degc;

	code = code * s->slope + s->offset;
	code/=SLOPE_FACTOR;

ym2c
re,
wh


>  	pr_debug("%s: raw_code: 0x%llx, degc:%d\n", __func__, code, degc);
>  	return clamp_val(code, THRESHOLD_MIN_ADC_CODE, THRESHOLD_MAX_ADC_CODE);
