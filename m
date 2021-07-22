Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB07D3D275A
	for <lists+linux-pm@lfdr.de>; Thu, 22 Jul 2021 18:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbhGVPcL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 22 Jul 2021 11:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbhGVPcK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 22 Jul 2021 11:32:10 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F0AEC061575
        for <linux-pm@vger.kernel.org>; Thu, 22 Jul 2021 09:12:45 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id s5so5868829ild.5
        for <linux-pm@vger.kernel.org>; Thu, 22 Jul 2021 09:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=ICEz6n3pVf9Vk+tzL5p0fvUItl4lvYSroSdckHL7HBo=;
        b=EPBubVQ+53GLxlG7PUtcHGG724gGseIWBF+8ETwzGmKmBd5jZNv1gOd6DW2uJZMGE9
         2CVQH32kJUMf7kMPK9E+lQNS/jDxUKg16yng3vU46LIpDQCVsngUicaOZjL2TI16u8VC
         a+oIOmKGPrcPojdhFUM33N0gWXjte2tzlt70I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ICEz6n3pVf9Vk+tzL5p0fvUItl4lvYSroSdckHL7HBo=;
        b=MgyyuwBfzZRv+BGMKSfIrzUIlGiUGxpg1duPhmH8laR0TuCv52Q20+CxuJmLXeckP2
         DmwZnDfaWW+IIzOLUohNqit4/4NTr1t1p8WLxe1ER/ejPZ6fmUIGnhlpMlgGKOjgpTLf
         8iPGvk+dPClB6iAjHMGMuaCdzr2HmOMeuj+vRDxw0j9elDFqIOZRfEFEKc3y0VvdOac5
         Ao518vxz2DGH+eRgkFWQhhK6CbdpcQBYHKnQlerAvOQMZof8D+DxZwyISUuRVGn4G0MF
         wVeWtWIXnY4vQlxy2NPLEvoYnn8fJ9Sq+d16QmBfcYLwlueNPiwHL6M+p5DncBDMBFQl
         hYhw==
X-Gm-Message-State: AOAM531ASBaJrLLjiJcX6Zo1eIshlqx2Fqd//VQvMBDl8Mmej/faifWp
        LP+vP9QncdbbHnfJ60SsaPJelg==
X-Google-Smtp-Source: ABdhPJxjvwU6Eln78LNnvW8d/s+U82xI1U1CMBs/mmnancvRG7gaqP3MZicYf+t0JWMPeL8pwTscoA==
X-Received: by 2002:a92:7f03:: with SMTP id a3mr397983ild.254.1626970364903;
        Thu, 22 Jul 2021 09:12:44 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id k4sm16391894ior.55.2021.07.22.09.12.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jul 2021 09:12:44 -0700 (PDT)
Subject: Re: [PATCH] tools: cpupower: fix typo in cpupower-idle-set(1) manpage
To:     andreas@rammhold.de, Thomas Renninger <trenn@suse.com>,
        Shuah Khan <shuah@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
References: <20210716200034.2158602-1-andreas@rammhold.de>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <f8778c74-bfd9-d366-1c39-55dbccb84d0c@linuxfoundation.org>
Date:   Thu, 22 Jul 2021 10:12:43 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210716200034.2158602-1-andreas@rammhold.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 7/16/21 2:00 PM, andreas@rammhold.de wrote:
> From: Andreas Rammhold <andreas@rammhold.de>
> 
> The tools name was wrong in the SYNTAX section of the manpage it should
> read "idle-set" instead of "idle-info".
> 
> Signed-off-by: Andreas Rammhold <andreas@rammhold.de>
> ---
>   tools/power/cpupower/man/cpupower-idle-set.1 | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/power/cpupower/man/cpupower-idle-set.1 b/tools/power/cpupower/man/cpupower-idle-set.1
> index 21916cff7516..8cef3c71e19e 100644
> --- a/tools/power/cpupower/man/cpupower-idle-set.1
> +++ b/tools/power/cpupower/man/cpupower-idle-set.1
> @@ -4,7 +4,7 @@
>   cpupower\-idle\-set \- Utility to set cpu idle state specific kernel options
>   .SH "SYNTAX"
>   .LP
> -cpupower [ \-c cpulist ] idle\-info [\fIoptions\fP]
> +cpupower [ \-c cpulist ] idle\-set [\fIoptions\fP]
>   .SH "DESCRIPTION"
>   .LP
>   The cpupower idle\-set subcommand allows to set cpu idle, also called cpu
> 

Thank you. Applied to

git.kernel.org/pub/scm/linux/kernel/git/shuah/linux.git cpupower

This patch will be included in my next cpupower pull request to Rafael.

thanks,
-- Shuah

