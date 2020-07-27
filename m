Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9D4922E74B
	for <lists+linux-pm@lfdr.de>; Mon, 27 Jul 2020 10:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbgG0IJ1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Jul 2020 04:09:27 -0400
Received: from mail-ej1-f66.google.com ([209.85.218.66]:44832 "EHLO
        mail-ej1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbgG0IJ1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Jul 2020 04:09:27 -0400
Received: by mail-ej1-f66.google.com with SMTP id dk23so4232824ejb.11;
        Mon, 27 Jul 2020 01:09:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hKkmbibPaaHyRRuXyUfERlU7BOY1YF76J3mADSkmBJI=;
        b=V/bgkBXjr+/0E7EMcWPZTOxh+cr//Zq3EHVT8kZVi9ctW9jhjDidkShwmG7PA4w0Tw
         LO0qV5gOAfU8VGfS2a+C/TXEk7+OeP3/BCqUP+/3cNYXz+61tZ+iMPCzQhXZkQUFHx0p
         Am5DF5RURPP8L7WOuwVMVI+4HiFq0SozjE0OiUTuw73anoUTgrJnScSSgVzEAne3rsqw
         0N9JwckAL4DtXGx4M42lTPHRbFIbVUDxTMaHvBTc2mOfq+FfZfPaVCWFujRhCQDZkS/G
         bU9UM/pZa/qGxICgNqhDQjBO/Ucfgxi/Z6JNSSRuEHcBQ+MGztUrGlxDQ6iljF6TD985
         Fatg==
X-Gm-Message-State: AOAM533af+T2hOpl1SiTpuG7lA3i6B2WtmzkbvgfOmS3JCr/vbWU9SoL
        zQjTwTF9e9fqx28O7CuynK8=
X-Google-Smtp-Source: ABdhPJx9eLbrDIcbXbnQwv52xfDW9/pKccXusKjWlVpgQW8jvx+LdTDi/Zg9iyuhBC6wogl+k+76jA==
X-Received: by 2002:a17:906:7f05:: with SMTP id d5mr2430608ejr.122.1595837365080;
        Mon, 27 Jul 2020 01:09:25 -0700 (PDT)
Received: from kozik-lap ([194.230.155.213])
        by smtp.googlemail.com with ESMTPSA id mf17sm2953883ejb.56.2020.07.27.01.09.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 Jul 2020 01:09:24 -0700 (PDT)
Date:   Mon, 27 Jul 2020 10:09:21 +0200
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
Subject: Re: [PATCH 14/16] memory: pl172: Enclose macro argument usage in
 parenthesis
Message-ID: <20200727080921.GA29255@kozik-lap>
References: <20200724182328.3348-1-krzk@kernel.org>
 <20200724182328.3348-15-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200724182328.3348-15-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jul 24, 2020 at 08:23:26PM +0200, Krzysztof Kozlowski wrote:
> Macros arguments should be enclosed by parenthesis for safety.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/memory/pl172.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)

Applied to drivers/memory tree.

Best regards,
Krzysztof
