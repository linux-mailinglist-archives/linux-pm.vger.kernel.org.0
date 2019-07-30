Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0BC57A4CE
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2019 11:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbfG3JlY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Jul 2019 05:41:24 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:46803 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbfG3JlY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Jul 2019 05:41:24 -0400
Received: by mail-lf1-f68.google.com with SMTP id z15so39959754lfh.13;
        Tue, 30 Jul 2019 02:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FiNSWAhWRWHMiKlDO5ZxlnYmA3exJcJjciDpPCvLDeU=;
        b=fN3owNYnTwvQd7qsBYYz3kIsu5drP5C491VrG/lTnr8qKxdUpNqa1hfmJZjnEdWUL/
         wyQLbog+bvijwLXw7EAIygGVfeGgXHVkqo+IPOM5RZI4hgsxxBwnHyXQj6AiHx+R+LxI
         y3ZzNYxqdDUnqIuRJxtgN9+aBwv8c9NGj1ZO9YndqygtLolKYGeE5BakhXFVPLf5MyKE
         E7Gtt0yg4vZGfBw4esz9zDFBOd6wC8Ddz0H5NvjXKmsrTStgw9qWluG7rB5KC/aVzJ7A
         6fszIOc1wQD3hq/lW3P0ywLDvXEKasVRO2WSROblAlULx9JaI+EW+EFykPZzPY4pBK2C
         56fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FiNSWAhWRWHMiKlDO5ZxlnYmA3exJcJjciDpPCvLDeU=;
        b=PU21LcygPMlRO/eJ3kOGd2+hliv67kKMPiaYS8cxBoS2iO2A8ccEPIpLs4QuDwwMBm
         V5f7Frnmi+b2fEd2UrPEXPCbS309zcjVTvJXYli7CpZX0G8OED11RXJShjItJjJ9flqq
         9njbP1l/NLCCKC+tcdTiuoeZkK1ETH7G3AH3yFmHnxDQP4LqDVEt2Oc8mGdU9BgGRyYm
         37BGNq7kJ6twLJFVEp+EQmGTt+m/ugV25orCRaurrjwZqRpdz/jJKcxxldswrpSjWIAq
         nUawenTDNQHKDGoGJkVCkl+VbGh9hrHQGZ7dj5UobN9pJpXF2J78+LlzplMdo+1rVxyV
         ChKQ==
X-Gm-Message-State: APjAAAWEZSiE5kSh+Tz798XRGWS9ZtS+IunVdqRdABYxWrCdP6LWh8B5
        rYOh4FtbQPgRsbKAmbVRjEs=
X-Google-Smtp-Source: APXvYqweTQ5kKdUYAfu0E6bmpPzufMx9qE7rgZuRRHxFXTW3BTKaHYUoF6WnsZFej3rpfp3dqB1JvQ==
X-Received: by 2002:a19:491d:: with SMTP id w29mr54806862lfa.149.1564479681978;
        Tue, 30 Jul 2019 02:41:21 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-78-220-99.pppoe.mtu-net.ru. [91.78.220.99])
        by smtp.googlemail.com with ESMTPSA id i23sm13297621ljb.7.2019.07.30.02.41.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2019 02:41:21 -0700 (PDT)
Subject: Re: [PATCH] driver core: Fix creation of device links with PM-runtime
 flags
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Saravana Kannan <saravanak@google.com>,
        Lukas Wunner <lukas@wunner.de>,
        Jon Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
References: <7674989.cD04D8YV3U@kreacher>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <eea5e138-33cc-42c4-1c42-56d309847d82@gmail.com>
Date:   Tue, 30 Jul 2019 12:41:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <7674989.cD04D8YV3U@kreacher>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

30.07.2019 12:28, Rafael J. Wysocki пишет:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> After commit 515db266a9da ("driver core: Remove device link creation
> limitation"), if PM-runtime flags are passed to device_link_add(), it
> will fail (returning NULL) due to an overly restrictive flags check
> introduced by that commit.
> 
> Fix this issue by extending the check in question to cover the
> PM-runtime flags too.
> 
> Fixes: 515db266a9da ("driver core: Remove device link creation limitation")
> Reported-by: Dmitry Osipenko <digetx@gmail.com>
> Tested-by: Jon Hunter <jonathanh@nvidia.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/base/core.c |    6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> Index: linux-pm/drivers/base/core.c
> ===================================================================
> --- linux-pm.orig/drivers/base/core.c
> +++ linux-pm/drivers/base/core.c
> @@ -213,6 +213,9 @@ void device_pm_move_to_tail(struct devic
>  			       DL_FLAG_AUTOREMOVE_SUPPLIER | \
>  			       DL_FLAG_AUTOPROBE_CONSUMER)
>  
> +#define DL_ADD_VALID_FLAGS (DL_MANAGED_LINK_FLAGS | DL_FLAG_STATELESS | \
> +			    DL_FLAG_PM_RUNTIME | DL_FLAG_RPM_ACTIVE)
> +
>  /**
>   * device_link_add - Create a link between two devices.
>   * @consumer: Consumer end of the link.
> @@ -274,8 +277,7 @@ struct device_link *device_link_add(stru
>  {
>  	struct device_link *link;
>  
> -	if (!consumer || !supplier ||
> -	    (flags & ~(DL_FLAG_STATELESS | DL_MANAGED_LINK_FLAGS)) ||
> +	if (!consumer || !supplier || flags & ~DL_ADD_VALID_FLAGS ||
>  	    (flags & DL_FLAG_STATELESS && flags & DL_MANAGED_LINK_FLAGS) ||
>  	    (flags & DL_FLAG_AUTOPROBE_CONSUMER &&
>  	     flags & (DL_FLAG_AUTOREMOVE_CONSUMER |
> 
> 
> 

Thank you very much!

Tested-by: Dmitry Osipenko <digetx@gmail.com>
