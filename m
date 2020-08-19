Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ADC6249B3A
	for <lists+linux-pm@lfdr.de>; Wed, 19 Aug 2020 12:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbgHSKwh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 19 Aug 2020 06:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbgHSKwe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Aug 2020 06:52:34 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19446C061757
        for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2020 03:52:34 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id y3so21064757wrl.4
        for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2020 03:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=9gkmD+jt+NPPAfuqcUBQK91Aso2a4xO+LXFVwtygFxw=;
        b=mrDjElMbw8NA6E2pCjzZai3H8/y5gZFC3nyYQF7wTWfgpyCO5b/6UefVl+zv02OTnQ
         lY8s0IN3LajIpW38QnPEKKQfMM0SFOyRmS8TWkTYekNg6Ira5ebYJkV8vwwT3ldbp6wk
         QMDIhKTOHSFQk4ywhNRIsnmz49yfCLvYMPxH9+orJ97qoO85hU6nm9rMYp42fRuyVXnQ
         +ptOQyD80xQ7YOitH4RNSp0W/BMk/7D7ae7pAmcNlHXHk5Jvj+/wKOUD7LcY29PmUMEN
         MdQ16EDPWre8Ai4VcTDT2LWgCC6gRguYRDKKvJsU6PCTP5+IH1zZGe9qbpsbjueRbOGZ
         1Irw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=9gkmD+jt+NPPAfuqcUBQK91Aso2a4xO+LXFVwtygFxw=;
        b=flU2AQdAjDXC3m84JPXUtVJeiwpYXr38MVqUSOTd5aQ9K/yAGiY/Ub+GLEBPndrbnm
         pqF+SebSJy/cdwqrBNfsEftYTkOZt4sZ2Wk8fcwE2KZvv/hCzaEvEnzIT9rJx3Q9BXGw
         JcEldKh02m4B2EUHACHF8yaLg9Spq5eBuxzkI5+CLF1ARXf4WcbVVkYwabQ13Q6ktBWn
         2MixciRr4dejs1fSDJGkMc4/9g6GAwphJquS95x1w+6kYgnH+iSUUHmD7ay2c7qY2N3J
         RsRJMcYMEQ1ILOB/nx7MOQHZYPoThwfa/R1yIQ8Gz7IGZTBTeQp9GOWN+cEufKESKQhl
         YcIw==
X-Gm-Message-State: AOAM5322X5aCYsjzevqy5/1iU8k34lOs9wEKanX5YoqBNE/zCigsdjTL
        M8EQ8z1/yt07cVtcycESp4zZTw==
X-Google-Smtp-Source: ABdhPJwYp3v/FEV8ijzBdLsbUJihb8JD2xh0McefXGdZF4kT9nYWP0mx8pkRxosbgqVUJg9fNL7Kvg==
X-Received: by 2002:a5d:6284:: with SMTP id k4mr25824583wru.372.1597834352734;
        Wed, 19 Aug 2020 03:52:32 -0700 (PDT)
Received: from dell ([95.149.164.62])
        by smtp.gmail.com with ESMTPSA id u6sm34957125wrn.95.2020.08.19.03.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 03:52:30 -0700 (PDT)
Date:   Wed, 19 Aug 2020 11:52:23 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     sre@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, b.galvani@gmail.com, phh@phh.me,
        letux-kernel@openphoenux.org
Subject: Re: [PATCH 2/2] mfd: rn5t618: Add a power supply subdevice
Message-ID: <20200819105223.GB3248864@dell>
References: <20200815165610.10647-1-andreas@kemnade.info>
 <20200815165610.10647-3-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200815165610.10647-3-andreas@kemnade.info>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, 15 Aug 2020, Andreas Kemnade wrote:

> The RN5T618 and RC5T619 both have a charger and a fuel gauge, so add
> a subdevice for it. According to drivers in the wild, things
> should be at least similar, but since it is not tested, add it
> only to the RC5T619.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
>  drivers/mfd/rn5t618.c | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
