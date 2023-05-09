Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC116FCE00
	for <lists+linux-pm@lfdr.de>; Tue,  9 May 2023 20:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbjEISuN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 May 2023 14:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjEISuM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 May 2023 14:50:12 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C942D43
        for <linux-pm@vger.kernel.org>; Tue,  9 May 2023 11:50:07 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-50b383222f7so9508454a12.3
        for <linux-pm@vger.kernel.org>; Tue, 09 May 2023 11:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683658206; x=1686250206;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7vDwdI4Y0zhDRNPMOTcRtq2TPj7BphvfPLZ3WWPJT7s=;
        b=dDk7hNdWSHdPiXlx2txnzdQ8whDxlg4yZNetGYJvUoAYTrywaDhZbApu9JTLZGR5Qu
         8etrdRwat3yRGIjy1vyCkywzLvEXI1jzeIi3DZXVTT1Nam1CyZPuIJJg2CFt3teFl477
         XRrMyOEqixZxxwHev98tEaS34+i2Cv3FExLcvl+GATfR0ThZI/XFhlfteaODKfCzKSiC
         apDg1ls4qyFeUvfUPyyYSnDNXExilb//syx2rPgBvT4Wv2h47AcWpG7rBQX5hdqRT15v
         0PoA641WADeOII3l0+DE7CcpeN1fAripoa5kWM4cyWWWC7hhDvQpAybiBln4bzr/l3dm
         Bj0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683658206; x=1686250206;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7vDwdI4Y0zhDRNPMOTcRtq2TPj7BphvfPLZ3WWPJT7s=;
        b=eYDlj7OmF/285WpCB8x2hy/IH7KScyzquLiG5x9zKSkKxyziUWhBR/Mlvg3qU14hOr
         lG9KseDhBD0BnsHHKzRCrACdBykYUwRK3fC3GvFprivT62WCGBb5tjlYVrOPolYCxavg
         7yVdw8MkfLaI7KihVvjwKFk4Kiao7OYVQLzpa7x1QAzuZBBKm0RCDAitUeXTFwOrayyb
         gOCdAiENf21IhSAZjF4Ri8+Sed5Ys8MEXpYUuWSU28KFwM+fVmXEIOEGMWvERz1WxBVV
         19GkFu6L1aTshLMOjHP2uwxy1u5tBbrDR6e65mv9cziu+YjeEebjs1wAviOkQQqaQ5zA
         tYgw==
X-Gm-Message-State: AC+VfDxZchEJmu+5/ipIVG4OeSjV9AwIv6Dc6rcJ9YN+dLVZ8tPbdK1h
        NzXcFYsi/BSIxmQXl2F1It8=
X-Google-Smtp-Source: ACHHUZ6IRaVlQNavyKreJUzKlq8F5+VTTntfW23W4708AokIbLGmaTKpNEip4Boxb98XHHUIHJP1bw==
X-Received: by 2002:a17:907:36c6:b0:94f:562b:2979 with SMTP id bj6-20020a17090736c600b0094f562b2979mr12447551ejc.31.1683658206255;
        Tue, 09 May 2023 11:50:06 -0700 (PDT)
Received: from eldamar.lan (c-82-192-242-114.customer.ggaweb.ch. [82.192.242.114])
        by smtp.gmail.com with ESMTPSA id ig13-20020a1709072e0d00b0096623c00727sm1649843ejc.136.2023.05.09.11.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 11:50:05 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
        id 39509BE2DE0; Tue,  9 May 2023 20:50:05 +0200 (CEST)
Date:   Tue, 9 May 2023 20:50:05 +0200
From:   Salvatore Bonaccorso <carnil@debian.org>
To:     Thomas Renninger <trenn@suse.com>, linux-pm@vger.kernel.org
Cc:     Ben Hutchings <ben@decadent.org.uk>, Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH] cpupower: Bump soname version
Message-ID: <ZFqV3ZFROy0m+/Xt@eldamar.lan>
References: <20160610005619.GQ7555@decadent.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160610005619.GQ7555@decadent.org.uk>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Thomas,

On Fri, Jun 10, 2016 at 01:56:20AM +0100, Ben Hutchings wrote:
> Several functions in the libcpupower API are renamed or removed in
> Linux 4.7.  This is an backward-incompatible ABI change, so the
> library soname should change from libcpupower.so.0 to
> libcpupower.so.1.
> 
> Fixes: ac5a181d065d ("cpupower: Add cpuidle parts into library")
> Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
> ---
> I have to say the choice of variable names here is rather confusing.
> LIB_MIN is used for the soname version, which would normally be the
> *major* part of the version.
> 
> I'll send a second patch that switches to more conventional library
> versioning.
> 
> Ben.
> 
>  tools/power/cpupower/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/power/cpupower/Makefile b/tools/power/cpupower/Makefile
> index 8358863259c5..0b85f5915ce8 100644
> --- a/tools/power/cpupower/Makefile
> +++ b/tools/power/cpupower/Makefile
> @@ -64,7 +64,7 @@ DESTDIR ?=
>  
>  VERSION=			$(shell ./utils/version-gen.sh)
>  LIB_MAJ=			0.0.1
> -LIB_MIN=			0
> +LIB_MIN=			1
>  
>  PACKAGE =			cpupower
>  PACKAGE_BUGREPORT =		linux-pm@vger.kernel.org

Repinging this patch. Thomas, we are shipping it in Debian since, and
I'm wondering if the patch did just felt trough the cracks.

Regards,
Salvatore
