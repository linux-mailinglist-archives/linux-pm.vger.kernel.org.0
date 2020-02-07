Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9332D1551B4
	for <lists+linux-pm@lfdr.de>; Fri,  7 Feb 2020 06:09:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725851AbgBGFJW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 7 Feb 2020 00:09:22 -0500
Received: from mail-vi1eur05on2088.outbound.protection.outlook.com ([40.107.21.88]:6034
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725837AbgBGFJW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 7 Feb 2020 00:09:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iEiOXt6hLBeQwofBwW35Z2VA2FOTKkDsCTV7gHhQARTtDYoPm9FyJ2pc1fbG8vKTIe26NWSBwoacMm6C/hMEC9rem9WLtXuKEN1uztvsV3m8hMKgocCLitjuNf+h63lUsp7w1WIo0DRcM7XP4RWp6WBI2vAL2MiZPbdy14098AkJG4C2EIkRSdjUEEaxA4Jz1sLjGy1G5uB76xnbzEN2JGiQxN05Ib40FsmmxB4FzsQjFi79obkN2/G33/WWe8G6OoVgMgLzQNyE/C96CL9NPtz90R7B5PKUFr5dBemLS85rUJln14sB20GhGZ9i5ieo69djjpp+V0oxTVhXbRgEpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kQ1dUI9G1SnZHyPWkNQAH5A+nQuUh9yMcE0AodF5+oQ=;
 b=JEhjtQWSd0cUtCPnnv6AFSXlIfVjEOExjZhZCDTVFl9V8NU62KUl3CSccCVn8bqArZdM+ZE84UPLqmdqhAuz1R8/MlYwV9e4YxngLSh3VXKbf994h6wS18j8HnJGvn+XNpy49eXZ/c/2vFvavwnybD/6H4dvAdvBRl24Zq8KEX7d444saTaw+umXcLIxlGsPT6pzfB3saBs7e1jydgLkuBiI2VPC3AQfjDbyObcsZaJgVINSJrcLabewoTc2p3XLmc7OmxKwLCTtpkSxOq7vEKdoHzMcQALX9zIcnKrps2OPMB5zvKeIql4vwrBAqQa7jSp9cP6x2syh8aHNn1Qwfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kQ1dUI9G1SnZHyPWkNQAH5A+nQuUh9yMcE0AodF5+oQ=;
 b=XKoSz2a3pGrYREh9AZifEohZo0NxtbiqxJbYEQjcbObYfuxwceitE2+AoBBY6injC2M8j9J4UErMmC22ttjeqG6YycWuwPEpftobV9xnWlpGECngzWE3fCxzBigK+6bxW6hspyp0PiXEgAJmFyqzHhoXqrBXDlEILYbhFAFf6mQ=
Received: from VI1PR04MB4333.eurprd04.prod.outlook.com (52.134.122.155) by
 VI1PR04MB5904.eurprd04.prod.outlook.com (20.178.127.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21; Fri, 7 Feb 2020 05:09:19 +0000
Received: from VI1PR04MB4333.eurprd04.prod.outlook.com
 ([fe80::fd7e:a5a0:691e:c123]) by VI1PR04MB4333.eurprd04.prod.outlook.com
 ([fe80::fd7e:a5a0:691e:c123%6]) with mapi id 15.20.2707.024; Fri, 7 Feb 2020
 05:09:19 +0000
From:   Andy Tang <andy.tang@nxp.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
CC:     "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Ask for help about cpufreq issue
Thread-Topic: Ask for help about cpufreq issue
Thread-Index: AdXdcxSxB0cyUSagT5OnSrOpW6FSxA==
Date:   Fri, 7 Feb 2020 05:09:19 +0000
Message-ID: <VI1PR04MB4333D45D033CB8E33CB9070FF31C0@VI1PR04MB4333.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andy.tang@nxp.com; 
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5bca33bf-00b7-4ece-ae18-08d7ab8be327
x-ms-traffictypediagnostic: VI1PR04MB5904:
x-microsoft-antispam-prvs: <VI1PR04MB590497A159DCDF3584D6F3CEF31C0@VI1PR04MB5904.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0306EE2ED4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(396003)(346002)(39860400002)(136003)(376002)(189003)(199004)(6916009)(4326008)(6506007)(76116006)(9686003)(55016002)(71200400001)(186003)(8936002)(26005)(86362001)(81156014)(316002)(8676002)(478600001)(54906003)(66476007)(81166006)(66446008)(44832011)(2906002)(33656002)(5660300002)(7696005)(52536014)(64756008)(66556008)(66946007);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5904;H:VI1PR04MB4333.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UAe9dYBaEWD5EBicKvoI6x9oiuMYsx0FfNz2/Ee1fUBq6r6iZ5kr2xPK7CUHGlmgIbdCh7RhWAIhEbnNByPK8wIYegwHcbzCc0woytSrRXmWJDT6p83rCiwDiVPfgwOOKwF34Zo4FeJTWVyDswYyzJZVy5g6NlHYepnWdBl8kmmNRB71DflGMasB1g3h6846NhEwysD7nhGicsw1jvIXRTKqVXT9G2dJ7Q2JvtSKBB4Um89gA9vHthbyXLyds3Oboh5LUCeibw1uTjtEh71LwO4txpPOaQE9QXH8ENZn+GOsjFP3XCnAnKG4JFTsDDDJA3xyXtlhoB7e2ajxKYWiKUA+rY9Yv4hdV9tU8fQmDgvS3zW8kj3qexGzeMnpW8o/IUtL6iPWA6iSY+NPo6/VcUjdImmWeDUQf2uXR2s3MQJ/bQpv5bTV2jDa7bWnzIyF
x-ms-exchange-antispam-messagedata: N3/tY730govVD8tYQLU3q9QM6dddlsSG19xDEBJIG+JekOuyUR4wxzmwTTaigg2KPeOZrFGkf2fqaUdzKFzoC8TXlWheOTdtSoZAi4YNPnCCNwuQ4aF5AlSTlOvvWHzJyjI9OJPsXVy+QhegX2XOLA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bca33bf-00b7-4ece-ae18-08d7ab8be327
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2020 05:09:19.5157
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rePYEbRdb4JL3Mrslapan86KyvWFkMRf+5O+nvjvC/riBgmyWa1wt8DuGxV4yf3yG1Q/YK4oZZdnfcDaB2r1qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5904
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Viresh,

Cpufreq failed to work on our board. CPU frequency keeps at the lowest freq=
uency whatever governor I choose.

Hardware platform: ls1043ardb board (4 cores arm64 arch)
Software: linux kernel v5.4.3 + ubuntu 1804.

Test log:
root@localhost:~# echo performance > /sys/devices/system/cpu/cpu0/cpufreq/s=
caling_governor
root@localhost:~# cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq
500000
root@localhost:~# cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_availabl=
e_frequencies
1600000 1000000 800000 500000

All the parameters you may need:
root@localhost:~# for entry in `ls /sys/devices/system/cpu/cpufreq/policy0/=
` ; do echo $entry;  cat  /sys/devices/system/cpu/cpufreq/policy0/$entry; d=
one
affected_cpus
0 1 2 3
cpuinfo_cur_freq
500000
cpuinfo_max_freq
1600000
cpuinfo_min_freq
500000
cpuinfo_transition_latency
31
related_cpus
0 1 2 3
scaling_available_frequencies
1600000 1000000 800000 500000
scaling_available_governors
userspace ondemand performance schedutil
scaling_cur_freq
500000
scaling_driver
qoriq_cpufreq
scaling_governor
performance
scaling_max_freq
500000
scaling_min_freq
500000
scaling_setspeed
<unsupported>
stats
cat: /sys/devices/system/cpu/cpufreq/policy0/stats: Is a directory


Could you please instruct me how to investigate this issue?

BR,
Andy
