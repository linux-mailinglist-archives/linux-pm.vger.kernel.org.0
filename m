Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD18F11A641
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2019 09:51:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbfLKIvY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Dec 2019 03:51:24 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:14862 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbfLKIvY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Dec 2019 03:51:24 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5df0adf60000>; Wed, 11 Dec 2019 00:51:02 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 11 Dec 2019 00:51:23 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 11 Dec 2019 00:51:23 -0800
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 11 Dec
 2019 08:51:23 +0000
Received: from tbergstrom-lnx.Nvidia.com (10.124.1.5) by
 DRHQMAIL107.nvidia.com (10.27.9.16) with Microsoft SMTP Server (TLS) id
 15.0.1473.3; Wed, 11 Dec 2019 08:51:23 +0000
Received: by tbergstrom-lnx.Nvidia.com (Postfix, from userid 1000)
        id F1CC742797; Wed, 11 Dec 2019 10:51:20 +0200 (EET)
Date:   Wed, 11 Dec 2019 10:51:20 +0200
From:   Peter De Schrijver <pdeschrijver@nvidia.com>
To:     Dmitry Osipenko <digetx@gmail.com>
CC:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Daniel Lezcano" <daniel.lezcano@linaro.org>,
        <linux-pm@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 00/19] Consolidate and improve NVIDIA Tegra CPUIDLE
 driver(s)
Message-ID: <20191211085120.GX28289@pdeschrijver-desktop.Nvidia.com>
References: <20191203004116.11771-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20191203004116.11771-1-digetx@gmail.com>
X-NVConfidentiality: public
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1576054262; bh=t3gv635EZuMfNV5qBxvXa8WTcnY4jw4X5D1j6FRfE/w=;
        h=X-PGP-Universal:Date:From:To:CC:Subject:Message-ID:References:
         MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
         X-NVConfidentiality:User-Agent:X-Originating-IP:X-ClientProxiedBy;
        b=CDPaPeGukpMKkfDXCfc90jsj+Fi0nWaEjPeYbc1cy6VL5TM7IEi394e2NeqrZaoVe
         7RUSpTO+V8O/p8r5ZpM3/Fo9cNY/PjBGz3NisN42o7hBY8bsu0P9+qjTQjT+nB/USS
         JvmMm7tuaTc5dnUQ2L2e+XO0nr3EEM+pKseASZOW/z+AznzHNm0Q3FNFUIVXjcJJUr
         9lEh9lB1dYOl2JxsYfRi2b08eoWheYdsv/be5QHpe/DI22tLoSnxVfrl9p7ufThtRw
         lWQow8zjL2tCqOoKXDx56s/729fgvDqopt8mEQ+tZd/zXAsJqcdA3x5Jz/qcn/C3ZK
         3zA47OH4Xf3UQ==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Dec 03, 2019 at 03:40:57AM +0300, Dmitry Osipenko wrote:
> Hello,
> 
> This series does the following:
> 
>   1. Unifies Tegra20/30/114 drivers into a single driver and moves it out
>      into common drivers/cpuidle/ directory.
> 
>   2. Enables CPU cluster power-down idling state on Tegra30.
> 
> In the end there is a quite nice clean up of the Tegra CPUIDLE drivers
> and of the Tegra's arch code in general. Please review, thanks!
> 

Acked-By Peter De Schrijver <pdeschrijver@nvidia.com> for the series.

Peter.
