Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9947FCBB9
	for <lists+linux-pm@lfdr.de>; Thu, 14 Nov 2019 18:20:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbfKNRU4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 Nov 2019 12:20:56 -0500
Received: from mail-eopbgr140047.outbound.protection.outlook.com ([40.107.14.47]:63635
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726491AbfKNRU4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 14 Nov 2019 12:20:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XmR9+9QKpSl2TbW78bI5XcH+nYpJbCXtK1XP99tkCZNQ+x44nWvZOB40rdUVzU/ZVhie3OswdVmdNyg+2VgLzBbX33rY/JkwSOTZbHxARF4eU/F34FFMP9Z0tHk5VLsJCyk/d5Ks5/mBRAsqeHgTpiE89qE7NnBCB6BIkZWduSm21Z1gk+UyyRHbBFsS038vPeHPpdhHUHROAFvcHIPvxJ4XanLU3KwuskMXVh2rc2xN/A8ltgn3NclQh7wHSWXshJ0Tx7WQBDkzao38YbyLIGQrT3mArmVSM+1QsC07Lc/02ByWv9hio9pccoBzdQ50eykaAfzdS5lMbW3eJyPakA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lkqS3vUpuCzSqtjWpusdOdAlqZROerLERMwBdZyTi6Q=;
 b=VzHiWap2fSANt3CzZjnt/j5uW0tI1d1OBELGp+zO06TThvYREGsqKLLU8zBCJkAfU4+telA8aQoyXokB+OX3ByP4Lr7UfpnFZroe/YoOyksT6y88fDSITx+WoLJvq1vITSDeKFQtjN9xrwtM1EfwS9+HzspjGudlxa6rQbp42uC/+1qCmjyhpZl6Y4ilXR78IxR4sBgWFVPDqU5pU6GvOz9A3a3OKf3bejZq7J40TZhesQ8arBm2GrasDa7zu/Ax/nFFKG0y/xCyBZgY9a99WM818wyMPo5GgtJlDU+h1DlHWSZ92WifbLWWaWhND4kT50uh+A+5fQSNg6GnzKJLXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lkqS3vUpuCzSqtjWpusdOdAlqZROerLERMwBdZyTi6Q=;
 b=nTzbER+iitM2wZZ1LRhrkj7dUq0c4WxOVFRRp3yvauw420auPo+cGnVU3Lijl4LhKjYlJDrJ4FFtPbLeMEXKYXXq9K+jynp4SatcTG1PUvHA6WTRfP5QHp3I0A80/Pd7fj9aa8hoeEy+ZDkdyXvCCw9/01i6xHHVUj7c2WVmICk=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB6127.eurprd04.prod.outlook.com (20.179.26.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Thu, 14 Nov 2019 17:20:13 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::dd0c:72dc:e462:16b3]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::dd0c:72dc:e462:16b3%5]) with mapi id 15.20.2451.024; Thu, 14 Nov 2019
 17:20:13 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Georgi Djakov <georgi.djakov@linaro.org>
CC:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        =?iso-8859-2?Q?Artur_=A6wigo=F1?= <a.swigon@partner.samsung.com>,
        Evan Green <evgreen@chromium.org>,
        David Dai <daidavid1@codeaurora.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH RFC] interconnect: Add interconnect_graph file to debugfs
Thread-Topic: [PATCH RFC] interconnect: Add interconnect_graph file to debugfs
Thread-Index: AQHVmpUL9/SyHMg2fkCUeguJeLjH5A==
Date:   Thu, 14 Nov 2019 17:20:13 +0000
Message-ID: <VI1PR04MB7023BA56243AADB3E462F535EE710@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <70f672b39780ba7387d15fd6485f94b75d47b1ec.1573692109.git.leonard.crestez@nxp.com>
 <20191114024134.GA47006@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 02dbc490-756e-49db-266b-08d76926e8d1
