Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8649C3EDA08
	for <lists+linux-pm@lfdr.de>; Mon, 16 Aug 2021 17:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232884AbhHPPjr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Aug 2021 11:39:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236748AbhHPPjo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Aug 2021 11:39:44 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 384AAC061764;
        Mon, 16 Aug 2021 08:39:12 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id t9so35324399lfc.6;
        Mon, 16 Aug 2021 08:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gLw/kz93BHvFOsj+m2S5uBMIvOyyukhUjyEmSfNHvuQ=;
        b=UMbCMbBAwfuhjpCWl3t3Ll9mbF30yfBmsWphmS8+Ta98tmTqcWfC3Kq3JLHDi27ooV
         brfx16+Ulv155VrOnXNNdPkQfSgnF+OnEn1WTwP8OJmzDesZCWsHzL7piNnAFEEYZdf7
         mHlSFzyrXAXkP2MShRWUTO5BJqbgO1MdXO8Fqmbu0wTQKIxUoc1np6yUAG3yXj1d26kh
         OYXpfEPxi5kVfmL8CQEx8plzuW5ljp9shETvG6dBJIEKqp+4LkIk26E8f+njntx77sS4
         kZpON449jbp76ErTRQcGQr8URpo71gITZmwKYhs+HShcDRSNO2m4jNimkU+uIiuqQLZQ
         wQmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gLw/kz93BHvFOsj+m2S5uBMIvOyyukhUjyEmSfNHvuQ=;
        b=n3ndcUhWtqlVSAGEx6QIj4p1pgSQ9loJ7WmNmSFpw8N/pFnM+w0Rhy+SsVUnt4JuCH
         1VBj6u+wyOCSKvnByD9ewUx/DeCqAYKESehv/lOk27aGbnJcqK/k/xCmhoAdnbAWctPi
         y55t2sn58j5CH2Q6SiEk3qHRggIH7wDF3DEHqwErb4NLFX6Cf9hJB0ZCJI+MJ4VJZqAJ
         rTtsgbNlkof1hUUIlbkCCuXjZeTCpRccv1+TeOhQraQ6fJKSw5GtecCogLLN4vcwjYmu
         kfdfuPGAocOOaWyDI6HRv1FjcciRNWVf7qABAbgSS8OQ4NCKAqbsY7eOQziPh8yUlXqK
         zpgQ==
X-Gm-Message-State: AOAM530YA3FoxgInhPjFgNBNHWXZhj5KmI2O1sZW5Qhbs/hyUEZElveC
        3vk0sUXd3RZXdXRWp67udQZbIjBIcuQ=
X-Google-Smtp-Source: ABdhPJyrmXfhpLAU/KOQY7BsiWYzn8V0yz6Jvc7+AAr/u2dCgesHtuftJ2Z/t8Wf7npnSqjRxWOnSQ==
X-Received: by 2002:a19:c7d4:: with SMTP id x203mr12095093lff.575.1629128350477;
        Mon, 16 Aug 2021 08:39:10 -0700 (PDT)
Received: from [192.168.2.145] (46-138-85-91.dynamic.spd-mgts.ru. [46.138.85.91])
        by smtp.googlemail.com with ESMTPSA id k12sm641889ljm.65.2021.08.16.08.39.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Aug 2021 08:39:10 -0700 (PDT)
Subject: Re: [PATCH v6 05/12] dt-bindings: power: supply: smb347-charger:
 Document USB VBUS regulator
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Peter Chen <peter.chen@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        David Heidelberg <david@ixit.cz>, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20210731173842.19643-1-digetx@gmail.com>
 <20210731173842.19643-6-digetx@gmail.com>
 <20210806211314.sfjl5jke27hz3jj7@earth.universe>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <dce19bb0-216e-bcd7-3db5-b2c074b4ca47@gmail.com>
Date:   Mon, 16 Aug 2021 18:39:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210806211314.sfjl5jke27hz3jj7@earth.universe>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

07.08.2021 00:13, Sebastian Reichel пишет:
> Hi,
> 
> On Sat, Jul 31, 2021 at 08:38:35PM +0300, Dmitry Osipenko wrote:
>> SMB347 can supply power to USB VBUS, which is required by OTG-cable
>> devices that want to switch USB port into the host mode. Add USB VBUS
>> regulator properties.
>>
>> Reviewed-by: Rob Herring <robh@kernel.org>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
> 
> Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Sebastian, you can pick up these patches into the power tree:

dt-bindings: power: supply: smb347-charger: Document USB VBUS
regulator
power: supply: smb347-charger: Make smb347_set_writable() IRQ-safe
power: supply: smb347-charger: Utilize generic regmap caching
power: supply: smb347-charger: Add missing pin control activation
power: supply: smb347-charger: Implement USB VBUS regulator

The reset of the patches could go via the Tegra tree. It's probably a
bit too late for the Tegra patches since Thierry already made 5.15 PR,
but should be fine for the power. Thanks in advance!
