Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 219227378D
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jul 2019 21:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728915AbfGXTOV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Wed, 24 Jul 2019 15:14:21 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52777 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726430AbfGXTOV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Jul 2019 15:14:21 -0400
Received: by mail-wm1-f67.google.com with SMTP id s3so42779962wms.2;
        Wed, 24 Jul 2019 12:14:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=+dgR7D/EXKyMHjC4KOvCZR7USJlIlrVgRqVtNiYm68A=;
        b=eCu7trHBlB2LOcMmTpoOt5Rocl4eYwi2sKmw3S29EziTNsVfhDsqDIl8m7NS55/hzt
         IynheOuSDWhfwNefZn0VCmq1yWOpwWZLnQBVgBSrfqVyPVB9fxGgRf/wvn4sQ+4NgyG0
         U2Eg+tApcDks5OTLZ0I+uCX04odB224CUFj2SPK0Xnwi3iBKCTgJPbPHcszzzAMBpm/P
         Vbi5RhCP9YzW0MZC6CtAkV6tl1i3Fh4UcCF9tcaZMSUUvvtYvJHv/m3LZ71k+CC9OgZu
         Rx3mwj9tQtF9A4oUCErpy+EjnV2l4adrzyO8YgHIKU8ogHVW9YmgLKVUs8X9nAml5eOs
         bamQ==
X-Gm-Message-State: APjAAAWKqudN6GbYHsn15NCl68FMAq5LIHq7MN6iq+zSzDd3/ZitwbIH
        0ciIkF85ekkOIJJm11YEaD+rGxM4
X-Google-Smtp-Source: APXvYqxr0ifyhVtp91zsXaTGdqxuq3wdKwgnKuWnLCyxSECwcySUMHL3yuZ93uJZ/W8HD1t2wKkzTw==
X-Received: by 2002:a1c:a186:: with SMTP id k128mr69920564wme.74.1563995658727;
        Wed, 24 Jul 2019 12:14:18 -0700 (PDT)
Received: from kozik-lap ([194.230.155.239])
        by smtp.googlemail.com with ESMTPSA id p6sm50559987wrq.97.2019.07.24.12.14.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Jul 2019 12:14:17 -0700 (PDT)
Date:   Wed, 24 Jul 2019 21:14:15 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Artur =?utf-8?B?xZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        cw00.choi@samsung.com, myungjoo.ham@samsung.com,
        inki.dae@samsung.com, sw0312.kim@samsung.com,
        georgi.djakov@linaro.org, m.szyprowski@samsung.com
Subject: Re: [RFC PATCH 04/11] devfreq: exynos-bus: Clean up code
Message-ID: <20190724191415.GG14346@kozik-lap>
References: <20190723122016.30279-1-a.swigon@partner.samsung.com>
 <CGME20190723122024eucas1p25a480ccddaa69ee1d0f1a07960ca3f22@eucas1p2.samsung.com>
 <20190723122016.30279-5-a.swigon@partner.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20190723122016.30279-5-a.swigon@partner.samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jul 23, 2019 at 02:20:09PM +0200, Artur Świgoń wrote:
> This patch adds minor improvements to the exynos-bus driver.
> 
> Signed-off-by: Artur Świgoń <a.swigon@partner.samsung.com>
> ---
>  drivers/devfreq/exynos-bus.c | 49 ++++++++++++++++--------------------
>  1 file changed, 22 insertions(+), 27 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof

