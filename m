Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB2A68D9A2
	for <lists+linux-pm@lfdr.de>; Tue,  7 Feb 2023 14:48:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231782AbjBGNs1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Feb 2023 08:48:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231260AbjBGNs0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Feb 2023 08:48:26 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6580683C1
        for <linux-pm@vger.kernel.org>; Tue,  7 Feb 2023 05:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675777660;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XA/I3fzzNYZ//8/vwERAn+P62R3VluePPy0fivL+Wr8=;
        b=FISClwm9n2lK3nXC1EJXUFPtyGgEYcjLqBDtj/ZfPDxoAT3GJXU4bIqo59efpvohntqtSq
        wt1zmCfFG4hBABcgPqadv97DTpBcq4Bcq/tF2X50u2Z2u9m8ZOjApoWXDtZ1O21HzRBV0j
        Q6NDaeBk2jRkpGBpF5wD4k3YIo7tBAo=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-421-FDj_buYhPde_Z-uJ5zsjPQ-1; Tue, 07 Feb 2023 08:47:39 -0500
X-MC-Unique: FDj_buYhPde_Z-uJ5zsjPQ-1
Received: by mail-qv1-f70.google.com with SMTP id j19-20020a056214033300b0056c11dfb0ddso181161qvu.19
        for <linux-pm@vger.kernel.org>; Tue, 07 Feb 2023 05:47:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XA/I3fzzNYZ//8/vwERAn+P62R3VluePPy0fivL+Wr8=;
        b=WR7z3qa4Bq5Jg58wzqX3idDy5PXucjNUCtB+snAM/r/Ky6wjTFx6wJCu8FWHYDv7dZ
         yC0CbDwEeVpQYf63fwP9wVAf1AWhp5kquzgqytxfpH4GvgZoCNOSQ8lUS7LrOULeDyNp
         nWuiMQ5t093o+RhZcXVv9eNt/HrZ9rvsir6doetEgFwZXqOgNBKsB2yfNd2UOiSzXt/4
         Utk36rtRLI0VG2g3WObV66LhfSEnRH+MMoi4gBm4hInMvBG/SnkeLBcv082BjlLcCIru
         WM4XHKGP4DqyNaXvdm0H1yVWUzcax+kZ9wCybQ3Pf7IDHDR4QVZubDw5KYSvqJy/54bk
         wCyA==
X-Gm-Message-State: AO0yUKVGAtYZiyngTlllmOtaIyUkazGv2REj+61oxRYl2sEAC3oQfmzT
        nRCKijCAqcgabO8MKtjY2JDZhIl3nKbxCYtOknga8ibgoOW5EwyYnnG3bPhh1n2QtWiNGTJbX9k
        WcLMadnzDBBrm/HJT+Y/GS74/
X-Received: by 2002:a05:622a:508:b0:3b8:6075:5d16 with SMTP id l8-20020a05622a050800b003b860755d16mr5879068qtx.56.1675777658673;
        Tue, 07 Feb 2023 05:47:38 -0800 (PST)
X-Google-Smtp-Source: AK7set/ejwgCvHaxLr87VY1OqTrLmCn+q6U4BxbYz736hZ4+blH4zqNep1u4j55SpjNPGPQlVa5mTQ==
X-Received: by 2002:a05:622a:508:b0:3b8:6075:5d16 with SMTP id l8-20020a05622a050800b003b860755d16mr5879035qtx.56.1675777658395;
        Tue, 07 Feb 2023 05:47:38 -0800 (PST)
Received: from fedora (modemcable181.5-202-24.mc.videotron.ca. [24.202.5.181])
        by smtp.gmail.com with ESMTPSA id pe4-20020a05620a850400b0071ada51ab48sm9503353qkn.37.2023.02.07.05.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 05:47:37 -0800 (PST)
Date:   Tue, 7 Feb 2023 08:47:35 -0500
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
Message-ID: <Y+JWd6NfhH0sAlim@fedora>
References: <20230125113418.455089-1-krzysztof.kozlowski@linaro.org>
 <Y9L5VFPdDnsiCluu@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9L5VFPdDnsiCluu@fedora>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Is there still something preventing this patch from being picked up?

Best,

Adrien

