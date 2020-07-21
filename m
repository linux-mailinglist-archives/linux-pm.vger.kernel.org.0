Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADB982280B7
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jul 2020 15:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728550AbgGUNN5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 21 Jul 2020 09:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727957AbgGUNN5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 Jul 2020 09:13:57 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2C31C0619DB
        for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2020 06:13:56 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id o11so21161531wrv.9
        for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2020 06:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6cyLMOSBZeL+BpGOPZ4KnMd993F4LhWCmpRnBNnGfbE=;
        b=pLrzDAuE9wXfoBg5tbB9EnQhEkgxhH8oujCWqkPZ7yPs1YY1iIAN3Htmby+FaeSNto
         I0AsSJQSA14mKVeuZwpaosXjYyNdgjtE5Md2vtVDzF5SPMVyAKGYNQ4PIOHEG3MPgF6A
         mZOW0+Bb5/X/p5NPn/GLaSwX82VnAeWXT8ZAGshNALVq1M3MvLoGZdddDwhJKJLFl+00
         +i5Z5m8Zht+mRlzpG/0R25tzgs57MBR3QTMoD3UNlkFRi4PqhEkOMLhM2Mt5uL0O/ne2
         M8FbFkGM0/NmhmKmCJwLFVHma6/oaFG80Y2XNLp4WcctcPX9+M7x/KrMfslAWLgEGoHR
         RJ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6cyLMOSBZeL+BpGOPZ4KnMd993F4LhWCmpRnBNnGfbE=;
        b=QrWMr9EcbgDydmdj1fnc+4IhaCFDcfxXbwz2odS3WuyJ9iQkYE7HtHizAFENU0V6X8
         8HAuPVcfKULk/K0yZqtoet2yPAou7BgtHS9jbFoiAeTDMAfy7k+E2sRA+2f/qsIao+TA
         SCjoJ+k2tvuXT+UqXMguxfaggszL5nfr3wMeObzL53lnmOha8CuO5xraJDJ+b6DYmFud
         SfSQ28AkxYhRCHU2BfLm2DfCMHl5bDJsP/FPSOIUS2MA6f8Vhaj9yov3IuL6W+HOeAtm
         dciTRttWNUPSBzgZlvJD67KtrYtg37dplYkJUpasRYpTZEHFZy8pUgPZX12tQgDed8ej
         mXMA==
X-Gm-Message-State: AOAM532ap9eruUG/P0MdPVduZcVkeTMQuTuPw8eM+kr1ZTxavQnQzyEm
        rmB+FmkMwgK0SkrocBCCxJn+zw==
X-Google-Smtp-Source: ABdhPJxx0VQc6B7QNxyrz8xAMr6fQIOSIIeCGxhOqrMXIku3RHo9gn7vVbH1A4tXfP0uGL/ot16u8A==
X-Received: by 2002:a5d:65cd:: with SMTP id e13mr28879567wrw.213.1595337235242;
        Tue, 21 Jul 2020 06:13:55 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:c144:5385:c824:85ce? ([2a01:e34:ed2f:f020:c144:5385:c824:85ce])
        by smtp.googlemail.com with ESMTPSA id m2sm3516167wmg.0.2020.07.21.06.13.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2020 06:13:54 -0700 (PDT)
Subject: Re: [PATCH] thermal: ti-soc-thermal: Fix reversed condition in
 ti_thermal_expose_sensor()
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Keerthy <j-keerthy@ti.com>, Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-pm@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20200616091949.GA11940@mwanda>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <145478f0-3db1-4121-ad7c-78bc67a69c66@linaro.org>
Date:   Tue, 21 Jul 2020 15:13:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200616091949.GA11940@mwanda>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 16/06/2020 11:19, Dan Carpenter wrote:
> This condition is reversed and will cause breakage.
> 
> Fixes: 7440f518dad9 ("thermal/drivers/ti-soc-thermal: Avoid dereferencing ERR_PTR")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
 Applied.


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
