Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30EC512B220
	for <lists+linux-pm@lfdr.de>; Fri, 27 Dec 2019 07:52:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbfL0GwI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 27 Dec 2019 01:52:08 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42906 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbfL0GwI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 27 Dec 2019 01:52:08 -0500
Received: by mail-pf1-f196.google.com with SMTP id 4so14313927pfz.9
        for <linux-pm@vger.kernel.org>; Thu, 26 Dec 2019 22:52:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=h10PX8DJZLkPTns7u+7EuYORpZ6ZCEapdli54+ecjxE=;
        b=IlEGowUjJh+UEXHDSpv9xzRlUtyRJqnj18TeES1zEeZ0Ufgd4cSTU3pujZA8pWrJqY
         uUK//86SVklBs+lGleyGtdF9p4m9bCd5BUNNyn6E4Kn5JpaK9Dnc3n6Gh1fLrN5JBU8L
         6N/VQH+jlyExVwxkxI5uTStVd1CPYH6Kbr9v0SHtP0n2vZW/sWlbG8AT/xlEpQJUTrQR
         tcUX6v60Kwfqu4nw3g8/qFeHbc0xJ8w74d040mqbnZHu1/h0B26yq6IARvcHcwyfS1xe
         ogrA4NkzcVMA7rgdR5I51p7OoqMAeForma67L7imtjVH73lq8vvk9ma5eAMoEPQATA0J
         ZJ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=h10PX8DJZLkPTns7u+7EuYORpZ6ZCEapdli54+ecjxE=;
        b=RDUwdxXtRiqR6rBD7ojvj7KD+m3X/dwiLxuS/IrevKdoxsIEHru6KzZAkNSaPD2LNf
         98HU8tYSWiPYagOK3nx/QS9D+ZZHEFQpriOKCDORMQDhj/PUeyxOL98sIjB+BgeHROiO
         cZM0CdHuo8rFoB0XPR7u9MNB0V/8rnKXwvhpmnBLl4WzgfCFV6n+jxihlwkV8/fgx8Qr
         /0C5B/EutBedEG2TNImoeXRSDe5FKqz+NGnf8RBhLYS73dIfktvVskJmCaDRziGmua+b
         v6gGkOJZ9v1LQ8UY7iSaKnWW11E3PRS8MwbXbofLQxAJt0nyaoNCIFS7CU3COh3k9+LB
         wQ+A==
X-Gm-Message-State: APjAAAWuGUB7PiLVWT2BfP+6Chl9RRRmE6Tqv1BXskFYcAGZsDq8mV18
        Ubnb2L9E5u10sTVNOdPkLWRw3g==
X-Google-Smtp-Source: APXvYqyNUvZALjln+pn3J5Nvw3y9HrAHIAb9GQ1w9VWf2pZ2BHcUsqmXIr+KGgm8fNiWIfbsDxWyDg==
X-Received: by 2002:a63:289:: with SMTP id 131mr53477901pgc.149.1577429527727;
        Thu, 26 Dec 2019 22:52:07 -0800 (PST)
Received: from ripper (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id d1sm13099541pjx.6.2019.12.26.22.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Dec 2019 22:52:07 -0800 (PST)
Date:   Thu, 26 Dec 2019 22:51:53 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Niklas Cassel <nks@flawful.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 3/5] power: avs: qcom-cpr: make sure that regmap is
 available
Message-ID: <20191227065153.GL1908628@ripper>
References: <20191223141934.19837-1-nks@flawful.org>
 <20191223141934.19837-4-nks@flawful.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191223141934.19837-4-nks@flawful.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon 23 Dec 06:19 PST 2019, Niklas Cassel wrote:

> drivers/power/avs/qcom-cpr.c:402:4:
> error: implicit declaration of function ‘regmap_multi_reg_write’
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> Signed-off-by: Niklas Cassel <nks@flawful.org>
> ---
>  drivers/power/avs/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/power/avs/Kconfig b/drivers/power/avs/Kconfig
> index c21882908a66..b8fe166cd0d9 100644
> --- a/drivers/power/avs/Kconfig
> +++ b/drivers/power/avs/Kconfig
> @@ -16,6 +16,7 @@ config QCOM_CPR
>  	tristate "QCOM Core Power Reduction (CPR) support"
>  	depends on POWER_AVS
>  	select PM_OPP
> +	select REGMAP
>  	help
>  	  Say Y here to enable support for the CPR hardware found on Qualcomm
>  	  SoCs like QCS404.
> -- 
> 2.24.1
> 
