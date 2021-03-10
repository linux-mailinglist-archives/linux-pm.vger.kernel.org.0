Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16AA2333C7C
	for <lists+linux-pm@lfdr.de>; Wed, 10 Mar 2021 13:20:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbhCJMTu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 Mar 2021 07:19:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbhCJMTt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 10 Mar 2021 07:19:49 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8556C061760
        for <linux-pm@vger.kernel.org>; Wed, 10 Mar 2021 04:19:48 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id v15so23096326wrx.4
        for <linux-pm@vger.kernel.org>; Wed, 10 Mar 2021 04:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+Thwrg3qqoUAhwxM+WcU2u+TiYXJHE8JDjJsGatqd/Y=;
        b=P9VknKEPcyVqWWZufkGPkL7KVSXa9RkQyQkPYODUoIxqRJr90IqY6fiSolH8U3aiWv
         93JrhtgP4aRcezHmCi/YEeCpNg/2qq8Htgn72XxVRzoQIuy5JLGiNLEpwbehqN5NtV9x
         8WEEvuVyRkSrBzZCRjPqwC4cCElK1sEkpwVGSKL6iszB+SvOHyLXRpvlPBg3flwuHEKu
         +fcDcHvQcHiVoPaQ8L4eQmbQ/XKi1bKnqV3jW/2gv0gXqjfEDOvYsJ55ihjlmIe+NQcF
         1bpbpL+j+mI1HQ9dQXY1/yUhJgeqaPgqIe+iC0EuBEqZ7SpCj1oFA0iSZQHwYQ/mj8/t
         4riA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+Thwrg3qqoUAhwxM+WcU2u+TiYXJHE8JDjJsGatqd/Y=;
        b=JuZfqAEukd+A6bj+hz8DoQQ6+J+AjcevlG8SppzlyP8cYfPZa5lSUE8fP5sWVCucIg
         S9TQU0Yw+W7KJKbn9YSGNw/BJOkEMLyFjf8xBZ9TzTMhTTe9eWJbpaPLvwFbIY8GjzBc
         2tl496v/SIjtOHBam1uKT6/EtMQDBo8I+C3kk40DJnFyKkGgAVYLF+vqi7968TRklZR1
         v+HZwXktbW+I4pjkKztpMZsXnHLMJ77fD5uYrJZcRkic8ffTQYWNggcSuNtQNoiG7Tq1
         riGm6VT6zX2evwFgouEfctY6VoTxyFsFLH5XqxV4ubgyj/iJWqt4U7pUbFLXfmZTf3UN
         6Ovg==
X-Gm-Message-State: AOAM530x7UiQ/tFv1n2PqO7a75bD0vvEMS0q7BOuRxanTe5FG4hdOgsV
        /UOQfPBELghP0Mwl6xXIoznY5g==
X-Google-Smtp-Source: ABdhPJy2wS4+o8phanKVOn3lZq7ICLobsnju1ml3279qVLpDMTBVRF+ouyMr00zPdGc/SISKLUPpYA==
X-Received: by 2002:a5d:6d06:: with SMTP id e6mr3253733wrq.425.1615378787498;
        Wed, 10 Mar 2021 04:19:47 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:8018:efa9:4421:9140? ([2a01:e34:ed2f:f020:8018:efa9:4421:9140])
        by smtp.googlemail.com with ESMTPSA id r11sm30479183wrm.26.2021.03.10.04.19.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Mar 2021 04:19:47 -0800 (PST)
Subject: Re: [PATCH v10 0/8] Add support for ipq8064 tsens
To:     Ansuel Smith <ansuelsmth@gmail.com>,
        Amit Kucheria <amitk@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thara Gopinath <thara.gopinath@linaro.org>
References: <20210217194011.22649-1-ansuelsmth@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <f0ab094e-440d-993c-6618-bf80fd05d484@linaro.org>
Date:   Wed, 10 Mar 2021 13:19:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210217194011.22649-1-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Hi Ansuel,

On 17/02/2021 20:40, Ansuel Smith wrote:
> This patchset convert msm8960 to reg_filed, use int_common instead 
> of a custom function and fix wrong tsens get_temp function for msm8960.
> Ipq8064 SoCs tsens driver is based on 8960 tsens driver. Ipq8064 needs
> to be registered as a gcc child as the tsens regs on this platform are
> shared with the controller.
> This is based on work and code here
> https://git.linaro.org/people/amit.kucheria/kernel.git/log/?h=wrk3/tsens-8960-breakage

I don't have major concerns with the series except there is no comment
from the maintainer / reviewer of the sensor.

Given it is based on Amit's work, I can assume they are correct.

I added Thara in Cc hoping she has time to review the changes. If nobody
complains with the series, I'll merge them in the next days

Thanks

  -- Daniel


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
