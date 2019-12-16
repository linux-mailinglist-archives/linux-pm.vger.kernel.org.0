Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 991211202E4
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2019 11:49:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727527AbfLPKr0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Dec 2019 05:47:26 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39367 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727501AbfLPKr0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Dec 2019 05:47:26 -0500
Received: by mail-wm1-f65.google.com with SMTP id b72so4125515wme.4
        for <linux-pm@vger.kernel.org>; Mon, 16 Dec 2019 02:47:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ZGx3tMIAXh3e/jErEj3mGjKXeLEgC7vtrPLTzgdf8RI=;
        b=exuPW0UOilBqSGIgd1GEmKBKjaCM6C7IqNc5ARGzMvdH+2VKEGi4kCAYsRLH5x5ln7
         muPuiE+DqbobB47BrGIWsTYD8ELklZ8V16TN8er5Xm6cvN43NgG2VQqbi+Nlheayyss0
         YBRLlxs8sEaw7AuKMh0YcXZ8gX0Og6DYxUVo/w0QXBK5o0HJ32zDIxZcvvYmYa5qYEnC
         v7loC741CYlgWr/spE9TJxpKmJQOnI3c3zsuJNjJQWvfKi4zKDXu3pIhnWeJTYAsuDNm
         jxt2qOd2vBEe7TSB9OweQ/kab2YiqYzYt60WXR3qIcIujgTJouMLTC6OP7Ew8l9vh9Ad
         aBIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ZGx3tMIAXh3e/jErEj3mGjKXeLEgC7vtrPLTzgdf8RI=;
        b=qRqscuxH0cp6jjCUsLzqnqnENzP2LIog+hDyoLMD1oA9vNSVxV6I/4Pr0tiweJTU/6
         rSJISh1nfjlGxRsFcFRVXgdhUcjiYPS4dSoTQx6x7dX+zPE4W7Np736aSIYAyxuwMUds
         WgFVDq0vWgNXN0+Fe7P4McwMn+VZNYDZV14Ta9B8mWUjDYuc9x8lZZPiXJK8vD8Ct1mB
         cG8LTaDC1ZtKRI2OFtFkYRR4qTICyGSvjRQzNYp6mt1uhThuNWB8jHlIeTBRWlzgWsMe
         Ih3Jcx8F055UfvuKYu2KtXwQldqKXI3IlIpOxxNkf+ACeZTyWNRkJZiSVPluLTEwfiwm
         wfRA==
X-Gm-Message-State: APjAAAXx2YrB7xemL3Jyc+TiGR+iqyhPV+3NWu/29EE/0PIZPcMGvUDY
        E5RvpocpH/ZId1T45kqTL/39HA==
X-Google-Smtp-Source: APXvYqwPxdSUxsc3QRujG1tAM8/rOSnkzPzMmIUqZawkxN8jwdGWvT5xmNwUIBP45uIeoMFRuQM1tg==
X-Received: by 2002:a1c:7715:: with SMTP id t21mr29005012wmi.149.1576493244116;
        Mon, 16 Dec 2019 02:47:24 -0800 (PST)
Received: from dell ([2.27.35.132])
        by smtp.gmail.com with ESMTPSA id n1sm20959404wrw.52.2019.12.16.02.47.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 02:47:23 -0800 (PST)
Date:   Mon, 16 Dec 2019 10:47:23 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Matheus Castello <matheus@castello.eng.br>
Cc:     sre@kernel.org, krzk@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, cw00.choi@samsung.com,
        b.zolnierkie@samsung.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v8 3/5] devicetree: mfd: max14577: Add reference to
 max14040_battery.txt descriptions
Message-ID: <20191216104723.GG3601@dell>
References: <20191205154410.29462-1-matheus@castello.eng.br>
 <20191205154410.29462-4-matheus@castello.eng.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191205154410.29462-4-matheus@castello.eng.br>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 05 Dec 2019, Matheus Castello wrote:

> max77836 MFD has a fuel gauge that has a low SOC alert feature that is
> described in Documentation/devicetree/bindings/power/supply/max17040_battery.txt.
> Adding the reference to de documentation here.
> 
> Signed-off-by: Matheus Castello <matheus@castello.eng.br>
> Acked-by: Lee Jones <lee.jones@linaro.org>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/mfd/max14577.txt | 2 ++
>  1 file changed, 2 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
