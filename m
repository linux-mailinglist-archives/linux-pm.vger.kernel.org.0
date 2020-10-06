Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB3CD2850EF
	for <lists+linux-pm@lfdr.de>; Tue,  6 Oct 2020 19:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbgJFRih (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Oct 2020 13:38:37 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:42456 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbgJFRig (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Oct 2020 13:38:36 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 096Hc3K3129266;
        Tue, 6 Oct 2020 12:38:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1602005884;
        bh=b/pK5enSoaoRb18q/LZC+anAWY2faAreH43Iz2Ll7X0=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=aC/uIK9YSipHG9MxlrA+YCgzx4QwuYrFazCkrc0bBNSIw5ZWbJnYTOuHDzFUdVVSe
         3FMWDsahRRsbHs/kobaSdCGLKTrDSdlOYk2z11h1kuScnEsHiCSZ7cNwMtEut3NK9S
         WdOfh6o8wNCvsRG+mSrry0qOdhvNAC0r8WJPDFGU=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 096Hc2A3098643
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 6 Oct 2020 12:38:03 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 6 Oct
 2020 12:38:03 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 6 Oct 2020 12:38:03 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 096Hc3qk096330;
        Tue, 6 Oct 2020 12:38:03 -0500
Date:   Tue, 6 Oct 2020 12:38:03 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        <linux-pm@vger.kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>,
        Tony Lindgren <tony@atomide.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Niklas Cassel <nks@flawful.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Kevin Hilman <khilman@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-omap@vger.kernel.org>, <ssantosh@kernel.org>
Subject: Re: [PATCH 3/4] power: avs: smartreflex Move driver to soc specific
 drivers
Message-ID: <20201006173803.3xug5pq6zsp23mi6@powwow>
References: <20201006160516.319830-1-ulf.hansson@linaro.org>
 <20201006160516.319830-4-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201006160516.319830-4-ulf.hansson@linaro.org>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 18:05-20201006, Ulf Hansson wrote:
> The avs drivers are all SoC specific drivers that doesn't share any code.
> Instead they are located in a directory, mostly to keep similar
> functionality together. From a maintenance point of view, it makes better
> sense to collect SoC specific drivers like these, into the SoC specific
> directories.
> 
> Therefore, let's move the smartreflex driver for OMAP to the ti directory.
> 
> Cc: Nishanth Menon <nm@ti.com>
> Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: linux-omap@vger.kernel.org
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
[...]

Reviewed-by: Nishanth Menon <nm@ti.com>

CCying Santosh to let him know as well.
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
