Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FAA72CFBB0
	for <lists+linux-pm@lfdr.de>; Sat,  5 Dec 2020 16:17:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbgLEPLk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 5 Dec 2020 10:11:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:44138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726873AbgLEO73 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 5 Dec 2020 09:59:29 -0500
From:   Krzysztof Kozlowski <krzk@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     Dmitry Osipenko <digetx@gmail.com>,
        Mikko Perttunen <cyndis@kapsi.fi>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Peter Geis <pgwipeout@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v11 00/10] Introduce memory interconnect for NVIDIA Tegra SoCs
Date:   Sat,  5 Dec 2020 15:09:11 +0100
Message-Id: <160717730565.9414.18193998919736710677.b4-ty@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201203192439.16177-1-digetx@gmail.com>
References: <20201203192439.16177-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 3 Dec 2020 22:24:29 +0300, Dmitry Osipenko wrote:
> This series brings initial support for memory interconnect to Tegra20,
> Tegra30 and Tegra124 SoCs.
> 
> For the starter only display controllers and devfreq devices are getting
> interconnect API support, others could be supported later on. The display
> controllers have the biggest demand for interconnect API right now because
> dynamic memory frequency scaling can't be done safely without taking into
> account bandwidth requirement from the displays. In particular this series
> fixes distorted display output on T30 Ouya and T124 TK1 devices.
> 
> [...]

Applied, thanks!

[01/10] dt-bindings: memory: tegra20: emc: Document opp-supported-hw property
[02/10] memory: tegra20: Support hardware versioning and clean up OPP table initialization
[03/10] memory: tegra30: Support interconnect framework
        commit: 01a51facb74fb337ff9fe734caa85dd6e246ef48

Best regards,
-- 
Krzysztof Kozlowski <krzk@kernel.org>
