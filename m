Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7568EB6FA
	for <lists+linux-pm@lfdr.de>; Thu, 31 Oct 2019 19:32:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729239AbfJaSch (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 31 Oct 2019 14:32:37 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36294 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729027AbfJaSch (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 31 Oct 2019 14:32:37 -0400
Received: by mail-pf1-f195.google.com with SMTP id v19so4953584pfm.3
        for <linux-pm@vger.kernel.org>; Thu, 31 Oct 2019 11:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UdKQ8XtlFhrxjB/2FoCKcqQ3brlpYi/JXe5PVcH9caE=;
        b=QxtJAsT2wVxqpRtct1RwB955RUPrhUvDLNXew5qo+8fOUP0xG8kcnNvRRcHMFdxylt
         ertJQZocQ4BpqrnjXqUNgPn9XUCo2ORwFbEpmwMAyYCTbXXxHiDYeiGnL4MlYSJPiMvn
         laGV6sCXpwK2xNKlRJoOIoSA7gcOMoxs/WOTGkp1SfTPUioy1Hn0t4qRRYmfKMd+iBVk
         Jz0/2DaUzSp46Jfql9Ce/pzb2rN1bbwddfIDEhMrDlT1AUcxutZGRs5q/MjE+T/kkBB9
         uvQXWJWJDzV0eW9Ai2gAiy5eun1SC9zB2vwDZRgC9Nu76i/1daaMejFaVfsDhdNsE53+
         y6pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UdKQ8XtlFhrxjB/2FoCKcqQ3brlpYi/JXe5PVcH9caE=;
        b=SXhwRlrQeAo+NCRVfcxNZaohiLlnJQVMTmK359KkBjV2J1Ss2s7zwKd9k0/J1w4BOC
         pehrD71wFDto00qATB1U/W4mSlfv8Xs2MdWXwjE3XxYxThNNtCKLGxfw4RY6nreQ298B
         0Gma9nsDfoSOua9Nw69GOjpwKIEuWvtB0S/j2uEqITMf9K7FmoXFUbKXKFnMci9nlFJs
         62aBQ2JN8z1zoidNtGRmdbZNdGE5kThyunmZj7vWpVclJW9hG4uPMQ3anzo5WTarm5Cm
         7Vq2KMCMrpTr1e27LxRcRjq0/wbhlOSrAQR9Go8WV4l+6x6amcAeY7nLcBFbKZ/qCuBd
         kQfg==
X-Gm-Message-State: APjAAAXLivmKzgoTJkghYIBSIfhaClk6lrHr+5EelU6kE9NFlyOIoaWx
        ia9BruHFb1U5tmw7QmGBsXsfeg==
X-Google-Smtp-Source: APXvYqwDLNRAdPzBepswCinv15VBKdWOO7bk/v7vyE7xYWILhRKYqsMcJhtBXxVVyrs9SgJbyM4Fyw==
X-Received: by 2002:a65:66c9:: with SMTP id c9mr7961884pgw.341.1572546756719;
        Thu, 31 Oct 2019 11:32:36 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id v19sm4071780pff.46.2019.10.31.11.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2019 11:32:35 -0700 (PDT)
Date:   Thu, 31 Oct 2019 11:32:33 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Jordan Crouse <jcrouse@codeaurora.org>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v1 2/2] interconnect: Remove unused module exit code from
 core
Message-ID: <20191031183233.GM1929@tuxbook-pro>
References: <1572546532-19248-1-git-send-email-jcrouse@codeaurora.org>
 <1572546532-19248-3-git-send-email-jcrouse@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1572546532-19248-3-git-send-email-jcrouse@codeaurora.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu 31 Oct 11:28 PDT 2019, Jordan Crouse wrote:

> The interconnect core is currently always built in:
> 
>  menuconfig INTERCONNECT
> 	bool "On-Chip Interconnect management support"
> 
> So remove the module_exit function and symbolically rename module_init
> to device_initcall to drive home the point.
> 
> Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> ---
> 
>  drivers/interconnect/core.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
> index c498796..61aba50 100644
> --- a/drivers/interconnect/core.c
> +++ b/drivers/interconnect/core.c
> @@ -805,12 +805,7 @@ static int __init icc_init(void)
>  	return 0;
>  }
>  
> -static void __exit icc_exit(void)
> -{
> -	debugfs_remove_recursive(icc_debugfs_dir);
> -}
> -module_init(icc_init);
> -module_exit(icc_exit);
> +device_initcall(icc_init);
>  
>  MODULE_AUTHOR("Georgi Djakov <georgi.djakov@linaro.org>");
>  MODULE_DESCRIPTION("Interconnect Driver Core");
> -- 
> 2.7.4
> 
