Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4300423437A
	for <lists+linux-pm@lfdr.de>; Fri, 31 Jul 2020 11:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732107AbgGaJnc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 31 Jul 2020 05:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731922AbgGaJnb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 31 Jul 2020 05:43:31 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA54C061574
        for <linux-pm@vger.kernel.org>; Fri, 31 Jul 2020 02:43:31 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id f1so26845049wro.2
        for <linux-pm@vger.kernel.org>; Fri, 31 Jul 2020 02:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=694M5ptZ+qGWMshyD+vmBo/LA7n/eegguVd13epfDvA=;
        b=SAwbNNoAA8841pE3OBKjYWLumeq2s4edh4sB10E2fUgUQEBOPYCI2n2hlj9vXE7fnH
         otmhH6LVm91/1roUdWxSOXIN49cYyMgG5HOxsI7QzZOU7ufXUxM6aVkATEGS8O0cnkxh
         r80Aayj4H2cLf3ZRRc85BxnfY/i4X924CksCJWYsPNH35+oeylrXggb4G782X5bbKY6m
         ldDQ4Br/Kg54cbV43e/xhPQHoubZ1OvbDuAqB0LtLLanQ1rf6k0A//+xMpHIwHpWrDzV
         I6PVSXxxt2P7fgJRtsUUqbUBUzeXdaoe2Sy83msQwXM6txMQye3MmUhvQIqyjuwHCWgo
         Tb/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=694M5ptZ+qGWMshyD+vmBo/LA7n/eegguVd13epfDvA=;
        b=JGKSjV2/qRlWKUEA5eXxNyd71jQKO6ripKcthKuley4FFnsis8DoJWqWHd0d3bHpTv
         DwgfRqwdH6nMKCKQhjAb/d6CysU3a0KS0+JjEVLvwFV8nR8z3OfvcEosjhwAiojmhO7T
         KMtfBAGaE3CDxYrPgSKyiha+XVxSHRYLe/rZGqzReuPqxL/cYU3Xc6Sw+PpSF7iWl+Ui
         KxooPmQyq0y0iAAe/e1UdblAev512aYuqmZBJP74n2Zo6cixQyjrV6LoAq2qDRSBw6GP
         Akvv04fA2FbBxMNd0i10IvClCT25YX5E7cyo90oWPArHH73hQhmYYFcF376nrtXoa/3T
         Oe0g==
X-Gm-Message-State: AOAM532kF8cAOpbQqUDl5QIGZV0uyO2C3hq/zPwTGn5P0ZUmcWAx5vYd
        z0FjOBlEZ4/4Iktr3D/Yyu0jXQ==
X-Google-Smtp-Source: ABdhPJz+8iqI7pblUB3VDCSn0j1SVfeJn1pDiDhaTyr/Cn9Rwt5f+GnLAtypovQLVALrAd4Ukhjfjg==
X-Received: by 2002:a5d:6584:: with SMTP id q4mr2700654wru.21.1596188609717;
        Fri, 31 Jul 2020 02:43:29 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:e484:a7d1:6931:9059? ([2a01:e34:ed2f:f020:e484:a7d1:6931:9059])
        by smtp.googlemail.com with ESMTPSA id r206sm12629178wma.6.2020.07.31.02.43.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jul 2020 02:43:29 -0700 (PDT)
Subject: Re: [PATCH] thermal: intel: intel_pch_thermal: Add Cannon Lake Low
 Power PCH support
To:     Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>, rui.zhang@intel.com,
        srinivas.pandruvada@linux.intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1596097503-27924-1-git-send-email-sumeet.r.pawnikar@intel.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <f5d88ddc-100f-35f8-5f38-f7f4811e6713@linaro.org>
Date:   Fri, 31 Jul 2020 11:43:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1596097503-27924-1-git-send-email-sumeet.r.pawnikar@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 30/07/2020 10:25, Sumeet Pawnikar wrote:
> Add LP (Low Power) PCH id for Cannon Lake (CNL) based platforms.
> 
> Signed-off-by: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
> ---

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
