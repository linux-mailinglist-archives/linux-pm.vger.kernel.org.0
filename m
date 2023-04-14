Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 092B46E2887
	for <lists+linux-pm@lfdr.de>; Fri, 14 Apr 2023 18:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbjDNQlj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 Apr 2023 12:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjDNQli (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Apr 2023 12:41:38 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE6BE45
        for <linux-pm@vger.kernel.org>; Fri, 14 Apr 2023 09:41:37 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id ca18e2360f4ac-7606d7cc9bdso6650339f.1
        for <linux-pm@vger.kernel.org>; Fri, 14 Apr 2023 09:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1681490496; x=1684082496;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1KMGf0SzwXvFf5sUG5Xm6eIyrT5N7p2Kjq8aD/XELRY=;
        b=Ku10yB4Ku0lbno78QD/FX+Uj6db8NV/QLSRmVXjeViXwr4SgIBI6cZNuMPl5aQsAJN
         LAsULvH/+/tj65QDNJja0LoC4eES1CHJPe9B2MDQjsPtkIjJPub5QcHP0xrDwxuN2Gkd
         Iy+Vhn2qWPD54qDn6HDeUPVTc/QAaYw9I1RZA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681490496; x=1684082496;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1KMGf0SzwXvFf5sUG5Xm6eIyrT5N7p2Kjq8aD/XELRY=;
        b=ZHmpgkPGn4yaEXr9vm8L1qPj5O2MvhVuRVusEbjRQM+Ksv5g1lOBWdPNVDe7v5UWVX
         +4NIcbDQKtoApgaNB2cahMNMAG+IvBulV/9GD4oIOo+xpl5P8ZftPxs44HZcigM1YmFq
         NJ/H9ir8uhQA/VaicDubTKxsIuWXlxgi5/dtYxISWXDjb8E9ny4ri0rhfiBwZejBHDWC
         kZPDv+bQ4frkSxjZjuZxVsXChDkgwfFEecnH/UlT92Pu0yqPgLLh01iAg2hj+9lFp1q5
         Ilgy3spw1N3y5RjFxIrpGogFliJTHbmhak8NkhVnWPMll5QKazpb7bvMiQiDG7cNJPAW
         NUAg==
X-Gm-Message-State: AAQBX9fkNYVM8OjTTKqFwxAbffxsqALIV6zqGJIcUIcX2pGr1kuisgbZ
        lO5pMChumHKdcMFzG6UWGZs4vE3TsW8u8kAs8Io=
X-Google-Smtp-Source: AKy350YFoPwc0TzXcMOd6kW+eYPa3IaIbmv9ZNk6nEenRzBlPrOnRj9ZArc+SMmkbcZP0Vr1Bw5XBA==
X-Received: by 2002:a05:6602:2e83:b0:760:478f:e436 with SMTP id m3-20020a0566022e8300b00760478fe436mr1650922iow.2.1681490496504;
        Fri, 14 Apr 2023 09:41:36 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id k12-20020a056638140c00b0040894c572basm1311968jad.125.2023.04.14.09.41.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Apr 2023 09:41:35 -0700 (PDT)
Message-ID: <4c04ae6d-f8db-0a2d-0bd5-97c4ec828a59@linuxfoundation.org>
Date:   Fri, 14 Apr 2023 10:41:35 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2] cpupower:Fix resource leaks in sysfs_get_enabled()
To:     Hao Zeng <zenghao@kylinos.cn>
Cc:     trenn@suse.com, shuah@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230414030830.3829332-1-zenghao@kylinos.cn>
Content-Language: en-US
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230414030830.3829332-1-zenghao@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 4/13/23 21:08, Hao Zeng wrote:
> When the read return value is equal to 1, a file handle leak will occur
> 

Would like a bit more information on how the error paths are
redone, since memory leak isn't the only one that is fixed.

> Signed-off-by: Hao Zeng <zenghao@kylinos.cn>
> Suggested-by: Shuah Khan <skhan@linuxfoundation.org>
> ---
>   tools/power/cpupower/lib/powercap.c | 19 ++++++++++---------
>   1 file changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/power/cpupower/lib/powercap.c b/tools/power/cpupower/lib/powercap.c
> index 0ce29ee4c2e4..02ec5b0bff6b 100644
> --- a/tools/power/cpupower/lib/powercap.c
> +++ b/tools/power/cpupower/lib/powercap.c
> @@ -40,7 +40,7 @@ static int sysfs_get_enabled(char *path, int *mode)
>   {
>   	int fd;
>   	char yes_no;
> -
> +	int ret = 0;
>   	*mode = 0;
>   
>   	fd = open(path, O_RDONLY);
> @@ -48,17 +48,18 @@ static int sysfs_get_enabled(char *path, int *mode)
>   		return -1;
>   
>   	if (read(fd, &yes_no, 1) != 1) {
> -		close(fd);
> -		return -1;
> +		ret = -1;
> +		goto err;
>   	}
>   
> -	if (yes_no == '1') {
> -		*mode = 1;
> -		return 0;
> -	} else if (yes_no == '0') {
> -		return 0;
> +	if (yes_no != '1' || yes_no != '0') {
> +		ret = -1;
> +		goto err;
>   	}
> -	return -1;
> +	*mode = yes_no - '0';

I am not seeing much value in changing the above paths.
Leave them unchanged.

> +err:
> +	close(fd);
> +	return ret;
>   }
>   
>   int powercap_get_enabled(int *mode)

thanks,
-- Shuah
