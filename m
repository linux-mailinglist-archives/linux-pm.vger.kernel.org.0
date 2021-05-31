Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8125839584C
	for <lists+linux-pm@lfdr.de>; Mon, 31 May 2021 11:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbhEaJns (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 31 May 2021 05:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbhEaJnr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 31 May 2021 05:43:47 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 303B2C061574;
        Mon, 31 May 2021 02:42:06 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id f11so10268809wrq.1;
        Mon, 31 May 2021 02:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0KB6HDqWDbYDQ3sbClq8V7awx6D1mSiWbRZJ+zsNykI=;
        b=fgsSueAhu6KoC/Pu1gQM1Bxx2cxGcTOgfXbUGqvqY8st5jQkRU7IHgd78qM+STqh5T
         0X2joDl28chJoC8c/ISkimTLXFUfF93vgyf+E8O/UNqSNyi9+/1irrGkucUb7bs5IdFS
         w0GGMFSpVpE/0h/fAED/p9dkmmGRiceFq01p/qqtngxS2BIhSV9SgzdJI7le6XO8jM7x
         AD5+Np+5K8jLcd8jNFjw1Bqx1c7BqaJ0eou/dNRLf2TtS1N0h0zPN9T8LUNFrPHh7kgL
         aaQ0XUFX9QTna1+I5m8bSQwkhIV0+sMGVFKjT72ls6D2qZ6ovgITA69bJR56Lz909+S5
         53dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0KB6HDqWDbYDQ3sbClq8V7awx6D1mSiWbRZJ+zsNykI=;
        b=RH3JVCIFCD/NSZ+V1GRsp1lPIaCYuOORPy5YDi3ttF6bnEVN9bpK48NftEVMXzABN3
         FZ/3Q3YA2aDuDnxWrUO5rMrcp5ERMdXavAL7aK/mokxTjN5O8aR+1xCm2gTY8cJ5ZD+u
         v6PBTNInEPR1BFWOQ+VtQKuQR3pvEiZwvz+ruSlXYi76ohc4PHvt+uK49y6myTqpOxzg
         g+owGVLd/g5J9Ep6WF4Xeq+jBFrdi7P5VuIbAyqUL+w8YsXgoDSlJNexwCuYRL++ia4O
         mYpG+nwhmiTity3p42q4OiYxJQ5DUwoQb+uYiDfbbJiAoP81TPK0rcEuPoOgogzDp6rM
         BpLQ==
X-Gm-Message-State: AOAM532xfhqQGFQbHoa4C7ZKvT0Tb4daf8wqQyOuWe0rRuE6Ez4EnhyQ
        hp7kGpSapCZt1g3anGJ+uCI=
X-Google-Smtp-Source: ABdhPJxkGDatOBDkp5cyeEg5yG9Ad7cqsNOcsKFfs/OBHjY58aDE22wAhNXwGnjGvGlf86YQCr3dtw==
X-Received: by 2002:adf:e3c1:: with SMTP id k1mr13850403wrm.305.1622454124818;
        Mon, 31 May 2021 02:42:04 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id l10sm3848039wrm.2.2021.05.31.02.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 02:42:03 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jonathan Hunter <jonathanh@nvidia.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v1 0/7] Add thermal cooling support to NVIDIA Tegra devfreq
Date:   Mon, 31 May 2021 11:43:38 +0200
Message-Id: <162245420727.56105.5565762567088320366.b4-ty@nvidia.com>
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

[2/7] ARM: tegra_defconfig: Enable CONFIG_DEVFREQ_THERMAL
      commit: 4302331fdf4440b96dba583384a0e2b759cb13bd

Best regards,
-- 
Thierry Reding <treding@nvidia.com>
