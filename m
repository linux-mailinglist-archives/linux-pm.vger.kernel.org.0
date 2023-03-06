Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF06B6ACF58
	for <lists+linux-pm@lfdr.de>; Mon,  6 Mar 2023 21:43:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjCFUnI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Mar 2023 15:43:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjCFUnH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Mar 2023 15:43:07 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B40A225E22;
        Mon,  6 Mar 2023 12:43:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H9HlhaawzeagJF3LTd7zCqyKvSdWwYaPDcZtPEmtgYWc99//eHChdscFyfoQg0A070a1Groi1+3TmdtbRtWoW4dssBtY1qcoT7mrKNcAham3djw7nY6QQHi8zcYSfzlTga/3XoKvRkv9aBDxOtCxRHwdKMyUvUdTBTYoepJ5z1SWeF3IrjIQH7yG21UdFW5s11n9R7vHqiB54Ic4DpvI7CQMPRzlFw8e28+AG8gVU94Y7JGJbXzOu3FOzQ6SmJuhPS3IndWidjiEKQZWgafqBRWMGASVflp1CrGtrhNI8Fwf1bDf5ASXzfon3MlBSA/XwFgj4TGguama1A4CrTvCYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ny926j+DnHj0EB75g1fghiymln9/ASCG987Rzy9y+u8=;
 b=GZDkyeyD/t2PjdFSAJdWLes52yrEWQQyVHU31xatxJ/Kr21id9W09Gh6PPwyhGvEE5wq5W5VOSHNLGpZ9P7Pe+HG4PjeIZQnggWsD/Vffui5jzLTCJQSGIT3xCzWMSq/5hvKsSJE5O2VgWX3PlZo/oxATP3/aJdbUeL1VVqE0hXBitBWwpr0jpOgKqRSiRF9MoCIrc6z5TMK56SMMTGUXhYwOLspBRWZ32EKxwnkDdUUwuXvIiVUarhg7cIV6SQnM8EzEzRO/1Xc3sLjdtJQ8LqqesjSb2X4P691hPBgClhgF5YjI0fMwA7hchnnLpFZpPCaOrTnLnfNFwbZAlNWCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ny926j+DnHj0EB75g1fghiymln9/ASCG987Rzy9y+u8=;
 b=Nn76flYTXaVU7lH6QGigBW/TNGB65oQdpcKIlI6r1i2rBw2NivmtkSieccF1K1kdCzfUrpENdT9Au9Y2bQZ1i8FC0RWg1OG3g1+nSuo3Ud18jAt0YSGg3+nXPvP4+JAxSdmRdLOMLUzlkQWD1sQAKIrtQVrI4Alj8r5MHuO0UzE=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CH3PR12MB8658.namprd12.prod.outlook.com (2603:10b6:610:175::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Mon, 6 Mar
 2023 20:43:02 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a4e:62dd:d463:5614]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a4e:62dd:d463:5614%9]) with mapi id 15.20.6156.028; Mon, 6 Mar 2023
 20:43:02 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Jason Gerecke <killertofu@gmail.com>
CC:     "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        "ping.cheng@wacom.com" <ping.cheng@wacom.com>,
        "jason.gerecke@wacom.com" <jason.gerecke@wacom.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: RE: "proximity" attribute for input devices
Thread-Topic: "proximity" attribute for input devices
Thread-Index: AdlHmxaRH1CSqlUwT36VLjEkDO6MiAGiZZKAAARS3IAAjYR5EA==
Date:   Mon, 6 Mar 2023 20:43:02 +0000
Message-ID: <MN0PR12MB6101B091FEBDC02539053A05E2B69@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <MN0PR12MB6101F4408960BDB9CF63DD53E2AB9@MN0PR12MB6101.namprd12.prod.outlook.com>
 <CANRwn3Tb1JgLpCiYFZBO1+PDHWLT-yxEPQ0TQ19xGDWZR9pmoA@mail.gmail.com>
 <c65e2dbc-c8f9-4481-85f1-4d1eb140a05f@mercury.local>
