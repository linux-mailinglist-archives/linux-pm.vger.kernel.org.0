Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB5B74F7A5
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jul 2023 19:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232126AbjGKR6Z (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Jul 2023 13:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232049AbjGKR6T (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Jul 2023 13:58:19 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 162D310D2
        for <linux-pm@vger.kernel.org>; Tue, 11 Jul 2023 10:58:18 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3fbdfda88f4so61585175e9.1
        for <linux-pm@vger.kernel.org>; Tue, 11 Jul 2023 10:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20221208.gappssmtp.com; s=20221208; t=1689098296; x=1691690296;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OD7Un52lM1nQCq9xqwKkXllli+tL3PRiZw04TrZHK0I=;
        b=fEi+nNDxTAXsLwgekHmMgnk/oFoDgCszQlDAfzbCbZZK61xqf2AbTYQvzi1ffmah/C
         EI8nSl/4i4l4XGE9RNS9rr/eLCyGlD6HUEaDZOad4VwLGIy7JMy3hpHuQLqwLjQtID5X
         FHR2r/oP5KbzQf8W7gZLDRJS0UKSRcd5sbDcCMmQbsDREww08S+EcWcAyNCLIliw0N+i
         gGbTzQ5EVM3uPTyhAfJo2tBGNO/Ro50yPAydaethQkEer/RLnyVBkVEOWKo/cheNj2Tz
         Jm9RT4mMy2tVjUbTyJtQtBXaQuD6KBwh35ryydzXbfPpOHEqJJXhXJkptlbh6610bpFm
         oJtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689098296; x=1691690296;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OD7Un52lM1nQCq9xqwKkXllli+tL3PRiZw04TrZHK0I=;
        b=B8qLn+KLYnKxCBpC3hWXAPN097ItFukVPKovm+C9f9/I1rKHrirmhNapPVMs78uz7A
         +SVs4XEL38a0/9qEl8JT722NVS4+LjWZQtGXc90/Rm+/Hp1vUZzwznPv2ZWeNdesYTMF
         HQPbZcQblCN8KAOuAX9x80YxSrJiGSFMWNaPn3Drz+qYBEykNirOWqSWwk57notF9nAK
         AnFEqd3/MTvcAYU/w1iDE90xqSWTuj+FfLu0F57F+NvNrdGvRk4enlWeaIIwAw9fidwN
         yszj9u7tFgA+SU35khVil4U7ijHnR0vqcLw1SvL2GpBXclzS1Z2rdoYnwRJDfHtbULVS
         Ch/w==
X-Gm-Message-State: ABy/qLYVROo9uZf6W2SYRwuEWLFu7mSFT1Hf9CsJ7E+M681XtLIGCD2u
        0so8kLCVwrO+a6Xm7v491SmToA==
X-Google-Smtp-Source: APBJJlEbj13xi6YmgAau9Qx0g364idTDfv8C9e/JLyeOs5Hn6W2evY+sN29+F+a0fXbv5uBiofW9gA==
X-Received: by 2002:adf:f590:0:b0:314:149a:4f28 with SMTP id f16-20020adff590000000b00314149a4f28mr11383680wro.23.1689098296506;
        Tue, 11 Jul 2023 10:58:16 -0700 (PDT)
Received: from airbuntu ([104.132.45.107])
        by smtp.gmail.com with ESMTPSA id y18-20020adffa52000000b00313f031876esm2850524wrr.43.2023.07.11.10.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 10:58:15 -0700 (PDT)
Date:   Tue, 11 Jul 2023 18:58:14 +0100
From:   Qais Yousef <qyousef@layalina.io>
To:     Kajetan Puchalski <kajetan.puchalski@arm.com>
Cc:     rafael@kernel.org, daniel.lezcano@linaro.org, lukasz.luba@arm.com,
        Dietmar.Eggemann@arm.com, dsmythies@telus.net,
        yu.chen.surf@gmail.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/2] cpuidle: teo: Introduce util-awareness
Message-ID: <20230711175814.zfavcn7xn3ia5va4@airbuntu>
References: <20230105145159.1089531-1-kajetan.puchalski@arm.com>
 <20230105145159.1089531-3-kajetan.puchalski@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230105145159.1089531-3-kajetan.puchalski@arm.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Kajetan

On 01/05/23 14:51, Kajetan Puchalski wrote:

[...]

> @@ -510,9 +598,11 @@ static int teo_enable_device(struct cpuidle_driver *drv,
>  			     struct cpuidle_device *dev)
>  {
>  	struct teo_cpu *cpu_data = per_cpu_ptr(&teo_cpus, dev->cpu);
> +	unsigned long max_capacity = arch_scale_cpu_capacity(dev->cpu);
>  	int i;
>  
>  	memset(cpu_data, 0, sizeof(*cpu_data));
> +	cpu_data->util_threshold = max_capacity >> UTIL_THRESHOLD_SHIFT;

Given that utilization is invariant, why do we set the threshold based on
cpu capacity?

I'm not sure if this is a problem, but on little cores this threshold would be
too low. Given that util is invariant - I wondered if we need to have a single
threshold for all type of CPUs instead. Have you tried something like that
while developing the patch?


Thanks

--
Qais Yousef
