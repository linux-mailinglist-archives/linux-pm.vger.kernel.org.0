Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 111897E8039
	for <lists+linux-pm@lfdr.de>; Fri, 10 Nov 2023 19:08:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235621AbjKJSIB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Nov 2023 13:08:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345909AbjKJSHA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Nov 2023 13:07:00 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E15C2B7FB
        for <linux-pm@vger.kernel.org>; Fri, 10 Nov 2023 01:18:06 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-5bd33abbb90so1371638a12.2
        for <linux-pm@vger.kernel.org>; Fri, 10 Nov 2023 01:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699607886; x=1700212686; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qQTkE1ZnpGXcZrl7W6lR4eKSn0Z1KI5/u9IM9eBWdzI=;
        b=aZV2WbWJN/MupF53Gl5WDyBX4VnHbTtk3PCCM/99/x6RApuoK7xeoksvPU6VwvyrqM
         X2ou80ymLE/EJkub+m0GtsKNUqILZoZMV/4M7bz1GsvKE5NcUlgxQN1aRoOrbjVXofnh
         +aBzgYGURDHKOOIAZtnc692snRHBgC+00WwWGT4obxw4OcIhAccCpkd++O9PYfsEeu4H
         1uHqU0FucU15gp8uH04VGF5KygK9SRKG7ijc2LwulLwdxduWBOWjXtzEi8LuRkcMah9y
         GKkMqGUpxn9CUnCzb/4v/SXskuUe5K/irfmxvx0AuY5dOCZKGMQOzjNwXPLbjrXeh0Cb
         8iWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699607886; x=1700212686;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qQTkE1ZnpGXcZrl7W6lR4eKSn0Z1KI5/u9IM9eBWdzI=;
        b=HgLJFIbSKDqHtBW2PvTyOfyksq/0ICzysVBveaiVfLAcrnGr31N3O9rl7lDmqqNPsW
         MA3+YAyCQbbODTsDnquI7nI4SNCUXRtZi2kdmeO4jboiJjNMxDA+nJkRuvUSD0nPvFkz
         nBARK9Qy+K7ivO8aCLH2rxtvB2O/3Lfi79ypLBpWJXV6F9fQHza5zjzcu43hPAVkjD6u
         cfF2P4NrhArxHV2LmHDRtDQ0AgPZANec0GdM8YUQCign8Ok4zNYHodlBpdd4A9ptuBay
         M0llQM2HtWBt7DfLpOleee6CVffObyjgCzm6HTvV4YA8cPP20YM3lUubxHBrBV8IeLIy
         QY9g==
X-Gm-Message-State: AOJu0YzPnCpN2v8wLF918sdNQjJ/2loLErnMWEY6ZvZ84a85VB6ooSE5
        VxLZ3qaJmiAryLkUfGmFoihA3g==
X-Google-Smtp-Source: AGHT+IGife7skzKrRrmxXSpDW1iTw6SRyJPT40pz+mavprG4ApUvNEQqFPvzfzolUakrl+Owq+kyyg==
X-Received: by 2002:a17:90b:3887:b0:280:e0:9071 with SMTP id mu7-20020a17090b388700b0028000e09071mr4653129pjb.28.1699607885946;
        Fri, 10 Nov 2023 01:18:05 -0800 (PST)
Received: from localhost ([122.172.82.6])
        by smtp.gmail.com with ESMTPSA id g13-20020a17090ae58d00b0027d12b1e29dsm1149227pjz.25.2023.11.10.01.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 01:18:05 -0800 (PST)
Date:   Fri, 10 Nov 2023 14:48:03 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, sudeep.holla@arm.com,
        gregkh@linuxfoundation.org, rafael@kernel.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        lenb@kernel.org, robert.moore@intel.com, lukasz.luba@arm.com,
        ionela.voinescu@arm.com, pierre.gondois@arm.com,
        beata.michalska@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
        conor.dooley@microchip.com, suagrfillet@gmail.com,
        ajones@ventanamicro.com, lftan@kernel.org
Subject: Re: [PATCH v6 6/7] cpufreq/cppc: Set the frequency used for
 computing the capacity
Message-ID: <20231110091803.2xqtodhyxtuxdbba@vireshk-i7>
References: <20231109101438.1139696-1-vincent.guittot@linaro.org>
 <20231109101438.1139696-7-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231109101438.1139696-7-vincent.guittot@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 09-11-23, 11:14, Vincent Guittot wrote:
> Save the frequency associated to the performance that has been used when
> initializing the capacity of CPUs.
> Also, cppc cpufreq driver can register an artificial energy model. In such
> case, it needs the frequency for this compute capacity.
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> Acked-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/base/arch_topology.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
