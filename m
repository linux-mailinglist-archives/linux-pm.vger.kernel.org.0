Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 279F922E76B
	for <lists+linux-pm@lfdr.de>; Mon, 27 Jul 2020 10:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbgG0IPI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Jul 2020 04:15:08 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40125 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbgG0IPC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Jul 2020 04:15:02 -0400
Received: by mail-ed1-f68.google.com with SMTP id b13so9067149edz.7;
        Mon, 27 Jul 2020 01:15:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uQ6jS2p/wfLKpN5rZ4uG0Txi8VApzRXQQMOZTpW6E5I=;
        b=FlSx8lyn6PxIQqtnya+AZusTMI7TnZzh4VZsyO2q4xap/E/TKNtQ3EdqGVTWt2H0U7
         aPMm8gM3EPZr+WnMGc66W9a8Ir69ceWf9m0uLdbhV0iqmRcEfh/Su22WGENIPcfKB0B7
         Ur6jPmE2rCcNb6bvxVrnIG9XzTZkga7ukNdIGoG8aPz1rUCOc1ZX/a4y9EtDMSelwR6w
         iueugoGjhFyQT2/6vyGGWdwqcB+pydLnrYlaR18oYOmqhV8qQSw9R7+FDeXvtHO7bfe7
         v3X7QXNKPlE05rXIE2WGNA5MMqDU7hHwa2O5ovqSwoA54FybRUb0vj/2kSRpujSOCM/h
         u4UQ==
X-Gm-Message-State: AOAM5318kQ9Pi4iKTuoXr/4vFC3T9U2VE10XiReBFOEmKeeuUxV54Lh1
        fSXv63IZalKusBZ1zZInNyo=
X-Google-Smtp-Source: ABdhPJzZy8lYuF4Dnv8+CzgE9UBuWcfCF+6QoG4nD0xokbAAauobBpYUph+um4SOa4k7Kb6rNYcUlQ==
X-Received: by 2002:a05:6402:1bc1:: with SMTP id ch1mr11717034edb.142.1595837700542;
        Mon, 27 Jul 2020 01:15:00 -0700 (PDT)
Received: from kozik-lap ([194.230.155.213])
        by smtp.googlemail.com with ESMTPSA id g6sm6545579ejz.19.2020.07.27.01.14.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 Jul 2020 01:14:59 -0700 (PDT)
Date:   Mon, 27 Jul 2020 10:14:57 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Markus Mayer <mmayer@broadcom.com>,
        Roger Quadros <rogerq@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Kukjin Kim <kgene@kernel.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-pm@vger.kernel.org, Olof Johansson <olof@lixom.net>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 11/16] memory: brcmstb_dpfe: Fix language typo
Message-ID: <20200727081457.GA17644@kozik-lap>
References: <20200724182328.3348-1-krzk@kernel.org>
 <20200724182328.3348-12-krzk@kernel.org>
 <ca3f8dd3-7fc7-85dc-5656-e1e95302d501@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ca3f8dd3-7fc7-85dc-5656-e1e95302d501@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jul 24, 2020 at 11:38:57AM -0700, Florian Fainelli wrote:
> On 7/24/20 11:23 AM, Krzysztof Kozlowski wrote:
> > Fix firwmare -> firmware.
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> Acked-by: Florian Fainelli <f.fainelli@gmail.com>

Thanks!

Applied to drivers/memory tree.

Best regards,
Krzysztof

