Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3F2A76F90F
	for <lists+linux-pm@lfdr.de>; Fri,  4 Aug 2023 06:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232724AbjHDEm0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 4 Aug 2023 00:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjHDEmY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 4 Aug 2023 00:42:24 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 624A6180
        for <linux-pm@vger.kernel.org>; Thu,  3 Aug 2023 21:42:23 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1bba54f7eefso18931255ad.1
        for <linux-pm@vger.kernel.org>; Thu, 03 Aug 2023 21:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691124143; x=1691728943;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WhhAvXcLPp41DDPWdXv76vCKorVBoPGcJuLdcgKOZzY=;
        b=CWLQdtDXWwvZv34z39X116TeBtMFjBj5iQAdzIO7mlp3mKO0CHIbDYIzlkYedweBR1
         +EVBj5HVLAUC3BP8R46xItOnAbJYAgrQPgJRdlEkZvZfSN+H3hc/tTMrOLkJy3dcggWW
         ZmjzHd7E9fqfFrdesEcRGKb2hGQV3Dg0KIQWMzCGnnye4k3gpZLLx1EhM27r3VnNe+k2
         mobIjWeZ6vTfSUpmq7zNN/wZsSj7+KIhf2K9vPnW2LHuf/SNjpLXfYGl8k232yRGrHWT
         3WBVct2i2L3bXeEEMeY2phT3NLQvayBmS4cPazsUgqLBctQAEp/0eGwoUUftFAN2MHQZ
         8pcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691124143; x=1691728943;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WhhAvXcLPp41DDPWdXv76vCKorVBoPGcJuLdcgKOZzY=;
        b=C8Oufmd+RN6YE3b3RhK/hZWBJca9JSYXkLPQNCX+NsoBS0ricnEVt8xhcqIj75nG7z
         Vhcsp/pLBw9MZquoXKh2FXPrx8xQXgU6JP8CJ0ZNbK9LuKKK6iVzwIGzcyq6Xuy1h/ng
         OsK7eZGePEm/e8kr6Pb/pVfRRRqF9fUwZG/INEob1/WXB7vjwcNPkQIQ2J/UMUuzurJ3
         0EkQWVokxh+CLxhVmXvHwDw3EoH4ZwdSYS6D3Vtr1CVIdx4lmMxSYrOpgP/tzwQlg0Wz
         WS+hQjbgDJg6nmyC4l3SeY+ZT/TGr4aPRcH9016dJVTo6Czsp+Vh69xoQ1PcK8sB7+8h
         FP0A==
X-Gm-Message-State: AOJu0Yy/D9zEdjNr5rsqycLwZ4LwqJF6xA92n3Nb3oSRycem7TzX9Y8c
        BkGDDyohYhijRKhOUpo287i4dQ==
X-Google-Smtp-Source: AGHT+IHVStLeBwE0WuFzAlxE5M1adCY0bQ4JoZ/lSAvfsGjyMlxW760cSktFwB69LZ5NsgOcqkIsxA==
X-Received: by 2002:a17:902:e886:b0:1b8:3936:7b64 with SMTP id w6-20020a170902e88600b001b839367b64mr1071513plg.1.1691124142814;
        Thu, 03 Aug 2023 21:42:22 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id h8-20020a170902748800b001b5640a8878sm676697pll.180.2023.08.03.21.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 21:42:22 -0700 (PDT)
Date:   Fri, 4 Aug 2023 10:12:19 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     David Dai <davidai@google.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Saravana Kannan <saravanak@google.com>,
        Quentin Perret <qperret@google.com>,
        Masami Hiramatsu <mhiramat@google.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Pavan Kondeti <quic_pkondeti@quicinc.com>,
        Gupta Pankaj <pankaj.gupta@amd.com>,
        Mel Gorman <mgorman@suse.de>, kernel-team@android.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] cpufreq: add virtual-cpufreq driver
Message-ID: <20230804044219.ng26jwcomprguoi3@vireshk-i7>
References: <20230731174613.4133167-1-davidai@google.com>
 <20230731174613.4133167-3-davidai@google.com>
 <20230801093620.ggz25g3faxycp44q@vireshk-i7>
 <CABN1KC+4kznd54-dZf4PiftxiqBfkGxpsqngaX4=dGf1pNg5Ug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABN1KC+4kznd54-dZf4PiftxiqBfkGxpsqngaX4=dGf1pNg5Ug@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 03-08-23, 09:50, David Dai wrote:
> > Why do you want to use this and not module_init() ? Then you can
> > simply use `module_platform_driver()`.
> 
> We found that using postcore_init over module_init results in a
> small(2-3%) but measurable benefit during boot time for VMs, so this
> is an optimization that I’d prefer to keep.

Okay. That's what platforms normally do (kick in cpufreq support
earlier), so we can boot at a higher frequency. Just wasn't sure if it
matters for this driver too.

-- 
viresh
