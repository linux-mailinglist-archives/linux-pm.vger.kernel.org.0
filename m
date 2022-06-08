Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB09542C4B
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jun 2022 12:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235676AbiFHJ7t (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Jun 2022 05:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235470AbiFHJ7e (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Jun 2022 05:59:34 -0400
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8004E3135B
        for <linux-pm@vger.kernel.org>; Wed,  8 Jun 2022 02:32:58 -0700 (PDT)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-e5e433d66dso26474151fac.5
        for <linux-pm@vger.kernel.org>; Wed, 08 Jun 2022 02:32:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=8q0UkAZ4dvNknvTQvko17+mn/F0IPrhf3ct/EHs1tCQ=;
        b=GPyfQl5q5Qf+9i9k/EQtnIzg7UPHXyhxGq5PvoANLagQp715HptsxkHHRZ6Mcl6Sth
         2f91d11NxHl1zKS7Y49vO4FTzkWU1Sn2IDyftqmXNwnMyWUk5YjG7yIMHqCwfCO4Qyn1
         gI2XGobgrW4/GntfOVXH0uVBsZoFJln5gTYhgE/lvbw/loJHDLeyPzcLWrHngLCvXheX
         eL/Aqg9jCe+qFbO7V2ex+4sU+o0fPD7gLwtkP72JcH7i01r8TqsGg8ROgzn6aetiLFn5
         g8X1OwkRt3nfbdpTgIhKGMK+xfabDqhf2N5pNg2AWGTjxqp5vGjYGtWNHAsRoJynBJ9P
         OyBg==
X-Gm-Message-State: AOAM532WksxkX1j/6ix/KBdWWAnuC4dNbvbBa4QcCtnIsDVYnRRI3m55
        K6BqBM3zV9b+WoV0J855VO7+lmwxauiRxA28YrM=
X-Google-Smtp-Source: ABdhPJzDC4rfQ2h72frt9dZYgo7p6s/mGWoR9neFT1AICp5chVHIamtKDi4iNqVMNjw1NMwuzyXGfA==
X-Received: by 2002:a17:90b:3a90:b0:1e6:a203:c7dd with SMTP id om16-20020a17090b3a9000b001e6a203c7ddmr31913271pjb.144.1654680766972;
        Wed, 08 Jun 2022 02:32:46 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id s2-20020a17090a1c0200b001dcf49d92a1sm13623279pjs.28.2022.06.08.02.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 02:32:46 -0700 (PDT)
From:   Kevin Hilman <khilman@kernel.org>
To:     Johnson Wang <johnson.wang@mediatek.com>, cw00.choi@samsung.com,
        krzk+dt@kernel.org, robh+dt@kernel.org, kyungmin.park@samsung.com
Cc:     djakov@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, jia-wei.chang@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Johnson Wang <johnson.wang@mediatek.com>
Subject: Re: [PATCH v7 0/2] Introduce MediaTek CCI devfreq driver
In-Reply-To: <20220607140556.6278-1-johnson.wang@mediatek.com>
References: <20220607140556.6278-1-johnson.wang@mediatek.com>
Date:   Wed, 08 Jun 2022 02:32:45 -0700
Message-ID: <7hr13z7b5u.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Johnson Wang <johnson.wang@mediatek.com> writes:

> The Cache Coherent Interconnect (CCI) is the management of cache
> coherency by hardware. CCI DEVFREQ is DVFS driver for power saving by
> scaling clock frequency and supply voltage of CCI. CCI uses the same
> input clock source and power rail as LITTLE CPUs on Mediatek SoCs.

Tested-by: Kevin Hilman <khilman@baylibre.com>
