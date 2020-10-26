Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C349429981E
	for <lists+linux-pm@lfdr.de>; Mon, 26 Oct 2020 21:42:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728553AbgJZUmd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 26 Oct 2020 16:42:33 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50248 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbgJZUmc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 26 Oct 2020 16:42:32 -0400
Received: by mail-wm1-f68.google.com with SMTP id 13so12990510wmf.0
        for <linux-pm@vger.kernel.org>; Mon, 26 Oct 2020 13:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oQ21H5X2KuPr/Qwp6JjCdjpeMX6VU2svnn7VHt/YlN8=;
        b=VfC+N1456fdmJsahxUouczM3Qx3uTHORj/Udy5NxiGc/HbdoRsK5tO/XhPtG9dsLEm
         okgGJ4lCcW9fmyxCv3TQIvVtI6Kd+rN8sYUurUfC+NVX83XR5gW9NIvKUZLGVoEqYQ04
         Nwl4HFqSTsbTlq8h6wBuKrallqR1atpiDhVnHTcSXd7OxLxdYQ7TFN1SaN7kSTJBLtdM
         QDdBn59G2WCxIrr7c/2kVEVdu0g2Zk2rR5RCnVKiBwB4ju3UU6j/yQodCBX1Ht43WK2g
         dn5n8CIBFsF0CRMFQjX1qaccK/SSuAmB+Kl8H8N3EYobxlMvdpQDx/rxzkCpLlLxiI5n
         fWTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oQ21H5X2KuPr/Qwp6JjCdjpeMX6VU2svnn7VHt/YlN8=;
        b=FfvR4anRCJf+TYWbjlvo+E0IhulvBpWX154Ud+eepQ8UXjSumseznWVaQFgdab+fif
         Fi9lzeHkpMdt+RIGM2eFA/e10nNxiTUmSos9lKlObuse9pEBPd45xSMUgy4hb3p3GtVt
         hjEzRasXxkAhQtyET4EUdPhYifz2HTIT5Vjnp1yGzcLDQZ6Ta5GMR1Vb1jbnU7+0hSZI
         J/3huY+NwHgNVAn/C/UkvFVyPpETjJ/QRkvbq28teSLhvey0ZHLUFMgmgd1Or3WqsVNg
         rjPBlE66k8lIVoPKw0smM+Vqd48JRtEn2DgKCmv3cTxmlvEfbnPU14jsk3L+vxTkrLMu
         86ZA==
X-Gm-Message-State: AOAM532D1DLFkA3IDbcxQJDRNaYZA1s7H5RfMW86avJ1obk9wy+6nWgX
        QcAM6nH45/NShRoP+CgJOYJ8xQ==
X-Google-Smtp-Source: ABdhPJxGGx/ffzAVIRGV7s+ZaFkUSYkHKdMdhVkH0ZbPrtOTi81HV1/RCojQal+vpjXdOZxbq8MdLQ==
X-Received: by 2002:a1c:1d89:: with SMTP id d131mr17980323wmd.188.1603744949064;
        Mon, 26 Oct 2020 13:42:29 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:6cbc:1a3:aabd:d451? ([2a01:e34:ed2f:f020:6cbc:1a3:aabd:d451])
        by smtp.googlemail.com with ESMTPSA id o3sm26053324wru.15.2020.10.26.13.42.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2020 13:42:28 -0700 (PDT)
Subject: Re: [PATCH v2 0/4] Add upper and lower limits in IPA power budget
 calculation
To:     Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     amitk@kernel.org, Dietmar.Eggemann@arm.com,
        michael.kao@mediatek.com, rui.zhang@intel.com
References: <20201015112441.4056-1-lukasz.luba@arm.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <c9471380-1614-209e-e75b-276edfb52ef4@linaro.org>
Date:   Mon, 26 Oct 2020 21:42:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201015112441.4056-1-lukasz.luba@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Applied, thanks

On 15/10/2020 13:24, Lukasz Luba wrote:
> Hi all,
> 
> This patch set makes thermal governor Intelligent Power Allocation (IPA)
> aware of cooling device limits for upper and lower bounds and respects them
> in the internal power budget calculation.
> 
> This v2 contains for completeness a patch posted by Michael. The patches
> are re-based on top of current thermal/linux-next branch.
> 
> Changes:
> v2:
> - added check for cdev_is_power_actor(), before using cdev->ops->state2power()
>   pointed out by Daniel
> - added Michael's patch for consistency
> - re-based on top of current thermal/linux-next
> v1:
>  can be found here [2]
> 
> Regards,
> Lukasz
> 
> [1] https://lore.kernel.org/linux-pm/20201007024332.30322-1-michael.kao@mediatek.com/
> [2] https://lore.kernel.org/linux-pm/20201007122256.28080-1-lukasz.luba@arm.com/
> 
> Lukasz Luba (3):
>   thermal: power_allocator: respect upper and lower bounds for cooling
>     device
>   thermal: core: remove unused functions in power actor section
>   thermal: move power_actor_set_power into IPA
> 
> Michael Kao (1):
>   thermal: core: add upper and lower limits to power_actor_set_power
> 
>  drivers/thermal/gov_power_allocator.c | 40 +++++++++++-
>  drivers/thermal/thermal_core.c        | 88 ---------------------------
>  drivers/thermal/thermal_core.h        |  6 --
>  3 files changed, 38 insertions(+), 96 deletions(-)
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
