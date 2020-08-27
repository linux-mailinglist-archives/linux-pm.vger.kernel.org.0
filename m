Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1B152545FB
	for <lists+linux-pm@lfdr.de>; Thu, 27 Aug 2020 15:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728374AbgH0Ncy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 Aug 2020 09:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728110AbgH0NcR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Aug 2020 09:32:17 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A681C061232
        for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2020 06:32:17 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id f7so5419888wrw.1
        for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2020 06:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:autocrypt:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CnBhoFWrprIDN00i9AYEpJ0QWAj8a6NyJSnQAwk3nKA=;
        b=bVAl9fYOg0wza5dd/3tsnmIXV42c6nLllLNKNTFK8PjWan+hZljgOF+GzgjWbmw7GO
         5wHgbTeo+R1TJnD4EdKyvTWm/6pWTDf6wuuIyllBCRwn85yFk6XJzpuZDvriihbyFd8b
         6TO336OedwDKN+td71Uk0A/l7KGkJmNqK/eCB/DpYDMVcTk/INOPrZjCyb6psMpSaFXF
         ycU3t8B+r2ryjj3NMZklGbquNyFKNn/byEEOcfiDNQDgM3+eLN0vdg5onuY0bGjDdS9V
         fOqq2o29rJUykd+ke34BnoiKhMxK5x8O0G4cQ01iE8HUgmr0MVzyAP9Ds/jRtnQsX+7l
         mQZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CnBhoFWrprIDN00i9AYEpJ0QWAj8a6NyJSnQAwk3nKA=;
        b=OMTvgMqYj67VFFK2kbMNjMauBTTU4BwFiXOn3gd9/uoc4QZEJ/B/edgP5JiDRfFfBA
         H3fz0G/81MbuI/5OTrn59R9aj4KlOepmIVpOJJwJwme9azyD2xxDkO5f5d4p/sEr4RyK
         HMJyKX1+TRbLOCd6R5olAthVUqns7+maA6g7ik1gbclAl6uNlQNSuXjLas8xNCosMl3A
         6ndRpvKpPG5an4Vk3c7muWvkLOlod3TaQA2nwk1CIa/G1Lj5eWPk7ItLcnrZWPCFoiwI
         zPdCrATfBTukmFtu0D3zWTc3jdy6zKe+WB43/IZPIAYvriWOtGTZ4hYYIpZR+DTpRIwb
         CswA==
X-Gm-Message-State: AOAM5332JTNU5Bqic3WxeNVv1RolZvDXiNChi2qLDjKBoIPk3/KMbu/X
        n1PEwdaWBCCsILWisQCeY4ljl1JDdHt98Q==
X-Google-Smtp-Source: ABdhPJzghwmF7BWi41naSgeIRR+oSU925DS1i8kyQhq5YclNstFArZhHJGZY3RCecBjbuL+khXKqXw==
X-Received: by 2002:a5d:4701:: with SMTP id y1mr21181346wrq.416.1598535135779;
        Thu, 27 Aug 2020 06:32:15 -0700 (PDT)
Received: from [10.44.66.8] ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id g14sm4873096wmk.37.2020.08.27.06.32.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2020 06:32:14 -0700 (PDT)
Subject: Re: [PATCH] interconnect: Show bandwidth for disabled paths as zero
 in debugfs
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Evan Green <evgreen@chromium.org>,
        Douglas Anderson <dianders@chromium.org>
References: <20200729104933.1.If8e80e4c0c7ddf99056f6e726e59505ed4e127f3@changeid>
 <20200825000846.GC486007@google.com>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Autocrypt: addr=georgi.djakov@linaro.org; prefer-encrypt=mutual; keydata=
 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
 KEmKjLDvB0pePJkdTw==
Message-ID: <ef2fa54c-7a20-8d3a-67d2-b26f70ac80c1@linaro.org>
Date:   Thu, 27 Aug 2020 16:32:14 +0300
MIME-Version: 1.0
In-Reply-To: <20200825000846.GC486007@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Matthias,

Thanks for the patch!

On 8/25/20 03:08, Matthias Kaehlcke wrote:
> On Wed, Jul 29, 2020 at 10:50:12AM -0700, Matthias Kaehlcke wrote:
>> For disabled paths the 'interconnect_summary' in debugfs currently shows
>> the orginally requested bandwidths. This is confusing, since the bandwidth
>> requests aren't active. Instead show the bandwidths for disabled
>> paths/requests as zero.
>>
>> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> 
> ping, any comments on this?
> 

Looks good to me! Just in case, I'll also add:
Fixes: 7d374b209083 ("interconnect: Add helpers for enabling/disabling a path")

Thanks,
Georgi
