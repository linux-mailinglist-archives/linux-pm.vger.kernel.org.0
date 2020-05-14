Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8255C1D4165
	for <lists+linux-pm@lfdr.de>; Fri, 15 May 2020 01:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729007AbgENXFH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 May 2020 19:05:07 -0400
Received: from mail-dm6nam12olkn2048.outbound.protection.outlook.com ([40.92.22.48]:47424
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728508AbgENXFG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 14 May 2020 19:05:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gdYG3GM2E6DZNF3aoaeD39O3T4OfsV5XN9Zzc9TLdMfAY/BKisbC46jkvT7qgDGIPFlIA2sL7QE1FVmzhwaeV235nwpWVX3WggkX4EEm/IHceCtB5xifFos7vNwFoRtP170S+Z1pLZt1s0RO5eobHwLT4gjFTka5HzqmmreQpx6FwrlJXs1knWsScuKqQYOcJaEn6fk/1EbLfmGpxOQ54n4K6IelNXhzdGQYsYeZo7z8ffi36SIEgaAr64S6DxeqwkND/iG8+O/BgrSn5kAiI7/OvrE6da0FUV8VRI6iAKToYXOpd3rcfFrRaCLxcym4whh0/CGHgwF8B1zn+qkRsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u8Z4mUac3jNXx26SHqo2XYSo2AyvhLsfSPKAt2qH4nM=;
 b=B9Zs7TvD+lex5/QF9NzXp51hsYled7lTeKOSGUQMNfAMw9JmcpprwyycnwKKhe7qySUNpU9I69GbJ6O+Y18ZkkAAiUbILHqga4c/Y1ToSO1UPDU944UX3/4zIgejnH8Cp6ZajRFa1Ahp3i9oyK68lJBJVuNQfWEeWTvDXjhEkhWEs4YB2uKgP7xpabnE+pJPohg13KoAz7C/G+ZSs5N4kKjhUzTZnLHz+eFti1s1Ray70RUrCEluyCQ+WgFr77L06SFM4MBTi72KIEVt0PrgJz1UhLg/hI+QJRbXh17NYTIr05+zxuTrYqBsvOGExqeRS6ZWQWPl3/DH27DteY7w0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=live.ca; dmarc=pass action=none header.from=live.ca; dkim=pass
 header.d=live.ca; arc=none
Received: from MW2NAM12FT003.eop-nam12.prod.protection.outlook.com
 (2a01:111:e400:fc65::48) by
 MW2NAM12HT221.eop-nam12.prod.protection.outlook.com (2a01:111:e400:fc65::279)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.11; Thu, 14 May
 2020 23:05:04 +0000
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 (2a01:111:e400:fc65::44) by MW2NAM12FT003.mail.protection.outlook.com
 (2a01:111:e400:fc65::70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.11 via Frontend
 Transport; Thu, 14 May 2020 23:05:04 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:2B908F33ADF082C81FC1E0FCB353C2A7DCA76E6AA8734CB8F5D9CE6A53963CFD;UpperCasedChecksum:74C0D38BCB1EA9186C10664C7F62431CC02EA446E510634877E7D9DA5FB97A8B;SizeAsReceived:7743;Count:48
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc]) by BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc%6]) with mapi id 15.20.3000.022; Thu, 14 May 2020
 23:05:04 +0000
From:   Jonathan Bakker <xc-racer2@live.ca>
To:     sre@kernel.org, krzk@kernel.org, jonghwa3.lee@samsung.com,
        tglx@linutronix.de, kstewart@linuxfoundation.org,
        baolin.wang7@gmail.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonathan Bakker <xc-racer2@live.ca>
Subject: [PATCH 00/10] power: supply: Charger-manager improvements
Date:   Thu, 14 May 2020 16:04:25 -0700
Message-ID: <BN6PR04MB06603115D277DF264D9380E8A3BC0@BN6PR04MB0660.namprd04.prod.outlook.com>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MWHPR22CA0040.namprd22.prod.outlook.com
 (2603:10b6:300:69::26) To BN6PR04MB0660.namprd04.prod.outlook.com
 (2603:10b6:404:d9::21)
