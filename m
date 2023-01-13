Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D53666693EA
	for <lists+linux-pm@lfdr.de>; Fri, 13 Jan 2023 11:20:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240603AbjAMKUY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 13 Jan 2023 05:20:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240196AbjAMKUW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 13 Jan 2023 05:20:22 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F0914021
        for <linux-pm@vger.kernel.org>; Fri, 13 Jan 2023 02:20:20 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id q10so1277981wrs.2
        for <linux-pm@vger.kernel.org>; Fri, 13 Jan 2023 02:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R8UGna3NvU6BqJN38fD7BOeeWmtWz0VHiahdkErFzDM=;
        b=HS9/A2RUs3GRmV+lBocazW5E1MWmENkSmuwiLhNXJO2BMnSkGeFBqYzG3mUal5UDYc
         2lcNIy/Z4bTYpdVa2E9B1aByagDK9ndV+D8TCDCuO0cvAunJevXAHtk4QM4UktkDP6OG
         98pbpfTGZTSkvWXyQNKjZlwqVXLFnSrvb3t80dsOVbv6YJnIXHC9AdbYTg2Dxex9JFhz
         4I363Se8rd8CkIWcPvKUIz/wvptVWP4Cbcss7FDHhZXIn/We626mkGZbBPWpll8MB+8m
         Yzxi8xzy5hTb4agJE6AEAlIWw59igVwLjOe5z5MZ74YxSTHJUpEWcO8waVNkkc0qyWpe
         wfRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R8UGna3NvU6BqJN38fD7BOeeWmtWz0VHiahdkErFzDM=;
        b=YgaQqk20k5ZLjfJqp2MbJiYB9t5r+GHpw1Ob+42GxlHOKlnUsdiFDFpiPTK9Eo8D2h
         8ampEUQluKl7eytST70VgnYKKyXDhB2Aed4O4lZ4X9GGF8GZMvjFU0QstATtuFSFZY5v
         JyQOblcxAu18yl4DS0zwFSSSe/Jt0UwkRWEaIRWXsQmfZn4t4NPBr6ZcD0ApAeR+oKwD
         AQcwKau5vw+Xhpz6fzBFwWsAEX+IxcA6euJv0Px0hMrwZBuBm+kY65/G0SJalLSsj/lF
         hArGctbIqpDKchylALajo9vLKaqBFXV1quFipjjhPZd/msxhxilBfef+naSXDiqdMzOl
         j6Og==
X-Gm-Message-State: AFqh2kp63h5WQMKcoxq7IeClNAwKdf/pJLQej21RmrTvUWaQ47YGVe4Z
        dQXWbYGFxlTYOk2o+jqnRCAW7A==
X-Google-Smtp-Source: AMrXdXuBnifufZaaMMgkYNy2Rnx2O9dvBZ6xWhzIFG2CPXcx9HLtGHFcu6BxzWXzZOVP58AvU+FJFg==
X-Received: by 2002:adf:f585:0:b0:2bd:dc3f:336a with SMTP id f5-20020adff585000000b002bddc3f336amr2080800wro.58.1673605218639;
        Fri, 13 Jan 2023 02:20:18 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id w4-20020adfee44000000b0029100e8dedasm18482938wro.28.2023.01.13.02.20.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Jan 2023 02:20:18 -0800 (PST)
Message-ID: <d855d1c5-330b-f87c-1db1-139b131d930f@linaro.org>
Date:   Fri, 13 Jan 2023 11:20:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] thermal: mtk_thermal: fix kernel-doc function name
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230113064449.15061-1-rdunlap@infradead.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230113064449.15061-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 13/01/2023 07:44, Randy Dunlap wrote:
> Use the correct function name in a kernel-doc comment to prevent
> a warning:
> 
> drivers/thermal/mtk_thermal.c:562: warning: expecting prototype for raw_to_mcelsius(). Prototype was for raw_to_mcelsius_v1() instead
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Amit Kucheria <amitk@kernel.org>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: linux-pm@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-mediatek@lists.infradead.org
> ---

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

