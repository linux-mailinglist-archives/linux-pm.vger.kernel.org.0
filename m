Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 643BC218178
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jul 2020 09:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbgGHHmS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Jul 2020 03:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbgGHHmR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Jul 2020 03:42:17 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AEBCC08C5DC;
        Wed,  8 Jul 2020 00:42:17 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id u25so26326464lfm.1;
        Wed, 08 Jul 2020 00:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UqAXpdSgwMr5Q0tv/rDA6Pc9wCXswpuopjQuL6uRINM=;
        b=Bu3mPkLEMaqO4Ao7xP8BUA3KUqBXVNmZAf4DE4ZuJCF3le9zlxBbYGTFVOnmd1L7Ge
         o3CuBI/Fg6pPzwYudny138p4gnQlfG0KKclS/FmeuUTLY/R+qoMao+9SOuNFo0QNclQd
         P+zZbAS+8yjyZIOh3DRV25W+BdU4NgFkun/+Jwn/Lesl1jTkRF//OtKfWpUa4MqRpWih
         H+fWTffi2g03HL9bc/yg+IJkYSzgMZ0nMQPXEhG/KRYTDi3NGh/AxEm8/2Jpbal+Ns0L
         SLjnf33opsSSexQOM9aZePS7vlI9Vv/rQXpI7902AczGGBemS+vROO8Bb38mewSEQKtF
         92VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UqAXpdSgwMr5Q0tv/rDA6Pc9wCXswpuopjQuL6uRINM=;
        b=jImctvpayxlDrOhbUrl6ogNO2kG5IUe8b2inAO54IYWq7tSGS+e0gBXwjNAvnGs6QR
         J7t24a5ost/IOkaPPa1wJSh92jDHiwQ0oAmUsBbpHhnZs0igSOhm49DWXxCx1+TcucLQ
         IKUedLtAYs1sClbo5l8ga4eBL/k7c8wozNnjRx1Iz0eptOqHGisaxiPV9fvnWB8J2ggp
         WLggMejsOLCfbMP/l5C4F8D9reMOetVPIxLUmLpIHl18cRFa5o8Rn+cvLZ5OFUqWPRH/
         FUOYNhIcTeKRCbMxeW9hgQLKF7lstNknK607E0moaaR/HlnnF3cM+zCeVUdH++lMpKYh
         Bj2A==
X-Gm-Message-State: AOAM530QidUVbsz1++fVgHy9jrE/8Qo3xyDF8IgU80DkKKFcCpVeAFTA
        sddaYecVjQJW7GGtlh3IUsQ=
X-Google-Smtp-Source: ABdhPJwWcVMnG0BK0zdFrpR01ehZhg+qE/pgvLQLB7GCjsQN9LYcX7Yc6M0UYTUGPwEweDgmhKgq+A==
X-Received: by 2002:a19:c4a:: with SMTP id 71mr35844362lfm.27.1594194135590;
        Wed, 08 Jul 2020 00:42:15 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-79-162-105.pppoe.mtu-net.ru. [91.79.162.105])
        by smtp.googlemail.com with ESMTPSA id v12sm10131186lfp.12.2020.07.08.00.42.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2020 00:42:15 -0700 (PDT)
Subject: Re: [PATCH v2 0/9] Summit SMB3xx driver & device-tree
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        David Heidelberg <david@ixit.cz>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Jonghwa Lee <jonghwa3.lee@samsung.com>,
        John Stultz <john.stultz@linaro.org>,
        Vinay Simha BN <simhavcs@gmail.com>
References: <20200607144113.10202-1-digetx@gmail.com>
Message-ID: <8480ea98-778e-d919-18e3-ab04609af914@gmail.com>
Date:   Wed, 8 Jul 2020 10:42:14 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200607144113.10202-1-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

07.06.2020 17:41, Dmitry Osipenko пишет:
> We gathered existing patches, fixed and improved what we could and
> final result is an working charging driver with device-tree support
> for Nexus 7.
> 
> At this moment charging works with:
>  - Nexus 7 2012 (grouper and tilapia)
>  - Nexus 7 2013 (flo and deb)
>  - ... and there are more devices equipped with these chargers.

Hello Sebastian and everyone!

Sebastian, do you have any comments to this series? Will be nice to get
some progress :)
