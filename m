Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAD0E2D2FBD
	for <lists+linux-pm@lfdr.de>; Tue,  8 Dec 2020 17:32:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730162AbgLHQbs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Dec 2020 11:31:48 -0500
Received: from de-smtp-delivery-102.mimecast.com ([51.163.158.102]:32948 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728602AbgLHQbs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Dec 2020 11:31:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1607445040;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d0GJtz0zOfg3ilKmpm5pbT1rah50qJjsOnh8T+hQ2lk=;
        b=OnnrSj4/0hoFABNZyT/rjst3e4Z+yZsw1c2eJWYf7SAYowEsp2tHi9VDQkYjg2Zl4E8f/h
        hJPuPB1Edlbw8xxBAsc0YIpK9Eev9z21Pwv4uT6lFXZ+OMGZLm9JZP3+YL+ow7RvpJyYFV
        njZBd6CAn4eyxQVmeXZNeF60HFHeXow=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2112.outbound.protection.outlook.com [104.47.18.112])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-19-oO2uXQ7ROW26YyaIrkdVmA-1; Tue, 08 Dec 2020 17:30:38 +0100
X-MC-Unique: oO2uXQ7ROW26YyaIrkdVmA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UZT89CxLFJcY8Tp4yAZpRkVbsx88SBIJ//bdXG5NpgriDYC7oGkVyhZd+ukTOGR8cTjkx2VlTm4fTUxH3IoYXG+fIghdvsXth2NU0gqmqlBPdukvM9J37U8MJHi62cr965BpRJ19FDbeCLPqnpaeEQuYOsg9zaH3+dqadBP/BoF+EXDtv/kISPfWi41h9XBGuqx2leedsxQRtgG7tB8TyzfmlbpP/FHwQWMKRuP4ra7kPw+05tD1yCCulYma1wgNxwWC5ROAPg3XN3jaZ8TUYXxjoDQfUnq69/ypnUU8BHO114+ESJPNRXk15yTiyS62nRBZeGrFSskZAgFqNAcb9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d0GJtz0zOfg3ilKmpm5pbT1rah50qJjsOnh8T+hQ2lk=;
 b=IeDqaqZMSQAkmIkxneuvaa/RHOwI2g1gkVQyM29S+hFsmFSy2qk2B5ObBmsZ4VnTYg2yCrSIGbsDdTXflejIQA44x6bwJ6j/4EhT6Jp96XTtQPv7cEWJWI7L+uQd5Afof7igTPOimcGjh1LLD7pT8KGLS86DWiV4qd26JMm4KcJYEjp2LpQON4Xvsuxp11gqbomdFlDSQoGjLsBnr8j0/0RhIwGKDBAu2vwAXiVu8Sd2ZI+zFT0NT6ODJ/5ZXKLgoRmT4pc5PbA+NDCctoxL4vBZ/kch9PMtOpUJo5yjOwoJbQ7FtZO6RN01fq5NHITG4hUbTn51tpLn2Iz+4D4BmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: rjwysocki.net; dkim=none (message not signed)
 header.d=none;rjwysocki.net; dmarc=none action=none header.from=suse.com;
