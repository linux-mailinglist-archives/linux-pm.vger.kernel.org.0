Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80F414096E2
	for <lists+linux-pm@lfdr.de>; Mon, 13 Sep 2021 17:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346995AbhIMPRm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Sep 2021 11:17:42 -0400
Received: from mail-vi1eur05on2086.outbound.protection.outlook.com ([40.107.21.86]:63789
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1346838AbhIMPR2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 13 Sep 2021 11:17:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VwiAQ89uZD1us6L8E3l3jgSgW6g2D+cxHx4hIWZ6YxprOYqA62LsXIINrkFp62Y5DARXocFoLcb6l46E9BQGWmJmXDzT+X814HLcpA5ociBqlQ+18rWEqavoYStatzayZ+v6F5ZLKS6jBi54ojy1gcdIYQ7HC5s/at8ne0rnSYXISdB+agebl4A4TMdS7/YQf7bMrokFDgj2z9F9hWXjt4bnZEDOM/4Fao8fNitiah+8Tm2puFt5ZCIJ/CFS0Nkue3pVXhyOAVXspqGM4kmgU6+rXZm01cN8yyfZwJaPguOvKwJH3QDtj3l7Wyg4ixc9mlbdXLD0eB4nTK8TYflhEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=jdMR63FU/P845M1o7DOKIGo4nMQQE3Usi2IjpxUUNdg=;
 b=UR3FZ6u4Z5HZA+m2izrRkC2/RRlKA5DwsFMQ1sXgsyqOrPjSYP8XqjRAxogLHyPAWiSyHZyom9asus1qprWwo+hFRJSEo/+rIxQEJ1/Pzc22oqiEHH/02J6RxdsRclS4i6iDu9WppBhR1zXpxRFUIYNS8kAOZtUivPKxNmd2L4QAtHFCzDmW2wCqbPpjtWSbsANbRavfeSvuts2lFIrxNjKSC7D0VVgPkjKU3AX8iKEJCpoFSXZF2Q1xDtwWGR4GCmYZaz5TWkRmq6ivytG2hFx6Pq7GrcsTtPsAuyttHYTwBx0IPyTORypPGEXKoP3vy6N0/fNAZ/gQqnHNBhXZ6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jdMR63FU/P845M1o7DOKIGo4nMQQE3Usi2IjpxUUNdg=;
 b=IayJR41IMoo5L14cXB5s79twpM4hiQJG1kiAl2wpf71/B3jNrStwiJPgOPg3YeSRr/KKbsZwPCfNssqWU8CrI+dSJ5CNdhjcE/sedu4X2XJgT8O1VOUWn2n/NSJEczOd6J69VoPu2cQ3PudT0tNVEtjH48Scdkq3Bx8iBurUejM=
Received: from DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:255::23)
 by DBAPR10MB4251.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:1c9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.18; Mon, 13 Sep
 2021 15:16:03 +0000
Received: from DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::dc0f:9e52:6dbb:1144]) by DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::dc0f:9e52:6dbb:1144%6]) with mapi id 15.20.4500.019; Mon, 13 Sep 2021
 15:15:46 +0000
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Prashant Malani <pmalani@chromium.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "bleung@chromium.org" <bleung@chromium.org>,
        "badhri@google.com" <badhri@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sebastian Reichel <sre@kernel.org>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: RE: [RFC PATCH 2/3] power: supply: Add support for PDOs props
Thread-Topic: [RFC PATCH 2/3] power: supply: Add support for PDOs props
Thread-Index: AQHXoEKRtU4w32eDxEeY6U4KQGzJs6uiBmsAgAAaumA=
Date:   Mon, 13 Sep 2021 15:15:46 +0000
Message-ID: <DB9PR10MB4652B4A6A2A2157018307AE380D99@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
References: <20210902213500.3795948-1-pmalani@chromium.org>
 <20210902213500.3795948-3-pmalani@chromium.org>
 <YT9SYMAnOCTWGi5P@kuha.fi.intel.com>
