Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E11A30C229
	for <lists+linux-pm@lfdr.de>; Tue,  2 Feb 2021 15:45:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234452AbhBBOmU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 2 Feb 2021 09:42:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234762AbhBBOkA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 2 Feb 2021 09:40:00 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCF2FC061797
        for <linux-pm@vger.kernel.org>; Tue,  2 Feb 2021 06:39:19 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id z22so15041768qto.7
        for <linux-pm@vger.kernel.org>; Tue, 02 Feb 2021 06:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QCXMgL/NI1An1LEuzQQXQxYWJvRlCAB2+iZ1nwK6XiQ=;
        b=ULAy3lrC+Y0gxtv4jTTV7PD/Td0PbcRkc4YE+9Hi3dFkV+t9mTfO9aMUL7CIcE3xOA
         Zpe4Vnb5mMcVlEEB1Ec/6UP5f8aFoPImSSbtaN8u0/zDd4pYtQnfQ3EGa8MNPSQPOUzT
         50wMf3T6pyetpDGFy95MLWydP3buumdz0ajV2WuU2pTHf71E47asOmVVsB8Ob5VjjTf/
         E4kZCVH4Bl04sp6IxTLggpfr933rMVat90qKNBRotLUsN8plYyuBqYLhpah4Fo8J6tWs
         C1gcolij6Ilb2szY4wfPnkmccGjYjmfBpqhjYHWs7XATcvjqWKElghKGRVIcu/i30R8F
         94zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QCXMgL/NI1An1LEuzQQXQxYWJvRlCAB2+iZ1nwK6XiQ=;
        b=Q+McQ5IMbsDcWhAIoTLm2b61xAzNez4bmwFJOoktHpzYr5mO2Mg3JRSCCVmE/KYlxH
         LYwYdxD0h++kmwUkDDPQLoEC5M5ifk+VGMMq5/u/CKj2NofMJqJnwExqL+wDyqIIpKT1
         u0zvPyc/01eWs9ypTKiefyPTgHZRoXxaWmd5QPLsrmc8r8u0Y0GhoqzmcuBnfqgRR2/d
         K1tAOeTbL5IeGN008yBjCPBR5QUOG+Gnrx6c9sgaUyND4KYaO6kpDgrepuoa4uyniFhE
         Rfl71SoK0LC6xuc82a7ofxKMVLFK/D0Y/VpS8PWJ9HCu0TWHX8sX8FAG4UEE5xuwg4jv
         cNwQ==
X-Gm-Message-State: AOAM533+zDva8EpDCeJxrrBleV2dEATBGOIbyXfE8mY5zhvChGe/iFeV
        6DoL+zHgnsVQ0KNuGEV9EJbPBg==
X-Google-Smtp-Source: ABdhPJyaPn4UvgA8IzkPLrlMtsyMEsa4VmMlWLOK/4Ie2EIEzaTQlKojJWvWZ3ZxxHcPy50aHzKsSA==
X-Received: by 2002:ac8:4886:: with SMTP id i6mr21015723qtq.334.1612276758902;
        Tue, 02 Feb 2021 06:39:18 -0800 (PST)
Received: from [192.168.1.93] (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.gmail.com with ESMTPSA id h6sm16225138qtx.39.2021.02.02.06.39.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Feb 2021 06:39:17 -0800 (PST)
Subject: Re: [PATCH v2 0/3] thermal: Replace thermal_notify_framework with
 thermal_zone_device_update
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     rui.zhang@intel.com, daniel.lezcano@linaro.org,
        davem@davemloft.net, kuba@kernel.org, luciano.coelho@intel.com
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-pm@vger.kernel.org, amitk@kernel.org,
        nathan.errera@intel.com
References: <20210122023406.3500424-1-thara.gopinath@linaro.org>
Message-ID: <73dccbcd-b4c3-64f5-1b7a-805c68ab7aa9@linaro.org>
Date:   Tue, 2 Feb 2021 09:39:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210122023406.3500424-1-thara.gopinath@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 1/21/21 9:34 PM, Thara Gopinath wrote:
> thermal_notify_framework just updates for a single trip point where as
> thermal_zone_device_update does other bookkeeping like updating the
> temperature of the thermal zone, running through the list of trip points
> and setting the next trip point etc. Since  the later is a more thorough
> version of former, replace thermal_notify_framework with
> thermal_zone_device_update.

Hi!

Any more comments for this series? Can this be merged, please ?


Warm Regards
Thara
> 
> v1->v2:
> 	- Removed net: wireless: intel: from subject header of Patch 1
> 	  in the series as per Kalle Valo and added his Acked-by.
> 	- Introduced Patch 3 removing thermal_notify_framework from
> 	  thermal documentation.
> 
> Thara Gopinath (3):
>    net: wireless: intel: iwlwifi: mvm: tt: Replace
>      thermal_notify_framework
>    drivers: thermal: Remove thermal_notify_framework
>    Documentation: driver-api: thermal: Remove thermal_notify_framework
>      from documentation
> 
>   Documentation/driver-api/thermal/sysfs-api.rst | 12 +-----------
>   drivers/net/wireless/intel/iwlwifi/mvm/tt.c    |  4 ++--
>   drivers/thermal/thermal_core.c                 | 18 ------------------
>   include/linux/thermal.h                        |  4 ----
>   4 files changed, 3 insertions(+), 35 deletions(-)
> 

