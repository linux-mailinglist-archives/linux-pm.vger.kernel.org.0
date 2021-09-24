Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3374177F2
	for <lists+linux-pm@lfdr.de>; Fri, 24 Sep 2021 17:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347151AbhIXPkL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 24 Sep 2021 11:40:11 -0400
Received: from mail-am6eur05on2059.outbound.protection.outlook.com ([40.107.22.59]:37409
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1347165AbhIXPj7 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 24 Sep 2021 11:39:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XLaRjQAyHlEofnKhvCispThFTAmN4VsgcM6y7Gak5UZlAwn61eM54XEPzeTTeCDG+H8MPOCG/5RP7af8xtVaoN0rKA0tGyuVKDakivs4X9prczqJiU4glo0WlzvR6oKneP5gycX7HUqn1k4llTqGe7LsXbULp89xmxq96c0IFi7cq79Q4WqkMa8B/U1THNT4OHv0VwVxQ0Al6QY3Vm7roGSSwrt41xcj1DumR7wY9JrXJfOGVJuqVivX6gPUprht9IpkdIhIkS4qrssjAdTNdub3JE5dR7bieJtoaUoEHKH/ODHu6Z3x3pUExkhW9cFUsUrSnqhis/Dzq9i9OAOCdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=NLsGHsdLydN5UyWyYvqN+1gMCsryUgz93PdeI7ZtY4Y=;
 b=H8KpQgv50PFC0OM/mfr5HTYffaijiNXhMN5XPzLy4Q0hgCo8ozh8JNi4dAuF/WZfpAr5fMzBMifE28xelovJpX5seeii8ECTF11k0Kd1Q+4b4tDxHwoTqOzqxtaGX424P4kD9UUB9Pw6cvWfcl2SwD/tBlmJVjsKHIrrrcJ+UMBp+LuVTuRMlMAX0hiOF7N/4WDedRWTFjkYxPYQ4M2Ew4XSFhAPhRFkaMN3vlhMeJEjpjnWlhLS5DJaCpP0oUa6dQTzAqPEbpm0F0w+7njevuv1vOp3//p6crtfh5wcBECp+Xo8BodxUXZz4ANg/uS89Qvall67XWSirEqt1zgJ8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NLsGHsdLydN5UyWyYvqN+1gMCsryUgz93PdeI7ZtY4Y=;
 b=vfuMY33f6SrWdAW99ngzsynlIy9iq/GWwJFd1rZy3twZpMTco06YJ6bxVgqorhJgVElbQ6y/5NyhQt877AuBTwoJ2Gzz6TEKFCoqpp7UKyUg+liMLpTlk02dOvkwFvpUJh0ERTeg03SaZUtbhOwhgHV4h359CljVm09t8j/jZM0=
Received: from DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:255::23)
 by DB7PR10MB1931.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:5:c::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4523.17; Fri, 24 Sep 2021 15:38:23 +0000
Received: from DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::dc0f:9e52:6dbb:1144]) by DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::dc0f:9e52:6dbb:1144%7]) with mapi id 15.20.4544.018; Fri, 24 Sep 2021
 15:38:23 +0000
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
CC:     Benson Leung <bleung@google.com>,
        Prashant Malani <pmalani@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "bleung@chromium.org" <bleung@chromium.org>,
        "badhri@google.com" <badhri@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sebastian Reichel <sre@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: RE: [RFC PATCH 2/3] power: supply: Add support for PDOs props
Thread-Topic: [RFC PATCH 2/3] power: supply: Add support for PDOs props
Thread-Index: AQHXoEKRtU4w32eDxEeY6U4KQGzJs6uiBmsAgAAaumCAAUDQAIAC9NuAgAAyawCAAD1scIAHpq+AgAUCZYA=
Date:   Fri, 24 Sep 2021 15:38:23 +0000
Message-ID: <DB9PR10MB46524E3817FB4D836CDC13E180A49@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
References: <20210902213500.3795948-1-pmalani@chromium.org>
 <20210902213500.3795948-3-pmalani@chromium.org>
 <YT9SYMAnOCTWGi5P@kuha.fi.intel.com>
 <DB9PR10MB4652B4A6A2A2157018307AE380D99@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
 <YUB16up3JDwi3HfI@kuha.fi.intel.com> <YULwz8NsoA3+vrhA@google.com>
 <YUMbGp0aemx1HCHv@kuha.fi.intel.com>
 <DB9PR10MB46525E6CA4C6BB101059D93C80DC9@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
 <YUm5sdbceMcDTvYj@kuha.fi.intel.com>
