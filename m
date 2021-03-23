Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB4D34620C
	for <lists+linux-pm@lfdr.de>; Tue, 23 Mar 2021 15:57:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232411AbhCWO4f (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Mar 2021 10:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232314AbhCWO42 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Mar 2021 10:56:28 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3E2BC061574;
        Tue, 23 Mar 2021 07:56:27 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id f10so4887236pgl.9;
        Tue, 23 Mar 2021 07:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uwOQAH48j/Wfcy8oW8OXRAHhpccSn9j5x5zOt8r384w=;
        b=Nf/ANJFOm6mPVaXPaO9jpFbN1aVvlWP7B2G2pfdptsXFZc6aqVvBCygQ3qAFclHz2J
         EPzdmlmcdXhsDbEStahk+u6ICPEkEXqrGkmmALHmJoKBfYLqRmfT5tUQ2PodbeUJAJBy
         fLtntIGMbliCPCelzoVVO/g5R9yVJxgBqQFYg2As/SauOrF3XG8ATv3fpfcM9BrAfQVM
         1E7vRspjDusY7WgBN1M2WfwoUvS0PYkMEzV1BeGF3lndGY4VAo7H8rDm9Q8k4f9XYLax
         h3efNlOzFYLKRb+ZcOuaSwovCsCHmjjZTaBn2mae4Yd76kXWwDkmOag2YGZRRYMmDwWS
         bw9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uwOQAH48j/Wfcy8oW8OXRAHhpccSn9j5x5zOt8r384w=;
        b=T1pj1yy0KG/rvFToe5h1rc3UuDpR2DNKrjgJ4Oj//NomCeqjmQ1T+lifidyvnU599F
         JdsxT6WxnDU+2vvo2vGVxw1ZcJ8gugMrJRd9RGxNw6XhhSd/7qNv/9c5AWPHv43bJZ3D
         JOWl62mrUinHyX+XqM52MfGV5doxZbO5xRiu+uqv0TnveYmxAIocdXWHwoy4FlQ2OUI8
         6bFDt7NQg0WWM/nAo5aOHgtj3dfqPnD9B+zQO56NAwDIwQi6YMjrby3lMwqsupNjw5Uu
         h+byyD9z8dXVytiANVrd4KI/7WOHV9OyOmnbl85UP0uBoKUN0h6wzfL57qezLrSYwl3+
         7NPw==
X-Gm-Message-State: AOAM533fYBcs4xzsqeIWUpOlFzPoehpaVTbQ8wSWx+KVwRIBl07grB79
        jCdqvLrJlboE012xNEukYsw=
X-Google-Smtp-Source: ABdhPJx8CJ0+96UXURRMTynP5GnV0047PXvR9xMpV9mvyVBQHSyjnZWeBboQqxP1H1XM4FN1vydUWg==
X-Received: by 2002:aa7:86d9:0:b029:1ff:275c:b67a with SMTP id h25-20020aa786d90000b02901ff275cb67amr5214321pfo.69.1616511387337;
        Tue, 23 Mar 2021 07:56:27 -0700 (PDT)
Received: from [172.30.1.19] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id x125sm7869258pfd.124.2021.03.23.07.56.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Mar 2021 07:56:26 -0700 (PDT)
Subject: Re: [PATCH V2 RESEND 2/4] PM / devfreq: Remove the invalid
 description for get_target_freq
To:     Dong Aisheng <aisheng.dong@nxp.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     dongas86@gmail.com, kernel@pengutronix.de, shawnguo@kernel.org,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, abel.vesa@nxp.com
References: <1616484011-26702-1-git-send-email-aisheng.dong@nxp.com>
 <1616484011-26702-3-git-send-email-aisheng.dong@nxp.com>
From:   Chanwoo Choi <cwchoi00@gmail.com>
Message-ID: <f7cc9eef-4fc9-ba33-06de-9414843ddf5b@gmail.com>
Date:   Tue, 23 Mar 2021 23:56:22 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <1616484011-26702-3-git-send-email-aisheng.dong@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 21. 3. 23. 오후 4:20, Dong Aisheng wrote:
> First of all, no_central_polling was removed since
> commit 7e6fdd4bad03 ("PM / devfreq: Core updates to support devices
> which can idle")
> Secondly, get_target_freq() is not only called only with update_devfreq()
> notified by OPP now, but also min/max freq qos notifier.
> 
> So remove this invalid description now to avoid confusing.
> 
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
>   Documentation/ABI/testing/sysfs-class-devfreq | 5 +----
>   drivers/devfreq/governor.h                    | 2 --
>   2 files changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-devfreq b/Documentation/ABI/testing/sysfs-class-devfreq
> index 386bc230a33d..5e6b74f30406 100644
> --- a/Documentation/ABI/testing/sysfs-class-devfreq
> +++ b/Documentation/ABI/testing/sysfs-class-devfreq
> @@ -97,10 +97,7 @@ Description:
>   		object. The values are represented in ms. If the value is
>   		less than 1 jiffy, it is considered to be 0, which means
>   		no polling. This value is meaningless if the governor is
> -		not polling; thus. If the governor is not using
> -		devfreq-provided central polling
> -		(/sys/class/devfreq/.../central_polling is 0), this value
> -		may be useless.
> +		not polling.
>   
>   		A list of governors that support the node:
>   		- simple_ondmenad
> diff --git a/drivers/devfreq/governor.h b/drivers/devfreq/governor.h
> index 244634465170..2d69a0ce6291 100644
> --- a/drivers/devfreq/governor.h
> +++ b/drivers/devfreq/governor.h
> @@ -57,8 +57,6 @@
>    *			Basically, get_target_freq will run
>    *			devfreq_dev_profile.get_dev_status() to get the
>    *			status of the device (load = busy_time / total_time).
> - *			If no_central_polling is set, this callback is called
> - *			only with update_devfreq() notified by OPP.
>    * @event_handler:      Callback for devfreq core framework to notify events
>    *                      to governors. Events include per device governor
>    *                      init and exit, opp changes out of devfreq, suspend
> 

Applied it. Thanks.

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi
