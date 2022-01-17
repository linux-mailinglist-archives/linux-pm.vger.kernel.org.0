Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8CD3490216
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jan 2022 07:41:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234801AbiAQGlr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 17 Jan 2022 01:41:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234799AbiAQGlr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 Jan 2022 01:41:47 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A16EC06161C
        for <linux-pm@vger.kernel.org>; Sun, 16 Jan 2022 22:41:47 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id 78so9378092pfu.10
        for <linux-pm@vger.kernel.org>; Sun, 16 Jan 2022 22:41:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=81bQSQb3wEEPINMq19rfFYIhQtFYQQaxVg6e3I6g4Z8=;
        b=zRlJ7/jj2U4qgugcmf+lCbQLOC/npaAeyYwnwxnSYfnoqT9MjGZJn7+/Sah0MGNRo9
         k9n0BS1t+1Wx951XTGmvHTE2R/0QsukC8N4ajrHwdhTLpL0D9Pis9+e1J4Qy7r1wT1L9
         FituuSQhiMuI9IUmL6mB/m4K5C+gyd3dSswo1SjcV2AIc1zkdKLGP3YEyw9uRbSTnyef
         6uwLkkG6P1sPu9QpABrojghmOds3GpdzgLuSlG5/5QmDALF4W9Z0yzUVDOZ69CFgJFC0
         dPjpDpGxrLPA2mSW4+hEq0yXGGZSlbeNywVBg0rvb3znVIsa1Qhiq92tqSGqeU0jIHcq
         LNCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=81bQSQb3wEEPINMq19rfFYIhQtFYQQaxVg6e3I6g4Z8=;
        b=2wJMIJNGa8Kvca5hvzV2ltxXJaryM8olAJ98bmZsnaB3P0ulnNse0lUwuLty3JVTVq
         789lJYDsJ5M9++L5wD4bGfGcLdDp2y3bCkhVEPtVJk0hpnxW4AWNJXHg6Rh3niz2HeMH
         blnbGIF3ouNYo2PxdBWH8sD+tQz6xIXQ9B/5DviJDHosJbWKXEtSIJF2ER/HYE3F5mvr
         mS7FmGKYicwXXhPz+95IrbJcnmVZ4e8AhLRBsPJMSYmDdYQ1A6bzxM/orQ32gD9JohIA
         X9zHJIgmV35DIEDO14gi0LMRm+0Z2dU9wYCEHGb0xJQ2iLtR0hSuf2jt5Fyo4AtFh9xs
         +CIg==
X-Gm-Message-State: AOAM531l+cyzZCDJcd50lFNJAO0YSqcyP2j2dn51iRHVVDqUEcL5NoZS
        jXOsnniFU1k2WByt+UV8ezdePQ==
X-Google-Smtp-Source: ABdhPJxCw4H0p4bJRCX4gflrN+anKXbVzdknmZomTRYKNMoouhPMB/DkmE9sAQGSEYWiSnDXypLjwA==
X-Received: by 2002:a63:a745:: with SMTP id w5mr17851937pgo.374.1642401706728;
        Sun, 16 Jan 2022 22:41:46 -0800 (PST)
Received: from localhost ([223.184.90.234])
        by smtp.gmail.com with ESMTPSA id c6sm12967468pfv.62.2022.01.16.22.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jan 2022 22:41:46 -0800 (PST)
Date:   Mon, 17 Jan 2022 12:11:44 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
Cc:     Shuah Khan <shuah@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH] selftests: cpufreq: Write test output to stdout as well
Message-ID: <20220117064144.bovae2r4wnln7g7k@vireshk-i7>
References: <20220114232126.92043-1-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220114232126.92043-1-nfraprado@collabora.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 14-01-22, 18:21, Nícolas F. R. A. Prado wrote:
> Use 'tee' to send the test output to stdout in addition to the current
> output file. This makes the output easier to handle in automated test
> systems and is superior to only later dumping the output file contents
> to stdout, since this way the test output can be interleaved with other
> log messages, like from the kernel, so that chronology is preserved,
> making it easier to detect issues.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> ---
>  tools/testing/selftests/cpufreq/main.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/cpufreq/main.sh b/tools/testing/selftests/cpufreq/main.sh
> index 31f8c9a76c5f..60ce18ed0666 100755
> --- a/tools/testing/selftests/cpufreq/main.sh
> +++ b/tools/testing/selftests/cpufreq/main.sh
> @@ -194,5 +194,5 @@ prerequisite
>  
>  # Run requested functions
>  clear_dumps $OUTFILE
> -do_test >> $OUTFILE.txt
> +do_test | tee -a $OUTFILE.txt
>  dmesg_dumps $OUTFILE

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
