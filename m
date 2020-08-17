Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCE62247204
	for <lists+linux-pm@lfdr.de>; Mon, 17 Aug 2020 20:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391368AbgHQSgp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 17 Aug 2020 14:36:45 -0400
Received: from mail-ej1-f43.google.com ([209.85.218.43]:44487 "EHLO
        mail-ej1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391362AbgHQSgm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 Aug 2020 14:36:42 -0400
Received: by mail-ej1-f43.google.com with SMTP id bo3so18925574ejb.11;
        Mon, 17 Aug 2020 11:36:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=w4avb5XD1N6bs6gwuW3db4QCXTxFoO49CBCvweYnBUM=;
        b=l04tDjWgYtlWfOWr+S6S3GyVGq1ufh9Z7kiJfAQZvAPwlsgUhOT6JhgpFGsVfPatpE
         upoWfQTW4/SJuzYOVmdKoxP+lYDXY8/Sg2TjDN1F0kD4lpAxXXno6wT7r0XiXJOSkgN7
         MNIAM/tuXq1AeLhN+UvWl12LEVBeYaIIr+1HolyF3/iZ/9jM/rDb6OkKMJWAqwXb83KW
         BGiCF3xo3HTjcDw+/e5k0+bJGIrzTPQPMIO5gkkLDEvfr6KEmSGzbzaIUnpHLVyES9Jm
         kvUKfST/2E5fHibEZzVuT4hORKSakgSiRbDBJuqwBsdw8UrFPDStIpe+nVStrjCIaEcL
         zQbA==
X-Gm-Message-State: AOAM531DXcAbZipQ5o0GvLBmzNKsG6H9Ivkkve/VpiFuKUsvaDfixUtT
        yYGxqVb5URtuz03lkq6Oun4=
X-Google-Smtp-Source: ABdhPJwXdYPrnnml9V9iJJthvNLmgucp4z6ahCb2RPLRjcr+hstD10uoSo1B39MitlYHVzGFOQFeog==
X-Received: by 2002:a17:906:1396:: with SMTP id f22mr16050829ejc.227.1597689399902;
        Mon, 17 Aug 2020 11:36:39 -0700 (PDT)
Received: from kozik-lap ([194.230.155.216])
        by smtp.googlemail.com with ESMTPSA id d2sm14871625ejm.19.2020.08.17.11.36.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Aug 2020 11:36:39 -0700 (PDT)
Date:   Mon, 17 Aug 2020 20:36:36 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
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
        linux-pm@vger.kernel.org
Cc:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFT 08/16] memory: omap-gpmc: Use WARN() instead of BUG() on
 wrong free
Message-ID: <20200817183636.GG3464@kozik-lap>
References: <20200724182328.3348-1-krzk@kernel.org>
 <20200724182328.3348-9-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200724182328.3348-9-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jul 24, 2020 at 08:23:20PM +0200, Krzysztof Kozlowski wrote:
> Since driver tracks reserved memory, freeing a non-reserved GPMC should
> not be fatal and crash the system.  Printing a warning is friendlier.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> ---
> 
> Not tested on HW.
> ---
>  drivers/memory/omap-gpmc.c | 3 +--

Applied.

Best regards,
Krzysztof