Received: from AM0PR04MB4530.eurprd04.prod.outlook.com (2603:10a6:208:70::28)
 by AM8PR04MB7297.eurprd04.prod.outlook.com (2603:10a6:20b:1c5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17; Tue, 8 Dec
 2020 16:30:38 +0000
Received: from AM0PR04MB4530.eurprd04.prod.outlook.com
 ([fe80::797c:6e40:f893:4082]) by AM0PR04MB4530.eurprd04.prod.outlook.com
 ([fe80::797c:6e40:f893:4082%6]) with mapi id 15.20.3654.012; Tue, 8 Dec 2020
 16:30:37 +0000
Message-ID: <1607445035.2673.64.camel@suse.com>
Subject: Re: [PATCH v1 0/4] cpufreq: Allow drivers to receive more
 information from the governor
From:   Giovanni Gherdovich <ggherdovich@suse.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Doug Smythies <dsmythies@telus.net>
Date:   Tue, 08 Dec 2020 17:30:35 +0100
In-Reply-To: <20360841.iInq7taT2Z@kreacher>
References: <20360841.iInq7taT2Z@kreacher>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.250.132.148]
X-ClientProxiedBy: AM0PR03CA0057.eurprd03.prod.outlook.com (2603:10a6:208::34)
 To AM0PR04MB4530.eurprd04.prod.outlook.com (2603:10a6:208:70::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-ni6k.dhcp.prg.suse.com (195.250.132.148) by AM0PR03CA0057.eurprd03.prod.outlook.com (2603:10a6:208::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.18 via Frontend Transport; Tue, 8 Dec 2020 16:30:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4a84e458-c33b-424d-8fc7-08d89b969889
X-MS-TrafficTypeDiagnostic: AM8PR04MB7297:
X-Microsoft-Antispam-PRVS: <AM8PR04MB729745A48FF0EFEB8F34581093CD0@AM8PR04MB7297.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3JAZa7TyD5Ndh33bHfi0crW6C/jxWPkJltmGQEZSb2j3pY9u5LlPNKqUiVdaclmckMt2iF9u1MQ8JWzIQu2gf/+s2kr9ymZT3wwO/lDpUFjHOkqZ3tC4ZzVQ+HcU3RbYxr85GsXMPLBmIU8MscgNvVN0UpjMaH2ISaNzrh+0bHOaiIRJUqro6ZrgNZMg9lBgvPi/K8jIUYyRZUUel3/HXcAlYZeZRdf5endTO6KC54WXoXdSoUb4U6CdP+3SqMFgsnMkkdYtHo4RWTKaCUC+G7JH8SX03U0O2ydIvYWxpA9zaAuDJTbxrTbt2x40GX8/8EbWUJfI3QmOXbphmzq1VVhSUghT13OTCqMiig2ps+JIpRJXLwuJBkPWSxnNNNJRyZuaWVPiW95cWcGT8WnZsJ5hAjDCe8Xrd1khNidCK4o84C21ijJAVWxKdqsNHn6vnKusqY6kfwFkpCkCG3mJpw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB4530.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(376002)(346002)(54906003)(52116002)(103116003)(4744005)(2906002)(110136005)(8676002)(36756003)(956004)(66946007)(6486002)(5660300002)(26005)(8936002)(66556008)(4326008)(2616005)(186003)(966005)(66476007)(16526019)(7696005)(508600001)(99106002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?S0E2Z25pQlZYaTJSQjhRQmFqRDAvQVdvNHNRZmowaFpTSjZvbXlxcjFiZ1dk?=
 =?utf-8?B?YXdxbEYvNU4xT0V6bXhEZHQ2NHZFdGh4MlhQOXk2bGdLbUdIOXdoTitlcTVY?=
 =?utf-8?B?S282ZlRrNmJkeHlmS1JlQllBSGk4VExySGJHSnlhRFVUWEV4akZreGlxVE5X?=
 =?utf-8?B?OU5oNUd5Y0E3UkJ6ODFjUzhaWnBXY3J1anRyVnF4OEtvSlFoeEFjOEtPOXpz?=
 =?utf-8?B?SmxFcGhiTEpCTThFNkFWWnU3Q1p2NkhtYVJ1VEZqU0dTZHpUMUdIK3huclZn?=
 =?utf-8?B?TFZuRFVXcmJQLzd0YXZRZFA2REU3ZGdZc2Z1WlBBZjNDU3FncjcyTzFPb1Mx?=
 =?utf-8?B?TnpMWFd6dDIxN1J2WE1nRk9nVEFtaVpvK3kxQ1J0VjZCV084QTI2eGRTaU8x?=
 =?utf-8?B?NlFWWFRUOFdEMlBxS0tWZ0Q3SG43SEdyd1Z3cjBMcXhQbWs5aWVIUlBQSGV5?=
 =?utf-8?B?UjRIVzZLSzJJdGROeDlpNTl5SFVPa2VuMXVQTWlKUitjTWQrUzRLbTkxVGFD?=
 =?utf-8?B?TUQ2VmN6bnZvZ2J1YVJDb1VKd09RaUlVNXkyL0YrbGk2SFlKOXJWWDR1RHY0?=
 =?utf-8?B?VmVDc2dVWWFFQkVSODFraVBlbE9WWDBCNkNSMjBzSUpKT3A2dWp0RUZjRVFj?=
 =?utf-8?B?U1lSMlRsREVJSlh4S0ZXL1k3azZ3aE9mWm0xVGMrRmpPUHRGWVZWOVIyMFNT?=
 =?utf-8?B?dlBabmwxWGFmK2d3bndOdW9TblRsNW4zZ2dsaTlLOHNDK25xWnl5VkhLenJJ?=
 =?utf-8?B?TmJBVHFHRjFGaTJUcFl6eW45U1BpazY2NHQrb0NUVE1SNUdUeXliaUo0T1li?=
 =?utf-8?B?OWQwLzB5VkVhME4vL0cycWJnMzFVdVZoZVJtUUFrR281UnUyMW8zQlA0dDRq?=
 =?utf-8?B?SWFkQ3FUb1FyOGU3TC9pUi9zVGhrU0ZmcEdUWVZIOUtodlBxNWVkaHd6QVdH?=
 =?utf-8?B?eUxZbXhzTFpNand6TExFdmozU2Z2YVFnb1l5cWJqQ0x4YzZSUE5ZMzdTT3po?=
 =?utf-8?B?OW1HWXhkUXlTZWZjVHArVVUxK28vcVFyWnc0OHA1QVk5dHljZVRxamQvOWZR?=
 =?utf-8?B?NGl1eEFCNEFDanRRaHJlc0NmVkVLa2pMSHM0bUoxQUUvY2w4Wk9XVWRGVDdW?=
 =?utf-8?B?Zi9TRitmY3cwZlhCODRsalZjTkh6d3prb1p0Q0VDVDY5aUpqYk1kdjZCNHNu?=
 =?utf-8?B?STl5RVlhazBocFNqNnRPTEJYVDVnRXdGR0IxWGh0UzBVN0ZkVWl1VHYvTVor?=
 =?utf-8?B?M3E4Mnk2K3VWN3ZpMG5JSzJ1K0RrL2VoN1AvUWJtZ3NxSlRGcE11dGlzR2oy?=
 =?utf-8?Q?msfbp8oKq5rYJduoOBNaqOwx0OSRAjry/x?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4530.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2020 16:30:37.7797
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a84e458-c33b-424d-8fc7-08d89b969889
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a0FRkjW8wndOihe7NuNqmK6ZafIyVO0TwP/ni2LbbYzDaNs8hYGcD1YB7CTuJK2hl59wN4pFQrMXKvPOZtedl3/MQFTphXJA5Ty+35w8Vcg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7297
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 2020-12-07 at 17:25 +0100, Rafael J. Wysocki wrote:
> Hi,
> 
> This is based on the RFC posted a few days ago:
> 
> https://lore.kernel.org/linux-pm/1817571.2o5Kk4Ohv2@kreacher/
> 
> The majority of the original cover letter still applies, so let me quote it
> here:
> [...]

Hello Rafael,

I'd like to test this patch, as I have concerns on how it performs against the
current intel_pstate passive + HWP + schedutil (which leaves HWP.REQ.DESIRED
untouched).

I'll get results within a week. Do you mind holding back the merge until then?


Thanks!
Giovanni Gherdovich

