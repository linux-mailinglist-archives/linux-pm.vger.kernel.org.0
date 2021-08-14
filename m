Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2D863EC2EE
	for <lists+linux-pm@lfdr.de>; Sat, 14 Aug 2021 15:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbhHNNnW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 14 Aug 2021 09:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbhHNNnW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 14 Aug 2021 09:43:22 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 447FAC061764
        for <linux-pm@vger.kernel.org>; Sat, 14 Aug 2021 06:42:53 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id r6so17137915wrt.4
        for <linux-pm@vger.kernel.org>; Sat, 14 Aug 2021 06:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hfu9hugGRcqPkgiDAUJyt+AdgFW9E3KmPbE674EXQXU=;
        b=tHU4XIvLlXu8m5DWaIvsR7J6Rtek1hp8oGSkcwkRtJtfDvfNymz5P7HRkEkKKoTbM1
         sk2tp2q9qC1WvR2FVZKEoFuJ+rqDROONilOa6Nd41KRfTozhWo+x04QuS9wP/wjM7NFX
         VNQXKFcXTXo0G8FMCusY+wN2l2UaR7LmEU9XFdUiNIU8dxrG/xGw6rcynjECLgPhiERU
         dDGHpORhlabWEXZnzcg+gQwAO8NAzNYn1hLENo6cdlbJmrulVWtwFrmjtCihQV9qrnx4
         Ia7afMkyz4XNPBNmTcTU95MKvxL6YYxSWeOjin9Y6hbcQ6hTefq0KhfQ8wpLHdmvNSvn
         tQ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hfu9hugGRcqPkgiDAUJyt+AdgFW9E3KmPbE674EXQXU=;
        b=R34JLmSNMfWyVP+KWskQKiGNpDIGlQDXdris3KH/OL4BP8rdLUkEwPxfBiZXw3fnYY
         osTKn7wdenIVLdPH0XEUuky2CRWJ0X0JSLGqRFRW+pTHvSRUY1neaU5xFz3ajqr39QoQ
         aKUHkEnNZlvMVSIq5feBd6xmjO0r4/ISxag+CerSBjhijoiGJTWuqjn0AA2m/vEUffTM
         YJTS6NYwCAqMcMOqwpTRnAJBfhKEqNIXZL7FOVxe5frmsrETF3Vz+AdLmuu3QyMcq44t
         TTQtmCqrtm4CnuPv+WGwmh/FwES2T9s4ubcQtXbZkkZHmwwp/i8Lyedz8Ogdb0l989u9
         WoRg==
X-Gm-Message-State: AOAM532IpUr6CTiJt3BWGkIZCUHl0vcQn7/fFVH1VF/QV56ID7GiEJpS
        sdKaYBhyGd6VNZNZd/KgNykUOg==
X-Google-Smtp-Source: ABdhPJwn8PbycVzm/tNWphYl0bL7+PMEJGuEf74X9Vnb7UtKculiYMWn2UTie8yRQLDAzf/fgt9G2Q==
X-Received: by 2002:adf:df92:: with SMTP id z18mr2325056wrl.180.1628948571557;
        Sat, 14 Aug 2021 06:42:51 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:ab33:6dea:825:98d? ([2a01:e34:ed2f:f020:ab33:6dea:825:98d])
        by smtp.googlemail.com with ESMTPSA id g6sm4640444wrm.73.2021.08.14.06.42.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Aug 2021 06:42:49 -0700 (PDT)
Subject: Re: [PATCH 33/54] dt-bindings: thermal: Make trips node optional
To:     Maxime Ripard <maxime@cerno.tech>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com,
        Amit Kucheria <amitk@kernel.org>, linux-pm@vger.kernel.org,
        Zhang Rui <rui.zhang@intel.com>
References: <20210721140424.725744-1-maxime@cerno.tech>
 <20210721140424.725744-34-maxime@cerno.tech>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <f0ca864a-ec20-4ad3-8876-6d73eae4a779@linaro.org>
Date:   Sat, 14 Aug 2021 15:42:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210721140424.725744-34-maxime@cerno.tech>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 21/07/2021 16:04, Maxime Ripard wrote:
> Even though the previous binding made it a required child node, the
> implementation in Linux never made it mandatory and just ignored thermal
> zones without trip points.
> 
> This was even effectively encouraged, since the thermal core wouldn't
> allow a thermal sensor to probe without a thermal zone.
> 
> In the case where you had a thermal device that had multiple sensors but
> with enough knowledge to provide trip points for only a few of them,
> this meant that the only way to make that driver probe was to provide a
> thermal zone without the trips node required by the binding.
> 
> This obviously led to a fair number of device trees doing exactly that,
> making the initial binding requirement ineffective.
> 
> Let's make it clear by dropping that requirement.
> 
> Cc: Amit Kucheria <amitk@kernel.org>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: linux-pm@vger.kernel.org
> Cc: Zhang Rui <rui.zhang@intel.com>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>

Applied, thanks!

  -- D.


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
