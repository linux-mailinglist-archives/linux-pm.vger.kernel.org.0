Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70D55591136
	for <lists+linux-pm@lfdr.de>; Fri, 12 Aug 2022 15:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234542AbiHLNLl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 12 Aug 2022 09:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238278AbiHLNLh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 12 Aug 2022 09:11:37 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD9E6C76B
        for <linux-pm@vger.kernel.org>; Fri, 12 Aug 2022 06:11:33 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id z16so1149962wrh.12
        for <linux-pm@vger.kernel.org>; Fri, 12 Aug 2022 06:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc;
        bh=oBbits87Sh54Pv6OEfDdfWZYrwVvKln+o+HoHPpBNT0=;
        b=s4ddTScLTJaDLUFkiZ3TBa3nJtFTnumXRrFoezKDY9/HeFWIew4zitQN4HCRxdSuMN
         AI1TlchQml2Nbne0zQcQvvVkELdYXXjY9CRNmdUMpNH1ZIQCr0iTGvM4zW7BH74GccBr
         LZM0Stq/nIwqOeEWQuxBUSxqFsxd4FqhzRhZapA9vGlCIj466gdc66fFKTY57C01wlVx
         YawjSwDBzBtyktrL9O/Colyw1wBIFwJiYCVVJ6bhrWLll9yerrK+kByLaITALFhvlzSk
         IH1Zxzo+3qkM1G8YTG1HfSGfNNUK5T41HOVE1g+P8JThNJeigd5Ka01AzXV0G+hcDFD9
         jO2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=oBbits87Sh54Pv6OEfDdfWZYrwVvKln+o+HoHPpBNT0=;
        b=DW0in6j4cKmNd7ij1cVemZH8RHp9JRo8PuSVxlUAXbwy0+AVOj/TBZvzTWBafUerUK
         WJhpptOaHDxd36s3Q62L17HSCTQbpk8tfpVrlHFpVLQwvKGbjRN8KgN+86utp3bQI/E3
         VUbeEbcjvqKjNE8x3RsbcFbe8H1Hc2ASq6TuKSTQont3r/99w1Gp0sLwlrakzd77U0Zh
         Nn5UAIhII5kE8qHrxkxZienjDSHNUBz0WOC67KzkQEYWvNui1OZHACafCa2MvEg6k5ve
         P7+JPpuXQFXy29Ljgqj82rrYPOgIBr66HI80wxNIf07t51h4E0GmejHpFmizn2hoMyEN
         Mjdg==
X-Gm-Message-State: ACgBeo1AYOK/y9AM8X2hEiltzgMvZ/ot54r0KI2UuzwPE9wTAuIdMX7y
        7rbg19NSwO7uFnb+SPz/hEsh+g==
X-Google-Smtp-Source: AA6agR6AuxoJ9bwmQi0vU/ySTcZsqisySBUe5l5ptauxg9gq8coDfUkOE+L1t6nDa3qVGWnjHUlVsA==
X-Received: by 2002:adf:f346:0:b0:21f:13ec:cacf with SMTP id e6-20020adff346000000b0021f13eccacfmr2080589wrp.525.1660309892485;
        Fri, 12 Aug 2022 06:11:32 -0700 (PDT)
Received: from localhost ([109.180.234.208])
        by smtp.gmail.com with ESMTPSA id e17-20020adfa451000000b0021e30e9e44asm2000849wra.53.2022.08.12.06.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 06:11:31 -0700 (PDT)
From:   Punit Agrawal <punit.agrawal@bytedance.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v1 0/5] ACPI: Device enumeration rearrangements and
 parent field elimination
In-Reply-To: <12036348.O9o76ZdvQC@kreacher> (Rafael J. Wysocki's message of
        "Wed, 10 Aug 2022 18:11:58 +0200")
References: <12036348.O9o76ZdvQC@kreacher>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Date:   Fri, 12 Aug 2022 14:11:31 +0100
Message-ID: <875yixk3ng.fsf@stealth>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

"Rafael J. Wysocki" <rjw@rjwysocki.net> writes:

> Hi All,
>
> There are still opportunities to clean up the ACPI support code and
> this series is part of the effort in that direction.
>
> It makes changes without functional impact (AFAICS) to the core ACPI
> code related to devices and to some of its users.
>
> Please refer to the patch changelogs for details.

Other than the single typo I noticed in Patch 2, the changes look good!

If it helps,

Reviewed-by: Punit Agrawal <punit.agrawal@bytedance.com>

Thanks,
Punit

[...]

