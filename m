Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23A8D679578
	for <lists+linux-pm@lfdr.de>; Tue, 24 Jan 2023 11:40:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbjAXKko (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Jan 2023 05:40:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232654AbjAXKkn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 Jan 2023 05:40:43 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C7155BB
        for <linux-pm@vger.kernel.org>; Tue, 24 Jan 2023 02:40:40 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id f25-20020a1c6a19000000b003da221fbf48so10578752wmc.1
        for <linux-pm@vger.kernel.org>; Tue, 24 Jan 2023 02:40:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ONRQWHI/sQIqG+xHe0N/n0K7DYmBUbJ5AAwVm+d+N0U=;
        b=wBlVF7aSvrGHLIvg+pYRaOcWCQwIgDJqjFp34W2AfthOXaBEZZ/08D1E0a7Nt2YVVV
         6vSq1r2omrSM3rXnFtBU9wv/+tvKhkV0Q/JVgvvlkHVJtlRPlbxhhcZxa14oUX5yjBA1
         DQi8Jyyc9o+Q2IoyYI7HVB3vRjGh60/ccBGd3iORuIJSfScenzj8OhlFVPUxcg7wGDqg
         qyDS31qPt8MeCZz6gy0QIU2n7/WC4rsL3TkCX6sXtUvpi3EX5VtnhsglK/J5hK/uKCaJ
         X29Qb3IbsfcSBkwwShocHdZ5EWZaYxeqNnNAu+LASt8nqCQuRCJZk9lNvkSh3UFtXogl
         I5OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ONRQWHI/sQIqG+xHe0N/n0K7DYmBUbJ5AAwVm+d+N0U=;
        b=KNMGUbTIuP1a5Wp3Eg2YkIY4S17m84724VaCLKAkLDEPLck4BGHQMcK5oAZ+cUliQP
         nvKazed18X7LsToEASbNFoKaOnCzlh8HPBkVioZ+sLKKojLY+YCMWS5wFS5i9etTDb2l
         zE25udoffP4Hj503up8PHwmvVvkSWPrxQamuNrHwOppz1y7M2tSw1Pkk6dCkqLKWIHQU
         QX/DUo+vxQiEiR1Qw6WN8SQ1CqnDhHXG+DMqrUr6QzwIQ5nShIt3E6xN65dXoyg62DZ6
         m6pYI9nl9YBoPW3Thz3tMcaXPq63xaggwgxec3cQaRZsrBj2On7knIylg3Bu1CH4S/4w
         sJtQ==
X-Gm-Message-State: AFqh2kppAB+FwXN5OJ1BiQjRAD6l76jLeOgViOCvp8XchhVgD8ooSDbt
        wM64XCmPp3xwjXzD3LXNkCuw7Q==
X-Google-Smtp-Source: AMrXdXvpqy013YLOhxcVEo64Ir3FVYX+WtS52ey29R9L7EdcjNlgq4mifaFxyfxuXLfuh5tMHiqBjw==
X-Received: by 2002:a05:600c:1e1f:b0:3db:2063:425d with SMTP id ay31-20020a05600c1e1f00b003db2063425dmr19422209wmb.2.1674556839190;
        Tue, 24 Jan 2023 02:40:39 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id l14-20020a05600c2cce00b003cf71b1f66csm1844294wmc.0.2023.01.24.02.40.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 02:40:38 -0800 (PST)
Message-ID: <5e3b1cb5-bfe0-e4ed-5de6-c251b061d4b3@linaro.org>
Date:   Tue, 24 Jan 2023 11:40:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] thermal: sun8i: convert to use macro
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, anarsoul@gmail.com,
        tiny.windzz@gmail.com, rafael@kernel.org, amitk@kernel.org,
        rui.zhang@intel.com, wens@csie.org, jernej.skrabec@gmail.com,
        samuel@sholland.org
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20230123102319.37710-1-frank.li@vivo.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230123102319.37710-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 23/01/2023 11:23, Yangtao Li wrote:
> Use TEMP_CALIB_MASK macro instead of raw number.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

