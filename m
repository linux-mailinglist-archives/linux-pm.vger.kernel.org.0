Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE12B455EA9
	for <lists+linux-pm@lfdr.de>; Thu, 18 Nov 2021 15:52:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbhKROzd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Nov 2021 09:55:33 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:34598 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229631AbhKROzc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Nov 2021 09:55:32 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AIElbHn020985;
        Thu, 18 Nov 2021 14:52:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=1cS92+FaAo8G7u/3RlnmSuEaLg13tVogPdlOiZg/cPw=;
 b=tWwIypGwlBTq/nJIDfuxFqraCl7uZWvOjxfePkSFpEGMeZT3+F33fA2u6gfH/6wjjtA5
 r/NiFu40OSJ4JRgR+7OULpJTkrKeHlRRYxm+RgHN87IUUyNqnFauPkSpbcVfl8tUub5+
 rn7gzQacAJUK++4xHkqfrpJQMjkMKo9fIo6h/nGDwbQ3tcim9JkUSCm8uOxV2L45xxie
 b9ohUabbPoRj42vey+Pp4BQdOIUXDn2zBXiwo3iR+Lxs7HhFk97JQWX7ce1UytuWLSOz
 ngPugAVVup/26jW0XP8rGXE8BjtDqo6hnFHQubuXaQvpYeEZD6yZ+cy1D/cG1ZYUZNgK aQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cd4qyptqn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Nov 2021 14:52:10 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AIEoYCt098083;
        Thu, 18 Nov 2021 14:52:09 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
        by aserp3030.oracle.com with ESMTP id 3ccccrunfj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Nov 2021 14:52:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FGuRiiRt9l4AJ13Eq7tY6O35ECrUQYFQTfiyeNPImf6aV18x6bmGXknRinhPQ/Q4qwmreSOSaJqlf0hvZC457Vavd1pjbzco7IbLtm7dXzdE9Pl4JDtMca8yqBrXqIW5OJoIPcdc+J2OQVHHTS7rkjR1bcQOAcJpUjEny25vBbzeFhWqsXcMloiZfKHlRIhLr9t5fA+UqDegKM6J9dV4LjsjZgGhPprB2eiannc4S6LPmpNJytJubN4Pqp2nVeIfMnumZ0DuA59RoDNVjUNk32wi/Hb7KxLqi8rcKI7Zsmb/ZD+2/RCW3kQpkLO8IqNN+T4eBclsaTFrknj90Q6eGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1cS92+FaAo8G7u/3RlnmSuEaLg13tVogPdlOiZg/cPw=;
 b=ApAhZvEe0yfMrDiZGt2wb6HbH/g2+0YhuvxCuqRCNO7rvw95cT5MeQXv2lgAuLNeoa3Ucm0GHkMJ75e9ILXoly8O2DSQGtYsSf8S2TiIouzBdkF9fiGcvXPIlxP7/epx1lUk1KzI+eEbg9g229ITXyi8LuwqiX5ZZyrfkioh9P+m/UuQB3QzbbiFkWHuWdJwn2nM3mi60dPZUYNEeBhxVj8Y/0d7zwuYZdpAfzDEEMtk2pWpNNYH2/3nG+QzmUyyAlY2Nq446aAoPyH/J6ei7mQI4FKWgYcVf0lBeEBPhSGZdXqZMZi0b4Xkeqq9CgLTl1Z0nVj7FafTM8mhfGzTJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1cS92+FaAo8G7u/3RlnmSuEaLg13tVogPdlOiZg/cPw=;
 b=K7iQ13NX2+3tE2el2q8azWst1CfKxoCHIutF/5h5+U7+BzA7mrlNQ+BapfpvDp+15opZHV91EKcQTpIyNvNP5m6JETQPOQfx3nErBEYyyEZNFOq7J83yiN+Dl+qM76UrzTERAjhrLS0jFXwxpk/j+eU2TAdLPwe+MSAviu8feeg=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR1001MB2398.namprd10.prod.outlook.com
 (2603:10b6:301:2f::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.27; Thu, 18 Nov
 2021 14:52:07 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4690.016; Thu, 18 Nov 2021
 14:52:07 +0000
Date:   Thu, 18 Nov 2021 17:51:35 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Sebastian Reichel <sre@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-omap@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] extcon: fix extcon_get_extcon_dev() error handling
Message-ID: <20211118145135.GO27562@kadam>
References: <20211118113026.GG1147@kili>
 <a33fc3d7-a389-a805-0ef9-4b90de1d3d89@roeck-us.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a33fc3d7-a389-a805-0ef9-4b90de1d3d89@roeck-us.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0009.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::21)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (102.222.70.114) by JN2P275CA0009.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.20 via Frontend Transport; Thu, 18 Nov 2021 14:51:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d8355295-eb6c-4a10-a2a6-08d9aaa2fdc7
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2398:
X-Microsoft-Antispam-PRVS: <MWHPR1001MB2398B94EC7A663F079B1C2928E9B9@MWHPR1001MB2398.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9lfL3i2Emz9GamBmj3bV0O46KZL8PLfuh6zFYtqXM1LlOk/3tpyDQnKC7qTHnM4H/Y+n68a7CrtVD0A7OXt4D5w6gL+kkHMmRnjvvu8NnLhUab/CeMGHQaZhPyHSMKKWPHsTW6uJY3shmgb73AqZpnrz56v8zuU2oHXfxREjx9nDo7jYKWX15j6vyZp6XDCO7ZtnemsDxkpxfN772ve0gwQVyh28UEwOHz8srdKXkxM8grWBgcC0VorloTRdd8ad+FMa8vUuY0FuHzwN9olIRBeEIuvIgXj2CopBdxY2Z+i3mdI0eVp3D0hvp52jCTHuSLwJfQUixm4gkPRw0eSNAdITcw/DsnStCw2HG3zTWQN9mpj+Lt7ws1iEKIilUc3X1/9a1IQFBsATFlEXJviEqqSKk1nZMA2jFxssxHwLsv2O5Kn8HVBKMSbE3cSte5eJrZW7hNqR2p6kawhlCvllgYC1yscxFLE7Pf4CoSisDlVdV8KR3+nhQjgKQeIKFhE6viZGcm7C0jFwxctrnrik/BDnEFUpC3EMRfZL0kvsA1JaLrdtZNMVFXqAy6vpMM57uHP5fMtaaHB/bb4Uo74/nanVCC1xrCVWoF94rQY2M2w/doQcssQiUa5QG5Na99tC7C5lCrOhYdWSt+07/g66D+GjoNEsqi2F3mqIBOauGbxJcLTMAGBkJKmtfVoKHI3Eis7nNgbfSZXzPhdOmrXoDw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(4326008)(316002)(6496006)(6916009)(7416002)(33716001)(54906003)(83380400001)(9576002)(1076003)(52116002)(8936002)(5660300002)(44832011)(9686003)(26005)(86362001)(66556008)(66946007)(38350700002)(33656002)(508600001)(6666004)(38100700002)(66476007)(2906002)(8676002)(55016002)(53546011)(186003)(956004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lklTF8cO+GRi0OAxBsFM7EaToN4XO3bQ7IchOL/c4xKsOdxv9x0AvGDtNeV8?=
 =?us-ascii?Q?dvbDAXTmfZCOAQLQiC+vAwDeik4q0bMXOJ2NwILcdt/w4UBG/6dRIfd/yV8b?=
 =?us-ascii?Q?mAlt518xvY8H/FUKAe0nhTQmVe27PMoPq3W0q98imOEeIVo/cUasNQXSYJQE?=
 =?us-ascii?Q?kI9+YPULYGLR9UgiIxsj1qhxmA5YREIw1SYFrYKx15PU4dAapjpA7eGKHrcG?=
 =?us-ascii?Q?++Bz5YZRDZpm3qi6WN8Uo9nbPivDQfL/cfnjQO10rdGTluU6Cq0ElgVcHTwn?=
 =?us-ascii?Q?zKYrglPKUUiCivSkGNhEuItmOPEFLq+3ORnKKFyVMBnatJnuCyHciWA3AuTM?=
 =?us-ascii?Q?Q5vosnCseanhaji3L5/l9Vh/kCjdaGeijrbcImUQBhB9XmqGhfT1/0sRtclH?=
 =?us-ascii?Q?n9Unym1v6CeuaDZfukmtH+GzoBq++lyorqE87dCv8TzbJ9xxj62nures58a9?=
 =?us-ascii?Q?5+rOXpu75Fpgrh2s4EPYi8GAIdU/5N5GflTCyXYwXS5p5kbWPREMhBfGwo08?=
 =?us-ascii?Q?Zv8bkg7urk84A1pfY/zPxGmu9xNN9HtqduAheA6LWasbt4nLvFHzAXVR2ghB?=
 =?us-ascii?Q?TBwLj4Ad6k+DompJq3pkkWStzkQks9hP/c07TYUVKcFpPKdimakdZf6n6H9Y?=
 =?us-ascii?Q?MeyB9AD3Gqa/mjYsvgkTbquucGmAAAnA8CMqlBidQxKF/dhHvVqpoZxZK7Gh?=
 =?us-ascii?Q?PrJNoHgCeeUQYYZ5GqFtLFHE1ueDO1IXuTewWFKniGkcFvGcJrhDZ/7yVoKr?=
 =?us-ascii?Q?1jIwT+YMXMUD+RFYraWDZ/U3yEyDfUnWmcJVkMScRoyFpcrHNd6rnpwMRiVM?=
 =?us-ascii?Q?GZb/qbd7EDqkmK5EY9uDRbyjwPwyWZl2Q/a5YexpbwFi3/bLZ5HBGitJQVMQ?=
 =?us-ascii?Q?CedD7byWHLhUcZ2ts2lVGlOs2twUYbxEfS1HGIdaJfwDwoEJzrWJgftveoYf?=
 =?us-ascii?Q?LhOLLoqXN023a5vXSlQfTg5Ddp117eEtAyMdwCfrHIH2HTEPF3JgCkoZBu36?=
 =?us-ascii?Q?WqXE2lhjZw8REYqtob3mWipjyMKfyt8n6qhaoKSQhwf05wc21apkLr2SXtYg?=
 =?us-ascii?Q?7pLF2U3cf0+frxXmmfA9KxGbHMmVOeMxtPRsOkfvSqLIjIr3WTa2ndCACjyW?=
 =?us-ascii?Q?G5hXi0+DF3jtnCCm17zjOTuF3Akoo1nVnuQ7Buj+oHBKBF1JfIt8DFX0j0zL?=
 =?us-ascii?Q?jmUgt8ncgEsjKsFW7sPRQ5dxpeog1g7r2/dC+upXtHvrIC7pjqTm1hhyatO0?=
 =?us-ascii?Q?dFlIjZUXziwA47qKUKGjrj9DiBbPsoWiPuOy1v9PXtqXoTlL0wzfCGVFYaxW?=
 =?us-ascii?Q?x/zDJ25SUVOfgTfW97qK/AC115zdSrfgCVCzc8YZbzHfxN/Gu1X6XaNDRp1B?=
 =?us-ascii?Q?OqGlgFmu3ogvWn0RHpNxVm1lBS+gvzanZ8tzrn1N8nz+fC7yn1R9gIFGXk9T?=
 =?us-ascii?Q?VFiG8u3E3wR5nuxhhum077+zkAbIbZaxmymh4aQ1SNXxVXeF2tYrPCMDi6Gq?=
 =?us-ascii?Q?j757lsBlYoqmYdINXYVUX/zJ8Ls5kk4W0dULrwbX9grojRDpJxJBDbbp5tSf?=
 =?us-ascii?Q?cXM8Cb/kim3bCpPhi6fhZgBjOYTwChFvm82VFHoazzhLahZ24yArUUdz3HKJ?=
 =?us-ascii?Q?Qzx/elKNUt7YIxM8JDMqPa6Fuw5/vX14d5bgf/aiAi4DZmF3UtlYM4m/+1aO?=
 =?us-ascii?Q?MI21y6U6GLGjGiciAQy0QN0HprY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8355295-eb6c-4a10-a2a6-08d9aaa2fdc7
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2021 14:52:07.5714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WL+wJTy73q0VVZmJ2zSp8Us2PIf62R3xbRvoXf/GsKXVMl4hrStJKU4asSZEpU0MsKu4A+LsQa/RWnzHAVsZ6+qUsnNBeVYi58FzeSfr7mI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2398
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10171 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 adultscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111180083
X-Proofpoint-ORIG-GUID: rJV_5CRcf4J6A7esdN5Da8iglD-idjDT
X-Proofpoint-GUID: rJV_5CRcf4J6A7esdN5Da8iglD-idjDT
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Nov 18, 2021 at 06:22:58AM -0800, Guenter Roeck wrote:
> On 11/18/21 3:32 AM, Dan Carpenter wrote:
> > The extcon_get_extcon_dev() function returns error pointers on error
> > and NULL when it's a -EPROBE_DEFER defer situation.  There are eight
> > callers and only two of them handled this correctly.  In the other
> > callers an error pointer return would lead to a crash.
> > 
> > What prevents crashes is that errors can only happen in the case of
> > a bug in the caller or if CONFIG_EXTCON is disabled.  Six out of
> > eight callers use the Kconfig to either depend on or select
> > CONFIG_EXTCON.  Thus the real life impact of these bugs is tiny.
> > 
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > ---
> > The two callers where the drivers can be built without CONFIG_EXTCON
> > are TYPEC_FUSB302 and CHARGER_MAX8997.
> > 
> [ ... ]
> > diff --git a/drivers/usb/typec/tcpm/fusb302.c b/drivers/usb/typec/tcpm/fusb302.c
> > index 7a2a17866a82..8594b59bd527 100644
> > --- a/drivers/usb/typec/tcpm/fusb302.c
> > +++ b/drivers/usb/typec/tcpm/fusb302.c
> > @@ -1706,8 +1706,8 @@ static int fusb302_probe(struct i2c_client *client,
> >   	 */
> >   	if (device_property_read_string(dev, "linux,extcon-name", &name) == 0) {
> >   		chip->extcon = extcon_get_extcon_dev(name);
> > -		if (!chip->extcon)
> > -			return -EPROBE_DEFER;
> > +		if (IS_ERR(chip->extcon))
> > +			return PTR_ERR(chip->extcon);
> 
> Why does the code not need to return -EPROBE_DEFER ? The description states
> that NULL is returned in that situation. Doesn't that mean that defer situations
> are no longer handled with this patch in place ?

I'm not sure I understand what you are saying here.  In the original
code, extcon_get_extcon_dev() would return NULL and relied on the
callers to change NULL into a -EPROBE_DEFER.  If extcon_get_extcon_dev()
returned ERR_PTR(-EINVAL) (which is impossible as mentioned) the it
would lead to a crash.

In the new code, the extcon_get_extcon_dev() function returns
-EPROBE_DEFER directly so the caller code is much simpler.

> 
> Also, with this patch in place, the code will no longer work if extcon is disabled,
> because extcon_get_extcon_dev() will return -ENODEV and the above code will bail out.
> The behavior of the code wasn't optimal in that case (it would wait until timeout
> in tcpm_get_current_limit() before returning), but at least it didn't fail.

Huh.  You are right.  Initialy I thought that tcpm_get_current_limit()
would crash.  This is one of the two drivers which I mentioned that can
be built without CONFIG_EXTCON.

I will modify the version of extcon_get_extcon_dev() where CONFIG_EXTCON
is disabled to return NULL.  That is the standard/correct way to write
these.  That will turn tcpm_get_current_limit() into a no-op.

A belt and suspenders approach might be to modify the Kconfig so this
driver selects CONFIG_EXTCON.

regards,
dan carpenter