In-Reply-To: <c65e2dbc-c8f9-4481-85f1-4d1eb140a05f@mercury.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-03-06T20:43:00Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=0eb688c5-e0b3-48ba-ac6b-b10ea5a02289;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2023-03-06T20:43:00Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 86116ea3-5f40-4c2d-a522-bf0153688c76
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|CH3PR12MB8658:EE_
x-ms-office365-filtering-correlation-id: 001d6993-bc03-4c9e-cac1-08db1e836125
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: c0keG3uoCMwtMybv6A2v0d9dGx7ZVXJ7yJnhLuR6ob4w/QE3Fm7O256cu4HamyVSGr2BQ27b+ix2gCZjfjwMcQvycoeaHVEECWCksXpuPJPxzi4PEgSO+nEEnSiDmAcsnGk1bu9X0iugM4SMcCRT0Tb3fz4UszDN3UrgYZWYpKAATfuRkWO9EIk5s1zv2D40KRpFCKW3AgoySS6fTDQ7Gf2B9Ic2HeKBNI0hyWgKpjtKF/6l72It/lmMnXAR475S7GTgYMiFM3FqUpyJCbgnA2WXeyoNcmLKV4mhQpIwcsKfIonnItBjHQ1pgcly15WMrHnG6lZy1kt77PB9BAf/7pMfWRWZRS9SNa9xDW3dgVPleH6YmLHydK09mvt9gg1skrduJx5GT9zNn2wYgkaq+yPJzzJm3TlY/kPsDVguzseXBgzXZrvPY2wO+WL6YWK3FgDlz+Ef0yec3TX7vHcP2qcNRIUIlhX47UKfSVrGNoGP6pmPSsbHH273172/4bYWdE+Q1xIA6qfUjTgBBNgWxdYyDuCCyPqRYDRIWmV8YnBHmZz8l1m5Agjtx48XGhhnA+FUff24LpfOU8QIK8FETSomzhIpKD6HFw2Psx0IrYfLDjVmCsqbpguCW+JdmbJK55o7twMeMVVwpOkz5+RID0ltxgT7YralKuLLNnAYVMN6T6wNQO/YBhprvvboLs8gkQ0v3WRzcYxVFh+DIWbv1A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(366004)(346002)(136003)(376002)(451199018)(33656002)(4326008)(76116006)(66946007)(66556008)(66446008)(8936002)(8676002)(66476007)(64756008)(5660300002)(2906002)(86362001)(122000001)(41300700001)(38100700002)(38070700005)(7696005)(71200400001)(478600001)(110136005)(54906003)(316002)(6506007)(55016003)(52536014)(83380400001)(9686003)(53546011)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xu4cI/wg83Jwxq2ViPKRjZPOmfHSYqnYY3Bj1xLrhPC/OWB2zfuyr/aShYk6?=
 =?us-ascii?Q?vwr5+FW4m3dTrCVJACS7DL7tOQSvT3Am+baojeBw0m2nrUpW4FOzJqRs8Wa/?=
 =?us-ascii?Q?F/pWMXJmT5+yUGAEfLz0oRjLW+nQ4dLzXHxZW3RkSoFAzC9UCJCaaRG6AJrr?=
 =?us-ascii?Q?zi/g866Mgl2+2TfCw1bdUF/E6A5on1aYzOqQZqs/ZYa4qO+g3dXGM1bmiOgd?=
 =?us-ascii?Q?frpgX9xIMsd4kUvs27LJE8CdFy4PZdnyisivASgKVgN3mwUYSZRpC2QqG4/4?=
 =?us-ascii?Q?icxtJxZQ8Z3BnWliEwBBuEi5oPH+Hn+qvGtAj291YwSoHx8K/pp22YVB/H2H?=
 =?us-ascii?Q?lhLCdVMw35BMlouELVrF+rQRdBwPqFI64zuviHaSLbry0MT1+nbQ2N/XY7L0?=
 =?us-ascii?Q?JdTaoMPVFnyggvc0rkH3pHHRYWQS609iUE0f9ww2X2qhAAOBsi43TIFHFBmF?=
 =?us-ascii?Q?10FGD9TVTQ1zWKSeRMZEV04YhcArXx5o9MrgzDczGz7K+Csl0CFUERQJw0PH?=
 =?us-ascii?Q?NjRSkaLHsvFTQa97DQz0dmrdKchOn4Nadrpi69iAkKO6VqHLzWJfyWXSvPaw?=
 =?us-ascii?Q?n2q4hDTXdrZY5OWGT6nmoupk4xAt7rdVS5Td0pgcsoLpusklIcL5nrtAbbJb?=
 =?us-ascii?Q?38AThKoT+hTLhI99Lc02bUW7P+0gTXsPGVIbIfHVsq8FRp0sTPHc7JrzWPzn?=
 =?us-ascii?Q?A8dWQdV2eEFG7aLiDbeRi/w/KQMxOKrS3SuMthSQVU/bKD/mL1r5RHvAXBtP?=
 =?us-ascii?Q?b7AmMPC8/f6v4iaxMfzc0Cavez9Kj/O8ZgVaPmBpULnuPHv5M0nKCl9KYTAm?=
 =?us-ascii?Q?rSI5484yidQe+l3KnT5tcLNV5BIbp3fNLojpNEKahfcoEkZqTQUDdW5POJK4?=
 =?us-ascii?Q?686BzTyi3OOmmtnkMjOuuqqo3Gr3iWz0+GWQqqPomz7rX/LAMPRk9fxSzdIq?=
 =?us-ascii?Q?+aC544t+s1DftsxfM/2xBVV7O2ryZvepwdFUjXOMdnriCF/1DWk2JMJFdkis?=
 =?us-ascii?Q?9FWsf02qvpl1TzN10r2oH4fOQcBEviFvDdorRMNMhf8HDyv9i0nvNZCDHJ2O?=
 =?us-ascii?Q?ydLk/WNUOGb3Ob1xzmpZXeNYyydbEqcIEZB1+bF1z7rFnNih7pB6w5b0gQzS?=
 =?us-ascii?Q?n9SQp+vb2Qm7TMWMqPeywLM6eYn1gZmncScLrU74usRGLruv37gOVtjBHEQ4?=
 =?us-ascii?Q?f76TEPjaBwuSfnaXUZkaHoU07zoWOVoaT6YkQTsBXSya1vvegJ9bz6ggaP56?=
 =?us-ascii?Q?fF7FKApwsUTK1WWTGxj/UzI1Tn+k+XvMm0puVldKs+BdGeNFGqo01aQYeTZj?=
 =?us-ascii?Q?mnRtxMbMogeLEmQvVbCWAr/XQ6Z6FqBXFiBw4SKkJt5uII1SBv71WkKfR+JS?=
 =?us-ascii?Q?9V+JiSzN/MT9Zxm+HB1RF63U+yBWOgnGGjaWyHHP2mmoWFtv1aFdh1FRmp6d?=
 =?us-ascii?Q?7KQs0Xng1b3N8K4wvaFDLcEMBJN4bUS8/1sR6cjLbIhuyYjNLdnpE+1XYHUC?=
 =?us-ascii?Q?XX7vu7lhKI04fU70fWrrOms54n8LE8ss6Ywl2BnrijDtnS7eif/kUnPIRXbu?=
 =?us-ascii?Q?IqjfUfWWrj2qLlKGZIcBCmdxJZoQc10GuN0HSn2LZfxh2EnRcJlQmHFxtiTi?=
 =?us-ascii?Q?5OGxypkosmnGR5xTXl0U6Ao=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 001d6993-bc03-4c9e-cac1-08db1e836125
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2023 20:43:02.1846
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dsiwXcp6l5H94sCVy0vu4P1wBFm4hLa/bhgmV35EFLK6if5SF+BkjZ8ncmZGzGmzv3OWFbcWdywb+UEdc64edA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8658
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

