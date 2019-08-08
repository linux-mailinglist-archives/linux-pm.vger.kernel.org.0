Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36DA686490
	for <lists+linux-pm@lfdr.de>; Thu,  8 Aug 2019 16:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732811AbfHHOk0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Aug 2019 10:40:26 -0400
Received: from mail-eopbgr30083.outbound.protection.outlook.com ([40.107.3.83]:45699
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732375AbfHHOk0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 8 Aug 2019 10:40:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DJmIVRXlPuHQWOtSxjzjmw8Zytgw0OVD4iMKZKi1mxLhEqRHbH129BmIAQmvhsJzUR7LIbFCCL6yl7TIVK/rHMDuplAQi0oCvRBBRYpQppppOqXchLe83uHo7btZlVjNERi8Mw+n7mZ0pEgxpU8TOgEvNW8It4RewnBQH5uJpRy+ddLrAhy9ZtuBkyz65vgDtHIcFOumV6plSVs5QyOA/qlIC6aW5S45DK14i6t0ty5SMATzw8pqobbPWWT3SBCiWnyeirehvSO8tHtiSAoOQ+Sek5cw9mSA38wYVh4fsqFKjvWQHPsh1jjtdy44gAFSXRLubblo1xALoBsFYzJIjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pihd/gRFSxCVv7ZE75MqtvfYdRkD0F0ISCeGgX0UBuU=;
 b=Cu2Eixf3fVoEBIRV3VzzkiYZfY+q0U9TdB5ba92ITqtS1fqXA/QYF3BED56Mso+ZjbH6AOj1Nr/U+FgHa6hB4WtS4QR5fBeRKLd9lDzYoGOOU5gGByqqjp3K8WvPAFt+xHzZomNEgIXNCa3iz1+e/+Fd3wH4dH0qObkN8ezsSOf+3+iXFImX2eDxTtiq/ZDhw8Q8tHzQckD7UTdiNgxp3dxe1QPm9iFA+gNxRXJsu44LSoobivaMQJYA/PwAqYBHmiZK+URtRlIiIr5WXJCgFkH2tOQqodbtfvu2zjMRFAzfFt6akz6l1CfWR4Rb4udJ5hOz+kX+uvJj68NQ2Au9Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=nxp.com;dmarc=pass action=none header.from=nxp.com;dkim=pass
 header.d=nxp.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pihd/gRFSxCVv7ZE75MqtvfYdRkD0F0ISCeGgX0UBuU=;
 b=Z5yCsiAtAGPok6x2Yo+yWS717+yZIGWKdKHvpyA0ZZj6v40BGJRmBwvw72E9gNI8rWKyIrJnAlYbzs9bjX8AL4cJxoN1EIDBvIRnFLUIMkTJGmCjQ+Y2VnvOQPHr42fwMuAzm9jc7a7aW2nyhXlmDkyZS2dKyzxEIlxMNmM/mrM=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB3167.eurprd04.prod.outlook.com (10.170.229.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.17; Thu, 8 Aug 2019 14:40:22 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::e53d:e6a9:79bd:f970]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::e53d:e6a9:79bd:f970%2]) with mapi id 15.20.2157.015; Thu, 8 Aug 2019
 14:40:22 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Saravana Kannan <saravanak@google.com>
