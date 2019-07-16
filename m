Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 980BF6A8AC
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2019 14:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732681AbfGPMZw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Jul 2019 08:25:52 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:59753 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbfGPMZw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Jul 2019 08:25:52 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190716122550euoutp01c82c4bbad88e42d7557b997499b980b9~x4tUrhVgM3130231302euoutp01g
        for <linux-pm@vger.kernel.org>; Tue, 16 Jul 2019 12:25:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190716122550euoutp01c82c4bbad88e42d7557b997499b980b9~x4tUrhVgM3130231302euoutp01g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563279950;
        bh=8dxkZGheuXcwqu+8751Obi1RgIchRJd6UNRg3xcUhVs=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=beB6fxJGOZp7/6yovKJephHOmkUOJiv5AmsjvY/Y3fHObUFK+nqsvNWG1UCXcujRA
         /1Nse0QddKyDCEaxDasugN6YEuuW1m3hRWIX7BL+aVyhJLhb4RzI1CXZpwM29uU4+7
         xM7ZZOj8nxTpIwb1RyIi5+bQaWj7csgnS3xQLPvA=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190716122550eucas1p21fd5c85a08af29b5815f294a48464b03~x4tUFrQ4I0472904729eucas1p2f;
        Tue, 16 Jul 2019 12:25:50 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 3B.CE.04298.D42CD2D5; Tue, 16
        Jul 2019 13:25:49 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190716122549eucas1p2c757e92ae6b02f02123f2510415372d8~x4tTbuNjs0470704707eucas1p2Y;
        Tue, 16 Jul 2019 12:25:49 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190716122549eusmtrp1c5e8222906bc800df7be15a267224311~x4tTNtNcz1452614526eusmtrp1J;
        Tue, 16 Jul 2019 12:25:49 +0000 (GMT)
X-AuditID: cbfec7f2-3615e9c0000010ca-f6-5d2dc24d841c
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 21.64.04146.D42CD2D5; Tue, 16
        Jul 2019 13:25:49 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190716122548eusmtip17c4b9af73f748791f459f12dc1abb5fe~x4tS2CZlL1043210432eusmtip1x;
        Tue, 16 Jul 2019 12:25:48 +0000 (GMT)
