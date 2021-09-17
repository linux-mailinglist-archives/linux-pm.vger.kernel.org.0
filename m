Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76AD540F9E0
	for <lists+linux-pm@lfdr.de>; Fri, 17 Sep 2021 16:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235063AbhIQOFB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 17 Sep 2021 10:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234664AbhIQOFB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Sep 2021 10:05:01 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A85C061764
        for <linux-pm@vger.kernel.org>; Fri, 17 Sep 2021 07:03:38 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id i23so15411706wrb.2
        for <linux-pm@vger.kernel.org>; Fri, 17 Sep 2021 07:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cElMJoeY5hvMr2V5LH+iZNPc0N3os4Ky0d4P23ZLkkE=;
        b=yxWaRcX1qbRGyttjQa1Pu6jM/hec9mQl0xer5eL4GeQQ+1dn6FvLc3GE/Pvl8V6pyo
         iOdk9dhgRd02eOwh+gf99oJvQfM0aFqME0t+6q3X9518yk07+yHUqNIbfKmV1/NNbAWF
         ayqthRKvn7hrFvlohYQuI++mvYKeLN/1WbP7vuq0nsQuLxJRfvFsF7BlW9muZxjzBwhs
         R1dMP5fTeosIQWA1nXAD/D/YMxHCKisgTYgY6M93GMj7JhbnE6WTr/MijVnMdCoWiIfC
         wLY9bhR8R09535t3WNqUNITU3Sy7C6jr2QyEzxLTvENgyP+QJvlctIzdasUGkxdzjUur
         7QhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cElMJoeY5hvMr2V5LH+iZNPc0N3os4Ky0d4P23ZLkkE=;
        b=OrFVpPuRt0u/zR2bRwc1myFvw1FDt8e7N8dz9njGO0XNxT5itT5O00biri1Pc8X5vq
         aFAsJLz2SNbW8Joul2q4Hi0PRRE1QRpbeClBwYj5GAnGzGalJ+kbMS9ZFQm5R7U3y0qO
         /kK4u4xgcJMN7QleyIjpRaBIExYgUOLlrwZQgRJKI2AKFmH/3ISC6/KEXX/mCqEFMcb5
         FGyBnztEIb0umwZpZ+lmF9wXGPCvBL4IWiwSCBs4aUhbr83pPAiV3gAxIkGh+/zLUQk4
         mRV5Q6jGYgEpf4gFSeoh4risor7bFERTxq8PbLYGMYlyzfAfqSbZ2Y8VGQa17pwrcDCr
         I99Q==
X-Gm-Message-State: AOAM530Km0gu3cYWAi0cMzhDPBQPhLCs2/YtjZO9UBsRLbAtTnsAw/I7
        kWZzWq2LOA3W2zcCfqwiKiV4Gw==
X-Google-Smtp-Source: ABdhPJyJCWGwOLEV9/kO0UR0P2oMTDL4+28RKANm87Wo3sd4A/skW3G/8EfbBDlafbJo5ujzY7+tuw==
X-Received: by 2002:a05:6000:104e:: with SMTP id c14mr12301421wrx.130.1631887417274;
        Fri, 17 Sep 2021 07:03:37 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:6b11:6374:882d:42a0? ([2a01:e34:ed2f:f020:6b11:6374:882d:42a0])
        by smtp.googlemail.com with ESMTPSA id i18sm6986113wrn.64.2021.09.17.07.03.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Sep 2021 07:03:36 -0700 (PDT)
Subject: Re: [PATCH v2 0/2] Add a generic virtual thermal sensor
To:     Alexandre Bailon <abailon@baylibre.com>, rui.zhang@intel.com,
        amitk@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.tseng@mediatek.com, khilman@baylibre.com, mka@chromium.org
References: <20210917072732.611140-1-abailon@baylibre.com>
 <bd347d14-0b42-f9ed-bf15-080c929e1cb7@linaro.org>
 <7cddcdb7-4efd-bfdb-3d86-f5862ea0b7fe@baylibre.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <8a9e5f13-6253-2d0d-35a8-789090af4521@linaro.org>
Date:   Fri, 17 Sep 2021 16:03:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <7cddcdb7-4efd-bfdb-3d86-f5862ea0b7fe@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 17/09/2021 15:33, Alexandre Bailon wrote:
> Hi Daniel,
> 
> On 9/17/21 2:41 PM, Daniel Lezcano wrote:
>> On 17/09/2021 09:27, Alexandre Bailon wrote:
>>> This series add a virtual thermal sensor.
>>> It could be used to get a temperature using some thermal sensors.
>>> Currently, the supported operations are max, min and avg.
>>> The virtual sensor could be easily extended to support others
>>> operations.
>>>
>>> Note:
>>> Currently, thermal drivers must explicitly register their sensors to
>>> make them
>>> available to the virtual sensor.
>>> This doesn't seem a good solution to me and I think it would be
>>> preferable to
>>> update the framework to register the list of each available sensors.
>> Why must the drivers do that ?
> Because there are no central place where thermal sensor are registered.
> The only other way I found was to update thermal_of.c,
> to register the thermal sensors and make them available later to the
> virtual thermal sensor.
> 
> To work, the virtual thermal need to get the sensor_data the ops from
> the thermal sensor.
> And as far I know, this is only registered in thermal_of.c, in the
> thermal zone data
> but I can't access it directly from the virtual thermal sensor.
> 
> How would you do it ?

Via the phandles when registering the virtual sensor ?

Or is the problem you are mentioning related to the sensor module
loading after the virtual sensor ?

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
