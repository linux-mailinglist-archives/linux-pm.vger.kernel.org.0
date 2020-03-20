Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C149D18C443
	for <lists+linux-pm@lfdr.de>; Fri, 20 Mar 2020 01:26:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgCTA0r (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Mar 2020 20:26:47 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:53618 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726827AbgCTA0r (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Mar 2020 20:26:47 -0400
Received: by mail-pj1-f66.google.com with SMTP id l36so1733725pjb.3
        for <linux-pm@vger.kernel.org>; Thu, 19 Mar 2020 17:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3CquBIknUh+wWij7pI3+EpiDVMbP4UE5jsk6gx0/y4s=;
        b=hIL879rr/L5dDRaQ5wFuNONmj14fKu2pOrCX0vcpiDCbDvQNW9D0XNhjQ812YIdJcl
         RFAA2QzyjMzwd4GerjIE1pcQTu7olaNibdMLiloj/OvyJs0dipLnlGDvPoaPJN07LF7F
         UpfdW8IHurtcqD7j9uunVEbKf7ka1RrgzG9H7++qEoXG0xofRl0tYeR5MQrxj+lu36Tf
         FZ+3j94YLwPxT4dCVO4muAjKHWNj39N/pscVLolXnbkt+oFHux9FDZk0ms266R6Y9OMV
         HjGdlLmJ9rmc+0SDvkMngNObYsKNqMJupbmJJiQ14SRp5BiLmdkQnqDHTRwXie3QkLi/
         ctIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3CquBIknUh+wWij7pI3+EpiDVMbP4UE5jsk6gx0/y4s=;
        b=ubZ9dRl0C2CALXKgxs06+iQq/R6DzJP5PGtUQLFyhynUQkOl9Fv0QhY679QoGLmoNz
         uWz7rO5vfYMDcgWMgwKfZFcdzY7ZviZGDHdWR2k6Yx/Wjz1fyTB1a24yEJlHXXsChXej
         fczea45GJjUblU6OXQzCvWzxDMTDGNnjWGbFfhPf33lS6qSKuoOop4d7b5alkS/NGjIr
         yX/9J4Z/ZOi4XmzjgdjFoSgZSLguYYrfgRf73e+5aHb6D4p4gr9Q9znrQuf2ytGBbL9a
         +DP75Efa9VP12hLa9YjaiiIm/+XJXhEm8mPNxxf+aK0zHTUF3oM/ee5UuJrSDQ/MqVtL
         +9Iw==
X-Gm-Message-State: ANhLgQ0yasioyJh8f+iunujseLKrYlO1DwwXfV21UHnXkuRtcdabX1c+
        Z+h150MOOBwFkxdLaVwscn/21Q==
X-Google-Smtp-Source: ADFU+vuvvlwjzHruspaJwITkonWxQdZ8Jw5QJj79hDHHYrQ1qrBu8aOfup37D42mz/zOwumlweKbcw==
X-Received: by 2002:a17:90a:3328:: with SMTP id m37mr6559226pjb.158.1584664004002;
        Thu, 19 Mar 2020 17:26:44 -0700 (PDT)
Received: from yoga (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id z125sm3629586pfz.187.2020.03.19.17.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 17:26:43 -0700 (PDT)
Date:   Thu, 19 Mar 2020 17:26:40 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Mike Tipton <mdtipton@codeaurora.org>
Cc:     georgi.djakov@linaro.org, agross@kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] interconnect: qcom: Fix uninitialized tcs_cmd::wait
Message-ID: <20200320002640.GC458947@yoga>
References: <20200319231021.18108-1-mdtipton@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200319231021.18108-1-mdtipton@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu 19 Mar 16:10 PDT 2020, Mike Tipton wrote:

> Currently, if tcs_cmd_gen is called with commit=false, then
> tcs_cmd::wait is left uninitialized. Since the tcs_cmd structures passed
> to this function aren't zero-initialized, then we're left with random
> wait values. This results in waiting for completion for more commands
> than is necessary, depending on what's on the stack at the time.
> 
> Removing the unnecessary if-condition fixes this, but add an explicit
> memset of the tcs_cmd structure as well to ensure predictable behavior
> if more tcs_cmd members are added in the future.
> 
> Fixes: 976daac4a1c5 ("interconnect: qcom: Consolidate interconnect RPMh support")
> Signed-off-by: Mike Tipton <mdtipton@codeaurora.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  drivers/interconnect/qcom/bcm-voter.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/interconnect/qcom/bcm-voter.c b/drivers/interconnect/qcom/bcm-voter.c
> index 2adfde8cdf19..2a11a63e7217 100644
> --- a/drivers/interconnect/qcom/bcm-voter.c
> +++ b/drivers/interconnect/qcom/bcm-voter.c
> @@ -96,6 +96,8 @@ static inline void tcs_cmd_gen(struct tcs_cmd *cmd, u64 vote_x, u64 vote_y,
>  	if (!cmd)
>  		return;
>  
> +	memset(cmd, 0, sizeof(*cmd));
> +
>  	if (vote_x == 0 && vote_y == 0)
>  		valid = false;
>  
> @@ -112,8 +114,7 @@ static inline void tcs_cmd_gen(struct tcs_cmd *cmd, u64 vote_x, u64 vote_y,
>  	 * Set the wait for completion flag on command that need to be completed
>  	 * before the next command.
>  	 */
> -	if (commit)
> -		cmd->wait = true;
> +	cmd->wait = commit;
>  }
>  
>  static void tcs_list_gen(struct list_head *bcm_list, int bucket,
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