Subject: Re: [PATCH 02/10] video: sa1100fb: Remove cpufreq policy notifier
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <8b0f9adf-8462-eeba-afd1-52201f4e7f47@samsung.com>
Date:   Tue, 16 Jul 2019 14:25:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <7163e57cfa1780d42732fa6b5ec424c24d1d4dc8.1563270828.git.viresh.kumar@linaro.org>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKKsWRmVeSWpSXmKPExsWy7djPc7q+h3RjDU68sbS48vU9m8WJvg+s
        Fpd3zWGz+Nx7hNHizOlLrBYdR74xW2z86uHA7nHn2h42j/vdx5k8tlxtZ/H4vEkugCWKyyYl
        NSezLLVI3y6BK2PxlnksBQtZK5ZtXMPUwLiCpYuRk0NCwETiUNMspi5GLg4hgRWMEkeutTJD
        OF8YJV5tuscG4XxmlLi18ToTTMvsG4/ZIRLLGSWa75+D6n/LKDHp/RWwKmEBL4ne/0tZuxg5
        OEQEtCRe3kwFCTMLnGOUOHvTF8RmE7CSmNi+ihHE5hWwk3h7Zy/YTSwCqhIrtjcxg9iiAhES
        949tYIWoEZQ4OfMJWA2nQJzEpA2X2SFmikvcejKfCcKWl9j+dg7YCxICm9gl/s/bwwhxtYvE
        24WroZ4Wlnh1fAs7hC0jcXpyDwtEwzpGib8dL6C6tzNKLJ/8jw2iylri8PGLYN8wC2hKrN+l
        DxF2lNh34BcLSFhCgE/ixltBiCP4JCZtm84MEeaV6GgTgqhWk9iwbAMbzNqunSuZJzAqzULy
        2iwk78xC8s4shL0LGFlWMYqnlhbnpqcWG+allusVJ+YWl+al6yXn525iBCae0/+Of9rB+PVS
        0iFGAQ5GJR7eE3t0YoVYE8uKK3MPMUpwMCuJ8Np+1Y4V4k1JrKxKLcqPLyrNSS0+xCjNwaIk
        zlvN8CBaSCA9sSQ1OzW1ILUIJsvEwSnVwBjsO7lt3Ru7+7qPG5ddXVPqlnK4sHbb5kvnnp5L
        DlU9bVmxqMZC+Hey6s0N3/90T3gnwG9cvmS5KUcut0PaY5sDk+W/vk1sLTOVS0v5KCe91E1/
        6wFH2x8Rydc6RLo6hVfvc9zrZV1wzFeN5dGpfW8L/JWK//drbD7wre6Eqrdym/9q6SuPKpRY
        ijMSDbWYi4oTAR1DDzw4AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOIsWRmVeSWpSXmKPExsVy+t/xu7q+h3RjDW485bG48vU9m8WJvg+s
        Fpd3zWGz+Nx7hNHizOlLrBYdR74xW2z86uHA7nHn2h42j/vdx5k8tlxtZ/H4vEkugCVKz6Yo
        v7QkVSEjv7jEVina0MJIz9DSQs/IxFLP0Ng81srIVEnfziYlNSezLLVI3y5BL2PxlnksBQtZ
        K5ZtXMPUwLiCpYuRk0NCwERi9o3H7F2MXBxCAksZJa5fXcDWxcgBlJCROL6+DKJGWOLPtS42
        iJrXjBJ/3rSwgySEBbwkev8vZQWpFxHQknh5MxWkhlngAqPErA9tjBANfYwSF1ZNYANpYBOw
        kpjYvooRxOYVsJN4e2cv2BUsAqoSK7Y3MYPYogIREmfeQ1zHKyAocXLmEzCbUyBOYtKGy2CL
        mQXUJf7Mu8QMYYtL3HoynwnClpfY/nYO8wRGoVlI2mchaZmFpGUWkpYFjCyrGEVSS4tz03OL
        DfWKE3OLS/PS9ZLzczcxAiNt27Gfm3cwXtoYfIhRgINRiYf3xB6dWCHWxLLiytxDjBIczEoi
        vLZftWOFeFMSK6tSi/Lji0pzUosPMZoCPTeRWUo0OR+YBPJK4g1NDc0tLA3Njc2NzSyUxHk7
        BA7GCAmkJ5akZqemFqQWwfQxcXBKNTCqzNz0hG+/lJbwg+wHh5Mq+/iEZ3HoF+Vu5+WsWPcj
        cYXFbYeJBhz+LHkN63PymnyDKrnuahzTlL/4qT3HPkDrVm937e+qC6bp28/ZTomxabnyoad3
        2q6fZ70dvKed2PRu6+sf1l/5a3492J3+SpB/SWim/UmLhVdOs7memmTJ/WoKp8XTLzpKLMUZ
        iYZazEXFiQD3EvhWygIAAA==
X-CMS-MailID: 20190716122549eucas1p2c757e92ae6b02f02123f2510415372d8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190716122549eucas1p2c757e92ae6b02f02123f2510415372d8
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190716122549eucas1p2c757e92ae6b02f02123f2510415372d8
References: <cover.1563270828.git.viresh.kumar@linaro.org>
        <7163e57cfa1780d42732fa6b5ec424c24d1d4dc8.1563270828.git.viresh.kumar@linaro.org>
        <CGME20190716122549eucas1p2c757e92ae6b02f02123f2510415372d8@eucas1p2.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Hi Viresh,

Please always Cc: me on fbdev patches.

On 7/16/19 11:54 AM, Viresh Kumar wrote:
> The cpufreq policy notifier's CPUFREQ_ADJUST notification is going to
> get removed soon.
> 
> The notifier callback sa1100fb_freq_policy() isn't doing anything apart
> from printing a debug message on CPUFREQ_ADJUST notification. There is
> no point in keeping an otherwise empty callback and registering the
> notifier.
> 
> Remove it.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
