Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21D783F92EC
	for <lists+linux-pm@lfdr.de>; Fri, 27 Aug 2021 05:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244128AbhH0D3w (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Aug 2021 23:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244015AbhH0D3v (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Aug 2021 23:29:51 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DDCDC061757;
        Thu, 26 Aug 2021 20:29:02 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id f2so9024942ljn.1;
        Thu, 26 Aug 2021 20:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=svxqvpAKliIvS4u4Jy0OhtXDUN4ND8MTehcm1BRtWIc=;
        b=fW/YVxM1LrYBh5IkDppF9PZVvuacDw0jD3rfHo0tsWUZp0FCOVXQPIDHL8h7+NISTR
         +kpANRMDEhImzAG68MW1ogpfLWBBZt15+CcjjNtPedrOpt8NIaCEzmotAZSXjMNN4wUM
         7RJMRSuRoXxJiYjuqVrC/znR+r02D/5D3+CjNmfoXMkIChqV09aPCLpIHRtuo5+9ftd/
         rh+Wj2sFG+XFak8tGzaYbi9ReJFQUh8VjE47L5GCbhBle62Asn8zQUEU5krNSqynlMTo
         M4ZFu2Bk/SAG+q96YlEhdqCWqIJjv9ZcBbnu2matvJBiyK8vXTGZCqgs5U6CQSAZMd3D
         VVdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=svxqvpAKliIvS4u4Jy0OhtXDUN4ND8MTehcm1BRtWIc=;
        b=AeLXq0R2uwC69/lqXQUoQXzep0nJc+cO789Wm6fdSHu8zMsrBtl0sPYfUMOWfvlTRQ
         jsjBnNSTleig6zDetqj4Pl8aktYTjoCHk0Svub/zyg+nHB/Y1ccCRKSrBJgcfXIhJ48U
         F5oh92/HEwZrlU+Vq03WHKxaGtgDwgpBxlq7pIORYQuB5Z5sWYD2yHCAgEyOC/b92hhQ
         zFjFQPnLhSbZrYPIypARplFsrMvPBxLdpXxEi6fDBzwWyS1T84Cv62Y9XrprYjftDeYy
         MbXTCUMGjahkyn1a5igImlhvUQXIsq+x/DNssus0boUFTA1QA6M40TffvSggGNph3UWW
         B8XQ==
X-Gm-Message-State: AOAM531FZfNupMUXhr5SGi6eVrObX48cSJwaAWwoJPTElMSfgK2UkGK3
        W24QAJQ449f7TgkMClz7xI9rzm/z30s=
X-Google-Smtp-Source: ABdhPJy+iN1793E/d7VmWXGrY5oV9KafTsvhfYaK1hBact+7rR57p7mcI73r8+6Y+LSJlVWdDcGtaQ==
X-Received: by 2002:a2e:8ec2:: with SMTP id e2mr1876342ljl.236.1630034940705;
        Thu, 26 Aug 2021 20:29:00 -0700 (PDT)
Received: from [192.168.2.145] (94-29-17-251.dynamic.spd-mgts.ru. [94.29.17.251])
        by smtp.googlemail.com with ESMTPSA id w2sm469497lfp.231.2021.08.26.20.29.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Aug 2021 20:29:00 -0700 (PDT)
Subject: Re: [PATCH v9 1/8] opp: Add dev_pm_opp_from_clk_rate()
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20210827013415.24027-1-digetx@gmail.com>
 <20210827013415.24027-2-digetx@gmail.com>
 <20210827030019.blhfh5wp7iyf53a2@vireshk-i7>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <536563a8-ffdc-5a75-ebf2-89f38d52f580@gmail.com>
Date:   Fri, 27 Aug 2021 06:28:59 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210827030019.blhfh5wp7iyf53a2@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

27.08.2021 06:00, Viresh Kumar пишет:
> On 27-08-21, 04:34, Dmitry Osipenko wrote:
>> +/**
>> + * dev_pm_opp_from_clk_rate() - Get OPP from current clock rate
>> + * @dev:	device for which we do this operation
>> + *
>> + * Get OPP which corresponds to the current clock rate of a device.
>> + *
>> + * Return: pointer to 'struct dev_pm_opp' on success and errorno otherwise.
>> + */
>> +struct dev_pm_opp *dev_pm_opp_from_clk_rate(struct device *dev)
> 
> I will rather call it dev_pm_opp_get_current(), and do the magic to find the
> current OPP here as well. No need to reinvent the wheel.
> 

Okay, I'll change it.
