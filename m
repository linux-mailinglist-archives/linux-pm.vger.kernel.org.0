Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3AD354DA2C
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jun 2022 08:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358909AbiFPGHN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Jun 2022 02:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358749AbiFPGHJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Jun 2022 02:07:09 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8076AE05
        for <linux-pm@vger.kernel.org>; Wed, 15 Jun 2022 23:07:07 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id k7so478380plg.7
        for <linux-pm@vger.kernel.org>; Wed, 15 Jun 2022 23:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FzWTxlTEFKqkIMF8VbZ/u79TNhEtmzp0He+3d50zpFI=;
        b=gluYI+a2xyVpoiDSRgRE3aiBySLr/MvVpJhF/5gH6NQ/IzZ5FBsroCTSnkAer7SxZz
         W6fvUIoaXyksi09EF38+yDEhuCr6ISFS9WLGoqsKdwJxIrOmq3f6awfAjrFtqk9Z2Hln
         S6+CjFTUqSxcRm4xE+iktjVPZFTZoOJBAd6gIyhHJM0t2/3GINPkAVOwR8IwUtDJxw6+
         WyMce/7H8xQPnd6K4L9mgoxsF9orwEK3zLUZS2p61QDJCBlXxWqP9dHqNpDxCNCZe6yP
         iqJFrJt/A2Hpr88pklbj4Gmi4nOxcHONmk9BnypVTTMUt+EDBunXkq4YjNO1HqcQnrxp
         8AdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FzWTxlTEFKqkIMF8VbZ/u79TNhEtmzp0He+3d50zpFI=;
        b=gv7dUYkwSiFDXZZvbbTVjgUhDLocG6/CgZ0WBrK8+fcFaRYHitNXYGRKED0zIyJy5N
         TeIAKEKioo3xLfTnMX3UnrsxZgB5kQUqF0rtGxSbSpvvHaQHfUm3PUhZeQDBbjwTsy5M
         WLmSsjxOaXVomYK05tUoVnOGqZ8Jrx0syP/nRc0WbnfpPfUNp/0ndU6guU7fkweMy+f0
         K37xbXEOnoplzw+QD+8kolp1+OSQAtg+WHbGU0rMP8MW4t19y8iE1ehKYyLBp2gt0FQy
         5a8+YFkLy8So55A3WHoPqQv4Mv8bNtOOJqD5xokkWXsScWbtnppqLwJcpESTqAUaiRUu
         EuJg==
X-Gm-Message-State: AJIora9mAih7Tez9F9w+Vo8IRqc7C4nEGfzjA21eTrkBLchOxYimj6KE
        CeE1WaztWTP9y+SIEhN6pX/yEsQgXwePvw==
X-Google-Smtp-Source: AGRyM1uFVCYBfTZ45/hWPa8qzjODUT5VMMm2n4TRbyVDluISTJi+yoWsZCF8oFjXmUxFfWbuNSVw8g==
X-Received: by 2002:a17:90b:3a8b:b0:1e8:3056:10fc with SMTP id om11-20020a17090b3a8b00b001e8305610fcmr3349878pjb.145.1655359627030;
        Wed, 15 Jun 2022 23:07:07 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id j3-20020a170903024300b00161947ecc82sm695345plh.199.2022.06.15.23.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 23:07:06 -0700 (PDT)
Date:   Thu, 16 Jun 2022 11:37:04 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        regressions@lists.linux.dev,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Nicolas Dechesne <nicolas.dechesne@linaro.org>
Subject: Re: [next] arm64: db410c: WARNING: CPU: 0 PID: 1 at
 drivers/opp/core.c:2265 dev_pm_opp_clear_config+0x174/0x17c
Message-ID: <20220616060704.xcxdqlm5fo7e7et4@vireshk-i7>
References: <CA+G9fYsP05V+bVoZsPto-ZdZra3Mo4unBjNqyk1dOjfMEK1XWg@mail.gmail.com>
 <20220615052503.6dvtnuq2ai45pmro@vireshk-i7>
 <CA+G9fYvifz5xDDNjoJBt2MRfdqwDtNf53teWXUs5QCOn2uhbfw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYvifz5xDDNjoJBt2MRfdqwDtNf53teWXUs5QCOn2uhbfw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 16-06-22, 00:56, Naresh Kamboju wrote:
> As per your suggestion, I have tested [1] this tree and branch and it worked.
> The reported kernel warning has been fixed.
> Thank you.
> 
> Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

Thanks Naresh.

-- 
viresh