X-Microsoft-Original-Message-ID: <20200514230435.11798-1-xc-racer2@live.ca>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jon-hp-6570b.telus (2001:569:fb68:9c00:8067:f823:1e15:7520) by MWHPR22CA0040.namprd22.prod.outlook.com (2603:10b6:300:69::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26 via Frontend Transport; Thu, 14 May 2020 23:05:02 +0000
X-Mailer: git-send-email 2.20.1
X-Microsoft-Original-Message-ID: <20200514230435.11798-1-xc-racer2@live.ca>
X-TMN:  [LHc+2olohFnXGtQZ9kDZurzcUck2jh1xjDnxFJJ2eRRV/Kohx+25bz1VVfCpu2qV]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 48
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: f984340d-8d2c-46d8-a3fd-08d7f85b3c3e
X-MS-TrafficTypeDiagnostic: MW2NAM12HT221:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zEK1vFgZqFPbxQudR2BGPp2pdGOL30XDE/H1APDQuD9mJ69a0uXXwI+2yAT5GB1qE4MO1SLmRoWyZUKDUyis7OLV9UTujY53etGoA3k/Cop7FZNsUhGvz799uhS1ozt9xMDAUHMBYQI0gYnNxkS2YXftPMdndAMUa5H2pRe71A8G5ULXXnCXJRhQcI+rJnavPuD7gCo7RjpqDQStVXTW192wwK/Y8QxmYfB7EX9LjfnCUMzvEAb/L2PyG2jPIC5f
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR04MB0660.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: TIXwLDbwsqF2yzraKILd15S/al3pSAZhOVLabJc8h/79+Gm4GfDdB13jP2gCM6zZOglCXdVdoMUkNsnnyI31AXbKQLlBuHGkhEZGNg2EU3ctyo2XbrZmUfdqI+abgknkLGjJqiMKU0eIHedbdXtyeh1u2L58kMPsybIVH6D4wkyYaEr22pU3dWdFb/a40SxdhpH/GI+Pogb+PZyc+nwFow==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f984340d-8d2c-46d8-a3fd-08d7f85b3c3e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2020 23:05:03.8852
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2NAM12HT221
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Charger-manager is a virtual driver for unifying chargers, fuel gauges,
extcon devices, and a thermal device into a battery management system.

Unfortunately, it has been broken since commit 830ae442202e ("extcon:
Remove the deprecated extcon functions") when the extcon internal API
was changed but some drivers were not updated.  Additionally, it had
some race conditions and was unnecessarily complex.

A number of these patches come from a Tizen git tree(1); they have been
rebased and the commit messages cleaned up.

These changes have been tested on a couple of first-gen Galaxy S devices
based on s5pv210 with a modified max8998 driver so that a charger
regulator is exposed.  In addition to the max8998, this hardware has
a max17040 fuel gauge, fsa9480 extcon, and a generic thermal resistor
for temperature sensing.

1) https://git.tizen.org/cgit/platform/kernel/linux-exynos/log/drivers/power/charger-manager.c?h=tizen_5.0

Jonathan Bakker (4):
  power: supply: charger-manager: Always use POWER_SUPPLY_PROP_TEMP
  power: supply: charger-manager: Update extcon functions
  power: supply: charger-manager: Count cm-chargers property directly
  dt-bindings: power: supply: Cleanup charger-manager bindings

Jonghwa Lee (6):
  power: supply: charger-manager: Swap private uevent for
    power_supply_changed
  power: supply: charger-manager: Remove cm_notify_event function
  power: supply: charger-manager: Correct usage of CHARGE_NOW/FULL
  power: supply: charger-manager:  Collect all power_supply_changed()
    calls
  power: supply: charger-manager: Make decisions focussed on battery
    status
  power: supply: charger-manager: Don't start charging in cable
    nofitication

 .../bindings/power/supply/charger-manager.txt |  30 +-
 drivers/power/supply/charger-manager.c        | 571 +++++-------------
 include/linux/power/charger-manager.h         |  41 +-
 3 files changed, 175 insertions(+), 467 deletions(-)

-- 
2.20.1

