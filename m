Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93B1B6EA4EE
	for <lists+linux-pm@lfdr.de>; Fri, 21 Apr 2023 09:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbjDUHhM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 21 Apr 2023 03:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbjDUHhL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Apr 2023 03:37:11 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C4F42D7E
        for <linux-pm@vger.kernel.org>; Fri, 21 Apr 2023 00:37:09 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-52160f75920so1383034a12.2
        for <linux-pm@vger.kernel.org>; Fri, 21 Apr 2023 00:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682062629; x=1684654629;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ws1r1MXeCEvX69yEkTPurpwAbmpa457Fai+VNzf4DEY=;
        b=ZQI2rEXhdANrf45MNGJf9HILUhJ4Bw6VisyeMQEy8EQAbpmBylMsOd6Cq20ZKh5/LX
         AY134L7OpDWpunRaNAWDWg95F+DV7LAYpzTQz8ELy8TTCeLGqGNK+PhP25hmbTgb0nb0
         jY9hez/PA31l7xfEFsSuLEyYQthFkKph53ing2++kv/VNi+D+ljKu800/rTZXgUEBh+1
         oR729FDKLksqtHXQlpzRn6fHM5atkCIh9xVISU8aopS9HUr4aO/+VHNC6/HRhp34BIbO
         chH3mUJfv8/RMtoDdht5rmhRJXgLWFHqoFzdY4ZUYbWN48ktBXdhz4fO5Ea8FmGx1E/A
         Og5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682062629; x=1684654629;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ws1r1MXeCEvX69yEkTPurpwAbmpa457Fai+VNzf4DEY=;
        b=XPRtvPgnUXPC4ynYsCJNjgvbi5hByjQ+bfywoqDXv/leZqY+PshWBwIl6TYpxpt2yR
         IRhx5ADvWrVq0jZlxEVppngA1QebzjqTwNtr3JfBhDA9x90jtHvOt9W+eDl3H+LwiTMF
         jdqd60Rhuoz9F+0mYCwuqpEx03YN7Z3zXjqsS5yd0hFVYIghCPaaI3D1oGV3txPBEQNe
         kZ1AxEcZcLY/o11quG6wLoILuHzNCMUOEsef9k2BpbunAIMR7pqRvZRtT57I0CAiSnrH
         WuqG+Pu7+G6Eu+GpjzH/QmqEvaFYBJwJh9G/vTGqaXHugJRhrFoCCnDpiKPGe+auAAE3
         0dFw==
X-Gm-Message-State: AAQBX9emCFbb5udx+dJL2GejBBIGDBuQaw7oWRKS3xMOgXmMUoJJUVk+
        RECzovyzIqcxWxlI7lCjWLwwHQ==
X-Google-Smtp-Source: AKy350Y3tjzqUpc2PpA1KHTguoo9hq4vYUDrqdHuUj/CrJexpNdOvtSR6Ua8+SfReOPpPBSjBZl3tg==
X-Received: by 2002:a17:90a:b38c:b0:247:af63:483 with SMTP id e12-20020a17090ab38c00b00247af630483mr4017603pjr.46.1682062629025;
        Fri, 21 Apr 2023 00:37:09 -0700 (PDT)
Received: from localhost ([122.172.85.8])
        by smtp.gmail.com with ESMTPSA id c19-20020a170902c1d300b001a50ede5086sm2200481plc.51.2023.04.21.00.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 00:37:08 -0700 (PDT)
Date:   Fri, 21 Apr 2023 13:07:06 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Mason Huo <mason.huo@starfivetech.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Shengyu Qu <wiagn233@outlook.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 2/3] cpufreq: dt-platdev: Add JH7110 SOC to the
 allowlist
Message-ID: <20230421073706.oi65cbuhljcu4upi@vireshk-i7>
References: <20230421031431.23010-1-mason.huo@starfivetech.com>
 <20230421031431.23010-3-mason.huo@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230421031431.23010-3-mason.huo@starfivetech.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 21-04-23, 11:14, Mason Huo wrote:
> Add the compatible strings for supporting the generic
> cpufreq driver on the StarFive JH7110 SoC.
> 
> Signed-off-by: Mason Huo <mason.huo@starfivetech.com>
> ---
>  drivers/cpufreq/cpufreq-dt-platdev.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
> index e85703651098..79537d0ed7cf 100644
> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> @@ -86,6 +86,8 @@ static const struct of_device_id allowlist[] __initconst = {
>  	{ .compatible = "st-ericsson,u9500", },
>  	{ .compatible = "st-ericsson,u9540", },
>  
> +	{ .compatible = "starfive,jh7110", },
> +
>  	{ .compatible = "ti,omap2", },
>  	{ .compatible = "ti,omap4", },
>  	{ .compatible = "ti,omap5", },

Applied. Thanks.

-- 
viresh
