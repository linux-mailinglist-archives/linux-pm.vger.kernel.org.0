Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 102172E8D30
	for <lists+linux-pm@lfdr.de>; Sun,  3 Jan 2021 17:33:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbhACQdZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 3 Jan 2021 11:33:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:58838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726733AbhACQdZ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 3 Jan 2021 11:33:25 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DDB97207FB;
        Sun,  3 Jan 2021 16:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609691564;
        bh=vH8svvwB/ZjYxW92qiP/AzA1tZNCSuSCSmv0MITZxak=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ks5xsAzaYDsAg7uYTRoQRa22Tn1+WMOyi9upG81x11iTblBTiPmgxUUykLlugitiw
         v8t3chU1Qn6rSfRAsumNcOahk99dyeQkZYuCfdvQCHigBdoibWdprGse73Gw6ggRPE
         r8wcI5gJV+WBZX3Q1/XOuYjBqAx6u82otDuAEYP1ch7NAQJiHXGBtLneDz0FFr+E3A
         LnSvwKqUVjau3vmaye/8hiZ5AO/lBk7uBJoPenN53S2cBmJYPsX+fxSGF1dF3JwJ8G
         +2D3rzftchx9LFd6kQYbQhwXZ6aPOttolACCOG2eemotATU65Ybbr0swaadOscgNsr
         Hb0Y0LqgEOEXw==
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Timon Baetz <timon.baetz@protonmail.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht, linux-pm@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Lee Jones <lee.jones@linaro.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: (subset) [PATCH v6 1/8] extcon: max8997: Add CHGINS and CHGRM interrupt handling
Date:   Sun,  3 Jan 2021 17:32:38 +0100
Message-Id: <160969149109.67322.9352237387856786036.b4-ty@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201230205139.1812366-1-timon.baetz@protonmail.com>
References: <20201230205139.1812366-1-timon.baetz@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 30 Dec 2020 20:51:53 +0000, Timon Baetz wrote:
> This allows the MAX8997 charger to set the current limit depending on
> the detected extcon charger type.

Applied, thanks!

[7/8] ARM: dts: exynos: Fix charging regulator voltage and current for I9100
      commit: 4a928b3b7c0f8a2ae382c3db3a78898877567786

Best regards,
-- 
Krzysztof Kozlowski <krzk@kernel.org>
