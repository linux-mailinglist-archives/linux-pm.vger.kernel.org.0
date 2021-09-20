Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C344D411109
	for <lists+linux-pm@lfdr.de>; Mon, 20 Sep 2021 10:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbhITIgA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 Sep 2021 04:36:00 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:51692
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235897AbhITIgA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Sep 2021 04:36:00 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id E153C3F320
        for <linux-pm@vger.kernel.org>; Mon, 20 Sep 2021 08:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632126872;
        bh=GlnCPL/n2TbFZ5lKXBBdaGTEcyYQg+Xe+TKmdfu9J3o=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=k3NQkMTJCzpxEaXtrsQYxD1tozAA27mjEdZTmW8rk2xphZA2q53u+aisx5jCsSlnV
         32HtqlBG3ASoJMNCJav+Ga7Oat1H/j0aC9XJysVHR/YgqT0TCpC1jvne0VDdfZlhHe
         zSX344WdjePs97xnJ6rMZZe8z/sWyK7gM9ZMpHYYDKH5VYAaasTQZCmLNGSN9de+es
         4V0tJuS884SmGNfKFVTTxbIgowIM6ff6vJ4vhyj3nc90A+ndZYUoAYm3I1dFclVwDX
         qFswYj2TCAb6C0ZmkusmkbXm/Rgg29DLJttiZHTPCbYKfx122UJvBJ1rsDfFh6oyhx
         G+l0mueS42WBw==
Received: by mail-wm1-f71.google.com with SMTP id z26-20020a1c4c1a000000b00300ec9d8d77so4477993wmf.5
        for <linux-pm@vger.kernel.org>; Mon, 20 Sep 2021 01:34:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GlnCPL/n2TbFZ5lKXBBdaGTEcyYQg+Xe+TKmdfu9J3o=;
        b=5ebia/CqH8R9/M+BFsGYlS5x0SLL5gRv8jaVTwHD9AXd6tKdkEyr99dxKohUTzA2n7
         gZoqX9e3885orcPeZLfxLxF+blmnSzqc8ym5BqyEhREbtMn2NxN+DwBXmvZxvdEa7Oz1
         rW8mf53zIVYuqGNK3Iao9yq+hGvfCA2rZwZi28HH9afw/lw4rYCPygyIdlfJwT7zeqLn
         +xbedLvRpOX6tZ8QoQvIBcHoh6hDQZyqE8CJYmqEveJnuKy/7CnZUEgHXHvLLwvI/+vh
         xGzTmwpzhI80wUDpq2Cmw1jl9J3seZG4twuIVYAGEHo9Uaod8II4LNGr1egK/a+EoC3c
         VtAg==
X-Gm-Message-State: AOAM531cVAO8F6HjfH6/VbaEZt5t8isOrtRb/UUGXO0X9NalPB+w+HeX
        X3nWTuvxeHOu6TQSg+maz1Zhg64hcnAU+GSfDJPctqYiwtqB6YGjLrwy1JWpemH7POg9mJEw6CN
        DCzU8RF8pt4OlTrtQ3fuu0QKiZRnfQZkomMux
X-Received: by 2002:a1c:2056:: with SMTP id g83mr27578663wmg.27.1632126872640;
        Mon, 20 Sep 2021 01:34:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxZ9ERCT7KUv6zwsHvcBjFyA/Y/awEBukLBanBzL4Ra5L9b9at0dRM9wxlTaF4DW/RU0R/XQw==
X-Received: by 2002:a1c:2056:: with SMTP id g83mr27578645wmg.27.1632126872454;
        Mon, 20 Sep 2021 01:34:32 -0700 (PDT)
Received: from kozik-lap.lan (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id v188sm4658891wme.38.2021.09.20.01.34.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 01:34:31 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     p.zabel@pengutronix.de, viresh.kumar@linaro.org, robh@kernel.org,
        Mikko Perttunen <mperttunen@nvidia.com>, amitk@kernel.org,
        kw@linux.com, rafael@kernel.org, thierry.reding@gmail.com,
        lorenzo.pieralisi@arm.com, daniel.lezcano@linaro.org,
        rui.zhang@intel.com, jonathanh@nvidia.com
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-pm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH 3/5] memory: tegra186-emc: Handle errors in BPMP response
Date:   Mon, 20 Sep 2021 10:34:27 +0200
Message-Id: <163212685894.112070.7948621267940223581.b4-ty@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210915085517.1669675-3-mperttunen@nvidia.com>
References: <20210915085517.1669675-1-mperttunen@nvidia.com> <20210915085517.1669675-3-mperttunen@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 15 Sep 2021 11:55:15 +0300, Mikko Perttunen wrote:
> The return value from tegra_bpmp_transfer indicates the success or
> failure of the IPC transaction with BPMP. If the transaction
> succeeded, we also need to check the actual command's result code.
> Add code to do this.
> 
> 

Applied, thanks!

[3/5] memory: tegra186-emc: Handle errors in BPMP response
      commit: 13324edbe9269e6fbca4d0f5146b18ef8478c958

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
