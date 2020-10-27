Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3469929A6ED
	for <lists+linux-pm@lfdr.de>; Tue, 27 Oct 2020 09:50:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2509470AbgJ0Iuk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Oct 2020 04:50:40 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44278 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2509350AbgJ0Iu0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Oct 2020 04:50:26 -0400
Received: by mail-wr1-f68.google.com with SMTP id t9so882074wrq.11
        for <linux-pm@vger.kernel.org>; Tue, 27 Oct 2020 01:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7To5fR7Q9UAxOnsymTWEk2T2/isEIEenNe0vcod1MTQ=;
        b=FrVGJAASwgGOHLjXsVS+TDlkp2LPHGEzVqVnlxcTjSD/cr6nN5p7or5UypZO6DinI6
         A8By5nb9orQHmknCoIS7/rVHrTn1/1O/TCZxGA15rZ3drA8crrQEd5Y7MP5XcOF9A6i7
         13+dhBlEA4TVsjMhCjwNYEmfMaXJSuHVHqmbuRplFQ8b5qDI+ffJ+AaGoGHLYUFuXWkW
         asWgirT7AhBXnV59TcXJJ8EHqi2N7OydsrDG1qmkPgsbfD3pkXGHepUiUowN8PUqthat
         +GYZwye0qXh/u1xBzGoTbXMLrOQYiJP1EXlMpQChn9MUAfxETVk+Jlu84RJh84528TW5
         sxmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7To5fR7Q9UAxOnsymTWEk2T2/isEIEenNe0vcod1MTQ=;
        b=j+o7oRXRiwCqfLXOCF9maOkdmzHoA/lTRrIMzRbR/jBh/DXQdOzSNuEWNU5RXeDGcg
         H/uHJtX34wVld+zoZlkT1uCWaM5cRmam9dBse2gRr4blAb6Knqos3Ke8C82HuAQwP4FR
         WK6xh7+Q2fJLq+unRsTyfEhC/GHnL5gtok462w2ucgAV930keCinbXyvogKdFbCf+C4H
         G3CmnJCwBmSjTYtWa7RivBJCuf2pIOw0dIPnDzg7YM+bEbzUI2helminmOH474p/CRBr
         WgOyt2oF72VTu+B8S+Jo582XBQJ9GKttE93yxE1qisLwND73d9oREw6GvZH+xJ9iq8FZ
         qGzw==
X-Gm-Message-State: AOAM531YARCjWRub6GevRL4/1csjyVsNquvKgf5RIVksvtCjzBNGoJCj
        YDOK4Jj8kGgx+xd6OkmjD0Q5Gg==
X-Google-Smtp-Source: ABdhPJzPfN26xhtrp7ZCg5xkLG2vH8Zt33AKBxdQuOt3lywV6PI43r3anfW88dN/8XCOlUjPjlvJ3w==
X-Received: by 2002:adf:81e5:: with SMTP id 92mr1469248wra.411.1603788623417;
        Tue, 27 Oct 2020 01:50:23 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:6cbc:1a3:aabd:d451? ([2a01:e34:ed2f:f020:6cbc:1a3:aabd:d451])
        by smtp.googlemail.com with ESMTPSA id 71sm1124828wrm.20.2020.10.27.01.50.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2020 01:50:22 -0700 (PDT)
Subject: Re: [PATCH v2] drivers/thermal: optimize the for circle to run a bit
 fast
To:     Bernard Zhao <bernard@vivo.com>, Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com
References: <20201027013743.62392-1-bernard@vivo.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <15cc88a3-9a96-c7a8-a9e0-375578de4305@linaro.org>
Date:   Tue, 27 Oct 2020 09:50:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201027013743.62392-1-bernard@vivo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 27/10/2020 02:37, Bernard Zhao wrote:
> Function thermal_zone_device_register, in the for circle, if the
> first if branch set the count bit in tz->trips_disabled, there is
> no need to set in the other if branch again.
> This change is to make the code run a bit fast and readable.
> 
> Signed-off-by: Bernard Zhao <bernard@vivo.com>
> 
> Changes since V1:
> *make the code more clear and readable
> 
> Link for V1:
> *https://lore.kernel.org/patchwork/patch/1324507/

When adding a changelog, add it after the signed off separated with a
'---' symbol. So when commiting the patch, the changelog is discarded.


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
