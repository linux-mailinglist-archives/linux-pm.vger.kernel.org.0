Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 364581C4977
	for <lists+linux-pm@lfdr.de>; Tue,  5 May 2020 00:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728134AbgEDWNd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 May 2020 18:13:33 -0400
Received: from mail-bn8nam11olkn2099.outbound.protection.outlook.com ([40.92.20.99]:30491
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726453AbgEDWNb (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 4 May 2020 18:13:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XLkkTj5NYw+b44s+2NrmGjlbnkoxH1lQ+6QZOdSHXmdLedGFHH809QlWcrG0kB7IIkiuAMAmKPVtdrsJrrt5kkmK+wT7yLJWGTw9rvfhoGhuvo0W92jD5RUh+VMWpbp0g3zQFa3fO09vWKMUhBZZ3zpe19Mi86EpuHLQjFlZXb6FM/RdPA700rQ2CiRohYz6fnHLenxAhOqaJiPlcRVd8HJQg5nSxrtgeVLRFk4ORJQrv/6/qZVM/tEVq63aaX1GZtC2PsJSoZFpjcMI5veqZ3fVmA5A9wNpMUhUZXjmhC/M5PiJNF3wgzfENcNCoQws0EVqeFqMjZ/+OSLFvdq19A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BjDFX7OxNYJ9dpDXgqdBWyfSjC9THLPC31mAGrV8EBQ=;
 b=MPEava+oJlmFDR3CuUuGyQwLDLDrVHAg5dixdxswBjQQMTqOUFqXTTe+mVreqikvfXvenIT5ey1ki2wr9LqmlbP552nJRGzJBjGWDvY3UwzDu6oMeG0gg+CYPedgjp+V1AkJ+X5D98ekdQoatUWZKP2e/TLD7NpwDlaZCLDr2IXfvkaerdEcw0xUQEqW9aPPgYC4hhHsoXTXU9IPkpsGO05Me7OZ6Q/USOCpPP0lAAv99dgUA9bOC3RzDbfBCWRR+MInnHysVMLZ3uN5S9tRuVwl0SHxs6TsYVB00S4JOt7jtP15VLHIh96uKp1JTExDFiSaL/WpyvxiLS3J9x+cvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=live.ca; dmarc=pass action=none header.from=live.ca; dkim=pass
 header.d=live.ca; arc=none
Received: from BN8NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2a01:111:e400:fc4b::4f) by
 BN8NAM11HT099.eop-nam11.prod.protection.outlook.com (2a01:111:e400:fc4b::262)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19; Mon, 4 May
 2020 22:13:28 +0000
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 (2a01:111:e400:fc4b::4d) by BN8NAM11FT010.mail.protection.outlook.com
 (2a01:111:e400:fc4b::309) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19 via Frontend
 Transport; Mon, 4 May 2020 22:13:28 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:4D6007E31AEF8A9A2185AD085CBE1BF1311FF5835FD22518BC136F0631633D72;UpperCasedChecksum:545C498EF5A43E31BE380659542A3C8ABE875CC7C552718776E03615079AEE01;SizeAsReceived:7766;Count:50
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc]) by BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc%6]) with mapi id 15.20.2958.029; Mon, 4 May 2020
 22:13:28 +0000
From:   Jonathan Bakker <xc-racer2@live.ca>
To:     sre@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org
Cc:     Jonathan Bakker <xc-racer2@live.ca>
Subject: [PATCH 1/3] power: supply: max17040: Correct voltage reading
Date:   Mon,  4 May 2020 15:12:58 -0700
Message-ID: <BN6PR04MB0660DA4AED9364441DA33094A3A60@BN6PR04MB0660.namprd04.prod.outlook.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200504221300.3153-1-xc-racer2@live.ca>
References: <20200504221300.3153-1-xc-racer2@live.ca>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MWHPR2201CA0053.namprd22.prod.outlook.com
 (2603:10b6:301:16::27) To BN6PR04MB0660.namprd04.prod.outlook.com
 (2603:10b6:404:d9::21)
X-Microsoft-Original-Message-ID: <20200504221300.3153-2-xc-racer2@live.ca>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jon-hp-6570b.telus (2001:569:fb68:9c00:8067:f823:1e15:7520) by MWHPR2201CA0053.namprd22.prod.outlook.com (2603:10b6:301:16::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19 via Frontend Transport; Mon, 4 May 2020 22:13:27 +0000
X-Mailer: git-send-email 2.20.1
X-Microsoft-Original-Message-ID: <20200504221300.3153-2-xc-racer2@live.ca>
X-TMN:  [WGkTflbsxw0dIwykn+04DaBhHAOY46l/NDMLDEEmKCkkfbLBdRzuVm1RbH/sVrrJ]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 50
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 4f4f15c5-7f67-4772-7a70-08d7f0785f58
X-MS-TrafficTypeDiagnostic: BN8NAM11HT099:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WmgzQyya2HdaYfIWzTL22N+4XlkssgRFFCLVrjnyXkHeNLpVM/wHwgxs4fG/POcbg58xEKK/LJWq7XUH9lATyK6VE9nixBJjgWRwxY6WF30vpQCbj6MXu2kl62RiOcIuQfXyUUKZjpnP4/dAMslH//EzjP1ONyRMF1I2C2EaMfACi1Hi6gVFRRlAqvfioPI8WtKYqpy7Uez7Gag0zOO0pYBgrMsZNt7DciWGmru8ss+e1nFikwD3vdWZzgRduLWM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR04MB0660.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: mJjyCY6y9xvwNd52CklzFcJ+/oJcFHZzo6/7HCNkh/ruPPUIBD7s9dPcVSGm+VZ5LrMjT5UdJOxWvChAV9r96fo93iNg1sst2TDepgu5eAsNxLHEB4pQj68YfC3yeci9bLt1tW7qwciXSZ3lq7JW0ivyMp/rXfqDev2jouj7ts4mgye1qFZ9O7Rvh3U9h6dt1knCu8LPkNeGU2r+hAlR0g==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f4f15c5-7f67-4772-7a70-08d7f0785f58
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2020 22:13:28.7288
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8NAM11HT099
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

According to the datasheet available at (1), the bottom four
bits are always zero and the actual voltage is 1.25x this value
in mV.  Since the kernel API specifies that voltages should be in
uV, it should report 1250x the shifted value.

1) https://datasheets.maximintegrated.com/en/ds/MAX17040-MAX17041.pdf

Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
---
 drivers/power/supply/max17040_battery.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/max17040_battery.c b/drivers/power/supply/max17040_battery.c
index 8a1f0ee493aa..48aa44665e2f 100644
--- a/drivers/power/supply/max17040_battery.c
+++ b/drivers/power/supply/max17040_battery.c
@@ -126,7 +126,7 @@ static void max17040_get_vcell(struct i2c_client *client)
 
 	vcell = max17040_read_reg(client, MAX17040_VCELL);
 
-	chip->vcell = vcell;
+	chip->vcell = (vcell >> 4) * 1250;
 }
 
 static void max17040_get_soc(struct i2c_client *client)
-- 
2.20.1

