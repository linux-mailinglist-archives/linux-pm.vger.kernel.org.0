Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E46A8313AAB
	for <lists+linux-pm@lfdr.de>; Mon,  8 Feb 2021 18:19:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232160AbhBHRSN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Feb 2021 12:18:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:33830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234671AbhBHRRr (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 8 Feb 2021 12:17:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 982F464E6E;
        Mon,  8 Feb 2021 17:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612804626;
        bh=BfPVNPhD+Ba/YNfUfM7utwp0Nvw3QE+oOCX7q7XltPE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=WZnrYnIqbli8bx4CGwsbi0lgpuo+Fh8NznXE5/0i6ZbR6B9ZOXqATxVjt8p+iTyjQ
         9N6Eulwn0MOs9CPvPqdD1HOyD5Sejih+04flUiBHO8zwcnNqr3KVEqf7/Enxivoy83
         e22Di1pxizbeIVyfC9XQaznR7jN4+yhPXyEBhW4bFxAiOWHEJ1YyLlC5UJai56ikHg
         oGV6wacETKDJaiAKudZXTP4A/slOw2V2cKjo0jA/n7qqCulL7XbtmBl8NaJf7r6OYT
         jXYz26e9FWCSY8OpjsrxxvEJLmmCYBB8SA9D3znWT7Sv0vvyATWnaHD/N10ORyC2jH
         Knn1Ztt1NHMoA==
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-samsung-soc@vger.kernel.org,
        Lukasz Luba <lukasz.luba@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: (subset) [PATCH] memory: samsung: exynos5422-dmc: Correct function names in kerneldoc
Date:   Mon,  8 Feb 2021 18:16:54 +0100
Message-Id: <161280460935.4459.2076677774296231794.b4-ty@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210206111715.20774-1-krzk@kernel.org>
References: <20210206111715.20774-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, 6 Feb 2021 12:17:15 +0100, Krzysztof Kozlowski wrote:
> Correct kerneldoc to fix W=1 warnings:
> 
>     drivers/memory/samsung/exynos5422-dmc.c:290: warning:
>         expecting prototype for find_target_freq_id(). Prototype was for find_target_freq_idx() instead
>     drivers/memory/samsung/exynos5422-dmc.c:1015: warning:
>         expecting prototype for exynos5_dmc_align_initial_frequency(). Prototype was for exynos5_dmc_align_init_freq() instead

Applied, thanks!

[1/1] memory: samsung: exynos5422-dmc: Correct function names in kerneldoc
      commit: 0e9bc42089a7374d056745419c7a8f28016b4191

Best regards,
-- 
Krzysztof Kozlowski <krzk@kernel.org>
