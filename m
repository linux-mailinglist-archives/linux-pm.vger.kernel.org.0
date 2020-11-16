Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58C0D2B3FBB
	for <lists+linux-pm@lfdr.de>; Mon, 16 Nov 2020 10:28:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728093AbgKPJ2I (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Nov 2020 04:28:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727027AbgKPJ2I (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Nov 2020 04:28:08 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0847C0613CF
        for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2020 01:28:07 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id m125so11673762wmm.3
        for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2020 01:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aiVEflQDL1Czjb2cNgVWqiIiSyZhmV56WumKQIdULB8=;
        b=N8h/wOgVmzOgB6oQWVsAXyVwSkIxftrwX56zVH0kkezD2bi7ZhV8b86mFR2ShBS3+d
         JsR7oIjQttTRadOEjoii/N1xvfYFk/v0FDTBZCpoREnE01stEd7m76wojUkjuGPzX36t
         /XhMjHCXo8QkC3ZwxqLM/CGIXxo0nKbyiqt9Tn58HFa7CsjeHEECi3btpJ5eoVlzWazw
         twXifoQik41Dtdkya2l7youQ44+4Z6jM0SRRXzHOleALfw0LVBYt2NJPdvDu0srN0opf
         6k3cdIJTPR7LcDuNkpV2AR3/QT+8UxcnoqSe2ZPXcomNCwUc73cIR7YJyPpD6js98ksD
         j+EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aiVEflQDL1Czjb2cNgVWqiIiSyZhmV56WumKQIdULB8=;
        b=NBc3s9yyldN0I0aGnTze38L7Gq/5+ZfWRXDj5yft66j5pAb9DfHCIH97sNma1HKgBY
         8aQl8zGmKpRJdBaSw/Yqgjggprcc02fy9plH64eaENVlhoyVmGXasJx0PVvU4qGX0V5g
         x/x9C+nTXmHP86pHE8LZizBHLNjelgZt4RNTWFkOAJH25qiAt/19NrYwGSgm5GGH93ML
         KDlQduXTWEM3ONGSFodNiHs7929YvkwZHZ9Z3GQ6LFHVyGw62SZdfD9rdLcw3ltkapOu
         fXAse8w9LBsQHod+E39YeJFRM0nq0lSuumVISdXrfcu2pfN7eA4q0hywLrVjssl9h1Sr
         76+w==
X-Gm-Message-State: AOAM530gRuDJPc8dLWFkdmM33+H9qWV5reusH64sEC23bK6X1l4nGJwP
        QC1mYvhXBik3HuBRqJVFRZjETMkDC2F9KQ==
X-Google-Smtp-Source: ABdhPJzlGXMgl3T04ISYwJc9hF/19Gvm08KlXJPXpkDO+c7n7N8p9oqyP/Q+OQHCtq20IQpJhKEO6w==
X-Received: by 2002:a1c:309:: with SMTP id 9mr13737111wmd.80.1605518886526;
        Mon, 16 Nov 2020 01:28:06 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:eda6:9373:9374:7214? ([2a01:e34:ed2f:f020:eda6:9373:9374:7214])
        by smtp.googlemail.com with ESMTPSA id n23sm19036873wmk.24.2020.11.16.01.28.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2020 01:28:05 -0800 (PST)
Subject: Re: [PATCH] thermal: intel_pch_thermal: Add PCI ids for Lewisburg
 PCH.
To:     Andres Freund <andres@anarazel.de>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Tushar Dave <tushar.n.dave@intel.com>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <2fd3733b-ed67-80e0-7b27-8e3c421eeb9c@linaro.org>
 <20201113204916.1144907-1-andres@anarazel.de>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <116a81e6-7989-8077-1fc4-c9f047256e9a@linaro.org>
Date:   Mon, 16 Nov 2020 10:28:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201113204916.1144907-1-andres@anarazel.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 13/11/2020 21:49, Andres Freund wrote:
> I noticed that I couldn't read the PCH temperature on my workstation
> (C620 series chipset, w/ 2x Xeon Gold 5215 CPUs) directly, but had to go
> through IPMI. Looking at the data sheet, it looks to me like the
> existing intel PCH thermal driver should work without changes for
> Lewisburg.
> 
> I suspect there's some other PCI IDs missing. But I hope somebody at
> Intel would have an easier time figuring that out than I...
> 
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: Tushar Dave <tushar.n.dave@intel.com>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: linux-pm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Link: https://lore.kernel.org/lkml/20200115184415.1726953-1-andres@anarazel.de/
> Signed-off-by: Andres Freund <andres@anarazel.de>
> ---

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