CC:     Viresh Kumar <viresh.kumar@linaro.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        =?iso-8859-2?Q?Artur_=A6wigo=F1?= <a.swigon@partner.samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        dl-linux-imx <linux-imx@nxp.com>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH] PM / devfreq: Add dev_pm_qos support
Thread-Topic: [PATCH] PM / devfreq: Add dev_pm_qos support
Thread-Index: AQHVTDXXQompASFxY0iEK4ZTlwB6yA==
Date:   Thu, 8 Aug 2019 14:40:22 +0000
Message-ID: <VI1PR04MB7023B254B29A2BA9C9FAD65FEED70@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <bcbab490489ef5143361048db93752741b38e379.1565081126.git.leonard.crestez@nxp.com>
 <CAGETcx9pf543R4j3_YE2TtFMPM8Teh-NNj06ikvo92JuNHDtGg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [212.146.100.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 564ad226-32af-49b0-c8c5-08d71c0e57fc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB3167;
x-ms-traffictypediagnostic: VI1PR04MB3167:
x-microsoft-antispam-prvs: <VI1PR04MB31679EB57BA242E6D228C62DEED70@VI1PR04MB3167.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 012349AD1C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(366004)(396003)(346002)(376002)(136003)(189003)(199004)(76176011)(64756008)(446003)(99286004)(6916009)(486006)(66556008)(2906002)(256004)(74316002)(305945005)(476003)(7736002)(6506007)(26005)(71190400001)(102836004)(316002)(86362001)(186003)(71200400001)(53546011)(54906003)(7696005)(44832011)(33656002)(7416002)(229853002)(25786009)(6116002)(66446008)(52536014)(6246003)(9686003)(8936002)(4326008)(81166006)(55016002)(66476007)(14444005)(6436002)(81156014)(14454004)(3846002)(66946007)(5660300002)(478600001)(66066001)(8676002)(53936002)(91956017)(76116006);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3167;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: YqVaFhtmx1q4QiLGZhSuQHBmSI3ba6PMX05TnXvLrRBN5EDuO8m8ZYitvgWhxPDN545oT2OrwWotJ+J8E9H2+exG/WdSfYupgi+4CJJ5aDKS6CWuwxdYr72ZHq9lZC9TUxghXMKkCesfs+74mg6reldAt+gprqSPRAgxHrUJ6vOS6rC0Yps9nbG8teJcQLh3mGAfMXOOVjxAFJ0fiI5gOJHhv3Jt6rz/yWrtWC3+VSigyRXs/WhRR5443qSM14nK3GufhXD3tfTfh1Mobl6F5RX9rVyXJ/l3nzvg6PpVsHdx1a8JfhdI51REMeSpEbrEGWDbvqHqcz0UqudLHzrexig8UNHEV963cmqJEupdxrZbislc8t8+BaqEs6SjTq8l/z9uR1Gec6dqhQbCzphOGcQ0HiTnHj9A0aIFVqU/Ek8=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 564ad226-32af-49b0-c8c5-08d71c0e57fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2019 14:40:22.7218
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3JViiQ0AokWOQjKXeV3UgdP7LL/ptCDF2hUqL3WKJUAU0edmG0zezhaSj1RcOTOU2MfDgqWcf+pz4V9+g1Qo/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3167
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 8/8/2019 12:48 AM, Saravana Kannan wrote:=0A=
> On Tue, Aug 6, 2019 at 2:03 AM Leonard Crestez <leonard.crestez@nxp.com> =
wrote:=0A=
>>=0A=
>> Add dev_pm_qos notifies to devfreq core in order to support frequency=0A=
>> limits via dev_pm_qos_add_request and related APIs=0A=
>>=0A=
>> Unlike the rest of devfreq the dev_pm_qos frequency is measured kHz:=0A=
>> this is consistent with current dev_pm_qos usage for cpufreq and allows=
=0A=
>> frequencies above 2Ghz.=0A=
=0A=
> Where's the devfreq_remove_device() clean up of this?=0A=
=0A=
Oops, see v2=0A=
>>   static ssize_t min_freq_show(struct device *dev, struct device_attribu=
te *attr,=0A=
>>                               char *buf)=0A=
>>   {=0A=
>> -       struct devfreq *df =3D to_devfreq(dev);=0A=
>> -=0A=
>> -       return sprintf(buf, "%lu\n", max(df->scaling_min_freq, df->min_f=
req));=0A=
>> +       return sprintf(buf, "%lu\n", get_effective_min_freq(to_devfreq(d=
ev)));=0A=
> =0A=
> Not directly related to your patch but I wish I had caught this=0A=
> behavior of min_freq_show earlier and nacked it. The "show the=0A=
> aggregated instantaneous min freq" file should have been separate from=0A=
> the user space min freq file. So if init scripts set some minfreq and=0A=
> some other userspace daemon wants to take control of the min_freq=0A=
> userspace vote, there's no way for it to query the current userspace=0A=
> vote because the PMQoS or OPP based minfreq limits might have caused=0A=
> the instantaneous min freq value to have changed. We have this same=0A=
> mess with cpufreq too. We really need to fix this and split userspace=0A=
> min/max freq votes file from current min/max freq.=0A=
=0A=
This seems solvable by adding extra files to sysfs.=0A=
=0A=
--=0A=
Regards,=0A=
Leonard=0A=
