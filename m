Return-Path: <linux-pm+bounces-24866-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62B86A7D143
	for <lists+linux-pm@lfdr.de>; Mon,  7 Apr 2025 02:22:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D78DD7A3928
	for <lists+linux-pm@lfdr.de>; Mon,  7 Apr 2025 00:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D74BF1C36;
	Mon,  7 Apr 2025 00:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IV70wqQt"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B322736B;
	Mon,  7 Apr 2025 00:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743985334; cv=fail; b=g+iaf3zbYv5rProiiy5xK1CaU1MBmRXZr4fduDS5VQikAruNF/Z6Y9A/FLnXeRJLBmeI3JLnA7wVUBPGIscov+d/Y3RtL1A5I+yqeL4Ijo3JBXcveRPhnomge3Fn4QhxfPil07CDXUMGl+3ThjCoeR4XGNHCLkY85zcYcUelMdI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743985334; c=relaxed/simple;
	bh=rLUWMEK8hVZmbjZwNYuzNk9vXZ5R6v8dKPvwrRnMj74=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bs/hgaO0xeIrSRBe16zu1QSjIjtQm/GX/b2JA/ywb5h4BsmpcDmTlqFKDAHdWDABEBLRcCJwQ7fxBJreSA59Zgxco9KcnYdlHBFbyDjY6y0yyoiZ2lq2eNDxbAyiCHyjWWg+HHkT2cPTb/SH/o7KpszZLJYZXBL5CBE9tzJ6G/w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IV70wqQt; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743985333; x=1775521333;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rLUWMEK8hVZmbjZwNYuzNk9vXZ5R6v8dKPvwrRnMj74=;
  b=IV70wqQtT+1gaFLDfdmWxilYTg6YgmhHE+APIYfSe2z7LKdAKJhUBS1a
   UadK4B/THmCwTRrcA9AkxYQmyRejLrNcyYGLwquC+Vjs4OzGJqLk5ninX
   tZdWpyRa1SUsJkULertQQ6DUNWvw4uqIBMd6/MRYsARZlxoXFl+Sh5jAq
   h8FX6jEeElwFa2Bo7++SNhUsU0hkPVW5odG0Tj+J/jLCLC1zCvWcM/2ay
   Rkdvv8b27H3imizYXCswCS2GNf0MhuotCjCyaackwLYdfGl+AtJdN+CpP
   vuLDnsT287EYffJuzTeOyZO3IYOSjhbFxGhhuZ+pTacqe3TpkQknkWUcZ
   A==;
X-CSE-ConnectionGUID: UGyqNEkUQeykWuo69t8AyQ==
X-CSE-MsgGUID: 7zN+9ykJSeCPbYsnBsJw4g==
X-IronPort-AV: E=McAfee;i="6700,10204,11396"; a="45069633"
X-IronPort-AV: E=Sophos;i="6.15,193,1739865600"; 
   d="scan'208";a="45069633"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2025 17:22:13 -0700
