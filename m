Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44807725278
	for <lists+linux-pm@lfdr.de>; Wed,  7 Jun 2023 05:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240454AbjFGDmi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Jun 2023 23:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234518AbjFGDmh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Jun 2023 23:42:37 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02EE719B7
        for <linux-pm@vger.kernel.org>; Tue,  6 Jun 2023 20:42:37 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-650c89c7e4fso7041143b3a.0
        for <linux-pm@vger.kernel.org>; Tue, 06 Jun 2023 20:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686109356; x=1688701356;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5amr3SUDsqzdSzy/47lg6a8IdfkrVtyksktE2N9uX2s=;
        b=pG9v16DF0kJRXNnHQrtaQv1di9rgPuLK9JyDO3nX1wsvYUfkmBuWSVDD/4etvL6rG0
         khItlfqQ7lZIknwFLwzRVPHK3llkPaK3WF7/xIxfy2hiW+hAgMjO1lhXeF54pnVVSoFM
         A4RbZaCKs4AlHPD5LCDp+wUfA1PeQOsuz3wMIqgdqJOADCpZ3eaVI5jqrCP6kTU7kCWD
         fOQr7/2PYxeLJhs7T//i14GQlS0k/E5+oG+u+vZnpC3mSk03RHlyUWgMMrEuVHsO7z7e
         qNwhaX1Nj1RARTxkfp6taoYulUx/qw8WE3VPV4QxjdyAhPGTjR2XlJc+RB5HJbkWe7a5
         Awnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686109356; x=1688701356;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5amr3SUDsqzdSzy/47lg6a8IdfkrVtyksktE2N9uX2s=;
        b=KEPrs7nM6QZFTd0vF/7z7wz9DYbKDJ9cID/xs9iwGttHFlxNJqXXhv12+DmDp8nEOq
         hHHxQWHskdcHOJ2X9f6jSreIWQz+SrUa+6AuTNFjdTDr8nbnaaVAfQ5j8cKheSW+x0G5
         wWY7InxvitIm7R8Ul4rN3lNWw8T+wJipnrGxoi+i2/yohgGaa1OgJfojyifGqVTai9r/
         dm2FnfE71zK65ODUoouF9m/61kr+H2xxKG+SDHaZcORWySovOIldUqYi10rhT7HiWA5V
         1dhRWub3CiMMipwCNgYQeJYDe/cAO2L3vMeSbzq1XJV4TjJKNomlt5K/ZXAHDI7oiFwT
         ZpOg==
X-Gm-Message-State: AC+VfDwYC353YjIVDXGb4EttqGpQJNA/3t/h1ZCQcxlto387HKL1sD/S
        rRMQS6EynXviWM6eqU0DclNztSn0tEWOnkC+jXs=
X-Google-Smtp-Source: ACHHUZ5jCaF84UNonxB7KCxf8AOMiF/ye9ip8+WqDMTb1jALjhGRnv+csTkREcknVbiC31dS9AgSNQ==
X-Received: by 2002:a05:6a00:1794:b0:64d:632a:d0ac with SMTP id s20-20020a056a00179400b0064d632ad0acmr5534707pfg.25.1686109356519;
        Tue, 06 Jun 2023 20:42:36 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id i8-20020a635408000000b00520b677c645sm8092718pgb.41.2023.06.06.20.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 20:42:36 -0700 (PDT)
Date:   Wed, 7 Jun 2023 09:12:34 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Mason Huo <mason.huo@starfivetech.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Shengyu Qu <wiagn233@outlook.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v4 2/3] cpufreq: dt-platdev: Add JH7110 SOC to the
 allowlist
Message-ID: <20230607034234.rgjb43gchkdtpuxw@vireshk-i7>
References: <20230606105656.124355-1-mason.huo@starfivetech.com>
 <20230606105656.124355-3-mason.huo@starfivetech.com>
 <20230606110804.qns4rolrrj2gku6w@vireshk-i7>
 <20230606-unsmooth-slip-c80fab59c9b4@wendy>
 <f29a14dad3d744bba54e561a050bdfaa@EXMBX067.cuchost.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f29a14dad3d744bba54e561a050bdfaa@EXMBX067.cuchost.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 07-06-23, 02:04, Mason Huo wrote:
> Or you can just ignore it?

I can do that :)

-- 
viresh
