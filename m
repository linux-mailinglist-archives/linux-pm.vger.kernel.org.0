Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD2450EF08
	for <lists+linux-pm@lfdr.de>; Tue, 26 Apr 2022 05:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236154AbiDZDLX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 25 Apr 2022 23:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235923AbiDZDLW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 25 Apr 2022 23:11:22 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB40D6EB08
        for <linux-pm@vger.kernel.org>; Mon, 25 Apr 2022 20:08:16 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id fv2so1698315pjb.4
        for <linux-pm@vger.kernel.org>; Mon, 25 Apr 2022 20:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lxaaZ0Sg1rxH5LBqG3Zw/U/YUfjYUA14RgnWfQ+BxmQ=;
        b=M2PrWDxMm3qMrfJh5fnYfrhPMesfO/d5/Lue+1fV+213TMOiZ6aC42XvOftBuukC5f
         iRP1fyAyIRwLUxA9Hz9skGo9KEYVsTRYFTd7W2T/m9AMXC5kZTGfwsBJs5z5WCT6XOui
         SgKY/jSFUYcm6n+XozCZuc4gUh3MgJBQbFGjuL8L6sZU75VvE+nascDifHkUzFgE3rz/
         CqGl/05Xt96UMQLkjNSJ7YlgtVngwaPLDDteu8HJZR9x/Yr9qiNrb2YTRNizZYR/edrY
         nN/K5jfGQF4fSkTHs5vKsa45IxNiPo4sAbMOjOrj3iR1567TqA88OFD1EExLDwSqxi+8
         97Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lxaaZ0Sg1rxH5LBqG3Zw/U/YUfjYUA14RgnWfQ+BxmQ=;
        b=pxZl7vFyWU2KXgwc6KTCYSdyppJID/UppRYiZHngRh7vaPaeFH5uO+7JZMaTV/WkGH
         6Vyp09r8IVnqgAhFr4bnaW4J0lZiHZ4QsKg/VR96Z1bwMdWX1wHhmP7sB9hX3EkpEz/c
         3tSxhpUrYiF4P0tVB1TyfXRKg0EynGVPYNOSYfcLNcTCyi4fzTCY7d9hqxyBy8ozfDd4
         K4gptuwdPHtAp4lBAWsObFdJlNSLkfrG6k0AaqCzkA+ZQB2MC728ePfumjb3+aFiia0z
         TQj1gb+ocZ4JJa6dvusR2H75ILDppsbeWIS3+Nbo9PMlTrmsY7aEaF96NttqJuYTeWlp
         1/eQ==
X-Gm-Message-State: AOAM531Sv3yVpN2H3znjrScFsptt6VeFyEvgOmbFEni1S8eeJN2Mg79N
        /EqOnMFn61Lkm0qCOxF4IgCEhw==
X-Google-Smtp-Source: ABdhPJyyDFe88WZs+G+zWXIf52GYbQ/Ine3wexitMP/ikcnDhXrVz7vTXaepRMY9xyHRHTb05bQGhw==
X-Received: by 2002:a17:902:868e:b0:15a:7c9d:b11f with SMTP id g14-20020a170902868e00b0015a7c9db11fmr21830948plo.151.1650942496243;
        Mon, 25 Apr 2022 20:08:16 -0700 (PDT)
Received: from localhost ([122.177.141.190])
        by smtp.gmail.com with ESMTPSA id w4-20020a056a0014c400b004fb0c7b3813sm13429723pfu.134.2022.04.25.20.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 20:08:15 -0700 (PDT)
Date:   Tue, 26 Apr 2022 08:38:10 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Pierre Gondois <pierre.gondois@arm.com>
Cc:     linux-kernel@vger.kernel.org, Ionela.Voinescu@arm.com,
        Lukasz.Luba@arm.com, Morten.Rasmussen@arm.com,
        Dietmar.Eggemann@arm.com, maz@kernel.org,
        daniel.lezcano@linaro.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Fuad Tabba <tabba@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Rob Herring <robh@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 0/2] Enable EAS for CPPC/ACPI based systems
Message-ID: <20220426030810.wj7mdhjhzs2s6y7h@vireshk-i7>
References: <20220425123819.137735-1-pierre.gondois@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220425123819.137735-1-pierre.gondois@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 25-04-22, 14:38, Pierre Gondois wrote:
> v3:
> - Remove efficiency_class_populated variable. [Viresh]
> - Remove patch "cpufreq: CPPC: Add cppc_cpufreq_search_cpu_data"
>   and access cpu_data through policy->driver_data. [Viresh]
> - arm64 code only acked by Catalin [Catalin]

Applied. Thanks.

-- 
viresh
