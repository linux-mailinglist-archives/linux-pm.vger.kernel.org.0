Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B82B6215C51
	for <lists+linux-pm@lfdr.de>; Mon,  6 Jul 2020 18:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729629AbgGFQyX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Jul 2020 12:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729623AbgGFQyX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Jul 2020 12:54:23 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18694C08C5DF
        for <linux-pm@vger.kernel.org>; Mon,  6 Jul 2020 09:54:23 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id l2so41374324wmf.0
        for <linux-pm@vger.kernel.org>; Mon, 06 Jul 2020 09:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Xne7vGpOLGVeZi1RzsYuJY7kP006PU447//pazbnL/8=;
        b=UEvqepdTWsEazyNyqDFLHWyFasioIb58H3Ax5VAXf9sR/mpp/WR3L1ghP3K3Mx78ez
         EHqQvwgr5FA12jUBNWe/8k3ZdP3I+cnx3fUoS0aJOTk0TmsULpbBi9fuaAjZ5tIfhcFz
         /43uuB0C+XpM1umBZrUir5clRWeTFo30UE7yn3EDEcba+DAUu42Il6fbk8vMKwEeMaPr
         YDDGYTj3TqsEBYWh58ghEVN/GeWzobDjcJHT1gJC7phxiTp9Y0y5fX11H5Ynz/SRXl1E
         SgZuMyqOS9HbyCQgcGMTDx2WxH9sPaX4F55h+67iKU9SejsMgherhSQGL/vt8+mytJIl
         vGUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Xne7vGpOLGVeZi1RzsYuJY7kP006PU447//pazbnL/8=;
        b=Pj0Dsd287ekAO1MFWVStmrn9R/BgsdafqMBgpr/xGnUYyb3/95jHFr9SPCsUcI/Ot2
         BAF1DFNQg5k+EvqlFIahx36A/h8kupkezOyQ2+h8/jYZn65cp/STCMo1MxAabXK9l8ND
         SxTbCo8YN9utC5C7QriT8XcOijdRNPJ9XWlUsg8BlKKQ2jDtfHYQ1y08H4HMQmWOtj7Q
         hprxsvlcD0Hn7v9T0eW2Qvmkr4oAHpHtRd6G8MQbXYjQsOD3ui3swFdZ4U3o/uuIv02D
         elpf40x+MHLnUU+cbKRA7/pBD+hJMpd5MWKzqqBYg9Geax+PvFOY6CfKnWWeuPJ+dkcJ
         UXCg==
X-Gm-Message-State: AOAM5338YBLnSWQ93OHmVOv96t5kcgdDIN4aE/10R1sapIpfnZ+Zsvvy
        Grs106I6ukmOXe052ahhsaxZ3A==
X-Google-Smtp-Source: ABdhPJxExmQmKbAkk+w/FTJsLGuqOHLlDJckmvf+a6xqgrNkO3sW24epd0O9t/fk4BURnw+rdGk1mQ==
X-Received: by 2002:a1c:804c:: with SMTP id b73mr106243wmd.59.1594054461512;
        Mon, 06 Jul 2020 09:54:21 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:f9e8:8c05:eb6f:1865? ([2a01:e34:ed2f:f020:f9e8:8c05:eb6f:1865])
        by smtp.googlemail.com with ESMTPSA id 51sm20025871wrc.44.2020.07.06.09.54.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2020 09:54:20 -0700 (PDT)
Subject: Re: linux-next: Tree for Jul 6 (thermal/thermal_netlink.c)
To:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>
References: <20200706174001.2d316826@canb.auug.org.au>
 <b0348556-065d-f8fa-fc1d-0f084147deb5@infradead.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <af95ed8a-577b-d029-ac27-9fbd142e9ffa@linaro.org>
Date:   Mon, 6 Jul 2020 18:54:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <b0348556-065d-f8fa-fc1d-0f084147deb5@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Hi,

thanks for reporting that, I'll fix it.

On 06/07/2020 18:53, Randy Dunlap wrote:
> On 7/6/20 12:40 AM, Stephen Rothwell wrote:
>> Hi all,
>>
>> Changes since 20200703:
>>
> 
> on i386 or x86_64:
> 
> when CONFIG_NET is not set/enabled:
> 
> thermal_netlink.c:(.text+0x34): undefined reference to `nla_put'
> thermal_netlink.c:(.text+0x76): undefined reference to `nla_put'
> thermal_netlink.c:(.text+0x87f): undefined reference to `init_net'
> ld: thermal_netlink.c:(.text+0x89d): undefined reference to `netlink_broadcast'
> thermal_netlink.c:(.text+0xa19): undefined reference to `__alloc_skb'
> ld: thermal_netlink.c:(.text+0xa59): undefined reference to `genlmsg_put'
> ld: thermal_netlink.c:(.text+0xad9): undefined reference to `init_net'
> ld: thermal_netlink.c:(.text+0xade): undefined reference to `netlink_unicast'
> ld: thermal_netlink.c:(.text+0xb02): undefined reference to `kfree_skb'
> thermal_netlink.c:(.text+0xb7d): undefined reference to `genlmsg_put'
> thermal_netlink.c:(.text+0xc29): undefined reference to `__alloc_skb'
> ld: thermal_netlink.c:(.text+0xc66): undefined reference to `genlmsg_put'
> ld: thermal_netlink.c:(.text+0xce1): undefined reference to `kfree_skb'
> thermal_netlink.c:(.text+0xd0e): undefined reference to `__alloc_skb'
> ld: thermal_netlink.c:(.text+0xd47): undefined reference to `genlmsg_put'
> ld: thermal_netlink.c:(.text+0xde4): undefined reference to `kfree_skb'
> thermal_netlink.c:(.text+0x1d): undefined reference to `nla_put'
> thermal_netlink.c:(.text+0x494): undefined reference to `skb_trim'
> thermal_netlink.c:(.init.text+0xd): undefined reference to `genl_register_family'
> 
> 
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
