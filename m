Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86C802B4AA5
	for <lists+linux-pm@lfdr.de>; Mon, 16 Nov 2020 17:20:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731842AbgKPQRv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Nov 2020 11:17:51 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:15356 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730948AbgKPQRv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Nov 2020 11:17:51 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fb2a6320000>; Mon, 16 Nov 2020 08:17:54 -0800
Received: from [10.26.75.250] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 16 Nov
 2020 16:17:48 +0000
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
From:   Jon Hunter <jonathanh@nvidia.com>
Subject: [RFC] PM Domains: Ensure the provider is resumed first
Message-ID: <0e00f9ba-571a-23a0-7774-84f893ce6bd5@nvidia.com>
Date:   Mon, 16 Nov 2020 16:17:46 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1605543474; bh=HWmpB7A736rXF29IkvUu++PAsgVlkACbRKRu4ThLeuo=;
        h=To:From:Subject:Message-ID:Date:User-Agent:MIME-Version:
         Content-Type:Content-Language:Content-Transfer-Encoding:
         X-Originating-IP:X-ClientProxiedBy;
        b=KShxaOquI6H9aqIZak0H0wTZgrIjJmRQl+aV/+1uJ0mGhqBV4w/Rire8/H3W6m3WT
         C5LmO8xiwd7YfjSqc7VtlnLqnQiJaosspT5GfqdwNgrrRFHsG8unLjbUDO58WunXwV
         aW274dZ3nYC9DCQbboVAasoupFmJSQBCfdZJmuQV2KZtnHxAfqsUsyymoetpH6zbGq
         8m8Mr7UbxU4RH4y3L7wrD/M0Y65tOGbGt5DdBcuGlPTaiicvFHqq+G+agCz25++50I
         luM+xYuaMDCriUluOP2WMHuTp2rrrDkNnzg6wMa/8T7GuHBgwnqw4DGTffeJQM+01u
         Bv6XarQgtc8ng==
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi all,

We recently ran into a problem on Tegra186 where it was failing to
resume from suspend. It turned out that a driver, the Tegra ACONNECT
(drivers/bus/tegra-aconnect.c), was being resumed before the PM domain
provider, the BPMP (drivers/firmware/tegra/bpmp.c), and the Tegra
ACONNECT was trying to enable the PM domain before the provider had been
resumed.

According to commit 4d23a5e84806 it states that 'genpd powers on the PM
domain unconditionally in the system PM resume "noirq" phase'. However,
what I don't see is anything that guarantees that the provider is
resumed before any device that requires power domains. Unless there is
something that I am missing?

Now by default the ACONNECT is resumed during the noirq phase, but I
have tried making it and its child devices, suspend/resume in the normal
system phase but this does not seem to make a difference. So I am
looking for a bit of guidance on how best to fix this.

Thanks
Jon



