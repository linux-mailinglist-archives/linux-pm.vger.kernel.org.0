Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D43722CB860
	for <lists+linux-pm@lfdr.de>; Wed,  2 Dec 2020 10:18:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388004AbgLBJPO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Dec 2020 04:15:14 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:11486 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388089AbgLBJPN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Dec 2020 04:15:13 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fc75af90001>; Wed, 02 Dec 2020 01:14:33 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 2 Dec
 2020 09:14:33 +0000
Received: from moonraker.nvidia.com (10.124.1.5) by mail.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Wed, 2 Dec 2020 09:14:31 +0000
From:   Jon Hunter <jonathanh@nvidia.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>
CC:     <linux-pm@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        Sumit Gupta <sumitg@nvidia.com>,
        Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH 0/4] CPUFREQ clean-ups for Tegra186 and Tegra194
Date:   Wed, 2 Dec 2020 09:14:15 +0000
Message-ID: <20201202091419.307192-1-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1606900473; bh=Cv3zdglcohr3se4j7Y3iqrG1oIBfVZaDaXOOVgrL2xg=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
         X-NVConfidentiality:Content-Transfer-Encoding:Content-Type;
        b=nlf8kOTJlM2Ks5gExs1f0VTWGmAO5JXdkDh8Qu8nhlzvfVUFzYCD/SHTci//XVt5m
         MQFDm04kOA6THPFvYmzAYAs4Hh6H+l3MK6+VR4WVaY8wWgPsc0KJOvMYw9u9aXZ2Md
         oQ9w2Y9LXt08DSu1DVitpr/kHyJLQ85SCrr9zxz6uQbqStvs9sMFzs0I3KB/Vg5ac5
         8AH7RzzvcRGogckt4gNZFMfqSBOdQMU5I20kGqDdnXRG3p2CiGToUD+28Z/osWP7mx
         eySZVypKT7H/rtTt8DrsYy2838tNdjU7rdinE0Xnn3PTiaFQXbJA68tayuyiLIngx1
         Nro0FEXbAEdrg==
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This series includes some clean-ups for the Tegra186 and Tegra194
CPUFREQ drivers.

Jon Hunter (4):
  cpufreq: tegra186: Fix sparse 'incorrect type in assignment' warning
  cpufreq: tegra186: Simplify cluster information lookup
  cpufreq: tegra194: Remove unnecessary frequency calculation
  cpufreq: tegra194: Rename tegra194_get_speed_common function

 drivers/cpufreq/tegra186-cpufreq.c | 122 +++++++++++++----------------
 drivers/cpufreq/tegra194-cpufreq.c |  12 +--
 2 files changed, 57 insertions(+), 77 deletions(-)

--=20
2.25.1