In-Reply-To: <YT9SYMAnOCTWGi5P@kuha.fi.intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none
 header.from=diasemi.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1d84a9cd-0391-4962-f7b7-08d976c95cb5
x-ms-traffictypediagnostic: DBAPR10MB4251:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DBAPR10MB425195097FC49A796B2F8306A7D99@DBAPR10MB4251.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k0CPr95MWzKWc6YGi0rxke1B3K6SlklxFRetqxBH4azm9j7wNCcMNk6Y7QTKrBuuCyBcrGLxA40rlg34jooOfjuhz6IMmsZif6jI3YgXaBtcQqRVEokgnyU5bJhgTONwCmXht+WWDBMNaa/Q6iWtZpw8idbAXc87AVGlO4TYBm1T0l5ZwdKOr7wGodUQMNDd57L3C/LN/xM93Fh3OglI8ppzC7rpI1L3GwHdwFQtZeLJTM+p97SSHFuKzUzCXB/nHBGUTK/pAEEtwqaySKno2gaeeqI2j8vSW+MTGtmTXhbwTPi7YhQ+8JPcr5WaRnVNLIy46Vs3G+S1lzrw3nylxHPTabzyjXwJuyqon0LbhzsxqQAYPYMHdB+sEM6W4zZcbRefMlWEm+SdqB6q27AXNRD0Hw6CTTb6keTaGFTwpg1EDT+hSGBxmqeaP+NHzU7w4XQ5ovAOhargMD81ZvyQvJNnO9ow75QWSFVkdKj+r+Rmn/eifho+fyU8+thnFpqSIW02vGEeIeo7wo/h7EDD3kLAhaHFdRstAMrqpczfG/j9Zbynri0+65kkWbhly10EZrTn0n9OKq/5gI8q5+5kZ0VXEmpOCcOq4Tl4iU2OBJ46NmbtfBcgJ/82oGwE0JKV8b4zcwym6dM/uIHd4aoQ/oB2Q0DqPLraGJjwc4v1/z+tvsFuSJ/ddLbcx/IRj4xqpVoDbZACD/OIt7gUbiBuvQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(136003)(396003)(366004)(376002)(83380400001)(55016002)(122000001)(76116006)(55236004)(66946007)(53546011)(9686003)(52536014)(38070700005)(8676002)(64756008)(4326008)(66556008)(66476007)(316002)(38100700002)(478600001)(6506007)(7416002)(71200400001)(8936002)(5660300002)(26005)(54906003)(186003)(86362001)(110136005)(33656002)(2906002)(66446008)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FGb8qtWzeYlNaw7dh+f4CCV1+rNHhEfVHIJwKcJZjsgRwMrQyZS2S6hM/5Ll?=
 =?us-ascii?Q?v4+8hXIs5YnTqpobyFzwtt+kU0vYCdi942xd2sF6oWJrtylGn/wT+SNPyky2?=
 =?us-ascii?Q?BKcEwaEQgI+xW8C9P1W8HDi7f1tYol5/Eov/nIqanleYFRqQ3KkYT1aQvz4e?=
 =?us-ascii?Q?OX8Xx099uF/u3/VeGYY/9W3eQe9n2pFJ5D9Z9nJxYoROh9MTDKGwMAoBTj8C?=
 =?us-ascii?Q?e3iIEVbfL64nXdY2zL3WaigVj5K+keyAvSev9iwJRK+N+qV4nvKQW8b5tmzl?=
 =?us-ascii?Q?oiLTGO+RNIdl3pFGPzfdei+HaD8jJ8ZXrLEYefmbU4U+HdoyjvDc1ck2L8EL?=
 =?us-ascii?Q?k6Sb3ehg6PuuNOdnrHvGLBc5BTu7t8/FT7FJHMKMpsTchT3JGiOuR2a1KG+P?=
 =?us-ascii?Q?RB+S9rus/9b5/QjYKlpAemTDShaiTKJovSVByg3neGihMwngUDv+YIQ7/rYW?=
 =?us-ascii?Q?0wv5E01Xq1jSO9uBRhtww0tLoehVbdaksj1r3Q+Q2kzASGZOpQPHODCVLnWd?=
 =?us-ascii?Q?/lipqK67DY6HZ4EwdnDIv0n++kM9Ch29dibiqeWXAMOmDYGzqi1/M/AreUEr?=
 =?us-ascii?Q?Unz1WQhLa2P8rrfHhM6WQC0Zup1SS1TQbBi/miuAxrENEKOO9inzHBcWcKDw?=
 =?us-ascii?Q?LqKA7fwRNUQTDgsDlXqybg2h1Kfj2dpzpyfCi9Loz0AmVJ9xJ+GROCekdM0i?=
 =?us-ascii?Q?hVDfhpnwapQVAvTfxDfUenG1Ew2tVWN9kY3AvgICRWHfFS+7FBUJa559bD+W?=
 =?us-ascii?Q?27gWKLRXYl0bKBIkWOqfmgCsx88mipLijxvj5j9Iyw/BUWLhO3LAtcbHne9K?=
 =?us-ascii?Q?u+TZuGulO0w0Bz8TkeTlPVEAukz0rW+RW8lbA//GfKfE4OQs0/mHidnASvVY?=
 =?us-ascii?Q?ayJsJb5mtFjoPgoYPErwzfnkAFlN1VuGGDp+YpOHvhdd/0D8qWY+aDDb5/WQ?=
 =?us-ascii?Q?z3n6yVyhRE1cGbacLwwMrfH77i99K/JoygEe2/uwpZAv0FsX/HqbaVPVzAq1?=
 =?us-ascii?Q?wJJco1bdxwDv8CicOGr4hm1McGgCbNISInrQOxMpQ/BI3/9wJcdzwZoQ5omD?=
 =?us-ascii?Q?uKltWOt/LmUqA6G3yFHUBmoqr7CeddOhivofHee19qyciFJNPCHDfzIZc+eC?=
 =?us-ascii?Q?M+v8xL54tjHe3NGhzwc7ErTkL+szNVaqHGcLK3JtD5JBgrdIylAjbUhPEyWi?=
 =?us-ascii?Q?EMWQvD9F+KnmXhG2NgRueJZsL9EJI/v0fsoHTdOeLaEwaieyY3CZkX7B/0ri?=
 =?us-ascii?Q?c+45z7OrE/lJS2Zko1+ZTtNV3CwpqTW98OtwS9AelWu8tdZ4wBk3lBRt68xw?=
 =?us-ascii?Q?YgkbqmdppOJ+jkjTQEMcnZtS?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d84a9cd-0391-4962-f7b7-08d976c95cb5
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2021 15:15:46.4712
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5OBcPAhD6Mw1ty1HeUBjWJFtRt809dUY7RP6GqpwKWpUGg5IgyF6L0PkkCU+c1KKlSoHmMtIY4z9ctGH+GvFfaaIjSVhh2PAOJ5149AnHEw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR10MB4251
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 13 September 2021 14:30, Heikki Krogerus wrote:

