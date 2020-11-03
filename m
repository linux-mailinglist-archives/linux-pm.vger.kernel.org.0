Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83FB12A3EEB
	for <lists+linux-pm@lfdr.de>; Tue,  3 Nov 2020 09:29:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbgKCI3i (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Nov 2020 03:29:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725982AbgKCI3e (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Nov 2020 03:29:34 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD33C0617A6
        for <linux-pm@vger.kernel.org>; Tue,  3 Nov 2020 00:29:32 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id p22so11813406wmg.3
        for <linux-pm@vger.kernel.org>; Tue, 03 Nov 2020 00:29:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:autocrypt:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wORoPEJyqMGn3vtLbYDCbkYsPLmForeYHOgaBK21yhA=;
        b=oQKT3A1GYk56SnBqLXlaHM2gkXQbMt+5LzOsXKkPe7f5iT+ommKDvr29trOE+HWtpL
         khfpzrlSZdTjkkVV0W4dSprwdmQzFceuAdsnQW6RFsWvBcPJ6nvvk6v5kvOEl3a/40Ab
         Et19n4498gNc6appXAmiCqCuxMv59Ck0S8twpWaEVwnbtkRLID37AB0gRacovLUW7xMK
         NIEAeA0DISixUQs4a/1DLJ+naj8UnJPXxHvIU7SubcLZDIqkYylFSA+X2n6jzAgRm9kA
         MdwHIDeqojeWl7QbBnO+OPeUWkO7NTCkWpVBW2HjFm949tN0yVinkj/ERrw+Lo4/GsyY
         JZ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wORoPEJyqMGn3vtLbYDCbkYsPLmForeYHOgaBK21yhA=;
        b=spDQyQb9XJ/G30hhwNCaJpl5GeLAlOaR7Lz1quBaSe1T9sDgiRu7zJQcYkz9fVC6qf
         nnxot0ytokuxtS25LN59N9O8bEQPrGprz2L0ToRkjso88baZNNdDS1gNe83f+FMmRy2j
         8b7mzgciGQSjNhNyuxcPyaUySu5TZwYGvNAoBTZsRIZWjstomycTsB/N5kB4JPPbh1SJ
         IXncwWo8qjq2spFvp4BQQraOcfZ0tpS4hsjGUoz8VQMUmL0KtSwhydMRHcIMmELyMP+W
         8nlepF0iSXIdq1/9nao9zonKhlaceqAqzDusjVIzOAiBX2opJLRHwWVKM+3LzQRlC6dm
         1p8w==
X-Gm-Message-State: AOAM5328UAPfFMudVODOyBnH4ZwrwuDbNegSXouwQG68jkItsddwXPlC
        KG/309tmf/X0ZbHqdVGz8MCIUQ==
X-Google-Smtp-Source: ABdhPJyuCr4bpmvzRQ+OyNyar0XW6jAidB2r0Vx7Hc9VycIyrAEpHv4hQX0NBBSmEJRjFmvMlxz8BA==
X-Received: by 2002:a1c:5f42:: with SMTP id t63mr2195051wmb.19.1604392171229;
        Tue, 03 Nov 2020 00:29:31 -0800 (PST)
Received: from [10.44.66.8] ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id k22sm2121288wmi.34.2020.11.03.00.29.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2020 00:29:30 -0800 (PST)
Subject: Re: [PATCH v7 0/6] Exynos: Simple QoS for exynos-bus using
 interconnect
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     krzk@kernel.org, devicetree@vger.kernel.org, robh+dt@kernel.org,
        a.swigon@samsung.com, myungjoo.ham@samsung.com,
        inki.dae@samsung.com, sw0312.kim@samsung.com,
        b.zolnierkie@samsung.com, m.szyprowski@samsung.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <CGME20201030125221eucas1p14e525f75c4b8dadae04144ce7684d776@eucas1p1.samsung.com>
 <20201030125149.8227-1-s.nawrocki@samsung.com>
 <b586c2b7-9ca1-e641-b70c-27493ffd05e0@samsung.com>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Autocrypt: addr=georgi.djakov@linaro.org; prefer-encrypt=mutual; keydata=
 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
 KEmKjLDvB0pePJkdTw==
Message-ID: <9285e2d4-f2fa-92f2-ba25-832f32f77d78@linaro.org>
Date:   Tue, 3 Nov 2020 10:29:32 +0200
MIME-Version: 1.0
In-Reply-To: <b586c2b7-9ca1-e641-b70c-27493ffd05e0@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Chanwoo and Sylwester,

On 11/3/20 09:54, Chanwoo Choi wrote:
> Hi Sylwester,
> 
> When I tested this patchset on Odroid-U3,
> After setting 0 bps by interconnect[1][2],
> the frequency of devfreq devs sustain the high frequency
> according to the pm qos request.
> 
> So, I try to find the cause of this situation.
> In result, it seems that interconnect exynos driver
> updates the pm qos request to devfreq device
> during the kernel booting. Do you know why the exynos
> interconnect driver request the pm qos during probe
> without the mixer request?

That's probably because of the sync_state support, that was introduced
recently. The icc_sync_state callback needs to be added to the driver
(i just left a comment on that patch), and then check again if it works.

The idea of the sync_state is that there could be multiple users of a
path and we must wait for all consumers to tell their bandwidth needs.
Otherwise the first consumer may lower the bandwidth or disable a path
needed for another consumer (driver), which has not probed yet. So we
maintain a floor bandwidth until everyone has probed. By default the floor
bandwidth is INT_MAX, but can be overridden by implementing the get_bw()
callback.

Thanks,
Georgi

> 
> PS. The passive governor has a bug related to PM_QOS interface.
> So, I posted the patch[4].
> 
> 
> [1] interconnect_graph
> root@localhost:~# cat /sys/kernel/debug/interconnect/interconnect_graph 
> digraph {
>         rankdir = LR
>         node [shape = record]
>         subgraph cluster_1 {
>                 label = "soc:bus_dmc"
>                 "2:bus_dmc" [label="2:bus_dmc
>                         |avg_bw=0kBps
>                         |peak_bw=0kBps"]
>         }
>         subgraph cluster_2 {
>                 label = "soc:bus_leftbus"
>                 "3:bus_leftbus" [label="3:bus_leftbus
>                         |avg_bw=0kBps
>                         |peak_bw=0kBps"]
>         }
>         subgraph cluster_3 {
>                 label = "soc:bus_display"
>                 "4:bus_display" [label="4:bus_display
>                         |avg_bw=0kBps
>                         |peak_bw=0kBps"]
>         }
>         "3:bus_leftbus" -> "2:bus_dmc"
>         "4:bus_display" -> "3:bus_leftbus"
> 
> 
> [2] interconnect_summary
> root@localhost:~# cat /sys/kernel/debug/interconnect/interconnect_summary 
>  node                                  tag          avg         peak
> --------------------------------------------------------------------
> bus_dmc                                               0            0
>   12c10000.mixer                         0            0            0
> bus_leftbus                                           0            0
>   12c10000.mixer                         0            0            0
> bus_display                                           0            0
>   12c10000.mixer                         0            0            0
> 
> 
> [3] devfreq_summary
> root@localhost:~# cat /sys/kernel/debug/devfreq/devfreq_summary 
> dev                            parent_dev                     governor        timer      polling_ms  cur_freq_Hz  min_freq_Hz  max_freq_Hz
> ------------------------------ ------------------------------ --------------- ---------- ---------- ------------ ------------ ------------
> soc:bus_dmc                    null                           simple_ondemand deferrable         50    400000000    400000000    400000000
> soc:bus_acp                    soc:bus_dmc                    passive         null                0    267000000    100000000    267000000
> soc:bus_c2c                    soc:bus_dmc                    passive         null                0    400000000    100000000    400000000
> soc:bus_leftbus                null                           simple_ondemand deferrable         50    200000000    200000000    200000000
> soc:bus_rightbus               soc:bus_leftbus                passive         null                0    200000000    100000000    200000000
> soc:bus_display                soc:bus_leftbus                passive         null                0    200000000    200000000    200000000
> soc:bus_fsys                   soc:bus_leftbus                passive         null                0    134000000    100000000    134000000
> soc:bus_peri                   soc:bus_leftbus                passive         null                0    100000000     50000000    100000000
> soc:bus_mfc                    soc:bus_leftbus                passive         null                0    200000000    100000000    200000000
> 
> 
> [4] PM / devfreq: passive: Update frequency when start governor
> https://patchwork.kernel.org/project/linux-pm/patch/20201103070646.18687-1-cw00.choi@samsung.com/
> 
> 
