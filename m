Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20A82314F0B
	for <lists+linux-pm@lfdr.de>; Tue,  9 Feb 2021 13:38:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbhBIMhy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Feb 2021 07:37:54 -0500
Received: from smtpcmd0872.aruba.it ([62.149.156.72]:50384 "EHLO
        smtpcmd0872.aruba.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbhBIMhx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Feb 2021 07:37:53 -0500
Received: from [192.168.1.56] ([79.0.204.227])
        by Aruba Outgoing Smtp  with ESMTPSA
        id 9S6Slz4POHTby9S6Sl0V2E; Tue, 09 Feb 2021 13:26:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1612873613; bh=mDUswk8o3BSLtbN9FBZukK6zJHlk4RbhcvaAExyA0nw=;
        h=Subject:To:From:Date:MIME-Version:Content-Type;
        b=Kzl1EYSpnas8XmF09hgxgzzlq2cQfYNdikTV0R866v6FMi18rsR2jWVgS6ccBui0q
         gu/2VBPSRuxNS3lgMEbTkGPRrXRGRpmUJIpU8OHOj7OUqzy/o8lfidC5a1IVHy9fUM
         ifOzehfJ+swDJDepMjKUkMl/t5TLwkCGCF8VvMGb1LyCcywhjMeUBK28Q4njRQxsad
         0jkbGPw7zasSDzwI+CIP46O5RDOafo5UjAXFJttwfb2OzRSmlB08ORdiroaLqs85Ju
         kuFmKTN9jCV9f6jHyTt/4MLwX8PcDuEjJwfSaq5+3DPIc0QcH0oVkEme3g6U8tidQL
         D279Xfw9JloGg==
Subject: Re: [PATCH v2 3/4] pps: Use subdir-ccflags-* to inherit debug flag
To:     Yicong Yang <yangyicong@hisilicon.com>, gregkh@linuxfoundation.org,
        jdelvare@suse.com, linux@roeck-us.net, abbotti@mev.co.uk,
        hsweeten@visionengravers.com, kw@linux.com, helgaas@kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-hwmon@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kbuild@vger.kernel.org, masahiroy@kernel.org,
        michal.lkml@markovi.net
Cc:     prime.zeng@huawei.com, linuxarm@openeuler.org
References: <1612868899-9185-1-git-send-email-yangyicong@hisilicon.com>
 <1612868899-9185-4-git-send-email-yangyicong@hisilicon.com>
From:   Rodolfo Giometti <giometti@enneenne.com>
Message-ID: <36b30ed8-a930-d1c3-2725-c6653f23490c@enneenne.com>
Date:   Tue, 9 Feb 2021 13:26:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1612868899-9185-4-git-send-email-yangyicong@hisilicon.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfJOtvfcS9SDUIzmTBtbnLxCn9w5jBVsknznaedOo9e7Vr0rIPrGhQrxsiBlKpKQMo8p9WoIyfGExvxm3eRi5IThCUTGOTOoVORppicdkKLU7ntqvJoHq
 QPY+Q4cFW3Qlnf7BXKIc2bDD9sR81IdWZPdqhWl/yG48Ze9YsxPcF4EaYAPM6n3pKPXeSqxq5W1TIuiAFAd+LM0Ova77sJiY6RuiBeRT09UY9W4NVDKR9Hkg
 a+qYxNAviyYwMOQiB2hPv+rhKM7AMAmDD2DbOV3UaW+NIxAFUrCK/7wn4arJAwvL20rc7Plqq6DOaoxQW0IeazmOynuZjtKG7vOWanwkDv8Dy81kUXJz2TRw
 A98aGs49XrGCwUBoSyPANKkVLIThLhFOpbFjHXJigrI56FCF4i5CPE/sW+9yft4Fzsw4/OWCNlVYtFGUPjthKo3eN1ifKBIoZCFk8NEVZgcz+/qXlqFRgWLk
 fvmyn/dQzshzuqGfxjd+GEWY4GymmulB0+7tZhyPHgUVBJghPfRKUNyhhcq2Xu/rU808RhuuLRpvDsskEfKDqfYhLAVimMMdoa6tVgHW2u7qAUURgcKCchUZ
 2JbWhCTFJW3iPgCh7EQYmY8Q2NzEZomvywfunnw8/O3EJ30YCuMdQHUYzwrJkjGmuBwVkcM50nXNQsldL103nFTq8x/GsuzwHACgBRF3vE7So7UKAAsHJffY
 D8C8+hAeAqXWlXGr71ctDJ2XrJBTtwqP
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 09/02/21 12:08, Yicong Yang wrote:
> From: Junhao He <hejunhao2@hisilicon.com>
> 
> We use ccflags-$(CONFIG_PPS_DEBUG) for the debug
> message in drivers/pps, but the DEBUG flag will not pass to
> the subdirectory.
> 
> Considering CONFIG_HWMON_DEBUG_CHIP intends to turn on debug
> recursively under driver/pps, so it will be clearer to use
> subdir-ccflags-* instead of ccflags-* to inherit
> the debug settings from Kconfig when traversing subdirectories.
> 
> Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Junhao He <hejunhao2@hisilicon.com>
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> ---
>  drivers/pps/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pps/Makefile b/drivers/pps/Makefile
> index ceaf65c..7a2d3f7 100644
> --- a/drivers/pps/Makefile
> +++ b/drivers/pps/Makefile
> @@ -8,4 +8,4 @@ pps_core-$(CONFIG_NTP_PPS)	+= kc.o
>  obj-$(CONFIG_PPS)		:= pps_core.o
>  obj-y				+= clients/ generators/
>  
> -ccflags-$(CONFIG_PPS_DEBUG) := -DDEBUG
> +subdir-ccflags-$(CONFIG_PPS_DEBUG) := -DDEBUG
> 

Acked-by: Rodolfo Giometti <giometti@enneenne.com>

-- 
GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming                     skype:  rodolfo.giometti
