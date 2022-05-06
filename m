Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD06D51CFFC
	for <lists+linux-pm@lfdr.de>; Fri,  6 May 2022 06:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388904AbiEFENI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 May 2022 00:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388898AbiEFENH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 May 2022 00:13:07 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD0B65799D
        for <linux-pm@vger.kernel.org>; Thu,  5 May 2022 21:09:25 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id t13so5162633pgn.8
        for <linux-pm@vger.kernel.org>; Thu, 05 May 2022 21:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XsoBtkAebOgjtMxymQU1wBQgO9U1OW2Xx5QkHSE5DvU=;
        b=rGUsO7GehX3b88mwxY/zTcVQU8oj8k7UYuN4o173aiyqlC/wvG1bQc2Fi1rXhtE3Bx
         36+GftgNTCKYaGOqx/CeIa0XZaYCfOYsiabPJlmqnYBxpSbmchkntincElTwg/HoLuJi
         e+lCHyvNqeQZqp1F5XV1AE1AAlRnEUm5g5DGIn5EdsZvvTunX5GoU0ZwZkI7YE8lQKEs
         vEb4rR/TkUiuN4JMzIa1nU3YFANscD/rgHmiXMbPtgYTU4nxHRNQelZogez37nGnPYaW
         6D83cfDUjFuvHsBfG0DgWLAG9QDRFYy3eKhq0ZffkCkdgvNJ29OtPapnnyqNAzzVmxZX
         Z47w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XsoBtkAebOgjtMxymQU1wBQgO9U1OW2Xx5QkHSE5DvU=;
        b=5eZCHI+dpq/OLxP/p1cFxX/CzAAgJMDfzSsw9tJBoVEzsStfV/YGdwSAtc4C9kGhsM
         z24WNSVsnY0hU5oLb+C3mcI8o4GzMfJU8MkVNJJYJZXmXAkFtEny4xkwiHUMpGsNOjNn
         jb50zNsGe7kHiqXdnrPCRUFDXFHGtL6d46PdXh87W+xrnxbCtxD3SZfeSvvw8Ss+Ase+
         c3ZxzMEVOXziuX7BXDZw0gmCsAD/0BOu03sk0cKc+bxbYNTCkn90lcMYR4Ygo94YKIS5
         yJDLDFw+R5R+A2tHgQIo1rFbyw8CUyDMTK0T2pMxHKu2k0tdKCEqUpomXnP5yFO4lz17
         Yb3w==
X-Gm-Message-State: AOAM531KWJNqVBU+akp+5YAHugGtg9NnHxeKq73M03IZ4PyKIMA0cxBQ
        VSKUknNpUGy0I5ZjFIegzeyr7A==
X-Google-Smtp-Source: ABdhPJwx7b+xmNh51JOkVexQJYw4Ub0h4b4eREe4WGecOLA4rSVA2b7lG2+t2YveniTshYGKqRBPJw==
X-Received: by 2002:a65:5245:0:b0:39c:ce49:e97d with SMTP id q5-20020a655245000000b0039cce49e97dmr1193052pgp.301.1651810165472;
        Thu, 05 May 2022 21:09:25 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id e30-20020a631e1e000000b003c14af5060asm2125467pge.34.2022.05.05.21.09.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 21:09:24 -0700 (PDT)
Date:   Fri, 6 May 2022 09:39:22 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>
Cc:     rafael@kernel.org, robh+dt@kernel.org, krzk+dt@kernel.org,
        matthias.bgg@gmail.com, jia-wei.chang@mediatek.com,
        roger.lu@mediatek.com, hsinyi@google.com, khilman@baylibre.com,
        angelogioacchino.delregno@collabora.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v6 02/10] cpufreq: mediatek: Add
 platform_device_unregister when driver exit
Message-ID: <20220506040922.n7l3kswvsh4re5xr@vireshk-i7>
References: <20220505115226.20130-1-rex-bc.chen@mediatek.com>
 <20220505115226.20130-3-rex-bc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220505115226.20130-3-rex-bc.chen@mediatek.com>
User-Agent: NeoMutt/20180716-391-311a52
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 05-05-22, 19:52, Rex-BC Chen wrote:
> We register the platform device when driver inits. However, we do not
> unregister it when driver exits.
> To resolve this, we declare the platform data to be a global static
> variable and rename it to be "cpufreq_pdev".
> With this global variable, we can do platform_device_unregister() when
> driver exits.
> 
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> ---
>  drivers/cpufreq/mediatek-cpufreq.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)

Applied. Thanks.

-- 
viresh