[Public]



> -----Original Message-----
> From: Sebastian Reichel <sebastian.reichel@collabora.com>
> Sent: Friday, March 3, 2023 19:09
> To: Jason Gerecke <killertofu@gmail.com>
> Cc: Limonciello, Mario <Mario.Limonciello@amd.com>; linux-
> input@vger.kernel.org; Bastien Nocera <hadess@hadess.net>;
> ping.cheng@wacom.com; jason.gerecke@wacom.com; linux-
> pm@vger.kernel.org
> Subject: Re: "proximity" attribute for input devices
>=20
> Hi,
>=20
> On Fri, Mar 03, 2023 at 03:05:41PM -0800, Jason Gerecke wrote:
> > Apologies for the delay in replying.
> >
> > First off: as an immediate action, I'm thinking of changing the Wacom
> > driver to do lazy creation of the power_supply device. This would mean
> > that rather than creating it at the same time as the input device, we
> > would wait until we receive some kind of affirmative indication of a
> > battery being present. Most Wacom peripherals report battery status in
> > a "heartbeat" report that is sent every few seconds, so there wouldn't
> > be much change for the typical user (just a few-second delay between
> > connecting the hardware and a power_supply device being created). In
> > the case of the "component" devices that are built into laptops and
> > other computers, however, the battery status is only reported while
> > the pen is actually in proximity. For users like you who don't own (or
> > never use) a pen, this means that our driver would never create a
> > power_supply device -- preventing GNOME from showing a battery that
> > isn't relevant. I'm working on a patch set that does this but need a
> > bit more time to finish it.
> >
> > That's only a partial solution, however. If a component user were to
> > bring a pen into prox even just briefly, then a power_supply device
> > would be created and not go away until the user reboots. The pen's
> > battery status will become stale at some point in time though --
> > self-discharge, use of the pen on another device, and even just simple
> > irrelevance if the user hasn't used the pen in a while (do I care that
> > the pen which I left at home is at 50% battery?). I agree that it
> > makes sense for userspace to hide the battery after a while due to
> > things like this. Are there new signals that the kernel should be
> > providing to userspace (e.g. an attribute that indicates if we're in
> > communication with power_supply? an attribute signaling that data
> > might be stale)? Or are the signals that are already provided
> > sufficient (e.g. should GNOME just hide power_supply devices that are
> > in an "Unknown" state? or maybe hide power_supplies which haven't
> been
> > updated in more than 1 hour?)
>=20
> Can't you just unregister the power-supply device if there hasn't
> been any heartbeat for some minutes and go back to the init state
> (i.e. the one where you are waiting for a heartbeat to appear for
> the first time)?
>=20
> > I've added the power_supply list and maintainer for some additional
> > viewpoints on the second paragraph... If there are questions about how
> > the Wacom hardware and its battery reporting works, I'm happy to
> > provide answers...
>=20
> I think the problem you have is quite specific to the Wacom
> hardware. Usually wireless devices are either connected or
> disconnected and drivers unregister the battery device on
> disconnect. So I think this logic belongs into Wacom specific
> code and not in generic power-supply core code.

Conceivably can the input device come and go too when in and out of
proximity?  If so, you may be able to just tie the power supply creation
and destruction directly to the creation and destruction of that input
device.
