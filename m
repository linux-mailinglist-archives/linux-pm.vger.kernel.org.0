Return-Path: <linux-pm+bounces-2512-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 118DE8373B3
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jan 2024 21:27:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B523B287632
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jan 2024 20:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93AA64177C;
	Mon, 22 Jan 2024 20:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="8nnywCHk";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="8nnywCHk"
X-Original-To: linux-pm@vger.kernel.org
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2055.outbound.protection.outlook.com [40.107.6.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B236341763
	for <linux-pm@vger.kernel.org>; Mon, 22 Jan 2024 20:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.55
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705955248; cv=fail; b=d/X1HZpmaCRmlcAnasRnm0rDT1Drpw9Xgxvnl3cPMjLREcMRegpYIhSUoiboqzam99W86R6SBKUPbt895v+PXBWFDReIsWaMp3XcfTPccpozVI0nKFiQVi94af4i+CvGar9BDEen7ly3NAXRU6Y8RDpHqJXnmG40MhlMxO4HiFg=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705955248; c=relaxed/simple;
	bh=JjKGwoSHFeNMMw7VrYBXOz76Wa9gK3cWjzaIYWfe6Gk=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=s7EhQRz1jB0aAHAAqVNtKdIwU8VwseKuNdriPSsSSi0PhRv6zy/HeDzRF0nAQGgzlO86KONpPNrpTGrsrans+FaKEXDGArE6l0a5DyGYS4u04r42cWlqCkFuXDgOZPupR+qc95+RGfnv1AeOCXZRh/NZDCcHIwUvNUXZ1q08QsE=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b=8nnywCHk; dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b=8nnywCHk; arc=fail smtp.client-ip=40.107.6.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=Xm+hXOUyzA/BLqS6ZyRr32lq1BkOMZJi2lsHUQPZ75oszn0Vi6l/833dVj+jEtvt/D5qQWNty/P7loX21CC4qd0O/YU/HMPD0ylFSj+d+S2yPIS7kpAcc+Jc01p22dGVR9HQxOrcL7BJm1rFtrzf1EWCn90xlFviBMFe5pAMIlDbG73XFjbmHqEI+AmgJDHOHpmK62BNi3F+Mw3YMFALJ/lAJ9gRtfCVV9XauKbU9OB5DmDvs8sVUWd2ZWxPz+wVpiGygCH8P3WgrOGV5ugKxejkcKMky061Onyu6DWsG4H8WUhiEHQS/uzrnd37fbmt0P2rsRFtAiKJE1bHsjuUQw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OnQvOk+yNUK1LmLXgeJHrg7+RT68fptGZ3DRBDpJz+E=;
 b=F+HJYt1qX50oRxh+1ORcC6er2lhYYsrTtxFiq2yM3Js/nU/Rxeza36Nq/TrkpWHe493nz9DSUXkY9cZ/+DmmGNZe7PkI+RRPy/cYlxrK6DR2pYEEbpLnXqNd5G6YcDNYcwmxT83Y2gGVdF7HTs3VFuC2C6ycIirqbwoXCiHDIQNsFDzJPrI0jhgaiyQGn7dwn20ZyK7VouK7llAK/bpyif90sPNp2eEhedetAIBWMpYKldsPoCRLDpzx1J7jn6vu20ztHN6RJd2kK/UwbWrNcfybc4PdkzykP3P8DD0mm8z2z5f0GjUDTr0UCWRnEQCErlRBBnroYTrS6D6x5A71Xg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=armh.onmicrosoft.com; arc=pass (0
 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OnQvOk+yNUK1LmLXgeJHrg7+RT68fptGZ3DRBDpJz+E=;
 b=8nnywCHk0kYCswv73XqKnKhpm/mCG4v+eh9V9pbKb1t2/CqT45fCUpO53L2rZMV7YKwD2Fh2Lc4OW7aJtPMqnpVbQdU60XcgZQTVKOza/A7xBhUVcIKF4bqAfcmAPvytVFUAItnTQVeacx5x3QhSi54/1G9qkjzPaNeP8jxMZ0A=
Received: from AM0PR03CA0045.eurprd03.prod.outlook.com (2603:10a6:208::22) by
 AS2PR08MB9715.eurprd08.prod.outlook.com (2603:10a6:20b:605::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.32; Mon, 22 Jan 2024 20:27:19 +0000
Received: from AM4PEPF00025F9A.EURPRD83.prod.outlook.com
 (2603:10a6:208:0:cafe::41) by AM0PR03CA0045.outlook.office365.com
 (2603:10a6:208::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.31 via Frontend
 Transport; Mon, 22 Jan 2024 20:27:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM4PEPF00025F9A.mail.protection.outlook.com (10.167.16.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7228.0 via Frontend Transport; Mon, 22 Jan 2024 20:27:19 +0000
Received: ("Tessian outbound c87008563c51:v228"); Mon, 22 Jan 2024 20:27:19 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 29c686cc70c6eff2
X-CR-MTA-TID: 64aa7808
Received: from 3812da4aa1f1.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 91B6820F-45BC-46B1-8BE1-6EE5B5EA5E83.1;
	Mon, 22 Jan 2024 20:27:13 +0000
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 3812da4aa1f1.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 22 Jan 2024 20:27:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mL21EvwyAORsuFmyFls7BHa5Skwecv48E9RXB1gJsEduLkgPOJ613MRBGa5IrsJWjLebUSpHzLgCSiYxL/AAft4zMYGGlny2DmrS9zzjZA65HrQrKEvSvtgwMsAxlfsS3veH+FTPuzSm+rzsQq7aMV4e4u1gZTO1JRaGr48LqM+oqWUGFEbiaHjiubydbSZHHCE7j5mRIvHTUB/eBIBkDdlWSkughCixZa+vi2MYlQJKZI7kit7OWDrco7FnJF8uavNQQDjM6kR3ay8lbL8BzUQ3PFr59L+90+hCa9OutfJzSCE5evEr3LPHeGcj9jGN8CJFsgUx4wXn4xKusbKJkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OnQvOk+yNUK1LmLXgeJHrg7+RT68fptGZ3DRBDpJz+E=;
 b=jDL/5D+400n3qyio5ySq4HAIlcb1oVrew4MMWlpdv9axM+LRnm4jBBSZN8UzOEagmH6+j67eEJILrmv1yHu+1aZYS4lMPPQqEV5V4ZRNPdxqUtYkPVk/m8DFUayIfhjeZXfWCw7RT3s+C9wKq68TfztVdEcO2tuWg+/AiFf+C8UCoJ30TxH3inK9TmzHqwsAO0HFbDB+nhpCSnPz0ACqyc0NaxqtaURgwcL6gUSk8OwIgYF9cSaZaP3MYZJEXTLooG65k8zwl/pp7IxOCn4EamLrjIjFBHTl1FN5/qbI2PZpQ97GE2+diBbqovYazfvZ6fStcfMzs4qR9zGU1k+9tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OnQvOk+yNUK1LmLXgeJHrg7+RT68fptGZ3DRBDpJz+E=;
 b=8nnywCHk0kYCswv73XqKnKhpm/mCG4v+eh9V9pbKb1t2/CqT45fCUpO53L2rZMV7YKwD2Fh2Lc4OW7aJtPMqnpVbQdU60XcgZQTVKOza/A7xBhUVcIKF4bqAfcmAPvytVFUAItnTQVeacx5x3QhSi54/1G9qkjzPaNeP8jxMZ0A=
Received: from VE1PR08MB4768.eurprd08.prod.outlook.com (2603:10a6:802:ab::22)
 by GV2PR08MB9877.eurprd08.prod.outlook.com (2603:10a6:150:dd::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.31; Mon, 22 Jan
 2024 20:27:09 +0000
Received: from VE1PR08MB4768.eurprd08.prod.outlook.com
 ([fe80::5c98:7294:1307:4796]) by VE1PR08MB4768.eurprd08.prod.outlook.com
 ([fe80::5c98:7294:1307:4796%4]) with mapi id 15.20.7202.031; Mon, 22 Jan 2024
 20:27:04 +0000
From: Ben Horgan <Ben.Horgan@arm.com>
To: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
CC: nd <nd@arm.com>, Vishnu Banavath <Vishnu.Banavath@arm.com>, Florent
 Tomasin <Florent.Tomasin@arm.com>, Ulf Hansson <ulf.hansson@linaro.org>,
	Sudeep Holla <Sudeep.Holla@arm.com>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>
Subject: Using scmi performance domains and scmi power domains together
Thread-Topic: Using scmi performance domains and scmi power domains together
Thread-Index: AQHaTXCIC237/uJ1K0CA6xtK0hXWVg==
Date: Mon, 22 Jan 2024 20:27:03 +0000
Message-ID:
 <VE1PR08MB476848A0895993EAC92AF77B91752@VE1PR08MB4768.eurprd08.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic:
	VE1PR08MB4768:EE_|GV2PR08MB9877:EE_|AM4PEPF00025F9A:EE_|AS2PR08MB9715:EE_
X-MS-Office365-Filtering-Correlation-Id: be589c94-7273-4e13-f806-08dc1b888855
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 96SFy1Oi9YLbONkgZeTO8JYPWWptAB3VboHGPcXxFDMqNnMq5K9IFS6hpPb5NjHloywag1by1no6MMa7/QIHsyNQRYbmsFBVHzJAkZLtbFICcdQjGuhMp6+kbDzQoDqJuR4d/64m02RGj/Xx+RR0mb2iKHf9xSq1Lzz5EO2t9iw1jkgfKPDQyVKAmN4B9T7s0L0QPwPl7n95M5RlCT3EuaCAJC7CTJ8ool9li6ezsWRxb/THFrWeCWUMYl82dgbvxBQmUhQX5TGeJ6YjLIkcrDl//UtPDVsXAk/f9Fw9+DS/1ziHddCFI3O2DBtMkPdLer5Pqt7AATjufDca27HwayRNd0UTXJnZGh9DV1JbOz9VAfJbjNKVPJejbWJCmgAdFJBDpHMAH6eGhMbgieVL+q9T01gdsLPlYX91zp+8XhTPzOrCpNTdaPOHNCmnmwopXIKGyfhGAxNYlVveMpdBhC3FkZxmROxDH4itxX7eRj6JTMsIpKj/qSRzWnUWwPmmPPHP4LH+8w9EAAVo7+y4uqjAnNxG6Sf0Y4fx3FdsfxFyBB4QofI5b/dOiIYWN7r0VKOpQlBef9oVbE8PaHzs4n+xNrGaxU2LK0tOxq1DSWle3dfYl7j+ppimxbNoQf2a
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4768.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(396003)(136003)(366004)(376002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(38070700009)(55016003)(66946007)(66556008)(26005)(64756008)(54906003)(2906002)(9686003)(76116006)(6916009)(66446008)(6506007)(71200400001)(8936002)(91956017)(316002)(8676002)(4326008)(66476007)(5660300002)(52536014)(7696005)(478600001)(122000001)(38100700002)(33656002)(86362001)(41300700001);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB9877
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM4PEPF00025F9A.EURPRD83.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	884cbb67-5f78-4a8d-c206-08dc1b887eff
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	r/jnVL367kdub4ba1OGEuHSmalWweW9pq0KdHfi0EWaRDzg5Q05pD31bA9Sj7k3SKhCecx0feaJyJ2PQNjIMfrnBor1intEPuAmtUImOPvMHHh8u2lS/6HYp9Ic23kZuzuCyU1RSx2kIfwLiL5PaGYTxqUQBZy2TDyDdpDisDYIK3OwojgX4MfW7oNMch6z07JU9tmtVBtF0HreRQNOsMWXy1TEJQK35YZQ2H6wd/BQvjPDqhJR5h4xrAizc8L8ENgKTrBxcRmsg2wzUr+AJ8U1RnLOyPyVp3rtQZZ1EdsN2/6OOGabnArQn3WLgL34D31qeQqYY8LCZ3gjD4pC6MMxE3HoFdBH0bNnjhZR2P8z656VMqT4HcePUHurbFxSIUhLQzspY9lReeoiIjzEw1rhHV3ROqfNFc7lIlo5rF4wr7+sYvgz7cZ+QSaT6cvwaYT2rDp+aQH/8yxn9nS6ItXbjHmS0/rgGgyRWDZjtsAtLfXz2yBqfPg/YJlZei6IpzKM9RCZyI+NEWpnsz7gKEIYaDZQTpkMmRp9O96Ey6yV4dZsJgztdo3nojRINkHxT74rfRdvw7iIr9+tTfzJZHZktzXqCDE056vUtMAN8t28uO1nXCk7q/6RCnkvLSOm6Ao49L5uLESmhAZuqQIAzoH6Q1Ku0SPRpywjxd7G4C4/IAaFZD4OllIBNlABD5KKMFxbVkH7Pq+3WovsOvbpD1HavxQx4JWR+oyUZ5H/q1mtYLLOq6Kq+4m/4ksdwSjyu
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(396003)(136003)(39860400002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(82310400011)(40470700004)(46966006)(36840700001)(55016003)(40480700001)(40460700003)(336012)(7696005)(9686003)(26005)(6506007)(356005)(86362001)(82740400003)(81166007)(33656002)(52536014)(36860700001)(5660300002)(2906002)(47076005)(8676002)(41300700001)(70586007)(8936002)(6862004)(70206006)(4326008)(54906003)(316002)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 20:27:19.6136
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be589c94-7273-4e13-f806-08dc1b888855
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00025F9A.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9715

Hi,=0A=
=0A=
I've been looking at adding support in total compute, an arm reference plat=
form, to control the gpu operating points and gpu power on/off via scmi. Th=
is was previously done for the juno platform but involved hacks. I would li=
ke to make sure this is cleaner going forward.=0A=
=0A=
For device driver simplicity it would be good if a device with a single pow=
er domain and a single performance domain could just use a single PM domain=
. Using a single PM domain means this can be on the platform device and you=
 don't need to create virtual devices. The drivers scmi_pm_domain and scmi_=
perf_domain both initialize a separate 'struct generic_pm_domain genpd' for=
 each of the corresponding scmi domains. Possibly, there could be some way =
to bring these together under a single genpd domain. Possible options are:=
=0A=
=0A=
A. Parent power domains with a helper driver that just uses an empty genpd =
domain as the child of both the genpd performance domain and the genpd powe=
r domain.=0A=
B. Combine the scmi_pm_domain and scmi_perf_domain driver and create a 'str=
uct generic_pm_domain genpd' for every pair of power domain and performance=
 domain.=0A=
C. Combine the scmi_pm_domain and scmi_perf_domain driver but only create t=
he 'struct generic_pm_domain genpd' for the power domain combinations that =
are used.=0A=
D. Keep things as they are and use separate PM domains for performance and =
power when using scmi.=0A=
=0A=
Examples of possible ways of expressing these options in the device tree, t=
he scmi performance domain is 3 and the scmi power domain is 8.=0A=
=0A=
A.=0A=
=0A=
scmi_devpd: protocol@11 {=0A=
	reg =3D <0x11>;=0A=
	#power-domain-cells =3D <1>;=0A=
};=0A=
=0A=
scmi_dvfs: protocol@13 {=0A=
	reg =3D <0x13>;=0A=
	#power-domain-cells =3D <1>;=0A=
};=0A=
=0A=
perf_and_performance: perf_and_performance {=0A=
	power-domain-names =3D "perf", "power";=0A=
	power-domain =3D <&scmi_dvfs 3>, <&scmi_devpd 8>;=0A=
};=0A=
=0A=
my_device : my_device  {=0A=
	power-domain =3D <&perf_and_performance>=0A=
};=0A=
=0A=
B. Combine on every pair=0A=
=0A=
scmi_pm_perf: protocol@11_13 {=0A=
	reg =3D <0x11>, <0x13>;=0A=
	#power-domain-cells =3D <2>;=0A=
};=0A=
=0A=
my_device : my_device {=0A=
	power-domain =3D <&scmi_pm_perf 8 3>=0A=
};=0A=
=0A=
C. Combine on used pairs=0A=
=0A=
scmi_pm_perf: protocol@11_13 {=0A=
	reg =3D <0x11>, <0x13>;=0A=
	#power-domain-cells =3D <2>;=0A=
       used-domains =3D <8, 3>, <9, 4>;=0A=
};=0A=
=0A=
my_device : my_device {=0A=
	power-domain =3D <&scmi_pm_perf 8 3>=0A=
};=0A=
=0A=
It seems wasteful that the scmi_pm_domain sets up and makes scmi calls for =
all possibly usable domains at start up even those that aren't controllable=
 by linux. E.g. cpus may use scmi power domain controlled via psci.=0A=
=0A=
scmi_devpd: protocol@11 {=0A=
	reg =3D <0x11>;=0A=
	#power-domain-cells =3D <1>;=0A=
	used-domains =3D <8>, <9>;=0A=
};=0A=
=0A=
Any thoughts?=0A=
=0A=
Thanks,=0A=
=0A=
Ben=0A=

