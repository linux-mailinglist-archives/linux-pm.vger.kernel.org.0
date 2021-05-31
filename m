Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D164E39583D
	for <lists+linux-pm@lfdr.de>; Mon, 31 May 2021 11:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbhEaJlT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 31 May 2021 05:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbhEaJlT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 31 May 2021 05:41:19 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95426C061574;
        Mon, 31 May 2021 02:39:38 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id y184-20020a1ce1c10000b02901769b409001so6185599wmg.3;
        Mon, 31 May 2021 02:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XOdtubDeLRT1SrX2gFQVLOjtwn9P5J3Qqsp7QIgnNKc=;
        b=cL1+zzThP0W0FjGLwbSVvWX0wV063i3E4qLkqvZmdey0LaM4uOVJxD8T9DjIIS3Ige
         g1LvykpMaaY4crSdni0/UCzqMe4mTq/AIzBoAgacfrgwlHWST2rzqIlmQl1gVt+eYrX9
         ukdEhhrNgz5BIjyaPKqB2sdWGZGJljjD3EgbfkPIJOlJccL0Zx7msXFqCweIp9SX1j4o
         t0q7vKDCfmQCxDVIx4LpwXlEYe6BT7ZluRtg8bYojLi+tzOQLLbr4Hfl5fNr8SSbJWyb
         eh1lv92CGJ9tX2TBwkpS/IMeRc1DvcO7eu3GifCO5/74OjYkquO4pcqTDPTjKC4696ls
         UDUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XOdtubDeLRT1SrX2gFQVLOjtwn9P5J3Qqsp7QIgnNKc=;
        b=MrzhholQv5SdH4g81/MzfXJU+QhwAlRGLTixvqhgHCAfnC7TvpIgHUV/fZa+uW+fzq
         MulzMw+Ihttp3z9LP+8M/5RiJmh2p8+YvgZOk82ety51nXuJ8oonFZy4dBBhegLGr/Qy
         FvoZk9kHm0UZMMo8k1VbAolCvaF3ob83jzuYmUGqPCSl4rnGVPyWAJin9t6cRb0UTXYc
         lWF4M1eSdtNZdVz058rsL/3JE0qJ2mDRXAtqxkAinln1tQC1Oqo12UjxvL1Q7e+Lbvwu
         RItxMe5MTvi1yrIPCzZs46rr/jLlzmljSBm3xUixnqagS4bpCvna2kDH9ZNENxBStc+3
         69JQ==
X-Gm-Message-State: AOAM533l1Xm0qyZUGL/kK7nLGRs5JjojgOKxHVWFXtyB4E6CeNcutmOD
        hJcY8RKHsvPP+fHydQSp72U=
X-Google-Smtp-Source: ABdhPJyAbtYrUJpxvsoMa5GK7/e4cJq00idAbWgY+IHVTJzakOl9MwHB9FJOhMfnHApbhyTzmnP4vw==
X-Received: by 2002:a05:600c:4a29:: with SMTP id c41mr7063544wmp.17.1622453977205;
        Mon, 31 May 2021 02:39:37 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id n2sm18020000wmb.32.2021.05.31.02.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 02:39:36 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: (subset) [PATCH v1 0/7] Add thermal cooling support to NVIDIA Tegra devfreq
Date:   Mon, 31 May 2021 11:41:10 +0200
Message-Id: <162245404837.55562.8775409412946252680.b4-ty@nvidia.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210510211008.30300-1-digetx@gmail.com>
References: <20210510211008.30300-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

On Tue, 11 May 2021 00:10:01 +0300, Dmitry Osipenko wrote:
> Some hardware versions of NVIDIA Tegra SoCs support higher freqs and they
> are producing much more heat than the other versions. We found that CPU
> throttling may be not enough on devices like Asus Transformer TF700T,
> which is Tegra30 tablet device. This series adds thermal cooling support
> to the NVIDIA Tegra30+ devfreq which cools down SoC by throttling memory
> frequency on overheat.
> 
> [...]

Applied, thanks!

[5/7] ARM: tegra: Add cooling cells to ACTMON device-tree node
      commit: 592b74b1f0ebfe49d2e66b2b4bd95ff3678c5696
[6/7] ARM: tegra: nexus7: Enable memory frequency thermal throttling using ACTMON
      commit: fe7482b88590635939c4bb786e1cd3bbd9ea1682
[7/7] ARM: tegra: ouya: Enable memory frequency thermal throttling using ACTMON
      commit: 4c101a4466983abe7798493ef17279cc3f8eb028

Best regards,
-- 
Thierry Reding <treding@nvidia.com>
