Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF3B321D964
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jul 2020 17:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729649AbgGMPDI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Jul 2020 11:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729027AbgGMPDH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Jul 2020 11:03:07 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A21AEC061755
        for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2020 08:03:07 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id o2so13493577wmh.2
        for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2020 08:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hj7ei/4/U37aYVFzIdiyRob1Gsg4Hui2K44614n1iwI=;
        b=i2jn9oc2zspqjTVmpnmwS8848CCRuvu5xsFu2vw3OlfkIRw7Fr77HxcgYjRAE3Mcyt
         XR7yS0fAqYT11ZspWkctOR1T6sUV0edIcASIZGPkgG5KiUkwqfj4mxdtR24+h1qNsXxN
         mSKEpGM4GcfiIjZwQvj1SesY0iKuwzcXeoZhrGx0oOfDhVnYzgdcyPwn93Esm1bxPHPR
         +Rjuax6h6eB+6Z/9CbF4kMjHffa8MbtXlMJrTqUNHOwHy15TFfWSSaHhqTzuRgLYLDSF
         oUm93NAXxBB6D2mhQntN0BOXU96MYVIZlw0MrXH2jTFNgO34gR1B/1beSyJUIS6ml78h
         iN5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hj7ei/4/U37aYVFzIdiyRob1Gsg4Hui2K44614n1iwI=;
        b=EgYbtQWes3CB6Ynw3VtVIcCpGW8CPQKos5XC2ctkm/6j99M2h6LcGwMA93EUrPUgJn
         iOvCr6bzyFILAl2wbrrMvl34GL3p4HjprqCyjdHzjhoaapQTqsvQEi8mSzpcGBqJFDQs
         ji3DATtgHA0K7eNBTSRnCnc1+7A3R2JXNKc0ESk0H7hUwHv0r++dyzdUFSR9ntpupy9Z
         1HfsHInJzmrkKRNZz2oBIaifFiFqKhDRgUPUwQ9ory4Lfnm4aUEozcDqWMeBtJnWOZ35
         lw8X3AW2HlJnVQa+LmYa96RvAr7OfW+tXnHtXARy/3eGR8sHqzTebSd2LwR3A/6owP3S
         uhlg==
X-Gm-Message-State: AOAM533neZGHIj5mfwF72G/+odvCEhR0zFifSdyWoNRwteax6pZaDaG2
        3FTIXa2CEDDpOEW8IWtCATsK+g==
X-Google-Smtp-Source: ABdhPJw65cTT/euYaJOY4JshtT6+GDtwu+71TCGdRUmekWqgIVNWBBETTu76zAOQEbJHhJLgbIME6w==
X-Received: by 2002:a1c:e285:: with SMTP id z127mr353808wmg.162.1594652586275;
        Mon, 13 Jul 2020 08:03:06 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:501b:b12d:3463:93f8? ([2a01:e34:ed2f:f020:501b:b12d:3463:93f8])
        by smtp.googlemail.com with ESMTPSA id v6sm24316475wrr.85.2020.07.13.08.03.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2020 08:03:05 -0700 (PDT)
Subject: Re: [RFC PATCH 0/4] thermal: Introduce support for monitoring falling
 temperature
To:     Thara Gopinath <thara.gopinath@linaro.org>, rui.zhang@intel.com,
        robh+dt@kernel.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200710135154.181454-1-thara.gopinath@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <7437ee89-e76d-0c82-9860-5c6076ad8a30@linaro.org>
Date:   Mon, 13 Jul 2020 17:03:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200710135154.181454-1-thara.gopinath@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10/07/2020 15:51, Thara Gopinath wrote:
> Thermal framework today supports monitoring for rising temperatures and
> subsequently initiating cooling action in case of a thermal trip point
> being crossed. There are scenarios where a SoC need some warming action to
> be activated if the temperature falls below a cetain permissible limit.
> Since warming action can be considered mirror opposite of cooling action,
> most of the thermal framework can be re-used to achieve this.
> 
> This patch series is yet another attempt to add support for monitoring
> falling temperature in thermal framework. Unlike the first attempt[1]
> (where a new property was added to thermal trip point binding to indicate
> direction of temperature monitoring), this series introduces a new trip
> point type (THERMAL_TRIP_COLD) to indicate a trip point at which falling
> temperature monitoring must be triggered. This patch series uses Daniel
> Lezcano's recently added thermal genetlink interface[2] to notify userspace
> of falling temperature and rising temperature at the cold trip point. This
> will enable a user space engine to trigger the relevant mitigation for
> falling temperature. At present, no support is added to any of the thermal
> governors to monitor and mitigate falling temperature at the cold trip
> point;rather all governors return doing nothing if triggered for a cold
> trip point. As future extension, monitoring of falling temperature can be
> added to the relevant thermal governor. 

I agree we need a cold trip point in order to introduce the functioning
temperature range in the thermal framework.

Rui, what is your opinion ?



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
