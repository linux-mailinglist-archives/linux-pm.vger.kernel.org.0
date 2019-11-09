Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73068F5C40
	for <lists+linux-pm@lfdr.de>; Sat,  9 Nov 2019 01:18:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbfKIASg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 Nov 2019 19:18:36 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38732 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbfKIASg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 8 Nov 2019 19:18:36 -0500
Received: by mail-pf1-f196.google.com with SMTP id c13so6054238pfp.5
        for <linux-pm@vger.kernel.org>; Fri, 08 Nov 2019 16:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DLA227JSDThrqcDvBPe+ZMoWdBImgX3jObiKE0Xgwkw=;
        b=WWBipmWU1An5/dBytWXyJRDgQfp1e7XO7x+Zcu8uWWcIUTFbRsUuR/c1B8rdMdqJGk
         A2GvlLA6727EJEWOBmdFj+q1HIVPS57BehxiESPbFe6Fwn4mFkCBg4Ds3neXCNHNqdqt
         rpsZq1sw9EL01jxWESNQ0ViHR7/NeGKdcdc5ssS4DbQRmszYFlXYHGy5rZh/TUwjQGPQ
         MCNh00+E5/jUtFfdYCMO94th9hMr76d2zJRIjpVzBs6M5ubrDZgJ1vFsmjgZFb/u0pB/
         7NesZB7n+FmCBfiZpdGEeQ6ee1g2Zbj4VvBhrm+/TD6AhxJBiELMCUv3oOqEX0bbZbkd
         +OQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DLA227JSDThrqcDvBPe+ZMoWdBImgX3jObiKE0Xgwkw=;
        b=oz8xPEwk+gFw7jNDkPdEtzlXpgkpMB+KxICb2rw49CXp7GanToIYkHaVlejqjAHUH0
         q56bqpl2cD+9d8U4ASLY2mQZSNHr39K9oiAh8j/IdCgqjyuSEVVqjDp60XS/aIl3/a+q
         sjouEadeAyc7THOYW4wCLcwSKP+rRTf+oTa63fZt5NmzQVxEQtQ30m976/GjvuC4mHBR
         Go8fhW2C35PM+dWu+qa0+flDmXmAxLUr80UC+AWb5iNTeGYo2VBR9a9D7UNK2F3Pzmy0
         WOif+eixc8Y0FzSM9yhX5dqszrIm/ZzblO3Q+/wWfNGPv+AjitNhysvwQ8kM1HJUQJBp
         FufA==
X-Gm-Message-State: APjAAAXqiJyaIHnvG5BZ1C59ATdGvEcXdMciOGbt2GzAq1hx6+Zki7LF
        kqh/VTcw41Pp0P+ARJ3/ve9+/Q==
X-Google-Smtp-Source: APXvYqxtM4kW+4iOrGcT90S2hhiMLXIK3ueLusLgB5r8wnxQkOJWuHvgSLcX+HoRFUPSGI2nIbPUrQ==
X-Received: by 2002:a17:90a:e651:: with SMTP id ep17mr10060962pjb.74.1573258715438;
        Fri, 08 Nov 2019 16:18:35 -0800 (PST)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id p7sm7178343pjp.4.2019.11.08.16.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 16:18:34 -0800 (PST)
Date:   Fri, 8 Nov 2019 16:18:32 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Elliot Berman <eberman@codeaurora.org>
Cc:     sre@kernel.org, tkjos@google.com, gregkh@linuxfoundation.org,
        tsoni@codeaurora.org, rananta@codeaurora.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 1/2] reboot: Export reboot_mode
Message-ID: <20191109001832.GA5592@tuxbook-pro>
References: <1573256452-14838-1-git-send-email-eberman@codeaurora.org>
 <1573256452-14838-2-git-send-email-eberman@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1573256452-14838-2-git-send-email-eberman@codeaurora.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri 08 Nov 15:40 PST 2019, Elliot Berman wrote:

> Export reboot_mode to support kernel modules wishing to modify reboot_mode.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> Signed-off-by: Elliot Berman <eberman@codeaurora.org>
> ---
>  kernel/reboot.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/reboot.c b/kernel/reboot.c
> index c4d472b..b1fbc22 100644
> --- a/kernel/reboot.c
> +++ b/kernel/reboot.c
> @@ -32,7 +32,9 @@ EXPORT_SYMBOL(cad_pid);
>  #define DEFAULT_REBOOT_MODE
>  #endif
>  enum reboot_mode reboot_mode DEFAULT_REBOOT_MODE;
> +EXPORT_SYMBOL_GPL(reboot_mode);
>  enum reboot_mode panic_reboot_mode = REBOOT_UNDEFINED;
> +EXPORT_SYMBOL_GPL(panic_reboot_mode);
>  
>  /*
>   * This variable is used privately to keep track of whether or not
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