In-Reply-To: <YUm5sdbceMcDTvYj@kuha.fi.intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none
 header.from=diasemi.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 06c93788-c174-4647-5228-08d97f715852
x-ms-traffictypediagnostic: DB7PR10MB1931:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR10MB19313970EA0109414815D01EA7A49@DB7PR10MB1931.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eHv7ys9cQt/3AQ+WLduec7AZRWOiQ6nKLY+ec6X9wMe3q+6Y0aofnM99pD4dg/pGac6xeUdJ/OTAAKReCRfPprM5LS/53+6OmXUbqNoYsad0mHPs1mXtgECF7IVbYbM1XlzjIBFGtjyUdx99hG7HlSjn/OOpqeWGePpYqDMNikqp4F0f6ayh0NhOD86+i/fV07pfoWc/fiua0z9UavaLch5XDCllpPlIHs4uA+Y/LG5WzPNH4i7GcifeHZfNYLkmO4rwL15Uf3f2jBZUIXpuc7ZHvDoi9JFAOOmYEY+nvmiULIv8ajuTBQQbvEZsWEF9wcXswP819vny06ODIp9Oj5Ca884AysIYj/LANGzzF2lnFPytHFGzn7ZWTH3D839Y0hvPDtQMNvc+6XjxBilU9NpKLBpbIfYim1Puy6KTYdjMZlmsW4xJ6pvUfE+WyJ+YSxE2mOee9U4vKq9wqt9v1D1VcKQ3toKPpRnJEX+eW4dpXdcWdZ5Dgp1HxpzSo6eGJCeFZQwMHqLJbfHDPD0/9kVN6aXVjBzt5HZ358vasc2THZ8Tg/nq3pWjef6jPWVGy77YeljyTJnmE9Xum9ks4VD3RlL44ex8paRNCwEZEOws5sYpd94olJy7Q5R0Zu71En783tCbizkSEh4LlxocFAVqOPZvnN4zgPyAgiiL2pFKiwG8fubmzIS3jwKLrvp8puf5BPdHkgY+IulNWQhm1g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(76116006)(66446008)(316002)(52536014)(2906002)(7696005)(83380400001)(66556008)(71200400001)(110136005)(55016002)(38070700005)(64756008)(66476007)(8936002)(7416002)(8676002)(66946007)(54906003)(26005)(5660300002)(6506007)(55236004)(4326008)(53546011)(508600001)(186003)(33656002)(86362001)(122000001)(9686003)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dKp6kEJFBphsfoDJhOX+KaFnzMosxlzyyp4Xbtti/1OxhPXsAwSwov433W2H?=
 =?us-ascii?Q?q6GUAbMxKtCvZBBnKmiB7vAItSBpgkdJ86NbS9w9RQC86qdstf0XdbMaX43Y?=
 =?us-ascii?Q?0nSLdg+sHwpH+L02yIhKmHfCr1IlAhRdcDSXclxubzvgJt5U50QJPi9B82zR?=
 =?us-ascii?Q?TXg8JMyo4Q1cuYEsvYlkI55gUKZ5wJKuYJvrc2dakpcOtNmiCo6KRMx5XnzV?=
 =?us-ascii?Q?FgyjJC+hgWkf6JVXR/07zxi9TGgx8ph2o9G+KOvBqmn+NekzNAkHXFbZqBQ1?=
 =?us-ascii?Q?fi7ZxSArRwtAM+6hHG0fv/OWLLr8Uz2/jRDe8KAx9wV4hrV4r2hVzG208zRh?=
 =?us-ascii?Q?TADNBK+63ugXLWsbxlleOmTNZAi0jeIbs3tqilgjjoLoeFWIjYFnzHBFqnbb?=
 =?us-ascii?Q?pxZcM7q0BaWJQdzWZOblRN1cs5Xk61RUj+g8w4GOIznPgVFPpyfHZzkWGtku?=
 =?us-ascii?Q?E6aVNwHNrPuNpKhEnXr5zZ3ztoTeWIPCcx2GrQ+vYQop9bj9xMOVWuQ+yV5P?=
 =?us-ascii?Q?Iv/cyZPXmZw5IpD5p6zwTmiMQ3RptvF5ETYGPjk7ULPLTF5W/ihxjvbekArx?=
 =?us-ascii?Q?um+h502TRw+WiY38UD+AWn//c0XaRVPIrcElHupzwERnrTschVGc/ftJlmoj?=
 =?us-ascii?Q?E6h5nQrqw0rFRXRhfd7pG84FGzNWpMa6DPpLMhHyUXtkNiabSADQUmvTi/Zq?=
 =?us-ascii?Q?fF7ZefY/3BZYw+EjpxZoGdU6M5tspzNfiqoq6kRzcZc75vW4NKWPXJK+2F2A?=
 =?us-ascii?Q?UTG5SC7Wu12qW4iXMTo8Lb8Qp8U7sUtzWkFHyAo0K1w+x+m0jaSy7i6y0oGw?=
 =?us-ascii?Q?vs+bUqkE+DFwwnnTW/ODE+F9xlYjsOELHb8n6NKMEyBqU+Z0HWERguVz8kIY?=
 =?us-ascii?Q?f3Qn3TxA9Mny3JRKwZgakIaMsfnnNgbGLgJzqNC8Pq2IRFHEEy3oACj+w7Vh?=
 =?us-ascii?Q?sLQYfwnjUi1+Jkp4T8nDATTE1B8q4ThhV8e5SpouESEy/6mXEkRefB3zicon?=
 =?us-ascii?Q?lZ+NqjHsJB/6gOEHOAvaG2f3Q2fl5XTSiwUxYhr1+iqejJLeNBcJz+aZATSc?=
 =?us-ascii?Q?rtzCDbdLisHcCk/EuiSBOGJJwOXaclqHZuaVrJmH55XTZmA9a9JHVozSZIeQ?=
 =?us-ascii?Q?Qy4fKK3ENEkKUGpSfWY38O8qHWPtHV25sqEefNkk1xmzONTnPpnyPM2VkL/S?=
 =?us-ascii?Q?2OAqdGL5jdF3MNod8ICmOqh+R3E9BCMbE1Fd5ZClQBtSgoktDtk989ssuVPj?=
 =?us-ascii?Q?1SbUay4faeQM/Oobu6s32tAY4g/Nw0kTZHbV1++/CWNyerHyecHihostpm+Q?=
 =?us-ascii?Q?e3pLVmAqrCW8L9efw4YdLgaU?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 06c93788-c174-4647-5228-08d97f715852
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2021 15:38:23.8999
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HblffOThtChO7JPt1LG184MpZCq1YG5r14emEWd8p/7AmpTIGGTP7zjM++y7mZvA2d9spJOjr3fP0YY7IrA4XaaQO/SYh25s1YNqss1c+jc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR10MB1931
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 21 September 2021 11:54, Heikki Krogerus wrote:

