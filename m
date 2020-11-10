Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D15422ADD46
	for <lists+linux-pm@lfdr.de>; Tue, 10 Nov 2020 18:45:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729361AbgKJRpw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Nov 2020 12:45:52 -0500
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:5160 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726179AbgKJRpv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Nov 2020 12:45:51 -0500
Received: from pps.filterd (m0170393.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AAHbphB025196;
        Tue, 10 Nov 2020 12:45:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=wN8sQ5J9LnQF5UqcEMck8LjiI1TAMbbxIqLb6ogVsg0=;
 b=AMJI8Eqx+4iBko70/uaPtW1vk9n6mZuhfwOWLTkGaDZsR1dNSneUkkRvuvJiV7wftBEg
 ELlGRw7d+eTyy7SfJePtLMq2bFegdVJqtVG6QezhuWCcdOD/3EdvXKvfQOv+u+LcwUAR
 WShIy/3KHvC6Kq1wvpxGndiUePa/vzSbZXidfGhKwDqi2u5HDPy9Kw6N7xCOfE/Vrv6W
 nr9rrv8V7+B2nH+JCyi80dnPhoWrahA/BI0l/VUWYWQXjxWPULpJznt4H9NrG5QadGpf
 clVQLwP9kC8QSFF4alPJH/ONeO7I79+1XiIuditpwTRk0ZpuGniLuQcbAFw9UvdEa46c VA== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0a-00154904.pphosted.com with ESMTP id 34nqsn0b8v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Nov 2020 12:45:46 -0500
Received: from pps.filterd (m0133268.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AAHfHsa122038;
        Tue, 10 Nov 2020 12:45:45 -0500
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2042.outbound.protection.outlook.com [104.47.73.42])
        by mx0a-00154901.pphosted.com with ESMTP id 34qwjvt0h2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Nov 2020 12:45:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M1sLgHk+UYa9iVDt/f/urW/4E7Xqn39B33Kbq6ishzGpqsr5hgs/POjJld/WDda8bcTEGa0H4/FJqYCbRB6BZX2Jpa50i7DgIv3TIWBToxYqD47yY9UbyUayhWdkNlcsdzmMCHW/UnQiHli3enVsczIKnkPIRvDQEgKsC+QjX8Uh/63AOqLWAzGChwZ27mnoia890IwQDh4h1sVCWdkbALEUQxZSXSasyTmUsD4G2a2VeM+ad+jKgp7thjdyx+n0Gc6R7t+Gswz07z7I/eKXaIBT46AClcV7HOciS76i+oczyjTa+Xz9wOhSZBj3+umC8G3APiYbv43jzl1SFwHjgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wN8sQ5J9LnQF5UqcEMck8LjiI1TAMbbxIqLb6ogVsg0=;
 b=GMEVGH4FUGa8eFLT7QK8YQ+CMDRLU69YEhjDZxhoJojnBUZz2GwEMded0rUAhZcThZxql7LB/QVPZ7Ad3lThwXqot5x174basOq6lyUHMwPcBA4s76WSGOhnwGGfju9Xtp62oqcZfmhEOoVRxpkq/QWN9meeDE18PD60xbOyDeLuhAENi3rEQjrjkjE48qFyIH8FkYMZNzCm64GkOGOraPexztKOZvIG0kwjqZQ6R90Fqvq5vh2RB5oO37roHVC4rV5RytmqE53xGv93WXbXgVuXaORfrlSnWEPiYyM0iyVk2hrMZiCUtZxflfrQii1ek3//wJyF8piLuZHzgrh6RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Dell.onmicrosoft.com;
 s=selector1-Dell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wN8sQ5J9LnQF5UqcEMck8LjiI1TAMbbxIqLb6ogVsg0=;
 b=hLGYL9UAWlvfe/gvGkpQ4RHlKvqM2TlIuCsMMDNQg1pyAhGULL4OTamkhCf8nn33SgShzhtBsRIo+ZX8gDxoFUMHjFnYgNnegDfa6rM3XdGJpgbaT4ohFNNY3bfD3TnV5FmbS8PWoM0SBhd5ygiKRsuH+UmO4tHsv1+Yt7fMOPE=
Received: from DM6PR19MB2636.namprd19.prod.outlook.com (2603:10b6:5:15f::15)
 by DM5PR19MB0027.namprd19.prod.outlook.com (2603:10b6:4:6b::35) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Tue, 10 Nov
 2020 17:45:43 +0000
Received: from DM6PR19MB2636.namprd19.prod.outlook.com
 ([fe80::a8ff:e803:ee80:e59a]) by DM6PR19MB2636.namprd19.prod.outlook.com
 ([fe80::a8ff:e803:ee80:e59a%3]) with mapi id 15.20.3499.032; Tue, 10 Nov 2020
 17:45:43 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@dell.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     Bastien Nocera <hadess@hadess.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Subject: RE: How to enable auto-suspend by default
Thread-Topic: How to enable auto-suspend by default
Thread-Index: AQHWt1BE6l+LjsERUU+/FRV4X0h3ganBPDeAgABA9KCAAB8fAIAABiww
Date:   Tue, 10 Nov 2020 17:45:43 +0000
Message-ID: <DM6PR19MB2636460E97BD5E47957BB43AFAE90@DM6PR19MB2636.namprd19.prod.outlook.com>
References: <fe8ab4cab3740afd261fa902f14ecae002a1122d.camel@hadess.net>
 <X6p6ubTOoMPUPPXi@kroah.com>
 <DM6PR19MB2636C94B56D5FBC0BD98A1B0FAE90@DM6PR19MB2636.namprd19.prod.outlook.com>
 <X6rLUDuG0N98jz18@kroah.com>
In-Reply-To: <X6rLUDuG0N98jz18@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Mario_Limonciello@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2020-11-10T17:40:15.8416521Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=a04f1a67-ceec-483f-8088-81c3fa3b9d8f;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=Dell.com;
x-originating-ip: [76.251.167.31]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b3546588-64f4-4a04-cbc8-08d885a07289
x-ms-traffictypediagnostic: DM5PR19MB0027:
x-microsoft-antispam-prvs: <DM5PR19MB00273E181C26CB82F9990843FAE90@DM5PR19MB0027.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QAGFki5nkubI9JfcDtDtWZVBLqJpa+r/iQJvcBIUG8bipgrR0SjHaha9ukT4s6UsPNc1Ewv8QrJoWY81ZNFmjge1HL23arVR32nkweT+7RC2X14WgyqG82cXmoOLi6eUcC51p8PNVCc0NkATbL7pszNlCfXhoCAQmZcZiuKTlhaCMDv7wAvNKu+oCQZX6m1DyQP6M8cbfWwSKW3FA7H7GRU83g8n3eFFwq2Dirgv7w5zTVLDXMw2JJvjRvsoQNrL6cNbE2x2QDX/4qm+kCUhutTL9LzePauPVXWHBX+UC4aQ1RaPrIdbJbxHE4j2Ib5l3hxXlPoGzKTj9gl1WNsoKYEfEihPMi5fv116n/EqR5G37OP38JFHh3hGf74R/4bmIm8uXe1fLf0XfqehuLz9mA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR19MB2636.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(396003)(136003)(346002)(376002)(26005)(15650500001)(5660300002)(66946007)(52536014)(8676002)(316002)(6506007)(66476007)(66556008)(8936002)(55016002)(54906003)(6916009)(786003)(86362001)(4326008)(66446008)(186003)(76116006)(64756008)(33656002)(478600001)(7696005)(71200400001)(9686003)(966005)(83380400001)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: nCZZ5FDeqnjef+M9wbaeauMxiy7kIXCgLawx0+I8S7j0ZmYGPlFw7/uBokYH5Y4srjW37E82w2m6keFueEjmcei7kl5zQHq4A267uzQvwsv85tHG7Haz309bvjjcTfMx45yvLzzvD6qwrOdZaO7rCZUv0V23hdvnhtw1cewtKck2Y0t1IqiR+xWdQaqlB8WIMOO262qYEeEOyXG9EU6B2tvwJVPuF8oaQtKA4Np0w52Z9JwsUC3JlI2ZdpnIspDlRRFEcwPD+3rpgfvsgTLIhUdCXwm4DHIsjVX0mWz9Icg5AUdvOLlUxlJRaf95YC2yqjjVwDGiF8Hflv1S6iiEr7rcyZXNPXxfiWobun62pmIrR81s0zKz7lAPTZKb+NDBQpjaokkLn1lO0AHnOkUKjV4r7imM8Jht0oO0Ksf6Qfsgi1maGOEHxKRFvyFDJ4+XlaF/aIW4KvRWU6j7zyr7cfkM9gnsLQikkM0P2ML2OgijORFOM0G0NM9PbBB4Zy0fQrjzLfhetrakoayd7CZikIdoHAdE32tFJPnT3jrYEzwpD2ZuTTiatFo1YWZh3HzODDbleGJxfsPUmCNhIn9obf1cjM9blhqYE6FrYXIbL3+J9VyRMTJwkNreGg2uEwSc02/G28EUJ3Qo/LeenztlGw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR19MB2636.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3546588-64f4-4a04-cbc8-08d885a07289
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2020 17:45:43.4910
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nIFSHplSQ9aPMjjJ6mkCzDoRE+dGb5H2A0Eq7bXv3ywSwiQmAEMiDS1vlFNkaJ7NRcsWPkihk7cT6VDcgQ6pYsVW1AYldzLlDlSXjNE4vbo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR19MB0027
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-10_07:2020-11-10,2020-11-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 spamscore=0 impostorscore=0 mlxscore=0 bulkscore=0
 clxscore=1015 malwarescore=0 suspectscore=0 phishscore=0 mlxlogscore=759
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011100124
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 spamscore=0 mlxscore=0 suspectscore=0 mlxlogscore=871 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011100124
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

> > I guess what Bastien is getting at is for newer devices supported by cl=
ass
> > drivers rather than having to store an allowlist in udev rules, can we =
set
> > the allowlist in the kernel instead.  Then distributions that either do=
n't
> > use systemd or don't regularly update udev rules from systemd can take
> > advantage of better defaults on modern hardware.
>=20
> That's what the "hardware ids" database is supposed to be handling.
> It's easier to manage this in userspace than in the kernel.
>=20
> I just love systems where people feel it is safer to update the kernel
> than it is to update a hardware database file :)
>=20
> > The one item that stood out to me in that rules file was 8086:a0ed.
> > It's listed as "Volteer XHCI", but that same device ID is actually pres=
ent
> > in an XPS 9310 in front of me as well and used by the xhci-pci kernel
> module.
>=20
> That's an Intel PCI device id.  If someone else is abusing that number,
> I'm sure Intel would want to know about it and would be glad to go after
> them.

Sorry I wasn't intending to insinuate an abuse of the number, but rather th=
at
the PCI device in the "Volteer" product and that in XPS 9310 appear are the
same so they are possibly using the same hardware for this device.

>=20
> But note, PCI devices can be behind lots of different types of busses,
> so maybe the "can this device autosuspend" differs for them because of
> different implementations of where the device is, right?
>=20

Well the reason that I raise it is that without that device auto-suspended =
the
SOC on the XPS 9310 consumes too much power.

> > Given we're effectively ending up with the combination of runtime PM tu=
rned
> > on by udev rules, do we need something like this for that ID:
> >
> >
> https://github.com/torvalds/linux/commit/6a7c533d4a1854f54901a065d8c672e8=
90400
> d8a
> >
> > @Mika Westerberg should 8086:a0ed be quirked like the TCSS xHCI too?
>=20
> Submit a patch!
>=20
> thanks,
>=20
> greg k-h

If that's the appropriate conclusion, will do.