X-CSE-ConnectionGUID: 4zPr10rNSrC09ApPWKMNTA==
X-CSE-MsgGUID: DyFTibDjQISNdWViofVoUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,193,1739865600"; 
   d="scan'208";a="127672740"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2025 17:22:13 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sun, 6 Apr 2025 17:22:11 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Sun, 6 Apr 2025 17:22:11 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Sun, 6 Apr 2025 17:22:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EzUDGtk3t+5Eftuy0idTJRxo7H0qk6N2ug8RIX3wQg45EGFeYWqaBEE141wfkfXdcCruVdUt5IbbqwIysA4I6TPPnNMh9trnnTtmqp6KzWhOO+ajOIZbY29vEv36q2Sf3qP9iyrXcKmiN2hwDJESZmIsavabjDHv4IvHcaK3LMtum2W28Iuys/05FjTsL1p8NV1i2VkzCqz4qrz+KOO7vvO1YuRWJWQzafa/SD7wk0GAz3c/fqhGjOJk2fSKsCZdAygF+qS9BQbOtJfCYJOIXXIsQ2J3P8EAXaleOtTeg8aJ1H7G6n3GEKE7cvD+H8pwHhr/Z4+EPbtJNxrrqsfKww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rLUWMEK8hVZmbjZwNYuzNk9vXZ5R6v8dKPvwrRnMj74=;
 b=bAelZkunWhGqTQnetIovo9nIDcn91n2XXXfixLgZdIKTjekrEflXFx/YdT3cSJZw4qDhrqodOU9mmejgPIKf362ek4lTA2ofdOcbOZb8liqTb0lp84NF1Px7HOXZAFQC8PS7XN2JhdlpK9bXFXw1eGmi/UE7a837OB4+wIdNdxrUxCMPSzRv0eusx1lI/5yhbTwV0QgCYwb0VnOGJ4NcQXrub3M20jRP0WPUN1epU/zYDY6LljAYTT7FJiUrUK76XRdf2fKh1BJMqC586eZjMXal+b5LUhZdQhkOpdOl8fE5D6WbBXRlpvopx6Mu/GxMdr+VMqRKOsfKm2rnQGS2TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB6010.namprd11.prod.outlook.com (2603:10b6:208:371::11)
 by SJ0PR11MB5166.namprd11.prod.outlook.com (2603:10b6:a03:2d8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Mon, 7 Apr
 2025 00:21:50 +0000
Received: from MN0PR11MB6010.namprd11.prod.outlook.com
 ([fe80::c7:95cd:f2e4:70b2]) by MN0PR11MB6010.namprd11.prod.outlook.com
 ([fe80::c7:95cd:f2e4:70b2%3]) with mapi id 15.20.8606.033; Mon, 7 Apr 2025
 00:21:50 +0000
From: "Brown, Len" <len.brown@intel.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] PM: MAINTAINERS: Drop Len Brown
Thread-Topic: [PATCH] PM: MAINTAINERS: Drop Len Brown
Thread-Index: AQHbk/hD4gwtR2JrGUyNeFmLLwQblbOXey0T
Date: Mon, 7 Apr 2025 00:21:50 +0000
Message-ID: <MN0PR11MB601057883B04FFD1BFC81C4FE0AA2@MN0PR11MB6010.namprd11.prod.outlook.com>
References: <20250313091403.50077-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20250313091403.50077-1-krzysztof.kozlowski@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB6010:EE_|SJ0PR11MB5166:EE_
x-ms-office365-filtering-correlation-id: b54d5bb8-f325-4bb1-4fc6-08dd756a30e3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?yv8Ygx+dom2Vij335OUU3rvRAyJe0ycxdeoT41z93xRg24FV/MYB8ixAzt?=
 =?iso-8859-1?Q?73i/cd64Hi/k0Uih+hg+NizVorOi58N9iXihcIAAk1Z7S7/vxI9CWwSuAM?=
 =?iso-8859-1?Q?q2fYZd4fKMcl/nULDrMwVjE+H1pEgquGFFv8Ay2w2g7K06nuPXWvm4uhMp?=
 =?iso-8859-1?Q?98IQeJ8dDMQrNSoWGqgFRyqqje8uGaxp5YVz1bnWE0ouCj3mujnnMwR973?=
 =?iso-8859-1?Q?ujYZ+638x0hZEQwjMZu7qrmUUuiwvbW8adDTtU0oYJr8iG8Kj4a6iuED9S?=
 =?iso-8859-1?Q?qvzuDygj74F+4xgeO4EQv7Jn9hhsV6uL/RouuX45Q4EkRdEpu4Kqy54Qdk?=
 =?iso-8859-1?Q?DY+G0pIOkuW5dtbp9n3/SuOH08c8iahF0kD6kDzBo7yYftSAatgP6e7MFo?=
 =?iso-8859-1?Q?xEyt3PuZ7mPvp6YPXnSfned3CW/8UDfsf91KrxUhfA5p5achitklzPRFhS?=
 =?iso-8859-1?Q?QwJL4oLn1NhI8OIllZ3JHJ8reAKmZd+AtVlRDch0yYOKYtfVLM+abb8GJM?=
 =?iso-8859-1?Q?+XQdEhIWqeKJQuMtWF6Y8O3dd0Z7UHW2tyya8gokmF3jcCJcfSPzL81pSL?=
 =?iso-8859-1?Q?GWEn/Kggu7LQ5N+mcoLe28TeXl8mHiImRAmpmuH+LdMyzDQ17xdb6vp9eZ?=
 =?iso-8859-1?Q?7amuf6GOwY361yy6OIUhK9pOjka4wwb8HeClDL/OoYcHpHxEVViNxbTQZP?=
 =?iso-8859-1?Q?OPDjGQZKb1+iIB1yat35qLy1T/HXu2zBl+8jg0NK0QWKadDRNBcoUcI4bF?=
 =?iso-8859-1?Q?FiblDUVx8OwSO9fvwPrelDXhhle/eSZ48SGB/Z0vwmzieLXkdPggR9GOQF?=
 =?iso-8859-1?Q?8Cd6exVguGPEv6Ezo5Jz1eAh0FMTbxP0w2KHAwKo9Cy/naxJBQvVXIDr9H?=
 =?iso-8859-1?Q?5c4hbnMDZLnI+3EGF6G/OsG45vu+iDZJ79r3L3oPpZScVmHVNmJRit+XiC?=
 =?iso-8859-1?Q?vKEs87VCc22HsJEsCQTPNLsoaA4o55Guz2Q9BxFVtfC3XDTiFE3dzn7Xkq?=
 =?iso-8859-1?Q?IeyQx2fwu/VhuDfdZz/muUyBY7QPQj5J3VPKhRY0TzSINDN2lW4fnE33mO?=
 =?iso-8859-1?Q?Z+AxEjtiZoL35DxW13dCJyB01C9oGnCpQ4GCyta325Z44BCiCV1J653U96?=
 =?iso-8859-1?Q?pHgOIMPfm5vGwDQVRCEN5EJvCQ9MjA13pCLMZcae7t8DR6Ap3rv9OzR1u2?=
 =?iso-8859-1?Q?YQXgZaZLaFRXrGv7yiV21/zw556kuUPvG0DhECTv8xfTsyXHJ8nYu6VH0N?=
 =?iso-8859-1?Q?vuiu/vikDcpyRgcugBbScV7bqPCR/fQT0XT2bfa6yamDUxfUlbyzLeMeEB?=
 =?iso-8859-1?Q?N1jv9SMY4BkNczesPWWi1+NvRxn3uoen8aIxkfpQL/hq6Rt2NB1vWSkVqk?=
 =?iso-8859-1?Q?RhTtj3WkZhcZXbrxkPg3yTHCaNq9frcU/iEAPrHie+7M7GDtkdlRMx1nuD?=
 =?iso-8859-1?Q?D/ppWAT6lyPB4aZEX7VOfmUHriJK2E7smbOnopO4RKhz2Wm1G+Yd5kdryw?=
 =?iso-8859-1?Q?O5/0kk77RuFNvD8py/KSlb?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6010.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?BkveR020dRts3M7RLX1ti69ceU9xzKGYmp0p4ku1bm/RtreihJVgKyPfdJ?=
 =?iso-8859-1?Q?zlLXMBR0VzTCoGQX2mVyMAEnmYbs+qIk/xnSLICmyxoPtYyHIaSPteYXsv?=
 =?iso-8859-1?Q?yNDGL46iB5kGq3sL66Av0d4y/9MM0E1pfViOz3mtkVEIL55X5pUi8g+Faq?=
 =?iso-8859-1?Q?+WchJXcFGyLbgrpNgKdjIv0cNcDCYxYMHGDNA+Sx2fI8qBLgaHjafjEEQ6?=
 =?iso-8859-1?Q?zLGipJz0lPf0v+6KD8IeXeUHPdG39wNtRXJG3DiZq28Rw+jgRcOisXK4Gp?=
 =?iso-8859-1?Q?o+uiojW4nNEfDbxWjCUGDoe60Vv54/AdEicFOWWYbBAUqkSPypOZGRyFpm?=
 =?iso-8859-1?Q?l/2SPA73qGGQjqbMNF366t1RLX0SQST76sbCDvIusqSXC0f2TzMsb5jKF1?=
 =?iso-8859-1?Q?/uMckfPMVraSkkmioz21cCGQBcoJZkoUA8C7rtO4ICDe70Un9iT2G9i1Em?=
 =?iso-8859-1?Q?RSgbCKbr0hP+KbuC0/9+TnTZpcemgaG/3XzY41KbgfpH0Wcu8edarSxEZk?=
 =?iso-8859-1?Q?BaC9O1k33j4ms8SymPIfwWBzoA1EBEVDI0Pe2/CaJh+HI4s6/KNmq8eJiL?=
 =?iso-8859-1?Q?CvsrL3OoZVQJWD63WwxKz/fdJSSaE/sE6f5leoozxWrX2U9RvtRzmboGMo?=
 =?iso-8859-1?Q?Na//G2q9w0LMSEfDdqIDQ9JK1jlRr/fZMGryoOOqd6uYF31zN6BuX4ufIR?=
 =?iso-8859-1?Q?F+I4YJ9KZiKzbRv3JuJB7Cm6W0Ni35aHIF+kO7vzVsXP1XU/bhwfd7mitP?=
 =?iso-8859-1?Q?Kf50UnK7DCVq72AIL3UJEtBRkLrPAMrpsFzBLXl3scjniBypL6qziMK3I7?=
 =?iso-8859-1?Q?Na0ifDowbIBO3yW8ZRLKwR+/ZKR5Bn/esTFaPkZwW5UNmTZt05OLe2iZdr?=
 =?iso-8859-1?Q?RC78uxqYAz65nmI7kyqtwn0rcAvCBEZ0h/effWq6x8xUKsPqSMTdenO6CU?=
 =?iso-8859-1?Q?+ZPi3bXmcN68+N0n5jg79Pkv9BwwRZ1J49YQXTQdY1oDk+tMhgAaHip+Zf?=
 =?iso-8859-1?Q?PYBaE4psgaf9F0nyP06EpLEEPecN29+cBFH1678nRfiPvf1a4Fy+lMpMbr?=
 =?iso-8859-1?Q?yRBRVbYUbmc1G/+4cpdYbPes0zxn80XMXCMcaGdHdsNQ86pB+CLN6Ul4qj?=
 =?iso-8859-1?Q?7/UumHa+jLx2jt/ehiBScHBLhwk00eCLPTh4jxhv1iIE8n6daM0wtDiadS?=
 =?iso-8859-1?Q?/4DRE9D9tAi2io0lQc7g9ukuPpDHiYALMfrwCxX1ZUKaLQFVOCrHmmQXT6?=
 =?iso-8859-1?Q?x+4DANNaI46N6HjfbJe4y0SkcIPjvQ7CJ+WilM7zptggCMTAjvTioheXeo?=
 =?iso-8859-1?Q?Co+nueJ2/KZEW053PPdYMg7Z2ZuDpLpJYmrLDHSvwUbw5Ychzun4lySmtD?=
 =?iso-8859-1?Q?JVogBV3vl6FSyeOG/sjQ7mGQzPkRlEoxxYL2cyHnK2VBE3ewBzzoHFOy1O?=
 =?iso-8859-1?Q?1ZGoaefeNxANrWQg2yx5CZ0BWKssmvyNX4hqqr0IzTe9hXgovyCM6Kpj3x?=
 =?iso-8859-1?Q?VL1kV2vq6FYyJkV7+w7/HHNvNUDGkZtOR+QqMWOAtFZDpvONn+y9zqiJxn?=
 =?iso-8859-1?Q?CC2iqPv7kQeLaAn909lOgVbNocPjlPZFWYj5S1p3KKxnvhqhhM3OgS5IJW?=
 =?iso-8859-1?Q?Q8GzolbeRFhG5zLcQGuYGrptWykyFi4ZPKafYxTZN+dFl1CTe/uKN7QEUc?=
 =?iso-8859-1?Q?i8xn3Hc3M9Q9NlKncMJlvJFTxpfuXPjiyQyJ5rLq?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6010.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b54d5bb8-f325-4bb1-4fc6-08dd756a30e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2025 00:21:50.3405
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LEdwyUs8MONrX+pVN76LmurJ8aZfEh+ySy8yFeLRys9hzUXTE9TD/ebiIhbaCL/FN0uW+gBDCTdhe/03mUg5Jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5166
X-OriginatorOrg: intel.com

> Emails to Len Brown bounce with:=0A=
=0A=
An auto-responder is different from bouncing.=0A=
=0A=
Back in the day, we were required to list our @intel.com addresses in MAINT=
AINERS to make it clear who pays us.=A0 I'm okay with global replacing lenb=
@kernel.org for len.brown@intel.com, since Rafael and others seem to have s=
urvived doing so.=0A=
=0A=
Thanks, -Len=