> If we can leave the decision about the selection to TCPM, that would
> be great! I'm not against that at all. As I said, I have not though
> through the control aspect. Right now I'm mostly concerned about how
> we expose the information to the user. The only reason why I have
> considered the control part at all is because how ever we decide to
> expose the information to the user, it has to work with control as
> well.

Well part of the discussion has to be about the role that the user plays in
the control. What does and doesn't need to be controlled further up the sta=
ck,
and what will be taken care of by, for example, TCPM? Surely that dictates =
to
some degree what and how we expose all of this? Right now we have a simple =
means
to read and control voltages and currents through a PSY class, without the =
need
for the user to know any details of what a PDO/APDO is. Do we continue with
abstracting away to the user or instead let the user decipher this itself a=
nd
decide? Am just trying to understand the needs going forward.

> The final PSYs and the supply chains they create as well as the
> individual properties I'm more than happy to talk about, but having a
> separate object for the smallest thing that we can see (PDO) is the
> right thing to do here IMO. Trying to concatenate things into single
> objects especially in sysfs, despite how nice it always would seem,
> has taken me to the brink of disaster in the past far too many times.
>
> In this case we don't need to take the risk of having to duplicated
> information or in worst case deprecate something that is also exposed
> to the sysfs in the future.
>
> So the question is not why should we registers every individual PDO
> separately. The question is, why shouldn't we do that? And saying that
> it's "heavyweight" I'm afraid is not good enough. :-)

That was my initial feeling on the suggestion based on the idea of a PSY pe=
r PDO
and I still don't feel that fits as your creating a whole class of resource=
s
to expose something that's pretty small. To me the PSY represents the sourc=
e as
whole, and the PDOs are simply options/configurations for that source. If w=
e're
needing to expose PDOs then I don't disagree with separating them out
individually and I certainly wouldn't want that all concatenated as one
property. However I think something like dynamically generated properties
might be a nicer solution to expose each PDO, or even groups of properties =
if
you wanted to split PDOs even further into constituent parts to the user.

Honestly though I'm not really against anything right now. I'm still trying=
 to
build a better view for myself as to how this needs to be used in the futur=
e.
