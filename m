Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED90F1C4976
	for <lists+linux-pm@lfdr.de>; Tue,  5 May 2020 00:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbgEDWNa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 May 2020 18:13:30 -0400
Received: from mail-co1nam11olkn2060.outbound.protection.outlook.com ([40.92.18.60]:57024
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726433AbgEDWNa (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 4 May 2020 18:13:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KMqJIsCaWUv2EzZYHckjyqdFY6UZr8VkNbIKz7+fH0yKvSFzuCVJPRr3CCMxUYB3fT97ZxMD7f0Mrtt3PCcmotgfT53Ldbe2t2k4tOgtRF+DHZzeL73iKn/9uk10ceijHaLqIx6ZP8cVKA97xiAB18hyLSPJ3D6mFwojzES70FNjYCbOZCVWc1GInSweUGOjucwJqTuC5tO1crLsV6sIQcSGxLj17ccAlmo0s/7UnZxUR0SHPfaOAFLSTY9lmH8HTI8HbvXmCFPQwNc9j966TI0eW76Sp+tZpR7E9opZ3EvSRu05J+3Caodyfl9KzvT9QmHpMklUiNFe2Vo83hPuHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RiBPZdxoYhg53RcsUryS63pWhkfxyAVyRABnH+FEjRY=;
 b=MzVMrwkLczNr7An7qTyg7LCWGLtqLxeZ0tUi0TkyAGdxjppS7vAkXiGMqdLQIrDy2SV0t/dJ7UqbaQmsx2r+6Q73+e4sfdsLYsMZ+8aWbRPRbWkajQsRXsU5IbMKtPrKke8M+FHAcjHY9nWvSCQuHIDI93URnxO2jgkTBN60dnWC5HoUY3yXBLHbPPlaC54/R+FsoFdkvFkoq+6J6QG4TL6+V0WFKYKyKQKbfuWaEMVDg8y6D0k/XCe2vodtQHNsLw3jW2rfWivw1d3RKRITvi7Sr6760OUqptQynOIMCwFrrL1sEv/gx2rKVqsC16eayC1mDRkeLMEqfgEO23rjVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=live.ca; dmarc=pass action=none header.from=live.ca; dkim=pass
 header.d=live.ca; arc=none
Received: from BN8NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2a01:111:e400:fc4b::46) by
 BN8NAM11HT236.eop-nam11.prod.protection.outlook.com (2a01:111:e400:fc4b::416)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19; Mon, 4 May
 2020 22:13:27 +0000
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 (2a01:111:e400:fc4b::4d) by BN8NAM11FT010.mail.protection.outlook.com
 (2a01:111:e400:fc4b::309) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19 via Frontend
 Transport; Mon, 4 May 2020 22:13:27 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:68233827BE256D2F9577E37CF0FBCA613500C69BC1CDB474F561A23E110EA7BE;UpperCasedChecksum:90EEA3423F0453A484840B9C54641D1F146A733C500F2DE6029EB97E0464947B;SizeAsReceived:7647;Count:48
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc]) by BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc%6]) with mapi id 15.20.2958.029; Mon, 4 May 2020
 22:13:27 +0000
From:   Jonathan Bakker <xc-racer2@live.ca>
To:     sre@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org
Cc:     Jonathan Bakker <xc-racer2@live.ca>
Subject: [PATCH 0/3] power: supply: Improve max17040 support
Date:   Mon,  4 May 2020 15:12:57 -0700
Message-ID: <BN6PR04MB06604ED6118024782BC2C11BA3A60@BN6PR04MB0660.namprd04.prod.outlook.com>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MWHPR2201CA0053.namprd22.prod.outlook.com
 (2603:10b6:301:16::27) To BN6PR04MB0660.namprd04.prod.outlook.com
 (2603:10b6:404:d9::21)
X-Microsoft-Original-Message-ID: <20200504221300.3153-1-xc-racer2@live.ca>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jon-hp-6570b.telus (2001:569:fb68:9c00:8067:f823:1e15:7520) by MWHPR2201CA0053.namprd22.prod.outlook.com (2603:10b6:301:16::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19 via Frontend Transport; Mon, 4 May 2020 22:13:26 +0000
X-Mailer: git-send-email 2.20.1
X-Microsoft-Original-Message-ID: <20200504221300.3153-1-xc-racer2@live.ca>
X-TMN:  [3hSWzqfsy1G5aoiJ6uvVHjoBHqUc0SAl9VBYyOjFKWA5Scj8MxbfzRai+dw1rZ0u]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 48
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 903f35a0-9406-4a5c-6456-08d7f0785e73
X-MS-TrafficTypeDiagnostic: BN8NAM11HT236:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NZn4tNrO6czs+BOJmBJGu7jH1QL+9VPBO2TpIc1wEf4iLtDtTMSVImFSbJaMMAWDaH7VJjtE1Lh8WO/axIymiXqzqc9OxZTgdnLgXec3E83h6t1e9mWznST5cUeNkydnOeTm556nw0P3N0gkT3+GK9yUZOjmk5vwNf2el9ZJ0moaWJ6XWYPuNSBh77scN5hAygv58Dv5WyBWCJ4qvbebKQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR04MB0660.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: t8/EqjYXGrY9ctZLbZllfKkiGVtWnjBcwZcJ6muCC5S1dXjEsr72F2CSghpHOVNl26WtUAsTfbT7K0/a1hGFFtpuT4ctKApd/qAUN2wWRhEn4KgxM6VGf5Gupk2a5LWdod6Y453Q/D2C5CrR3dq6/pKyJ5OxdMdP+6yg/6FBB0e5fTTz3ZLIn1j4XwWomHr2f71Y4yhwtNIx931yva+7ag==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 903f35a0-9406-4a5c-6456-08d7f0785e73
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2020 22:13:27.3134
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8NAM11HT236
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patchset does two things:
1) Corrects the voltage reading from the max17040, which was missing
the shift and scaling.
2) Adds the ability to the set the rcomp, which is used to optimize
performance for specific battery chemistries and/or workloads.

Jonathan Bakker (3):
  power: supply: max17040: Correct voltage reading
  dt-bindings: power: supply: Document maxim,rcomp-value for max17040
  power: supply: max17040: Set rcomp value

 .../power/supply/max17040_battery.txt         |  3 ++
 drivers/power/supply/max17040_battery.c       | 35 +++++++++++++++----
 2 files changed, 32 insertions(+), 6 deletions(-)

-- 
2.20.1

