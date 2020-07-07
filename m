Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 354AA216808
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jul 2020 10:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728201AbgGGIMB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Jul 2020 04:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727886AbgGGIMB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Jul 2020 04:12:01 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D436FC08C5DF
        for <linux-pm@vger.kernel.org>; Tue,  7 Jul 2020 01:12:00 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id f7so41142030wrw.1
        for <linux-pm@vger.kernel.org>; Tue, 07 Jul 2020 01:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Om/XPTjADVYkykZwGGFhhFw2NeXXFx1YufzyiN0meo4=;
        b=xWrw+neGQIhWOVrb5t79sZctZYqc9AE6XcjS3FBux/54b/eC8cbjSLQa9KFB+RJg+N
         oaCg0wLHKYUfcIU74uKd1Z6XwHIUYbHhfptA7+xShXddi/Ml7/2Te9sIpB+4D7+r6Yo7
         6DPuwoU705hm0jcqPc9e0rVfcsfM6JViJXUwstRlgn6/F8/3MmIvbb+cru/4pJZB1fs+
         t337Iv9MFUTTi/uFZmfj9IGhxT/Boj8h++Y+dACbPar4QahxNUXg3Oe08NuM3/nAgF0Y
         xUw0b7ctgsWAE1vJPIZmYcW4Ca6lddpUTU5xa4tDiS5rj/VDWdAVANFajmNweEg45Lsr
         091g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Om/XPTjADVYkykZwGGFhhFw2NeXXFx1YufzyiN0meo4=;
        b=lIGzMcS74p4SD8J/CrXGyATo2ubuKciE9hze5qSJWe53UWFJrAV3/onSFmQ2EQeugn
         qvpkmS8x7I+8qh7Z40W4AVTnj9Qjund1h2X7Qzb68gmktpq65xVs+3RZZrQf6PZPgfr5
         uRBJUiRX0NeYbRS4AlHN9b0UlHJvN3Zbfyo2fhVPX9XS4UR/vyD9K3/wr2TvJbdTYSvB
         9H+8IFr4++ssV6qCK0i5DFWDjCsMhAwIbrsYS27xO2MjLdvyautqdkdNbH3r2z6OmCzm
         +DbIA2UmFRzxPm8SawXeMkzjlzwrg2Vc/QCdCmLpHAzMnW4/SIv39FkV2hIH+3nWhSGV
         VrUA==
X-Gm-Message-State: AOAM531C2ZhUyDHCwJJzUxGd5u4x+LOym7H5NVFc1QOkyzlEtwnKP6sM
        PtG+6cI1KRV3lBofdaJA5ng73w==
X-Google-Smtp-Source: ABdhPJyhQVBRWgi0ZALecoxb1nyzRu8gH7Pag6gT9p4aJ7+hhF2+R8SBeh7THJGM/p0LXX3DfDzelw==
X-Received: by 2002:adf:f082:: with SMTP id n2mr55669814wro.326.1594109519219;
        Tue, 07 Jul 2020 01:11:59 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:b4ff:29eb:619e:318? ([2a01:e34:ed2f:f020:b4ff:29eb:619e:318])
        by smtp.googlemail.com with ESMTPSA id u15sm29087207wrm.64.2020.07.07.01.11.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2020 01:11:58 -0700 (PDT)
Subject: Re: [v4,7/7] thermal: mediatek: use spinlock to protect PTPCORESEL
To:     Michael Kao <michael.kao@mediatek.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        srv_heupstream@mediatek.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Eduardo Valentin <edubezval@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-mediatek@lists.infradead.org, hsinyi@chromium.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        linux-arm-kernel@lists.infradead.org
References: <20200323121537.22697-1-michael.kao@mediatek.com>
 <20200323121537.22697-8-michael.kao@mediatek.com>
 <1afbf412-fbeb-8abe-66d8-bd7ac4e9dd83@linaro.org>
 <1591329023.12739.0.camel@mtksdccf07> <1594090621.20216.0.camel@mtksdccf07>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <e7a14d36-7bea-eb05-0573-66951b788e37@linaro.org>
Date:   Tue, 7 Jul 2020 10:11:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <1594090621.20216.0.camel@mtksdccf07>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 07/07/2020 04:57, Michael Kao wrote:

[ ... ]

> Gently ping.

Michael,

it is impossible to have this series merged if there is a so big delay
between the comments / questions and the answers (or no answers at all).



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
