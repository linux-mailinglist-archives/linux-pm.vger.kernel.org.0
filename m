Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B04C67D829
	for <lists+linux-pm@lfdr.de>; Thu, 26 Jan 2023 23:07:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232524AbjAZWHG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Jan 2023 17:07:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232249AbjAZWHF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Jan 2023 17:07:05 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1EF44FCE7
        for <linux-pm@vger.kernel.org>; Thu, 26 Jan 2023 14:06:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674770777;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uJ/8nX4zvnH/ty2ST5KcgskeZg0+7IEmI7sIejuxW3M=;
        b=eRjUnXERP44INWX7DOQxDNtFDt6RYNSxTxeoezERfFqvUg7P6sKoHG6CwEILXcSp3eAGrX
        YDrFSWt5KBcqIdiOU1VvCadKfSKrA7ulU2fge6JILHhX5Gj1O+Dv15P4DoM4kLhQmCtm+3
        pv8ehqrumm3OJmo7Yu1fe/fTzwyuRLE=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-383-Ksn9TY6RNCK-kwLPmyxffA-1; Thu, 26 Jan 2023 17:06:16 -0500
X-MC-Unique: Ksn9TY6RNCK-kwLPmyxffA-1
Received: by mail-qv1-f72.google.com with SMTP id c10-20020a05621401ea00b004c72d0e92bcso1794511qvu.12
        for <linux-pm@vger.kernel.org>; Thu, 26 Jan 2023 14:06:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uJ/8nX4zvnH/ty2ST5KcgskeZg0+7IEmI7sIejuxW3M=;
        b=MeBZlbkmi3UhxJCIno5dImfWAxMKQn5On1M/zBRt3ZAbP49zNhlVXG1rBuMd/WLFBT
         yeZIKoim3iypnAFqAD23Bnxai9yi4FPkWTffba2lT5NRRIqvr5jzAxPvSuDH7fhRaK/Q
         86Hix0ThN7cbJc6uQ/W+XlJ/PM8ngFkUFyqpeqZyYkECTeXK5UnqmUrSuP6QDCsm8H6B
         N4QZG1uPE/8t1nEQasdVViUlJC+W1HJkTOJPd21DFLmjzdqyDqY1aXDYLmzIB/0RFsB3
         mqJLbPJO8Lo/HTfehs6I2md1LRdFocoBmqtkOfO8fosUdtOWMebgpLRCDuYoTioD85oW
         FcbQ==
X-Gm-Message-State: AO0yUKUUO001TXMHfR+4hN0wTKtdHaTOfN1jMOarVlklm1vQX2rcbyR9
        OuoeAYlW+JsZk3uW/kuFIPzw2FL97vJ7QrQoEBBDS0M6VFaziu9vgNujWwJGjBw7Ll/aOQiUV96
        AvoI9U+n5oOylCKdqhuw=
X-Received: by 2002:ac8:5c09:0:b0:3b6:377d:4330 with SMTP id i9-20020ac85c09000000b003b6377d4330mr14060711qti.29.1674770775836;
        Thu, 26 Jan 2023 14:06:15 -0800 (PST)
X-Google-Smtp-Source: AK7set9yWYt2rhCoYu5m2yMmMGUlTPpm6onbgSgfZq2E5c1G86CongsU6U+8xg6KgYsC0Zolr+xW1g==
X-Received: by 2002:ac8:5c09:0:b0:3b6:377d:4330 with SMTP id i9-20020ac85c09000000b003b6377d4330mr14060673qti.29.1674770775515;
        Thu, 26 Jan 2023 14:06:15 -0800 (PST)
Received: from fedora (modemcable181.5-202-24.mc.videotron.ca. [24.202.5.181])
        by smtp.gmail.com with ESMTPSA id br9-20020a05622a1e0900b003b62e8b77e7sm1493538qtb.68.2023.01.26.14.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 14:06:14 -0800 (PST)
Date:   Thu, 26 Jan 2023 17:06:12 -0500
From:   Adrien Thierry <athierry@redhat.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Brian Masney <bmasney@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v4] cpuidle: psci: Do not suspend topology CPUs on
 PREEMPT_RT
Message-ID: <Y9L5VFPdDnsiCluu@fedora>
References: <20230125113418.455089-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230125113418.455089-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Krzysztof,

I tested your patch on the Qdrive3/sa8540p-ride on 6.2.0-rc3-rt1, and it
fixes the issue I encountered in [1].

Tested-by: Adrien Thierry <athierry@redhat.com>

Thank you,

Adrien

[1] https://lore.kernel.org/all/20220615203605.1068453-1-athierry@redhat.com/

