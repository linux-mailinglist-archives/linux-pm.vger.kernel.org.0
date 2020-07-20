Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A80B225C26
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jul 2020 11:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728328AbgGTJ5b (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 Jul 2020 05:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728310AbgGTJ5a (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Jul 2020 05:57:30 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD698C0619D2
        for <linux-pm@vger.kernel.org>; Mon, 20 Jul 2020 02:57:29 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id gc9so9973414pjb.2
        for <linux-pm@vger.kernel.org>; Mon, 20 Jul 2020 02:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6XyZ1vebKO6SQCUsj068hhsBNuOKRm7ZmD8BgAuoHaY=;
        b=NQBiu1cOCISh1k3U4y2l52I5TOrTbmZzL+gIeTHwlzmCjlDf3IZD/ASeQl0xonnttT
         BEBTV4O6+LnVxFo/P67buZg17mjeeDzQ6YW9F5upr2VTBMiQYdnb6LmiMrZPNLo2+AvX
         FsJAD3xO/Y1XACZxNmQn5zgKtsx0Eu+Q/07copNlruVNsS3eDO7l4BJy7FS/XMOlVJAH
         5Th+Fgrh0sVI/M+/7oxKgEHskmAki/NZIoebAOMDGHZHUq3J8eEwmT9bpNlf6LYbSdrz
         KlJie1QrAVSirzAarzo8Xi9oPUU18PND6e9uVj5H5NfTEeulHQWwkzA5hfrywQOqvzd0
         rptQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6XyZ1vebKO6SQCUsj068hhsBNuOKRm7ZmD8BgAuoHaY=;
        b=Lyw38ewH50QRrIjN7iW91mur1z80i3+ntUMPc/Jt46jKbxXn7Qar7oB8VuAD5l+mjM
         3XyWBsI0LFtAidHCCuR8ogcINNNlVtl5P9VXVcLwdHjMbY4GH17ggCr9ZhZxFkW2WNoS
         wvDrOB+YB+oQCzXYgG1TJzkvc2PzDmEYgNfqL2hGw9/Q84y/VdHuayH3d7u77WHVlCu5
         uOByKpqKmaCJdG297GnPTVX+3ux//QdW+2rZIMRbOjMG/Q55LgHdDKLVpZeQJRaXPbxm
         f3/MHPuMOYj963Kio0DZSVnY+G0lY+h4IUNTR+0t8UCUYOZhha+jEUG1r96TayQAFh2n
         iQ/w==
X-Gm-Message-State: AOAM530S6Md+uRlbC6sexu4st27ECJfD/fncYusZWJZXqYLD9apqaghv
        cFztskyu24ZCD2GLr8YsUbXvuQ==
X-Google-Smtp-Source: ABdhPJzkmZ+GQFeE1cVYyN6xa/AAWSvHNvngWQItcmxRGFYYYD7B/0wV++gqFg1j+Ya++WKQMwlFCA==
X-Received: by 2002:a17:90a:2367:: with SMTP id f94mr23548839pje.20.1595239049209;
        Mon, 20 Jul 2020 02:57:29 -0700 (PDT)
Received: from localhost ([223.179.133.67])
        by smtp.gmail.com with ESMTPSA id u20sm17765622pfk.91.2020.07.20.02.57.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 Jul 2020 02:57:28 -0700 (PDT)
Date:   Mon, 20 Jul 2020 15:27:17 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Andrew-sh.Cheng" <andrew-sh.cheng@mediatek.com>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com
Subject: Re: opp: Modify opp API, dev_pm_opp_get_freq(), find freq in opp,
 even it is disabled
Message-ID: <20200720095717.eer4pnh3y4stkems@vireshk-mac-ubuntu>
References: <1595235326-6333-1-git-send-email-andrew-sh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1595235326-6333-1-git-send-email-andrew-sh.cheng@mediatek.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 20-07-20, 16:55, Andrew-sh.Cheng wrote:
> From: "Andrew-sh.Cheng" <andrew-sh.cheng@mediatek.com>
> 
> Modify dev_pm_opp_get_freq() to return freqeuncy
> even this opp item is not available.
> So that we can get the information of disable opp items.
> 
> Signed-off-by: Andrew-sh.Cheng <andrew-sh.cheng@mediatek.com>
> ---
>  drivers/opp/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index eed42d6b2e6b..5213e0462382 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -118,7 +118,7 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_get_voltage);
>   */
>  unsigned long dev_pm_opp_get_freq(struct dev_pm_opp *opp)
>  {
> -	if (IS_ERR_OR_NULL(opp) || !opp->available) {
> +	if (IS_ERR_OR_NULL(opp)) {
>  		pr_err("%s: Invalid parameters\n", __func__);
>  		return 0;
>  	}

Applied. Thanks.

-- 
viresh
