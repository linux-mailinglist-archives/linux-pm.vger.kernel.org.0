Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F388B3FDD74
	for <lists+linux-pm@lfdr.de>; Wed,  1 Sep 2021 15:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbhIANvY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Sep 2021 09:51:24 -0400
Received: from mga07.intel.com ([134.134.136.100]:41771 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242535AbhIANvY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 1 Sep 2021 09:51:24 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10093"; a="282469127"
X-IronPort-AV: E=Sophos;i="5.84,369,1620716400"; 
   d="scan'208";a="282469127"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2021 06:50:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,369,1620716400"; 
   d="scan'208";a="532186963"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by FMSMGA003.fm.intel.com with ESMTP; 01 Sep 2021 06:50:26 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Wed, 1 Sep 2021 06:50:26 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Wed, 1 Sep 2021 06:50:26 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Wed, 1 Sep 2021 06:50:26 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.43) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Wed, 1 Sep 2021 06:50:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d/MbbzRWt0VaqRTBA+4WNUrYJ3Mpo+3fdzRnGOssuyvi0yP+jif00TzJ8RS3I/rk6S9aoJVfqIYgwhqF+b6C+6lugbsVyieQ972tVK8ioVU3ieYd4WP6xhBhtV7HIRr6OdPA3QgubWP1YVw9dFI3d4Lkqt5Kvbzoj8e+XD5UAk9jH2IWHOd89FmX4fLyJXpBrj8xQsrwNt7rOCEfxi9xT7JeoWU/QYo4TCwtusXVLteLMWjk0PJ4PgHM1FK9O5Ic8l346jsCsMeIc8VpWDWo+SenOe4Sp2ehtIYGYy8Lu6ZlfJjrgtCk24sLqBGcxUkAWNT8iXGsxKgj0u926WXunA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=d/ipsOEKDyKoY8RaoCaYurtwA45XmriD6OdeAapWLSE=;
 b=JRa+EuiZp7OOTfuoi0RT82p4uWboAbKQeZxiVKaViA0ii9HE6BZtT1DqaHwXzK8Dv6hYZGEorriTBZjN+PZT94mxWQQdwPL+csuzCZ93ab+/C/NVPB5N2hRGWloNy/N6/b7mbnaq3gCBwQ6ooh38TGYuG0Y6rPPezvCAJzO3B2KSvpkXdJEL/ocyD7U/uULFps3mOV1lKA0ytVn9gklK7WpE14SxXPuOVTWYbKtIPcJ2TA6a5gNqYwUrJnpTMmHIqWd5sJ8x0kQRPp2YKUIJWTwCh57fR1ekEi7RdagkDV+27EPZ86VXd2J5XkY9bpyn3/inU/OxQwCZaRQwBj/7UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d/ipsOEKDyKoY8RaoCaYurtwA45XmriD6OdeAapWLSE=;
 b=K2ThrTmKXi4KaPM+waqVgVI5huIq8XhRkMH7Z0izH7/SoUgw7droERHIHQkzdHng5ZubfrE3HbNe4D5++LAs9W5yydkr3AD2WFU8a62IR+/xH+2ppN4ACeHZM7y6TZhlA60Bo6+TxR3DJ185h6JG7qg+RIXJ2ug/RS0Kcu5lRLo=
