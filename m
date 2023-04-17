Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCB076E53A9
	for <lists+linux-pm@lfdr.de>; Mon, 17 Apr 2023 23:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbjDQVJm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 17 Apr 2023 17:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjDQVJl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 Apr 2023 17:09:41 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 437794EDE
        for <linux-pm@vger.kernel.org>; Mon, 17 Apr 2023 14:09:15 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id e9e14a558f8ab-32ae537c23fso269895ab.0
        for <linux-pm@vger.kernel.org>; Mon, 17 Apr 2023 14:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1681765754; x=1684357754;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wVXmhj3TGHHFs7svj8Ip00zxJ88Teb4vtWufX4YraHw=;
        b=PpgbovI364VkFQG3FXe8NZ2ByLY1ELlrpBA+aSUsnzH+QkDZN22exc1BM7ZtfTQi7j
         5LY9jvHNhfac3GKLgBNVI/qZvAH3IPrjwqRJeR/M0vwKgDYQvXHwqB3NA6BqaqQmVvfd
         s5fYrq5IROsG7zpA8jFPebxRrKTNDneSWPRUg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681765754; x=1684357754;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wVXmhj3TGHHFs7svj8Ip00zxJ88Teb4vtWufX4YraHw=;
        b=PdEKkiH1DltIhex/AnVQzZ7WHzB+g/Vl3cA5Ch8Rzb5I5nPMFHA8W+Zt5kmR2rfFca
         GnKx6xgNhVYYkVyQD0CJdOv4N0u8T8tzxkd2kW3EhB6EuYD4/VPEgNgxiO2b6BM1M05r
         37YhPLky67wQHU7/PuMBUjNb+ZyzTDfLgO4JoJCWtof9JNOInZ/lpj9Lsns/6I5kzM3j
         9WGITRdfTZPatReUC0h15Eo1mNtD1spdr7oXFy/rNNdUkzch3Pnql+K+fjPResLCuoci
         JygbInUz/SCHkhU0lqLg13H5d5XmirB4dA0GmnYPH/XAobGJnKIvGwjY4nxD/D4uHdt6
         HFtA==
X-Gm-Message-State: AAQBX9f8gnX1ZrNgDrdqY5Ak1gv0QXGue3JXNCV+K/mOS/zApSBeADCp
        WlRvPiTdXdOwYT8omoTdxB4ILA==
X-Google-Smtp-Source: AKy350biNY2JexbixxhrTYvQmzQqcnccL8xidRuISwhdvxL633H52V3hS4b3cG9nOnALT0AS1oYMQA==
X-Received: by 2002:a6b:b2d1:0:b0:763:55ab:de with SMTP id b200-20020a6bb2d1000000b0076355ab00demr1784819iof.1.1681765754481;
        Mon, 17 Apr 2023 14:09:14 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id p71-20020a02294a000000b0040f6f565d5dsm3309058jap.97.2023.04.17.14.09.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Apr 2023 14:09:13 -0700 (PDT)
Message-ID: <4eaae372-c312-6a77-f57f-dffc5f9aff02@linuxfoundation.org>
Date:   Mon, 17 Apr 2023 15:09:12 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3] cpupower:Fix resource leaks in sysfs_get_enabled()
Content-Language: en-US
To:     Hao Zeng <zenghao@kylinos.cn>
Cc:     trenn@suse.com, shuah@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230417075617.10487-1-zenghao@kylinos.cn>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230417075617.10487-1-zenghao@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 4/17/23 01:56, Hao Zeng wrote:
> The sysfs_get_enabled() opened file processor not closed,
> may cause a file handle leak.
> Putting error handling and resource cleanup code together
> makes the code easy to maintain and read.
> Removed the unnecessary else if branch from the original
> function, as it should return an error in cases other than '0'.
> 
> Signed-off-by: Hao Zeng <zenghao@kylinos.cn>
> Suggested-by: Shuah Khan <skhan@linuxfoundation.org>
> ---
>   tools/power/cpupower/lib/powercap.c | 22 ++++++++++++++--------
>   1 file changed, 14 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/power/cpupower/lib/powercap.c b/tools/power/cpupower/lib/powercap.c
> index 0ce29ee4c2e4..f0334a5f1acf 100644
> --- a/tools/power/cpupower/lib/powercap.c
> +++ b/tools/power/cpupower/lib/powercap.c
> @@ -40,25 +40,31 @@ static int sysfs_get_enabled(char *path, int *mode)
>   {
>   	int fd;
>   	char yes_no;
> +	int ret = 0;
>   
>   	*mode = 0;
>   
>   	fd = open(path, O_RDONLY);
> -	if (fd == -1)
> -		return -1;
> +	if (fd == -1) {
> +		ret = -1;
> +		goto out;
> +	}
>   
>   	if (read(fd, &yes_no, 1) != 1) {
> -		close(fd);
> -		return -1;
> +		ret = -1;
> +		goto out_close;
>   	}
>   
>   	if (yes_no == '1') {
>   		*mode = 1;
> -		return 0;

You can just add goto out_close here

> -	} else if (yes_no == '0') {
> -		return 0;

Keep == '0' check and add goto out_close here
> +	} else if (yes_no != '0') {

This can be just else with the above change.

> +		ret = -1;
> +		goto out_close;
>   	}
> -	return -1;
> +out_close:
> +	close(fd);
> +out:
> +	return ret;
>   }
>   
>   int powercap_get_enabled(int *mode)

thanks,
-- Shuah
