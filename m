Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 573F33B662E
	for <lists+linux-pm@lfdr.de>; Mon, 28 Jun 2021 17:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234283AbhF1Pyr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Jun 2021 11:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236982AbhF1PyS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Jun 2021 11:54:18 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0175C09CDE7
        for <linux-pm@vger.kernel.org>; Mon, 28 Jun 2021 08:38:22 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id r3so7250589wmq.1
        for <linux-pm@vger.kernel.org>; Mon, 28 Jun 2021 08:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4JaQqvoR+0f2Sh2zrstf6yPCyntyADWYeNdjvtHLij8=;
        b=c5xC4O2gzmT8kiPNdVZtcIyKFj2dtP0Kw3VkhUSA1SlC3B89ZfhSnIf4I2fVKDvxHl
         4cjB77Ug+GRxMI3yG8r9q3vj49dyJntVgmYPBK4wFCMPoguBewEX27uhpv1BdCN0ggDw
         MfBAp+cPreX2UHW/D5AvKoN/19EQgHg1OSFqUo8ELBGiI00TnqyHC6tZtHaME7A9CLIF
         TDZrRo57qxDPAjCbyDIdbc//FYLIQtpN6nuJBbRArPQOwC3ex/xtRtkR+SunR0Zdr06w
         FT9oUUY6Ho+O5uTzFpQjm5bYmWAQ0UlOGzedfm00G8bc+Is3uLeFvMVDUv/xZLwrAjwN
         VEtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4JaQqvoR+0f2Sh2zrstf6yPCyntyADWYeNdjvtHLij8=;
        b=Il6JcB4t4xhzyTsEXNHgIzBJ/+kXNi/QLKMCERhw4MjXwRvfeHL1G3HwazRssy+0to
         BDjIyADAYHVz/Ltrokbv4KwcuzQxgflFtR/DmOp31a/6AT9zWpr54u1d9ytYfdzDUJsS
         7JU5rMqdqqQlvJ770ueSEQ+5wq+0sF5z5PgkywvUE7t9AfKttsFxMdRw5P45vETU9FWG
         vBQ7Eo44FkVyzqyeN7WdwYsrjpX9L98sxu7SNJsMqNLCRcPs54HIOL0lliWdQF2++wY1
         ybyuydgQ6Szofoe9QpTOpFxkgyeWIWjkk+93JUpmgBH8/aeGzZFMdq5HANBn8YFQdtNr
         39SA==
X-Gm-Message-State: AOAM533PVktEtmIN2Z2hyZ9G4KWTOxkrVMG0aw38Mb9XxqYCUWCwOGTF
        HeBO7RaFigVqxxBYXa2t1OWz9Q==
X-Google-Smtp-Source: ABdhPJy5S03IXoODGLADcWPT9mB85Cqt9LLwCy+impxfJlWAc+wlKP6dltP61XPzG97lnieMZPl08Q==
X-Received: by 2002:a1c:ac87:: with SMTP id v129mr28215948wme.45.1624894701198;
        Mon, 28 Jun 2021 08:38:21 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:c9b2:a9e9:8b67:65fc? ([2a01:e34:ed2f:f020:c9b2:a9e9:8b67:65fc])
        by smtp.googlemail.com with ESMTPSA id h10sm15414567wmq.0.2021.06.28.08.38.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jun 2021 08:38:20 -0700 (PDT)
Subject: Re: Aw: Re: [PATCH v4] thermal: mediatek: add sensors-support
To:     Frank Wunderlich <frank-w@public-files.de>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Frank Wunderlich <linux@fw-web.de>,
        linux-mediatek@lists.infradead.org,
        Amit Kucheria <amitk@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210608154530.70074-1-linux@fw-web.de>
 <9eb45f06-1303-1438-7ba0-b9ccaa898b34@gmail.com>
 <trinity-de0268f6-e2f2-4ce9-abdd-8016c593894c-1624874759475@3c-app-gmx-bs72>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <0ff513a4-a419-ea47-4b44-9034f538c633@linaro.org>
Date:   Mon, 28 Jun 2021 17:38:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <trinity-de0268f6-e2f2-4ce9-abdd-8016c593894c-1624874759475@3c-app-gmx-bs72>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 28/06/2021 12:05, Frank Wunderlich wrote:
> Hi,
> 
> A gentle ping as it is reviewed but not yet visible in thermal tree [1] i guess it should do,right?
> 

Right, I thought I took it.

Fixed, thanks for the heads up.


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