Received: from BYAPR11MB3528.namprd11.prod.outlook.com (2603:10b6:a03:87::26)
 by BY5PR11MB4419.namprd11.prod.outlook.com (2603:10b6:a03:1c8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.17; Wed, 1 Sep
 2021 13:50:17 +0000
Received: from BYAPR11MB3528.namprd11.prod.outlook.com
 ([fe80::7426:7b96:b9b9:6882]) by BYAPR11MB3528.namprd11.prod.outlook.com
 ([fe80::7426:7b96:b9b9:6882%7]) with mapi id 15.20.4457.024; Wed, 1 Sep 2021
 13:50:15 +0000
From:   "N, Pandith" <pandith.n@intel.com>
To:     Joe Perches <joe@perches.com>,
        "georgi.djakov@linaro.org" <georgi.djakov@linaro.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "Zhou, Furong" <furong.zhou@intel.com>,
        "Sangannavar, Mallikarjunappa" 
        <mallikarjunappa.sangannavar@intel.com>,
        "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>
Subject: RE: [PATCH V6 1/1] interconnect: intel: Add Keem Bay noc driver
Thread-Topic: [PATCH V6 1/1] interconnect: intel: Add Keem Bay noc driver
Thread-Index: AQHXnjKFvPGsOLQFu0yhd4mKaNMQ96uNvIQAgAFzPgA=
Date:   Wed, 1 Sep 2021 13:50:15 +0000
Message-ID: <BYAPR11MB35281058ADB062E796338B7FE1CD9@BYAPR11MB3528.namprd11.prod.outlook.com>
References: <20210831063615.1021-1-pandith.n@intel.com>
 <1c5b485cc9b8836b09f99278233d9dc0ae991da7.camel@perches.com>
In-Reply-To: <1c5b485cc9b8836b09f99278233d9dc0ae991da7.camel@perches.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: perches.com; dkim=none (message not signed)
 header.d=none;perches.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 767bc19e-420b-4eca-629f-08d96d4f6da0
x-ms-traffictypediagnostic: BY5PR11MB4419:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR11MB441984DEA16C65695EDCC066E1CD9@BY5PR11MB4419.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XvmzlC3WIapcSdnpEOrnayDK+gPGLmXoJ3X3GH9oPczt8OipXU5v4rj8gi5GwFgZucCx9enS3J/ReudfSDLhdXgQmgk6v3qVLlNSahK/8ZN9NH9oWfE2aslLM/ZzYWOHDH8A4nesd6Qo2af+0Cax5pHuamjWJ0ydTI0fORMz/SWNdJffrdYmHUquXgm8QTjXE9sS954ekh0fJKyZxab9m/qrdjMLIBC9czVDFktz87HmeNgttMw6eLL3iTJKvvRQ13Gmzsw51EjLPPCPTl/jLwCnuoIJ2knwzEIXHl21LcZZZ1sQqEtBe2lCMBzoath9Vw+Zm2OME3WfLWc8lDatEjw0Y1cyyUbLs9UAPft76FD3bGopAXeyMZTnk89JmJZPrQQZHiXjEqDVumorAto3rETf7rXRdOh1yt0bgrWEGeOhgF1ZPQtM+eiF3wxt9yRBjOPfHetQ7bgUzBD+S9ZrZeh8Rkt9zwWCo+0HNw8awYR4i+2EGhLDrbTu987tYCqgg6n2MA1P3cHg+WpKhn6j7updfwTagkF0YNy7D8dv2Ht9t7KPL7j6vXCFP9VwWDx3mbZGu0kmulLT/pyQGWpjdwvEUfojoD0Ur4jHdzc6tXGBK88nnvn7BnwHubreD6JMxBfvxNObJ3d6VW00i2SSD545lFvieEJf2/2tZ3IDTBeHY2OsP3Rb1Wu3gIumBZgLPxQAR5eI1nJZabNDhqKxRw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3528.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(136003)(366004)(346002)(376002)(5660300002)(9686003)(6506007)(53546011)(4326008)(122000001)(71200400001)(33656002)(38100700002)(55016002)(38070700005)(478600001)(66946007)(66556008)(316002)(66476007)(55236004)(76116006)(110136005)(54906003)(7696005)(8676002)(83380400001)(8936002)(2906002)(52536014)(86362001)(186003)(26005)(66446008)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YcYmXBcP4F40QVDhwtIxHVIjD9k1ruH25eLj3EvwgcL37c6aopoubdomrvn8?=
 =?us-ascii?Q?DvrBlWiLaK9zUDCbfXjo/CSgwBZ52B3et+PUa1aoRXtdQRIFnznGujZQK3zr?=
 =?us-ascii?Q?4O92RgO5GmE+sxM4tsmAlAh8BHLjHc4YYjdORZV95CdfJIUa+xVmtYbIUkx7?=
 =?us-ascii?Q?E2aMY4UJP7J+VbL62l/vXxpsxQgbEvPvmsa8ULd3n6RnUnugmnB2nE/2Dm3g?=
 =?us-ascii?Q?Twl/qd8OHtHowspxFBpWNsQ+L6CBQP0IzADBDjiSrVtoJQSoopbByeiAyQ6d?=
 =?us-ascii?Q?ZJn37mNiHRiGFU2BB0LhRMlIInYkQ94fobcu0IyTdRhgfLkl7JDRErreVgIS?=
 =?us-ascii?Q?t1RmEzc6b3lF+0pUbPXsY367ZzuYyt7/sSja1l3m3b8Ske3+9/h5EzBNK9pb?=
 =?us-ascii?Q?wVJ3wbEy1prSf6db00OF8cRvre9Y4/v6NSI6dp3Kv3bpLcrxgoTfEHs9F22N?=
 =?us-ascii?Q?Wirnae935XF6U9AS7KMCDba4q15uolbGcEjn0riNM/ndlSkmfodSSswSL89M?=
 =?us-ascii?Q?eKCSpaB3KANLN8Bl35YIaQsCz3M7JozvScJGDmb4SCWUDKmNmEaFTXACEPOO?=
 =?us-ascii?Q?IVxME4E2QXlhKMbZSGcXxg2Rmetl6aObXUWvjHR7MF5Fb6lkJjDDT4jNrizm?=
 =?us-ascii?Q?NoIaSFCU59I77N/7QPQqm6DhrxgVqeueh1qcE13CRCD58DZNEtIKUIbbTAFe?=
 =?us-ascii?Q?jicy7zAFBTd2FM8BUZ8S1rYGvKdGuxZnyVV4hs0h1QU6IYg9BbtNnPPM22k6?=
 =?us-ascii?Q?TATbUXdtdRvkWADuMDpCsVUvLX7/wRyoyGG2pKtVSQaZ4APHJN4hQ9gWRyhT?=
 =?us-ascii?Q?eZMnaz7PeEWxAwJt0O7o8C2OdiZWpQ6l3WPmGITkQUl/7WFrOp6CfqyjRwrZ?=
 =?us-ascii?Q?rTuk2rgA/KgIjnZfxx1OQlEcSYzD7r8GqCBd853nyUrAF4eKPmKhK7Q/9esz?=
 =?us-ascii?Q?opHoz6LcGitTHQSsWmtrjvCBzEGdwsHIYxvsgqq12MFIPHiy6itH4hM4xbdB?=
 =?us-ascii?Q?lrapvbIbXDB3PW9rD27RmT+6YU2uf/hcPTJK7uSD8hBa2AQS/XwcIsjGoDp4?=
 =?us-ascii?Q?jERp29C8DVCb5Kx2M15rvSAH7k7qaJvTDQzpoD1baAOmEFWun7plPV84mBSG?=
 =?us-ascii?Q?oW783hn/iaa+k8j5BJtBH/a8k/NR+vjZbxI6okMr/R/76ERhV3i5hJP4jP3G?=
 =?us-ascii?Q?S9jNu4cIwULl2XlYUEiyC1isa+E7n9OA3LVcEaQze4Vtg+PXC8369C7ybuzE?=
 =?us-ascii?Q?sbaG+Wr7I5zEEUwzX+4YuG1oJMfsJ1K3ChLlxooQ2oJQynWmdr6EHzITU7AT?=
 =?us-ascii?Q?YvrzpvMq3GNQGiUd4jnkpY4K?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3528.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 767bc19e-420b-4eca-629f-08d96d4f6da0
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2021 13:50:15.7418
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V2vCEts+7UN56VZYm5suYZz6Z11f5JkFZR/W1Q6xNSSLZfnCmClq73qFXiKSGdnpLM8Bwk23psMMuMYc3NT9EA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4419
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

> -----Original Message-----
> From: Joe Perches <joe@perches.com>
> Sent: Tuesday, August 31, 2021 8:56 PM
> To: N, Pandith <pandith.n@intel.com>; georgi.djakov@linaro.org; linux-
> pm@vger.kernel.org; linux-kernel@vger.kernel.org
> Cc: mgross@linux.intel.com; Zhou, Furong <furong.zhou@intel.com>;
> Sangannavar, Mallikarjunappa <mallikarjunappa.sangannavar@intel.com>; Raj=
a
> Subramanian, Lakshmi Bai <lakshmi.bai.raja.subramanian@intel.com>
> Subject: Re: [PATCH V6 1/1] interconnect: intel: Add Keem Bay noc driver
>=20
> On Tue, 2021-08-31 at 12:06 +0530, pandith.n@intel.com wrote:
> > From: Pandith N <pandith.n@intel.com>
> >
> > Add support for Network on Chip(NOC) counters. Enable features to
> > configure and capture NOC probe counters, needed for DDR bandwidth
> > measurement. NOC driver is specific to Intel Keem Bay SOC. NOC
> > hardware counters are used for DDR statistics profiling, it is not rela=
ted to
> timers.
> > Interface details are provided in include/uapi/linux/noc_uapi.h
>=20
> trivial notes:
>=20
> > diff --git a/drivers/interconnect/intel/Kconfig
> > b/drivers/interconnect/intel/Kconfig
> []
> > +config INTERCONNECT_INTEL_KEEMBAY
> > +	tristate "Intel Keem Bay Enable DDR profiling using NOC"
> > +	depends on INTERCONNECT_INTEL || ARCH_KEEMBAY ||
> COMPILE_TEST
> > +	help
> > +	  Enable this option for DDR bandwidth measurements using NOC
> > +
> > +	  Add support for Network-on-chip (NOC) in DDR Subsystem(DSS).
> > +	  DSS NOC has capabilities to enable and get statistics profiling.
> > +	  NOC driver enables features to configure and capture NOC probe
> > +          counters, needed for DSS bandwidth measurement.
>=20
> Inconsistent tab/space indentation on this line
>=20
It will corrected with tab + 2 spaces

> > diff --git a/drivers/interconnect/intel/keembay-bwmon.c
> > b/drivers/interconnect/intel/keembay-bwmon.c
> []
> > +/**
> > + * flex_noc_setup() - Setup two counters for the NOC probe
> > + * @noc: NOC type to setup counters
> > + * @counter: Counter number to set up counter n and n+1
> > + * @trace_port: trace port number to setup counters
> > + *
> > + * This function will setup the counters for the trace port given.
>=20
> This seems to be unnecessary kernel-doc and if it is useful, the return v=
alue isn't
> described.
>=20
Will add description for return value

> > +int flex_noc_setup(enum noc_ss_type noc, enum noc_counter counter,
> > +int trace_port) {
> > +	int offset;
> > +
> > +	if (noc >=3D NOC_TYPE_MAX || counter >=3D NOC_COUNTER_MAX)
> > +		return -EINVAL;
> > +
> > +	offset =3D f_offset[counter / 2];
> > +
> > +	/* Stop ongoing stats */
> > +	noc_writel(MAINCTL, 0);
> > +	noc_writel(CFGCTL, 0);
> > +
> > +	/* Setup trace port and counters port select */
> > +	noc_writel(TRACEPORTSEL, trace_port);
> > +	noc_writel((c_offset[counter] + C_PORTSEL), trace_port);
>=20
> Lots of unnecessary parentheses
>=20
Will change as below :=20
noc_writel(c_offset[counter] + C_PORTSEL, trace_port);

> > +	noc_writel((c_offset[counter + 1] + C_PORTSEL), trace_port);
> > +
> > +	/* Setup counter sources & triggers, Alarm mode - OFF */
> > +	noc_writel((c_offset[counter] + C_SRC), COUNTERS_0_SRC_VAL);
> > +	noc_writel((c_offset[counter] + C_ALARMMODE),
> COUNTERS_ALARMMODE_VAL);
> > +	noc_writel((c_offset[counter + 1] + C_SRC), COUNTERS_1_SRC_VAL);
> > +	noc_writel((c_offset[counter + 1] + C_ALARMMODE),
> > +		   COUNTERS_ALARMMODE_VAL);
>=20
> []
Will correct unnecessary parenthesis in above 4 statements
=20
>=20
> > +enum noc_status flexnoc_counter_capture(enum noc_ss_type noc,
> > +					enum noc_counter counter, u32
> *value) {
> > +	unsigned long j0, j1, delay;
> > +	u32 c0_0, c0_1;
> > +
> > +	if (noc >=3D NOC_TYPE_MAX ||
> > +	    counter >=3D NOC_COUNTER_MAX  ||
> > +	    !value)
> > +		return NOC_PROBE_ERR_INVALID_ARGS;
> > +
> > +	delay =3D msecs_to_jiffies(NOC_CAPTURE_TIMEOUT_MSEC);
> > +	j0 =3D jiffies;
> > +	j1 =3D j0 + delay;
>=20
> j0 and j1 seem unnecessary
>=20
Yes, will change it to single timeout variable.

> 	timeout =3D jiffies + msecs_to_jiffies(NOC_CAPTURE_TIMEOUT_MSEC);
>=20
> > +	do {
> > +		c0_0 =3D noc_readl((c_offset[counter] + C_VAL));
> > +		usleep_range(10000, 11000);
>=20
> Seems a long time.
>=20
Will review if this time can be optimized.

> > +		c0_1 =3D noc_readl((c_offset[counter] + C_VAL));
> > +		/* If mainctrl is zero , return error */
> > +		if (noc_readl(MAINCTL) =3D=3D 0)
> > +			return NOC_PROBE_ERR_IN_PROGRESS;
> > +		/* If counters are zero, keep reading */
> > +		if (0 =3D=3D c0_0 && 0 =3D=3D c0_1) {
> > +			break;
> > +		} else if (c0_0 !=3D c0_1) {
> > +			continue;
> > +		} else {
> > +			/* counters look good break the while */
> > +			break;
> > +		}
> > +	} while (time_before(jiffies, j1));
>=20
> 	} while (time_before(jiffies, timeout);
>
Variable will be renamed as timeout.
=20
> []
>=20
> > +static long noc_ioctl(struct file *file, unsigned int cmd, unsigned
> > +long arg) {
> > +	struct flexnoc_countercapture capture_data;
> > +	void __user *argp =3D (void __user *)arg;
> > +	struct flexnoc_probestart probe_data;
> > +	struct flexnoc_setup setup_data;
> > +	int rc;
> > +
> > +	if (!arg) {
> > +		pr_err("NOC: Null pointer from user\n");
>=20
> Perhaps useful to add #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt near th=
e
> top of the file.
>=20
will add this line to the top of the file
#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt

Regards,
Pandith

