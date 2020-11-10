Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 454172ADDD6
	for <lists+linux-pm@lfdr.de>; Tue, 10 Nov 2020 19:09:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730669AbgKJSIw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Nov 2020 13:08:52 -0500
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:9976 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726984AbgKJSIw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Nov 2020 13:08:52 -0500
Received: from pps.filterd (m0170398.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AAI4Hk3021630;
        Tue, 10 Nov 2020 13:08:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=ndQ79lKQ625y68Gi0TjzooTBBDYC6H7qcjtl188Rivg=;
 b=FDFRvoByeHLesr0WKS5DZYwWmg/8nsK7cf+TC4J9MqcAFwiuAGhtoP7REFbn8xoOdUA1
 tmQhxOrkpoZMsxplZjD0TpUtmFx6QA162oeUpkwAeuIXKQXXZxO/MuDCImlDSW5kZFC7
 EdoNA1DFctk5Bfttfj53ETh4BB547Uxn9nlefp6UX0C4zBnI+nBUovCfLvLF+9dgre8o
 JTa5TipC8atvT5uHRfMBjIQyiCshBDlO1G7dd0HToA1h87Wwol0DJoyuFn0O+r6meqtq
 X4dVWEhYldNjuu4k77dCTk8W1/rcRGpop634VCrz8TQOe9szCOV/7p8wvM+WCxfjqtat wA== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
        by mx0b-00154904.pphosted.com with ESMTP id 34nqpbren6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Nov 2020 13:08:44 -0500
Received: from pps.filterd (m0144103.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AAI605W087739;
        Tue, 10 Nov 2020 13:08:43 -0500
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by mx0b-00154901.pphosted.com with ESMTP id 34qu9y6cu0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Nov 2020 13:08:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D/XAIAJMX8bBmLscqBxE+/GydGH1FGXcy+BbOdM5oBAravITwMHgedBn/YvhJcro04v4hI5OWwFSG90f5GN3zFa2BxRwde6Zgil+EqKYA+SjVggoQ2pPKrSWrN+dYFB1UwYPbN4fkBo9TdNVpRgyhW37v4jwDTHm8uDESs76xo8HafNTctjCXlwfkabQQi2L83vcL0Kdt0gZ6sG0R0xMYmg7KRsTEHRA1GVmGlot7Yje/RsefcMrGCSqvwz8A1ybBLbiBKSZeX0eikilQItlmVUT/c0fVAbiJbys122ilBzoSKSlUPcogZRfI/HJC5xAVAISCQJAfGkScnTc+xo4xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ndQ79lKQ625y68Gi0TjzooTBBDYC6H7qcjtl188Rivg=;
 b=KVBYho5Ku+MGmM7r0iEprT6plKGp8SbCFnJPTJtX4EseEoHaozl7ykuOcVFIZFjAaBCjfqtvO92rhDuRYN1ifj4DmpexIyJ5OBxvjQZYGLOpoPPQ9tRUzvO4761yGOJYKaWOCTh7L0UG0v47tm4WDfIyBtt1S6EjAxf93f2yPjPcTA//N4Km7i9rsQx3OduGd6EV6NI+U/PnJD+Dpd9ULtGeAWtzdDIkc1U8Y+G36Id1RfBYXazajhsO6knjnvUtwRmH370m2ewvrAwjIfnTH+nLYenu02lh32XsEpIOS80sO3n6cSTKGIAoy36BynQ4jNUjouqMP9uKFhCn+qgYDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Dell.onmicrosoft.com;
 s=selector1-Dell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ndQ79lKQ625y68Gi0TjzooTBBDYC6H7qcjtl188Rivg=;
 b=H+KAh3euuUKArcg7em0NDeg4SySsyR5Ficq2PUmfej66TRsCtq2uCYRDUuWALEFaNFQNDeN/0Bm18xT5tdE0w1GNmKnNm50eRu2c57m2A3ClrE58JcjDOOBSNcDEupWfTKbXkdt7My0pG0Hgb8541EEIyp3ZWY3ORR8ng5Cb6bo=
Received: from DM6PR19MB2636.namprd19.prod.outlook.com (2603:10b6:5:15f::15)
 by DS7PR19MB4568.namprd19.prod.outlook.com (2603:10b6:5:2d0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Tue, 10 Nov
 2020 18:08:42 +0000
Received: from DM6PR19MB2636.namprd19.prod.outlook.com
 ([fe80::a8ff:e803:ee80:e59a]) by DM6PR19MB2636.namprd19.prod.outlook.com
 ([fe80::a8ff:e803:ee80:e59a%3]) with mapi id 15.20.3499.032; Tue, 10 Nov 2020
 18:08:42 +0000
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
Thread-Index: AQHWt1BE6l+LjsERUU+/FRV4X0h3ganBPDeAgABA9KCAAB8fAIAABiwwgAAFvoCAAAA7cA==
Date:   Tue, 10 Nov 2020 18:08:42 +0000
Message-ID: <DM6PR19MB263696FE5FA50F344B559488FAE90@DM6PR19MB2636.namprd19.prod.outlook.com>
References: <fe8ab4cab3740afd261fa902f14ecae002a1122d.camel@hadess.net>
 <X6p6ubTOoMPUPPXi@kroah.com>
 <DM6PR19MB2636C94B56D5FBC0BD98A1B0FAE90@DM6PR19MB2636.namprd19.prod.outlook.com>
 <X6rLUDuG0N98jz18@kroah.com>
 <DM6PR19MB2636460E97BD5E47957BB43AFAE90@DM6PR19MB2636.namprd19.prod.outlook.com>
 <X6rVT6IXHYQpqjic@kroah.com>
In-Reply-To: <X6rVT6IXHYQpqjic@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Mario_Limonciello@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2020-11-10T18:08:39.5205292Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=86c7ffc0-47ae-41c6-a8a8-ff6a994609f2;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=Dell.com;
x-originating-ip: [76.251.167.31]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 79d91bbd-d4cb-4f5b-cd40-08d885a3a855
x-ms-traffictypediagnostic: DS7PR19MB4568:
x-microsoft-antispam-prvs: <DS7PR19MB4568AFD59B7534579F831622FAE90@DS7PR19MB4568.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LqT4QT8HjGlKY4FR4+B73Hr2SkYGI+dhc1n48JRjZw/fYhCL/vPZ0JdeZDWpIMHh4o8Uw/6X6MMqgxdi/MqJHFSlXqDXsWTusUOgxO5FF26erb/IFnVluxaSgG3zVa+QAqMx3EtvT05+NH3ZbF/QJawj41s61p0XggD3eBqgvwSmeLN9KAniumhuNW6JLcJ8CV1BSp3KMYbNO2eVNu/qJtNcfCTMUneA7kN+QDbXfBlSjB2rfUZ5/ad2ev1tEYJtSXdx+a+PFf5pqj9tTwbBCWobA5eiQqXrvNpPkP51Cg4EcbtrfRl+tNfyus+bDUWp
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR19MB2636.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(396003)(376002)(366004)(39860400002)(66446008)(33656002)(66476007)(66556008)(64756008)(6916009)(316002)(76116006)(7696005)(86362001)(54906003)(786003)(478600001)(15650500001)(8676002)(5660300002)(8936002)(52536014)(4326008)(26005)(186003)(6506007)(55016002)(9686003)(2906002)(83380400001)(71200400001)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: WC1hB3eW41e5HmBVPZHEhTTMdc0VtmLRNkw73SiVqNMyUwv81Yg53LHzzS5Sggszoal6eOV0vBarvoiMJMBcFSjct/Qs0AC8pz4s41dbh44WKBxefMmFwP/XkTaQ9l/QGOkwoxp7k5cFZvb+fH3XE5gmFPSp84PCMleWnC/bdsFJf3m/gCev4TvhrgNlqOyaX1lV+aB4X+HCF2BYFcYPE+y3N3i62D+rW2yJfk8anWxSIyqvfjdBZNtCcsbDQc3xv1ryMe0SYOHn26Rgbzx8appbObfWSOKoKy2gNlUBaG0aR6XKqvdv+ghS4Dd5DJ0cTS5mm59g+nQFLJQabTBO2wGrBxYK8U6iR4MraGgFqL5zI2/wYPhtoZSrwRHqrFvBZH8fLnJ1gyyWCQkQcFCU9NZDs6roQLKY62bjPoFZDnUOL24FvFnbmcdREMik8hG/hXkV4xmWAQQbLabJyVQ+es9KKSsJi/xUp2h1V+OLhMboTG058Kjk94Qt9fsrRNdvobzQbik0Oy1OsyOgGzw20KWnIrJpbBKJCoOzmcQQw1QgoKXTXzC9ZVAcQ60E6LoIIWoNG4inm8VpXGBJxi+yVsaLRcO6sHMgdMllgHsbvNxFNaXxOR501NQIUObLwt+ENMzhYSI0krY3NfhZ6/v76Q==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR19MB2636.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79d91bbd-d4cb-4f5b-cd40-08d885a3a855
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2020 18:08:42.2364
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cYQ0P8kvx4znLGBRmu1GYOsAQVIN8Dt2uGS4L+Lfwh2wrGOheARlNDxif6bQeeWB+ilUHLn9/h6/qAnbZwxMpAJOjEkbJFSv+5BN71owjEo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR19MB4568
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-10_07:2020-11-10,2020-11-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 mlxlogscore=829 phishscore=0 mlxscore=0 spamscore=0 suspectscore=0
 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2011100127
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=941 phishscore=0
 malwarescore=0 adultscore=0 bulkscore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011100126
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

> On Tue, Nov 10, 2020 at 05:45:43PM +0000, Limonciello, Mario wrote:
> > > > I guess what Bastien is getting at is for newer devices supported b=
y
> class
> > > > drivers rather than having to store an allowlist in udev rules, can=
 we
> set
> > > > the allowlist in the kernel instead.  Then distributions that eithe=
r
> don't
> > > > use systemd or don't regularly update udev rules from systemd can t=
ake
> > > > advantage of better defaults on modern hardware.
> > >
> > > That's what the "hardware ids" database is supposed to be handling.
> > > It's easier to manage this in userspace than in the kernel.
> > >
> > > I just love systems where people feel it is safer to update the kerne=
l
> > > than it is to update a hardware database file :)
> > >
> > > > The one item that stood out to me in that rules file was 8086:a0ed.
> > > > It's listed as "Volteer XHCI", but that same device ID is actually
> present
> > > > in an XPS 9310 in front of me as well and used by the xhci-pci kern=
el
> > > module.
> > >
> > > That's an Intel PCI device id.  If someone else is abusing that numbe=
r,
> > > I'm sure Intel would want to know about it and would be glad to go af=
ter
> > > them.
> >
> > Sorry I wasn't intending to insinuate an abuse of the number, but rathe=
r
> that
> > the PCI device in the "Volteer" product and that in XPS 9310 appear are=
 the
> > same so they are possibly using the same hardware for this device.
>=20
> Ok, but again, given that the device might be on different transports,
> the ability for the device to properly autosuspend might be different,
> right?
>=20

I would think since it's provided by the PCH unlikely to be different trans=
ports.
I'm not sure though, Matthias might need to confirm.

On my side if I don't put that device into autosuspend the power consumptio=
n
goes up.
