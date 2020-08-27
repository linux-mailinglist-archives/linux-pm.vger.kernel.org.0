Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C57C254BB1
	for <lists+linux-pm@lfdr.de>; Thu, 27 Aug 2020 19:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgH0RLu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 Aug 2020 13:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbgH0RLs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Aug 2020 13:11:48 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D031C06121B;
        Thu, 27 Aug 2020 10:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=va1W/wu0D2iKj3V3xi8LWa26LKykVBSskhKiiZRnxsM=; b=Wc+72D4Setyn4hb763n+bQ0Ll0
        rWVVCK4Cwpy33AK+exuym+jzlUoVQij9cNl7t3cVf2cyjktpJenJc/oSEmSKq34rxofCc8Z3Dk9ZE
        GC1/Sd6Ta1McDcJfEF3HIMMFpWJhDWnqwauhdq9RGSc5u9HC/ZUKfreAM7rLSZhgjUMGuYOH6Y9DB
        WceTwioIp00zsvMNx5ztgvn0k5TZMYcg/6gMVPsYoyArICjCTy5MsfrRPsiEBeK8FqhKiu5/Qgbj3
        v2ve7Udg1uHQCvt4KS1Rflp6qYhdtao2EHnC3hTberxOb3+HPaKtDNkB3WoLsLac/CTJKsr4XtPb6
        /p3O2jvA==;
Received: from [2601:1c0:6280:3f0::19c2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kBLR4-0000T0-UW; Thu, 27 Aug 2020 17:11:39 +0000
Subject: Re: [PATCH v2] power: supply: Add support for RN5T618/RC5T619 charger
 and fuel gauge
To:     Andreas Kemnade <andreas@kemnade.info>, lee.jones@linaro.org,
        sre@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, b.galvani@gmail.com, phh@phh.me,
        letux-kernel@openphoenux.org
References: <20200827170713.12142-1-andreas@kemnade.info>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <68444fa7-895d-3d64-2afd-43fc6d73a8d0@infradead.org>
Date:   Thu, 27 Aug 2020 10:11:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200827170713.12142-1-andreas@kemnade.info>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi--

On 8/27/20 10:07 AM, Andreas Kemnade wrote:
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index 44d3c8512fb8..28cea178f6f1 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -739,4 +739,12 @@ config CHARGER_WILCO
>  	  information can be found in
>  	  Documentation/ABI/testing/sysfs-class-power-wilco
>  
> +config RN5T618_POWER
> +	tristate "RN5T618 charger/fuel gauge support"
> +	depends on MFD_RN5T618
> +	help
> +	  Say Y here to have support for RN5T618 PMIC family fuel gauge and charger

Missing period at the end of the sentence above.

> +	  This driver can also be built as a module. If so, the module will be
> +	  called rn5t618_power.
> +
>  endif # POWER_SUPPLY


-- 
~Randy

