Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A78033B35E
	for <lists+linux-pm@lfdr.de>; Mon, 15 Mar 2021 14:12:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbhCONLl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 15 Mar 2021 09:11:41 -0400
Received: from mail-wm1-f42.google.com ([209.85.128.42]:46865 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbhCONLQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 15 Mar 2021 09:11:16 -0400
Received: by mail-wm1-f42.google.com with SMTP id d139-20020a1c1d910000b029010b895cb6f2so19404164wmd.5;
        Mon, 15 Mar 2021 06:11:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qqfofxJJvL97CyThmJbWDOZDdOswFnLIDcDX1c+Xar8=;
        b=E/1/21eCom8/UeCCN1H/SGTK20gXPcBEUCxPBTPyMFSRTrZThWkyC7p42spUNjemgB
         r1UAXcp8+AWUTAyGSlkYqHs2KRbqYV3/XiqdsKO8Hs95z1PcLR0V2peizgPtxANPJn+y
         Hh4RNvY2af/mHjlwdxp5DDxCEHpV0jMHxrv2uCaFUwUS1aF3TwOjnjrdEEpqr4ThqHhw
         dujyokP04bPmLMk4wK4sx1zwbDq/pkaqXKKtrdVMgN3tFxEFj5bmAcIMKIc+JlBquxsq
         stgJzKLa6Sb1DOQAfbJnfB9H9IAqxWWgQ5wU4s8qnY5CNpyMkX2tsW4NXRD7hVxjpih7
         4Ggw==
X-Gm-Message-State: AOAM5313gvK3lDXRRbRC+wQqlh1iDZOBV9r1oUMzBNHME6aUa1X08UkH
        X/HRh0wjbOZTY9xrysVnZdE=
X-Google-Smtp-Source: ABdhPJxzVnd9JjVflVxEo9H8HI0OmuYLgoqrLAbegOb2TJvYfm+4Lon8/TbZ6L0lTY7qvbw7Q2o8jQ==
X-Received: by 2002:a1c:1f8f:: with SMTP id f137mr25819030wmf.66.1615813871521;
        Mon, 15 Mar 2021 06:11:11 -0700 (PDT)
Received: from [192.168.1.116] (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id u23sm12362131wmn.26.2021.03.15.06.11.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Mar 2021 06:11:10 -0700 (PDT)
Subject: Re: [PATCH] cpufreq:s5pv210:Fix typo issue
To:     Xiaofeng Cao <cxfcosmos@gmail.com>, rjw@rjwysocki.net,
        viresh.kumar@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xiaofeng Cao <caoxiaofeng@yulong.com>
References: <20210315130855.9715-1-cxfcosmos@gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Message-ID: <f8427d5b-24bd-cc54-4649-f2e6e006129c@kernel.org>
Date:   Mon, 15 Mar 2021 14:11:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210315130855.9715-1-cxfcosmos@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 15/03/2021 14:08, Xiaofeng Cao wrote:
> change 'freqency' to 'frequency'
> change 'accoriding' to 'according'
> change 'untile' to 'until'
> change 'souce' to 'source'
> change 'divier' to 'divider'
> 
> Signed-off-by: Xiaofeng Cao <caoxiaofeng@yulong.com>
> ---
>  drivers/cpufreq/s5pv210-cpufreq.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 

Thanks, but already fixed here:
https://lore.kernel.org/linux-arm-kernel/20210313034951.13269-1-unixbhaskar@gmail.com/

Best regards,
Krzysztof
