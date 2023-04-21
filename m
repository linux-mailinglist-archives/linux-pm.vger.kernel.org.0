Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDE3F6EA52C
	for <lists+linux-pm@lfdr.de>; Fri, 21 Apr 2023 09:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231383AbjDUHrn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 21 Apr 2023 03:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231347AbjDUHrl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Apr 2023 03:47:41 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2B6C902D
        for <linux-pm@vger.kernel.org>; Fri, 21 Apr 2023 00:47:35 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-63b73203e0aso12502370b3a.1
        for <linux-pm@vger.kernel.org>; Fri, 21 Apr 2023 00:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682063255; x=1684655255;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+szQLnykesBFXcAq23XEggqpIQQDxm1SpvIgtBdDdQc=;
        b=ilzo9c2eLpG5BOdzTnJ1tkqhp9s2JwqSPj4VzslIQPFHhDhVdpoBWfev2lcvMWYGAk
         LWFmGUCMpF5uNIxObmAY1y7Cwz0tVv3fXlx7DirA+zGhp0gHsbVrJYts4KlIEMaVNShW
         s58ijis6EBKvlJ4RD7wg+QyKC9HgwxlOoMmGiStZytqdwsRGkEPAbnd97VSChuXp0WX2
         +zQZucIclSJNEB8LrJuUWNbLETDbXuARP7J4BpZwlsp3F2KaeVnEGE3ElxagEGNuNPMX
         MhhrdCYxE4HJypzTxNex6giAt99IH51nzCLsiUbRV5I8Mu3122JtZN6LienGlMgmPFwP
         f7Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682063255; x=1684655255;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+szQLnykesBFXcAq23XEggqpIQQDxm1SpvIgtBdDdQc=;
        b=afelp8y1Q7Vy+P/h629qTsWpoVhclOkciK57auwHabsBO/4XICNhhmUboCnokMS6pn
         y4TpO8sajIppo7Xu4nw+utkJUCucsLZeSBFj9GogHZha0txkXyx+x7D69IGHEw5opoSS
         lm9updUhv0l4LYwV2dAIFlXNSWE3qJwX1br5eDnjS5G02pGDwULh9ub3Hc5pmOnF+J9c
         Ip4X0BjR8WAmvwA9CFx1M2Dr17K0iZojwQ21ZNqeMGPHzidmo+dMrqX5fTtx8JsBsw1I
         bzp64L0EPOKZEZb92UGOKCf1fnz014z1oZCTgADSLKYQxFPs5MDYnxms6B+2Nst+fq2B
         C3Kw==
X-Gm-Message-State: AAQBX9c6wRDrOIGnMxS2uil1lxWuCDWHPtRTr2g7OwwAcXxonl0eHouI
        1d7SnCMCqyW0wbO5hV3VXpwjjG+rjuN3xQHshqY=
X-Google-Smtp-Source: AKy350YWXAjbfegp64SHi2kVBPvjPJX53ws5n0MUPi+U6yw4/3MYRHocvwLpECOt3NyF2XecW9aODA==
X-Received: by 2002:a05:6a20:3d17:b0:ee:4210:6ca with SMTP id y23-20020a056a203d1700b000ee421006camr5099315pzi.7.1682063255147;
        Fri, 21 Apr 2023 00:47:35 -0700 (PDT)
Received: from localhost ([122.172.85.8])
        by smtp.gmail.com with ESMTPSA id x7-20020a056a00270700b0062ddefe02dfsm2464680pfv.171.2023.04.21.00.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 00:47:34 -0700 (PDT)
Date:   Fri, 21 Apr 2023 13:17:32 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Mason Huo <mason.huo@starfivetech.com>,
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
Subject: Re: [PATCH v1 0/3] Add JH7110 cpufreq support
Message-ID: <20230421074732.hazan2cpmozpht6x@vireshk-i7>
References: <20230411083257.16155-1-mason.huo@starfivetech.com>
 <CAJZ5v0j_MCv6e08qYKMhiZ2kKzovO+W4scMAKUokNJvt2myS-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0j_MCv6e08qYKMhiZ2kKzovO+W4scMAKUokNJvt2myS-A@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11-04-23, 17:58, Rafael J. Wysocki wrote:
> Viresh, can you have a look at this, please?
> 
> It is very similar to the ARM thing AFAICS.

Sorry, I missed your email earlier. I have already applied the cpufreq
specific patch now.

-- 
viresh
