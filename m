Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 614E86AB25C
	for <lists+linux-pm@lfdr.de>; Sun,  5 Mar 2023 22:00:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbjCEVAy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 5 Mar 2023 16:00:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjCEVAx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 5 Mar 2023 16:00:53 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F3A61968C
        for <linux-pm@vger.kernel.org>; Sun,  5 Mar 2023 12:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678049883;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nBTMm3uwgvfae/ngoBF4AejEDDkHKSRKnnl2elLXTYw=;
        b=V+UFcgG/gEpU8IZmkg2jq6U5VUYDRR5mhdTSRfdaB709jMz7xe9cqDxgxtjTaXaMJ1AtqU
        iyg0J2x0FMUBl+rn9wdwkmiJY9lOEW3Re6AwhHSDF3XPKyITxK79Wl1H+4mKutuOYfsc2t
        nVjzR6PLpe0PPevIfbCc4oTL//fEqdU=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-DCtl6L1GOPWVkGwgD_IeqQ-1; Sun, 05 Mar 2023 15:58:02 -0500
X-MC-Unique: DCtl6L1GOPWVkGwgD_IeqQ-1
Received: by mail-ed1-f69.google.com with SMTP id v11-20020a056402348b00b004ce34232666so7557567edc.3
        for <linux-pm@vger.kernel.org>; Sun, 05 Mar 2023 12:58:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678049881;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nBTMm3uwgvfae/ngoBF4AejEDDkHKSRKnnl2elLXTYw=;
        b=qzWRCzkREB+bCE31CkwYmdAmtEKqSOb4m+psKHLEOwFOGGntem3BNoVI7UTbQ67zvM
         BAEYYKxyfeSYp30WoVB03UzGih4fhpi9crnJ8mTT7IbhecM82dbndaFV2K13wLuCiXMn
         vWKg174jpojYxIJ5ignJkHGR6nKzngl0JJnBOYx2fqnRF9XIuypzNdnQpSqKyzNsvVV8
         pHiucQ4JLbnA+BI7nk6TwQ6bi+cgB8T3s7aMdacvSvDZI+nTHEfpDNgCVWAQmQSf9uSx
         c0LtBb7gzViVY2Mwleo9cU0qMOOwZExLQHR48WTaGaasrAITGQoljtJ+X4N54eoIqm3D
         mOLQ==
X-Gm-Message-State: AO0yUKW291uBbRu8BUbQhmsr/qasXQaQghxnEH5WneMKQiA7uLBcMIr1
        uoJXMnlFPFoisyz0T33h1vI8Faw29+DdtJtWvAFWIYBOZRqmNfa5RUJ6xWdpdad2whuo+dsC2P7
        GRhpv2qI5Z9rYvsx8JavuC35jhv4=
X-Received: by 2002:a17:906:af01:b0:8b2:3748:3db9 with SMTP id lx1-20020a170906af0100b008b237483db9mr8687403ejb.51.1678049880872;
        Sun, 05 Mar 2023 12:58:00 -0800 (PST)
X-Google-Smtp-Source: AK7set8+akk5BoFJ5RgHwnWSmiU4nErv6fX2JMKZNEKpVATaBy1VZ1wwUY5r7o386egviRJjpYXVGQ==
X-Received: by 2002:a17:906:af01:b0:8b2:3748:3db9 with SMTP id lx1-20020a170906af0100b008b237483db9mr8687399ejb.51.1678049880615;
        Sun, 05 Mar 2023 12:58:00 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id ga2-20020a170906b84200b00882f9130eafsm3622161ejb.26.2023.03.05.12.57.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Mar 2023 12:58:00 -0800 (PST)
Message-ID: <bd24cdb6-4db4-feff-57d5-dc0cb64aff0c@redhat.com>
Date:   Sun, 5 Mar 2023 21:57:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] power: supply: Ratelimit no data debug output
To:     Marek Vasut <marex@denx.de>, linux-pm@vger.kernel.org
Cc:     Sebastian Reichel <sre@kernel.org>
References: <20230305205226.773025-1-marex@denx.de>
Content-Language: en-US, nl
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230305205226.773025-1-marex@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 3/5/23 21:52, Marek Vasut wrote:
> Reduce the amount of output this dev_dbg() statement emits into logs,
> otherwise if system software polls the sysfs entry for data and keeps
> getting -ENODATA, it could end up filling the logs up.
> 
> This does in fact make systemd journald choke, since during boot the
> sysfs power supply entries are polled and if journald starts at the
> same time, the journal is just being repeatedly filled up, and the
> system stops on trying to start journald without booting any further.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Sebastian Reichel <sre@kernel.org>
> Cc: linux-pm@vger.kernel.org

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>  drivers/power/supply/power_supply_sysfs.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
> index c228205e09538..4bbb3053eef44 100644
> --- a/drivers/power/supply/power_supply_sysfs.c
> +++ b/drivers/power/supply/power_supply_sysfs.c
> @@ -285,7 +285,8 @@ static ssize_t power_supply_show_property(struct device *dev,
>  
>  		if (ret < 0) {
>  			if (ret == -ENODATA)
> -				dev_dbg(dev, "driver has no data for `%s' property\n",
> +				dev_dbg_ratelimited(dev,
> +					"driver has no data for `%s' property\n",
>  					attr->attr.name);
>  			else if (ret != -ENODEV && ret != -EAGAIN)
>  				dev_err_ratelimited(dev,

