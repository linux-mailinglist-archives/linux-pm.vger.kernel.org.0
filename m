Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA028EC32
	for <lists+linux-pm@lfdr.de>; Thu, 15 Aug 2019 15:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730775AbfHONBU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 15 Aug 2019 09:01:20 -0400
Received: from mail-eopbgr780073.outbound.protection.outlook.com ([40.107.78.73]:37760
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729818AbfHONBU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 15 Aug 2019 09:01:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZZq21s6YSeSWWwD7tmCAZceMwaA41/oKh+IoC52YNKjXCjfrvdigYithqmD9MiyBH12Dd/F+AjBmbzcw/nqMvnX8vPkdqzNMZOSBAkkGEjnWHuBdHSEjr2bMdtw6+YE3d+IXUJG/ALA5W0wAun48fbEqac3OiLibSdpdXirYmkhUKDA9hTemsI+qVt0Dsuweh0cxWN769JIZfRe8yd2+bYRb0a9oW8WxU6zBxK/stuf9sybYx2loks5LHv5we13GhShZYYYAJbP9vcBABu/KGfQnAPcwz25DTahkqdOlS2ugrOWYzX2TP7Yj4W1YjOFP5VVLNAWKBf7Ybirezy4jzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GWg0YO9pydI5mkD0dxgdJFJzj5JRMDVTM1huuYoRgso=;
 b=DyB6idtGEf7owmmynUNn97hI20NZ9BsZAB7DCBJr2pbs+yIxQTWSFbr+uTnQA4RJcGnDZ91PAAnsMEv2eqLlTDVl8vJgnpYVKTQFHNJwIS05wP7QxHWLzyF5C3K4SgvMBA1Bws6DuexJzJD0ewBJuYiHTfGtaLeGj6ovQ/OLc5/HmzE6S2BHVDl43hld1Knw0NHXOJeExerjutWcXfenU3FCme1moJjjtk7wZMyh0EX8ItcF3Oadnoxr8q9gO4a/mwPJD3yIvdB8IVVpTHUEspaWjLhT0jF4gBZP1NNa6YnhEPGwdg9/MqfirfSyU3tM9glErpFSJqyw1n3mYscn/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GWg0YO9pydI5mkD0dxgdJFJzj5JRMDVTM1huuYoRgso=;
 b=rsRDSWtN0oJudmjcfUUX56Q3T0o1HXuG2oou6m4rSrFTiKxva4xFy4O8JFDulSs9dXteqfEAbhUGdvnPXga6HgV0l+vwEJXhaBrUAmyJLD0dHukfEn6BZX5sZqL5FlhXbvU4s+/ag2db6cykjiVw9a92ndC7nf0GwDMWT5s/Mr8=
Received: from DM6PR12MB3163.namprd12.prod.outlook.com (20.179.104.150) by
 DM6PR12MB3226.namprd12.prod.outlook.com (20.179.105.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.14; Thu, 15 Aug 2019 13:01:16 +0000
Received: from DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::9c3d:8593:906c:e4f7]) by DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::9c3d:8593:906c:e4f7%6]) with mapi id 15.20.2157.022; Thu, 15 Aug 2019
 13:01:16 +0000
From:   "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
To:     Pavel Machek <pavel@ucw.cz>, "tytso@mit.edu" <tytso@mit.edu>,
        "nhorman@tuxdriver.com" <nhorman@tuxdriver.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Chen Yu <yu.c.chen@intel.com>, Jonathan Corbet <corbet@lwn.net>
Subject: Re: Non-random RDRAND Re: [PATCH] x86/CPU/AMD: Clear RDRAND CPUID bit
 on AMD family 15h/16h
Thread-Topic: Non-random RDRAND Re: [PATCH] x86/CPU/AMD: Clear RDRAND CPUID
 bit on AMD family 15h/16h
Thread-Index: AQHVUuW0/upDXQeDUkyQJLUEYNL76ab7SRKAgADkKwA=
Date:   Thu, 15 Aug 2019 13:01:16 +0000
Message-ID: <0ea34954-10d4-03f9-fce6-d25aa574bb43@amd.com>
References: <776cb5c2d33e7fd0d2893904724c0e52b394f24a.1565817448.git.thomas.lendacky@amd.com>
 <20190814232434.GA31769@amd>