> > Add support for reporting Source and Sink Capabilities
> > Power Data Object (PDO) property. These are reported by USB
> > Power Delivery (PD) capable power sources.
> >
> > Signed-off-by: Prashant Malani <pmalani@chromium.org>
> > ---
> >  Documentation/ABI/testing/sysfs-class-power | 30 +++++++++++++++++++++
> >  drivers/power/supply/power_supply_sysfs.c   | 18 ++++++++++++-
> >  include/linux/power_supply.h                |  5 ++++
> >  3 files changed, 52 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/ABI/testing/sysfs-class-power
> b/Documentation/ABI/testing/sysfs-class-power
> > index ca830c6cd809..90d4198e6dfb 100644
> > --- a/Documentation/ABI/testing/sysfs-class-power
> > +++ b/Documentation/ABI/testing/sysfs-class-power
> > @@ -562,6 +562,36 @@ Description:
> >  			      "Unknown", "SDP", "DCP", "CDP", "ACA", "C", "PD",
> >  			      "PD_DRP", "PD_PPS", "BrickID"
> >
> > +What:
> 	/sys/class/power_supply/<supply_name>/source_cap_pdos
> > +Date:		September 2021
> > +Contact:	linux-pm@vger.kernel.org
> > +Description:
> > +		Reports the Source Capabilities Power Data Objects (PDO)
> reported by the USB
> > +		PD-capable power source. 13 PDOs are listed. PDOs 1-7 represent
> the Source Caps
> > +		for devices which only support Standard Power Range (SPR),
> whereas PDOs 8-13
> > +		are for Extended Power Range (EPR) capable sources.
> > +		NOTE: The EPR Source Caps message is a superset of the Source
> Cap message, so on
> > +		SPR-only sources, PDOs 8-13 will be 0.
> > +
> > +		Access: Read-Only
> > +
> > +		Valid values: Represented as a list of 13 32-bit PDO objects in
> hexadecimal format.
> > +
> > +What:
> 	/sys/class/power_supply/<supply_name>/sink_cap_pdos
> > +Date:		September 2021
> > +Contact:	linux-pm@vger.kernel.org
> > +Description:
> > +		Reports the Sink Capabilities Power Data Objects (PDO) reported
> by the USB
> > +		PD-capable power source. 13 PDOs are listed. PDOs 1-7 represent
> the Sink Caps
> > +		for devices which only support Standard Power Range (SPR),
> whereas PDOs 8-13
> > +		are for Extended Power Range (EPR) capable sinks.
> > +		NOTE: The EPR Sink Caps message is a superset of the Sink Cap
> message, so on
> > +		SPR-only sinks, PDOs 8-13 will be 0.
> > +
> > +		Access: Read-Only
> > +
> > +		Valid values: Represented as a list of 13 32-bit PDO objects in
> hexadecimal format.
>
> My plan is to register a separate power supply for each PDO. So for
> every source PDO and every sink PDO a port has in its capabilities,
> you'll have a separate power supply registered, and the same for the
> partner when it's connected. With every connection there should always
> be one active (online) source psy and active sink psy (if the port is
> source, one of the port's source psys will be active and the partner
> will have the active sink psy, or vise versa - depending on the role).
>
> Each PDO represents a "Power Supply" so to me that approach just
> makes the most sense. It will require a bit of work in kernel, however
> in user space it should mean that we only have a single new attribute
> file for the power supplies named "pdo" that returns a single PDO.
>
> Let me know if you guys see any obvious problems with the idea.
> Otherwise, that is how we really need to do this. That will make
> things much more clear in user space. I have a feeling it will make
> things easier in kernel as well in the long run.
>
> Adding Adam and Guenter. It would be good if you guys could comment
> the idea as well.

Hi Heikki,

Thanks for CCing me. My two pence worth is that I always envisaged the PSY
representation as being 1 PSY for 1 power source. I consider this in a
similar manner to the Regulator framework, where 1 regulator can support a =
range
of voltages and currents, but this is covered by 1 regulator instance as it=
's
just a single output. For USB-PD we have a number of options for voltage/cu=
rrent
combos, including PPS which is even lower granularity, but it's still only =
one
port. I get the feeling that having PSY instances for each and every PDO mi=
ght
be a little confusing and these will never be concurrent.

However, I'd be keen to understand further and see what restrictions/issues=
 are
currently present as I probably don't have a complete view of this right no=
w. I
wouldn't want to dismiss something out of turn, especially when you obvious=
ly
have good reason to suggest such an approach.