x-ms-traffictypediagnostic: VI1PR04MB6127:
x-microsoft-antispam-prvs: <VI1PR04MB612797BCB3E7F661941BEBCEEE710@VI1PR04MB6127.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 02213C82F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(376002)(366004)(396003)(346002)(39860400002)(189003)(199004)(54534003)(64756008)(305945005)(74316002)(7416002)(8936002)(76176011)(5660300002)(7696005)(229853002)(8676002)(99286004)(81166006)(86362001)(478600001)(81156014)(4326008)(45080400002)(316002)(110136005)(71200400001)(71190400001)(25786009)(54906003)(6436002)(33656002)(9686003)(7736002)(6306002)(14454004)(55016002)(966005)(256004)(66066001)(6246003)(52536014)(486006)(26005)(91956017)(446003)(44832011)(476003)(2906002)(76116006)(102836004)(3846002)(186003)(6116002)(66476007)(66556008)(66446008)(53546011)(6506007)(66946007);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB6127;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dIJ1IlwQS8ANzN6dPRNXqAgPV1tSfYCpxwwZvc6IRvmN76Icu90Y1ht6RDXQObxsp+ldJmFFuFyZGGYPwItFz8OYrAwlYa/1iFvRHSOchxOJEYSSHloqkkB/6wFwnsPzCRuUyE7yODqT0gZHVdShSRWFALPEtwuFvajuIt/tAsjeJIhx8QKMjbrWPtKcuGvG2Fw4bOuTOhGpwGHxuNjsPcwvSSCkSjyTaZt29t031J6DH0/oYLiwdjnL4q77leIvc43yaraMLSEsdFEyko+HdRN9Fu6t3ZtcCP2k1ggMjIDBUBgFJZviF4yhDQRjyowPWNXXC0LPa8NyfwB0hbPnxkhHj93Y0ynTQcCTtOsF16E9OncP6yhffT+W9I2Zb2mXe8kej8ZxcA75EO/6hDdWjzKPGMrD9fS0rguvh6cKfGVl6RwAX0uryquw3qYWc5i9
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02dbc490-756e-49db-266b-08d76926e8d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2019 17:20:13.1660
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7clVE4HWVcpUTkQ43PT8mhVt2Z/vmZfXgkM45cWCPDtxdSIM8kd6HYakBb2w4vytaCl7Lc+wWLNUixmbNCKTEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6127
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 14.11.2019 04:41, Greg Kroah-Hartman wrote:=0A=
> On Thu, Nov 14, 2019 at 02:50:49AM +0200, Leonard Crestez wrote:=0A=
>> The interconnect graphs can be difficult to understand and the current=
=0A=
>> "interconnect_summary" file doesn't even display links in any way.=0A=
>>=0A=
>> Add a new "interconnect_graph" file to debugfs in the graphviz "dot"=0A=
>> format which describes interconnect providers, nodes and links.=0A=
>>=0A=
>> The file is human-readable and can be visualized by piping through=0A=
>> graphviz. Example:=0A=
>>=0A=
>> ssh $TARGET cat /sys/kernel/debug/interconnect/interconnect_graph \=0A=
>> 	| dot -Tsvg > interconnect_graph.svg=0A=
> =0A=
> You might want to document this somewhere so we don't all have to go dig=
=0A=
> it out of the changelog every time we want to look at this file.=0A=
=0A=
Files from sysfs are all described under Documentation/ABI but there's =0A=
nothing similar for debugfs (and this should definitely not be =0A=
considered ABI).=0A=
=0A=
Maybe Documentation/driver-api/interconnect.rst should have a "debugfs =0A=
interfaces" paragraph?=0A=
=0A=
>> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>=0A=
>> ---=0A=
>>   drivers/interconnect/core.c | 66 +++++++++++++++++++++++++++++++++++++=
=0A=
>>   1 file changed, 66 insertions(+)=0A=
>>=0A=
>> Example output as a github gist:=0A=
>> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgist=
.github.com%2Fcdleonard%2F2f74a7efe74587e3d4b57cf7983b46a8&amp;data=3D02%7C=
01%7Cleonard.crestez%40nxp.com%7C946b54955bda47a2c7a308d768ac2d23%7C686ea1d=
3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637092961007878684&amp;sdata=3DUk7QI%2F=
Oo70H4H5N3ZZl2IMXMHMvP3vov%2FqSMnPuNWg8%3D&amp;reserved=3D0=0A=
>>=0A=
>> The qcs404 driver was hacked to probe on imx, the links to "0" seem to=
=0A=
>> from incorrect trailing 0s on DEFINE_QNODE. Possibly fallout from=0A=
>> switching to ARRAY_SIZE(__VA_ARGS__)?=0A=
>>=0A=
>> I'm not sure that "graphviz" is allowed as an output format even in=0A=
>> debugfs.=0A=
> =0A=
> Why not!  :)=0A=
> =0A=
> This is great, I love it, nice job, no objection from me.=0A=
> =0A=
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>=0A=