In-Reply-To: <20190814232434.GA31769@amd>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0501CA0055.namprd05.prod.outlook.com
 (2603:10b6:803:41::32) To DM6PR12MB3163.namprd12.prod.outlook.com
 (2603:10b6:5:182::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 175f34da-59d4-481f-af64-08d72180a886
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DM6PR12MB3226;
x-ms-traffictypediagnostic: DM6PR12MB3226:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DM6PR12MB3226F830FB265D2613CBDB4FECAC0@DM6PR12MB3226.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01304918F3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(366004)(136003)(396003)(39850400004)(199004)(189003)(305945005)(316002)(7736002)(81166006)(6116002)(6512007)(36756003)(81156014)(3846002)(7416002)(53936002)(8936002)(8676002)(66556008)(64756008)(486006)(66946007)(66476007)(26005)(66446008)(14444005)(256004)(31696002)(186003)(86362001)(54906003)(2201001)(110136005)(5660300002)(2616005)(476003)(2501003)(11346002)(446003)(386003)(76176011)(53546011)(52116002)(2906002)(14454004)(6506007)(16799955002)(102836004)(6306002)(6436002)(66066001)(31686004)(2171002)(6246003)(71190400001)(71200400001)(229853002)(6486002)(4326008)(478600001)(99286004)(25786009)(966005);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB3226;H:DM6PR12MB3163.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /Q5V1x9uxyv2Y8RiR1m4MQNxU9lR3sOoszutgTClQa8s+XJlO7yduamm+ID/DsGQkP/6xUdupXtSD0BnYGl7ncU3JzHscapjKVQoJy4HPQkpxTQI0NN0A7ZVo19M/Wlr1sRj6fMcxxnV6HEAduP5D8TI1kwlfTPjurTY9UgcRzcvyd0drddygKM/GdavTiH4Vd0W7xNmCPW3p+jozAwMZ3h8qNrDo/3Unpx35AvuCdnxcWc6ONRi5GSpCeIED6/3qzRVX/mFxHd70BQFG2yeaFYFcdzVwE6DXnoowERqakehQDXw1g8LZd60n8/cKunRejbS1cEIulICe8e2Nxje7v/8x7D9i9GXdRlp8dlm56CGcm6X2F4iJXDdxTPEnE0/VHsNJgUdR2HoBO3PEEPPkET30FE/LYmF8eImuzUb9k4=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <EAB7E492129AD847B61182E76A8937CB@namprd12.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 175f34da-59d4-481f-af64-08d72180a886
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2019 13:01:16.4723
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yGB6BsYMYc05brOA2q2mdG8cJzjWB/DXpkVm8cGAah4ngvK1VR7hI1QdYRnvnNIpY2g1f36p+aLYO/gJ51iSkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3226
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 8/14/19 6:24 PM, Pavel Machek wrote:
> On Wed 2019-08-14 21:17:41, Lendacky, Thomas wrote:
>> From: Tom Lendacky <thomas.lendacky@amd.com>
>>
>> There have been reports of RDRAND issues after resuming from suspend on
>> some AMD family 15h and family 16h systems. This issue stems from BIOS
>> not performing the proper steps during resume to ensure RDRAND continues
>> to function properly.
>=20
> Burn it with fire!
>=20
> I mean... people were afraid RDRAND would be backdoored, and you now
> confirm ... it indeed _is_ backdoored? /., here's news for you!
>=20
> So what is the impact? Does it give random-looking but predictable
> numbers after resume? Does it give all zeros? Something else?

See this article:
https://www.phoronix.com/scan.php?page=3Dnews_item&px=3DAMD-CPUs-RdRand-Sus=
pend

Thanks,
Tom

>=20
>> =20
>> +	rdrand_force	[X86]
>> +			On certain AMD processors, the advertisement of the
>> +			RDRAND instruction has been disabled by the kernel
>> +			because of buggy BIOS support, specifically around the
>> +			suspend/resume path. This option allows for overriding
>> +			that decision if it is known that the BIOS support for
>> +			RDRAND is not buggy on the system.
>=20
> But this is not how we normally deal with buggy BIOSes. We don't want
> user to have to decide this...
>=20
> Should we introduce black-list or white-list of BIOS versions?
>=20
> Hmm. Actually.
>=20
> You are the CPU vendor. Surely you can tell us how to init RDRAND in
> kernel if BIOS failed to do that... can you?
>=20
> 									Pavel
>=20
